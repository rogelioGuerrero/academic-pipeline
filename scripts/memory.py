"""
memory.py - Memoria Relacional Persistente (SQLite) para AcademicPipeline
Almacena el historial de investigaciones, hipotesis y hallazgos cuantitativos
para que el pipeline (MoA Groq) mantenga contexto acumulativo a costo $0.
"""

import os
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

    cur.execute("CREATE INDEX IF NOT EXISTS idx_papers_date ON papers(date);")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_papers_topic ON papers(topic);")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_corr_p_value ON correlations(p_value);")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_corr_vars ON correlations(var_x, var_y);")
    
    conn.commit()
    conn.close()

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
    sig_list = stats.get("top_significativas") or stats.get("significantCorrelations") or []
    corr_sig = len(sig_list) if isinstance(sig_list, list) else stats.get("significativas", 0)
    
    review_verdict = data.get("review") or (data.get("reviewDecision") or {}).get("veredicto")
    qa_verdict = data.get("qa") or (data.get("qaDecision") or {}).get("veredicto")
    editorial = data.get("editorial")

    cur.execute("""
    INSERT INTO papers (
        date, filename, topic, pregunta, hipotesis, indicadores,
        inspiring_news_title, inspiring_news_url, r_squared,
        correlations_total, correlations_sig, review_verdict,
        qa_verdict, editorial
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
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
        editorial=excluded.editorial
    ;
    """, (
        date, filename, topic, pregunta, hipotesis, indicadores_json,
        news_title, news_url, r_squared, corr_total, corr_sig,
        review_verdict, qa_verdict, editorial
    ))
    
    paper_id = cur.execute("SELECT id FROM papers WHERE filename = ?", (filename,)).fetchone()[0]
    
    # Reemplazar correlaciones
    cur.execute("DELETE FROM correlations WHERE paper_id = ?", (paper_id,))
    
    if isinstance(sig_list, list):
        for c in sig_list:
            if isinstance(c, dict) and "x" in c and "y" in c:
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

if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "sync"
    if cmd == "sync":
        c = sync_all_from_files()
        print(f"Base de datos SQLite sincronizada con {c} papers en {DB_PATH}")
    elif cmd == "context":
        print(get_memory_context_for_suggest())
    elif cmd == "query":
        conn = get_connection()
        rows = conn.execute("SELECT id, date, topic, r_squared FROM papers").fetchall()
        for r in rows:
            print(f"[{r['id']}] {r['date']} - {r['topic']} (R2={r['r_squared']})")
        conn.close()
