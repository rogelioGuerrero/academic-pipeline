/**
 * Academic Scout - Fase consejero
 * Explora dominios economicos/politicos y propone lineas de investigacion
 *
 * Uso: node scripts/scout.mjs ["tema opcional"]
 * Salida: output/proposals/proposals.txt
 */

import { writeFileSync, readFileSync, mkdirSync } from "fs";
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
const OUTPUT_DIR = "output/proposals";
const OUTPUT_FILE = `${OUTPUT_DIR}/proposals.txt`;

if (!GROQ_API_KEY) {
  console.error("Error: GROQ_API_KEY no encontrada. Crear .env con GROQ_API_KEY=gsk_tu_key");
  process.exit(1);
}

const DOMAINS = [
  {
    id: "D1",
    name: "Economia y mercados laborales",
    question: "Como afecta la economia a distintos grupos?",
    prompt: "Find 2025-2026 news about labor markets, wages, precarity, gig economy, youth unemployment, informal employment, pension systems under strain, retirement age debates, or economic inequality. Include OECD, ILO, World Bank, IMF data. Also cover Latin America. Return specific facts with dates and sources. Be concise.",
    tools: ["web_search"],
  },
  {
    id: "D2",
    name: "Politica publica y reformas",
    question: "Que reformas politicas estan en debate?",
    prompt: "Find 2025-2026 news about pension reforms, social security changes, labor law reforms, tax policy debates, housing policy, education policy, healthcare policy, or government spending priorities. Include European Union, OECD referents. Also cover Latin America. Return specific facts with dates and sources. Be concise.",
    tools: ["web_search"],
  },
  {
    id: "D3",
    name: "Demografia y envejecimiento",
    question: "Como cambia la poblacion y que implica?",
    prompt: "Find 2025-2026 data about aging populations, birth rate declines, demographic transitions, dependency ratios, intergenerational transfers, migration patterns, or population projections. Include UN Population Division, World Bank, EU demographic data. Also cover Latin America. Return specific facts with dates and sources. Be concise.",
    tools: ["web_search", "wolfram_alpha"],
  },
  {
    id: "D4",
    name: "Tecnologia, IA y futuro del trabajo",
    question: "Como transforma la tecnologia el empleo?",
    prompt: "Find 2025-2026 news about AI impact on jobs, automation and employment, future of work, digital economy, platform work, AI and productivity, tech layoffs, or skills gap. Include OECD, ILO, academic studies. Also cover Latin America. Return specific facts with dates and sources. Be concise.",
    tools: ["web_search"],
  },
];

async function callGroq(model, prompt, opts = {}) {
  const body = { model, messages: [{ role: "user", content: prompt }], ...opts };
  for (let attempt = 1; attempt <= 4; attempt++) {
    const res = await fetch(GROQ_API_URL, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${GROQ_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    });

    if (res.ok) return await res.json();

    if (res.status === 429 && attempt < 4) {
      const errText = await res.text();
      const match = errText.match(/try again in ([\d.]+)s/i);
      const waitSec = match ? Math.ceil(parseFloat(match[1])) + 2 : 35;
      console.log(`  Rate limit (429). Esperando ${waitSec}s... (intento ${attempt}/4)`);
      await new Promise((r) => setTimeout(r, waitSec * 1000));
      continue;
    }

    if (res.status === 413) {
      console.error(`  Error 413 (prompt demasiado largo). Saltando...`);
      return null;
    }

    const err = await res.text();
    console.error(`Error ${model}: ${res.status}`);
    console.error(err.slice(0, 300));
    return null;
  }
  return null;
}

function delay(seconds) {
  return new Promise((r) => setTimeout(r, seconds * 1000));
}

async function scanDomain(domain) {
  console.log(`\n[SCAN ${domain.id}] ${domain.name}...`);
  console.log(`  Pregunta: ${domain.question}`);
  console.log("  Esto puede tomar 15-30 segundos...\n");

  const data = await callGroq("groq/compound", domain.prompt, {
    compound_custom: {
      models: {
        reasoning_model: "openai/gpt-oss-120b",
        answering_model: "openai/gpt-oss-120b",
      },
      tools: { enabled_tools: domain.tools },
    },
  });

  if (!data) {
    console.log(`  X ${domain.id} no respondio.`);
    return { domain, content: "", tools: [] };
  }

  const content = data.choices[0]?.message?.content || "";
  const tools = data.choices[0]?.message?.executed_tools || [];
  console.log(`  OK ${domain.id}: ${content.length} chars`);
  return { domain, content, tools };
}

async function propose(digests, userTopic) {
  console.log("\n[PROPOSE] Sintetizando lineas de investigacion...\n");

  const digestText = digests
    .map((d) => `## ${d.domain.name} (${d.domain.id})\n${d.content}`)
    .join("\n\n---\n\n");

  const topicInstruction = userTopic
    ? `El profesor ha indicado interes en: "${userTopic}". Prioriza lineas relacionadas con este tema, pero tambien puedes proponer otras si son relevantes.`
    : "Propone lineas variadas que crucen los dominios.";

  const prompt = `Eres un consejero de investigacion academica para un profesor universitario.
Tu trabajo es proponer lineas de investigacion rigurosas, originales y publicables en revistas de ciencias sociales.

DATOS DE ACTUALIDAD (de web search en tiempo real):
${digestText}

${topicInstruction}

Propon 3-5 lineas de investigacion. Para cada una:
1. Titulo provisional (concreto, no vago)
2. Pregunta de investigacion (formulada academicamente)
3. Por que es relevante ahora (justificacion con los datos de arriba)
4. Fuentes identificadas (citar las que aparecen en los datos)
5. Posible hallazgo/tesis (que crees que encontraria la investigacion)
6. Tipo de output sugerido: "paper" (academico) o "ensayo" (argumentativo)

Las fuentes pueden estar en ingles o frances - el paper final sera en espanol.
Se concreto. No propongas "estudiar el impacto de X en Y" - propone "X reduce Y en Z% segun datos de [fuente], lo que sugiere..."

Devuelve en formato Markdown claro.`;

  const data = await callGroq("openai/gpt-oss-120b", prompt, {
    max_tokens: 4000,
    temperature: 0.7,
  });

  return data?.choices[0]?.message?.content || "";
}

async function main() {
  const userTopic = process.argv[2] || "";

  console.log("==================================================");
  console.log("  ACADEMIC SCOUT - Fase Consejero");
  console.log("  Analisis de actualidad -> Lineas de investigacion");
  console.log("==================================================\n");

  if (userTopic) {
    console.log(`Tema de interes del profesor: "${userTopic}"\n`);
  } else {
    console.log("Sin tema especifico. Explorando todos los dominios...\n");
  }

  console.log("FASE 1: Escaneo de dominios\n");
  const digests = [];
  for (const domain of DOMAINS) {
    const result = await scanDomain(domain);
    digests.push(result);
    await delay(5);
  }

  console.log("\nFASE 2: Propuesta de lineas\n");
  const proposals = await propose(digests, userTopic);

  mkdirSync(OUTPUT_DIR, { recursive: true });
  const header = `# Propuestas de Investigacion\n# Generado: ${new Date().toISOString()}\n${userTopic ? `# Tema: ${userTopic}\n` : ""}\n---\n\n`;
  writeFileSync(OUTPUT_FILE, header + proposals, "utf-8");

  console.log(`\n==================================================`);
  console.log(`  OK Propuestas guardadas en ${OUTPUT_FILE}`);
  console.log(`==================================================\n`);

  console.log(proposals);
}

main().catch((err) => {
  console.error("Error fatal:", err);
  process.exit(1);
});
