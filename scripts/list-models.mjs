import { readFileSync } from "fs";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import Groq from "groq-sdk";

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

const groq = new Groq({ apiKey: process.env.GROQ_API_KEY });

try {
  const models = await groq.models.list();
  console.log("Available models:");
  for (const m of models.data) {
    console.log(`  ${m.id}`);
  }
} catch (err) {
  console.error("Error:", err.message);
}
