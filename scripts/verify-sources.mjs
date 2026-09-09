/**
 * verify-sources.mjs - Verificación REAL de fuentes
 *
 * Extrae URLs de executed_tools de Compound, hace fetch real a cada una,
 * extrae texto, y usa LLM para confirmar que los datos atribuidos existen.
 *
 * Si una fuente no responde o no confirma el dato → RECHAZO.
 *
 * Uso (como módulo): import { verifySources } from "./verify-sources.mjs"
 * Uso (CLI): node scripts/verify-sources.mjs <json con tools y claims>
 */

import { readFileSync, writeFileSync, mkdirSync } from "fs";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";

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

async function callGroq(model, prompt, opts = {}) {
  const body = { model, messages: [{ role: "user", content: prompt }], ...opts };
  for (let attempt = 1; attempt <= 3; attempt++) {
    const res = await fetch(GROQ_API_URL, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${GROQ_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    });

    if (res.ok) return await res.json();

    if (res.status === 429 && attempt < 3) {
      const errText = await res.text();
      const match = errText.match(/try again in ([\d.]+)s/i);
      const waitSec = match ? Math.ceil(parseFloat(match[1])) + 2 : 30;
      console.log(`  Rate limit (429). Esperando ${waitSec}s... (intento ${attempt}/3)`);
      await new Promise((r) => setTimeout(r, waitSec * 1000));
      continue;
    }

    console.error(`  Error ${model}: ${res.status}`);
    return null;
  }
  return null;
}

/**
 * Extrae URLs de executed_tools de Compound
 */
function extractUrlsFromTools(executedTools) {
  if (!executedTools || !Array.isArray(executedTools)) return [];

  const urls = new Set();
  for (const tool of executedTools) {
    try {
      const args = typeof tool.arguments === "string" ? JSON.parse(tool.arguments) : tool.arguments;
      // web_search tools pueden tener query, no URL directa
      // Pero el output puede contener URLs
      if (tool.output) {
        const outputStr = typeof tool.output === "string" ? tool.output : JSON.stringify(tool.output);
        const urlMatches = outputStr.match(/https?:\/\/[^\s"'<>\])\\]+/g);
        if (urlMatches) urlMatches.forEach((u) => urls.add(u));
      }
      // Algunos tools tienen URL en arguments
      if (args?.url) urls.add(args.url);
      if (args?.domain) urls.add(`https://${args.domain}`);
    } catch {}
  }
  return [...urls];
}

/**
 * Extrae URLs del texto de respuesta de Compound (fallback)
 */
function extractUrlsFromText(text) {
  if (!text) return [];
  const urlRegex = /https?:\/\/[^\s"'<>\])\\]+/g;
  const matches = text.match(urlRegex) || [];
  return [...new Set(matches)];
}

/**
 * Hace fetch real a una URL y extrae texto legible
 */
async function fetchUrlContent(url, timeoutMs = 15000) {
  try {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), timeoutMs);

    const res = await fetch(url, {
      signal: controller.signal,
      headers: {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AcademicPipeline/1.0",
        Accept: "text/html,application/xhtml+xml,application/json,text/plain",
      },
    });

    clearTimeout(timeout);

    if (!res.ok) {
      return { url, status: res.status, ok: false, error: `HTTP ${res.status}` };
    }

    const contentType = res.headers.get("content-type") || "";
    const html = await res.text();

    // Extraer texto del HTML (strip tags básico)
    let text = html;
    if (contentType.includes("text/html")) {
      // Remover scripts, styles, y tags
      text = html
        .replace(/<script[^>]*>[\s\S]*?<\/script>/gi, "")
        .replace(/<style[^>]*>[\s\S]*?<\/style>/gi, "")
        .replace(/<nav[^>]*>[\s\S]*?<\/nav>/gi, "")
        .replace(/<footer[^>]*>[\s\S]*?<\/footer>/gi, "")
        .replace(/<[^>]+>/g, " ")
        .replace(/&nbsp;/g, " ")
        .replace(/&/g, "&")
        .replace(/</g, "<")
        .replace(/>/g, ">")
        .replace(/"/g, '"')
        .replace(/&#\d+;/g, "")
        .replace(/\s+/g, " ")
        .trim();
    }

    // Truncar a 8000 chars para no exceder TPM del LLM
    text = text.slice(0, 8000);

    return { url, status: 200, ok: true, text, contentLength: text.length };
  } catch (err) {
    return { url, status: 0, ok: false, error: err.message };
  }
}

/**
 * Usa LLM para verificar si un claim específico está respaldado por el contenido de la URL
 */
async function verifyClaimWithLLM(claim, sourceContent, sourceUrl) {
  if (!sourceContent || sourceContent.length < 50) {
    return { verified: false, reason: "Contenido insuficiente en la fuente" };
  }

  const prompt = `Eres un verificador de fuentes académicas. Tu trabajo es determinar si el contenido de una página web respalda un dato específico.

DATO A VERIFICAR:
${claim}

CONTENIDO DE LA FUENTE (URL: ${sourceUrl}):
${sourceContent}

PREGUNTA: ¿El contenido de esta página respalda el dato indicado? Busca el dato específico (número, porcentaje, cifra, afirmación) en el texto.

Responde EXACTAMENTE como JSON (sin markdown):
{
  "verified": true/false,
  "evidence": "cita textual o paráfrasis del fragmento que respalda el dato, o explicación de por qué no se encuentra",
  "confidence": "alta/media/baja"
}`;

  const data = await callGroq("openai/gpt-oss-20b", prompt, {
    max_tokens: 500,
    temperature: 0.1,
  });

  if (!data) return { verified: false, reason: "LLM no respondió" };

  const raw = data.choices[0]?.message?.content || "";
  try {
    // Limpiar markdown si existe
    const clean = raw.replace(/```json\s*/g, "").replace(/```\s*/g, "").trim();
    return JSON.parse(clean);
  } catch {
    return { verified: false, reason: "Respuesta no parseable", raw: raw.slice(0, 200) };
  }
}

/**
 * Función principal: verifica todas las fuentes y claims
 *
 * @param {Object} params
 * @param {Array} params.executedTools - tools de Compound
 * @param {string} params.researchText - texto de respuesta de Compound
 * @param {Array} params.claims - [{ claim: "desempleo juvenil 22.1%", sourceUrl: "https://..." }]
 * @returns {Object} { allVerified: bool, results: [...], rejected: [...] }
 */
export async function verifySources({ executedTools, researchText, claims }) {
  console.log("\n[VERIFY] Verificación real de fuentes...\n");

  // 1. Extraer URLs
  let urls = extractUrlsFromTools(executedTools);
  if (urls.length === 0) {
    console.log("  No se extrajeron URLs de executed_tools. Intentando desde texto...");
    urls = extractUrlsFromText(researchText);
  }

  console.log(`  URLs encontradas: ${urls.length}`);
  urls.forEach((u, i) => console.log(`    ${i + 1}. ${u.slice(0, 80)}`));

  if (urls.length === 0) {
    console.log("\n  X No se encontraron URLs para verificar. RECHAZO.");
    return {
      allVerified: false,
      results: [],
      rejected: [{ reason: "No se encontraron URLs en la investigación" }],
      summary: "Sin URLs verificables",
    };
  }

  // 2. Hacer fetch a cada URL
  console.log("\n  Haciendo fetch a fuentes...");
  const fetchedSources = [];
  for (const url of urls.slice(0, 10)) {
    // Limitar a 10 URLs para no tardar demasiado
    console.log(`  Fetch: ${url.slice(0, 60)}...`);
    const result = await fetchUrlContent(url);
    fetchedSources.push(result);
    if (result.ok) {
      console.log(`    OK (${result.contentLength} chars)`);
    } else {
      console.log(`    X ${result.error}`);
    }
  }

  // 3. Si no hay claims explícitos, extraer claims del research text
  let claimsToVerify = claims;
  if (!claimsToVerify || claimsToVerify.length === 0) {
    console.log("\n  No hay claims explícitos. Extrayendo claims del research text...");
    claimsToVerify = await extractClaims(researchText, urls);
  }

  console.log(`\n  Claims a verificar: ${claimsToVerify.length}`);

  // 4. Verificar cada claim contra su fuente
  const results = [];
  const rejected = [];

  for (const claim of claimsToVerify) {
    // Encontrar la fuente correspondiente
    let source = null;
    if (claim.sourceUrl) {
      source = fetchedSources.find((s) => s.url === claim.sourceUrl || s.url.includes(claim.sourceUrl));
    }
    // Si no hay match exacto, usar la primera fuente disponible
    if (!source) {
      source = fetchedSources.find((s) => s.ok);
    }

    if (!source || !source.ok) {
      console.log(`  X Claim sin fuente accesible: "${claim.claim?.slice(0, 60) || 'N/A'}"`);
      rejected.push({ claim: claim.claim, reason: "Fuente no accesible", url: claim.sourceUrl });
      results.push({ claim: claim.claim, verified: false, reason: "Fuente no accesible" });
      continue;
    }

    console.log(`  Verificando: "${(claim.claim || "").slice(0, 60)}..." contra ${source.url.slice(0, 50)}`);
    const verification = await verifyClaimWithLLM(claim.claim, source.text, source.url);

    if (verification.verified) {
      console.log(`    ✓ Verificado (${verification.confidence || 'N/A'})`);
    } else {
      console.log(`    X NO verificado: ${(verification.reason || verification.evidence || "").slice(0, 80)}`);
      rejected.push({
        claim: claim.claim,
        reason: verification.reason || verification.evidence || "No encontrado en la fuente",
        url: source.url,
      });
    }

    results.push({
      claim: claim.claim,
      sourceUrl: source.url,
      verified: verification.verified,
      evidence: verification.evidence,
      confidence: verification.confidence,
    });

    // Pequeño delay para no saturar
    await new Promise((r) => setTimeout(r, 2000));
  }

  const allVerified = rejected.length === 0 && results.length > 0;

  console.log(`\n[VERIFY] Resultado: ${results.length} claims, ${rejected.length} rechazados`);
  console.log(`  Verificado: ${results.filter((r) => r.verified).length}`);
  console.log(`  Rechazado: ${rejected.length}`);
  console.log(`  Veredicto: ${allVerified ? "APROBADO" : "RECHAZADO"}\n`);

  return {
    allVerified,
    results,
    rejected,
    urlsChecked: urls.length,
    sourcesFetched: fetchedSources.filter((s) => s.ok).length,
    summary: `${results.filter((r) => r.verified).length}/${results.length} verificados, ${rejected.length} rechazados`,
  };
}

/**
 * Usa LLM para extraer claims verificables del research text
 */
async function extractClaims(researchText, urls) {
  const prompt = `Eres un extractor de claims académicos. Del siguiente texto de investigación, extrae los datos verificables (cifras, porcentajes, estadísticas, afirmaciones concretas).

TEXTO DE INVESTIGACIÓN:
${researchText.slice(0, 6000)}

URLs de fuentes:
${urls.join("\n")}

Extrae cada dato como un objeto JSON. Devuelve un array:
[
  {"claim": "desempleo juvenil 22.1% en América Latina 2024", "sourceUrl": "https://..."},
  ...
]

Asocia cada claim con la URL más probable de la lista. Si no puedes asociar, deja sourceUrl vacío.
Devuelve SOLO el JSON, sin markdown.`;

  const data = await callGroq("openai/gpt-oss-20b", prompt, {
    max_tokens: 2000,
    temperature: 0.1,
  });

  if (!data) return [];
  const raw = data.choices[0]?.message?.content || "";
  try {
    const clean = raw.replace(/```json\s*/g, "").replace(/```\s*/g, "").trim();
    return JSON.parse(clean);
  } catch {
    console.log("  No se pudieron extraer claims estructurados. Verificando texto completo...");
    return [{ claim: researchText.slice(0, 500), sourceUrl: urls[0] || "" }];
  }
}

// CLI mode
async function main() {
  const inputFile = process.argv[2];
  if (!inputFile) {
    console.error("Uso: node scripts/verify-sources.mjs <input.json>");
    console.error('Input JSON: { executedTools: [...], researchText: "...", claims: [...] }');
    process.exit(1);
  }

  const input = JSON.parse(readFileSync(inputFile, "utf-8"));
  const result = await verifySources(input);

  mkdirSync("output/verification", { recursive: true });
  writeFileSync("output/verification/verification.json", JSON.stringify(result, null, 2), "utf-8");

  console.log("\nResultado guardado en output/verification/verification.json");

  if (!result.allVerified) {
    console.log("\nRECHAZO: Hay claims no verificados.");
    process.exit(2);
  } else {
    console.log("\nAPROBADO: Todas las fuentes verificadas.");
  }
}

// Export para uso como módulo
export { extractUrlsFromTools, extractUrlsFromText, fetchUrlContent, verifyClaimWithLLM, extractClaims };

// CLI
if (process.argv[1] && process.argv[1].endsWith("verify-sources.mjs")) {
  main().catch((err) => {
    console.error("Error fatal:", err);
    process.exit(1);
  });
}
