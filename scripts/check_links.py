"""
check_links.py — Verifica que los enlaces externos de los papers no estén rotos.

Uso: python scripts/check_links.py [--strict] [--dir docs/papers]
Salida: output/link-report.json + resumen en consola.
--strict: exit code 1 si hay enlaces rotos (para CI bloqueante).
"""

import argparse
import json
import os
import re
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed
from urllib.parse import urlparse

import requests

URL_RE = re.compile(r'https?://[^\s\)\]<>"\']+')
SKIP_DOMAINS = ("localhost", "127.0.0.1", "doi.org/10.1007")  # doi: algunos editores bloquean bots; se reportan aparte
HEADERS = {"User-Agent": "Mozilla/5.0 (compatible; AcademicPipeline-LinkChecker/1.0)"}


def extract_urls(path):
    with open(path, "r", encoding="utf-8") as f:
        text = f.read()
    urls = []
    for m in URL_RE.finditer(text):
        url = m.group(0).rstrip(".,;:")
        urls.append(url)
    return urls


def check_url(url):
    try:
        r = requests.head(url, headers=HEADERS, timeout=12, allow_redirects=True)
        if r.status_code in (405, 403, 404) or r.status_code >= 500:
            r = requests.get(url, headers=HEADERS, timeout=12, allow_redirects=True, stream=True)
        return r.status_code, ""
    except requests.RequestException as e:
        return None, type(e).__name__


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--strict", action="store_true", help="exit 1 si hay enlaces rotos")
    ap.add_argument("--dir", default="docs/papers", help="directorio de papers .md")
    args = ap.parse_args()

    files = sorted(
        os.path.join(args.dir, f) for f in os.listdir(args.dir) if f.endswith(".md")
    ) if os.path.isdir(args.dir) else []
    if not files:
        sys.exit(f"No hay .md en {args.dir}")

    # url -> lista de archivos donde aparece
    url_map = {}
    for path in files:
        for url in extract_urls(path):
            if urlparse(url).netloc in ("localhost", "127.0.0.1"):
                continue
            url_map.setdefault(url, []).append(os.path.basename(path))

    print(f"{len(files)} papers, {len(url_map)} enlaces únicos a verificar\n")

    results = []
    with ThreadPoolExecutor(max_workers=8) as pool:
        futures = {pool.submit(check_url, u): u for u in url_map}
        for fut in as_completed(futures):
            url = futures[fut]
            code, err = fut.result()
            # 401/403 = el sitio existe pero bloquea bots (comun en publishers)
            blocked = code in (401, 403)
            ok = (code is not None and code < 400) or blocked
            results.append({
                "url": url,
                "status": code,
                "error": err or None,
                "ok": ok,
                "bot_blocked": blocked,
                "papers": url_map[url],
            })
            mark = "OK " if ok and not blocked else ("BOT " if blocked else "ROTO")
            print(f"  [{mark}] {code or err}  {url}")

    broken = [r for r in results if not r["ok"]]
    os.makedirs("output", exist_ok=True)
    with open("output/link-report.json", "w", encoding="utf-8") as f:
        json.dump({"checked": len(results), "broken": len(broken), "results": results},
                  f, ensure_ascii=False, indent=2)

    print(f"\n{len(results) - len(broken)}/{len(results)} enlaces OK — reporte en output/link-report.json")
    if broken:
        print(f"{len(broken)} enlaces rotos:")
        for r in broken:
            print(f"  - {r['url']} ({r['status'] or r['error']}) en {', '.join(r['papers'])}")
    if args.strict and broken:
        sys.exit(1)


if __name__ == "__main__":
    main()
