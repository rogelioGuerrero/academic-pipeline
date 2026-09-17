// Verificacion de las funciones puras del presupuesto de tokens.
// Extrae el bloque real de scripts/research.mjs (no una copia) y lo ejercita.
import { readFileSync } from "fs";

const src = readFileSync("scripts/research.mjs", "utf-8");
const start = src.indexOf("const TPM_LIMIT");
const end = src.indexOf("// Registro de truncamientos");
if (start < 0 || end < 0 || end <= start) throw new Error("No se pudo extraer el bloque");
const block = src.slice(start, end);

const mod = new Function(`${block}\nreturn { planRequest, fitPrompt, estimateTokens, calibrateTokenRatio, TPM_LIMIT, COMPLETION_FLOOR, TPM_MARGIN, getRatio: () => CHARS_PER_TOKEN };`)();
const { planRequest, fitPrompt, estimateTokens, calibrateTokenRatio, TPM_LIMIT, COMPLETION_FLOOR, TPM_MARGIN, getRatio } = mod;

let pass = 0, fail = 0;
const ok = (name, cond, extra = "") => {
  if (cond) { pass++; console.log(`  OK   ${name}`); }
  else { fail++; console.log(`  FALLA ${name} ${extra}`); }
};
// Simula un prompt de n tokens estimados
const promptOfTokens = n => "x".repeat(Math.round(n * getRatio()));
const total = p => estimateTokens(p.prompt) + p.maxTokens + TPM_MARGIN;

console.log(`TPM_LIMIT=${TPM_LIMIT} COMPLETION_FLOOR=${COMPLETION_FLOOR} MARGIN=${TPM_MARGIN}\n`);

// 1) prompt pequeno: nada se toca
{
  const p = planRequest(promptOfTokens(1500), 4000);
  ok("prompt pequeno conserva prompt y max_tokens", p.maxTokens === 4000 && !p.clamped && p.prompt.length === promptOfTokens(1500).length);
  ok("prompt pequeno cabe en el TPM", total(p) <= TPM_LIMIT);
}

// 2) EL CASO QUE FALLABA: prompt ~4729 + max_tokens 4500 = 9229 > 8000
{
  const raw = promptOfTokens(4729);
  const realTokens = estimateTokens(raw); // el redondeo de la cadena no da exacto
  const p = planRequest(raw, 4500);
  ok("caso 9229: NO recorta el prompt (no se pierden datos)", p.prompt.length === raw.length);
  ok("caso 9229: ajusta max_tokens", p.maxTokens === TPM_LIMIT - realTokens - TPM_MARGIN, `-> ${p.maxTokens} (esperado ${TPM_LIMIT - realTokens - TPM_MARGIN})`);
  ok("caso 9229: cabe en el TPM", total(p) <= TPM_LIMIT, `-> ${total(p)}`);
  ok("caso 9229: conserva respuesta util", p.maxTokens >= COMPLETION_FLOOR);
}

// 3) prompt enorme: ahora si recorta, llena el presupuesto y no deja lineas partidas
{
  const raw = Array.from({ length: 900 }, (_, i) => `linea ${i} con contenido de datos`).join("\n");
  const p = planRequest(raw, 4500);
  ok("prompt enorme: recorta", p.fit && p.fit.cutChars > 0);
  ok("prompt enorme: cabe en el TPM", total(p) <= TPM_LIMIT, `-> ${total(p)}`);
  ok("prompt enorme: deja marca del recorte", p.prompt.includes("recortado"));
  const presupuesto = TPM_LIMIT - 4500 - TPM_MARGIN; // split 60/35 = ~95% por diseno
  ok("prompt enorme: llena el presupuesto (>=88%)", p.fit.after >= presupuesto * 0.88, `-> ${p.fit.after} de ${presupuesto}`);
  const lineas = p.prompt.split("\n").filter(l => l.length > 0 && !l.startsWith("["));
  ok("prompt enorme: sin fragmentos de linea partidos", lineas.every(l => l.length >= 20), `-> min ${Math.min(...lineas.map(l => l.length))}`);
}

// 4) fitPrompt respeta el presupuesto
{
  const raw = "a".repeat(100000);
  const f = fitPrompt(raw, 1000);
  ok("fitPrompt: resultado dentro del presupuesto", estimateTokens(f.text) <= 1000, `-> ${estimateTokens(f.text)}`);
  ok("fitPrompt: reporta before > after", f.before > f.after);
}

// 5) fitPrompt no toca lo que ya cabe
{
  const raw = "corto";
  const f = fitPrompt(raw, 1000);
  ok("fitPrompt: no toca lo que cabe", f.text === raw && f.cutChars === 0);
}

// 6) respuesta deseada menor que el suelo
{
  const p = planRequest(promptOfTokens(100), 500);
  ok("deseada bajo el suelo: no se recorta el prompt", !p.clamped && total(p) <= TPM_LIMIT);
}

// 7) nunca se excede el TPM, en un barrido amplio
{
  let worst = 0;
  for (let tok = 100; tok <= 9000; tok += 250) {
    for (const desired of [1000, 2000, 2500, 4000, 4500]) {
      const p = planRequest(promptOfTokens(tok), desired);
      worst = Math.max(worst, total(p));
      if (total(p) > TPM_LIMIT) { console.log(`  FALLA barrido en prompt=${tok} desired=${desired}: total=${total(p)}`); fail++; tok = 99999; break; }
    }
  }
  ok("barrido 100..9000 tokens x 5 reservas: nunca pasa de 8000", worst <= TPM_LIMIT, `peor caso ${worst}`);
}

// 8) calibracion con los numeros reales de un 413
//    Historia: con la base vieja de 3.5, un prompt de 17062 chars que la API
//    reporto como Requested 8635 (max_tokens 2500) eran 6135 tokens reales
//    -> 2.78 chars/token, un 26% mas de lo estimado. Por eso la base es 2.7.
//    La calibracion solo actua cuando la medida es MAS ajustada que la base.
{
  const ratioBefore = getRatio();
  const chars = 17062;
  // Requested 9000 con max_tokens 2500 -> prompt real 6500 -> 2.62 chars/token
  calibrateTokenRatio(chars, 9000, 2500);
  const after = getRatio();
  ok("calibracion: baja el ratio si la medida es mas ajustada", after < ratioBefore, `-> ${after}`);
  ok("calibracion: aplica 2% de holgura", Math.abs(after - (chars / 6500) * 0.98) < 0.01, `-> ${after}`);
  ok("calibracion: el nuevo estimador es mas conservador", estimateTokens("x".repeat(chars)) >= 6500, `-> ${estimateTokens("x".repeat(chars))}`);
}

// 9) la calibracion nunca sube el ratio (jamas se vuelve mas optimista)
{
  const before = getRatio();
  calibrateTokenRatio(17062, 8635, 2500); // 2.78 medido: mas optimista que 2.7
  ok("calibracion: no sube el ratio si la medida es mas optimista", getRatio() === before, `-> ${getRatio()}`);
  calibrateTokenRatio(10000, 900, 500); // medido 25 chars/token: absurdo
  ok("calibracion: ignora medidas absurdas", getRatio() === before, `-> ${getRatio()}`);
  calibrateTokenRatio(10000, 3000, 1000); // 5 chars/token, mas optimista
  ok("calibracion: no sube el ratio", getRatio() === before, `-> ${getRatio()}`);
  calibrateTokenRatio(0, 8000, 2500);
  ok("calibracion: ignora prompt vacio", getRatio() === before);
}

// 10) suelo de respuesta por llamada: un paper cortado no sirve de nada
//     Caso real medido: tema pesado, prompt 5816 tokens, reserva 3200. Sin
//     suelo la respuesta quedaba en 1934 tokens y el paper salia cortado.
{
  const raw = promptOfTokens(5816);
  const sinSuelo = planRequest(raw, 3200);
  ok("WRITE pesado sin suelo: la respuesta quedaba en ~1934", sinSuelo.maxTokens === TPM_LIMIT - 5816 - TPM_MARGIN, `-> ${sinSuelo.maxTokens}`);
  const conSuelo = planRequest(raw, 3200, 2900);
  ok("WRITE pesado con suelo: garantiza 2900 de respuesta", conSuelo.maxTokens >= 2900, `-> ${conSuelo.maxTokens}`);
  ok("WRITE pesado con suelo: cabe en el TPM", total(conSuelo) <= TPM_LIMIT, `-> ${total(conSuelo)}`);
  ok("WRITE pesado con suelo: recorta el prompt, no el paper", conSuelo.fit && conSuelo.fit.cutChars > 0);
  ok("WRITE pesado con suelo: recorta poco (4.000-4.550)", conSuelo.fit.after >= 4000 && conSuelo.fit.after <= TPM_LIMIT - 3200 - TPM_MARGIN, `-> ${conSuelo.fit.after}`);
  // tema liviano: nada se toca aunque haya suelo
  const liviano = planRequest(promptOfTokens(4000), 3200, 2900);
  ok("WRITE liviano con suelo: ni prompt ni reserva se tocan", !liviano.clamped && liviano.maxTokens === 3200);
}

console.log(`\n${pass} OK, ${fail} FALLAS`);
process.exit(fail ? 1 : 0);
