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

const groq = new Groq({
  apiKey: process.env.GROQ_API_KEY,
});

console.log("Test: groq/compound + gpt-oss-20b + tool_choice auto + simple query");
console.log("================================================\n");

try {
  const response = await groq.chat.completions.create({
    model: "groq/compound",
    messages: [{ role: "user", content: "What is the weather today?" }],
    compound_custom: {
      models: {
        reasoning_model: "openai/gpt-oss-20b",
        answering_model: "openai/gpt-oss-20b",
      },
      tools: { enabled_tools: ["web_search"] },
    },
    tool_choice: "auto",
    max_tokens: 1000,
  });

  const choice = response.choices[0];
  console.log("Content length:", choice.message?.content?.length || 0);
  console.log("Content preview:", (choice.message?.content || "").slice(0, 500));
  console.log("\n--- reasoning ---");
  console.log((choice.message?.reasoning || "(sin reasoning)").slice(0, 1000));
  console.log("\n--- executed_tools ---");
  const tools = choice.message?.executed_tools || [];
  console.log("Tools count:", tools.length);
  if (tools.length > 0) {
    tools.forEach((t, i) => {
      console.log(`\nTool ${i + 1}: type=${t.type}`);
      console.log("  arguments:", (t.arguments || "").slice(0, 200));
      console.log("  search_results:", JSON.stringify(t.search_results || null, null, 2).slice(0, 1000));
    });
  } else {
    console.log("(vacío)");
  }
  console.log("\n--- usage ---");
  console.log(JSON.stringify(response.usage, null, 2));
} catch (err) {
  console.error("Error:", err.message);
  if (err.error) console.error("Detail:", JSON.stringify(err.error));
}
