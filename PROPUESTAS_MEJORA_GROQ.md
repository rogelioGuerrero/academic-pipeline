# Plan de Optimización Quirúrgica: Uso de Groq, Presupuesto de Tokens y Calidad Editorial

Este documento contiene el diagnóstico técnico profundo de `AcademicPipeline` y la especificación puntual de cambios para que un agente de código los implemente directamente.

El objetivo rector es **producir 1 documento académico impecable por corrida sin exceder las cuotas gratuitas de Groq (8,000 TPM / 200,000 TPD en `openai/gpt-oss-120b`, compartidas con `job-hunter`)**, eliminando los recortes destructivos de prompt, las tablas rotas, las citas fantasma (`Autor, 2020`) y los ciclos de reescritura innecesarios.

---

## Resumen Ejecutivo del Diagnóstico (Hallazgos con Evidencia en Producción)

Al inspeccionar el código (`scripts/research.mjs`, `scripts/compute.py`, `scripts/memory.py`) y cruzarlo con las salidas reales en `output/papers/2026-10-12_*.{json,md}`, `2026-10-09_*.{json,md}` y `2026-10-06_*.{json,md}`, se identificaron **8 problemas estructurales** que degradan la calidad y desperdician hasta el 60% de los tokens de cada corrida:

1. **Bug crítico en `UNIT_COMPAT` (`scripts/compute.py:78-107`)**: `_units_compatible` busca `tuple(sorted([unit_a, unit_b]))`, pero 14 de las 21 tuplas del diccionario están declaradas en orden inverso al orden ASCII de `sorted()` (ej. `("years", "%")` en vez de `("%", "years")`, `("kWh", "%")` en vez de `("%", "kWh")`, `("count", "USD")` en vez de `("USD", "count")`). Esto bloquea el cálculo de correlaciones para salud, energía, migración, telefonía móvil y PISA, llenando la Tabla 3 de `—` y dejando al LLM sin datos de su variable principal.
2. **Bug en `generate_markdown_tables` (`scripts/compute.py:1529` y `1551`)**:
   - En la línea 1529 se lee `c.get('t_stat', 0)` cuando `ols_regression` guarda la clave como `'t'` (`compute.py:465,481`). **Todos los papers publicados tienen `t = 0.00` en todas las filas OLS de la Tabla 2.**
   - En la línea 1551 no se filtran los objetos de correlación con `"error"`, inyectando filas vacías (`— | — | 🔴 Sin evidencia`) en la Tabla 3.
   - R (`compute_panel.R`) corre **después** de `compute.py` (`research.mjs:868`), por lo que la Tabla 2 nunca incluye los coeficientes de R aunque `computeDigest` (`research.mjs:1059`) oculta los coeficientes diciéndole al LLM *"Los coeficientes están en la TABLA 2"*. Eso causó los placeholders `β = ?` en el paper `2026-10-09`.
3. **Colapso del presupuesto de tokens en `fitPrompt` por exceso de bloques `⟦KEEP⟧` y tablas crudas (`scripts/research.mjs:143-220, 1021-1160`)**:
   - `computeDigest` inyecta las 4 tablas Markdown completas (incluyendo la Tabla 1 con 52 filas × 12 columnas de todos los países y años).
   - En `2026-10-12_*.json`, el prompt de `WRITE:cuerpo` pesó **8,559 tokens** y `fitPrompt` le recortó **10,524 caracteres**; en `REVIEW` recortó **9,001 caracteres**; en `EDIT` recortó **14,151 caracteres**.
   - Como los bloques `⟦KEEP⟧` consumen casi todo el presupuesto disponible, los segmentos sin `⟦KEEP⟧` (la literatura de OpenAlex, las tendencias, la Tabla 1/4 y los encabezados de las secciones a redactar) son **eliminados por `fitPrompt`**. Al quedarse sin la lista de OpenAlex, el LLM inventa citas como `(Autor, 2020; Autor, 2021)` (`2026-10-06.md`) o `(Smith, 2020)` (`2026-10-12.md`).
4. **Pérdida de `pregunta` e `hipotesis` en el deduplicador de `SUGGEST` (`scripts/research.mjs:2273-2281`)**:
   - `agentSuggest` solo pide `pregunta` e `hipotesis` en la raíz del JSON (para `suggestions[0]`). Cuando el dedup detecta que `suggestions[0]` está repetida y promueve `suggestions[1]`, asigna `decision.pregunta = null` y `decision.hipotesis = null` (ver `2026-10-09.json` y `2026-10-12.json`). Además, `fetchLiterature` busca en OpenAlex el título largo en español, devolviendo 0 papers.
5. **Mutilación de secciones en `WRITE` y guardrails insuficientes (`scripts/research.mjs:419-423, 1318-1384`)**:
   - El guardrail de `WRITE` solo comprueba `length > 1000`, `Resumen` y `Bibliografía` (que además tiene auto-append en la línea 1380). En `2026-10-12.md` el paper se publicó **sin `## Discusión` y sin `## Conclusiones`**.
6. **Ensamblaje prematuro de tablas/anexos antes de `REVIEW` y `EDIT` (`scripts/research.mjs:1384, 1770-1868`)**:
   - `agentWrite` pega `## Tablas` y `## Anexo estadístico` al borrador antes de pasar a `REVIEW` y `EDIT`, inflando el texto de ~8,000 a ~23,000 caracteres. Luego `EDIT` hace 5–7 llamadas separadas al LLM en cada iteración aunque solo 1 sección tenga observaciones del revisor.
7. **Concentración de todas las llamadas en un solo modelo (`openai/gpt-oss-120b`) y desperdicio de `reasoning_tokens`**:
   - En Groq Free Tier, cada modelo tiene su propio límite de TPM/TPD independiente, y `gpt-oss-120b` descuenta los tokens de razonamiento interno de `max_tokens`. Usar `gpt-oss-120b` incluso para correcciones mecánicas de estilo (`EDIT`) o checks que ya son deterministas (`APPROVE`) agota el balde de 8,000 TPM y provoca truncamientos (`finish_reason === "length"`).
8. **Estimación ciega de tokens y sleeps fijos (`scripts/research.mjs:116-130, 269-327`)**:
   - `callLLM` nunca lee `json.usage.prompt_tokens` en respuestas `200 OK` ni los headers `x-ratelimit-remaining-tokens` / `x-ratelimit-reset-tokens` de Groq; solo calibra tras fallar con HTTP 413 y usa `delay(20-40)` fijos.

---

## Tareas de Implementación Puntuales (En Orden de Ejecución)

### TAREA 1: Corregir los 4 bugs de datos y tablas en `scripts/compute.py`

**Archivo:** `scripts/compute.py`

#### 1.1. Corregir el orden de tuplas en `UNIT_COMPAT` (Líneas 78–107)
`_units_compatible` evalúa `tuple(sorted([unit_a, unit_b]))`. Todas las claves de `UNIT_COMPAT` deben normalizarse con `tuple(sorted(...))` al construir el diccionario para que el orden nunca falle:

```python
# Reemplazar la definición de UNIT_COMPAT y _units_compatible (líneas 78-107) por:
_RAW_UNIT_COMPAT = [
    ("%", "%"),
    ("%", "index"),
    ("%", "USD"),
    ("USD", "USD"),
    ("count", "count"),
    ("count", "USD"),
    ("count", "%"),
    ("per100", "per100"),
    ("per100", "%"),
    ("per100", "USD"),
    ("score", "score"),
    ("score", "USD"),
    ("score", "%"),
    ("score", "index"),
    ("years", "years"),
    ("years", "%"),
    ("years", "USD"),
    ("years", "count"),
    ("years", "index"),
    ("t", "t"),
    ("t", "%"),
    ("t", "USD"),
    ("kWh", "kWh"),
    ("kWh", "%"),
    ("kWh", "USD"),
]
UNIT_COMPAT = {tuple(sorted(pair)): True for pair in _RAW_UNIT_COMPAT}

def _units_compatible(unit_a, unit_b):
    """Check if two units can be meaningfully correlated."""
    if unit_a == unit_b:
        return True
    return UNIT_COMPAT.get(tuple(sorted([unit_a, unit_b])), False)
```

#### 1.2. Corregir `t = 0.00` en la Tabla 2 (Línea 1529)
En `generate_markdown_tables` (`scripts/compute.py:1529`), cambiar `c.get('t_stat', 0)` por `c.get('t', c.get('t_stat', 0))`:

```python
# Línea 1529:
t_val = c.get("t", c.get("t_stat", 0.0))
stat_str = f"t = {t_val:.2f}" if t_val == t_val else "—"
```

#### 1.3. Filtrar correlaciones con error antes de armar la Tabla 3 (Líneas 1551–1553)
Evitar que pares con `"error"` (por falta de años comunes o unidades incompatibles) entren en la Tabla 3 con `—`:

```python
# Reemplazar líneas 1551-1553 por:
corrs = [c for c in results.get("correlations", []) if c.get("pearson_r") is not None]
if corrs:
    top_corrs = sorted(
        corrs,
        key=lambda c: (1 if c.get("significant_fdr", c.get("significant")) else 0, abs(c.get("pearson_r") or 0)),
        reverse=True,
    )[:15]
```

#### 1.4. Limpiar etiquetas en español y nombres de países en `generate_markdown_tables` (Líneas 48–60 y 1498–1605)
- En `_es_label(name)` (`compute.py:48-60`), asegurar que si se pide solo la etiqueta del indicador para una columna donde el país ya va en otra columna (`Ámbito / País`), se elimine el sufijo `[CC]` en vez de concatenarlo de nuevo.
- Agregar un diccionario `COUNTRY_ES` en `compute.py` (`{"Brazil": "Brasil", "Dominican Republic": "República Dominicana", "Mexico": "México", "Panama": "Panamá", "Peru": "Perú", "Latin America & Caribbean (regional)": "América Latina y el Caribe (LCN)", "Latin America & Caribbean (aggregate)": "América Latina y el Caribe (LCN)"}`) y aplicarlo a la columna `País / Región` en las Tablas 1 y 4.

---

### TAREA 2: Sincronizar R (`compute_panel.R`) con `computeDigest` y la Tabla 2

**Archivos:** `scripts/research.mjs` (líneas 867–880 y 1050–1080)

**Problema actual:** `compute.py` corre primero y genera `computeResults.tables.regression` usando el panel de Python. Luego corre `compute_panel.R` y guarda `computeResults.r_econometrics`. Después, en `computeDigest` (línea 1058), el código ve `if (computeResults.tables?.regression)` y dice *"Los coeficientes están en la TABLA 2"*, ocultando los coeficientes de R que **no están** en la Tabla 2.

**Solución puntual:**
1. En ` computeDigest` (`scripts/research.mjs:1027-1080`), **siempre** listar explícitamente los coeficientes de `regression` (OLS) y de `panel` / `r_econometrics` en líneas compactas (~3 líneas por modelo, menos de 120 tokens en total), sin ocultarlos bajo `if (computeResults.tables?.regression)`. Eso garantiza que el LLM nunca escriba `β = ?` aunque la Tabla 2 sea recortada o separada.
2. Si `results.r_econometrics?.coefficients?.length` existe tras ejecutar `Rscript` en `agentCompute` (`scripts/research.mjs:873`), anexar las filas del modelo R (`Panel Efectos Fijos Bidireccional (País + Año, R)`) a `results.tables.regression` para que la Tabla 2 publicada en el paper coincida exactamente con lo que `computeDigest` y la `Nota de transparencia` declaran.

---

### TAREA 3: Rediseñar `computeDigest` y `dataDigest` para reducir el prompt de `WRITE` y `REVIEW` de ~8,500 a ~2,400 tokens (Cero Recortes)

**Archivo:** `scripts/research.mjs` (líneas 963–1160)

**Principio de diseño:** Las tablas Markdown completas (`TABLA 1` de 52 filas, `TABLA 2`, `TABLA 3`, `TABLA 4`) se insertan **determinísticamente por código** al final del documento (`ensureTables`). **El LLM NO tiene que copiar ni regenerar las tablas**, solo citar sus cifras en la prosa. Enviar la Tabla 1 de 52 filas año por año tres veces en `WRITE` y otra vez en `REVIEW` quema ~6,000 tokens por corrida y provoca que `fitPrompt` destruya el resto del prompt.

**Ajustes exactos:**
1. **Eliminar `TABLA 1 PRE-COMPUTADA` y `TABLA 4 PRE-COMPUTADA` crudas de `computeDigest`** (`scripts/research.mjs:1145-1158`).
2. En su lugar, en `dataDigest(fetchedData, suggestDecision)` (`scripts/research.mjs:963-1019`), construir un **Resumen Compacto de Series y Derivados** limitado exclusivamente a **`LCN` + los 5 países de `sampleCountriesFor(suggestDecision)`** para los 3-4 indicadores del estudio (máximo 24 líneas en total, ~400 tokens):
   ```text
   - Esperanza de vida al nacer (años) [LCN]: 2015=74.74 -> 2024=75.82 (min=71.81 en 2021, max=75.82 en 2024, media=74.56, Δtotal=+1.44%, cambio anual=+0.1194, CAGR=+0.16%)
   ```
   *(Tomando los valores directamente de `computeResults.derived[name]` y `computeResults.descriptive[name]` para que cada número citado por el LLM exista exactamente en `collectAllowedNumbers`)*.
3. En `computeDigest` (`scripts/research.mjs:1021-1144`), emitir los resultados estadísticos en formato tabular ultra-compacto protegido por `⟦KEEP⟧`:
   - **Bloque 1 (`REGRESION OLS`)**: ecuación, `n`, `dof`, `R2`, `R2_adj`, `F`, `p`, White test, regresores excluidos, y 1 línea por coeficiente con `beta`, `se`, `t`, `p`, `IC95% bootstrap` y veredicto (`🟢 Robusta` / `🟡 Marginal` / `🔴 Sin evidencia`).
   - **Bloque 2 (`REGRESION PANEL`)**: ecuación, `n`, `n_countries`, `R2`, `dof`, y 1 línea por coeficiente con `beta`, `se`, `t`, `p`, `IC95%` y veredicto.
   - **Bloque 3 (`CORRELACIONES TOP 12`)**: las 12 correlaciones más relevantes (priorizando `significant_fdr` y el ámbito `LCN` + los 5 países de la muestra), cada una en 1 línea con: `Par [País]: r=..., p=..., q_fdr=..., spearman=..., diff_r=..., diff_p=..., evidencia=...`.
   - **Bloque 4 (`TENDENCIAS Y ANOMALIAS`)**: top 8 tendencias significativas (Mann-Kendall `slope` y `p`) + top 4 anomalías (`año`, `valor`, `z`).
   - **Bloque 5 (`FIGURAS NARRATIVAS`)**: lista de rutas válidas `charts/<stamp>/figX.png` con su guía de lectura.
4. **Tamaño resultante de `contexto` (`dataDigest` + `computeDigest` + `literature`)**: **~1,600 a 2,100 tokens** (en lugar de 6,500–8,000 tokens). Cabe holgadamente en los 8,000 TPM de Groq en **todas** las etapas sin activar un solo recorte de `fitPrompt`.

---

### TAREA 4: Corregir `fitPrompt` para que nunca destruya encabezados ni ignore `⟦KEEP⟧`

**Archivo:** `scripts/research.mjs` (líneas 143–220)

Aunque con la Tarea 3 `fitPrompt` rara vez tendrá que recortar, cuando actúe como red de seguridad debe ser no-destructivo:
1. En la línea 161, cambiar `if (keepChars > 0 && keepChars < maxChars * 0.8)` para que **nunca caiga al `else` ciego** cuando existan bloques `⟦KEEP⟧`. Si `keepChars >= maxChars * 0.85`, recortar proporcionalmente el interior de los bloques `⟦KEEP⟧` más largos por líneas completas (conservando siempre las primeras y últimas líneas de cada bloque `⟦KEEP⟧`), en vez de partir el prompt entero con `60% cabeza / 35% cola`.
2. En el último segmento libre (`i === freeIdx[freeIdx.length - 1]`, líneas 193–198), **no hacer `s.t.slice(-avail)`** (que borra los encabezados `## Análisis` / `## Discusión` al inicio de ese bloque). En su lugar, conservar el **inicio** del bloque de instrucciones de la etapa (60% de `avail`, donde están los encabezados y estructura exigida) y el **final** (40% de `avail`, donde está la instrucción de formato/JSON).
3. Envolver también el bloque de `LITERATURA REAL VERIFICADA` en `⟦KEEP⟧...⟦/KEEP⟧` (son solo ~250 tokens para 5 referencias APA) y **prohibir explícitamente en el prompt placeholders como `(Autor, año)`**: si `literature` está vacío, el prompt debe indicar que solo se cite `(Banco Mundial, 2024)` y la noticia inspiradora.

---

### TAREA 5: Corregir `SUGGEST`, el Deduplicador y la Búsqueda en OpenAlex

**Archivo:** `scripts/research.mjs` (líneas 641–660, 1192–1210 y 2258–2282)

#### 5.1. Incluir `pregunta`, `hipotesis` y `keywords_en` dentro de cada sugerencia en `agentSuggest`
En el esquema JSON de `agentSuggest` (`scripts/research.mjs:642-658`), agregar dentro de cada elemento de `"suggestions"` los campos:
```json
"pregunta": "pregunta de investigacion verificable con los indicadores disponibles",
"hipotesis": "afirmacion concreta que los datos pueden apoyar o refutar",
"keywords_en": "3 to 5 English academic search terms for OpenAlex (e.g. 'health expenditure life expectancy Latin America')"
```
Y en `nodeSuggest` (`scripts/research.mjs:2273-2281`), cuando el deduplicador promueva `fresh.s`, asignar:
```js
decision.topic = fresh.s.titulo;
decision.angle = fresh.s.justificacion || decision.angle;
decision.pregunta = fresh.s.pregunta || decision.pregunta;
decision.hipotesis = fresh.s.hipotesis || decision.hipotesis;
decision.keywords_en = fresh.s.keywords_en || null;
```
**Impacto:** Nunca más habrá papers con `"pregunta": null` o `"hipotesis": null` cuando se active el dedup.

#### 5.2. Mejorar `fetchLiterature` en OpenAlex (`scripts/research.mjs:1192-1210`)
- Usar `suggestDecision?.keywords_en` (o extraer palabras clave de los nombres en inglés de `chosenIndicators(suggestDecision)` + `"Latin America"`) como query principal en OpenAlex.
- Si la consulta con `cited_by_count:>30` devuelve `< 2` resultados, hacer un segundo intento automático con `cited_by_count:>5` antes de rendirse.
- Acortar el `abstract` de cada paper de OpenAlex de 300 a **180 caracteres** en `formatAPA` (`línea 1188`) para ahorrar tokens en `WRITE`.

---

### TAREA 6: Separar Prosa de Ensamblaje Determinista y Optimizar `WRITE`, `REVIEW`, `EDIT` y `APPROVE`

**Archivo:** `scripts/research.mjs` (líneas 419–436, 1212–1385, 1615–2056)

#### 6.1. No pegar `## Tablas` ni `## Anexo estadístico` hasta terminar el ciclo de edición
- En `agentWrite` (`línea 1384`) y `agentEdit` (`líneas 1806, 1812, 1818, 1825, 1867`), **NO llamar a `ensureTables` ni `ensureDiagnosticsAnnex`**. Crear una función `normalizeDraftProse(text, computeResults)` que solo repare rutas de figuras narrativas (`![...](charts/...)`) durante `WRITE` y `EDIT`, y dejar `ensureTables` + `ensureDiagnosticsAnnex` + `buildBibliography` + `transparencyNote` para el **ensamblaje final post-APPROVE** (en `MoAGraph.run()`, línea 2394).
- **Impacto:** El borrador que viaja entre `WRITE -> REVIEW -> EDIT -> APPROVE` pasa de ~23,000 caracteres a **~7,500 caracteres (~2,500 tokens)**, eliminando la necesidad de `proseOnly()` y evitando truncamientos en `REVIEW` y `EDIT`.

#### 6.2. Generación 100% determinista de `## Bibliografía`
- En `WRITE:cierre` (`líneas 1348-1375`), pedirle al LLM únicamente que escriba `## Discusión` (200–300 palabras) y `## Conclusiones` (150–250 palabras), reduciendo `WRITE` de **3 llamadas a solo 2 llamadas**:
  1. **`WRITE:apertura_metodologia`** (`max_tokens: 2200, floor: 1400`): Título, `## Resumen` (+ `> **En breve:**`), `## Introducción` (+ `> **Hipótesis:**`), `## Metodología`.
  2. **`WRITE:analisis_cierre`** (`max_tokens: 3200, floor: 2200`): `## Análisis`, `## Discusión`, `## Conclusiones`.
- La sección `## Bibliografía` se construye por código (`buildDeterministicBibliography(draft, suggestDecision, literature)`) incluyendo:
  1. Cita APA del Banco Mundial (2024).
  2. Cita APA de la noticia inspiradora (`suggestDecision.inspiringNews`).
  3. Todas las obras de `literature` (OpenAlex) cuyo primer autor o año aparezca citado en `draft` (o las top 3 de `literature` si el autor las referenció).
- **Impacto:**
  - **Ahorra 1 llamada completa a `gpt-oss-120b` (~4,500 tokens)** en cada `WRITE` (y en cada `REESCRIBIR`).
  - **Elimina al 100% las citas inventadas** (`Autor, A. 2020`, `Smith, 2020`, `APA, 2020`) y los fallos de `bibliografia_ok: false` en QA.

#### 6.3. Endurecer los Guardrails de `WRITE` y `EDIT` (`scripts/research.mjs:419-431`)
Reemplazar los guardrails laxos actuales por la verificación de todas las secciones obligatorias de prosa:
```js
const REQUIRED_SECTIONS = [/##\s+Resumen/i, /##\s+(?:\d+\.\s*)?Introducci[oó]n/i, /##\s+(?:\d+\.\s*)?(?:Metodolog[ií]a|M[eé]todos)/i, /##\s+(?:\d+\.\s*)?(?:An[aá]lisis|Resultados)/i, /##\s+(?:\d+\.\s*)?Discusi[oó]n/i, /##\s+(?:\d+\.\s*)?Conclusiones/i];
```
Además, agregar un detector determinista de citas fantasma (`/\bAutor,?\s+[A-Z]?\.?\s*\(\d{4}\)|\b(?:Smith|Doe|Perez|Gomez),?\s+\(\d{4}\)/i`) dentro de `placeholderCheck(text)` para que cualquier referencia placeholder sea rechazada de inmediato.

#### 6.4. Hacer que `agentEdit` sea selectivo (Solo editar cuando hay issues reales y solo las secciones afectadas)
- **Skip de `EDIT` cuando `REVIEW` aprobó sin correcciones**: En `TRANSITIONS.REVIEW` (`scripts/research.mjs:452-455`), si `s.reviewDecision?.veredicto === "APROBADO"` y no hay `correcciones` ni `causal_check.soft` ni `invented`, saltar directamente de `REVIEW` a `APPROVE` (o hacer únicamente la normalización determinista). En corridas limpias esto **ahorra entre 5,000 y 15,000 tokens**.
- **Edición quirúrgica por sección afectada**: Cuando `EDIT` sí deba ejecutarse (porque `REVIEW` dejó correcciones menores o `APPROVE` detectó una frase causal o cifra sin respaldo), identificar **en qué sección (`## ...`) está el texto o cifra señalada** y llamar al LLM **solo para esa(s) sección(es)**, dejando las demás secciones intactas en 0 tokens.

#### 6.5. Convertir `agentApprove` (Nodo 7) en un Gate 100% Determinista (0 tokens de LLM)
- En `agentApprove` (`scripts/research.mjs:1987-2056`), los chequeos reales ya son deterministas (`verifyNumbers`, `causalClaimCheck`, `hasBrokenTables`, `placeholderCheck`). La llamada final a `openai/gpt-oss-20b` no recibe los datos (`computeResults` ni `fetchedData`) y siempre devuelve `"palabras": 3000` copiando el ejemplo del prompt.
- Reemplazar esa llamada LLM en `agentApprove` por una validación determinista completa de estructura (`REQUIRED_SECTIONS`), conteo real de palabras por sección (`palabras >= 900`), ausencia de placeholders/citas fantasma, `verifyNumbers` (`invented.length === 0`) y `causalClaimCheck` (`hard.length === 0`).
- **Impacto:** Ahorra ~2,500 tokens por cada pasada de `APPROVE` y elimina falsos positivos/negativos del modelo 20B.

---

### TAREA 7: Distribución Inteligente de Modelos en Groq (Multi-Model Pool) y Telemetría Real de Tokens

**Archivo:** `scripts/research.mjs` (líneas 106–130, 250–378)

#### 7.1. Reparto de modelos por etapa para multiplicar el TPM efectivo en Groq Free Tier
En Groq, los límites de rate-limit (TPM y TPD) se contabilizan **por modelo**:
- Mantener `openai/gpt-oss-120b` (`reasoning_effort: "low"`) para las etapas de alto razonamiento analítico:
  - `SUGGEST` (cruzar noticias con catálogo y formular hipótesis).
  - `WRITE` (redacción científica rigurosa con datos).
  - `REVIEW` (auditoría lógica e inconsistencias internas entre prosa y tablas).
- Asignar un modelo versátil sin sobrecosto de `reasoning_tokens` (configurable por env `GROQ_FAST_MODEL`, default `"llama-3.3-70b-versatile"` con fallback automático a `"openai/gpt-oss-120b"` o `"openai/gpt-oss-20b"`) para las tareas de transformación de estilo:
  - `EDIT` (pulir una sección puntual aplicando feedback concreto).
  - `EDITORIAL` (redactar la columna divulgativa de 180 palabras "Datos al día").
- **Ventaja:** `llama-3.3-70b-versatile` en Groq tiene **12,000 TPM propios** y **no gasta tokens de `max_tokens` en `<think>` / `reasoning`**, por lo que nunca trunca una sección editada ni compite por la cuota de `gpt-oss-120b`.

#### 7.2. Calibración continua con `usage` y Rate-Limiting basado en Headers de Groq
En `callLLM` (`scripts/research.mjs:270-291`):
1. Cuando `res.ok` es `true`, leer:
   - `res.headers.get("x-ratelimit-remaining-tokens")` y `res.headers.get("x-ratelimit-reset-tokens")`.
   - `json.usage?.prompt_tokens`, `json.usage?.completion_tokens`, `json.usage?.total_tokens`.
2. Calibrar `CHARS_PER_TOKEN` en **cada respuesta exitosa** usando `body.messages[0].content.length / json.usage.prompt_tokens` (con media móvil suave), sin esperar a que ocurra un error 413.
3. Reemplazar los `await delay(20)` / `await delay(25)` / `await delay(40)` fijos entre etapas por un helper `waitForTokenBudget(model, estimatedNextTokens)` que consulte los tokens restantes del modelo en el minuto actual y solo duerma los segundos exactos indicados por `x-ratelimit-reset-tokens` cuando `remainingTokens < estimatedNextTokens`.

---

### TAREA 8: Unificar el Pipeline a 1 Corrida Diaria Completa (Eliminar el freno artificial de 3 días cuando hay presupuesto)

**Archivo:** `scripts/research.mjs` (líneas 2324–2344)

**Problema actual:** En las líneas 2340 y 2342:
```js
if (multiDay && !checkpoint && current === "COMPUTE" && next !== "END") { saveCheckpoint("compute_done", next, this.state); process.exit(0); }
if (multiDay && checkpoint?.stage === "compute_done" && current === "WRITE") { saveCheckpoint("write_done", "REVIEW", this.state); process.exit(0); }
```
Hoy el pipeline se detiene obligatoriamente el Día 1 después de `COMPUTE` (habiendo gastado solo ~2,500 tokens en `SUGGEST`) y el Día 2 después de `WRITE` (habiendo gastado solo ~9,000 tokens). Eso retrasa cada paper 3 días aunque la cuota diaria de Groq (200,000 TPD) esté al 95% libre.

**Solución puntual:**
- Con las optimizaciones de las Tareas 1–7, una corrida completa de principio a fin (`FETCH -> SUGGEST -> COMPUTE -> WRITE (2 partes) -> REVIEW -> [EDIT selectivo] -> APPROVE (0 tokens) -> EDITORIAL`) consume **~14,000 a 18,000 tokens totales** (menos del 9% del límite diario de Groq).
- Cambiar la lógica de checkpoint en `MoAGraph.run()` para que el pipeline **ejecute todos los nodos en la misma corrida**, y **solo guarde checkpoint y salga con `process.exit(0)` si Groq devuelve un 429 de cuota diaria agotada (TPD)** o si `QA` rechaza tras agotar reintentos.

---

## Comparativa de Consumo de Tokens por Corrida (Antes vs. Después)

| Etapa | Estado Actual (`v4`) | Propuesta Optimizada | Ahorro / Mejora Clave |
| :--- | :--- | :--- | :--- |
| **SUGGEST** | ~3,200 tok (`gpt-oss-120b`) | ~2,800 tok (`gpt-oss-120b`) | Incluye `pregunta`, `hipotesis` y `keywords_en` por cada sugerencia |
| **WRITE** | 3 llamadas × ~8,000 tok = **~24,000 tok** (con recortes de 10k chars) | 2 llamadas × ~3,800 tok = **~7,600 tok** (0 recortes) | Digest sin Tabla 1 cruda de 52 filas; Bibliografía 100% determinista |
| **REVIEW** | ~8,000 tok (con recorte de 9k chars) | **~3,800 tok** (ve el 100% del paper sin recortes) | Evalúa prosa limpia antes de pegar `## Tablas` y `## Anexo` |
| **EDIT** | 5–7 llamadas = **~12,000–18,000 tok** | **0 tok** (si REVIEW aprueba) o **~1,800 tok** (solo sección afectada) | Skip cuando no hay correcciones; edita solo la sección con issues |
| **APPROVE** | ~2,500 tok (`gpt-oss-20b` sin datos) | **0 tok** (100% determinista en JS) | Verifica secciones, palabras, cifras (`verifyNumbers`) y causalidad |
| **EDITORIAL** | ~2,500 tok (`gpt-oss-120b`) | **~1,200 tok** (`llama-3.3-70b-versatile`) | Usa pool de TPM separado sin gasto en tokens de razonamiento |
| **Total 1 Run** | **~50,000 – 85,000 tok** (en 3 días, con truncamientos) | **~15,400 – 17,200 tok** (en 1 sola corrida de ~2 min, 0 truncamientos) | **Reducción del ~75% de tokens y eliminación de errores estructurales** |

---

## Checklist de Verificación para el Agente Ejecutor

Después de aplicar las 8 tareas anteriores, el agente ejecutor debe correr estos comandos de verificación (usando `;` en PowerShell):

```powershell
python -m pytest scripts/test_compute.py -q; node scripts/test-token-budget.mjs; node scripts/test-verify-numbers.mjs; node scripts/test-edit.mjs; node scripts/test-pares-linea-elegida.mjs
```

Y verificar explícitamente en un test que:
1. `_units_compatible("years", "%")`, `_units_compatible("kWh", "%")`, `_units_compatible("per100", "USD")` y `_units_compatible("count", "USD")` devuelven `True`.
2. La Tabla 2 generada por `compute.py` muestra el estadístico `t` real (distinto de `0.00`) en las filas de `OLS Agregado (LCN)`.
3. La Tabla 3 no contiene filas con `—` producto de correlaciones con `"error"`.
4. `computeDigest` + `dataDigest` para cualquier tema de 4 indicadores no supera los 2,200 tokens estimados.
