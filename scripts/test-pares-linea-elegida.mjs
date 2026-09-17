// Verificacion del recorte de pares a la linea elegida.
// Usa chosenSuggestion EXTRAIDO del codigo real (no una copia) y las
// sugerencias reales del paper del 2026-09-16 para contar cuantos pares
// genera cada politica.
import { readFileSync } from "fs";

const src = readFileSync("scripts/research.mjs", "utf-8");
const start = src.indexOf("function chosenSuggestion");
const end = src.indexOf("function chosenIndicators");
if (start < 0 || end < 0) throw new Error("No se pudo extraer chosenSuggestion");
const { chosenSuggestion } = new Function(`${src.slice(start, end)}\nreturn { chosenSuggestion };`)();

const fetched = JSON.parse(readFileSync("output/raw/fetched-data.json", "utf-8"));
const meta = JSON.parse(readFileSync("output/papers/2026-09-16_financiamiento-del-sector-el-ctrico-medi.json", "utf-8"));

// Reconstruir el suggestDecision como lo ve agentCompute
const suggestDecision = {
  topic: meta.topic,
  suggestions: meta.suggestions || [],
};

// Replicar el mapeo de research.mjs:575-583: name = "label [CC]"
const series = fetched.indicators
  .filter(i => i.series?.length >= 3)
  .map(i => ({ name: `${i.indicator_label} [${i.country_code}]`, country_code: i.country_code }));
const countries = [...new Set(series.map(s => s.country_code))];
console.log(`series: ${series.length} | paises: ${countries.length} | sugerencias: ${suggestDecision.suggestions.length}\n`);

function findSeries(pattern, cc) {
  const escaped = pattern.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  return series.find(s => new RegExp(escaped, "i").test(s.name) && s.country_code === cc);
}
const buildPairs = (lists) => {
  const seen = new Set();
  let pairs = 0;
  for (const indicators of lists) {
    for (let i = 0; i < indicators.length; i++) {
      for (let j = i + 1; j < indicators.length; j++) {
        for (const cc of countries) {
          const xs = findSeries(indicators[i], cc);
          const ys = findSeries(indicators[j], cc);
          if (!xs || !ys) continue;
          const key = [xs.name, ys.name].sort().join("|");
          if (!seen.has(key)) { seen.add(key); pairs++; }
        }
      }
    }
  }
  return pairs;
};

const chosen = chosenSuggestion(suggestDecision);
console.log(`linea elegida: "${(chosen?.titulo || "?").slice(0, 70)}..."`);
console.log(`  indicadores: ${(chosen?.indicadores_respaldan || []).length}\n`);

const antes = buildPairs(suggestDecision.suggestions.map(s => s.indicadores_respaldan || []));
const despues = buildPairs([chosen?.indicadores_respaldan || []]);

console.log(`ANTES  (todas las lineas):  ${antes} pares`);
console.log(`DESPUES (solo la elegida):  ${despues} pares`);
console.log(`reduccion: ${(100 * (1 - despues / antes)).toFixed(0)}%\n`);

// La regresion debe salir de la MISMA linea elegida (antes: suggestions[0])
const first = suggestDecision.suggestions[0];
console.log("regresion:");
console.log(`  ANTES   usaba suggestions[0]: "${(first?.titulo || "?").slice(0, 60)}..."`);
console.log(`  DESPUES usa la elegida:        "${(chosen?.titulo || "?").slice(0, 60)}..."`);
console.log(`  ${first?.titulo === chosen?.titulo ? "(!) en este paper coincidian: el bug era latente" : "eran DISTINTAS lineas: el bug estaba activo"}`);
