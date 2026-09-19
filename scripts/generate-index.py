#!/usr/bin/env python3
"""Generate docs/index.json listing all research papers.

Called from .github/workflows/daily-research.yml after papers are copied
to docs/papers/. Reads metadata from output/papers/<stem>.json and
optionally enriches entries with the inspiring news image from
../job-hunter/news_found.json.
"""
import json, os, glob

papers = []
for f in sorted(glob.glob('docs/papers/*.md'), reverse=True):
    name = os.path.basename(f)
    date = name[:10] if len(name) > 10 else ''
    topic = 'Paper'
    verified = False
    try:
        with open(f, encoding='utf-8') as fh:
            content = fh.read()
            verified = '## Nota de transparencia' in content
            for line in content.splitlines():
                if line.startswith('# '):
                    topic = line[2:].strip(); break
    except: pass
    entry = {'file': name, 'date': date, 'topic': topic, 'nodes': 7, 'mode': 'suggest'}
    # Veredictos + noticia inspiradora desde la metadata (output/papers/<stem>.json)
    meta_path = os.path.join('output/papers', os.path.splitext(name)[0] + '.json')
    try:
        meta = json.load(open(meta_path, encoding='utf-8'))
        if meta.get('reviewDecision', {}).get('veredicto'):
            entry['review'] = meta['reviewDecision']['veredicto']
        if meta.get('qaDecision', {}).get('veredicto'):
            entry['qa'] = meta['qaDecision']['veredicto']
        news = meta.get('inspiringNews') or {}
        # Fallback: papers antiguos sin inspiringNews — matchear
        # suggestions[0].noticia_inspiradora contra news_found.json
        if not news.get('image'):
            try:
                items = json.load(open('../job-hunter/news_found.json', encoding='utf-8'))
                wanted = (meta.get('suggestions') or [{}])[0].get('noticia_inspiradora', '').lower()
                # Match robusto: substring O solapamiento de tokens >= 0.5
                # (news_found.json rota 3x/dia; la misma historia puede
                # reaparecer con titulo distinto en otra fuente)
                wanted_toks = set(wanted.split()) - {'a','de','the','for','in','on','to','y','el','la','en','los','las','por','con'}
                best, best_score = None, 0.0
                for it in items:
                    t = (it.get('title') or '').lower()
                    if wanted and (wanted in t or t in wanted):
                        best = it; break
                    t_toks = set(t.split())
                    score = len(wanted_toks & t_toks) / len(wanted_toks) if wanted_toks else 0
                    if score > best_score:
                        best, best_score = it, score
                if best and best_score >= 0.5:
                    news = {'image': best.get('url_to_image') or best.get('pexels_image'), 'section': best.get('section'), 'url': best.get('url')}
            except: pass
        if news.get('image'):
            entry['image'] = news['image']
        if news.get('section'):
            entry['section'] = news['section']
        if news.get('url'):
            entry['news_url'] = news['url']
        if meta.get('pregunta'):
            entry['pregunta'] = meta['pregunta']
        if meta.get('editorial'):
            entry['editorial'] = meta['editorial']
        cdir = (meta.get('computeResults') or {}).get('chartsDir')
        if cdir:
            entry['charts'] = cdir
            figs = sorted(os.path.basename(p) for p in glob.glob(f'docs/charts/{cdir}/fig*.png'))
            if figs:
                entry['figs'] = figs
        if meta.get('truncations'):
            entry['truncations'] = meta['truncations']
        entry['ts'] = meta.get('generated') or (date + 'T00:00:00Z')
    except:
        entry['ts'] = date + 'T00:00:00Z'
    if not verified:
        entry['warning'] = 'Borrador experimental generado antes de las correcciones de verificacion. Puede contener metodologia o estadisticas no verificadas.'
    papers.append(entry)
# Mas reciente primero: por timestamp real de generacion, no por filename
papers.sort(key=lambda p: (p.get('ts') or p['date']) + '|' + p['file'], reverse=True)
with open('docs/index.json', 'w', encoding='utf-8') as fh:
    json.dump(papers, fh, indent=2, ensure_ascii=False)
print(f'index.json: {len(papers)} papers')
