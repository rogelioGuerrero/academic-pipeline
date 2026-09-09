/**
 * Translate - Convierte un paper academico en articulo divulgativo
 *
 * Toma el paper de output/papers/paper.txt y produce una version
 * accesible para publico general, manteniendo el rigor de los datos.
 *
 * Uso: node scripts/translate.mjs
 * Salida: output/articles/article.txt
 */

import { writeFileSync, readFileSync, mkdirSync, existsSync } from "fs";
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
const PAPER_FILE = "output/papers/paper.txt";
const OUTPUT_DIR = "output/articles";
const OUTPUT_FILE = `${OUTPUT_DIR}/article.txt`;

if (!GROQ_API_KEY) {
  console.error("Error: GROQ_API_KEY no encontrada.");
  process.exit(1);
}

if (!existsSync(PAPER_FILE)) {
  console.error(`Error: No se encontro ${PAPER_FILE}. Ejecuta primero: node scripts/research.mjs "tema"`);
  process.exit(1);
}

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

    const err = await res.text();
    console.error(`Error ${model}: ${res.status}`);
    console.error(err.slice(0, 500));
    process.exit(1);
  }
}

async function main() {
  console.log("==================================================");
  console.log("  TRANSLATE - Paper academico -> Articulo divulgativo");
  console.log("==================================================\n");

  const paper = readFileSync(PAPER_FILE, "utf-8");
  console.log(`Paper leido: ${paper.length} caracteres\n`);

  console.log("[Agente] GPT-OSS 120B traduciendo a lenguaje divulgativo...\n");

  // Truncar paper para no exceder limite TPM
  const paperTrunc = paper.slice(0, 6000);
  const prompt = `Eres un periodista especializado en economia y politica que escribe para un publico general educado pero no especializado.

Tienes este paper academico:

${paperTrunc}

Tu trabajo: escribir un ARTICULO DIVULGATIVO que traduzca el paper a un lenguaje accesible, atractivo y riguroso.

REGLAS:
- Escribe en espanol
- 800-1200 palabras
- Mantén TODOS los datos y cifras del paper. NO inventes ni exageres.
- Cita las fuentes de forma natural: "segun datos del Banco Mundial", "la OCDE reporta que..."
- Tono: periodistico de calidad, como un articulo de opinion en un medio serio (El Pais, The Economist)
- Estructura: titulo atractivo + lead (gancho) + desarrollo + cierre
- NO uses jerga academica. Si el paper dice "coeficiente de Gini", tu explicas "la desigualdad medida por..."
- Conecta con la vida cotidiana: que significa esto para una persona comun?
- Mantén el rigor: cada afirmacion debe tener respaldo en el paper
- NO uses markdown (sin **negritas**, sin ##, sin bullets con -)
- Usa parrafos cortos (3-5 frases maximo)
- Abre con una pregunta o situacion concreta que enganche al lector

Devuelve SOLO el texto del articulo.`;

  const data = await callGroq("openai/gpt-oss-120b", prompt, {
    max_tokens: 3000,
    temperature: 0.7,
  });

  const article = data.choices[0]?.message?.content || "";

  mkdirSync(OUTPUT_DIR, { recursive: true });
  writeFileSync(OUTPUT_FILE, article, "utf-8");

  const date = new Date().toISOString().slice(0, 10);
  const archivePath = `${OUTPUT_DIR}/${date}_articulo.txt`;
  writeFileSync(archivePath, article, "utf-8");

  console.log(`\n==================================================`);
  console.log(`  OK Articulo divulgativo guardado en ${OUTPUT_FILE}`);
  console.log(`  Archivo historico: ${archivePath}`);
  console.log(`==================================================\n`);

  console.log(article);
}

main().catch((err) => {
  console.error("Error fatal:", err);
  process.exit(1);
});
