"""
memory.py - Memoria Relacional Persistente (SQLite) para AcademicPipeline
Almacena el historial de investigaciones, hipotesis y hallazgos cuantitativos
para que el pipeline (MoA Groq) mantenga contexto acumulativo a costo $0.
"""

import os
import re
import sys
import json
import sqlite3
from typing import List, Dict, Any, Optional

ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(ROOT_DIR, "docs", "memory.db")
KNOWLEDGE_JSONL = os.path.join(ROOT_DIR, "docs", "knowledge.jsonl")
OUTPUT_PAPERS_DIR = os.path.join(ROOT_DIR, "output", "papers")

def get_connection(db_path: str = DB_PATH) -> sqlite3.Connection:
    os.makedirs(os.path.dirname(db_path), exist_ok=True)
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    return conn

def init_db(db_path: str = DB_PATH) -> None:
    """Crea las tablas relacionales e índices si no existen."""
    conn = get_connection(db_path)
    cur = conn.cursor()
    
    cur.execute("""
    CREATE TABLE IF NOT EXISTS papers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        filename TEXT UNIQUE NOT NULL,
        topic TEXT NOT NULL,
        pregunta TEXT,
        hipotesis TEXT,
        indicadores TEXT, -- JSON array
        inspiring_news_title TEXT,
        inspiring_news_url TEXT,
        r_squared REAL,
        correlations_total INTEGER DEFAULT 0,
        correlations_sig INTEGER DEFAULT 0,
        review_verdict TEXT,
        qa_verdict TEXT,
        editorial TEXT,
        sample_countries TEXT, -- JSON array: muestra de paises del estudio
        sample_indicators TEXT, -- JSON array: indicadores del estudio
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)
    
    cur.execute("""
    CREATE TABLE IF NOT EXISTS correlations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        paper_id INTEGER NOT NULL,
        var_x TEXT NOT NULL,
        var_y TEXT NOT NULL,
        r REAL NOT NULL,
        p_value REAL NOT NULL,
        country TEXT,
        FOREIGN KEY (paper_id) REFERENCES papers (id) ON DELETE CASCADE
    );
    """)

    cur.execute("""
    CREATE TABLE IF NOT EXISTS indicator_series (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country_code TEXT NOT NULL,
        country_name TEXT NOT NULL,
        indicator_code TEXT NOT NULL,
        indicator_label TEXT NOT NULL,
        category TEXT,
        unit TEXT,
        year INTEGER NOT NULL,
        value REAL NOT NULL,
        UNIQUE(country_code, indicator_code, year)
    );
    """)

    cur.execute("CREATE INDEX IF NOT EXISTS idx_papers_date ON papers(date);")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_papers_topic ON papers(topic);")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_corr_p_value ON correlations(p_value);")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_corr_vars ON correlations(var_x, var_y);")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_ind_series_query ON indicator_series(indicator_code, country_code);")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_ind_series_label ON indicator_series(indicator_label, country_code);")

    _migrate(cur)
    
    conn.commit()
    conn.close()

# Columnas agregadas despues de la version inicial de `papers`. CREATE TABLE IF
# NOT EXISTS no las agrega a una base ya creada, asi que van por ALTER TABLE.
MIGRATIONS = {
    "papers": {
        "sample_countries": "TEXT",   # JSON array: muestra de paises del estudio
        "sample_indicators": "TEXT",  # JSON array: indicadores del estudio
    },
}


def _migrate(cur: sqlite3.Cursor) -> None:
    """Agrega columnas nuevas a bases ya existentes (idempotente)."""
    for table, columns in MIGRATIONS.items():
        existing = {row[1] for row in cur.execute(f"PRAGMA table_info({table})")}
        if not existing:
            continue
        for name, decl in columns.items():
            if name not in existing:
                cur.execute(f"ALTER TABLE {table} ADD COLUMN {name} {decl}")
                print(f"Migracion: {table}.{name} agregada")


def record_paper(data: Dict[str, Any], db_path: str = DB_PATH) -> int:
    """Inserta o actualiza un paper y sus correlaciones en SQLite."""
    init_db(db_path)
    conn = get_connection(db_path)
    cur = conn.cursor()
    
    filename = data.get("file") or os.path.basename(data.get("link", ""))
    date = data.get("date") or filename[:10]
    topic = data.get("topic") or "Investigación"
    pregunta = data.get("pregunta")
    hipotesis = data.get("hipotesis")
    
    indicadores = data.get("indicadores") or []
    if isinstance(indicadores, list):
        indicadores_json = json.dumps(indicadores, ensure_ascii=False)
    else:
        indicadores_json = str(indicadores)
        
    news = data.get("noticia") or data.get("inspiringNews") or {}
    news_title = news.get("title")
    news_url = news.get("url")
    
    stats = data.get("stats") or data.get("computeResults") or {}
    r_squared = (stats.get("regresion") or stats.get("regression") or {}).get("r_squared")
    corr_total = stats.get("correlaciones") if isinstance(stats.get("correlaciones"), int) else stats.get("correlations", 0)
    sig_list = normalize_correlations(
        stats.get("top_significativas") or stats.get("significantCorrelations") or []
    )
    corr_sig = len(sig_list) if isinstance(sig_list, list) else stats.get("significativas", 0)
    
    review_verdict = data.get("review") or (data.get("reviewDecision") or {}).get("veredicto")
    qa_verdict = data.get("qa") or (data.get("qaDecision") or {}).get("veredicto")
    editorial = data.get("editorial")

    # Muestra del estudio. Viene como `sample` desde output/papers/*.json o como
    # `muestra_paises`/`muestra_indicadores` desde knowledge.jsonl. Se guarda
    # NULL si no viene, para no pisar un valor bueno en una sincronizacion
    # posterior que no la traiga (ver COALESCE en el UPDATE).
    sample = data.get("sample") or {}
    sample_countries = sample.get("countries") or data.get("muestra_paises") or []
    sample_indicators = sample.get("indicators") or data.get("muestra_indicadores") or []
    sample_countries_json = json.dumps(sample_countries, ensure_ascii=False) if sample_countries else None
    sample_indicators_json = json.dumps(sample_indicators, ensure_ascii=False) if sample_indicators else None

    cur.execute("""
    INSERT INTO papers (
        date, filename, topic, pregunta, hipotesis, indicadores,
        inspiring_news_title, inspiring_news_url, r_squared,
        correlations_total, correlations_sig, review_verdict,
        qa_verdict, editorial, sample_countries, sample_indicators
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(filename) DO UPDATE SET
        topic=excluded.topic,
        pregunta=excluded.pregunta,
        hipotesis=excluded.hipotesis,
        indicadores=excluded.indicadores,
        inspiring_news_title=excluded.inspiring_news_title,
        inspiring_news_url=excluded.inspiring_news_url,
        r_squared=excluded.r_squared,
        correlations_total=excluded.correlations_total,
        correlations_sig=excluded.correlations_sig,
        review_verdict=excluded.review_verdict,
        qa_verdict=excluded.qa_verdict,
        editorial=excluded.editorial,
        sample_countries=COALESCE(excluded.sample_countries, papers.sample_countries),
        sample_indicators=COALESCE(excluded.sample_indicators, papers.sample_indicators)
    ;
    """, (
        date, filename, topic, pregunta, hipotesis, indicadores_json,
        news_title, news_url, r_squared, corr_total, corr_sig,
        review_verdict, qa_verdict, editorial,
        sample_countries_json, sample_indicators_json
    ))
    
    paper_id = cur.execute("SELECT id FROM papers WHERE filename = ?", (filename,)).fetchone()[0]
    
    # Reemplazar correlaciones
    cur.execute("DELETE FROM correlations WHERE paper_id = ?", (paper_id,))
    
    if isinstance(sig_list, list):
        for c in sig_list:
            cur.execute("""
            INSERT INTO correlations (paper_id, var_x, var_y, r, p_value, country)
            VALUES (?, ?, ?, ?, ?, ?)
            """, (
                paper_id,
                c.get("x", ""),
                c.get("y", ""),
                float(c.get("r", 0.0)),
                float(c.get("p", 1.0)),
                c.get("country") or ""
            ))
                
    conn.commit()
    conn.close()
    return paper_id

_COUNTRY_SUFFIX_RE = re.compile(r"\s*\[([A-Za-z]{2,3})\]\s*$")


def _split_country(name: str):
    """Separa 'Etiqueta [CC]' en (etiqueta, CC).

    El sufijo [CC] lo agrega research.mjs a cada serie para evitar colisiones
    de nombre entre paises en el var_map de compute.py.
    """
    match = _COUNTRY_SUFFIX_RE.search(name or "")
    if not match:
        return (name or "").strip(), ""
    return name[: match.start()].strip(), match.group(1)


def normalize_correlations(entries: Any) -> List[Dict[str, Any]]:
    """Normaliza la lista de correlaciones antes de persistirla.

    - Colapsa pares simetricos: (A,B) y (B,A) son la misma correlacion (Pearson
      es simetrico) pero entraban dos veces, porque cada sugerencia del LLM
      puede listar el mismo par en orden distinto.
    - Rellena `country` desde el sufijo [CC] cuando el registro no lo trae.
    """
    normalized: List[Dict[str, Any]] = []
    seen = set()
    for entry in entries or []:
        if not isinstance(entry, dict) or "x" not in entry or "y" not in entry:
            continue
        x_name, y_name = entry["x"], entry["y"]
        key = tuple(sorted((x_name, y_name)))
        if key in seen:
            continue
        seen.add(key)
        _, cc_x = _split_country(x_name)
        _, cc_y = _split_country(y_name)
        normalized.append({**entry, "country": entry.get("country") or cc_x or cc_y or ""})
    return normalized


def sync_all_from_files(db_path: str = DB_PATH) -> int:
    """Sincroniza toda la base de datos a partir de knowledge.jsonl y output/papers/*.json."""
    init_db(db_path)
    count = 0
    
    # 1. Desde output/papers/*.json
    if os.path.exists(OUTPUT_PAPERS_DIR):
        for fname in os.listdir(OUTPUT_PAPERS_DIR):
            if fname.endswith(".json"):
                fpath = os.path.join(OUTPUT_PAPERS_DIR, fname)
                try:
                    with open(fpath, "r", encoding="utf-8") as f:
                        meta = json.load(f)
                    meta["file"] = fname.replace(".json", ".md")
                    record_paper(meta, db_path)
                    count += 1
                except Exception as e:
                    print(f"Aviso sync {fname}: {e}")
                    
    # 2. Complementar desde knowledge.jsonl
    if os.path.exists(KNOWLEDGE_JSONL):
        try:
            with open(KNOWLEDGE_JSONL, "r", encoding="utf-8") as f:
                for line in f:
                    line = line.strip()
                    if not line:
                        continue
                    try:
                        record = json.loads(line)
                        record_paper(record, db_path)
                    except:
                        pass
        except Exception as e:
            print(f"Aviso sync knowledge.jsonl: {e}")
            
    return count

def get_memory_context_for_suggest(db_path: str = DB_PATH, limit: int = 5) -> str:
    """Genera un bloque de texto contextual para inyectar en el prompt SUGGEST de Groq."""
    if not os.path.exists(db_path):
        sync_all_from_files(db_path)
        
    conn = get_connection(db_path)
    cur = conn.cursor()
    
    rows = cur.execute("""
    SELECT date, topic, pregunta, hipotesis, indicadores, r_squared, correlations_sig
    FROM papers
    ORDER BY date DESC, id DESC
    LIMIT ?;
    """, (limit,)).fetchall()
    
    if not rows:
        conn.close()
        return ""
        
    lines = ["MEMORIA DE INVESTIGACIONES PREVIAS (SQLite Base):"]
    lines.append("El sistema ya ha evaluado recientemente las siguientes hipótesis y relaciones empíricas:")
    
    for r in rows:
        inds = []
        if r["indicadores"]:
            try:
                inds = json.loads(r["indicadores"])
            except:
                pass
        ind_str = ", ".join(inds[:3]) if inds else "Indicadores varios"
        r2_str = f"R²={r['r_squared']:.3f}" if r["r_squared"] is not None else "Sin regresión"
        
        lines.append(f"- [{r['date']}] {r['topic']}")
        if r['hipotesis']:
            lines.append(f"  Hipótesis evaluada: \"{r['hipotesis']}\" ({r2_str}, {r['correlations_sig']} correlaciones sig.)")
        lines.append(f"  Indicadores explorados: {ind_str}")
        
    # Obtener un par de correlaciones significativas destacadas del histórico
    top_corr = cur.execute("""
    SELECT var_x, var_y, r, p_value
    FROM correlations
    WHERE p_value < 0.05
    ORDER BY abs(r) DESC
    LIMIT 3;
    """).fetchall()
    
    if top_corr:
        lines.append("\nHALLAZGOS EMPÍRICOS CONFIRMADOS EN LA BASE:")
        for c in top_corr:
            lines.append(f"- {c['var_x']} <-> {c['var_y']} (r={c['r']:.2f}, p={c['p_value']:.4f})")
            
    lines.append("\nINSTRUCCIÓN DE CONTINUIDAD EDITORIAL:")
    lines.append("Evita repetir exactamente las preguntas anteriores a menos que sea para contrastar un nuevo país o periodo. Busca ángulos complementarios o contradicciones interesantes.")
    
    conn.close()
    return "\n".join(lines)

def sync_indicator_series_from_fetched(json_path: str = None) -> int:
    """Ingesta las series temporales desde fetched-data.json hacia la tabla SQLite indicator_series."""
    init_db()
    if not json_path:
        json_path = os.path.join(ROOT_DIR, "output", "raw", "fetched-data.json")
    if not os.path.exists(json_path):
        return 0
    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    indicators = data.get("indicators", [])
    if not indicators:
        return 0
    conn = get_connection()
    cur = conn.cursor()
    count = 0
    for ind in indicators:
        cc = ind.get("country_code")
        cname = ind.get("country", cc)
        icode = ind.get("indicator_code")
        ilabel = ind.get("indicator_label")
        cat = ind.get("category")
        unit = ind.get("unit")
        for pt in ind.get("series", []):
            yr = pt.get("year")
            val = pt.get("value")
            if yr is not None and val is not None:
                cur.execute("""
                INSERT OR REPLACE INTO indicator_series
                (country_code, country_name, indicator_code, indicator_label, category, unit, year, value)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """, (cc, cname, icode, ilabel, cat, unit, yr, val))
                count += 1
    conn.commit()
    conn.close()
    return count

def get_top_countries_for_indicators(indicators: List[str], limit: int = 5) -> List[str]:
    """
    Selecciona de forma dinámica en SQLite la mejor muestra de países (default: 5)
    que tengan datos completos y consistentes para los indicadores del estudio.
    """
    init_db()
    if not indicators:
        return []
    conn = get_connection()
    cur = conn.cursor()
    
    placeholders = ", ".join(["?"] * len(indicators))
    sql = f"""
    SELECT country_code, count(DISTINCT indicator_code) as n_indicators, count(*) as n_observations
    FROM indicator_series
    WHERE country_code != 'LCN'
      AND (indicator_code IN ({placeholders}) OR indicator_label IN ({placeholders}))
    GROUP BY country_code
    ORDER BY n_indicators DESC, n_observations DESC
    LIMIT ?;
    """
    params = indicators + indicators + [limit]
    rows = cur.execute(sql, params).fetchall()
    conn.close()
    return [r["country_code"] for r in rows]

if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "sync"
    if cmd == "sync":
        c = sync_all_from_files()
        print(f"Base de datos SQLite sincronizada con {c} papers en {DB_PATH}")
    elif cmd == "sync-indicators":
        n = sync_indicator_series_from_fetched()
        print(f"Sincronizados {n} puntos de series temporales en SQLite indicator_series.")
    elif cmd == "top-countries":
        inds = sys.argv[2].split(",") if len(sys.argv) > 2 else []
        print(json.dumps(get_top_countries_for_indicators(inds)))
    elif cmd == "context":
        print(get_memory_context_for_suggest())
    elif cmd == "query":
        conn = get_connection()
        rows = conn.execute("SELECT id, date, topic, r_squared FROM papers").fetchall()
        for r in rows:
            print(f"[{r['id']}] {r['date']} - {r['topic']} (R2={r['r_squared']})")
        conn.close()
