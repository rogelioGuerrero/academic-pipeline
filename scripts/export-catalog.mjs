/**
 * export-catalog.mjs - Exporta el catalogo de indicadores declarado en fetch-sources.mjs
 * a docs/data/catalog.json, para el libro de codigos (docs/codebook.html).
 *
 * El catalogo es lo que el sistema *puede* pedir al Banco Mundial / ILO.
 * Que indicadores tienen datos realmente lo determina docs/memory.db
 * (ver export_codebook.py). La diferencia entre ambos es justamente lo que
 * el libro de codigos hace visible.
 *
 * Uso: node scripts/export-catalog.mjs
 */

import { writeFileSync, mkdirSync } from "fs";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { WB_INDICATORS, ILO_INDICATORS } from "./fetch-sources.mjs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const OUT_PATH = resolve(__dirname, "..", "docs", "data", "catalog.json");

const wb = WB_INDICATORS.map(i => ({
  code: i.code,
  label: i.label,
  category: i.category,
  unit: i.unit,
  source: "World Bank",
  source_url: `https://data.worldbank.org/indicator/${i.code}`,
}));

const ilo = ILO_INDICATORS.map(i => ({
  code: i.indicator,
  label: i.label,
  category: i.category,
  unit: i.unit,
  source: "ILO",
  ref_area: i.ref_area,
  source_url: "https://ilostat.ilo.org/data/",
}));

const catalog = {
  generated: new Date().toISOString(),
  total: wb.length + ilo.length,
  entries: [...wb, ...ilo],
};

mkdirSync(dirname(OUT_PATH), { recursive: true });
writeFileSync(OUT_PATH, JSON.stringify(catalog, null, 2), "utf-8");
console.log(`catalog.json: ${catalog.total} indicadores declarados (${wb.length} World Bank + ${ilo.length} ILO)`);
