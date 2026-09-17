# AcademicPipeline — Arquitectura del pipeline

## Rol en el ecosistema

AcademicPipeline es el **motor de investigación automatizada** del sistema. Toma noticias de job-hunter, las cruza con datos públicos del World Bank, ejecuta análisis estadístico determinístico en Python, y produce papers en español con anti-hallucination.

## Pipeline end-to-end (1 corrida diaria, 8am)

```
news_found.json (de job-hunter/Netlify) ─┐
                                         ↓
World Bank API (23 indicadores × 7 países = 158 series) ─→ FETCH ─→ SUGGEST ─→ COMPUTE ─→ WRITE ─→ REVIEW ─→ EDIT ─→ APPROVE ─→ EDITORIAL
                                              │         │          │           │          │         │          │            │
                                              │         │          │           │          │         │          │            ↓
                                              │         │          │           │          │         │          │     Paper .md + .json
                                              │         │          │           │          │         │          │     charts/<stamp>/
                                              │         │          │           │          │         │          │     data.json (ECharts)
                                              │         │          │           │          │         │          │            │
                                              │         │          │           │          │         │          │            ↓
                                              │         │          │           │          │         │          │     GitHub Pages deploy
                                              │         │          │           │          │         │          │     (docs/index.html)
                                              ↓         ↓          ↓           ↓          ↓         ↓          ↓
                                         fetched-   tema +     compute-    draft      veredicto  draft      QA final
                                         data.json  hipótesis  results.json           (vs datos)  pulido    (estructura)
```

## Los 5 pasos de la PoC

| Paso | Implementación | Verificable |
|---|---|---|
| **Buscar** | World Bank API (23 indicadores × 6 países + LCN = 158 series) | fetched-data.json con 158 series |
| **Filtrar** | SUGGEST cruza noticias (score ≥70) con catálogo de indicadores | Tema + hipótesis + pregunta de investigación |
| **Resumir** | WRITE redacta paper técnico, EDITORIAL redacta columna llana | Paper .md + columna "Datos al día" |
| **Validar** | REVIEW verifica contra compute-results reales, QA structural, guardrails por nodo | Papers RECHAZADOS se marcan con warning |
| **Presentar** | GitHub Pages con ECharts interactivos + PNG fallback + guías "Cómo leerlo" | https://rogelioguerrero.github.io/academic-pipeline/ |

## Anti-hallucination (el diferenciador)

El sistema separa cálculo de redacción:

1. **Python calcula** (determinístico, seed=42): descriptivas, Pearson/Spearman, OLS con VIF/White/robust SE, panel FE, bootstrap (2000 réplicas), Mann-Kendall, anomalías, clustering
2. **LLM solo redacta** sobre resultados reales — no calcula nada
3. **REVIEW verifica** que cada número del paper esté en compute-results
4. **Guardrails** por nodo: FETCH (¿hay indicadores?), COMPUTE (¿hay regresión o correlaciones?), WRITE (¿tiene Resumen y Bibliografía?), REVIEW (¿veredicto válido?)
5. **Transparencia**: si el safety net recorta el prompt, se muestra banner naranja en el paper

## Componentes

- `scripts/research.mjs` — orquestador (8 nodos: SUGGEST→FETCH→COMPUTE→WRITE→REVIEW→EDIT→APPROVE→EDITORIAL)
- `scripts/compute.py` — análisis estadístico determinístico + 11 figuras con triggers condicionales
- `scripts/fetch-sources.mjs` — World Bank API con caché de 1 año
- `docs/index.html` — visor web con ECharts interactivos + guías de lectura + fallback PNG
- `docs/codebook.html` — libro de códigos: qué mide cada indicador, cobertura, unidades, papers que lo usan y matriz de cobertura (alcance catálogo o paper)
- `docs/explorer.html` — constructor visual de consultas (estantes) sobre Parquet vía DuckDB-WASM + SQL libre
- `docs/methodology.html` — documentación metodológica
- `.github/workflows/daily-research.yml` — cron 8am + deploy GitHub Pages

## Integración con job-hunter

- Descarga `news_found.json` de Netlify a las 8am
- SUGGEST filtra top 15 noticias por score ≥70
- El tab Research del PWA de job-hunter carga `index.json` de este repo
- Ambos comparten `GROQ_API_KEY` (200K tokens/día)

## Budget de tokens (Groq free tier)

| Nodo | Tokens estimados |
|---|---|
| SUGGEST | ~3K |
| WRITE | ~6K |
| REVIEW | ~5K |
| EDIT | ~2K |
| APPROVE | ~1K |
| EDITORIAL | ~1K |
| **Total por run** | **~28K** |

Safety net: si el prompt pasa de 7000 tokens, se trunca preservando instrucciones + formato. Se registra en metadata.

## Replicabilidad del concepto

Este pipeline demuestra un patrón replicable a otros dominios:

1. **Fuente de inspiración**: noticias, eventos, señales externas
2. **Fuente de datos**: APIs públicas (WB, FRED, ILOSTAT, OECD, UN Data)
3. **Análisis determinístico**: Python calcula, LLM no toca números
4. **Validación contra datos**: REVIEW verifica, no confía en el LLM
5. **Entrega multi-formato**: paper técnico + columna llana + gráficas interactivas

Para replicar a otro dominio (ej: inteligencia de mercado, compliance, content marketing):
- Cambiar las fuentes de datos en `fetch-sources.mjs`
- Cambiar el catálogo de indicadores
- Ajustar el prompt de SUGGEST al nuevo dominio
- El resto (compute, review, edit, approve, web) queda igual
