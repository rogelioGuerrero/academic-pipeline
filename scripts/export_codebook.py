"""
export_codebook.py - Genera el libro de codigos del pipeline desde docs/memory.db.

Salida: docs/data/codebook.json

Para cada indicador con datos reporta: codigo de fuente, etiqueta, categoria,
unidad, cobertura por pais, ventana de anios, numero de observaciones y en que
papers se ha usado. La pagina docs/codebook.html cruza esto con
docs/data/catalog.json para mostrar tambien los indicadores declarados que
todavia no tienen datos.

Uso: python scripts/export_codebook.py
"""

import json
import os
import sqlite3
from datetime import datetime, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(ROOT, "docs", "memory.db")
OUT_PATH = os.path.join(ROOT, "docs", "data", "codebook.json")

# Orden editorial de las categorias (el resto se ordena alfabeticamente al final)
CATEGORY_ORDER = [
    "employment", "economy", "education", "technology",
    "demographics", "inequality", "health", "environment",
]


def wb_url(code):
    return f"https://data.worldbank.org/indicator/{code}"


def load_papers_by_indicator(cur):
    """Mapea etiqueta de indicador -> lista de papers que lo usaron.

    papers.indicadores guarda un JSON array de etiquetas (mismo formato que
    knowledge.jsonl), no de codigos: el match es por etiqueta.
    """
    by_label = {}
    rows = cur.execute(
        "SELECT date, filename, topic, indicadores FROM papers ORDER BY date DESC"
    ).fetchall()
    for date, filename, topic, indicadores in rows:
        if not indicadores:
            continue
        try:
            labels = json.loads(indicadores)
        except (ValueError, TypeError):
            continue
        if not isinstance(labels, list):
            continue
        for label in labels:
            by_label.setdefault(label, []).append(
                {"date": date, "file": filename, "topic": topic}
            )
    return by_label


def _loads(value):
    """Decodifica una columna JSON de SQLite; devuelve [] si viene vacia o rota."""
    if not value:
        return []
    try:
        parsed = json.loads(value)
    except (ValueError, TypeError):
        return []
    return parsed if isinstance(parsed, list) else []


def build_codebook(conn):
    cur = conn.cursor()
    papers_by_label = load_papers_by_indicator(cur)

    countries = [
        {"code": code, "name": name}
        for code, name in cur.execute(
            "SELECT DISTINCT country_code, country_name FROM indicator_series ORDER BY country_code"
        ).fetchall()
    ]
    country_codes = [c["code"] for c in countries]

    rows = cur.execute(
        """
        SELECT indicator_code,
               indicator_label,
               category,
               unit,
               COUNT(DISTINCT country_code) AS n_countries,
               COUNT(*)                    AS n_observations,
               MIN(year)                   AS year_from,
               MAX(year)                   AS year_to
        FROM indicator_series
        GROUP BY indicator_code, indicator_label, category, unit
        ORDER BY indicator_label
        """
    ).fetchall()

    indicators = []
    for code, label, category, unit, n_countries, n_obs, year_from, year_to in rows:
        present = [
            cc for (cc,) in cur.execute(
                "SELECT DISTINCT country_code FROM indicator_series WHERE indicator_code = ?",
                (code,),
            ).fetchall()
        ]
        # Años cubiertos por cobertura: alimenta la matriz de cobertura con
        # celda "años cubiertos", no solo presencia/ausencia.
        by_country = dict(cur.execute(
            "SELECT country_code, COUNT(*) FROM indicator_series WHERE indicator_code = ? GROUP BY country_code",
            (code,),
        ).fetchall())
        papers = papers_by_label.get(label, [])
        indicators.append({
            "code": code,
            "label": label,
            "category": category or "sin categoria",
            "unit": unit,
            "source": "World Bank",
            "source_url": wb_url(code),
            "n_countries": n_countries,
            "countries": sorted(present),
            "missing_countries": sorted(set(country_codes) - set(present)),
            "by_country": by_country,
            "year_from": year_from,
            "year_to": year_to,
            "n_observations": n_obs,
            # Celdas esperadas si cada pais cubierto tuviera la ventana completa
            "n_observations_expected": n_countries * (year_to - year_from + 1),
            "papers": papers,
        })

    # Agrupar por categoria respetando el orden editorial
    seen = [i["category"] for i in indicators]
    ordered = [c for c in CATEGORY_ORDER if c in seen]
    ordered += sorted({c for c in seen if c not in CATEGORY_ORDER})
    categories = []
    for name in ordered:
        members = [i for i in indicators if i["category"] == name]
        categories.append({
            "name": name,
            "n_indicators": len(members),
            "n_observations": sum(m["n_observations"] for m in members),
            "indicators": sorted(members, key=lambda i: i["label"]),
        })

    total_series = len({
        (i["code"], cc) for i in indicators for cc in i["countries"]
    })
    n_papers = cur.execute("SELECT COUNT(*) FROM papers").fetchone()[0]

    # Índice de papers: la muestra real (si está persistida) más los
    # indicadores del catálogo que cada uno usó, para acotar la matriz.
    known_labels = {i["label"] for i in indicators}
    paper_index = {}
    for date, filename, topic, sc, si in cur.execute(
        "SELECT date, filename, topic, sample_countries, sample_indicators "
        "FROM papers ORDER BY date DESC, id DESC"
    ):
        paper_index[filename] = {
            "date": date,
            "file": filename,
            "topic": topic,
            "sample_countries": _loads(sc),
            "sample_indicators": _loads(si),
            "indicators": [],
        }

    # Cruce por etiqueta: cubre los papers anteriores a que existiera `sample`.
    for label, entries in papers_by_label.items():
        if label not in known_labels:
            continue
        for entry in entries:
            paper = paper_index.get(entry["file"])
            if paper and label not in paper["indicators"]:
                paper["indicators"].append(label)

    # La muestra persistida manda: agrega los indicadores que declare.
    for paper in paper_index.values():
        for label in paper["sample_indicators"]:
            if label in known_labels and label not in paper["indicators"]:
                paper["indicators"].append(label)

    papers_out = sorted(paper_index.values(), key=lambda p: (p["date"], p["file"]), reverse=True)

    return {
        "generated": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "window": {
            "from": min(i["year_from"] for i in indicators),
            "to": max(i["year_to"] for i in indicators),
        },
        "totals": {
            "indicators_with_data": len(indicators),
            "countries": len(countries),
            "series": total_series,
            "observations": sum(i["n_observations"] for i in indicators),
            "papers": n_papers,
        },
        "countries": countries,
        "papers": papers_out,
        "categories": categories,
    }


def main():
    if not os.path.exists(DB_PATH):
        raise SystemExit(f"No existe {DB_PATH}")
    conn = sqlite3.connect(DB_PATH)
    try:
        codebook = build_codebook(conn)
    finally:
        conn.close()

    os.makedirs(os.path.dirname(OUT_PATH), exist_ok=True)
    with open(OUT_PATH, "w", encoding="utf-8") as fh:
        json.dump(codebook, fh, indent=2, ensure_ascii=False)

    t = codebook["totals"]
    print(
        f"  codebook.json: {t['indicators_with_data']} indicadores con datos, "
        f"{t['series']} series, {t['observations']} observaciones"
    )
    print(f"  -> {OUT_PATH}")


if __name__ == "__main__":
    main()
