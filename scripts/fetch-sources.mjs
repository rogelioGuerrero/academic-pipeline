/**
 * fetch-sources.mjs - Fetch real data from public APIs (no LLM invention)
 *
 * Sources:
 * - World Bank API (free, no key): GDP, unemployment, education, internet, etc.
 * - OECD API (free, no key): education, skills, technology indicators
 * - ILO STAT (free, no key): labor market, informal employment, wages
 *
 * Each indicator has a `unit` field to prevent apples-vs-pears correlations.
 *
 * Uso:
 *   import { fetchSources } from "./fetch-sources.mjs";
 *   const data = await fetchSources("youth unemployment AI automation Latin America");
 *
 * O CLI:
 *   node scripts/fetch-sources.mjs "youth unemployment AI automation"
 */

import { writeFileSync, mkdirSync, readFileSync } from "fs";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));

// ── World Bank indicator catalog ──
// Each entry: { code, label, category }
const WB_INDICATORS = [
  // Employment & unemployment
  { code: "SL.UEM.1524.ZS", label: "Youth unemployment (% of labor force 15-24)", category: "employment", unit: "%" },
  { code: "SL.UEM.1524.MA.ZS", label: "Youth unemployment, male (% of male labor force 15-24)", category: "employment", unit: "%" },
  { code: "SL.UEM.1524.FE.ZS", label: "Youth unemployment, female (% of female labor force 15-24)", category: "employment", unit: "%" },
  { code: "SL.UEM.TOTL.ZS", label: "Total unemployment (% of total labor force)", category: "employment", unit: "%" },
  { code: "SL.UEM.TOTL.MA.ZS", label: "Unemployment, male (% of male labor force)", category: "employment", unit: "%" },
  { code: "SL.UEM.TOTL.FE.ZS", label: "Unemployment, female (% of female labor force)", category: "employment", unit: "%" },
  { code: "SL.EMP.TOTL.SP.ZS", label: "Employment to population ratio, 15+, total (%)", category: "employment", unit: "%" },
  { code: "SL.TLF.TOTL.IN", label: "Total labor force (total)", category: "employment", unit: "count" },
  { code: "SL.TLF.1524.IN", label: "Labor force, youth total (ages 15-24)", category: "employment", unit: "count" },
  { code: "SL.UEM.NEET.ZS", label: "Share of youth not in education, employment or training (NEET, % of youth population)", category: "employment", unit: "%" },
  { code: "SL.TLF.CACT.ZS", label: "Labor force participation rate (% of population ages 15+)", category: "employment", unit: "%" },
  { code: "SL.EMP.VULN.ZS", label: "Vulnerable employment (% of total employment)", category: "employment", unit: "%" },
  { code: "SL.AGR.EMPL.ZS", label: "Employment in agriculture (% of total employment)", category: "employment", unit: "%" },
  { code: "SL.IND.EMPL.ZS", label: "Employment in industry (% of total employment)", category: "employment", unit: "%" },
  { code: "SL.SRV.EMPL.ZS", label: "Employment in services (% of total employment)", category: "employment", unit: "%" },
  // GDP & economy
  { code: "NY.GDP.PCAP.CD", label: "GDP per capita (current US$)", category: "economy", unit: "USD" },
  { code: "NY.GDP.MKTP.CD", label: "GDP (current US$)", category: "economy", unit: "USD" },
  { code: "NY.GDP.PCAP.PP.CD", label: "GDP per capita, PPP (current US$)", category: "economy", unit: "USD" },
  { code: "NY.GDP.MKTP.KD.ZG", label: "GDP growth (annual %)", category: "economy", unit: "%" },
  { code: "NV.IND.MANF.ZS", label: "Manufacturing, value added (% of GDP)", category: "economy", unit: "%" },
  { code: "GC.TAX.TOTL.GD.ZS", label: "Tax revenue (% of GDP)", category: "economy", unit: "%" },
  // Education & skills
  { code: "SE.ADT.1524.LT.ZS", label: "Youth literacy rate (% of people 15-24)", category: "education", unit: "%" },
  { code: "SE.ADT.1524.LT.MA.ZS", label: "Youth literacy rate, male", category: "education", unit: "%" },
  { code: "SE.ADT.1524.LT.FE.ZS", label: "Youth literacy rate, female", category: "education", unit: "%" },
  { code: "SE.XPD.TOTL.GD.ZS", label: "Government expenditure on education (% of GDP)", category: "education", unit: "%" },
  { code: "SE.SEC.ENRR", label: "Secondary school enrollment (% gross)", category: "education", unit: "%" },
  { code: "SE.TER.ENRR", label: "Tertiary school enrollment (% gross)", category: "education", unit: "%" },
  // Technology & digital
  { code: "IT.NET.USER.ZS", label: "Internet users (% of population)", category: "technology", unit: "%" },
  { code: "IT.CEL.SETS.P2", label: "Mobile cellular subscriptions (per 100 people)", category: "technology", unit: "per100" },
  { code: "IT.NET.BNDW.PC", label: "Fixed broadband subscriptions (per 100 people)", category: "technology", unit: "per100" },
  // Demographics
  { code: "SP.POP.TOTL", label: "Total population", category: "demographics", unit: "count" },
  { code: "SP.POP.1524.TO", label: "Youth population (ages 15-24)", category: "demographics", unit: "count" },
  { code: "SP.URB.TOTL.IN.ZS", label: "Urban population (% of total)", category: "demographics", unit: "%" },
  // Inequality
  { code: "SI.POV.GINI", label: "Gini index", category: "inequality", unit: "index" },
  { code: "SI.POV.NAHC", label: "Poverty headcount at national poverty line (% of population)", category: "inequality", unit: "%" },
  { code: "SI.POV.DDAY", label: "Poverty headcount ratio at $2.15 a day (2017 PPP, % of population)", category: "inequality", unit: "%" },
  // PISA scores (via World Bank EdStats, sourced from OECD PISA)
  { code: "LO.PISA.MAT", label: "PISA Mathematics score", category: "education", unit: "score" },
  { code: "LO.PISA.REA", label: "PISA Reading score", category: "education", unit: "score" },
  { code: "LO.PISA.SCI", label: "PISA Science score", category: "education", unit: "score" },
  // Migration & remittances
  { code: "SM.POP.NETM", label: "Net migration (total people)", category: "demographics", unit: "count" },
  { code: "BX.TRF.PWKR.CD.DT", label: "Personal remittances received (current US$)", category: "economy", unit: "USD" },
  // Prices
  { code: "FP.CPI.TOTL.ZG", label: "Inflation, consumer prices (annual %)", category: "economy", unit: "%" },
  // Health
  { code: "SP.DYN.LE00.IN", label: "Life expectancy at birth (years)", category: "health", unit: "years" },
  { code: "SH.XPD.CHEX.GD.ZS", label: "Current health expenditure (% of GDP)", category: "health", unit: "%" },
  // Environment & energy
  { code: "EG.FEC.RNEW.ZS", label: "Renewable energy consumption (% of total final energy)", category: "environment", unit: "%" },
  { code: "EG.USE.ELEC.KH.PC", label: "Electric power consumption (kWh per capita)", category: "environment", unit: "kWh" },
  // Trade & investment
  { code: "NE.TRD.GNFS.ZS", label: "Trade (% of GDP)", category: "economy", unit: "%" },
  { code: "BX.KLT.DINV.WD.GD.ZS", label: "Foreign direct investment, net inflows (% of GDP)", category: "economy", unit: "%" },
];

// ── ILO STAT indicator catalog (via ILO REST API) ──
// ILO API: https://www.ilo.org/sdmx/rest/data/ILO,DF_YI_*,...
// We use the simplified ILO STAT JSON endpoint
const ILO_INDICATORS = [
  { ref_area: "AMR", indicator: "UNE_DEAP_SEX_AGE_RT", label: "Youth unemployment rate (ILO, 15-24)", category: "employment", unit: "%" },
  { ref_area: "AMR", indicator: "EMP_DWAP_SEX_AGE_RT", label: "Youth employment-to-population ratio (ILO, 15-24)", category: "employment", unit: "%" },
  { ref_area: "AMR", indicator: "UNE_DEAP_SEX_AGE_NB", label: "Youth unemployed, total (ILO, 15-24)", category: "employment", unit: "count" },
  { ref_area: "AMR", indicator: "EMP_NINS_SEX_AGE_RT", label: "Informal employment rate (ILO)", category: "employment", unit: "%" },
  { ref_area: "AMR", indicator: "EAR_GAP_SEX_AGE_RT", label: "Gender wage gap (ILO)", category: "employment", unit: "%" },
];

// ILO country codes for Latin America (ISO-2 for ILO API)
const ILO_COUNTRIES = [
  { code: "BRA", name: "Brazil" }, { code: "MEX", name: "Mexico" },
  { code: "COL", name: "Colombia" }, { code: "ARG", name: "Argentina" },
  { code: "PER", name: "Peru" }, { code: "CHL", name: "Chile" },
];

// Country codes for Latin America & Caribbean
const LAC_COUNTRIES = [
  { code: "BRA", name: "Brazil" },
  { code: "MEX", name: "Mexico" },
  { code: "COL", name: "Colombia" },
  { code: "ARG", name: "Argentina" },
  { code: "PER", name: "Peru" },
  { code: "CHL", name: "Chile" },
  { code: "ECU", name: "Ecuador" },
  { code: "GTM", name: "Guatemala" },
  { code: "CUB", name: "Cuba" },
  { code: "BOL", name: "Bolivia" },
  { code: "DOM", name: "Dominican Republic" },
  { code: "HND", name: "Honduras" },
  { code: "PRY", name: "Paraguay" },
  { code: "SLV", name: "El Salvador" },
  { code: "NIC", name: "Nicaragua" },
  { code: "CRI", name: "Costa Rica" },
  { code: "PAN", name: "Panama" },
  { code: "URY", name: "Uruguay" },
];

// Regional aggregates
const LAC_REGIONAL = [
  { code: "LCN", name: "Latin America & Caribbean (aggregate)" },
];

const YEAR_RANGE = "2015:2024";

async function fetchWBIndicator(indicatorCode, countryCode, perPage = 50) {
  const url = `https://api.worldbank.org/v2/country/${countryCode}/indicator/${indicatorCode}?format=json&date=${YEAR_RANGE}&per_page=${perPage}`;
  try {
    const res = await fetch(url);
    if (!res.ok) return null;
    const data = await res.json();
    if (!data || !data[1]) return null;
    return data[1]
      .filter(v => v.value != null)
      .map(v => ({
        year: parseInt(v.date),
        value: v.value,
        indicator: data[1][0]?.indicator?.value || indicatorCode,
        country: v.country?.value || countryCode,
        country_code: v.countryiso3code || countryCode,
        source: "World Bank",
        source_url: `https://data.worldbank.org/indicator/${indicatorCode}`,
      }))
      .sort((a, b) => a.year - b.year);
  } catch (err) {
    console.error(`  Error fetching ${indicatorCode} for ${countryCode}: ${err.message}`);
    return null;
  }
}

async function fetchILOIndicator(indicator, refArea) {
  const url = `https://www.ilo.org/sdmx/rest/data/ILO,DF_YI_ALL_SEC_A/${refArea}....${indicator}?format=jsondata&startPeriod=2015&endPeriod=2024`;
  try {
    const res = await fetch(url, { headers: { Accept: "application/json" } });
    if (!res.ok) return null;
    const data = await res.json();
    const obs = data?.data?.observations || [];
    if (!obs.length) return null;
    return obs.map(o => ({
      year: parseInt(o.TIME_PERIOD),
      value: parseFloat(o.OBS_VALUE),
      indicator: indicator,
      country: refArea,
      country_code: refArea,
      source: "ILO STAT",
      source_url: `https://ilostat.ilo.org/data/`,
    })).filter(o => !isNaN(o.value)).sort((a, b) => a.year - b.year);
  } catch {
    return null;
  }
}

// Cubre: empleo, economia, educacion, tecnologia, demografia, desigualdad,
// migracion/remesas, inflacion, salud, ambiente/energia, comercio/inversion.
// El prompt de WRITE solo inyecta los indicadores del tema elegido (filtro topico),
// asi el costo de tokens no crece con el catalogo.
const KEY_INDICATORS = [
    // Empleo y estructura laboral
    "SL.UEM.1524.ZS",
    "SL.UEM.TOTL.ZS",
    "SL.EMP.TOTL.SP.ZS",
    "SL.SRV.EMPL.ZS",
    "SL.EMP.VULN.ZS",
    "SL.UEM.NEET.ZS",
    "SL.TLF.CACT.ZS",
    "SL.AGR.EMPL.ZS",
    "NV.IND.MANF.ZS",
    // Economia
    "NY.GDP.PCAP.CD",
    "NY.GDP.MKTP.KD.ZG",
    "FP.CPI.TOTL.ZG",
    "NE.TRD.GNFS.ZS",
    "BX.KLT.DINV.WD.GD.ZS",
    // Tecnologia
    "IT.NET.USER.ZS",
    "IT.CEL.SETS.P2",
    // Educacion
    "SE.ADT.1524.LT.ZS",
    "SE.XPD.TOTL.GD.ZS",
    "SE.SEC.ENRR",
    "SE.TER.ENRR",
    // Demografia y migracion
    "SP.URB.TOTL.IN.ZS",
    "SM.POP.NETM",
    // Desigualdad
    "SI.POV.GINI",
    "SI.POV.NAHC",
    "SI.POV.DDAY",
    // Remesas
    "BX.TRF.PWKR.CD.DT",
    // Salud
    "SP.DYN.LE00.IN",
    "SH.XPD.CHEX.GD.ZS",
    // Ambiente y energia
    "EG.FEC.RNEW.ZS",
    "EG.USE.ELEC.KH.PC",
];

// Países representativos de América Latina y Caribe (Sudamérica, Centroamérica y Caribe)
const FETCH_COUNTRIES = [
  { code: "LCN", name: "Latin America & Caribbean (regional)" },
  ...LAC_COUNTRIES.filter(c => ["BRA", "MEX", "COL", "ARG", "CHL", "PER", "ECU", "URY", "CRI", "GTM", "DOM", "PAN"].includes(c.code))
];

// Firma del catálogo esperado: pares indicador|país que fetched-data.json debe
// contener. research.mjs la usa para decidir si la caché está incompleta y hay
// que hacer un fetch incremental (solo de los pares faltantes/vencidos).
const SERIES_STALE_DAYS = 180;
const CATALOG_KEYS = new Set();
for (const c of FETCH_COUNTRIES) for (const i of KEY_INDICATORS) CATALOG_KEYS.add(`${i}|${c.code}`);

async function fetchSources(topic) {
  console.log("[FETCH] Obteniendo datos reales de APIs públicas...\n");
  console.log(`  Tema: ${topic}`);
  console.log(`  Fuente: World Bank API (LCN + ${FETCH_COUNTRIES.length - 1} paises)`);
  console.log(`  Indicadores: ${KEY_INDICATORS.length} (modo PoC ampliado)`);
  console.log("  Rango: " + YEAR_RANGE + "\n");

  const results = {
    topic,
    fetchDate: new Date().toISOString(),
    sources: ["World Bank API"],
    indicators: [],
    summary: {},
  };

  // Caché incremental por serie: fetched-data.json es el store persistente
  // (viaja en git, así el cron hereda la caché). Solo se re-descargan los
  // pares indicador×país que falten o lleven >180 días sin refresco; el resto
  // se reutiliza. --no-cache ignora todo y baja el catálogo completo.
  const STALE_DAYS = SERIES_STALE_DAYS;
  const RAW_PATH = resolve(__dirname, "..", "output", "raw", "fetched-data.json");
  const NO_CACHE = process.argv.includes("--no-cache");
  const cacheMap = new Map();   // series frescas: se reusan sin llamar a la API
  const prevMap = new Map();    // todas las series previas: fallback si el refetch falla
  if (!NO_CACHE) {
    try {
      const prev = JSON.parse(readFileSync(RAW_PATH, "utf-8"));
      const baseTs = Date.parse(prev.fetchDate || 0) || 0;
      for (const e of prev.indicators || []) {
        prevMap.set(`${e.indicator_code}|${e.country_code}`, e);
        const ts = Date.parse(e.fetched_at || "") || baseTs;
        if (Date.now() - ts < STALE_DAYS * 86400000) {
          cacheMap.set(`${e.indicator_code}|${e.country_code}`, e);
        }
      }
      // Pares conocidos como "sin datos" en el BM (p.ej. GINI no tiene agregado
      // LCN): se guardan con timestamp para no reintentarlos en cada corrida.
      for (const e of prev.no_data || []) {
        const ts = Date.parse(e.fetched_at || "") || baseTs;
        if (e.key && Date.now() - ts < STALE_DAYS * 86400000) {
          cacheMap.set(e.key, null);
        }
      }
    } catch {}
  }

  let nCached = 0, nFetched = 0;
  const noData = [];
  for (const country of FETCH_COUNTRIES) {
    console.log(`  [${country.code} — ${country.name}]`);
    for (const indCode of KEY_INDICATORS) {
      const ind = WB_INDICATORS.find(i => i.code === indCode);
      if (!ind) continue;
      const key = `${ind.code}|${country.code}`;
      if (cacheMap.has(key)) {
        const hit = cacheMap.get(key);
        if (hit) results.indicators.push(hit);
        else noData.push({ key, fetched_at: new Date().toISOString() });
        nCached++;
        continue;
      }
      const data = await fetchWBIndicator(ind.code, country.code);
      if (data && data.length > 0) {
        results.indicators.push({
          indicator_code: ind.code,
          indicator_label: ind.label,
          category: ind.category,
          unit: ind.unit,
          country: country.name,
          country_code: country.code,
          series: data,
          source: "World Bank API",
          source_url: `https://data.worldbank.org/indicator/${ind.code}`,
          fetched_at: new Date().toISOString(),
        });
        nFetched++;
        const latest = data[data.length - 1];
        console.log(`    ${ind.code}: ${ind.label} => ${latest.year}: ${latest.value.toFixed(2)}`);
      } else {
        // Refetch vacío o falló: conservar la versión previa (vencida) si existe —
        // mejor un dato viejo auditado que perder la serie por un fallo transitorio.
        const stale = prevMap.get(`${ind.code}|${country.code}`);
        if (stale) {
          results.indicators.push(stale);
          nCached++;
          console.log(`    ${ind.code}: refetch sin datos, se conserva caché vencida (${stale.series?.length || 0} puntos)`);
        } else {
          noData.push({ key, fetched_at: new Date().toISOString() });
        }
      }
      await new Promise(r => setTimeout(r, 100)); // rate limit
    }
  }
  results.no_data = noData;
  console.log(`  Caché incremental: ${nCached} series reutilizadas, ${nFetched} descargadas de la API, ${noData.length} sin datos en el BM.`);

  // Build summary
  // Ojo: results.indicators es una entrada por indicador×país, no un indicador.
  // total_series cuenta esas entradas; total_indicators cuenta códigos distintos.
  results.summary = {
    total_series: results.indicators.length,
    total_indicators: new Set(results.indicators.map(i => i.indicator_code)).size,
    total_countries: new Set(results.indicators.map(i => i.country_code)).size,
    categories: [...new Set(results.indicators.map(i => i.category))],
    units: [...new Set(results.indicators.map(i => i.unit))],
    sources: [...new Set(results.indicators.map(i => i.source))],
    year_range: YEAR_RANGE,
    latest_year_available: Math.max(...results.indicators.flatMap(i => i.series.map(s => s.year))),
  };

  console.log(`\n  Total: ${results.summary.total_series} series de datos reales (${results.summary.total_indicators} indicadores distintos)`);
  console.log(`  Paises: ${results.summary.total_countries}`);
  console.log(`  Categorias: ${results.summary.categories.join(", ")}`);
  console.log(`  Año mas reciente: ${results.summary.latest_year_available}\n`);

  // Save raw fetch
  mkdirSync(resolve(__dirname, "..", "output", "raw"), { recursive: true });
  const rawPath = resolve(__dirname, "..", "output", "raw", "fetched-data.json");
  writeFileSync(rawPath, JSON.stringify(results, null, 2), "utf-8");
  console.log(`  Guardado: ${rawPath}`);

  return results;
}

// CLI
if (process.argv[1] && process.argv[1].endsWith("fetch-sources.mjs")) {
  const topic = process.argv[2] || "youth unemployment technology Latin America";
  fetchSources(topic).then(data => {
    console.log("\n[FETCH] Completado.");
  }).catch(err => {
    console.error("Error:", err);
    process.exit(1);
  });
}

export { fetchSources, WB_INDICATORS, LAC_COUNTRIES, ILO_INDICATORS, ILO_COUNTRIES, CATALOG_KEYS, SERIES_STALE_DAYS };
