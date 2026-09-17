// Tests de verifyNumbers: verificacion determinista de cifras del paper.
// Extrae las funciones REALES de research.mjs (no copias) y las ejercita.
import { readFileSync, existsSync } from "fs";

const src = readFileSync("scripts/research.mjs", "utf-8");
const start = src.indexOf("function collectAllowedNumbers");
const end = src.indexOf("async function agentReview");
if (start < 0 || end < 0) { console.error("No se pudieron extraer las funciones"); process.exit(1); }
const { verifyNumbers } = new Function(
  `${src.slice(start, end)}\nreturn { verifyNumbers };`
)();

let ok = 0, fail = 0;
const t = (name, cond) => { if (cond) { ok++; console.log(`  OK   ${name}`); } else { fail++; console.log(`  FAIL ${name}`); } };

// ── Datos computados sinteticos ──
const compute = {
  descriptive: {
    "GDP growth (annual %) [LCN]": { n: 10, mean: 1.8342, median: 2.1, std: 3.44, min: -9.94, max: 10.85 },
  },
  correlations: [
    { x: "a", y: "b", pearson_r: 0.8734, pearson_p: 0.0231, spearman_rho: 0.7812, spearman_p: 0.04, n: 10, pearson_ci_95: [0.55, 0.97] },
    { x: "c", y: "d", pearson_r: -0.4521, pearson_p: 0.19, n: 9 },
  ],
  regression: {
    n: 10, r_squared: 0.761, adj_r_squared: 0.68, f_statistic: 12.34, f_p_value: 0.008,
    coefficients: [
      { name: "intercept", beta: 2.31, se: 0.9, t: 2.5, p_value: 0.03, ci_95: [0.4, 4.2] },
      { name: "indep", beta: -0.452, se: 0.11, t: -4.1, p_value: 0.003, ci_95: [-0.7, -0.2], boot_ci_95: [-0.68, -0.21] },
    ],
  },
  trends: [{ n: 10, slope: 0.42, slope_p: 0.01, r_squared: 0.66, mann_kendall_z: 2.14, mann_kendall_p: 0.032 }],
  anomalies: [{ z_score: 2.7, value: -9.94, year: 2020 }],
  charts: [{ file: "f1.png" }],
};
const fetched = {
  indicators: [
    { indicator_label: "GDP growth", country_code: "LCN", series: [{ year: 2020, value: -9.94 }, { year: 2021, value: 10.85 }, { year: 2022, value: 4.1 }] },
  ],
  summary: { total_indicators: 23, total_series: 158, total_countries: 7 },
};

console.log("\n== verifyNumbers ==");

// 1. Paper correcto: cifras reales en distintas formas
const goodDraft = `## Resumen
La correlacion fue r = 0.87 (p = 0.023), con R² = 0.761 y F = 12.34.
El crecimiento cayo a -9.94 en 2020 y rebotó a 10.85 en 2021.
El beta fue -0.45 (IC95%: -0.7 a -0.2), con n = 10.
La tendencia tiene slope 0.42 y tau con z = 2.14.
La diferencia fue de 20.79 puntos (derivada: 10.85 - (-9.94)).
El repunte fue del 209.2% respecto al año previo.
Entre 2015 y 2024, con significancia p < 0.05.
Bibliografia: doi.org/10.1234/foo.2020 y https://ejemplo.com/x?y=2.5
![fig](charts/f1.png)`;

const r1 = verifyNumbers(goodDraft, compute, fetched);
t("paper correcto: no marca inventadas", r1.invented.length === 0);
t("paper correcto: reviso cifras", r1.checked > 5);
if (r1.invented.length) console.log("     falsos positivos:", r1.invented.map(c => c.text).join(", "));

// 2. Paper con cifra inventada
const badDraft = `La correlacion fue r = 0.61 y el beta resulto 7.77.
Ademas el 66.6% de los casos mejoraron.`;
const r2 = verifyNumbers(badDraft, compute, fetched);
t("inventadas: detecta r falso", r2.invented.some(c => c.text === "0.61"));
t("inventadas: detecta beta falso", r2.invented.some(c => c.text === "7.77"));
t("inventadas: detecta % falso", r2.invented.some(c => c.text === "66.6%"));

// 3. Años y umbrales no son afirmaciones
const misc = `En 2020 y entre 2015-2024 hubo cambios con p < 0.05 y r > 0.9.
El nivel fue 95% de confianza.`;
const r3 = verifyNumbers(misc, compute, fetched);
t("años y umbrales: nada inventado", r3.invented.length === 0);
if (r3.invented.length) console.log("     falsos positivos:", r3.invented.map(c => c.text).join(", "));

// 4. Decimales con coma y porcentaje de fraccion
const comma = `La correlacion fue del 87,3% y el minimo de -9,94 puntos.`;
const r4 = verifyNumbers(comma, compute, fetched);
t("coma decimal + % de fraccion: nada inventado", r4.invented.length === 0);
if (r4.invented.length) console.log("     falsos positivos:", r4.invented.map(c => c.text).join(", "));

// 5. Sin datos computados: no verifica (no bloquea)
const r5 = verifyNumbers("La cifra fue 99.99 puntos.", null, null);
t("sin compute: checked=0", r5.checked === 0 && r5.invented.length === 0);

// 6. Encabezados numerados no se confunden
const heads = `### 3.1 Resultados\n#### 4.2 Discusion\nLa media fue 1.83.`;
const r6 = verifyNumbers(heads, compute, fetched);
t("encabezados 3.1/4.2 ignorados", !r6.invented.some(c => c.text === "3.1" || c.text === "4.2"));

// 7. Dedup de inventadas repetidas
const dup = `El valor fue 33.33 y otra vez 33.33.`;
const r7 = verifyNumbers(dup, compute, fetched);
t("inventada repetida: se reporta una vez", r7.invented.length === 1);

// 8. Humo con datos reales commiteados
if (existsSync("output/raw/compute-results.json") && existsSync("output/raw/fetched-data.json") && existsSync("output/papers/paper.txt")) {
  const rc = JSON.parse(readFileSync("output/raw/compute-results.json", "utf-8"));
  const rf = JSON.parse(readFileSync("output/raw/fetched-data.json", "utf-8"));
  const draft = readFileSync("output/papers/paper.txt", "utf-8");
  const r8 = verifyNumbers(draft, rc, rf);
  console.log(`  Real: ${r8.checked} cifras revisadas, ${r8.invented.length} sin respaldo`);
  if (r8.invented.length) console.log("     sin respaldo:", r8.invented.map(c => c.text).join(", "));
  t("paper real: se ejecuto", r8.checked > 0);
}

console.log(`\n${ok} OK, ${fail} FALLAS\n`);
process.exit(fail ? 1 : 0);
