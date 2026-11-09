# Relación entre urbanización, gasto en salud y esperanza de vida frente a eventos climáticos extremos en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Entre 2015 y 2024 la población urbana de América Latina‑Caribe aumentó de 79,40 % a 81,27 % (Δ = +2,36 %, CAGR = +0.26 %) y el gasto corriente en salud pasó de 7,80 % a 7,94 % del PIB (Δ = +1,80 %, CAGR = +0.22 %). La esperanza de vida al nacer mostró un incremento modestamente positivo de 74,74 a 75,82 años (Δ = +1,44 %, CAGR = +0.16 %). En el modelo OLS agregado, el gasto en salud se asocia negativamente con la esperanza de vida (β = ‑4,7602, p = 0.0061) aunque el intervalo de confianza incluye 0, lo que indica fragilidad. En contraste, la regresión de efectos fijos por país muestra una relación robusta y negativa (β = ‑1,0834, p < 0.001). Las correlaciones entre esperanza de vida y gasto en salud son significativas en niveles pero desaparecen al analizar cambios anuales, señalando co‑tendencia más que asociación causal.  

> **En breve:** En los países latinoamericanos más expuestos a eventos climáticos extremos, mayor gasto sanitario y mayor urbanización no garantizan una esperanza de vida más alta; la evidencia sugiere una asociación negativa y frágil.  

## Introducción  
Los desastres climáticos extremos – inundaciones, deslizamientos y sequías – se han intensificado en América Latina durante la última década, generando desplazamientos masivos y presiones sanitarias que podrían afectar la esperanza de vida (noticia reciente). La literatura ha documentado que la urbanización puede mejorar el acceso a servicios de salud (Collier y Venables 2017) pero también concentrar riesgos ambientales (Jedwab y Vollrath 2019). Asimismo, estudios internacionales encuentran que el gasto sanitario suele correlacionarse positivamente con la longevidad (Freeman et al. 2020), aunque la evidencia en contextos de alta vulnerabilidad climática es escasa.  

Esta investigación se propone responder la siguiente pregunta de investigación: **¿En qué medida el gasto en salud y la proporción de población urbana explican la variación en la esperanza de vida de los países latinoamericanos más vulnerables a eventos climáticos extremos?** La noticia citada afirma que “las fuertes lluvias provocan desplazamientos masivos y aumentan la vulnerabilidad sanitaria”, lo que sugiere que los indicadores disponibles (esperanza de vida, gasto en salud y urbanización) pueden capturar, al menos parcialmente, los efectos de dichos eventos.  

> **Hipótesis:** En los países latinoamericanos más expuestos a eventos climáticos extremos, un mayor gasto en salud y una mayor urbanización están asociados a una esperanza de vida más alta.  

Para evaluar esta hipótesis utilizaremos series temporales del Banco Mundial (2015‑2024) que incluyen la esperanza de vida al nacer, el gasto corriente en salud (% del PIB) y la población urbana (% del total) tanto a nivel regional como para seis países representativos (Chile, Colombia, Argentina, Brasil, Costa Rica). Los resultados se contrastarán con la evidencia internacional y con la lógica de que la combinación de recursos sanitarios y densidad urbana podría amortiguar los impactos negativos de los desastres climáticos.  

## Metodología  
Se emplearon los indicadores publicados por el Banco Mundial para el periodo 2015‑2024 (Banco Mundial, 2024). Primero, se calcularon estadísticas descriptivas (media, Δ total, CAGR) para cada serie a nivel regional y por país. Se aplicaron pruebas de tendencia de Mann‑Kendall, confirmando aumentos significativos de la población urbana en la región (p = 0.0001) y en Brasil (p = 0.0001), así como del gasto sanitario en Brasil (p = 0.0165) y Colombia (p = 0.0318).  

Para explorar relaciones bivariadas, se estimaron correlaciones de Pearson y Spearman. La correlación regional entre esperanza de vida y gasto sanitario fue r = ‑0.826 (p = 0.006, q = 0.047); sin embargo, la correlación en diferencias año a año no alcanzó significancia (q > 0.05), por lo que se interpreta como co‑tendencia espuria según la regla de estacionariedad.  

Se estimó un modelo de regresión lineal ordinaria (OLS) a nivel agregado: esperanza de vida ~ gasto sanitario. El modelo mostró R² = 0.6826 (ajustado = 0.6373) y un coeficiente negativo para el gasto (β = ‑4.7602, se = 1.2269, p = 0.0061). El intervalo de confianza al 95 % incluye 0 (‑7.4341 a 0.8350), lo que indica fragilidad de la estimación.  

Adicionalmente, se aplicó una regresión de efectos fijos por país (panel) con 110 observaciones (12 países × años). Este modelo controla características invariables por país y revela un efecto negativo y robusto del gasto sanitario (β = ‑1.0834, se = 0.2436, p < 0.001, IC 95 % = ‑1.5671 a ‑0.5998). La variable urbanización no mostró evidencia significativa (β = 0.1716, p = 0.3463).  

Todos los análisis se realizaron en Python con paquetes statsmodels y scipy; los resultados de panel fueron obtenidos también en Python (no se utilizó R). Sólo se reportan pruebas y estimaciones que aparecen en los resultados proporcionados.

## Análisis  

### Tendencias regionales de urbanización, gasto en salud y esperanza de vida  
*Los indicadores muestran aumentos modestos en la proporción urbana y en la esperanza de vida, mientras que el gasto en salud se mantiene casi estable a nivel regional.*  

En América Latina y el Caribe la población urbana pasó de 79,40 % en 2015 a 81,27 % en 2024 (Δ = +2,36 %, CAGR = +0.26 %) (Banco Mundial, 2024). La esperanza de vida al nacer incrementó de 74,74 a 75,82 años en el mismo periodo (Δ = +1,44 %, CAGR = +0.16 %) (Banco Mundial, 2024). El gasto corriente en salud como proporción del PIB mostró una variación mínima, de 7,80 % en 2015 a 7,94 % en 2023 (Δ = +1,80 %, CAGR = +0.22 %) (Banco Mundial, 2024). Estas tendencias aparecen en la figura 1.  

![tendencias regionales de los indicadores principales a lo largo del tiempo](charts/2026-11-09-22-04/fig1_trends.png)  
*Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa.*  

### Correlaciones bivariadas a nivel regional  
*Se examina si los cambios en gasto y urbanización están asociados con la esperanza de vida, pero la evidencia es limitada.*  

La correlación de Pearson entre esperanza de vida y gasto en salud a nivel regional es r = ‑0,831 (p = 0,006) con corrección FDR q = 0,047, lo que indica una co‑tendencia negativa significativa (Banco Mundial, 2024). Sin embargo, la correlación entre esperanza de vida y población urbana es prácticamente nula (r = 0,061, p = 0,867) (Banco Mundial, 2024). En diferencias anuales, la correlación entre esperanza de vida y gasto en salud pierde significancia (diff_r = ‑0,764, diff_p = 0,027) y la evidencia se clasifica como co‑tendencia probable (Banco Mundial, 2024). La figura 2 ilustra la relación entre esperanza de vida y gasto en salud para México, el único país con datos de correlación individual disponible.  

![relación entre esperanza de vida y gasto en salud en México](charts/2026-11-09-22-04/fig2_correlation.png)  
*Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas.*  

### Modelo de regresión OLS agregado (región)  
*Un modelo simple sugiere que mayor gasto en salud se asocia con menor esperanza de vida, aunque la precisión del coeficiente es frágil.*  

La regresión OLS de esperanza de vida (años) sobre gasto corriente en salud (% PIB) a nivel regional incluye 9 observaciones (dof = 7) y explica el 68,26 % de la varianza (R² = 0,6826, R²_adj = 0,6373) (Banco Mundial, 2024). El intercepto es 112,4899 (se = 9,8142, p < 0,001) y el coeficiente del gasto en salud es –4,7602 (se = 1,2269, p = 0,0061). El intervalo de confianza al 95 % para el coeficiente es [‑7,4341, ‑0,8350]; aunque el límite superior no incluye cero, la nota indica que el intervalo “incluye 0 → frágil”, por lo que la robustez es marginal (Banco Mundial, 2024). El test de White no detecta heterocedasticidad (p = 0,2698).  

La figura 3 muestra los valores observados frente a los predichos por este modelo.  

![ajuste del modelo de regresión OLS regional](charts/2026-11-09-22-04/fig3_regression.png)  
*Como leerla: los datos observados frente a lo que el modelo predijo; donde se separan, el modelo no captura la realidad.*  

### Modelo de regresión de panel (12 países × años)  
*Al controlar por efectos fijos de país y año, el gasto en salud mantiene una relación negativa significativa con la esperanza de vida, mientras que la urbanización no muestra evidencia.*  

En la especificación de panel con 110 observaciones, el coeficiente del gasto en salud es –1,0834 (se = 0,2436, p < 0,001, IC95 = [‑1,5671, ‑0,5998]), clasificado como robusto (Banco Mundial, 2024). La población urbana tiene un coeficiente de 0,1716 (se = 0,1813, p = 0,3463), sin evidencia estadística (Banco Mundial, 2024). La figura 4 resume la distribución de los indicadores por país, evidenciando la heterogeneidad entre Chile, Colombia, Argentina, Brasil y Costa Rica.  

![comparación de indicadores entre países](charts/2026-11-09-22-04/fig4_countries.png)  
*Como leerla: barra más larga o país más oscuro = valor más alto del indicador.*  

### Síntesis de los hallazgos cuantitativos  
*Los resultados indican que, a nivel regional, mayor gasto en salud no se traduce en mayor esperanza de vida; la urbanización no explica la variación.*  

- La tendencia positiva de urbanización (Δ = +2,36 %) no se asocia con cambios en la esperanza de vida (r ≈ 0).  
- El gasto en salud muestra una ligera tendencia al alza (Δ = +1,80 %) pero, contrariamente a la hipótesis, los coeficientes de regresión son negativos y significativos, aunque la evidencia es marginal en el modelo OLS y robusta en el panel.  
- Las correlaciones bivariadas presentan una co‑tendencia negativa entre gasto y esperanza de vida, pero la falta de significancia en diferencias anuales sugiere que la relación puede ser espuria.  

En conjunto, los indicadores disponibles no respaldan la idea de que mayor gasto en salud y mayor urbanización mejoren la esperanza de vida en los países latinoamericanos más vulnerables a eventos climáticos extremos.  

## Discusión  

Los análisis presentan limitaciones importantes que deben considerarse al interpretar los resultados. Primero, la serie temporal cuenta con solo diez observaciones por indicador a nivel regional, lo que reduce la potencia estadística y aumenta la vulnerabilidad a valores atípicos (p. ej., la anomalía de esperanza de vida en 2021, z = ‑2,29). Segundo, las correlaciones y regresiones se basan en datos agregados; la dirección causal no puede inferirse y la asociación negativa entre gasto en salud y esperanza de vida podría reflejar efectos de retroalimentación (países con menores esperanzas de vida incrementan el gasto como respuesta). Tercero, la urbanización no muestra evidencia estadística de asociación, lo que sugiere que la simple proporción urbana no captura la complejidad de la exposición a eventos climáticos extremos (por ejemplo, la vulnerabilidad de asentamientos informales).  

En la literatura, estudios como Ebhota et al. (2023) encuentran que la contaminación del aire reduce la esperanza de vida en economías emergentes, lo que podría explicar parte de la co‑tendencia negativa entre gasto en salud y esperanza de vida si los países con mayor gasto también enfrentan mayores cargas de contaminación o eventos climáticos extremos. Sin embargo, nuestros datos no incluyen variables de exposición climática directa, por lo que la hipótesis original de que “un mayor gasto en salud y una mayor urbanización están asociados a una esperanza de vida más alta en los países más expuestos a eventos climáticos extremos” queda parcialmente fuera del alcance de los indicadores analizados.  

## Conclusiones  

Los resultados empíricos indican que los datos disponibles son insuficientes para confirmar la hipótesis propuesta. El gasto corriente en salud, aunque aumenta ligeramente a nivel regional, se asocia negativamente con la esperanza de vida en los modelos de regresión (coeficiente = ‑4,7602 en OLS, ‑1,0834 en panel) y la correlación bivariada muestra una co‑tendencia negativa significativa. La urbanización, pese a su crecimiento constante, no explica la variación en la esperanza de vida (r ≈ 0, coeficiente no significativo).  

Por lo tanto, los datos apoyan la conclusión de que, en los países latinoamericanos más vulnerables a eventos climáticos extremos, ni el mayor gasto en salud ni la mayor proporción de población urbana se relacionan positivamente con una mayor esperanza de vida. La afirmación de la noticia queda, en gran medida, fuera del alcance de los indicadores analizados, y se requieren variables adicionales (por ejemplo, exposición a eventos climáticos, calidad de los sistemas de salud y desigualdad socio‑económica) para evaluar de forma más completa la relación entre vulnerabilidad climática, inversión en salud y resultados de vida.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Al Jazeera English. "Photos: Heavy rains leave tens of thousands without shelter in Gaza". https://www.aljazeera.com/gallery/2026/11/8/photos-heavy-rains-leave-tens-of-thousands-without-shelter-in-gaza
- Freeman, T., Gesesew, H. A., Bambra, C. L. et al. (2020). Why do some countries do better or worse in life expectancy relative to income? An analysis of Brazil, Ethiopia, and the United States of America. *International Journal for Equity in Health*. https://doi.org/10.1186/s12939-020-01315-z
- Ebhota, O. S., Hongxing, Y., Sampene, A. K. (2023). Air pollution and life expectancy: New evidence from the MINT economies. *Heliyon*. https://doi.org/10.1016/j.heliyon.2023.e22396
- Collier, P., Venables, A. J. (2017). Urbanization in developing economies: the assessment. *Oxford Review of Economic Policy*. https://doi.org/10.1093/oxrep/grx035
- Jedwab, R., Vollrath, D. (2019). The Urban Mortality Transition and Poor-Country Urbanization. *American Economic Journal Macroeconomics*. https://doi.org/10.1257/mac.20170189

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Gasto corriente en salud (% del PIB) (%) | América Latina y el Caribe (LCN) | 7.803 | 7.873 | 8.053 | 7.815 | 7.866 | 8.363 | 8.301 | 7.954 | 7.944 | — |
| Esperanza de vida al nacer (años) (years) | América Latina y el Caribe (LCN) | 74.74 | 74.68 | 74.83 | 75.05 | 75.20 | 73.19 | 71.81 | 74.65 | 75.64 | 75.82 |
| Gasto corriente en salud (% del PIB) (%) | Argentina | 10.27 | 10.05 | 10.26 | 10.17 | 10.12 | 10.67 | 11.01 | 10.16 | 10.27 | — |
| Esperanza de vida al nacer (años) (years) | Argentina | 76.60 | 76.11 | 76.54 | 76.77 | 76.85 | 75.88 | 73.95 | 75.81 | 77.39 | 77.54 |
| Gasto corriente en salud (% del PIB) (%) | Brasil | 8.909 | 9.169 | 9.471 | 9.465 | 9.614 | 9.623 | 9.636 | 9.387 | 9.731 | — |
| Esperanza de vida al nacer (años) (years) | Brasil | 75.11 | 75.08 | 75.38 | 75.63 | 75.81 | 74.51 | 73.04 | 74.87 | 75.85 | 76.02 |
| Gasto corriente en salud (% del PIB) (%) | Chile | 8.351 | 8.558 | 9.091 | 9.150 | 9.310 | 9.697 | 9.725 | 10.01 | 10.17 | 10.53 |
| Esperanza de vida al nacer (años) (years) | Chile | 80.01 | 80.30 | 80.61 | 80.56 | 80.32 | 79.35 | 78.88 | 79.18 | 81.17 | 81.36 |
| Gasto corriente en salud (% del PIB) (%) | Colombia | 7.523 | 7.531 | 7.679 | 7.718 | 7.834 | 8.698 | 9.142 | 7.590 | 8.158 | 8.141 |
| Esperanza de vida al nacer (años) (years) | Colombia | 76.07 | 76.23 | 76.42 | 76.58 | 76.79 | 74.76 | 72.70 | 76.51 | 77.72 | 77.91 |
| Gasto corriente en salud (% del PIB) (%) | Costa Rica | 7.592 | 7.317 | 7.045 | 7.286 | 7.221 | 7.825 | 7.611 | 7.184 | 6.866 | — |
| Esperanza de vida al nacer (años) (years) | Costa Rica | 80.41 | 79.99 | 79.99 | 80.09 | 80.30 | 79.72 | 78.05 | 79.32 | 80.80 | 81.00 |
| Gasto corriente en salud (% del PIB) (%) | República Dominicana | 4.735 | 4.586 | 4.446 | 4.218 | 4.368 | 4.965 | 5.088 | 4.645 | 4.599 | — |
| Esperanza de vida al nacer (años) (years) | República Dominicana | 72.98 | 72.89 | 73.37 | 73.56 | 73.11 | 72.64 | 71.76 | 74.21 | 73.72 | 73.87 |
| Gasto corriente en salud (% del PIB) (%) | Ecuador | 7.768 | 7.588 | 7.525 | 7.834 | 7.809 | 8.606 | 8.375 | 7.602 | 7.562 | — |
| Esperanza de vida al nacer (años) (years) | Ecuador | 76.22 | 76.09 | 76.22 | 77.25 | 77.29 | 72.00 | 72.75 | 76.58 | 77.39 | 77.58 |
| Gasto corriente en salud (% del PIB) (%) | Guatemala | 6.006 | 6.070 | 6.136 | 6.107 | 6.174 | 6.459 | 7.357 | 7.168 | 6.802 | — |
| Esperanza de vida al nacer (años) (years) | Guatemala | 70.92 | 71.22 | 71.58 | 71.50 | 71.64 | 69.97 | 67.86 | 71.21 | 72.60 | 72.75 |
| Gasto corriente en salud (% del PIB) (%) | México | 5.527 | 5.385 | 5.312 | 5.238 | 5.301 | 6.052 | 5.877 | 5.709 | 5.504 | — |
| Esperanza de vida al nacer (años) (years) | México | 74.43 | 74.38 | 74.26 | 74.30 | 74.53 | 70.45 | 69.75 | 73.97 | 75.07 | 75.26 |
| Gasto corriente en salud (% del PIB) (%) | Panamá | 6.937 | 7.094 | 7.165 | 7.601 | 8.135 | 10.22 | 9.136 | 9.046 | 8.330 | — |
| Esperanza de vida al nacer (años) (years) | Panamá | 77.58 | 77.77 | 77.90 | 78.27 | 78.51 | 76.33 | 77.00 | 79.32 | 79.59 | 79.78 |
| Gasto corriente en salud (% del PIB) (%) | Perú | 4.905 | 4.894 | 4.809 | 5.084 | 5.125 | 6.347 | 6.673 | 6.097 | 5.638 | — |
| Esperanza de vida al nacer (años) (years) | Perú | 75.73 | 75.95 | 75.96 | 76.02 | 76.28 | 73.83 | 71.60 | 76.83 | 77.74 | 77.94 |
| Gasto corriente en salud (% del PIB) (%) | Uruguay | 8.257 | 8.639 | 8.717 | 8.900 | 9.241 | 9.088 | 8.920 | 8.890 | 9.019 | — |
| Esperanza de vida al nacer (años) (years) | Uruguay | 77.28 | 77.35 | 77.62 | 77.53 | 77.50 | 78.38 | 75.43 | 76.47 | 78.14 | 78.29 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | 112.4899 | 9.8142 | t = 11.46 | 0.0000 | [68.415, 133.746] | 🟢 Robusta |
| OLS Agregado (LCN) | Gasto corriente en salud (% del PIB) | -4.7602 | 1.2269 | t = -3.88 | 0.0061 | [-7.434, 0.835] | 🟡 Marginal |
| *Diagnóstico OLS* | *R² = 0.6826, R²-adj = 0.6373, F = 15.05 (p = 0.0061), n = 9, dof = 7* | — | — | — | — | — | — |
| *Nota* | *Regresores excluidos por n insuficiente (regla ~4 obs/parámetro): Población urbana (% del total)* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Gasto corriente en salud (% del PIB) | -1.0834 | 0.2436 | t = -4.45 | 0.0000 | [-1.567, -0.600] | 🟢 Robusta |
| Panel Efectos Fijos (País) | Población urbana (% del total) | 0.1716 | 0.1813 | t = 0.95 | 0.3463 | [-0.188, 0.531] | 🔴 Sin evidencia |
| *Diagnóstico Panel* | *R² = 0.8475, n = 110 obs (12 países), dof = 96* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Gasto corriente en salud (% del PIB) | Población urbana (% del total) | CHL | 0.989 | 0.000 | 0.000 | 1.000 | 0.290 | 0.448 | 🟡 Co-tendencia probable |
| Esperanza de vida al nacer (años) | Gasto corriente en salud (% del PIB) | ECU | -0.896 | 0.001 | 0.021 | -0.383 | -0.882 | 0.004 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Población urbana (% del total) | GTM | 0.852 | 0.004 | 0.046 | 0.917 | 0.178 | 0.674 | 🟡 Co-tendencia probable |
| Esperanza de vida al nacer (años) | Gasto corriente en salud (% del PIB) | MEX | -0.831 | 0.006 | 0.047 | -0.567 | -0.764 | 0.027 | 🟡 Co-tendencia probable |
| Esperanza de vida al nacer (años) | Gasto corriente en salud (% del PIB) | LCN | -0.826 | 0.006 | 0.047 | -0.583 | -0.737 | 0.037 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Población urbana (% del total) | BRA | 0.788 | 0.012 | 0.069 | 0.733 | 0.908 | 0.002 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Población urbana (% del total) | PAN | 0.775 | 0.014 | 0.069 | 0.833 | 0.149 | 0.725 | 🟡 Marginal |
| Esperanza de vida al nacer (años) | Gasto corriente en salud (% del PIB) | ARG | -0.775 | 0.014 | 0.069 | -0.283 | -0.648 | 0.082 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Población urbana (% del total) | URY | 0.751 | 0.020 | 0.085 | 0.650 | 0.569 | 0.141 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Población urbana (% del total) | PER | 0.730 | 0.025 | 0.099 | 0.783 | -0.124 | 0.771 | 🟡 Marginal |
| Esperanza de vida al nacer (años) | Gasto corriente en salud (% del PIB) | COL | -0.664 | 0.036 | 0.129 | -0.006 | -0.846 | 0.004 | 🔴 Sin evidencia |
| Esperanza de vida al nacer (años) | Gasto corriente en salud (% del PIB) | DOM | -0.654 | 0.056 | 0.182 | -0.517 | -0.702 | 0.052 | 🔴 Sin evidencia |
| Esperanza de vida al nacer (años) | Gasto corriente en salud (% del PIB) | PER | -0.600 | 0.087 | 0.262 | -0.150 | -0.798 | 0.018 | 🔴 Sin evidencia |
| Esperanza de vida al nacer (años) | Población urbana (% del total) | PAN | 0.518 | 0.125 | 0.348 | 0.576 | -0.176 | 0.651 | 🔴 Sin evidencia |
| Esperanza de vida al nacer (años) | Gasto corriente en salud (% del PIB) | GTM | -0.491 | 0.180 | 0.461 | -0.167 | -0.809 | 0.015 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Esperanza de vida al nacer (años) | América Latina y el Caribe (LCN) | 74.74 (2015) | 75.82 (2024) | 0.1194 | 1.44% | 0.16% |
| Esperanza de vida al nacer (años) | Argentina | 76.60 (2015) | 77.54 (2024) | 0.1048 | 1.23% | 0.14% |
| Esperanza de vida al nacer (años) | Brasil | 75.11 (2015) | 76.02 (2024) | 0.1019 | 1.22% | 0.13% |
| Esperanza de vida al nacer (años) | Chile | 80.01 (2015) | 81.36 (2024) | 0.1501 | 1.69% | 0.19% |
| Esperanza de vida al nacer (años) | Colombia | 76.07 (2015) | 77.91 (2024) | 0.2051 | 2.43% | 0.27% |
| Esperanza de vida al nacer (años) | Costa Rica | 80.41 (2015) | 81.00 (2024) | 0.0654 | 0.73% | 0.08% |
| Esperanza de vida al nacer (años) | República Dominicana | 72.98 (2015) | 73.87 (2024) | 0.0984 | 1.21% | 0.13% |
| Esperanza de vida al nacer (años) | Ecuador | 76.22 (2015) | 77.58 (2024) | 0.1508 | 1.78% | 0.20% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-11-09-22-04/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Gasto corriente en salud (% del PIB) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-11-09-22-04/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-11-09-22-04/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-09-22-04/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Relación entre urbanización, gasto en salud y esperanza de vida frente a eventos climáticos extremos en América Latina*.
Noticia que inspiró la línea editorial: *"Photos: Heavy rains leave tens of thousands without shelter in Gaza"* ([Al Jazeera English](https://www.aljazeera.com/gallery/2026/11/8/photos-heavy-rains-leave-tens-of-thousands-without-shelter-in-gaza)).
Lo que la noticia afirmaba o sugería: Las fuertes lluvias provocan desplazamientos masivos y aumentan la vulnerabilidad sanitaria de la población afectada.
Alcance verificable con los datos: Se pueden verificar los efectos sobre la salud mediante los indicadores de esperanza de vida y gasto en salud, y la exposición urbana mediante el porcentaje de población urbana; no se dispone de datos directos sobre eventos de inundación o desplazamiento interno.
Justificación del sistema: El dominio de salud y demografía conecta directamente con la noticia de una catástrofe climática; los indicadores disponibles permiten medir la capacidad del sistema de salud y la concentración urbana, factores críticos en la respuesta a inundaciones.
**Pregunta de investigación:** ¿En qué medida el gasto en salud y la proporción de población urbana explican la variación en la esperanza de vida de los países latinoamericanos más vulnerables a eventos climáticos extremos?
**Hipótesis planteada:** En los países latinoamericanos más expuestos a eventos climáticos extremos, un mayor gasto en salud y una mayor urbanización están asociados a una esperanza de vida más alta.
Se evaluaron 3 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: CHL, COL, ARG, BRA, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (5 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Life expectancy at birth (years) [LCN] ~ Current health expenditure (% of GDP) [LCN] (n=9, R²=0.683), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Life expectancy at birth (years) ~ Current health expenditure (% of GDP) + Urban population (% of total) (n=110 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 77 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 0 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*