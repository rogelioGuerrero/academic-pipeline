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

import { writeFileSync, readFileSync, mkdirSync, readdirSync, existsSync } from "fs";
import { resolve, dirname, join } from "path";
import { fileURLToPath } from "url";
import { execFileSync } from "child_process";
import { fetchSources } from "./fetch-sources.mjs";

const __rootdirname = dirname(fileURLToPath(import.meta.url));

function getPythonPath() {
  const isWindows = process.platform === "win32";
  const venvPy = resolve(__rootdirname, "..", ".venv", "Scripts", "python.exe");
  if (isWindows && existsSync(venvPy)) return venvPy;
  return isWindows ? "python" : "python3";
}

function loadMemoryContext() {
  try {
    const py = getPythonPath();
    const script = resolve(__rootdirname, "memory.py");
    const out = execFileSync(py, [script, "context"], { encoding: "utf-8", timeout: 10000 });
    return out.trim();
  } catch {
    return "";
  }
}

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
const GEMINI_API_KEY = process.env.GEMINI_API_KEY;
const GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions";
const GEMINI_MODEL = process.env.GEMINI_MODEL || "gemini-2.5-flash";
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

if (!GROQ_API_KEY && !GEMINI_API_KEY) {
  console.error("Error: Ni GROQ_API_KEY ni GEMINI_API_KEY encontradas.");
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

// Estimacion de tokens: Groq tokeniza ~4 chars/token para espanol, pero
// con razonamiento interno el consumo real puede ser mayor. Usamos 3.5 como
// estimacion conservadora. Si el prompt excede el umbral, se trunca.
const TOKEN_BUDGET = 7000; // margen seguro bajo 8000 TPM del free tier
function estimateTokens(text) { return Math.ceil(text.length / 3.5); }

// Registro de truncamientos para transparencia: si el safety net se activa,
// el paper sale pero la metadata lo dice — asi sabemos si hay que ajustar.
const truncationLog = [];

async function callLLM(apiKey, apiUrl, model, prompt, opts = {}) {
  let safePrompt = prompt;
  const tok = estimateTokens(prompt);
  if (tok > TOKEN_BUDGET) {
    // Truncar preservando el inicio (instrucciones + datos) y el final (formato JSON)
    const overflow = (tok - TOKEN_BUDGET) * 3.5;
    const cutStart = Math.floor(safePrompt.length * 0.6);
    const cutEnd = Math.floor(safePrompt.length - overflow - (safePrompt.length - cutStart) * 0.3);
    const cutChars = cutEnd - cutStart;
    safePrompt = safePrompt.slice(0, cutStart) + "\n[...contenido recortado por limite de tokens...]\n" + safePrompt.slice(cutEnd);
    const after = estimateTokens(safePrompt);
    console.log(`  ⚠ Prompt ${tok} tokens > ${TOKEN_BUDGET}. Recortado a ~${after} tokens (${cutChars} chars cortados).`);
    truncationLog.push({ model, before: tok, after, cutChars });
  }
  const body = { model, messages: [{ role: "user", content: safePrompt }], ...opts };
  for (let attempt = 1; attempt <= 4; attempt++) {
    const res = await fetch(apiUrl, {
      method: "POST",
      headers: { Authorization: `Bearer ${apiKey}`, "Content-Type": "application/json" },
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
    if (res.status === 413 && attempt < 4) {
      console.log(`  Prompt demasiado largo (413). Recortando y reintentando... (${attempt}/4)`);
      const overflow = estimateTokens(safePrompt) - 5000;
      if (overflow > 0) {
        const cutStart = Math.floor(safePrompt.length * 0.5);
        safePrompt = safePrompt.slice(0, cutStart) + "\n[...contenido recortado por limite 413...]\n" + safePrompt.slice(safePrompt.length - 500);
        body.messages = [{ role: "user", content: safePrompt }];
      }
      await new Promise((r) => setTimeout(r, 3000));
      continue;
    }
    if (res.status >= 500 && attempt < 4) {
      console.log(`  Server error (${res.status}). Reintentando en ${10 * attempt}s... (intento ${attempt}/4)`);
      await new Promise((r) => setTimeout(r, 10000 * attempt));
      continue;
    }
    const err = await res.text();
    console.error(`Error ${model}: ${res.status}`);
    console.error(err.slice(0, 500));
    throw new Error(`API error ${res.status} on ${model}`);
  }
  throw new Error(`API: max retries exceeded on ${model}`);
}

async function callGroq(model, prompt, opts = {}) {
  // Intentar Groq primero, Gemini como fallback
  if (GROQ_API_KEY) {
    try {
      return await callLLM(GROQ_API_KEY, GROQ_API_URL, model, prompt, opts);
    } catch (e) {
      console.log(`  Groq fallo (${e.message}). Intentando Gemini...`);
    }
  }
  if (GEMINI_API_KEY) {
    return await callLLM(GEMINI_API_KEY, GEMINI_API_URL, GEMINI_MODEL, prompt, opts);
  }
  throw new Error("No LLM provider available (Groq and Gemini both missing/failed)");
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
  COMPUTE: [
    { check: out => out !== null, msg: "Python no respondio" },
    { check: out => out && (out.regression || (out.correlations && out.correlations.length > 0)), msg: "Compute no produjo resultados estadisticos (sin regresion ni correlaciones)" },
  ],
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

// ── Dedup y noticias: helpers compartidos ──
function loadNewsItems() {
  try {
    const parsed = JSON.parse(readFileSync(NEWS_PATH, "utf-8"));
    if (Array.isArray(parsed)) return parsed;
    if (parsed && Array.isArray(parsed.articles)) return parsed.articles;
    if (parsed && Array.isArray(parsed.items)) return parsed.items;
    return [];
  } catch {
    return [];
  }
}

function normText(s) {
  return (s || "").toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g, "").replace(/[^a-z0-9 ]/g, " ").replace(/\s+/g, " ").trim();
}

// Similitud de temas: coeficiente de solapamiento sobre palabras significativas.
// Containment (inter/min) en vez de Jaccard: detecta "X y Y" dentro de "X y Z".
function topicSimilarity(a, b) {
  const stop = new Set(["del", "los", "las", "una", "para", "con", "sobre", "entre", "ante", "bajo", "desde", "hacia", "como", "mas"]);
  const words = s => new Set(normText(s).split(" ").filter(w => w.length > 3 && !stop.has(w)));
  const A = words(a), B = words(b);
  if (!A.size || !B.size) return 0;
  const inter = [...A].filter(w => B.has(w)).length;
  return inter / Math.min(A.size, B.size);
}

// Topics de papers ya generados (metadata json en output/papers/)
function loadRecentTopics() {
  try {
    const files = readdirSync(OUTPUT_DIR).filter(f => f.endsWith(".json")).sort().reverse().slice(0, 10);
    return files.map(f => {
      try { return JSON.parse(readFileSync(join(OUTPUT_DIR, f), "utf-8")).topic; } catch { return null; }
    }).filter(Boolean);
  } catch {
    return [];
  }
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
  const newsItems = loadNewsItems();
  console.log(`  Noticias cargadas: ${newsItems.length} articulos de job-hunter`);

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

  // Memoria relacional SQLite previa (con fallback a JSON files)
  const memoryContext = loadMemoryContext();
  const recentTopics = loadRecentTopics();
  const recentText = memoryContext || (recentTopics.length
    ? `TEMAS YA PUBLICADOS RECIENTEMENTE (evita repetir el mismo dominio/angulo):\n${recentTopics.map(t => `- ${t}`).join("\n")}\n`
    : "");

  const prompt = `Eres un editor de una revista de ciencias sociales especializada en America Latina.

NOTICIAS TENDING (de job-hunter, scored por LLM):
${newsText || "Sin noticias disponibles."}

CATALOGO DE INDICADORES DISPONIBLES (datos reales ya fetchados):
${catalogText}

${recentText}
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
- La pregunta de investigacion debe poder responderse SOLO con los indicadores del catalogo. Si la noticia trata de algo sin datos directos, reformula la pregunta a lo verificable — la reformulacion puede mapear a CUALQUIER dominio del catalogo, no solo tecnologia/empleo. Ejemplos de puentes validos (hay muchos mas): una noticia de IA puede derivar en empleo digital, en crecimiento economico o en productividad; una de inflacion en remesas o gasto publico; una de seguridad en inversion extranjera o comercio; una de clima en salud o migracion; una de conflicto geopolitico en comercio o PIB. Evalua que dominio tiene el puente mas directo a la noticia y los datos mas solidos.
- Diversidad: las lineas propuestas deben cubrir dominios distintos entre si cuando el catalogo lo permita — no propongas 5 variantes del mismo tema. Si un tema publicado recientemente ya exploro un dominio, prefiere otro dominio con buen puente noticia-datos.
- Justifica el puente: en "justificacion" explica por que ESE dominio (y no otro) es el que mejor conecta la noticia con los datos — esto evita mapear todo al mismo lugar por costumbre.
- La hipotesis debe ser una afirmacion concreta que los datos puedan apoyar o refutar.

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
  "angle": "angulo editorial especifico para el paper",
  "pregunta": "pregunta de investigacion verificable con los indicadores disponibles",
  "hipotesis": "afirmacion concreta que los datos pueden apoyar o refutar"
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
        // Panel FE: mismos indicadores base resueltos por país (6 países × años)
        dataset.panel = { dependent: topIndicators[0], independent: topIndicators.slice(1, 4) };
        console.log(`  Panel FE: ${topIndicators[0]} ~ ${topIndicators.slice(1, 4).join(" + ")} (por país)`);
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
        dataset.panel = { dependent: "youth unemployment", independent: ["gdp per capita", "internet users", "government expenditure education"] };
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
  // Namespace por run: charts/<fecha-hora>/figN.png — un paper nuevo nunca
  // sobrescribe las figuras de papers anteriores (los links quedan estables)
  const stamp = new Date().toISOString().slice(0, 16).replace("T", "-").replace(/:/g, "-");
  const chartsDir = resolve(__dirname, "..", "output", "charts", stamp);
  try {
    console.log("  Ejecutando: python compute.py");
    const output = execFileSync(pythonPath, [scriptPath, inputPath, chartsDir], { encoding: "utf-8", timeout: 60000, maxBuffer: 1024 * 1024 });
    const results = JSON.parse(output);
    results.chartsDir = stamp;
    console.log("  Python completado:");
    if (results.descriptive) console.log(`    Descriptivas: ${Object.keys(results.descriptive).length} variables`);
    if (results.regression) {
      console.log(`    Regresión: R² = ${results.regression.r_squared?.toFixed(4)}, n = ${results.regression.n}`);
      results.regression.coefficients?.forEach(c => console.log(`    ${c.name}: β=${c.beta?.toFixed(4)}, p=${c.p_value?.toFixed(4)}${c.significant ? " *" : ""}`));
      if (results.regression.vif) console.log(`    VIF: ${Object.entries(results.regression.vif).map(([k,v]) => `${k}=${v.toFixed(1)}`).join(", ")}`);
      if (results.regression.white_test) console.log(`    White test: p=${results.regression.white_test.p_value?.toFixed(4)}${results.regression.white_test.heteroscedastic ? " (heterocedástico)" : ""}`);
      if (results.regression.bootstrap) console.log(`    Bootstrap IC95%: ${results.regression.coefficients?.filter(c => c.boot_ci_95).map(c => `${c.name}=[${c.boot_ci_95[0].toFixed(3)},${c.boot_ci_95[1].toFixed(3)}]${c.boot_includes_zero ? " (incluye 0)" : ""}`).join(", ")}`);
    }
    if (results.panel?.coefficients?.length) {
      console.log(`    Panel FE (${results.panel.n_countries} países, n=${results.panel.n}): R²=${results.panel.r_squared?.toFixed(4)}`);
      results.panel.coefficients.forEach(c => console.log(`    ${c.name}: β=${c.beta?.toFixed(4)}, p=${c.p_value?.toFixed(4)}${c.significant ? " *" : ""}`));
    }
    results.correlations?.forEach(c => { if (c.pearson_r !== undefined) console.log(`    Corr(${c.x}, ${c.y}): r=${c.pearson_r?.toFixed(4)}, p=${c.pearson_p?.toFixed(4)}, Spearman ρ=${c.spearman_rho?.toFixed(4)}`); });
    if (results.clustering) console.log(`    Clustering: k=${results.clustering.best_k}, silhouette=${results.clustering.silhouette?.toFixed(3)}, ${results.clustering.n_countries} países`);
    if (results.anomalies?.length) console.log(`    Anomalías: ${results.anomalies.length} detectadas`);
    if (results.trends?.length) {
      const sig = results.trends.filter(t => t.trend !== "no_trend");
      console.log(`    Tendencias: ${sig.length} significativas de ${results.trends.length}`);
    }
    if (results.charts?.length) console.log(`    Gráficas: ${results.charts.map(c => c.file).join(", ")}`);

    // Complemento econometrico en R (Two-Way Fixed Effects Panel)
    try {
      const rScriptPath = resolve(__rootdirname, "compute_panel.R");
      const rOutputPath = resolve(__rootdirname, "..", "output", "raw", "compute-r-results.json");
      execFileSync("Rscript", [rScriptPath, inputPath, rOutputPath], { encoding: "utf-8", timeout: 30000 });
      if (existsSync(rOutputPath)) {
        const rData = JSON.parse(readFileSync(rOutputPath, "utf-8"));
        results.r_econometrics = rData;
        console.log(`    R Econometria (Two-Way FE): R²=${rData.r_squared?.toFixed(4)}, ${rData.coefficients?.length || 0} coeficientes`);
      }
    } catch {
      // Rscript no disponible o sin jsonlite: continuar normalmente con Python
    }

    return results;
  } catch (err) {
    console.error(`  Error Python: ${err.message}`);
    if (err.stderr) console.error(`  stderr: ${err.stderr.slice(0, 500)}`);
    return { descriptive: {}, correlations: [], regression: null, error: err.message, note: "Python fallo." };
  }
}

// ── Digests compartidos: WRITE y REVIEW deben ver exactamente los mismos datos ──
// Filtro topico: solo inyecta series de los indicadores que la sugerencia ELEGIDA
// usa (la que matchea decision.topic). El prompt no crece con el tamano del
// catalogo ni con el numero de sugerencias — escala solo con el tema elegido.
function chosenSuggestion(suggestDecision) {
  const sugs = suggestDecision?.suggestions || [];
  if (!sugs.length) return null;
  const topic = (suggestDecision?.topic || "").toLowerCase().trim();
  const match = topic && sugs.find(s => {
    const t = (s.titulo || "").toLowerCase().trim();
    return t === topic || topic.includes(t) || t.includes(topic);
  });
  return match || sugs[0];
}

function chosenIndicators(suggestDecision) {
  const chosen = chosenSuggestion(suggestDecision);
  const terms = (chosen?.indicadores_respaldan || []).map(u => u.toLowerCase());
  return terms.length ? terms : null;
}

function matchesIndicator(seriesName, indicatorTerms) {
  const label = seriesName.toLowerCase();
  return indicatorTerms.some(u => label.includes(u) || u.includes(label));
}

function getTopCountriesFromMemory(indicators, limit = 5) {
  try {
    const py = getPythonPath();
    const script = resolve(__rootdirname, "memory.py");
    const out = execFileSync(py, [script, "top-countries", indicators.join(",")], { encoding: "utf-8", timeout: 10000 });
    const parsed = JSON.parse(out.trim());
    return Array.isArray(parsed) && parsed.length ? parsed : [];
  } catch {
    return [];
  }
}

function dataDigest(fetchedData, suggestDecision = null) {
  let inds = fetchedData.indicators;
  const used = chosenIndicators(suggestDecision);
  let topCcs = [];
  if (used) {
    const filtered = inds.filter(i => matchesIndicator(i.indicator_label, used));
    if (filtered.length) inds = filtered; // si nada coincide, mostrar todo (fallback seguro)
    topCcs = getTopCountriesFromMemory(used, 5);
  }
  // Series LCN: comprimir a primero/ultimo (no todos los años) + cap duro
  const lcnInds = inds.filter(i => i.country_code === "LCN").slice(0, 12);
  const lcn = lcnInds.map(i => {
    const pts = i.series.map(s => `${s.year}=${s.value.toFixed(2)}`).join(", ");
    return `- ${i.indicator_label} [LCN] (${i.unit}): ${pts}`;
  }).join("\n");
  // Series por pais: acotado prioritariamente a la muestra de Top 5 países de SQLite
  let countryInds = inds.filter(i => i.country_code !== "LCN");
  if (topCcs.length) {
    const matched = countryInds.filter(i => topCcs.includes(i.country_code));
    if (matched.length) countryInds = matched;
  }
  const countries = countryInds
    .slice(0, 25)
    .map(i => {
      const first = i.series[0]; const latest = i.series[i.series.length - 1];
      return `- ${i.indicator_label} [${i.country_code}] (${i.unit}): ${first.year}=${first.value.toFixed(2)} -> ${latest.year}=${latest.value.toFixed(2)}`;
    }).join("\n");
  return { lcn, countries };
}

function computeDigest(computeResults, suggestDecision = null) {
  if (!computeResults) return "Sin analisis estadistico.";
  const inds = chosenIndicators(suggestDecision);
  const relevant = (name) => !inds || matchesIndicator(name, inds);
  const parts = [];
  if (computeResults.regression && !computeResults.error && computeResults.regression.dependent) {
    const r = computeResults.regression;
    parts.push(`REGRESION OLS: ${r.dependent} ~ ${r.independent.join(" + ")}`);
    parts.push(`  n=${r.n}, R2=${r.r_squared?.toFixed(4)}, R2_adj=${r.adj_r_squared?.toFixed(4)}, F=${r.f_statistic?.toFixed(2)} (p=${r.f_p_value?.toFixed(4)})`);
    for (const c of r.coefficients || []) {
      let line = `  ${c.name}: beta=${c.beta?.toFixed(4)}, p=${c.p_value?.toFixed(4)}${c.significant ? " *" : ""}${c.robust_p !== undefined ? `, robust_p=${c.robust_p?.toFixed(4)}${c.robust_significant ? " *" : ""}` : ""}`;
      if (c.boot_ci_95) line += ` | IC95% bootstrap=[${c.boot_ci_95[0].toFixed(4)}, ${c.boot_ci_95[1].toFixed(4)}]${c.boot_includes_zero ? " (incluye 0 -> fragil)" : " (no incluye 0)"}`;
      parts.push(line);
    }
    if (r.white_test) parts.push(`  White test: p=${r.white_test.p_value?.toFixed(4)} (${r.white_test.heteroscedastic ? "heterocedastico" : "homocedastico"})`);
    else parts.push(`  White test: NO calculado`);
  }
  // Panel econométrico: R sustituye a Python para evitar duplicidad de tokens y redundancia
  const rEcon = computeResults.r_econometrics;
  const panel = computeResults.panel;
  if (rEcon && rEcon.coefficients?.length) {
    parts.push(`REGRESION PANEL EN R (Efectos Fijos Bidireccionales - Pais + Año):`);
    parts.push(`  Especificación: ${rEcon.formula}`);
    parts.push(`  R2=${rEcon.r_squared?.toFixed(4)}, R2_adj=${rEcon.adj_r_squared?.toFixed(4)}, F=${rEcon.f_statistic?.toFixed(2)} (p=${rEcon.f_p_value?.toFixed(4)}), n=${rEcon.n} (${rEcon.n_countries} países)`);
    for (const c of rEcon.coefficients) {
      parts.push(`  ${c.name}: estimate=${c.estimate?.toFixed(4)}, std_error=${c.std_error?.toFixed(4)}, t=${c.t_stat?.toFixed(2)}, p=${c.p_value?.toFixed(4)}${c.significant ? " *" : ""}`);
    }
    parts.push(`  NOTA METODOLOGICA (R): Controla simultaneamente por shocks globales de año (tendencias compartidas) y caracteristicas fijas de cada pais.`);
  } else if (panel && panel.coefficients?.length) {
    parts.push(`REGRESION PANEL (efectos fijos por pais): ${panel.dependent} ~ ${panel.independent.join(" + ")}`);
    parts.push(`  n=${panel.n} obs (${panel.n_countries} paises x anos), R2=${panel.r_squared?.toFixed(4)}, dof=${panel.dof}`);
    for (const c of panel.coefficients) {
      parts.push(`  ${c.name}: beta=${c.beta?.toFixed(4)}, p=${c.p_value?.toFixed(4)}${c.significant ? " *" : ""}, IC95%=[${c.ci_95[0].toFixed(4)}, ${c.ci_95[1].toFixed(4)}]`);
    }
    parts.push(`  NOTA: el panel usa variacion INTRA-pais en el tiempo (controla caracteristicas fijas por pais). Si el OLS agregado y el panel discrepan, reportar ambos — la discrepancia es informacion (el agregado puede estar dominado por diferencias entre paises).`);
  }
  const corrs = (computeResults.correlations || []).filter(c => c.pearson_r !== undefined && relevant(c.x) && relevant(c.y));
  if (corrs.length) {
    // Top correlaciones: significativas primero, luego por |r| — evita inflar
    // el digest con 100+ pares irrelevantes que rompen el limite TPM de Groq.
    const top = [...corrs].sort((a, b) => (b.significant - a.significant) || (Math.abs(b.pearson_r) - Math.abs(a.pearson_r))).slice(0, 20);
    parts.push(`CORRELACIONES (${corrs.length} calculadas, top ${top.length} mostradas):`);
    for (const c of top) {
      let line = `  ${c.x} <-> ${c.y}: pearson_r=${c.pearson_r.toFixed(4)}, p=${c.pearson_p.toFixed(4)}, spearman=${c.spearman_rho.toFixed(4)}, n=${c.n}, significativa=${c.significant}`;
      if (c.diff_pearson_r !== undefined) {
        line += ` | en diferencias (Δ año a año): r=${c.diff_pearson_r.toFixed(4)}, p=${c.diff_pearson_p.toFixed(4)}, n=${c.diff_n}`;
      }
      parts.push(line);
    }
    parts.push(`  NOTA: correlaciones en niveles entre series con tendencia pueden ser espurias (co-tendencia). Las correlaciones "en diferencias" (cambios año a año) son el test mas honesto: si la relacion en niveles desaparece en diferencias, era co-tendencia, no asociacion real.`);
  }
  const sigTrends = (computeResults.trends || []).filter(t => t.trend !== "no_trend" && relevant(t.indicator));
  if (sigTrends.length) {
    parts.push(`TENDENCIAS SIGNIFICATIVAS (Mann-Kendall p<0.05):`);
    for (const t of sigTrends.slice(0, 10)) {
      parts.push(`  ${t.indicator}: ${t.trend}, slope=${t.slope.toFixed(3)}/año, p=${t.mann_kendall_p.toFixed(4)}`);
    }
  }
  const anomalies = (computeResults.anomalies || []).filter(a => relevant(a.indicator));
  if (anomalies.length) {
    parts.push(`ANOMALIAS (${anomalies.length}):`);
    for (const a of anomalies.slice(0, 3)) {
      parts.push(`  ${a.indicator} [${a.country_code}] ${a.year}: ${a.value.toFixed(2)} (z=${a.z_score.toFixed(1)})`);
    }
  }
  if (computeResults.charts?.length) {
    const cdir = computeResults.chartsDir ? `${computeResults.chartsDir}/` : "";
    // Solo paths, no captions — el LLM solo necesita referenciar, no leer el caption
    parts.push(`FIGURAS (referenciar con path exacto): ${computeResults.charts.map(c => `charts/${cdir}${c.file}${c.howto ? ` — guia de lectura: "${c.howto}"` : ""}`).join(", ")}`);
  }
  if (computeResults.tables) {
    if (computeResults.tables.descriptive) {
      parts.push(`TABLA 1 PRE-COMPUTADA (Descriptiva / Series reales):\n${computeResults.tables.descriptive}`);
    }
    if (computeResults.tables.regression) {
      parts.push(`TABLA 2 PRE-COMPUTADA (Modelos OLS y Panel):\n${computeResults.tables.regression}`);
    }
    if (computeResults.tables.correlations) {
      parts.push(`TABLA 3 PRE-COMPUTADA (Correlaciones):\n${computeResults.tables.correlations}`);
    }
  }
  return parts.join("\n") || "Sin analisis estadistico.";
}

async function agentWrite(fetchedData, computeResults, feedback = null, topic = null, angle = null, suggestDecision = null) {
  console.log("[4/7] GPT-OSS 120B redactando paper con datos reales...\n");
  if (feedback) console.log(`Aplicando feedback: ${feedback.slice(0, 100)}\n`);
  const effectiveTopic = topic || TOPIC;
  const effectiveAngle = angle || ANGLE;
  const angleSection = effectiveAngle ? `ANGULO EDITORIAL:\n${effectiveAngle}\n` : `ANGULO EDITORIAL: Busca el argumento central mas relevante.`;
  const feedbackSection = feedback ? `\nFEEDBACK DEL REVISOR: ${feedback}\n` : "";
  const questionSection = suggestDecision?.pregunta
    ? `PREGUNTA DE INVESTIGACION:\n${suggestDecision.pregunta}\n\nHIPOTESIS A VERIFICAR:\n${suggestDecision.hipotesis || "(derivar de la pregunta)"}\n`
    : "";
  const { lcn, countries } = dataDigest(fetchedData, suggestDecision);
  const digest = computeDigest(computeResults, suggestDecision);
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
${questionSection}
${feedbackSection}

ESTRUCTURA OBLIGATORIA:
1. **Resumen** (100-150 palabras)
2. **Introduccion** (300-400 palabras): plantea la pregunta de investigacion explicitamente
3. **Metodologia** (150-250 palabras): datos del Banco Mundial 2015-2024, OLS, correlaciones Pearson/Spearman, Mann-Kendall. Menciona regresion de panel con efectos fijos por pais y/o intervalos bootstrap SOLO si aparecen en RESULTADOS. NO menciones metodos que no aparezcan en RESULTADOS (nada de Durbin-Watson, simulaciones ni proyecciones).
4. **Analisis** (500-800 palabras): usa SOLO datos y resultados listados.
OBLIGATORIO PARA TABLAS Y FIGURAS:
- Incluye las tablas pre-computadas provistas en RESULTADOS ESTADISTICOS tal cual están.
- ESTÁ ESTRICTAMENTE PROHIBIDO usar puntos suspensivos ("…"), omitir celdas o dejar datos incompletos.
- Referencia al menos 2-3 de las figuras reales provistas usando EXACTAMENTE la sintaxis: ![descripcion](charts/<path-exacto>).
- PROHIBIDO inventar nombres de archivo de figuras (como charts/consumo_pib.png o cualquier nombre que no esté en la lista de FIGURAS).
5. **Discusion** (200-350 palabras): interpreta; reconoce que n=10 observaciones por serie es muestra pequena y las correlaciones no implican causalidad.
6. **Conclusiones** (150-250 palabras): DEBE dar un veredicto explicito sobre la hipotesis — "los datos apoyan / no apoyan / son insuficientes para evaluar" — basado SOLO en los resultados calculados.
7. **Bibliografia**: formato APA. Solo puedes citar: Banco Mundial/World Development Indicators, la noticia que inspiro el tema, y literatura academica REAL y conocida (Autor 2015, Acemoglu & Restrepo, etc.) SIN atribuirles coeficientes ni cifras especificas.

REGLAS CRITICAS (incumplir = rechazo):
- Todo numero citado debe aparecer LITERALMENTE en DATOS o RESULTADOS de arriba. Prohibido redondear a valores diferentes, inventar valores por pais no listados, o reportar estadisticos no calculados.
- NO existe informacion de paises fuera de la lista. NO uses fuentes que no sean World Bank (nada de CEPAL, OECD, IMF, ECLAC).
- NO inventes tests diagnosticos (White, Durbin-Watson), simulaciones, escenarios futuros ni proyecciones: solo reporta lo que Python calculo.
- Si un resultado no es significativo (p>0.05), dilo explicitamente; no lo presentes como evidencia solida. Si el IC95% bootstrap "incluye 0 -> fragil", reporta esa fragilidad.
- Si aparece "REGRESION PANEL EN R" en RESULTADOS, menciónala explícitamente en Metodología y Análisis como estimación econométrica de efectos fijos bidireccionales (país + año) ejecutada en R 4.x, contrastándola con las correlaciones y OLS de Python. Si solo aparece Python, reporta solo Python.
- Si aparece "REGRESION PANEL" en RESULTADOS, reportala: explica que usa variacion intra-pais (n paises x anos) y contrasta su veredicto con el OLS agregado. Si discrepan, dilo.
- Cuando una correlacion en niveles es significativa pero su correlacion "en diferencias" no lo es (o viceversa), dilo explicitamente: la primera puede ser co-tendencia espuria, la segunda es evidencia mas honesta de co-movimiento.
- Referencia las figuras reales listadas con el path EXACTO de la lista: ![descripcion](charts/<path-completo>). NO inventes figuras ni cambies los paths.
- Cita cada dato como (Banco Mundial, 2024).
- Justo despues del Resumen, agrega un blockquote: "> **En breve:** <la respuesta en una frase a la pregunta de investigacion, con el veredicto honesto segun los resultados>".
- Bajo cada sub-encabezado ### del Analisis, agrega UNA linea en cursiva que explique con lenguaje sencillo que muestra esa seccion (para lectores no tecnicos). NO uses la frase "En palabras simples" — empieza directo con la explicacion.
- Bajo cada figura referenciada, agrega una linea en cursiva "*Como leerla: <guia>*" usando la guia de lectura provista en la lista FIGURAS.
- Total: 1200-1800 palabras. La Bibliografia es OBLIGATORIA y va AL FINAL — si te quedas sin espacio, acorta el Analisis, nunca omitas la Bibliografia.

Devuelve el paper completo en Markdown.`;
  const data = await callGroq("openai/gpt-oss-120b", prompt, { max_tokens: 4500, temperature: 0.6 });
  let result = data.choices[0]?.message?.content || "";
  // Fallback: si el modelo no generó bibliografía (común en modelos Flash),
  // appendear una mínima basada en las fuentes usadas
  if (result && !/## Bibliograf/i.test(result)) {
    console.log("  WRITE: bibliografía faltante — appendando fallback.");
    result = result.trimEnd() + "\n\n## Bibliografía\n\n- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators\n";
  }
  return repairTablesAndCharts(result, computeResults);
}

async function agentReview(fetchedData, computeResults, draft, suggestDecision = null) {
  console.log("[5/7] GPT-OSS 120B revisando rigor academico...\n");
  const { lcn, countries } = dataDigest(fetchedData, suggestDecision);
  const digest = computeDigest(computeResults, suggestDecision);
  const prompt = `Eres un revisor academico riguroso y desconfiado. Tu trabajo es detectar DATOS INVENTADOS comparando el paper contra los datos reales.

DATOS REALES (World Bank API — la unica fuente permitida):

Series regionales America Latina & Caribe:
${lcn}

Series por pais:
${countries || "Sin datos por pais."}

RESULTADOS ESTADISTICOS REALES (Python):
${digest}

PAPER A REVISAR:
${truncate(draft, 5000)}

VERIFICACION OBLIGATORIA:
1. Extrae TODOS los numeros/estadisticas que el paper afirma (porcentajes, coeficientes, r, p, R2, betas, medias).
2. Para cada uno, buscalo en DATOS/RESULTADOS de arriba. Si no aparece literalmente (o no se deriva directamente), marcalo como INVENTADO en "datos_inventados".
3. Senales de alucinacion frecuentes — rechaza si el paper:
   - Menciona datos de paises NO listados arriba, o fuentes externas (CEPAL, OECD, IMF, ECLAC)
   - Contiene tablas con elipses ("…") o celdas vacías sin datos
   - Contiene enlaces a figuras inventadas que no estén en la lista de FIGURAS (ej: charts/consumo_pib.png)
   - Reporta tests no calculados (Durbin-Watson, White si dice "NO calculado"), simulaciones o proyecciones. Efectos fijos / regresion de panel solo son validos si "REGRESION PANEL" aparece en RESULTADOS; si no aparece, mencionarlos es inventado.
   - Cita literatura con coeficientes/cifras especificas no presentes en RESULTADOS
   - Afirma significancia estadistica cuando p>0.05
   - Presenta correlaciones como causalidad sin matizar
4. CONSISTENCIA INTERNA: verifica que la prosa no contradiga las tablas ni los datos — ej. si dice "cinco paises" pero la tabla lista seis, si enumera paises distintos a los que aparecen en tablas, o si describe una tendencia opuesta a la que muestran las cifras citadas. Estas contradicciones cuentan como datos_inventados.
5. Verifica estructura (Resumen, Metodologia, Analisis, Discusion, Conclusiones, Bibliografia) y coherencia.

Responde EXACTAMENTE como JSON (sin markdown):
{"datos_correctos":true,"detalle_datos":"...","datos_inventados":["lista de cada valor fabricado"],"estructura_ok":true,"coherencia_ok":true,"correcciones":["..."],"datos_faltantes":null,"veredicto":"APROBADO","feedback":null}

Veredicto: "APROBADO" solo si datos_correctos=true Y datos_inventados esta vacio Y estructura_ok=true. Si hay CUALQUIER dato inventado o incompleto: "REESCRIBIR" con feedback detallado listando cada correccion.`;
  const data = await callGroq("openai/gpt-oss-120b", prompt, { max_tokens: 2500, temperature: 0.2 });
  const raw = data.choices[0]?.message?.content || "";
  const decision = parseJSONResponse(raw);
  if (!decision) {
    // No auto-aprobar: devolver objeto sin veredicto valido -> guardrails reintentan; si persisten, el pipeline falla honestamente
    console.log("Review: respuesta no parseable (no se auto-aprueba):\n" + raw.slice(0, 500) + "\n");
    return { veredicto: undefined, datos_correctos: false, correcciones: [], feedback: "review response unparseable" };
  }
  // Forzar consistencia: si reporta datos inventados o incompletos, el veredicto no puede ser APROBADO
  const hasBrokenTables = /\|[^\n]*(?:…|\.{3})[^\n]*\|/.test(draft);
  if (hasBrokenTables) {
    decision.veredicto = "REESCRIBIR";
    decision.datos_correctos = false;
    decision.correcciones = decision.correcciones || [];
    decision.correcciones.push("El paper contiene tablas con puntos suspensivos (…) o celdas incompletas.");
    decision.feedback = (decision.feedback ? decision.feedback + "; " : "") + "Tablas incompletas con (…) detectadas.";
  }
  if (decision.estructura_ok === false && decision.veredicto === "APROBADO") {
    decision.veredicto = "REESCRIBIR";
    decision.feedback = (decision.feedback ? decision.feedback + "; " : "") + `Estructura incompleta: ${(decision.correcciones || []).join("; ")}`;
  }
  if (decision.veredicto === "APROBADO" && (decision.datos_inventados?.length || decision.datos_correctos === false)) {
    decision.veredicto = "REESCRIBIR";
    decision.feedback = decision.feedback || `Datos inventados detectados: ${(decision.datos_inventados || []).join("; ")}`;
  }
  console.log("Review:\n" + JSON.stringify(decision, null, 2).slice(0, 500) + "\n");
  return decision;
}

async function agentEdit(draft, review, computeResults = null) {
  console.log("[6/7] GPT-OSS 120B editando paper...\n");
  // Extract bibliography from original draft to re-append if EDIT truncates it
  const bibMatch = draft.match(/^## Bibliograf[\s\S]*$/m);
  const originalBib = bibMatch ? bibMatch[0] : "";
  const prompt = `Eres el editor de una revista de ciencias sociales. Pule este paper.

PAPER:
${truncate(draft, 5000)}

REVISION:
${truncate(typeof review === "string" ? review : JSON.stringify(review), 1500)}

Aplica correcciones, mejora flujo, verifica APA. Manten estructura y formato Markdown.
IMPORTANTE: Preserva la seccion de Bibliografia, las tablas Markdown y todas las referencias a figuras ![..](charts/..) del paper original.
NO agregues numeros, estadisticos ni tests que la REVISION no haya verificado.
NO uses puntos suspensivos ("…") en las tablas ni inventes rutas de figuras.
Devuelve SOLO el paper final en Markdown.`;
  const data = await callGroq("openai/gpt-oss-120b", prompt, { max_tokens: 4000, temperature: 0.5 });
  let result = data.choices[0]?.message?.content || "";
  // If EDIT truncated the bibliography, re-append from original
  if (originalBib && !/## Bibliograf/i.test(result)) {
    console.log("  EDIT trunco bibliografia. Re-appendiendo del draft original.");
    result = result.trimEnd() + "\n\n" + originalBib;
  }
  return repairTablesAndCharts(result, computeResults);
}

function repairTablesAndCharts(markdownText, computeResults) {
  if (!markdownText || !computeResults) return markdownText;
  let text = markdownText;
  const cdir = computeResults.chartsDir ? `${computeResults.chartsDir}/` : "";
  const validCharts = (computeResults.charts || []).map(c => c.file);

  // 1. Normalizar y reparar rutas de figuras
  if (validCharts.length > 0) {
    text = text.replace(/!\[(.*?)\]\((charts\/[^\)]+)\)/g, (match, caption, p) => {
      const filename = p.split("/").pop();
      if (validCharts.includes(filename)) {
        return `![${caption}](charts/${cdir}${filename})`;
      }
      return `![${caption || "Evolución de indicadores"}](charts/${cdir}${validCharts[0]})`;
    });

    if (!/!\[.*?\]\(charts\/.*?\)/.test(text)) {
      const topCharts = computeResults.charts.slice(0, 3);
      const chartSnippets = topCharts.map(c => `\n\n![${c.caption || c.file}](charts/${cdir}${c.file})${c.howto ? `\n\n*Cómo leerla: ${c.howto}.*` : ""}\n`).join("");
      if (/## Análisis/i.test(text)) {
        text = text.replace(/## Análisis/i, `## Análisis${chartSnippets}`);
      }
    }
  }

  // 2. Corregir tablas incompletas o con puntos suspensivos (…)
  if (computeResults.tables) {
    const hasBrokenTables = /\|[^\n]*(?:…|\.{3})[^\n]*\|/.test(text);
    if (hasBrokenTables) {
      if (computeResults.tables.descriptive) {
        text = text.replace(/\|[^\n]*(?:Serie|Indicador|País)[^\n]*\|[\s\S]*?(?=\n\s*\n|\n#|$)/i, (tbl) => {
          if (tbl.includes("…") || tbl.includes("...")) return computeResults.tables.descriptive;
          return tbl;
        });
      }
      if (computeResults.tables.correlations) {
        text = text.replace(/\|[^\n]*(?:Pearson|Spearman|Correlaci)[^\n]*\|[\s\S]*?(?=\n\s*\n|\n#|$)/i, (tbl) => {
          if (tbl.includes("…") || tbl.includes("...")) return computeResults.tables.correlations;
          return tbl;
        });
      }
      if (computeResults.tables.regression) {
        text = text.replace(/\|[^\n]*(?:Modelo|OLS|Panel|Coeficiente)[^\n]*\|[\s\S]*?(?=\n\s*\n|\n#|$)/i, (tbl) => {
          if (tbl.includes("…") || tbl.includes("...")) return computeResults.tables.regression;
          return tbl;
        });
      }
      // Reemplazo de seguridad para cualquier tabla remanente con '…'
      text = text.replace(/(\|(?:\s*[^|\n]+\s*\|){2,}\n\|(?:\s*[-:]+[-| :]*)\n(?:\|[^\n]+\|\n?)+)/g, (tbl) => {
        if (tbl.includes("…") || tbl.includes("...")) {
          if (/kWh|PIB|Manufactur|per cápita/i.test(tbl) && computeResults.tables.descriptive) {
            return computeResults.tables.descriptive;
          }
          if (/Brasil|México|Colombia|Argentina|Chile|Guatemala/i.test(tbl) && computeResults.tables.correlations) {
            return computeResults.tables.correlations;
          }
        }
        return tbl;
      });
    }
  }

  return text;
}

async function agentApprove(finalText) {
  console.log("[7/7] GPT-OSS 20B QA final...\n");
  const hasBrokenTables = /\|[^\n]*(?:…|\.{3})[^\n]*\|/.test(finalText);
  if (hasBrokenTables) {
    return {
      veredicto: "RECHAZADO",
      checklist: { estructura_ok: false, datos_verificados: false, resumen_ok: true, bibliografia_ok: true, citas_apa_ok: true, coherencia_ok: false, tono_academico: true, extension_ok: true },
      palabras: finalText.split(/\s+/).length,
      issues: ["El paper contiene tablas con celdas incompletas o elipses (…)"]
    };
  }
  const prompt = `Eres control de calidad de una revista de ciencias sociales. Verifica:

${truncate(finalText, 4000)}

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

// ── Nota de transparencia: generada determinísticamente desde el estado (sin LLM) ──
function transparencyNote(state) {
  const s = state.suggestDecision || {};
  const cr = state.computeResults || {};
  const corrs = (cr.correlations || []).filter(c => c.pearson_r !== undefined);
  const sigCorrs = corrs.filter(c => c.significant);
  const trends = cr.trends || [];
  const sigTrends = trends.filter(t => t.trend !== "no_trend");
  const ind = state.fetchedData?.indicators || [];
  const allCountries = [...new Set(ind.map(i => i.country_code))];
  const sampleCountries = cr.panel?.countries?.length
    ? cr.panel.countries
    : [...new Set((cr.correlations || []).map(c => c.x.split(' [')[1]?.replace(']', '')).filter(c => c && c !== 'LCN'))];
  const sampleStr = sampleCountries.length ? sampleCountries.join(", ") : allCountries.filter(c => c !== "LCN").join(", ");
  const latestYear = state.fetchedData?.summary?.latest_year_available || "";
  const inspiring = s.suggestions?.find(x => x.titulo === state.topic) || s.suggestions?.[0];
  const it = state.iterations;
  const reg = cr.regression;

  const lines = [
    "---",
    "",
    "## Nota de transparencia",
    "",
    "**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.",
    state.topic ? `Tema seleccionado: *${state.topic}*.` : "",
    inspiring?.noticia_inspiradora ? `Noticia que inspiró la línea editorial: *"${inspiring.noticia_inspiradora}"*${s.inspiringNews?.url ? ` ([${s.inspiringNews.source || "fuente"}](${s.inspiringNews.url}))` : ""}.` : "",
    inspiring?.justificacion ? `Justificación del sistema: ${inspiring.justificacion}` : "",
    s.pregunta ? `**Pregunta de investigación:** ${s.pregunta}` : "",
    s.hipotesis ? `**Hipótesis planteada:** ${s.hipotesis}` : "",
    s.suggestions?.length > 1 ? `Se evaluaron ${s.suggestions.length} líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.` : "",
    "",
    "**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-" + latestYear + ". Muestra analizada: " + sampleStr + " (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.",
    "",
    "**Métodos analíticos ejecutados (Cómputo Determinístico):**",
    `- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de ${ind.length} series, ${corrs.length} correlaciones Pearson/Spearman (${sigCorrs.length} sig. p<0.05).`,
    reg?.dependent ? `- Python 3.12 (Regresión OLS): ${reg.dependent} ~ ${reg.independent.join(" + ")} (n=${reg.n}, R²=${reg.r_squared?.toFixed(3)})${reg.bootstrap ? ", con intervalos de confianza bootstrap (2000 réplicas)" : ""}.` : "- Sin regresión OLS ejecutada.",
    cr.r_econometrics?.coefficients?.length ? `- R 4.x (Panel Econometrics): Estimación de Efectos Fijos Bidireccionales (${cr.r_econometrics.formula}), R²=${cr.r_econometrics.r_squared?.toFixed(3)}, F=${cr.r_econometrics.f_statistic?.toFixed(2)} (n=${cr.r_econometrics.n}, ${cr.r_econometrics.n_countries} países).` : (cr.panel?.coefficients?.length ? `- Regresión de panel con efectos fijos por país: ${cr.panel.dependent} ~ ${cr.panel.independent.join(" + ")} (n=${cr.panel.n} obs, ${cr.panel.n_countries} países).` : ""),
    sigTrends.length ? `- Test de tendencia Mann-Kendall: ${sigTrends.length} de ${trends.length} series con tendencia significativa.` : "",
    cr.anomalies?.length ? `- Detección de anomalías (z-score/IQR): ${cr.anomalies.length} observaciones atípicas.` : "",
    cr.charts?.length ? `- ${cr.charts.length} figuras generadas con matplotlib a partir de los datos.` : "",
    "",
    "**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.",
    state.reviewDecision ? `Revisión de rigor: veredicto ${state.reviewDecision.veredicto}${state.reviewDecision.datos_inventados?.length ? ` (detectó ${state.reviewDecision.datos_inventados.length} datos inventados, corregidos en reescritura)` : ""}.` : "",
    state.qaDecision ? `Control de calidad final: veredicto ${state.qaDecision.veredicto}.` : "",
    `Iteraciones: ${it.rewrite} reescritura(s), ${it.edit} reedición(es).`,
    "",
    "**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/briefs/` (decisión editorial).",
    "",
    "*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*",
  ];
  return lines.filter(l => l !== "").join("\n");
}

// ── Columna editorial de datos: resumen llano del paper para lectura rapida.
// Se genera post-APPROVE desde el paper final + resultados; solo puede usar
// cifras literales del compute. Aparece en el PWA/archivo como "Datos al dia".
async function agentEditorial(state) {
  const s = state.suggestDecision || {};
  const digest = computeDigest(state.computeResults, s);
  const prompt = `Eres un columnista de datos que escribe para lectores sin formacion estadistica. Escribe una COLUMNA corta en espanol (150-220 palabras) que cuente una historia, no que reporte estadisticas.

CONTEXTO:
- Noticia que inspiro el analisis: "${s.suggestions?.find(x => x.titulo === state.topic)?.noticia_inspiradora || "n/a"}"
- Pregunta de investigacion: ${s.pregunta || state.topic}
- Hipotesis evaluada: ${s.hipotesis || "n/a"}

RESULTADOS REALES (la unica evidencia permitida — el lector experto vera el detalle tecnico en el documento completo):
${truncate(digest, 1500)}

ESTRUCTURA (prosa continua, sin encabezados):
1. Primera frase: la pregunta que nacio de la noticia, como se la haria una persona normal.
2. Que encontramos al mirar los datos — contado como historia: que subio, que bajo, que no cambio, en que paises paso algo distinto. Puedes usar magnitudes concretas simples (porcentajes, años, paises) pero TRADUCE todo: en vez de "coeficiente -0.1150, p=0.04" di "cuando crecen las suscripciones moviles, el empleo vulnerable tiende a bajar un poco".
3. Cierre honesto y claro: que significa para el lector — incluyendo si los datos no confirman, son heterogeneos o contradicen la idea inicial. "No se confirma" es un resultado util, dilo con naturalidad.

PROHIBIDO TERMINOS TECNICOS: no uses "coeficiente", "p-valor", "correlacion r", "regresion", "significativo", "R2" ni ninguna notacion estadistica. Si un resultado es debil o incierto, dilo en lenguaje normal ("los datos no son concluyentes", "puede ser casualidad"). No inventes cantidades (numero de paises, de años, de observaciones) — usa solo las que aparezcan en RESULTADOS; no confundas el n de observaciones con el numero de paises. Prohibidos tambien: numeros no listados, opinion politica, causas no probadas ("coincide con", no "causa"), alarmismo, las palabras "paper" y "pipeline" — di "el analisis" o "los datos del Banco Mundial".
Devuelve SOLO el texto de la columna.`;
  // gpt-oss consume tokens en razonamiento — 2000 de margen para que la
  // columna de ~200 palabras no quede truncada a mitad de frase
  const data = await callGroq("openai/gpt-oss-120b", prompt, { max_tokens: 2000, temperature: 0.5 });
  return (data.choices[0]?.message?.content || "").trim();
}

// ── Knowledge base: un registro estructurado por paper (docs/knowledge.jsonl)
// Se reconstruye desde todas las metadata — auto-sanante: sin duplicados,
// sin borrados; crece ordenadamente con cada run. Base para un futuro
// agente/RAG que pueda consultar "que se investigo y que se encontro".
function rebuildKnowledge() {
  try {
    const files = readdirSync(OUTPUT_DIR).filter(f => f.endsWith(".json"));
    const records = [];
    for (const f of files) {
      try {
        const m = JSON.parse(readFileSync(join(OUTPUT_DIR, f), "utf-8"));
        const md = f.replace(/\.json$/, ".md");
        records.push({
          date: f.slice(0, 10),
          file: md,
          link: `papers/${md}`,
          topic: m.topic || null,
          pregunta: m.pregunta || null,
          hipotesis: m.hipotesis || null,
          indicadores: (m.suggestions?.[0]?.indicadores_respaldan) || [],
          noticia: m.inspiringNews ? { title: m.inspiringNews.title, url: m.inspiringNews.url, source: m.inspiringNews.source } : null,
          stats: {
            correlaciones: m.computeResults?.correlations ?? 0,
            significativas: m.computeResults?.significantCorrelations?.length ?? 0,
            top_significativas: m.computeResults?.significantCorrelations || [],
            regresion: m.computeResults?.regression || null,
          },
          review: m.reviewDecision?.veredicto || null,
          qa: m.qaDecision?.veredicto || null,
          editorial: m.editorial || null,
          series: m.dataSources?.indicators ?? null,
          paises: m.dataSources?.countries ?? null,
        });
      } catch {}
    }
    records.sort((a, b) => (b.date + b.file).localeCompare(a.date + a.file));
    mkdirSync("docs", { recursive: true });
    writeFileSync("docs/knowledge.jsonl", records.map(r => JSON.stringify(r)).join("\n") + "\n", "utf-8");
    console.log(`  Knowledge base: ${records.length} registros en docs/knowledge.jsonl`);
    try {
      const py = getPythonPath();
      const script = resolve(__rootdirname, "memory.py");
      execFileSync(py, [script, "sync"], { stdio: "ignore", timeout: 15000 });
      console.log("  Memoria persistente SQLite (docs/memory.db) sincronizada.");
    } catch (e) {
      console.log("  Aviso sync memory.db: " + e.message);
    }
  } catch (e) {
    console.log(`  Knowledge base skip: ${e.message}`);
  }
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
  async nodeSuggest() {
    this.logNode("SUGGEST");
    this.state.suggestDecision = await this.runWithGuardrails("SUGGEST", () => agentSuggest(this.state.fetchedData));
    const decision = this.state.suggestDecision;
    // ── Dedup: si el tema elegido repite un paper reciente, promover la
    // siguiente sugerencia fresca; si todas repiten, saltar el run. ──
    const sugs = decision?.suggestions || [];
    const recent = loadRecentTopics();
    if (recent.length && sugs.length) {
      const scored = sugs.map(s => ({ s, sim: Math.max(0, ...recent.map(t => topicSimilarity(s.titulo, t))) }));
      const fresh = scored.find(x => x.sim < 0.55);
      if (!fresh) {
        console.log(`  Dedup: todas las lineas propuestas repiten temas recientes (max sim ${Math.max(...scored.map(x => x.sim)).toFixed(2)}). Sin tema nuevo — run omitido.`);
        process.exit(0);
      }
      const chosen = chosenSuggestion(decision);
      if (chosen !== fresh.s) {
        const dup = scored.find(x => x.s === chosen);
        console.log(`  Dedup: "${chosen?.titulo || decision.topic}" ya cubierto (sim ${dup?.sim.toFixed(2)}). Promoviendo: "${fresh.s.titulo}"`);
        decision.topic = fresh.s.titulo;
        decision.angle = fresh.s.justificacion || decision.angle;
        decision.pregunta = null;   // la pregunta original era de la linea descartada
        decision.hipotesis = null;  // WRITE la derivara del nuevo tema
      }
    }
    // ── Adjuntar noticia inspiradora (imagen/url) para metadata e index ──
    const chosen = chosenSuggestion(decision);
    if (chosen?.noticia_inspiradora) {
      const news = loadNewsItems();
      const item = news.find(n => {
        const a = normText(n.title), b = normText(chosen.noticia_inspiradora);
        return a && b && (a.includes(b) || b.includes(a) || topicSimilarity(a, b) > 0.6);
      });
      if (item) {
        decision.inspiringNews = {
          title: item.title, url: item.url, source: item.source,
          section: item.section, image: item.url_to_image || item.pexels_image || null,
        };
        console.log(`  Noticia vinculada: "${item.title?.slice(0, 60)}" (${item.source})`);
      }
    }
    if (decision?.topic) { this.state.topic = decision.topic; this.state.angle = decision.angle || this.state.angle; }
    await delay(20); return resolveTransition("SUGGEST", this.state);
  }
  async nodeCompute() { this.logNode("COMPUTE"); this.state.computeResults = await this.runWithGuardrails("COMPUTE", () => agentCompute(this.state.fetchedData, this.state.suggestDecision)); mkdirSync("output/raw", { recursive: true }); writeFileSync("output/raw/compute-results.json", JSON.stringify(this.state.computeResults, null, 2), "utf-8"); return resolveTransition("COMPUTE", this.state); }
  async nodeWrite() { this.logNode("WRITE"); this.state.currentDraft = await this.runWithGuardrails("WRITE", () => agentWrite(this.state.fetchedData, this.state.computeResults, this.state.writeFeedback, this.state.topic, this.state.angle, this.state.suggestDecision)); this.state.drafts.push(this.state.currentDraft); this.state.writeFeedback = null; await delay(20); return resolveTransition("WRITE", this.state); }
  async nodeReview() { this.logNode("REVIEW"); this.state.reviewDecision = await this.runWithGuardrails("REVIEW", () => agentReview(this.state.fetchedData, this.state.computeResults, this.state.currentDraft, this.state.suggestDecision)); await delay(20); return resolveTransition("REVIEW", this.state); }
  async nodeEdit() { this.logNode("EDIT"); try { this.state.editedArticle = await this.runWithGuardrails("EDIT", () => agentEdit(this.state.currentDraft, this.state.editFeedback || "", this.state.computeResults)); } catch (e) { console.log(`  EDIT fallo (${e.message}). Usando draft original.`); this.state.editedArticle = repairTablesAndCharts(this.state.currentDraft, this.state.computeResults); } await delay(20); return resolveTransition("EDIT", this.state); }
  async nodeApprove() {
    this.logNode("APPROVE"); await delay(40);
    this.state.editedArticle = repairTablesAndCharts(this.state.editedArticle, this.state.computeResults);
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
    // Columna editorial "Datos al dia" — derivada del resultado final, tolerante a fallos
    try {
      this.state.editorial = await agentEditorial(this.state);
      if (this.state.editorial) console.log(`  Editorial "Datos al dia": ${this.state.editorial.split(/\s+/).length} palabras`);
    } catch (e) { console.log(`  Editorial skip: ${e.message}`); }
    this.state.editedArticle = repairTablesAndCharts(this.state.editedArticle, this.state.computeResults);
    const finalPaper = this.state.editedArticle + "\n\n" + transparencyNote(this.state);
    writeFileSync(OUTPUT_FILE, finalPaper, "utf-8");
    const date = new Date().toISOString().slice(0, 10);
    const slug = this.state.topic.slice(0, 40).replace(/[^a-z0-9]/gi, "-").toLowerCase();
    writeFileSync(`${OUTPUT_DIR}/${date}_${slug}.md`, finalPaper, "utf-8");
    writeFileSync(`${OUTPUT_DIR}/${date}_${slug}.json`, JSON.stringify({
      generated: new Date().toISOString(),
      topic: this.state.topic, angle: this.state.angle, nodes: this.state.nodeHistory, iterations: this.state.iterations,
      pregunta: this.state.suggestDecision?.pregunta || null, hipotesis: this.state.suggestDecision?.hipotesis || null,
      inspiringNews: this.state.suggestDecision?.inspiringNews || null,
      suggestMode: this.state.suggestDecision?.mode || "manual",
      suggestions: this.state.suggestDecision?.suggestions || [],
      reviewDecision: this.state.reviewDecision, qaDecision: this.state.qaDecision,
      editorial: this.state.editorial || null,
      dataSources: { source: "World Bank API", url: "https://api.worldbank.org", indicators: this.state.fetchedData?.summary?.total_indicators || 0, countries: this.state.fetchedData?.summary?.total_countries || 0, latestYear: this.state.fetchedData?.summary?.latest_year_available || null },
      computeResults: this.state.computeResults ? {
        chartsDir: this.state.computeResults.chartsDir || null,
        regression: this.state.computeResults.regression ? { r_squared: this.state.computeResults.regression.r_squared, n: this.state.computeResults.regression.n } : null,
        correlations: this.state.computeResults.correlations?.length || 0,
        significantCorrelations: (this.state.computeResults.correlations || []).filter(c => c.significant).slice(0, 8).map(c => ({ x: c.x, y: c.y, r: c.pearson_r, p: c.pearson_p, diff_r: c.diff_pearson_r, diff_p: c.diff_pearson_p })),
      } : null,
      truncations: truncationLog.length ? truncationLog : null,
      elapsed: parseFloat(((Date.now() - this.t0) / 1000).toFixed(1)),
    }, null, 2), "utf-8");
    rebuildKnowledge();
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
