#!/usr/bin/env python3
"""parse-issue-form.py - Extrae los campos de un issue form de GitHub.

GitHub renderiza cada campo del formulario como '### <label>' seguido del valor,
y escribe '_No response_' cuando un campo opcional queda vacío. Este script
convierte ese Markdown en campos usables por el workflow paper-request.yml.

Uso:
  python scripts/parse-issue-form.py body.md                    # imprime JSON
  python scripts/parse-issue-form.py body.md --github-output    # escribe a $GITHUB_OUTPUT
"""

import json
import os
import re
import sys

# etiqueta visible en el formulario -> clave interna
FIELDS = {
    "Tema de investigación": "tema",
    "Ángulo editorial": "angulo",
    "Pregunta e hipótesis (opcional)": "pregunta",
    "Coberturas de interés (opcional)": "cobertura",
    "Indicadores sugeridos (opcional)": "indicadores",
    "Prioridad": "prioridad",
}

EMPTY = {"", "_no response_", "none", "n/a"}


def parse(body: str) -> dict:
    fields = {}
    for label, key in FIELDS.items():
        pattern = rf"^###\s+{re.escape(label)}\s*$\n(.*?)(?=^###\s|\Z)"
        match = re.search(pattern, body, re.S | re.M)
        value = match.group(1).strip() if match else ""
        fields[key] = "" if value.lower() in EMPTY else value
    return fields


def build_angle(fields: dict) -> str:
    """research.mjs acepta un solo argumento de ángulo: aquí se concatenan
    los campos opcionales del formulario en un bloque de contexto."""
    parts = []
    if fields["angulo"]:
        parts.append(fields["angulo"])
    if fields["pregunta"]:
        parts.append(fields["pregunta"])
    if fields["cobertura"]:
        parts.append(
            "Coberturas de interes (orientativo; la muestra final la decide la "
            "cobertura de datos, no esta lista):\n" + fields["cobertura"]
        )
    if fields["indicadores"]:
        parts.append("Indicadores sugeridos por quien encarga:\n" + fields["indicadores"])
    return "\n\n".join(parts)


def write_github_output(values: dict) -> None:
    path = os.environ.get("GITHUB_OUTPUT")
    if not path:
        raise SystemExit("Falta la variable de entorno GITHUB_OUTPUT")
    with open(path, "a", encoding="utf-8") as fh:
        for key, value in values.items():
            # Formato heredoc: soporta valores multilínea
            fh.write(f"{key}<<__EOF__\n{value}\n__EOF__\n")


def main() -> None:
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")  # consolas Windows en cp1252
    with open(sys.argv[1], encoding="utf-8") as fh:
        body = fh.read()

    fields = parse(body)
    if not fields["tema"]:
        raise SystemExit("El issue no tiene 'Tema de investigación': ¿es un encargo de paper?")

    outputs = {"tema": fields["tema"], "angulo": build_angle(fields)}

    if "--github-output" in sys.argv:
        write_github_output(outputs)
    else:
        print(json.dumps({**outputs, "campos": fields}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
