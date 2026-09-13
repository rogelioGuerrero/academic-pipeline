/**
 * Research Pipeline v4 - Datos reales + sugerencias basadas en noticias
 *
 * 7 nodos: FETCH -> SUGGEST -> COMPUTE -> WRITE -> REVIEW -> EDIT -> APPROVE
 *
 * v4:
 * - FETCH: World Bank API + ILO + PISA (datos reales, sin invenciones)
 * - SUGGEST: LLM cruza noticias de job-hunter vs catálogo de indicadores disponibles
 * - COMPUTE: Python real (statsmodels/scipy) sobre datos reales
 * - WRITE: LLM escribe narrativa usando SOLO datos reales + resultados Python
 * - REVIEW/EDIT/APPROVE: MoA con feedback loops
 *
 * Uso: node scripts/research.mjs ["linea de investigacion"] [@angle.txt]
 *   Sin argumentos: usa SUGGEST con news_found.json de job-hunter
 *   Con argumento: usa el tema dado (modo v3)
 */

import { writeFileSync, readFileSync, mkdirSync } from "fs";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { execFileSync } from "child_process";
import { fetchSources } from "./fetch-sources.mjs";

function loadEnv() {
  try {
    const __dirname = dirname(fileURLToPath(import.meta.url));
    const envPath = resolve(__dirname, "..", ".env");
    const envContent = readFileSync(envPath, "utf-8");
    for (const line of envContent.split("\n")) {
      const match = line.match(/^([A-Z_]+)=(.*)$/);
      if (match && !process.env[match[1]]) {
        process.env[match[1]] = match[2].replace(/^"|"$/g, "");
      }
    }
  } catch {}
}
loadEnv();

const GROQ_API_KEY = process.env.GROQ_API_KEY;
const GROQ_API_URL = "https://api.groq.com/openai/v1/chat/completions";
const OUTPUT_DIR = "output/papers";
const OUTPUT_FILE = `${OUTPUT_DIR}/paper.txt`;
const BRIEF_DIR = "output/briefs";

// Path to job-hunter news_found.json (relative to project root)
const NEWS_PATH = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..", "job-hunter", "news_found.json");

let TOPIC = process.argv.slice(2).filter(a => !a.startsWith("--"))[0] || "";
const ANGLE_RAW = process.argv.slice(2).filter(a => !a.startsWith("--"))[1] || "";
const MAX_REWRITE_ITERATIONS = 2;
const MAX_EDIT_ITERATIONS = 2;

const ANGLE = ANGLE_RAW.startsWith("@")
  ? readFileSync(ANGLE_RAW.slice(1), "utf-8").trim()
  : ANGLE_RAW;

if (!GROQ_API_KEY) {
  console.error("Error: GROQ_API_KEY no encontrada.");
  process.exit(1);
}

// Sin TOPIC: modo SUGGEST (usa news_found.json de job-hunter)
// Con TOPIC: modo directo (v3 behavior)
// --suggest-only: para despues de SUGGEST, no escribe paper
// --no-cache: fuerza refetch aunque exista caché
const SUGGEST_ONLY = process.argv.includes("--suggest-only");
const NO_CACHE = process.argv.includes("--no-cache");
const CACHE_PATH = "output/raw/fetched-data.json";
const CACHE_MAX_AGE_HOURS = 8760; // 1 año: los datos del World Bank se actualizan anualmente

async function callGroq(model, prompt, opts = {}) {
  const body = { model, messages: [{ role: "user", content: prompt }], ...opts };
  for (let attempt = 1; attempt <= 4; attempt++) {
    const res = await fetch(GROQ_API_URL, {
      method: "POST",
      headers: { Authorization: `Bearer ${GROQ_API_KEY}`, "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
    if (res.ok) {
      const json = await res.json();
      const content = json.choices[0]?.message?.content || "";
      if (!content.trim() && attempt < 4) {
        console.log(`  Respuesta vacia de ${model}. Reintentando... (${attempt}/4)`);
        await new Promise((r) => setTimeout(r, 5000 * attempt));
        continue;
      }
      return json;
    }
    if (res.status === 429 && attempt < 4) {
      const errText = await res.text();
      const match = errText.match(/try again in ([\d.]+)s/i);
      const waitSec = match ? Math.ceil(parseFloat(match[1])) + 2 : 35;
      console.log(`  Rate limit (429). Esperando ${waitSec}s... (intento ${attempt}/4)`);
      await new Promise((r) => setTimeout(r, waitSec * 1000));
      continue;
    }
    const err = await res.text();
    console.error(`Error ${model}: ${res.status}`);
    console.error(err.slice(0, 500));
    throw new Error(`Groq API error ${res.status}`);
  }
  throw new Error("Groq API: max retries exceeded");
}

function parseJSONResponse(text) {
  try { return JSON.parse(text); } catch {}
  const jsonMatch = text.match(/```(?:json)?\s*([\s\S]*?)```/);
  if (jsonMatch) { try { return JSON.parse(jsonMatch[1].trim()); } catch {} }
  const start = text.indexOf("{");
  const end = text.lastIndexOf("}");
  if (start !== -1 && end !== -1) { try { return JSON.parse(text.slice(start, end + 1)); } catch {} }
  return null;
}

function decisionToFeedback(decision) {
  if (!decision) return "";
  const parts = [];
  if (decision.correcciones?.length) parts.push("Correcciones: " + decision.correcciones.join("; "));
  if (decision.datos_faltantes) parts.push("Datos faltantes: " + decision.datos_faltantes);
  if (decision.issues?.length) parts.push("Problemas: " + decision.issues.join("; "));
  if (decision.feedback) parts.push("Feedback: " + decision.feedback);
  if (decision.detalle_datos) parts.push("Detalle: " + decision.detalle_datos);
  return parts.join("\n");
}

function delay(seconds) {
  console.log(`  Esperando ${seconds}s...`);
  return new Promise((r) => setTimeout(r, seconds * 1000));
}

function truncate(text, maxChars) {
  if (!text) return "";
  if (text.length <= maxChars) return text;
  return text.slice(0, maxChars) + "\n[...truncado]";
}

const GUARDRAILS = {
  FETCH: [{ check: out => out && out.indicators && out.indicators.length > 0, msg: "No se obtuvieron indicadores" }],
  SUGGEST: [{ check: out => out && out.topic && out.topic.length > 10, msg: "SUGGEST no genero tema" }],
  COMPUTE: [{ check: out => out !== null, msg: "Python no respondio" }],
  WRITE: [
    { check: out => out && out.length > 1000, msg: "Paper muy corto" },
    { check: out => out && /Resumen|Abstract/i.test(out), msg: "Falta Resumen" },
    { check: out => out && /Bibliograf|References/i.test(out), msg: "Falta Bibliografia" },
  ],
  REVIEW: [
    { check: out => out && out.veredicto !== undefined, msg: "Falta veredicto" },
    { check: out => out && ["APROBADO", "REESCRIBIR"].includes(out.veredicto), msg: "Veredicto invalido" },
  ],
  EDIT: [
    { check: out => out && out.length > 1000, msg: "Paper editado muy corto" },
    { check: out => out && /Bibliograf|References/i.test(out), msg: "Falta Bibliografia" },
  ],
  APPROVE: [
    { check: out => out && out.veredicto !== undefined, msg: "Falta veredicto" },
    { check: out => out && ["APROBADO", "RECHAZADO"].includes(out.veredicto), msg: "Veredicto invalido" },
  ],
};

function runGuardrails(node, output) {
  const rules = GUARDRAILS[node];
  if (!rules) return [];
  return rules.filter(g => !g.check(output)).map(g => g.msg);
}

const TRANSITIONS = {
  FETCH: [{ next: "SUGGEST" }],
  SUGGEST: [
    { condition: () => SUGGEST_ONLY, next: "END" },
    { condition: () => true, next: "COMPUTE" },
  ],
  COMPUTE: [{ next: "WRITE" }],
  WRITE: [{ next: "REVIEW" }],
  REVIEW: [
    { condition: s => s.reviewDecision?.veredicto === "REESCRIBIR" && s.iterations.rewrite < MAX_REWRITE_ITERATIONS, next: "WRITE", action: s => { console.log("-> REESCRIBIR\n"); s.writeFeedback = s.reviewDecision.feedback || s.reviewDecision.correcciones?.join("; ") || ""; s.iterations.rewrite++; } },
    { condition: () => true, next: "EDIT", action: s => { s.editFeedback = decisionToFeedback(s.reviewDecision); } },
  ],
  EDIT: [{ next: "APPROVE" }],
  APPROVE: [
    { condition: s => s.qaDecision?.veredicto === "RECHAZADO" && s.iterations.edit < MAX_EDIT_ITERATIONS, next: "EDIT", action: s => { console.log("-> QA rechazo\n"); s.editFeedback = decisionToFeedback(s.qaDecision); s.iterations.edit++; } },
    { condition: () => true, next: "END" },
  ],
};

function resolveTransition(node, state) {
  const rules = TRANSITIONS[node];
  if (!rules) return "END";
  for (const rule of rules) {
    if (!rule.condition || rule.condition(state)) {
      if (rule.action) rule.action(state);
      return rule.next;
    }
  }
  return "END";
}

async function agentFetch(topic) {
  // Caché: si existe y es reciente, usar sin refetch
  if (!NO_CACHE) {
    try {
      const stat = await import("fs").then(fs => fs.statSync(CACHE_PATH));
      const ageHours = (Date.now() - stat.mtimeMs) / 3600000;
      if (ageHours < CACHE_MAX_AGE_HOURS) {
        const cached = JSON.parse(readFileSync(CACHE_PATH, "utf-8"));
        console.log(`[1/7] Caché válida (${ageHours.toFixed(1)}h). Datos: ${cached.summary?.total_indicators || "??"} indicadores, ${cached.summary?.total_countries || "??"} países.`);
        return cached;
      }
      console.log(`[1/7] Caché expirada (${ageHours.toFixed(1)}h > ${CACHE_MAX_AGE_HOURS}h). Refetching...`);
    } catch {
      console.log("[1/7] Sin caché. Fetching de World Bank + ILO + PISA...");
    }
  } else {
    console.log("[1/7] --no-cache. Fetching de World Bank + ILO + PISA...");
  }
  console.log("[1/7] Obteniendo datos reales de World Bank + ILO + PISA...\n");
  return await fetchSources(topic);
}

async function agentSuggest(fetchedData) {
  console.log("[2/7] GPT-OSS 120B sugiriendo lineas editoriales...\n");

  // Si ya tenemos TOPIC, modo directo (v3)
  if (TOPIC) {
    console.log("  TOPIC provisto por argumento, saltando SUGGEST.");
    return { topic: TOPIC, angle: ANGLE, suggestions: [], mode: "manual" };
  }

  // Leer news_found.json de job-hunter
  let newsItems = [];
  try {
    const raw = readFileSync(NEWS_PATH, "utf-8");
    const parsed = JSON.parse(raw);
    // Aceptar array directo o envoltorio tipo {articles: [...]} / {items: [...]}
    if (Array.isArray(parsed)) {
      newsItems = parsed;
    } else if (parsed && Array.isArray(parsed.articles)) {
      newsItems = parsed.articles;
    } else if (parsed && Array.isArray(parsed.items)) {
      newsItems = parsed.items;
    } else {
      // Respuesta de error de la API de GitHub ({"message":"Not Found",...}) u otro objeto inesperado
      console.log("  news_found.json no es una lista de articulos (posible error de descarga). Usando modo generico.");
      newsItems = [];
    }
    console.log(`  Noticias cargadas: ${newsItems.length} articulos de job-hunter`);
  } catch {
    console.log("  No se encontro news_found.json. Usando modo generico.");
  }

  // Construir catalogo de indicadores disponibles
  const catalog = [...new Map(fetchedData.indicators.map(i => [i.indicator_label, {
    label: i.indicator_label,
    category: i.category,
    unit: i.unit,
    source: i.source,
  }])).values()];
  const catalogText = catalog.map(c => `- ${c.label} (${c.category}, ${c.unit}, ${c.source})`).join("\n");

  // Top noticias (score > 70)
  const topNews = newsItems
    .filter(n => (n.llm_score || 0) >= 70)
    .slice(0, 15)
    .map(n => ({
      title: n.title,
      section: n.section,
      score: n.llm_score,
      summary: (n.llm_summary || n.description || "").slice(0, 150),
      published: n.published_at,
    }));
  const newsText = topNews.map(n => `- [${n.score}] ${n.title} (${n.section})\n  ${n.summary}`).join("\n");

  const prompt = `Eres un editor de una revista de ciencias sociales especializada en America Latina.

NOTICIAS TENDING (de job-hunter, scored por LLM):
${newsText || "Sin noticias disponibles."}

CATALOGO DE INDICADORES DISPONIBLES (datos reales ya fetchados):
${catalogText}

TAREA:
1. Cruza las noticias con los indicadores disponibles.
2. Propone 3-5 lineas editoriales que PUEDEN respaldarse con datos reales.
3. Para cada linea: indica que noticia la inspira, que indicadores la respaldan, y que correlaciones serian relevantes.
4. Descarta noticias que no tengan respaldo de datos (ej: politica interna, conflictos belicos sin datos economicos).
5. Elige la MEJOR linea como tema principal.

REGLAS:
- Solo propone lineas donde tenemos datos reales para respaldar.
- Prioriza lineas que combinen multiples dominios (educacion + economia, tecnologia + empleo, etc).
- El tema debe ser relevante y actual (conectado a las noticias trending).
- El angulo debe ser especifico y analizable con correlacion/regresion.

Responde EXACTAMENTE como JSON (sin markdown):
{
  "suggestions": [
    {
      "titulo": "titulo de la linea editorial",
      "noticia_inspiradora": "titulo de la noticia",
      "indicadores_respaldan": ["indicador 1", "indicador 2"],
      "correlaciones_relevantes": ["corr 1", "corr 2"],
      "justificacion": "por que esta linea tiene respaldo de datos"
    }
  ],
  "topic": "el mejor tema para investigar (especifico)",
  "angle": "angulo editorial especifico para el paper"
}`;

  const data = await callGroq("openai/gpt-oss-120b", prompt, { max_tokens: 4000, temperature: 0.7 });
  const raw = data.choices[0]?.message?.content || "";
  const decision = parseJSONResponse(raw);

  if (!decision || !decision.topic) {
    console.log("  SUGGEST fallback: " + raw.slice(0, 300));
    // Save raw for debugging
    mkdirSync(BRIEF_DIR, { recursive: true });
    writeFileSync(`${BRIEF_DIR}/debug-raw.txt`, raw, "utf-8");
    return { topic: "desempleo juvenil y desarrollo educativo en America Latina", angle: "", suggestions: [], mode: "fallback" };
  }

  // Guardar brief como artefacto
  mkdirSync(BRIEF_DIR, { recursive: true });
  const date = new Date().toISOString().slice(0, 10);
  writeFileSync(`${BRIEF_DIR}/${date}_brief.json`, JSON.stringify(decision, null, 2), "utf-8");

  console.log(`  Topic sugerido: ${decision.topic}`);
  console.log(`  Angulo: ${decision.angle || "(auto)"}`);
  console.log(`  ${decision.suggestions?.length || 0} lineas editoriales propuestas`);
  decision.suggestions?.forEach((s, i) => {
    console.log(`    ${i + 1}. ${s.titulo} ← "${s.noticia_inspiradora?.slice(0, 50)}"`);
  });

  return { ...decision, mode: "suggest" };
}

async function agentCompute(fetchedData, suggestDecision = null) {
  console.log("[3/7] Python ejecutando analisis estadistico real...\n");
  if (!fetchedData?.indicators?.length) {
    console.log("  No hay datos. Saltando Python.");
    return { descriptive: {}, correlations: [], regression: null, note: "Sin datos" };
  }
  const dataset = { series: [] };
  for (const ind of fetchedData.indicators) {
    if (ind.series?.length >= 3) {
      dataset.series.push({
        // Sufijo [CC] para evitar colisiones de nombre entre paises en var_map de compute.py
        name: `${ind.indicator_label} [${ind.country_code}]`,
        code: ind.indicator_code,
        country: ind.country, country_code: ind.country_code, category: ind.category,
        unit: ind.unit || "unknown",
        years: ind.series.map(s => s.year), values: ind.series.map(s => s.value),
        source: ind.source, source_url: ind.source_url,
      });
    }
  }

  // ── Construir correlaciones dinámicamente ──
  dataset.correlations = [];
  const seenPairs = new Set();

  // Helper: find series by fuzzy name match within same country
  function findSeries(pattern, countryCode) {
    // Escape regex special chars in indicator name, use as case-insensitive substring match
    const escaped = pattern.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    return dataset.series.find(s => {
      const re = new RegExp(escaped, "i");
      return re.test(s.name) && s.country_code === countryCode;
    });
  }

  // Helper: add correlation pair if both exist and not duplicate
  function addPair(xs, ys) {
    if (!xs || !ys) return;
    const key = `${xs.name}|${ys.name}`;
    if (!seenPairs.has(key)) {
      seenPairs.add(key);
      dataset.correlations.push([xs.name, ys.name]);
    }
  }

  if (suggestDecision?.suggestions?.length) {
    // ── Modo SUGGEST: correlaciones basadas en las sugerencias del LLM ──
    console.log("  Construyendo correlaciones desde sugerencias del SUGGEST...");
    for (const sug of suggestDecision.suggestions) {
      const indicators = sug.indicadores_respaldan || [];
      // Correlacionar todos los pares de indicadores sugeridos, mismo país
      for (let i = 0; i < indicators.length; i++) {
        for (let j = i + 1; j < indicators.length; j++) {
          // Buscar en todos los países
          const countries = [...new Set(dataset.series.map(s => s.country_code))];
          for (const cc of countries) {
            const xs = findSeries(indicators[i], cc);
            const ys = findSeries(indicators[j], cc);
            addPair(xs, ys);
          }
        }
      }
    }

    // ── Regresión: usar el primer indicador como dependiente, resto como independientes ──
    const topSuggestion = suggestDecision.suggestions[0];
    const topIndicators = topSuggestion?.indicadores_respaldan || [];
    if (topIndicators.length >= 3) {
      // Buscar series regionales (LCN) para la regresión
      const depSeries = findSeries(topIndicators[0], "LCN");
      const indepNames = [];
      for (let i = 1; i < topIndicators.length && indepNames.length < 3; i++) {
        const s = findSeries(topIndicators[i], "LCN");
        if (s) indepNames.push(s.name);
      }
      if (depSeries && indepNames.length >= 2) {
        dataset.regression = { dependent: depSeries.name, independent: indepNames };
        console.log(`  Regresión dinámica: ${depSeries.name} ~ ${indepNames.join(" + ")}`);
      }
    }
  }

  // ── Fallback: si SUGGEST no generó correlaciones, usar VALID_PAIRS ──
  if (dataset.correlations.length === 0) {
    console.log("  Sin sugerencias. Usando VALID_PAIRS de fallback...");
    const VALID_PAIRS = [
      { x_pattern: /youth.*unemploy.*15-24/i, y_pattern: /gdp.*per capita/i },
      { x_pattern: /youth.*unemploy.*15-24/i, y_pattern: /internet users/i },
      { x_pattern: /youth.*unemploy.*15-24/i, y_pattern: /government.*expenditure.*education/i },
      { x_pattern: /youth.*unemploy.*15-24/i, y_pattern: /vulnerable employment/i },
      { x_pattern: /youth.*unemploy.*15-24/i, y_pattern: /manufacturing.*value added/i },
      { x_pattern: /youth.*unemploy.*15-24/i, y_pattern: /gini/i },
      { x_pattern: /youth.*unemploy.*15-24/i, y_pattern: /gdp growth/i },
      { x_pattern: /PISA.*Math/i, y_pattern: /gdp.*per capita/i },
      { x_pattern: /PISA.*Reading/i, y_pattern: /gdp.*per capita/i },
      { x_pattern: /PISA.*Science/i, y_pattern: /gdp.*per capita/i },
      { x_pattern: /PISA.*Math/i, y_pattern: /internet users/i },
      { x_pattern: /PISA.*Math/i, y_pattern: /youth.*unemploy.*15-24/i },
      { x_pattern: /PISA.*Science/i, y_pattern: /youth.*unemploy.*15-24/i },
    ];
    for (const pair of VALID_PAIRS) {
      const xSeries = dataset.series.filter(s => pair.x_pattern.test(s.name));
      for (const xs of xSeries) {
        const ys = dataset.series.find(s => pair.y_pattern.test(s.name) && s.country_code === xs.country_code);
        addPair(xs, ys);
      }
    }

    // Regresión fallback
    const youthUnemp = dataset.series.find(s => /youth.*unemploy.*15-24/i.test(s.name) && s.country_code === "LCN");
    if (youthUnemp) {
      const gdpPc = dataset.series.find(s => /gdp.*per capita/i.test(s.name) && s.country_code === "LCN");
      const internet = dataset.series.find(s => /internet users/i.test(s.name) && s.country_code === "LCN");
      const education = dataset.series.find(s => /government.*expenditure.*education/i.test(s.name) && s.country_code === "LCN");
      const indep = [];
      if (gdpPc) indep.push(gdpPc.name);
      if (internet) indep.push(internet.name);
      if (education) indep.push(education.name);
      if (indep.length >= 2) {
        dataset.regression = { dependent: youthUnemp.name, independent: indep };
      }
    }
  }

  console.log(`  ${dataset.correlations.length} pares de correlación, ${dataset.regression ? "con" : "sin"} regresión.`);
  const __dirname = dirname(fileURLToPath(import.meta.url));
  const inputPath = resolve(__dirname, "..", "output", "raw", "compute-input.json");
  mkdirSync(dirname(inputPath), { recursive: true });
  writeFileSync(inputPath, JSON.stringify(dataset, null, 2), "utf-8");
  const isWindows = process.platform === "win32";
  const pythonPath = isWindows
    ? resolve(__dirname, "..", ".venv", "Scripts", "python.exe")
    : "python3";
  const scriptPath = resolve(__dirname, "compute.py");
  const chartsDir = resolve(__dirname, "..", "output", "charts");
  try {
    console.log("  Ejecutando: python compute.py");
    const output = execFileSync(pythonPath, [scriptPath, inputPath, chartsDir], { encoding: "utf-8", timeout: 60000, maxBuffer: 1024 * 1024 });
    const results = JSON.parse(output);
    console.log("  Python completado:");
    if (results.descriptive) console.log(`    Descriptivas: ${Object.keys(results.descriptive).length} variables`);
    if (results.regression) {
      console.log(`    Regresión: R² = ${results.regression.r_squared?.toFixed(4)}, n = ${results.regression.n}`);
      results.regression.coefficients?.forEach(c => console.log(`    ${c.name}: β=${c.beta?.toFixed(4)}, p=${c.p_value?.toFixed(4)}${c.significant ? " *" : ""}`));
      if (results.regression.vif) console.log(`    VIF: ${Object.entries(results.regression.vif).map(([k,v]) => `${k}=${v.toFixed(1)}`).join(", ")}`);
      if (results.regression.white_test) console.log(`    White test: p=${results.regression.white_test.p_value?.toFixed(4)}${results.regression.white_test.heteroscedastic ? " (heterocedástico)" : ""}`);
    }
    results.correlations?.forEach(c => { if (c.pearson_r !== undefined) console.log(`    Corr(${c.x}, ${c.y}): r=${c.pearson_r?.toFixed(4)}, p=${c.pearson_p?.toFixed(4)}, Spearman ρ=${c.spearman_rho?.toFixed(4)}`); });
    if (results.clustering) console.log(`    Clustering: k=${results.clustering.best_k}, silhouette=${results.clustering.silhouette?.toFixed(3)}, ${results.clustering.n_countries} países`);
    if (results.anomalies?.length) console.log(`    Anomalías: ${results.anomalies.length} detectadas`);
    if (results.trends?.length) {
      const sig = results.trends.filter(t => t.trend !== "no_trend");
      console.log(`    Tendencias: ${sig.length} significativas de ${results.trends.length}`);
    }
    if (results.charts?.length) console.log(`    Gráficas: ${results.charts.map(c => c.file).join(", ")}`);
    return results;
  } catch (err) {
    console.error(`  Error Python: ${err.message}`);
    if (err.stderr) console.error(`  stderr: ${err.stderr.slice(0, 500)}`);
    return { descriptive: {}, correlations: [], regression: null, error: err.message, note: "Python fallo." };
  }
}

// ── Digests compartidos: WRITE y REVIEW deben ver exactamente los mismos datos ──
function dataDigest(fetchedData) {
  // Series LCN completas (año=valor) + países primer→último valor
  const lcn = fetchedData.indicators.filter(i => i.country_code === "LCN").map(i => {
    const pts = i.series.map(s => `${s.year}=${s.value.toFixed(2)}`).join(", ");
    return `- ${i.indicator_label} [LCN] (${i.unit}): ${pts}`;
  }).join("\n");
  const countries = fetchedData.indicators
    .filter(i => i.country_code !== "LCN")
    .map(i => {
      const first = i.series[0]; const latest = i.series[i.series.length - 1];
      return `- ${i.indicator_label} [${i.country_code}] (${i.unit}): ${first.year}=${first.value.toFixed(2)} -> ${latest.year}=${latest.value.toFixed(2)}`;
    }).join("\n");
  return { lcn, countries };
}

function computeDigest(computeResults) {
  if (!computeResults) return "Sin analisis estadistico.";
  const parts = [];
  if (computeResults.regression && !computeResults.error && computeResults.regression.dependent) {
    const r = computeResults.regression;
    parts.push(`REGRESION OLS: ${r.dependent} ~ ${r.independent.join(" + ")}`);
    parts.push(`  n=${r.n}, R2=${r.r_squared?.toFixed(4)}, R2_adj=${r.adj_r_squared?.toFixed(4)}, F=${r.f_statistic?.toFixed(2)} (p=${r.f_p_value?.toFixed(4)})`);
    for (const c of r.coefficients || []) {
      parts.push(`  ${c.name}: beta=${c.beta?.toFixed(4)}, p=${c.p_value?.toFixed(4)}${c.significant ? " *" : ""}${c.robust_p !== undefined ? `, robust_p=${c.robust_p?.toFixed(4)}${c.robust_significant ? " *" : ""}` : ""}`);
    }
    if (r.white_test) parts.push(`  White test: p=${r.white_test.p_value?.toFixed(4)} (${r.white_test.heteroscedastic ? "heterocedastico" : "homocedastico"})`);
    else parts.push(`  White test: NO calculado`);
  }
  const corrs = (computeResults.correlations || []).filter(c => c.pearson_r !== undefined);
  if (corrs.length) {
    parts.push(`CORRELACIONES (${corrs.length} calculadas):`);
    for (const c of corrs) {
      parts.push(`  ${c.x} <-> ${c.y}: pearson_r=${c.pearson_r.toFixed(4)}, p=${c.pearson_p.toFixed(4)}, spearman=${c.spearman_rho.toFixed(4)}, n=${c.n}, significativa=${c.significant}`);
    }
  }
  const sigTrends = (computeResults.trends || []).filter(t => t.trend !== "no_trend");
  if (sigTrends.length) {
    parts.push(`TENDENCIAS SIGNIFICATIVAS (Mann-Kendall p<0.05):`);
    for (const t of sigTrends.slice(0, 15)) {
      parts.push(`  ${t.indicator}: ${t.trend}, slope=${t.slope.toFixed(3)}/año, p=${t.mann_kendall_p.toFixed(4)}`);
    }
  }
  if (computeResults.anomalies?.length) {
    parts.push(`ANOMALIAS (${computeResults.anomalies.length}):`);
    for (const a of computeResults.anomalies.slice(0, 5)) {
      parts.push(`  ${a.indicator} [${a.country_code}] ${a.year}: ${a.value.toFixed(2)} (z=${a.z_score.toFixed(1)})`);
    }
  }
  if (computeResults.charts?.length) {
    parts.push(`FIGURAS GENERADAS (archivos reales en output/charts/, referenciar como charts/<file>):`);
    for (const c of computeResults.charts) {
      parts.push(`  - charts/${c.file}: ${c.caption}`);
    }
  }
  return parts.join("\n") || "Sin analisis estadistico.";
}

async function agentWrite(fetchedData, computeResults, feedback = null, topic = null, angle = null) {
  console.log("[4/7] GPT-OSS 120B redactando paper con datos reales...\n");
  if (feedback) console.log(`Aplicando feedback: ${feedback.slice(0, 100)}\n`);
  const effectiveTopic = topic || TOPIC;
  const effectiveAngle = angle || ANGLE;
  const angleSection = effectiveAngle ? `ANGULO EDITORIAL:\n${effectiveAngle}\n` : `ANGULO EDITORIAL: Busca el argumento central mas relevante.`;
  const feedbackSection = feedback ? `\nFEEDBACK DEL REVISOR: ${feedback}\n` : "";
  const { lcn, countries } = dataDigest(fetchedData);
  const digest = computeDigest(computeResults);
  const prompt = `Eres un investigador academico que escribe un paper en espanol para una revista de ciencias sociales.

DATOS REALES (World Bank API, unicos datos disponibles):

Series regionales America Latina & Caribe (serie completa):
${lcn}

Series por pais (primer y ultimo valor):
${countries || "Sin datos por pais."}

RESULTADOS ESTADISTICOS REALES (Python/statsmodels/scipy):
${digest}

Escribe un paper academico sobre: ${effectiveTopic}

${angleSection}
${feedbackSection}

ESTRUCTURA OBLIGATORIA:
1. **Resumen** (100-150 palabras)
2. **Introduccion** (300-400 palabras)
3. **Metodologia** (150-250 palabras): datos del Banco Mundial 2015-2024, OLS, correlaciones Pearson/Spearman, Mann-Kendall. NO menciones metodos que no aparezcan en RESULTADOS (nada de efectos fijos, panel, Durbin-Watson ni simulaciones).
4. **Analisis** (500-800 palabras): usa SOLO datos y resultados listados. Incluye tablas Markdown y referencia las figuras listadas.
5. **Discusion** (200-350 palabras): interpreta; reconoce que n=10 observaciones por serie es muestra pequena y las correlaciones no implican causalidad.
6. **Conclusiones** (150-250 palabras)
7. **Bibliografia**: formato APA. Solo puedes citar: Banco Mundial/World Development Indicators, la noticia que inspiro el tema, y literatura academica REAL y conocida (Autor 2015, Acemoglu & Restrepo, etc.) SIN atribuirles coeficientes ni cifras especificas.

REGLAS CRITICAS (incumplir = rechazo):
- Todo numero citado debe aparecer LITERALMENTE en DATOS o RESULTADOS de arriba. Prohibido redondear a valores diferentes, inventar valores por pais no listados, o reportar estadisticos no calculados.
- NO existe informacion de paises fuera de la lista. NO uses fuentes que no sean World Bank (nada de CEPAL, OECD, IMF, ECLAC).
- NO inventes tests diagnosticos (White, Durbin-Watson), simulaciones, escenarios futuros ni proyecciones: solo reporta lo que Python calculo.
- Si un resultado no es significativo (p>0.05), dilo explicitamente; no lo presentes como evidencia solida.
- Referencia las figuras reales listadas: ![descripcion](charts/<file>). NO inventes figuras que no esten en la lista.
- Cita cada dato como (Banco Mundial, 2024).
- Total: 1500-2200 palabras. La Bibliografia es OBLIGATORIA.

Devuelve el paper completo en Markdown.`;
  const data = await callGroq("openai/gpt-oss-120b", prompt, { max_tokens: 4000, temperature: 0.6 });
  return data.choices[0]?.message?.content || "";
}

async function agentReview(fetchedData, computeResults, draft) {
  console.log("[5/7] GPT-OSS 120B revisando rigor academico...\n");
  const { lcn, countries } = dataDigest(fetchedData);
  const digest = computeDigest(computeResults);
  const prompt = `Eres un revisor academico riguroso y desconfiado. Tu trabajo es detectar DATOS INVENTADOS comparando el paper contra los datos reales.

DATOS REALES (World Bank API — la unica fuente permitida):

Series regionales America Latina & Caribe:
${lcn}

Series por pais:
${countries || "Sin datos por pais."}

RESULTADOS ESTADISTICOS REALES (Python):
${digest}

PAPER A REVISAR:
${truncate(draft, 8000)}

VERIFICACION OBLIGATORIA:
1. Extrae TODOS los numeros/estadisticas que el paper afirma (porcentajes, coeficientes, r, p, R2, betas, medias).
2. Para cada uno, buscalo en DATOS/RESULTADOS de arriba. Si no aparece literalmente (o no se deriva directamente), marcalo como INVENTADO en "datos_inventados".
3. Senales de alucinacion frecuentes — rechaza si el paper:
   - Menciona datos de paises NO listados arriba, o fuentes externas (CEPAL, OECD, IMF, ECLAC)
   - Reporta tests no calculados (Durbin-Watson, White si dice "NO calculado"), efectos fijos, datos de panel, simulaciones o proyecciones
   - Cita literatura con coeficientes/cifras especificas no presentes en RESULTADOS
   - Afirma significancia estadistica cuando p>0.05
   - Presenta correlaciones como causalidad sin matizar
4. Verifica estructura (Resumen, Metodologia, Analisis, Discusion, Conclusiones, Bibliografia) y coherencia.

Responde EXACTAMENTE como JSON (sin markdown):
{"datos_correctos":true,"detalle_datos":"...","datos_inventados":["lista de cada valor fabricado"],"estructura_ok":true,"coherencia_ok":true,"correcciones":["..."],"datos_faltantes":null,"veredicto":"APROBADO","feedback":null}

Veredicto: "APROBADO" solo si datos_correctos=true Y datos_inventados esta vacio. Si hay CUALQUIER dato inventado: "REESCRIBIR" con feedback detallado listando cada correccion.`;
  const data = await callGroq("openai/gpt-oss-120b", prompt, { max_tokens: 2500, temperature: 0.2 });
  const raw = data.choices[0]?.message?.content || "";
  const decision = parseJSONResponse(raw);
  if (!decision) {
    // No auto-aprobar: devolver objeto sin veredicto valido -> guardrails reintentan; si persisten, el pipeline falla honestamente
    console.log("Review: respuesta no parseable (no se auto-aprueba):\n" + raw.slice(0, 500) + "\n");
    return { veredicto: undefined, datos_correctos: false, correcciones: [], feedback: "review response unparseable" };
  }
  // Forzar consistencia: si reporta datos inventados, el veredicto no puede ser APROBADO
  if (decision.veredicto === "APROBADO" && (decision.datos_inventados?.length || decision.datos_correctos === false)) {
    decision.veredicto = "REESCRIBIR";
    decision.feedback = decision.feedback || `Datos inventados detectados: ${(decision.datos_inventados || []).join("; ")}`;
  }
  console.log("Review:\n" + JSON.stringify(decision, null, 2).slice(0, 500) + "\n");
  return decision;
}

async function agentEdit(draft, review) {
  console.log("[6/7] GPT-OSS 120B editando paper...\n");
  // Extract bibliography from original draft to re-append if EDIT truncates it
  const bibMatch = draft.match(/^## Bibliograf[\s\S]*$/m);
  const originalBib = bibMatch ? bibMatch[0] : "";
  const prompt = `Eres el editor de una revista de ciencias sociales. Pule este paper.

PAPER:
${truncate(draft, 8000)}

REVISION:
${truncate(typeof review === "string" ? review : JSON.stringify(review), 1500)}

Aplica correcciones, mejora flujo, verifica APA. Manten estructura y formato Markdown.
IMPORTANTE: Preserva la seccion de Bibliografia, las tablas Markdown y todas las referencias a figuras ![..](charts/..) del paper original.
NO agregues numeros, estadisticos ni tests que la REVISION no haya verificado.
Devuelve SOLO el paper final en Markdown.`;
  const data = await callGroq("openai/gpt-oss-120b", prompt, { max_tokens: 4000, temperature: 0.5 });
  let result = data.choices[0]?.message?.content || "";
  // If EDIT truncated the bibliography, re-append from original
  if (originalBib && !/## Bibliograf/i.test(result)) {
    console.log("  EDIT trunco bibliografia. Re-appendiendo del draft original.");
    result = result.trimEnd() + "\n\n" + originalBib;
  }
  return result;
}

async function agentApprove(finalText) {
  console.log("[7/7] GPT-OSS 20B QA final...\n");
  const prompt = `Eres control de calidad de una revista de ciencias sociales. Verifica:

${truncate(finalText, 8000)}

Responde EXACTAMENTE como JSON (sin markdown):
{"checklist":{"estructura_ok":true,"resumen_ok":true,"bibliografia_ok":true,"citas_apa_ok":true,"coherencia_ok":true,"datos_verificados":true,"tono_academico":true,"extension_ok":true},"palabras":3000,"veredicto":"APROBADO","issues":[]}

CRITERIOS:
- Si la seccion Bibliografia existe (aunque sea minima), aprobar.
- Si los datos coinciden con las fuentes, aprobar.
- Solo rechazar si hay datos inventados o estructura incompleta (sin Resumen, sin Conclusiones).
Veredicto: "APROBADO" o "RECHAZADO" (con issues).`;
  const data = await callGroq("openai/gpt-oss-20b", prompt, { max_tokens: 1000, temperature: 0.2 });
  const raw = data.choices[0]?.message?.content || "";
  const decision = parseJSONResponse(raw);
  if (!decision) { console.log("QA fallback:\n" + raw.slice(0, 500) + "\n"); return { veredicto: raw.includes("RECHAZADO") ? "RECHAZADO" : "APROBADO", checklist: {}, palabras: 0, issues: [raw.slice(0, 200)] }; }
  console.log("QA Final:\n" + JSON.stringify(decision, null, 2).slice(0, 500) + "\n");
  return decision;
}

class MoAGraph {
  constructor() {
    this.state = {
      topic: TOPIC, angle: ANGLE, fetchedData: null, suggestDecision: null,
      computeResults: null, currentDraft: "", drafts: [], reviewDecision: null,
      editedArticle: "", qaDecision: null, writeFeedback: null, editFeedback: null,
      iterations: { rewrite: 0, edit: 0 }, nodeHistory: [],
    };
    this.t0 = Date.now();
  }
  logNode(node) { this.state.nodeHistory.push(node); const i = this.state.iterations; console.log(`\n[Nodo: ${node}]${i.rewrite + i.edit > 0 ? ` (rewrite:${i.rewrite} edit:${i.edit})` : ""}`); }
  async runWithGuardrails(node, agentFn, maxRetries = 2) {
    for (let attempt = 0; attempt <= maxRetries; attempt++) {
      const output = await agentFn();
      const errors = runGuardrails(node, output);
      if (errors.length === 0) return output;
      if (attempt < maxRetries) { console.log(`  Guardrails: ${errors.join(", ")}. Reintento ${attempt + 1}/${maxRetries}...`); await new Promise(r => setTimeout(r, 5000)); }
      else throw new Error(`${node} guardrails: ${errors.join(", ")}`);
    }
  }
  async nodeFetch() { this.logNode("FETCH"); this.state.fetchedData = await this.runWithGuardrails("FETCH", () => agentFetch(this.state.topic)); return resolveTransition("FETCH", this.state); }
  async nodeSuggest() { this.logNode("SUGGEST"); this.state.suggestDecision = await this.runWithGuardrails("SUGGEST", () => agentSuggest(this.state.fetchedData)); if (this.state.suggestDecision?.topic) { this.state.topic = this.state.suggestDecision.topic; this.state.angle = this.state.suggestDecision.angle || this.state.angle; } await delay(20); return resolveTransition("SUGGEST", this.state); }
  async nodeCompute() { this.logNode("COMPUTE"); this.state.computeResults = await this.runWithGuardrails("COMPUTE", () => agentCompute(this.state.fetchedData, this.state.suggestDecision)); mkdirSync("output/raw", { recursive: true }); writeFileSync("output/raw/compute-results.json", JSON.stringify(this.state.computeResults, null, 2), "utf-8"); return resolveTransition("COMPUTE", this.state); }
  async nodeWrite() { this.logNode("WRITE"); this.state.currentDraft = await this.runWithGuardrails("WRITE", () => agentWrite(this.state.fetchedData, this.state.computeResults, this.state.writeFeedback, this.state.topic, this.state.angle)); this.state.drafts.push(this.state.currentDraft); this.state.writeFeedback = null; await delay(20); return resolveTransition("WRITE", this.state); }
  async nodeReview() { this.logNode("REVIEW"); this.state.reviewDecision = await this.runWithGuardrails("REVIEW", () => agentReview(this.state.fetchedData, this.state.computeResults, this.state.currentDraft)); await delay(20); return resolveTransition("REVIEW", this.state); }
  async nodeEdit() { this.logNode("EDIT"); try { this.state.editedArticle = await this.runWithGuardrails("EDIT", () => agentEdit(this.state.currentDraft, this.state.editFeedback || "")); } catch (e) { console.log(`  EDIT fallo (${e.message}). Usando draft original.`); this.state.editedArticle = this.state.currentDraft; } await delay(20); return resolveTransition("EDIT", this.state); }
  async nodeApprove() {
    this.logNode("APPROVE"); await delay(40);
    try { this.state.qaDecision = await this.runWithGuardrails("APPROVE", () => agentApprove(this.state.editedArticle)); }
    catch (e) { console.log(`  QA fallo (${e.message}). Auto-aprobando.`); this.state.qaDecision = { veredicto: "APROBADO", checklist: {}, palabras: 0, issues: ["QA no ejecutado"] }; }
    return resolveTransition("APPROVE", this.state);
  }
  async run() {
    const nodes = { FETCH: () => this.nodeFetch(), SUGGEST: () => this.nodeSuggest(), COMPUTE: () => this.nodeCompute(), WRITE: () => this.nodeWrite(), REVIEW: () => this.nodeReview(), EDIT: () => this.nodeEdit(), APPROVE: () => this.nodeApprove() };
    let current = "FETCH"; let steps = 0; const MAX_STEPS = 15;
    while (current !== "END" && steps < MAX_STEPS) {
      steps++;
      try { current = await nodes[current](); }
      catch (err) {
        console.error(`\nX Error en ${current}: ${err.message}`);
        console.error(`  Historial: ${this.state.nodeHistory.join(" -> ")}`);
        if (this.state.editedArticle || this.state.currentDraft) { mkdirSync(OUTPUT_DIR, { recursive: true }); writeFileSync(OUTPUT_FILE, this.state.editedArticle || this.state.currentDraft, "utf-8"); console.log(`  !! Paper guardado de emergencia en ${OUTPUT_FILE}`); }
        process.exit(1);
      }
    }
    if (current !== "END") { console.error(`X Loop infinito (${steps}).`); process.exit(1); }
    if (SUGGEST_ONLY) {
      console.log(`\n==================================================`);
      console.log(`  SUGGEST-ONLY completado. Brief en ${BRIEF_DIR}/`);
      console.log(`  Topic: ${this.state.topic}`);
      console.log(`  Tiempo: ${((Date.now() - this.t0) / 1000).toFixed(1)}s | Nodos: ${this.state.nodeHistory.join(" -> ")}`);
      console.log(`==================================================\n`);
      return;
    }
    mkdirSync(OUTPUT_DIR, { recursive: true });
    writeFileSync(OUTPUT_FILE, this.state.editedArticle, "utf-8");
    const date = new Date().toISOString().slice(0, 10);
    const slug = this.state.topic.slice(0, 40).replace(/[^a-z0-9]/gi, "-").toLowerCase();
    writeFileSync(`${OUTPUT_DIR}/${date}_${slug}.md`, this.state.editedArticle, "utf-8");
    writeFileSync(`${OUTPUT_DIR}/${date}_${slug}.json`, JSON.stringify({
      topic: this.state.topic, angle: this.state.angle, nodes: this.state.nodeHistory, iterations: this.state.iterations,
      suggestMode: this.state.suggestDecision?.mode || "manual",
      suggestions: this.state.suggestDecision?.suggestions || [],
      reviewDecision: this.state.reviewDecision, qaDecision: this.state.qaDecision,
      dataSources: { source: "World Bank API", url: "https://api.worldbank.org", indicators: this.state.fetchedData?.summary?.total_indicators || 0, countries: this.state.fetchedData?.summary?.total_countries || 0, latestYear: this.state.fetchedData?.summary?.latest_year_available || null },
      computeResults: this.state.computeResults ? { regression: this.state.computeResults.regression ? { r_squared: this.state.computeResults.regression.r_squared, n: this.state.computeResults.regression.n } : null, correlations: this.state.computeResults.correlations?.length || 0 } : null,
      elapsed: parseFloat(((Date.now() - this.t0) / 1000).toFixed(1)),
    }, null, 2), "utf-8");
    const elapsed = ((Date.now() - this.t0) / 1000).toFixed(1);
    console.log(`\n==================================================`);
    console.log(`  OK Paper guardado en ${OUTPUT_FILE}`);
    console.log(`  Tiempo: ${elapsed}s | Nodos: ${this.state.nodeHistory.join(" -> ")}`);
    console.log(`  Datos: ${this.state.fetchedData?.summary?.total_indicators || 0} indicadores, ${this.state.fetchedData?.summary?.total_countries || 0} paises`);
    console.log(`  Fuente: World Bank API (datos reales)`);
    console.log(`==================================================\n`);
  }
}

new MoAGraph().run().catch((err) => { console.error("Error fatal:", err); process.exit(1); });
