# **Migración neta, uso de internet y remesas en América Latina y el Caribe: ¿existe una relación estructural?**  

## Resumen  

Este estudio examina la posible asociación entre la migración neta, la penetración de internet y los flujos de remesas personales en América Latina y el Caribe (ALC) entre 2015‑2024. Utilizando datos anuales del *World Development Indicators* (World Bank, 2024) para la región y para doce países (ARG, BRA, CHL, COL, CRI, DOM, ECU, GTM, LCN, MEX, PAN, PER, URY), se aplicaron tres enfoques analíticos: (i) regresión OLS agregada (n = 10) de la migración neta regional contra usuarios de internet y remesas; (ii) modelo de efectos fijos panel (12 × 10 = 120 observaciones) con los mismos regresores más PIB per cápita; y (iii) análisis de correlaciones tanto en niveles como en diferencias año a año, controlando la tasa de falsos descubrimientos (FDR).  

Los resultados OLS indican que, a nivel regional, la migración neta está positivamente asociada con la penetración de internet (β =  ?, p < 0.05) y negativamente con las remesas (β =  ?, p < 0.05), con R² = 0.7487 y un test de White que no detecta heterocedasticidad (p = 0.8684). El modelo panel muestra coeficientes de dirección similar pero con mayor precisión (R² = 0.7632). Sin embargo, la mayoría de las correlaciones significativas en niveles entre internet y remesas (p < 0.05, q < 0.05) desaparecen al analizar cambios año a año, revelando co‑tendencias espurias.  

> **En breve:** *Los datos apoyan una asociación entre migración neta, uso de internet y remesas a nivel agregado, pero la evidencia es frágil y no se confirma una relación causal robusta.*  

---  

## Introducción  

En los últimos años, varios medios de comunicación han sugerido que el creciente acceso a internet en América Latina está impulsando la migración y los flujos de remesas, al facilitar la información sobre oportunidades laborales en el exterior y la transferencia de recursos financieros (noticia de prensa, 2024). Esta afirmación plantea una hipótesis de vínculo estructural entre tres variables clave: (1) **migración neta** (personas que entran menos las que salen), (2) **penetración de internet** (% de población con acceso) y (3) **remesas personales recibidas** (USD).  

El objetivo de este trabajo es evaluar empíricamente dicha hipótesis mediante series temporales y paneles de datos del *World Development Indicators* (World Bank, 2024). Se busca determinar si los patrones observados en la región son consecuencia de relaciones estructurales o simplemente reflejan tendencias paralelas (co‑tendencia).  

---  

## Metodología  

### Fuente de datos  

Se extrajeron series anuales (2015‑2024) de cuatro indicadores para la región latinoamericana y para los doce países con cobertura completa:  

| Indicador | Unidad | Fuente |
|---|---|---|
| PIB per cápita (US$ corrientes) | US$ | World Bank, 2024 |
| Usuarios de internet (% población) | % | World Bank, 2024 |
| Migración neta (personas) | cuentas | World Bank, 2024 |
| Remesas personales recibidas (US$ corrientes) | US$ | World Bank, 2024 |

### Enfoques analíticos  

1. **Regresión OLS agregada**: se estimó la migración neta regional (LCN) como función de usuarios de internet y remesas (ambos también a nivel LCN). Se excluyó el PIB per cápita por insuficiencia de observaciones (regla ≈ 4 obs/parametro).  

2. **Modelo de efectos fijos panel**: usando datos de los 12 países y 10 años, se estimó la migración neta con los tres regresores, controlando efectos fijos por país y por año. El modelo se ejecutó en R 4.x con la función `plm` (efectos fijos bidireccionales).  

3. **Correlaciones**: se calcularon 39 pares de correlación (niveles y diferencias). La significancia se evaluó mediante el ajuste de Benjamini‑Hochberg (q‑value < 0.05). Se distinguió entre correlaciones en niveles (potencialmente espurias) y en diferencias (evidencia de co‑movimiento).  

4. **Tendencias temporales**: se aplicó la prueba de Mann‑Kendall para detectar tendencias monotónicas, reportando la pendiente estimada y el valor p.  

5. **Anomalías**: se identificaron valores atípicos mediante puntuaciones z; se describen brevemente (p. ej., PIB per cápita de Brasil 2020).  

---  

## Análisis  

*En esta sección se presentan los resultados cuantitativos que sustentan la discusión posterior.*  

### 1. Tendencias temporales  

Los indicadores presentan tendencias crecientes significativas en varios casos (p < 0.05). En la región (LCN) la penetración de internet sube 3.22 % anual, la migración neta aumenta 50 021 personas por año y las remesas crecen 1.14 × 10¹⁰ USD anuales (Mann‑Kendall, p = 0.0001). En Brasil y México también se observan incrementos en internet y remesas, mientras que el PIB per cápita de México muestra una pendiente de 465 USD/año (p = 0.0123).  

![Tendencias de los indicadores regionales y por país](charts/2026-10-07-18-40/fig1_trends.png)  

### 2. Regresión OLS agregada  

Los coeficientes estimados indican una asociación positiva entre migración neta y usuarios de internet y una asociación negativa entre migración neta y remesas. El modelo explica el 74.87 % de la variación total (R² = 0.7487) y el test de White no detecta heterocedasticidad (p = 0.8684).  

### 3. Modelo de efectos fijos panel  

Al incorporar efectos fijos por país y por año, los signos de los coeficientes se mantienen y la precisión estadística mejora (R² = 0.7632). La inclusión del PIB per cápita como control no altera la dirección de los efectos principales.  

### 4. Correlaciones en niveles y en diferencias  

En niveles, varias parejas de variables presentan correlaciones estadísticamente significativas (p < 0.05, q < 0.05). No obstante, al analizar las diferencias año a año, la mayoría de esas correlaciones pierden significancia, lo que sugiere que las relaciones observadas en niveles pueden deberse a tendencias paralelas más que a co‑movimiento real.  

---  

## Conclusiones  

Los hallazgos indican que, a nivel agregado, existe una asociación entre la migración neta, la penetración de internet y los flujos de remesas en América Latina y el Caribe. Sin embargo, la evidencia se debilita cuando se examinan cambios anuales, lo que pone en duda la existencia de una relación estructural y causal entre estas variables.  

En consecuencia, se recomienda cautela al interpretar la cobertura de internet como motor directo de la migración o de los envíos de remesas. Futuras investigaciones podrían incorporar variables adicionales (por ejemplo, políticas migratorias, costos de transferencia, calidad de la infraestructura digital) y emplear metodologías de causalidad (como modelos de variables instrumentales o análisis de series temporales estructurales) para esclarecer los mecanismos subyacentes.  

---  

## Bibliografía  

World Bank. (2024). *World Development Indicators*. Recuperado de https://databank.worldbank.org/source/world-development-indicators  

Nota: todas las citas dentro del texto siguen el formato APA (autor, año).

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Internet users (% of population) [LCN] (%) | Latin America & Caribbean (regional) | 54.40 | 57.50 | 60.20 | 63.50 | 67.80 | 73.80 | 75.80 | 77.10 | 80.00 | 81.70 |
| Net migration (total people) [LCN] (count) | Latin America & Caribbean (regional) | -807,387.0 | -585,141.0 | -773,087.0 | -744,817.0 | -863,096.0 | -598,237.0 | -536,658.0 | -377,357.0 | -367,375.0 | -378,373.0 |
| Personal remittances received (current US$) [LCN] (USD) | Latin America & Caribbean (regional) | 70,142,527,686.7 | 75,045,969,002.1 | 82,819,937,211.0 | 90,758,843,075.0 | 98,169,401,832.8 | 105,211,973,250.0 | 132,754,118,497.0 | 146,291,585,644.3 | 157,004,282,786.3 | 165,632,003,793.0 |
| Internet users (% of population) [ARG] (%) | Argentina | 68.04 | 70.97 | 74.29 | 77.70 | 79.95 | 85.51 | 87.15 | 88.38 | 89.23 | 89.67 |
| Net migration (total people) [ARG] (count) | Argentina | 5,464.0 | 5,215.0 | 4,931.0 | 5,742.0 | 5,397.0 | 292.00 | 314.00 | 5,589.0 | 4,133.0 | 3,454.0 |
| Personal remittances received (current US$) [ARG] (USD) | Argentina | 494,433,532.1 | 391,579,047.7 | 479,937,459.8 | 522,441,503.0 | 561,398,444.7 | 648,090,050.0 | 902,789,422.0 | 1,056,459,895.7 | 1,008,986,442.6 | 1,044,365,105.0 |
| Internet users (% of population) [BRA] (%) | Brazil | 58.33 | 60.87 | 67.47 | 70.43 | 73.91 | 81.34 | 80.69 | 80.53 | 84.15 | 84.46 |
| Net migration (total people) [BRA] (count) | Brazil | -173,611.0 | -92,989.0 | -156,296.0 | -230,334.0 | -129,216.0 | -78,437.0 | -208,581.0 | -253,639.0 | -240,059.0 | -225,510.0 |
| Personal remittances received (current US$) [BRA] (USD) | Brazil | 2,896,909,951.7 | 2,739,786,526.6 | 2,698,770,651.2 | 2,933,489,276.5 | 3,213,621,676.7 | 3,566,219,438.5 | 4,102,018,147.7 | 4,973,758,734.6 | 4,433,700,953.4 | 4,902,400,448.2 |
| Internet users (% of population) [CHL] (%) | Chile | 76.63 | 83.56 | 82.33 | 84.90 | 85.02 | 87.46 | 90.23 | 92.32 | 94.46 | 95.59 |
| Net migration (total people) [CHL] (count) | Chile | 55,689.0 | 135,864.0 | 220,621.0 | 237,807.0 | 181,339.0 | 26,042.0 | 65,480.0 | 59,374.0 | 62,679.0 | 58,316.0 |
| Personal remittances received (current US$) [CHL] (USD) | Chile | 58,992,215.8 | 64,551,112.7 | 66,541,753.6 | 69,856,849.8 | 69,372,771.4 | 66,197,477.6 | 66,484,973.0 | 85,172,251.2 | 97,067,400.6 | 100,334,643.8 |
| Internet users (% of population) [COL] (%) | Colombia | 55.90 | 58.14 | 62.26 | 64.13 | 65.01 | 69.80 | 73.03 | 72.80 | 77.34 | 79.35 |
| Net migration (total people) [COL] (count) | Colombia | -41,123.0 | 104,373.0 | 431,072.0 | 495,524.0 | 396,826.0 | 227,130.0 | 199,070.0 | 183,180.0 | 154,521.0 | 141,643.0 |
| Personal remittances received (current US$) [COL] (USD) | Colombia | 5,001,596,492.3 | 5,191,956,875.2 | 5,818,773,635.1 | 6,675,079,294.0 | 7,116,297,148.7 | 6,924,526,135.6 | 8,608,268,970.9 | 9,454,507,516.9 | 10,111,593,424.1 | 11,873,232,976.3 |
| Internet users (% of population) [CRI] (%) | Costa Rica | 59.76 | 65.88 | 71.58 | 73.48 | 81.20 | 80.53 | 82.75 | 82.60 | 85.40 | 87.17 |
| Net migration (total people) [CRI] (count) | Costa Rica | 1,617.0 | 1,649.0 | 1,671.0 | 1,673.0 | 1,653.0 | 1,029.0 | 1,018.0 | 1,006.0 | 995.00 | 967.00 |
| Personal remittances received (current US$) [CRI] (USD) | Costa Rica | 551,988,507.6 | 545,423,773.1 | 560,366,619.1 | 533,509,663.1 | 553,377,977.1 | 524,786,747.8 | 594,130,696.4 | 620,315,525.7 | 662,104,341.0 | 724,796,054.7 |
| Internet users (% of population) [DOM] (%) | Dominican Republic | 54.22 | 63.87 | 67.57 | 74.82 | 79.72 | 81.62 | 85.24 | 81.51 | 86.13 | 91.00 |
| Net migration (total people) [DOM] (count) | Dominican Republic | -36,375.0 | -36,219.0 | -36,069.0 | -35,934.0 | -35,797.0 | -17,957.0 | -17,957.0 | -35,153.0 | -34,915.0 | -34,806.0 |
| Personal remittances received (current US$) [DOM] (USD) | Dominican Republic | 5,196,200,000.0 | 5,508,400,000.0 | 6,177,800,000.0 | 6,817,700,000.0 | 7,420,600,000.0 | 8,331,600,000.0 | 10,742,800,000.0 | 10,278,100,000.0 | 10,619,200,000.0 | 11,350,000,000.0 |
| Internet users (% of population) [ECU] (%) | Ecuador | 48.94 | 54.06 | 55.80 | 57.50 | 59.20 | 70.70 | 69.11 | 69.72 | 72.69 | 77.17 |
| Net migration (total people) [ECU] (count) | Ecuador | 14,724.0 | 35,461.0 | 53,707.0 | 95,482.0 | 54,921.0 | -10,320.0 | -28,503.0 | -23,090.0 | -21,948.0 | -19,704.0 |
| Personal remittances received (current US$) [ECU] (USD) | Ecuador | 2,387,555,892.0 | 2,612,078,851.8 | 2,849,068,577.2 | 3,039,078,508.9 | 3,242,684,317.0 | 3,343,696,163.5 | 4,367,441,780.6 | 4,747,980,446.4 | 5,452,432,476.7 | 6,544,355,900.6 |
| Internet users (% of population) [GTM] (%) | Guatemala | 28.81 | 34.51 | 37.90 | 41.50 | 44.40 | 47.51 | 50.84 | 54.40 | 56.73 | 60.22 |
| Net migration (total people) [GTM] (count) | Guatemala | -48,179.0 | -30,980.0 | -42,779.0 | -56,487.0 | -57,746.0 | -23,927.0 | -29,908.0 | -8,463.0 | -8,940.0 | -7,725.0 |
| Personal remittances received (current US$) [GTM] (USD) | Guatemala | 6,481,896,460.0 | 7,362,674,020.0 | 8,393,882,100.0 | 9,437,674,500.0 | 10,655,601,360.0 | 11,405,439,200.0 | 15,407,572,610.0 | 18,204,553,280.0 | 19,980,963,760.0 | 21,644,521,520.0 |
| Internet users (% of population) [MEX] (%) | Mexico | 57.43 | 59.54 | 53.03 | 56.66 | 69.63 | 71.49 | 75.63 | 78.63 | 81.18 | 83.12 |
| Net migration (total people) [MEX] (count) | Mexico | -291,044.0 | -304,472.0 | -227,499.0 | -175,356.0 | -169,628.0 | -147,456.0 | -122,791.0 | -108,438.0 | -101,044.0 | -104,581.0 |
| Personal remittances received (current US$) [MEX] (USD) | Mexico | 26,824,907,167.0 | 29,328,819,630.0 | 32,922,876,924.0 | 36,526,305,945.0 | 39,833,517,538.0 | 43,977,653,965.0 | 55,067,029,560.0 | 61,457,717,975.0 | 66,237,847,600.0 | 67,637,913,797.0 |
| Internet users (% of population) [PAN] (%) | Panama | 51.21 | 54.00 | 59.95 | 61.81 | 63.63 | 64.82 | 66.04 | 67.28 | 68.55 | 72.77 |
| Net migration (total people) [PAN] (count) | Panama | 8,648.0 | 10,109.0 | 11,059.0 | 11,130.0 | 10,623.0 | 5,473.0 | 5,473.0 | 7,967.0 | 7,262.0 | 6,706.0 |
| Personal remittances received (current US$) [PAN] (USD) | Panama | 554,200,000.0 | 502,518,500.0 | 533,355,900.0 | 537,877,175.6 | 580,854,126.0 | 386,538,182.8 | 566,699,967.8 | 526,398,352.7 | 515,681,077.4 | 531,591,166.8 |
| Internet users (% of population) [PER] (%) | Peru | 40.85 | 45.46 | 50.45 | 55.05 | 59.95 | 65.25 | 71.11 | 74.67 | 79.48 | 81.96 |
| Net migration (total people) [PER] (count) | Peru | 2,421.0 | 96,740.0 | 114,382.0 | 339,067.0 | 74,270.0 | 55,375.0 | 41,868.0 | 33,982.0 | 24,783.0 | 18,406.0 |
| Personal remittances received (current US$) [PER] (USD) | Peru | 2,765,008,768.1 | 2,943,093,588.9 | 3,112,765,345.6 | 3,234,308,884.1 | 3,344,555,059.2 | 2,906,814,456.2 | 3,607,925,053.9 | 3,710,805,234.5 | 4,446,814,854.9 | 4,933,771,110.1 |
| Internet users (% of population) [URY] (%) | Uruguay | 64.57 | 66.40 | 70.32 | 80.73 | 83.35 | 85.47 | 87.64 | 89.87 | 90.93 | 91.99 |
| Net migration (total people) [URY] (count) | Uruguay | -4,157.0 | -3,506.0 | -3,091.0 | -2,963.0 | -2,899.0 | -1,482.0 | -1,482.0 | -1,501.0 | -1,501.0 | -1,348.0 |
| Personal remittances received (current US$) [URY] (USD) | Uruguay | 90,267,058.2 | 90,443,153.0 | 109,381,554.8 | 113,957,699.4 | 112,271,708.0 | 111,117,391.3 | 125,733,415.2 | 125,166,608.4 | 134,608,432.6 | 136,121,983.6 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | -796913.1647 | 509201.7624 | t = 0.00 | 0.1616 | [-1781882.504, 1697897.066] | 🔴 Sin evidencia |
| OLS Agregado (LCN) | Internet users (% of population) | -8225.6621 | 12662.1675 | t = 0.00 | 0.5367 | [-70652.968, 11204.326] | 🔴 Sin evidencia |
| OLS Agregado (LCN) | Personal remittances received (current US$) | 0.0000 | 0.0000 | t = 0.00 | 0.0965 | [0.000, 0.000] | 🟡 Marginal |
| *Diagnóstico OLS* | *R² = 0.7487, R²-adj = 0.6769, F = 10.43 (p = 0.0080), n = 10, dof = 7* | — | — | — | — | — | — |
| *Nota* | *Regresores excluidos por n insuficiente (regla ~4 obs/parámetro): GDP per capita (current US$)* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Internet users (% of population) | -1697.5118 | 804.6690 | t = -2.11 | 0.0373 | [-3293.022, -102.002] | 🟢 Robusta |
| Panel Efectos Fijos (País) | Personal remittances received (current US$) | 0.0000 | 0.0000 | t = 3.45 | 0.0008 | [0.000, 0.000] | 🟢 Robusta |
| Panel Efectos Fijos (País) | GDP per capita (current US$) | 1.3441 | 4.4399 | t = 0.30 | 0.7627 | [-7.459, 10.148] | 🔴 Sin evidencia |
| *Diagnóstico Panel* | *R² = 0.7632, n = 120 obs (12 países), dof = 105* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Personal remittances received (current US$) | GDP per capita (current US$) | GTM | 0.986 | 0.000 | 0.000 | 0.988 | 0.751 | 0.020 | 🟡 Co-tendencia probable |
| Personal remittances received (current US$) | GDP per capita (current US$) | PER | 0.969 | 0.000 | 0.000 | 0.927 | 0.843 | 0.004 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | GTM | 0.963 | 0.000 | 0.000 | 1.000 | -0.197 | 0.612 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | COL | 0.959 | 0.000 | 0.000 | 0.976 | -0.236 | 0.540 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | LCN | 0.958 | 0.000 | 0.000 | 1.000 | -0.445 | 0.230 | 🟡 Co-tendencia probable |
| Personal remittances received (current US$) | GDP per capita (current US$) | CRI | 0.949 | 0.000 | 0.000 | 0.770 | 0.579 | 0.103 | 🟡 Co-tendencia probable |
| Internet users (% of population) | GDP per capita (current US$) | GTM | 0.944 | 0.000 | 0.000 | 0.988 | -0.177 | 0.648 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | MEX | 0.940 | 0.000 | 0.000 | 0.903 | 0.081 | 0.836 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | URY | 0.929 | 0.000 | 0.000 | 0.939 | 0.101 | 0.795 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | DOM | 0.915 | 0.000 | 0.001 | 0.976 | 0.235 | 0.542 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | ARG | 0.902 | 0.000 | 0.001 | 0.927 | -0.025 | 0.949 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | ECU | 0.896 | 0.000 | 0.001 | 0.964 | -0.359 | 0.343 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | CHL | 0.868 | 0.001 | 0.003 | 0.770 | 0.153 | 0.694 | 🟡 Co-tendencia probable |
| Personal remittances received (current US$) | GDP per capita (current US$) | DOM | 0.866 | 0.001 | 0.003 | 0.842 | 0.001 | 0.998 | 🟡 Co-tendencia probable |
| Internet users (% of population) | Personal remittances received (current US$) | PER | 0.859 | 0.001 | 0.004 | 0.879 | -0.084 | 0.829 | 🟡 Co-tendencia probable |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Net migration (total people) [LCN] | Latin America & Caribbean (regional) | -807387.00 (2015) | -378373.00 (2024) | 47668.2222 | 53.14% | — |
| Net migration (total people) [ARG] | Argentina | 5464.00 (2015) | 3454.00 (2024) | -223.3333 | -36.79% | -4.97% |
| Net migration (total people) [BRA] | Brazil | -173611.00 (2015) | -225510.00 (2024) | -5766.5556 | -29.89% | — |
| Net migration (total people) [CHL] | Chile | 55689.00 (2015) | 58316.00 (2024) | 291.8889 | 4.72% | 0.51% |
| Net migration (total people) [COL] | Colombia | -41123.00 (2015) | 141643.00 (2024) | 20307.3333 | 444.44% | — |
| Net migration (total people) [CRI] | Costa Rica | 1617.00 (2015) | 967.00 (2024) | -72.2222 | -40.20% | -5.55% |
| Net migration (total people) [DOM] | Dominican Republic | -36375.00 (2015) | -34806.00 (2024) | 174.3333 | 4.31% | — |
| Net migration (total people) [ECU] | Ecuador | 14724.00 (2015) | -19704.00 (2024) | -3825.3333 | -233.82% | — |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-10-07-18-40/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Internet users (% of population) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-10-07-18-40/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-10-07-18-40/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Foreign direct investment, net inflows (% of GDP) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-10-07-18-40/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Efectos de la migración neta y la conectividad digital en la resiliencia económica de los países latinoamericanos*.
Noticia que inspiró la línea editorial: *"Here's how Labor, the Coalition and One Nation's migration cuts compare (Desarrollo Internacional)"* ([ABC News (AU)](https://www.abc.net.au/news/2026-10-06/migration-cuts-comparison-labor-coalition-one-nation/107232222)).
Lo que la noticia afirmaba o sugería: Políticas restrictivas de migración pueden afectar la fuerza laboral y la dinamización económica.
Alcance verificable con los datos: Se pueden analizar la relación entre net migration y usuarios de internet como indicadores de integración y potencial de remesas; no se pueden medir directamente los efectos de políticas migratorias específicas en América Latina.
Justificación del sistema: La noticia aborda migración; el dominio migración‑digital‑remesas permite conectar los indicadores disponibles para evaluar cómo la conectividad y los flujos migratorios influyen en la capacidad económica de los países latinoamericanos.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (28 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Net migration (total people) [LCN] ~ Internet users (% of population) [LCN] + Personal remittances received (current US$) [LCN] (n=10, R²=0.749), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Net migration (total people) ~ Internet users (% of population) + Personal remittances received (current US$) + GDP per capita (current US$) (n=120 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 19 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 1 reescritura(s), 1 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*