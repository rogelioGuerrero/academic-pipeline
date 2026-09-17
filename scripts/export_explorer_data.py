"""
export_explorer_data.py — Exporta las tablas de docs/memory.db a Parquet
para el explorador DuckDB-WASM (docs/explorer.html).

Uso: python scripts/export_explorer_data.py
Salida: docs/data/{series,papers,correlations}.parquet
"""

import os
import sqlite3
import pandas as pd

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(ROOT, "docs", "memory.db")
OUT_DIR = os.path.join(ROOT, "docs", "data")

# nombre archivo -> (tabla sqlite, query)
TABLES = {
    "series": "SELECT country_code, country_name, indicator_code, indicator_label, category, unit, year, value FROM indicator_series ORDER BY country_code, indicator_code, year",
    "papers": "SELECT date, filename, topic, pregunta, hipotesis, inspiring_news_title, inspiring_news_url, r_squared, correlations_total, correlations_sig, review_verdict, qa_verdict, sample_countries FROM papers ORDER BY date DESC",
    "correlations": "SELECT var_x, var_y, r, p_value, country FROM correlations ORDER BY p_value",
}


def main():
    if not os.path.exists(DB_PATH):
        raise SystemExit(f"No existe {DB_PATH}")
    os.makedirs(OUT_DIR, exist_ok=True)
    conn = sqlite3.connect(DB_PATH)
    total = 0
    for name, query in TABLES.items():
        df = pd.read_sql_query(query, conn)
        out = os.path.join(OUT_DIR, f"{name}.parquet")
        df.to_parquet(out, index=False)
        kb = os.path.getsize(out) / 1024
        total += len(df)
        print(f"  {name}.parquet: {len(df)} filas ({kb:.1f} KB)")
    conn.close()
    print(f"Exportadas {total} filas -> {OUT_DIR}")


if __name__ == "__main__":
    main()
