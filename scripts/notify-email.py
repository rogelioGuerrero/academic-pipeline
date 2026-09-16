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


def main():
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
    topic = p.get("topic", "Nuevo artículo")
    link = f"{BASE}/#{p['file']}"
    qa = p.get("qa", "—")
    review = p.get("review", "—")
    pregunta = p.get("pregunta", "")

    html = f"""<h2>{topic}</h2>
<p><em>{pregunta}</em></p>
<p>Revisión de rigor: <b>{review}</b> · Control de calidad: <b>{qa}</b></p>
<p><a href="{link}">Leer el artículo completo →</a></p>
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
        },
    )
    try:
        with urllib.request.urlopen(req) as response:
            status = response.status
            print(f"Correo enviado ({status}): {topic}")
    except urllib.error.HTTPError as e:
        err_body = e.read().decode("utf-8", errors="ignore")
        print(f"Aviso: Resend devolvió HTTP {e.code}: {err_body}")
    except Exception as e:
        print(f"Aviso envío correo: {e}")


if __name__ == "__main__":
    sys.exit(main())
