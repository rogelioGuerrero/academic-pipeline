// Tests del EDIT por secciones y guardrails anti-mutilacion.
// Extrae las funciones REALES de research.mjs y las ejercita con stubs.
import { readFileSync } from "fs";

const src = readFileSync("scripts/research.mjs", "utf-8");

const hStart = src.indexOf("function splitMdSections");
const hEnd = src.indexOf("async function agentReview");
if (hStart < 0 || hEnd < 0) { console.error("No se pudieron extraer los helpers"); process.exit(1); }
const helpers = new Function(`${src.slice(hStart, hEnd)}\nreturn { splitMdSections, APPENDIX_RE, proseOnly, placeholderCheck };`)();
const { splitMdSections, APPENDIX_RE, proseOnly, placeholderCheck } = helpers;

const eStart = src.indexOf("async function agentEdit");
const eEnd = src.indexOf("async function agentApprove");
if (eStart < 0 || eEnd < 0) { console.error("No se pudo extraer agentEdit"); process.exit(1); }

// Stubs: callGroq configurable, delay instantaneo, reparacion identidad.
const mkAgentEdit = (callGroq) => new Function(
  "callGroq", "delay", "estimateTokens", "repairTablesAndCharts", "truncate", "TPM_LIMIT", "TPM_MARGIN",
  "splitMdSections", "APPENDIX_RE",
  `${src.slice(eStart, eEnd)}\nreturn agentEdit;`
)(
  callGroq,
  async () => {},
  t => Math.ceil((t || "").length / 2.7),
  (text) => text,
  (t, n) => (t || "").slice(0, n),
  8000, 250,
  splitMdSections, APPENDIX_RE
);

let ok = 0, fail = 0;
const t = (name, cond) => { if (cond) { ok++; console.log(`  OK   ${name}`); } else { fail++; console.log(`  FAIL ${name}`); } };

// Draft con prosa suficiente para forzar el camino de edicion por secciones
// (estimacion > ~4.5k tokens, como un paper real de ~15-23k chars).
const PAD = "La literatura empirica documenta este canal con evidencia consistente en multiples contextos nacionales y regionales. ".repeat(38) + "\n\n";
const DRAFT = `# Titulo del paper

_Meta del paper_

## Resumen

Resumen original con cifras 4.52 y 0.873.

${PAD}
## Introducción

Texto introductorio largo que el editor deberia pulir pero sin tocar cifras.

${PAD}
## Metodología

Se usaron datos del Banco Mundial (r = 0.87, p < 0.05).

${PAD}
## Análisis

Hallazgo principal con beta 1.21.

| Estadistico | Valor |
|---|---|
| beta | 1.21 |

${PAD}
## Tablas

| Indicador | Media |
|---|---|
| GDP growth | 1.83 |

## Bibliografía

- World Bank (2024). World Development Indicators.

## Anexo estadístico

Material suplementario fijo.

## Nota de transparencia

Generado por AcademicPipeline.
`;

// ── splitMdSections ──
const secs = splitMdSections(DRAFT);
t("split: 9 piezas (preambulo + 8 secciones)", secs.length === 9);
t("split: preambulo primero", secs[0].startsWith("# Titulo"));
t("split: encabezados en orden", secs.map(s => s.split("\n", 1)[0].trim()).join("|").includes("## Resumen|## Introducción|## Metodología|## Análisis|## Tablas|## Bibliografía"));
t("appendix: Tablas/Biblio/Anexo/Nota detectados", secs.filter(s => APPENDIX_RE.test(s)).length === 4);
t("appendix: prosa no detectada como apendice", !APPENDIX_RE.test(secs[1]));

// ── placeholderCheck ──
t("placeholder: 'β = ?' detectado", placeholderCheck("El efecto fue significativo (β = ?, p < 0.05).").length > 0);
t("placeholder: 'p = ?' detectado", placeholderCheck("resultado (p = ?)").length > 0);
t("placeholder: '??' detectado", placeholderCheck("valor desconocido ??").length > 0);
t("placeholder: 'p < 0.05' no se marca", placeholderCheck("significativo (p < 0.05, r = 0.87)").length === 0);
t("placeholder: pregunta legitima no se marca", placeholderCheck("¿Aumenta la migracion? Depende.").length === 0);

// ── proseOnly ──
const prose = proseOnly(DRAFT);
t("prose: sin filas de tabla", !prose.includes("| GDP growth |"));
t("prose: prosa intacta", prose.includes("Resumen original con cifras"));
t("prose: apendice colapsado a stub", !prose.includes("Generado por AcademicPipeline") && prose.includes("## Nota de transparencia"));
t("prose: marca la tabla omitida", prose.includes("_[tabla omitida"));

// ── EDIT draft chico: respuesta truncada NO reemplaza el draft ──
{
  const edit = mkAgentEdit(async () => ({ choices: [{ finish_reason: "length", message: { content: "# Titulo\n\n## Resumen\n\nTexto cortado a la mitad sin biblio" } }] }));
  const out = await edit("# T\n\n## Resumen\n\nCorto.", "correcciones", null);
  t("edit chico truncado: conserva draft original", out === "# T\n\n## Resumen\n\nCorto.");
}

// ── EDIT draft chico: salida sin bibliografia la re-appendiza ──
{
  const edit = mkAgentEdit(async () => ({ choices: [{ finish_reason: "stop", message: { content: "# T\n\n## Resumen\n\nEditado." } }] }));
  const out = await edit("# T\n\n## Resumen\n\nA.\n\n## Bibliografía\n\n- Ref.", "c", null);
  t("edit chico: bibliografia recuperada", out.includes("## Bibliografía") && out.includes("- Ref."));
}

// ── EDIT draft grande: va por secciones, apendices intactos ──
{
  const calls = [];
  const edit = mkAgentEdit(async (model, prompt) => {
    calls.push(prompt);
    const sec = prompt.match(/⟦KEEP⟧([\s\S]*?)⟦\/KEEP⟧/)[1];
    return { choices: [{ finish_reason: "stop", message: { content: sec.replace("Resumen original", "Resumen PULIDO") } }] };
  });
  const out = await edit(DRAFT, "corregir tono", null);
  t("edit secciones: 5 llamadas (preambulo + 4 secciones de prosa)", calls.length === 5);
  t("edit secciones: resumen pulido", out.includes("Resumen PULIDO"));
  t("edit secciones: tabla intacta verbatim", out.includes("| GDP growth | 1.83 |"));
  t("edit secciones: bibliografia intacta", out.includes("World Bank (2024)"));
  t("edit secciones: anexo intacto", out.includes("Material suplementario fijo."));
  t("edit secciones: nota intacta", out.includes("Generado por AcademicPipeline."));
  t("edit secciones: nunca envio Tablas/Biblio/Anexo/Nota al LLM",
    calls.every(p => !/⟦KEEP⟧## (Tablas|Bibliograf|Anexo|Nota)/.test(p)));
}

// ── EDIT secciones: una seccion truncada se conserva, el resto se edita ──
{
  const edit = mkAgentEdit(async (model, prompt) => {
    if (prompt.includes("## Introducción")) {
      return { choices: [{ finish_reason: "length", message: { content: "## Introducción\n\nTexto mutilado a la mi" } }] };
    }
    const sec = prompt.match(/⟦KEEP⟧([\s\S]*?)⟦\/KEEP⟧/)[1];
    return { choices: [{ finish_reason: "stop", message: { content: sec.replace("cifras 4.52", "cifras 4.52 revisadas") } }] };
  });
  const out = await edit(DRAFT, "c", null);
  t("seccion truncada: conserva original verbatim", out.includes("Texto introductorio largo que el editor deberia pulir"));
  t("seccion truncada: NO adopta salida mutilada", !out.includes("Texto mutilado"));
  t("seccion truncada: otras secciones si se editaron", out.includes("cifras 4.52 revisadas"));
  t("seccion truncada: estructura completa preservada", /## Nota de transparencia/.test(out));
}

// ── EDIT secciones: fallo de API deja la seccion intacta ──
{
  const edit = mkAgentEdit(async (model, prompt) => {
    if (prompt.includes("## Metodología")) throw new Error("429 rate limit");
    const sec = prompt.match(/⟦KEEP⟧([\s\S]*?)⟦\/KEEP⟧/)[1];
    return { choices: [{ finish_reason: "stop", message: { content: sec } }] };
  });
  const out = await edit(DRAFT, "c", null);
  t("fallo API: metodologia intacta", out.includes("Se usaron datos del Banco Mundial"));
  t("fallo API: documento completo", out.includes("## Bibliografía") && out.includes("## Nota de transparencia"));
}

console.log(`\n${ok} OK, ${fail} FALLAS`);
process.exit(fail ? 1 : 0);
