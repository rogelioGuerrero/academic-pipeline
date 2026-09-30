"""
notify-email.py - Aviso por correo cuando hay paper nuevo del día.
Lee docs/index.json, toma el paper más reciente de hoy y lo envía por Resend.
Uso: python scripts/notify-email.py  (env: RESEND_API_KEY, RESEND_FROM, RESEND_TO)
"""
import json
import os
import sys
import urllib.request
from datetime import date

BASE = "https://rogelioguerrero.github.io/academic-pipeline"
# Dedup de correos: papers ya anunciados. La marca se commitea desde el
# paso de notify del workflow (corre despues del commit de artifacts).
NOTIFIED_FILE = "output/notified.txt"


def load_env_fallback():
    for env_path in [".env", "../job-hunter/.env", os.path.join(os.path.dirname(__file__), "..", "..", "job-hunter", ".env")]:
        if os.path.exists(env_path):
            try:
                with open(env_path, encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if line and not line.startswith("#") and "=" in line:
                            k, v = line.split("=", 1)
                            k = k.strip()
                            if k not in os.environ:
                                os.environ[k] = v.strip().strip('"').strip("'")
            except Exception:
                pass


def main():
    load_env_fallback()
    for var in ("RESEND_API_KEY", "RESEND_FROM", "RESEND_TO"):
        if not os.environ.get(var):
            print(f"Falta {var}. Sin aviso por correo.")
            return

    try:
        papers = json.load(open("docs/index.json", encoding="utf-8"))
    except Exception as e:
        print(f"No se pudo leer docs/index.json: {e}")
        return

    today = date.today().isoformat()
    new_today = [p for p in papers if p.get("date") == today]
    if not new_today:
        print(f"Sin paper nuevo hoy ({today}). No se envía correo.")
        return

    p = new_today[0]
    notified = set()
    if os.path.exists(NOTIFIED_FILE):
        notified = set(open(NOTIFIED_FILE, encoding="utf-8").read().split())
    if p["file"] in notified:
        print(f"Paper {p['file']} ya notificado. No se reenvía.")
        return

    topic = p.get("topic", "Nuevo artículo")
    link = f"{BASE}/#{p['file']}"
    pdf_link = f"{BASE}/papers/{p['file'].replace('.md', '.pdf')}"
    qa = p.get("qa", "—")
    review = p.get("review", "—")
    pregunta = p.get("pregunta", "")

    html = f"""<h2>{topic}</h2>
<p><em>{pregunta}</em></p>
<p>Revisión de rigor: <b>{review}</b> · Control de calidad: <b>{qa}</b></p>
<p style="margin: 18px 0;">
  <a href="{link}" style="background: #14213d; color: #fff; padding: 8px 16px; text-decoration: none; border-radius: 6px; font-weight: bold;">Leer en la Web →</a>
  &nbsp;&nbsp;
  <a href="{pdf_link}" style="background: #0284c7; color: #fff; padding: 8px 16px; text-decoration: none; border-radius: 6px; font-weight: bold;">📄 Descargar PDF Editorial →</a>
</p>
<hr>
<small>Generado por AcademicPipeline. Cada cifra es verificable contra los datos del Banco Mundial — ver la Nota de transparencia al final del artículo.</small>"""

    body = {
        "from": os.environ["RESEND_FROM"],
        "to": [os.environ["RESEND_TO"]],
        "subject": f"Paper del día: {topic[:90]}",
        "html": html,
    }
    req = urllib.request.Request(
        "https://api.resend.com/emails",
        data=json.dumps(body).encode(),
        headers={
            "Authorization": "Bearer " + os.environ["RESEND_API_KEY"],
            "Content-Type": "application/json",
            "User-Agent": "AcademicPipeline/1.0 (Mozilla/5.0)",
        },
    )
    try:
        with urllib.request.urlopen(req) as response:
            status = response.status
            print(f"Correo enviado ({status}): {topic}")
        os.makedirs(os.path.dirname(NOTIFIED_FILE), exist_ok=True)
        with open(NOTIFIED_FILE, "a", encoding="utf-8") as fh:
            fh.write(p["file"] + "\n")
    except urllib.error.HTTPError as e:
        err_body = e.read().decode("utf-8", errors="ignore")
        print(f"Aviso: Resend devolvió HTTP {e.code}: {err_body}")
    except Exception as e:
        print(f"Aviso envío correo: {e}")


if __name__ == "__main__":
    sys.exit(main())
