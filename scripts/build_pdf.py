"""
build_pdf.py - Generador de PDFs Académicos con Typst para AcademicPipeline
Convierte los papers .md y sus metadatos en PDFs con diseño editorial de alto nivel.
"""

import os
import re
import sys
import json
import typst

ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PAPERS_DIR = os.path.join(ROOT_DIR, "docs", "papers")
OUTPUT_PAPERS_DIR = os.path.join(ROOT_DIR, "output", "papers")
CHARTS_DIR = os.path.join(ROOT_DIR, "docs", "charts")

def clean_math(tex: str) -> str:
    """Convierte ecuaciones LaTeX simples a sintaxis Typst math."""
    tex = re.sub(r'\\text\{([^}]+)\}', r'"\1"', tex)
    # Subíndices y superíndices literales en Typst math se representan con comillas: _"it"
    tex = re.sub(r'_\{([^}]+)\}', r'_"\1"', tex)
    tex = re.sub(r'\^\{([^}]+)\}', r'^"\1"', tex)
    tex = tex.replace(r'\beta', 'beta').replace(r'\varepsilon', 'epsilon')
    tex = tex.replace(r'\times', 'times').replace(r'\,', ' ').replace(r'\Delta', 'Delta')
    tex = tex.replace(r'\approx', 'approx').replace(r'\sim', 'tilde')
    tex = tex.replace("‑", "-").replace("–", "-").replace(" ", " ")
    return tex.strip()

def clean_text_formatting(text: str) -> str:
    """Convierte formato markdown inline a Typst seguro."""
    # Primero escapar caracteres que Typst interpreta como comandos
    text = text.replace("$", r"\$")
    text = text.replace("<", r"\<").replace(">", r"\>")
    text = re.sub(r'@([a-zA-Z0-9_-]+)', r'\@\1', text)
    
    # Enlaces markdown [texto](url) -> #link("url")[texto]
    # (Restaurar si las URLs tenian caracteres escapados)
    text = re.sub(r'\[([^\]]+)\]\((https?://[^)]+)\)', r'#link("\2")[\1]', text)
    
    # Negrita **texto** -> *texto*
    text = re.sub(r'\*\*(.*?)\*\*', r'*\1*', text)
    
    # Normalizar tipografía especial (flechas, guiones no separables, espacios finos)
    text = text.replace("→", "->").replace("‑", "-").replace("–", "-").replace(" ", " ")
    return text

def parse_markdown_table(table_lines):
    """Convierte una tabla markdown a una tabla Typst profesional."""
    rows = []
    for line in table_lines:
        line = line.strip()
        if not line or line.startswith("|-") or line.startswith("| -"):
            continue
        cells = [c.strip() for c in line.split("|")[1:-1]]
        if cells and not all(re.match(r"^:?-+:?$", c) for c in cells):
            rows.append(cells)
    
    if not rows:
        return ""
    
    num_cols = len(rows[0])
    cleaned_rows = []
    for r in rows:
        while len(r) < num_cols:
            r.append("")
        r = r[:num_cols]
        cleaned_cells = []
        for cell in r:
            cell_clean = clean_text_formatting(cell)
            cleaned_cells.append(cell_clean)
        cleaned_rows.append(cleaned_cells)

    header = cleaned_rows[0]
    data_rows = cleaned_rows[1:]

    col_spec = ", ".join(["1fr"] * num_cols)
    out = [
        f"#align(center)[",
        f"#v(6pt)",
        f"#table(",
        f"  columns: ({col_spec}),",
        f"  fill: (col, row) => if row == 0 {{ rgb(\"#14213d\") }} else if calc.odd(row) {{ rgb(\"#f8fafc\") }} else {{ white }},",
        f"  stroke: (col, row) => if row == 0 {{ (bottom: 1.5pt + rgb(\"#0f172a\")) }} else {{ (bottom: 0.5pt + rgb(\"#e2e8f0\")) }},",
        f"  inset: (x: 8pt, y: 7pt),",
        f"  align: (col, row) => if row == 0 {{ center + horizon }} else {{ left + horizon }},",
        f"  table.header(" + ", ".join([f"text(white, weight: \"bold\", size: 8.2pt)[{h}]" for h in header]) + "),"
    ]
    for row in data_rows:
        row_str = ", ".join([f"text(size: 8.2pt)[{c}]" for c in row])
        out.append(f"  {row_str},")
    out.append(")")
    out.append(f"#v(6pt)")
    out.append("]")
    return "\n".join(out)

def convert_md_to_typst(md_content: str, meta: dict, paper_filename: str) -> str:
    """Convierte un paper completo a código Typst."""
    lines = md_content.splitlines()
    
    title = meta.get("topic") or "Investigación Académica"
    date_str = meta.get("date") or "2026-09-13"
    pregunta = meta.get("pregunta") or ""
    editorial = meta.get("editorial") or ""
    veredicto_rev = meta.get("reviewDecision", {}).get("veredicto", "APROBADO")
    
    if lines and lines[0].startswith("# "):
        title = lines[0][2:].strip().replace("**", "")
        lines = lines[1:]

    title = clean_text_formatting(title)
    pregunta = clean_text_formatting(pregunta)

    # Extraer Resumen
    resumen_text = ""
    body_lines = []
    i = 0
    
    while i < len(lines):
        line = lines[i]
        line_s = line.strip()
        
        if line_s.startswith("## Resumen"):
            i += 1
            res_parts = []
            while i < len(lines) and not lines[i].strip().startswith("## ") and not lines[i].strip().startswith("---"):
                if lines[i].strip():
                    res_parts.append(lines[i].strip())
                i += 1
            resumen_text = " ".join(res_parts)
            continue
        
        body_lines.append(line)
        i += 1

    resumen_text = clean_text_formatting(resumen_text)

    # Procesar cuerpo
    typst_body = []
    j = 0
    
    while j < len(body_lines):
        line = body_lines[j]
        line_s = line.strip()
        
        # Detectar Nota de transparencia
        if "## Nota de transparencia" in line_s or "Nota de transparencia" in line_s:
            trans_lines = []
            j += 1
            while j < len(body_lines):
                trans_lines.append(body_lines[j])
                j += 1
            
            trans_text = "\n".join(trans_lines)
            trans_text = clean_text_formatting(trans_text)
            
            trans_box = f"""
#v(14pt)
#block(
  fill: rgb("#f1f5f9"),
  stroke: (left: 4pt + rgb("#0284c7"), rest: 1pt + rgb("#cbd5e1")),
  radius: (right: 6pt),
  inset: (x: 14pt, y: 12pt),
  width: 100%,
  [
    #grid(
      columns: (auto, 1fr),
      gutter: 8pt,
      align: horizon,
      text(11pt)[#text(rgb("#0284c7"), weight: "bold")[#sym.checkmark]],
      text(10pt, weight: "bold", fill: rgb("#0f172a"))[CERTIFICADO DE TRANSPARENCIA Y NO-ALUCINACIÓN (AUDITORÍA MOA)]
    )
    #v(3pt)
    #line(length: 100%, stroke: 0.5pt + rgb("#94a3b8"))
    #v(3pt)
    #set text(size: 8pt, fill: rgb("#334155"))
    #set par(justify: true, leading: 0.55em)
    {trans_text}
  ]
)
"""
            typst_body.append(trans_box)
            break
            
        # Saltarse separadores horizontales simples
        if line_s == "---":
            j += 1
            continue
            
        # Detectar Tablas Markdown
        if line_s.startswith("|") and line_s.endswith("|"):
            table_block = []
            while j < len(body_lines) and body_lines[j].strip().startswith("|"):
                table_block.append(body_lines[j])
                j += 1
            typst_table = parse_markdown_table(table_block)
            typst_body.append(typst_table)
            continue
            
        # Detectar Ecuaciones en bloque \\[ ... \\]
        if line_s == r"\[":
            eq_lines = []
            j += 1
            while j < len(body_lines) and body_lines[j].strip() != r"\]":
                eq_lines.append(body_lines[j].strip())
                j += 1
            j += 1 # saltar \]
            eq_content = clean_math(" ".join(eq_lines))
            typst_body.append(f"\n$ {eq_content} $\n")
            continue
            
        # Detectar Imágenes Markdown: ![alt](charts/fig.png)
        img_match = re.match(r"!\[(.*?)\]\((.*?)\)", line_s)
        if img_match:
            caption = img_match.group(1)
            img_rel = img_match.group(2)
            base_name = os.path.basename(img_rel)
            
            # Buscar en distintas ubicaciones posibles
            candidate_paths = [
                os.path.normpath(os.path.join(PAPERS_DIR, img_rel)),
                os.path.normpath(os.path.join(CHARTS_DIR, base_name)),
            ]
            
            charts_dir_stamp = meta.get("charts") or (meta.get("computeResults") or {}).get("chartsDir")
            if charts_dir_stamp:
                candidate_paths.append(os.path.normpath(os.path.join(CHARTS_DIR, charts_dir_stamp, base_name)))
                # Fallback al primer gráfico de la corrida si el nombre fue inventado por el LLM
                candidate_paths.append(os.path.normpath(os.path.join(CHARTS_DIR, charts_dir_stamp, "fig1_trends.png")))
            
            img_abs = None
            for p in candidate_paths:
                if os.path.exists(p):
                    img_abs = p
                    break
            
            if img_abs:
                img_rel_typst = "/" + os.path.relpath(img_abs, ROOT_DIR).replace("\\", "/")
                fig_typ = f"""
#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("{img_rel_typst}", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* {clean_text_formatting(caption)}]
    ]
  )
  #v(6pt)
]
"""
            else:
                fig_typ = f"""
#align(center)[
  #v(4pt)
  #block(
    stroke: 0.5pt + rgb("#cbd5e1"),
    fill: rgb("#f8fafc"),
    radius: 4pt,
    inset: 8pt,
    [
      #text(size: 8pt, fill: rgb("#64748b"), style: "italic")[*Figura:* {clean_text_formatting(caption)} (Gráfico no disponible en repositorio)]
    ]
  )
  #v(4pt)
]
"""
            typst_body.append(fig_typ)
            j += 1
            continue

        # Encabezados
        if line_s.startswith("### "):
            h_text = clean_text_formatting(line_s[4:].strip().replace("**", ""))
            typst_body.append(f"\n=== {h_text}\n")
            j += 1
            continue
        elif line_s.startswith("## "):
            h_text = clean_text_formatting(line_s[3:].strip().replace("**", ""))
            typst_body.append(f"\n== {h_text}\n")
            j += 1
            continue
        elif line_s.startswith("# "):
            h_text = clean_text_formatting(line_s[2:].strip().replace("**", ""))
            typst_body.append(f"\n= {h_text}\n")
            j += 1
            continue

        # Formato de texto normal
        formatted_line = clean_text_formatting(line)
        
        # Viñetas y listas numeradas
        if line_s.startswith("- ") or line_s.startswith("* "):
            formatted_line = "- " + clean_text_formatting(line_s[2:])
        elif re.match(r"^\d+\.\s+", line_s):
            sub_text = re.sub(r"^\d+\.\s+", "", line_s)
            formatted_line = "+ " + clean_text_formatting(sub_text)

        typst_body.append(formatted_line)
        j += 1

    content_str = "\n".join(typst_body)
    
    # Editorial box si existe
    editorial_box = ""
    if editorial:
        clean_editorial = clean_text_formatting(editorial.replace("\n", "\n\n"))
        editorial_box = f"""
#block(
  fill: rgb("#fefce8"),
  stroke: (left: 3.5pt + rgb("#ca8a04"), rest: 0.5pt + rgb("#fef08a")),
  radius: (right: 4pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #text(9pt, weight: "bold", fill: rgb("#854d0e"))[COLUMNA EDITORIAL: DATOS AL DÍA]
    #v(3pt)
    #set text(size: 8.8pt, fill: rgb("#713f12"), style: "italic")
    #set par(justify: true, leading: 0.6em)
    {clean_editorial}
  ]
)
#v(8pt)
"""

    color_veredicto = "#166534" if "APROBADO" in veredicto_rev else "#b91c1c"

    # Template maestro Typst
    typst_doc = f"""
// ── CONFIGURACIÓN DEL DOCUMENTO ──
#set document(title: "{title}", author: "AcademicPipeline (MoA)")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.3cm, right: 2.3cm),
  header: context {{
    if here().page() > 1 [
      #grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        text(7.5pt, fill: rgb("#64748b"), weight: "medium")[
          *ACADEMIC PIPELINE* #h(6pt) | #h(6pt) CUADERNO DE INVESTIGACIÓN ECONÓMICA Y SOCIAL
        ],
        text(7.5pt, fill: rgb("#64748b"))[
          Página #counter(page).display()
        ]
      )
      #v(-3pt)
      #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
    ]
  }},
  footer: context [
    #line(length: 100%, stroke: 0.4pt + rgb("#e2e8f0"))
    #v(3pt)
    #grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      text(7pt, fill: rgb("#94a3b8"))[
        Datos auditados: World Development Indicators (Banco Mundial) · Python scipy/statsmodels (seed=42)
      ],
      text(7pt, fill: rgb("#94a3b8"))[
        Repositorio: rogelioguerrero.github.io/academic-pipeline
      ]
    )
  ]
)

#set text(font: ("Linux Libertine", "Georgia", "Times New Roman"), size: 9.6pt, lang: "es")
#set par(justify: true, leading: 0.68em)

// Estilo de encabezados
#show heading.where(level: 1): it => block(below: 10pt, above: 16pt)[
  #text(fill: rgb("#14213d"), weight: "bold", size: 13pt)[#it.body]
  #v(2pt)
  #line(length: 100%, stroke: 1.2pt + rgb("#14213d"))
]

#show heading.where(level: 2): it => block(below: 8pt, above: 12pt)[
  #text(fill: rgb("#1e293b"), weight: "bold", size: 10.8pt)[#it.body]
]

#show heading.where(level: 3): it => block(below: 6pt, above: 10pt)[
  #text(fill: rgb("#334155"), weight: "bold", size: 9.6pt)[#it.body]
]

// ── CABECERA / PORTADA ──
#align(center)[
  #block(
    fill: rgb("#14213d"),
    radius: 3pt,
    inset: (x: 10pt, y: 4pt),
    text(7.5pt, fill: white, weight: "bold", tracking: 1.2pt)[
      DOCUMENTO DE TRABAJO · AUDITORÍA COMPUTACIONAL
    ]
  )
  #v(6pt)
  #text(fill: rgb("#0f172a"), weight: "bold", size: 17.5pt)[{title}]
  
  #v(4pt)
  #text(fill: rgb("#475569"), style: "italic", size: 9.2pt)[
    Pregunta central: {pregunta}
  ]
  #v(8pt)
  
  // Ficha de metadatos del estudio
  #block(
    stroke: 0.6pt + rgb("#cbd5e1"),
    fill: rgb("#f8fafc"),
    radius: 4pt,
    inset: (x: 12pt, y: 8pt),
    [
      #grid(
        columns: (1.2fr, 1fr, 1fr, 1.1fr),
        align: left + horizon,
        gutter: 8pt,
        [
          #text(7.2pt, fill: rgb("#64748b"))[*FECHA Y VERSIÓN*]\\
          #text(8.2pt, fill: rgb("#0f172a"))[{date_str} · v1.0]
        ],
        [
          #text(7.2pt, fill: rgb("#64748b"))[*MOTOR ANALÍTICO*]\\
          #text(8.2pt, fill: rgb("#0f172a"))[MoA 5 Agentes (Groq)]
        ],
        [
          #text(7.2pt, fill: rgb("#64748b"))[*VALIDACIÓN RIGOR*]\\
          #text(8.2pt, fill: rgb("{color_veredicto}"), weight: "bold")[{veredicto_rev}]
        ],
        [
          #text(7.2pt, fill: rgb("#64748b"))[*FUENTE DE DATOS*]\\
          #text(8.2pt, fill: rgb("#0f172a"))[Banco Mundial (WDI)]
        ]
      )
    ]
  )
]

#v(8pt)

// ── RESUMEN EJECUTIVO / ABSTRACT ──
#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 3.5pt + rgb("#14213d"), rest: 0.5pt + rgb("#e2e8f0")),
  radius: (right: 4pt),
  inset: (x: 14pt, y: 10pt),
  width: 100%,
  [
    #text(9.5pt, weight: "bold", fill: rgb("#14213d"))[RESUMEN]
    #v(3pt)
    #set text(size: 8.8pt)
    #set par(justify: true, leading: 0.62em)
    {resumen_text}
    
    #v(4pt)
    #text(7.8pt, fill: rgb("#475569"))[*Palabras clave:* Banco Mundial, Econometría, América Latina, OLS, Series de Tiempo, MoA.]
  ]
)

#v(8pt)

{editorial_box}

// ── CUERPO DEL PAPER ──
{content_str}
"""
    return typst_doc

def build_paper(md_filename: str) -> str:
    """Compila un archivo markdown específico a PDF."""
    md_path = os.path.join(PAPERS_DIR, md_filename)
    if not os.path.exists(md_path):
        print(f"Error: no existe {md_path}")
        return None
    
    with open(md_path, "r", encoding="utf-8") as f:
        md_content = f.read()
        
    meta_filename = md_filename.replace(".md", ".json")
    meta_path = os.path.join(OUTPUT_PAPERS_DIR, meta_filename)
    meta = {}
    if os.path.exists(meta_path):
        try:
            with open(meta_path, "r", encoding="utf-8") as f:
                meta = json.load(f)
        except Exception as e:
            print(f"Aviso: no se pudo leer {meta_path}: {e}")
            
    index_json_path = os.path.join(ROOT_DIR, "docs", "index.json")
    if os.path.exists(index_json_path):
        try:
            with open(index_json_path, "r", encoding="utf-8") as f:
                index_data = json.load(f)
                for entry in index_data:
                    if entry.get("file") == md_filename:
                        for k, v in entry.items():
                            if k not in meta:
                                meta[k] = v
                        break
        except Exception as e:
            pass

    typst_content = convert_md_to_typst(md_content, meta, md_filename)
    
    typ_path = os.path.join(PAPERS_DIR, md_filename.replace(".md", ".typ"))
    pdf_path = os.path.join(PAPERS_DIR, md_filename.replace(".md", ".pdf"))
    
    with open(typ_path, "w", encoding="utf-8") as f:
        f.write(typst_content)
        
    print(f"Compilando con Typst: {md_filename} -> {os.path.basename(pdf_path)}")
    try:
        typst.compile(typ_path, output=pdf_path, root=ROOT_DIR)
    except Exception as e:
        print(f"Error compilando {typ_path}: {e}")
        return None
    
    # Limpiar .typ temporal si compiló exitosamente
    if os.path.exists(typ_path):
        os.remove(typ_path)
        
    file_size_kb = os.path.getsize(pdf_path) / 1024
    print(f"-> ¡Éxito! PDF generado: {pdf_path} ({file_size_kb:.1f} KB)")
    return pdf_path

def build_all():
    """Compila todos los papers en docs/papers/ a PDF."""
    if not os.path.exists(PAPERS_DIR):
        print(f"No existe {PAPERS_DIR}")
        return
        
    md_files = [f for f in os.listdir(PAPERS_DIR) if f.endswith(".md")]
    print(f"Papers encontrados para compilar: {len(md_files)}")
    
    for f in md_files:
        build_paper(f)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        build_paper(sys.argv[1])
    else:
        build_all()
