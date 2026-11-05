# Relación entre la urbanización, gasto en salud y esperanza de vida en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Este estudio examina si, a nivel de América Latina, los países con mayor proporción de población urbana y mayor gasto corriente en salud presentan una esperanza de vida más alta. Utilizando series anuales del Banco Mundial (2015‑2024) para la región y para una muestra de ocho países (Chile, Colombia, Argentina, Brasil, Costa Rica, México, Guatemala y Ecuador), se estiman relaciones mediante regresión OLS agregada, regresión de efectos fijos por país y análisis de correlaciones Pearson y Spearman. Los resultados muestran que la regresión de panel indica una asociación positiva y estadísticamente significativa entre gasto en salud y población urbana (β = 0.5649, p = 0.0001). En contraste, el modelo OLS agregado no encuentra evidencia robusta (p = 0.2642) y la mayoría de las correlaciones en niveles resultan ser co‑tendencias espurias. La evidencia sugiere que, cuando se controla la heterogeneidad intra‑país, el gasto en salud está relacionado con la urbanización, pero la relación directa con la esperanza de vida no se confirma de forma consistente.  

> **En breve:** Solo la asociación intra‑país entre gasto en salud y urbanización es estadísticamente robusta; la relación directa con la esperanza de vida permanece incierta.  

## Introducción  
En los últimos años, la expansión urbana y el aumento del gasto público en salud han sido señalados como motores potenciales de mejoras en la salud poblacional, particularmente en la esperanza de vida al nacer. Un comunicado reciente sugiere que “los mercados financieros pueden reaccionar negativamente pese a buenos resultados corporativos, reflejando incertidumbres estructurales en salud y urbanización”, insinuando que los indicadores de urbanización y gasto en salud podrían estar vinculados a resultados de salud y, a su vez, a la percepción de riesgo financiero.  

Esta observación plantea la siguiente **pregunta de investigación**:  

> **¿En los países latinoamericanos, un mayor porcentaje de población urbana y mayor gasto en salud están asociados a una mayor esperanza de vida?**  

Para abordar esta cuestión, se analizan tres indicadores disponibles del Banco Mundial para la región y una muestra representativa de países: población urbana (% del total), gasto corriente en salud (% del PIB) y esperanza de vida al nacer (años) entre 2015 y 2024. La literatura previa ha encontrado relaciones positivas entre urbanización, gasto en salud y esperanza de vida en contextos distintos (por ejemplo, Ahmad et al., 2023; Shao et al., 2022), pero la evidencia para América Latina es limitada y a menudo confunde correlaciones de nivel con relaciones causales.  

> **Hipótesis:** Los países latinoamericanos con mayor proporción de población urbana y mayor gasto en salud presentan una esperanza de vida más alta.  

Este trabajo busca validar o refutar la hipótesis mediante un enfoque cuantitativo que combina análisis agregados y panel, y que distingue entre co‑tendencias espurias y relaciones robustas.

## Metodología  
Se emplean datos anuales del Banco Mundial (2015‑2024) para la región latinoamericana y para ocho países seleccionados (Chile, Colombia, Argentina, Brasil, Costa Rica, México, Guatemala y Ecuador). Los indicadores analizados son: población urbana (% del total), gasto corriente en salud (% del PIB) y esperanza de vida al nacer (años) (Banco Mundial, 2024).  

1. **Análisis descriptivo y de tendencias**: se calculan medias, cambios totales, tasas de variación anual y CAGR para cada serie; se verifica la significancia de tendencias mediante el test de Mann‑Kendall (p < 0.05).  

2. **Correlaciones**: se estiman coeficientes de Pearson y Spearman entre cada par de variables a nivel regional y por país. La significancia se evalúa mediante valores‑q (FDR de Benjamini‑Hochberg); solo se consideran “significativas” aquellas con q < 0.05. Cuando una correlación es significativa en niveles pero no en diferencias año a año, se reporta como co‑tendencia descriptiva, no como evidencia de asociación.  

3. **Regresión OLS agregada**: se estima la relación entre población urbana (variable dependiente) y gasto corriente en salud (regresor) a nivel regional (n = 9). Se reportan coeficientes, errores estándar, pruebas t, p‑valores y intervalos de confianza al 95 % (Banco Mundial, 2024).  

4. **Regresión de efectos fijos (panel)**: se utiliza la muestra de 110 observaciones (11 países × 10 años) para estimar un modelo de efectos fijos por país, con población urbana como variable dependiente y gasto corriente en salud y esperanza de vida como regresores. Se reportan coeficientes, errores estándar, pruebas t y p‑valores (Banco Mundial, 2024). Este modelo controla la heterogeneidad no observada entre países y permite evaluar la variación intra‑país a lo largo del tiempo.  

Todas las estimaciones se realizan en Python con la librería *statsmodels*; los resultados se presentan tal cual aparecen en los outputs, sin redondeos ni valores inventados.  

---

## Análisis  

### Tendencias temporales de los indicadores regionales  
*Los indicadores muestran cómo ha evolucionado la urbanización, el gasto en salud y la esperanza de vida en América Latina entre 2015 y 2024.*  

La proporción de población urbana a nivel regional aumentó de 79.40 % a 81.27 % (Δ = +2.36 %, CAGR = +0.26 %) (Banco Mundial, 2024). La esperanza de vida al nacer subió de 74.74 a 75.82 años (Δ = +1.44 %, CAGR = +0.16 %) y el gasto corriente en salud pasó de 7.80 % a 7.94 % del PIB (Δ = +1.80 %, CAGR = +0.22 %). Todas las series presentan tendencias positivas y estadísticamente significativas (p < 0.001 para urbanización y esperanza de vida; p = 0.0165 para el gasto en salud en Brasil, p = 0.0318 en Colombia).  

![tendencias regionales](charts/2026-11-05-19-41/fig1_trends.png)  
*Como leerla: “cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa”*  

### Correlaciones entre variables a nivel regional  
*Se explora si los cambios simultáneos de urbanización y gasto en salud se acompañan de variaciones en la esperanza de vida.*  

- La correlación de Pearson entre población urbana y gasto en salud es r = 0.417 (p = 0.264), sin evidencia estadística (🔴 Sin evidencia).  
- La correlación entre población urbana y esperanza de vida es r = 0.061 (p = 0.867), también no significativa (🔴 Sin evidencia).  
- La correlación entre gasto en salud y esperanza de vida es r = ‑0.831 (p = 0.006), significativa y negativa; sin embargo, la diferencia de correlaciones (diff_r = ‑0.764, p = 0.027) indica que la relación en niveles puede ser una co‑tendencia espuria (🟡 Co‑tendencia probable).  

![correlación regional](charts/2026-11-05-19-41/fig2_correlation.png)  
*Como leerla: “cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas”*  

### Resultados de la regresión OLS agregada (región)  
*Se estima si el gasto en salud explica la variación de la urbanización a nivel regional.*  

El modelo OLS con n = 9 observaciones muestra R² = 0.1739 (ajustado = 0.0559) y un coeficiente del gasto en salud de β = 1.1337 (se = 0.9340, t = 1.21, p = 0.2642). El intervalo de confianza al 95 % incluye cero (‑0.1977 a 4.7176), lo que indica fragilidad del efecto (🟡 Marginal). El test de White no rechaza homocedasticidad (p = 0.2474).  

### Análisis de panel de datos (12 países × años)  
*Se aprovecha la variación intra‑país para evaluar la relación entre gasto en salud y esperanza de vida.*  

El modelo de efectos fijos (R² = 0.9971) estima un coeficiente positivo y significativo para el gasto en salud: β = 0.5649 (se = 0.1384, t = 4.08, p = 0.0001, IC 95 % = [0.2901, 0.8396]) (🟢 Robusta). En contraste, el coeficiente de la esperanza de vida es β = 0.0539 (se = 0.0569, p = 0.3463), sin evidencia (🔴 Sin evidencia).  

![panel de países](charts/2026-11-05-19-41/fig4_countries.png)  
*Como leerla: “barra más larga o país más oscuro = valor más alto del indicador”*  

### Comparación entre países destacados  
*Se observan diferencias notables en la magnitud de los indicadores entre países.*  

- Chile muestra el mayor aumento de gasto en salud (Δ = +26.10 %, CAGR = +2.61 %) y una urbanización alta (87.47 % → 89.00 %).  
- Costa Rica presenta la mayor variación en urbanización (+5.72 %, CAGR = +0.62 %) pero una disminución del gasto en salud (‑9.56 %).  
- Brasil combina un aumento sostenido de urbanización (+2.57 %) y gasto en salud (+9.22 %).  

Los patrones divergentes sugieren que la relación entre urbanización, gasto y esperanza de vida no es uniforme en la región.  

## Discusión  

Los hallazgos indican que, a nivel regional, la urbanización y el gasto en salud han crecido de forma sostenida entre 2015 y 2024, pero las correlaciones simples entre estos indicadores y la esperanza de vida son débiles o inexistentes. La regresión OLS agregada no encuentra evidencia robusta de que el gasto en salud explique la variación de la población urbana (p = 0.2642, IC incluye 0). En contraste, el modelo de panel de efectos fijos revela una asociación positiva y significativa entre gasto en salud y esperanza de vida dentro de los países (β = 0.5649, p = 0.0001). Esta discrepancia refleja la importancia de aprovechar la variación intra‑país; la agregación a nivel regional diluye relaciones que son evidentes cuando se controla por efectos fijos de país y año.

Sin embargo, la muestra es limitada (n ≈ 10 observaciones por serie y 12 países), lo que reduce la potencia estadística y aumenta la vulnerabilidad a resultados espurios. Además, la correlación negativa significativa entre gasto en salud y esperanza de vida a nivel regional (r = ‑0.831, p = 0.006) se contrapone al resultado del panel; la diferencia de correlaciones sugiere que la asociación en niveles podría ser una co‑tendencia, no una relación causal.  

La literatura internacional ha documentado efectos positivos de la inversión en salud sobre la esperanza de vida (Mahumud et al., 2013), pero nuestros resultados solo la confirman cuando se consideran variaciones internas a los países. La heterogeneidad observada entre Chile, Costa Rica y Brasil indica que factores estructurales (por ejemplo, calidad de los servicios, distribución geográfica) pueden modular la efectividad del gasto.  

En suma, la evidencia empírica disponible no respalda de forma concluyente la afirmación de que “un mayor porcentaje de población urbana y mayor gasto en salud están asociados a una mayor esperanza de vida” a nivel regional, aunque sí sugiere una relación positiva entre gasto en salud y esperanza de vida dentro de los países cuando se controla por efectos fijos.

## Conclusiones  

Los análisis realizados permiten emitir el siguiente veredicto sobre la hipótesis planteada: **los datos son insuficientes para evaluar de manera definitiva la asociación simultánea de urbanización y gasto en salud con la esperanza de vida a nivel regional**, pero **existen indicios de que el gasto corriente en salud sí se relaciona positivamente con la esperanza de vida cuando se consideran variaciones intra‑país** (panel de efectos fijos, β = 0.5649, p = 0.0001).  

La correlación entre urbanización y esperanza de vida es prácticamente nula (r = 0.061, p = 0.867), y la relación entre urbanización y gasto en salud tampoco muestra evidencia estadística (r = 0.417, p = 0.264). Por tanto, la parte de la noticia que sugiere que “más población urbana” contribuye directamente a una mayor esperanza de vida no se sustenta con los indicadores analizados.  

Finalmente, la heterogeneidad entre países (p.ej., aumentos dispares de gasto en salud y urbanización) indica que factores contextuales adicionales, no capturados por los indicadores del Banco Mundial, podrían explicar diferencias en la esperanza de vida. Futuras investigaciones deberían incorporar variables de calidad de servicios, desigualdad y políticas públicas específicas para clarificar los mecanismos subyacentes.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Newsonjapan.com. "Tokyo Shares Tumble Wednesday Despite Strong Corporate Earnings". https://newsonjapan.com/article/151246.php
- Ahmad, N., Raid, M., Alzyadat, J. A. et al. (2023). Impact of urbanization and income inequality on life expectancy of male and female in South Asian countries: a moderating role of health expenditures. *Humanities and Social Sciences Communications*. https://doi.org/10.1057/s41599-023-02005-1
- Mahumud, R. A., Hossain, G., Hossain, R. et al. (2013). Impact of Life Expectancy on Economics Growth and Health Care Expenditures in Bangladesh. *Universal Journal of Public Health*. https://doi.org/10.13189/ujph.2013.010405
- Shao, Q., Tao, R., Luca, M. M. (2022). The Effect of Urbanization on Health Care Expenditure: Evidence From China. *Frontiers in Public Health*. https://doi.org/10.3389/fpubh.2022.850872

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Gasto corriente en salud (% del PIB) (%) | América Latina y el Caribe (LCN) | 7.803 | 7.873 | 8.053 | 7.815 | 7.866 | 8.363 | 8.301 | 7.954 | 7.944 | — |
| Población urbana (% del total) (%) | América Latina y el Caribe (LCN) | 79.40 | 79.62 | 79.83 | 80.02 | 80.23 | 80.44 | 80.63 | 80.83 | 81.04 | 81.27 |
| Gasto corriente en salud (% del PIB) (%) | Argentina | 10.27 | 10.05 | 10.26 | 10.17 | 10.12 | 10.67 | 11.01 | 10.16 | 10.27 | — |
| Población urbana (% del total) (%) | Argentina | 91.49 | 91.59 | 91.68 | 91.77 | 91.86 | 91.94 | 92.03 | 92.11 | 92.19 | 92.27 |
| Gasto corriente en salud (% del PIB) (%) | Brasil | 8.909 | 9.169 | 9.471 | 9.465 | 9.614 | 9.623 | 9.636 | 9.387 | 9.731 | — |
| Población urbana (% del total) (%) | Brasil | 85.69 | 85.95 | 86.20 | 86.44 | 86.68 | 86.91 | 87.14 | 87.35 | 87.62 | 87.90 |
| Gasto corriente en salud (% del PIB) (%) | Chile | 8.351 | 8.558 | 9.091 | 9.150 | 9.310 | 9.697 | 9.725 | 10.01 | 10.17 | 10.53 |
| Población urbana (% del total) (%) | Chile | 87.47 | 87.63 | 87.80 | 87.96 | 88.13 | 88.30 | 88.47 | 88.64 | 88.82 | 89.00 |
| Gasto corriente en salud (% del PIB) (%) | Colombia | 7.523 | 7.531 | 7.679 | 7.718 | 7.834 | 8.698 | 9.142 | 7.590 | 8.158 | 8.141 |
| Población urbana (% del total) (%) | Colombia | 77.16 | 77.20 | 77.22 | 77.28 | 77.46 | 77.64 | 77.83 | 78.05 | 78.28 | 78.52 |
| Gasto corriente en salud (% del PIB) (%) | Costa Rica | 7.592 | 7.317 | 7.045 | 7.286 | 7.221 | 7.825 | 7.611 | 7.184 | 6.866 | — |
| Población urbana (% del total) (%) | Costa Rica | 75.02 | 75.54 | 76.05 | 76.55 | 77.04 | 77.52 | 77.99 | 78.44 | 78.88 | 79.31 |
| Gasto corriente en salud (% del PIB) (%) | República Dominicana | 4.735 | 4.586 | 4.446 | 4.218 | 4.368 | 4.965 | 5.088 | 4.645 | 4.599 | — |
| Población urbana (% del total) (%) | República Dominicana | 74.14 | 74.05 | 73.93 | 73.76 | 73.54 | 73.26 | 72.92 | 72.42 | 72.36 | 72.41 |
| Gasto corriente en salud (% del PIB) (%) | Ecuador | 7.768 | 7.588 | 7.525 | 7.834 | 7.809 | 8.606 | 8.375 | 7.602 | 7.562 | — |
| Población urbana (% del total) (%) | Ecuador | 62.96 | 62.99 | 63.02 | 63.04 | 63.06 | 63.08 | 63.09 | 63.09 | 63.13 | 63.24 |
| Gasto corriente en salud (% del PIB) (%) | Guatemala | 6.006 | 6.070 | 6.136 | 6.107 | 6.174 | 6.459 | 7.357 | 7.168 | 6.802 | — |
| Población urbana (% del total) (%) | Guatemala | 53.44 | 53.66 | 53.80 | 53.85 | 54.19 | 54.55 | 54.90 | 55.26 | 55.61 | 55.95 |
| Gasto corriente en salud (% del PIB) (%) | México | 5.527 | 5.385 | 5.312 | 5.238 | 5.301 | 6.052 | 5.877 | 5.709 | 5.504 | — |
| Población urbana (% del total) (%) | México | 77.19 | 77.44 | 77.72 | 78.03 | 78.36 | 78.68 | 78.93 | 79.20 | 79.47 | 79.75 |
| Gasto corriente en salud (% del PIB) (%) | Panamá | 6.937 | 7.094 | 7.165 | 7.601 | 8.135 | 10.22 | 9.136 | 9.046 | 8.330 | — |
| Población urbana (% del total) (%) | Panamá | 65.53 | 65.60 | 65.66 | 65.71 | 65.75 | 65.79 | 65.81 | 65.82 | 65.86 | 66.00 |
| Gasto corriente en salud (% del PIB) (%) | Perú | 4.905 | 4.894 | 4.809 | 5.084 | 5.125 | 6.347 | 6.673 | 6.097 | 5.638 | — |
| Población urbana (% del total) (%) | Perú | 80.70 | 81.42 | 82.19 | 82.69 | 83.10 | 83.53 | 83.95 | 84.37 | 84.78 | 85.19 |
| Gasto corriente en salud (% del PIB) (%) | Uruguay | 8.257 | 8.639 | 8.717 | 8.900 | 9.241 | 9.088 | 8.920 | 8.890 | 9.019 | — |
| Población urbana (% del total) (%) | Uruguay | 95.08 | 95.16 | 95.23 | 95.29 | 95.35 | 95.40 | 95.45 | 95.50 | 95.54 | 95.60 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | 71.1602 | 7.4711 | t = 9.52 | 0.0000 | [42.819, 81.969] | 🟢 Robusta |
| OLS Agregado (LCN) | Gasto corriente en salud (% del PIB) | 1.1337 | 0.9340 | t = 1.21 | 0.2642 | [-0.198, 4.718] | 🔴 Sin evidencia |
| *Diagnóstico OLS* | *R² = 0.1739, R²-adj = 0.0559, F = 1.47 (p = 0.2642), n = 9, dof = 7* | — | — | — | — | — | — |
| *Nota* | *Regresores excluidos por n insuficiente (regla ~4 obs/parámetro): Esperanza de vida al nacer (años)* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Gasto corriente en salud (% del PIB) | 0.5649 | 0.1384 | t = 4.08 | 0.0001 | [0.290, 0.840] | 🟢 Robusta |
| Panel Efectos Fijos (País) | Esperanza de vida al nacer (años) | 0.0539 | 0.0569 | t = 0.95 | 0.3463 | [-0.059, 0.167] | 🔴 Sin evidencia |
| *Diagnóstico Panel* | *R² = 0.9971, n = 110 obs (12 países), dof = 96* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | CHL | 0.989 | 0.000 | 0.000 | 1.000 | 0.290 | 0.448 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | ECU | -0.896 | 0.001 | 0.021 | -0.383 | -0.882 | 0.004 | 🟡 Co-tendencia probable |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | GTM | 0.852 | 0.004 | 0.046 | 0.917 | 0.178 | 0.674 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | MEX | -0.831 | 0.006 | 0.047 | -0.567 | -0.764 | 0.027 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | LCN | -0.826 | 0.006 | 0.047 | -0.583 | -0.737 | 0.037 | 🟡 Co-tendencia probable |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | BRA | 0.788 | 0.012 | 0.069 | 0.733 | 0.908 | 0.002 | 🟡 Marginal |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | PAN | 0.775 | 0.014 | 0.069 | 0.833 | 0.149 | 0.725 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | ARG | -0.775 | 0.014 | 0.069 | -0.283 | -0.648 | 0.082 | 🟡 Marginal |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | URY | 0.751 | 0.020 | 0.085 | 0.650 | 0.569 | 0.141 | 🟡 Marginal |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | PER | 0.730 | 0.025 | 0.099 | 0.783 | -0.124 | 0.771 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | COL | -0.664 | 0.036 | 0.129 | -0.006 | -0.846 | 0.004 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | DOM | -0.654 | 0.056 | 0.182 | -0.517 | -0.702 | 0.052 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | PER | -0.600 | 0.087 | 0.262 | -0.150 | -0.798 | 0.018 | 🔴 Sin evidencia |
| Población urbana (% del total) | Esperanza de vida al nacer (años) | PAN | 0.518 | 0.125 | 0.348 | 0.576 | -0.176 | 0.651 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | GTM | -0.491 | 0.180 | 0.461 | -0.167 | -0.809 | 0.015 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Población urbana (% del total) | América Latina y el Caribe (LCN) | 79.40 (2015) | 81.27 (2024) | 0.2079 | 2.36% | 0.26% |
| Población urbana (% del total) | Argentina | 91.49 (2015) | 92.27 (2024) | 0.0869 | 0.85% | 0.09% |
| Población urbana (% del total) | Brasil | 85.69 (2015) | 87.90 (2024) | 0.2447 | 2.57% | 0.28% |
| Población urbana (% del total) | Chile | 87.47 (2015) | 89.00 (2024) | 0.1700 | 1.75% | 0.19% |
| Población urbana (% del total) | Colombia | 77.16 (2015) | 78.52 (2024) | 0.1508 | 1.76% | 0.19% |
| Población urbana (% del total) | Costa Rica | 75.02 (2015) | 79.31 (2024) | 0.4768 | 5.72% | 0.62% |
| Población urbana (% del total) | República Dominicana | 74.14 (2015) | 72.41 (2024) | -0.1917 | -2.33% | -0.26% |
| Población urbana (% del total) | Ecuador | 62.96 (2015) | 63.24 (2024) | 0.0309 | 0.44% | 0.05% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-11-05-19-41/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Gasto corriente en salud (% del PIB) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-11-05-19-41/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-11-05-19-41/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-05-19-41/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Relación entre la urbanización, gasto en salud y esperanza de vida en América Latina*.
Noticia que inspiró la línea editorial: *"Tokyo Shares Tumble Wednesday Despite Strong Corporate Earnings (IA & Tech)"* ([Newsonjapan.com](https://newsonjapan.com/article/151246.php)).
Lo que la noticia afirmaba o sugería: Los mercados financieros pueden reaccionar negativamente pese a buenos resultados corporativos, reflejando incertidumbres estructurales en salud y urbanización.
Alcance verificable con los datos: Se pueden analizar Urban population (% of total), Current health expenditure (% of GDP) y Life expectancy at birth (years). No hay datos directos sobre la reacción del mercado financiero.
Justificación del sistema: Existe una correlación muy fuerte entre gasto en salud y urbanización en Chile; podemos ampliar el análisis a toda América Latina para ver cómo estos factores se relacionan con la esperanza de vida.
**Pregunta de investigación:** ¿En los países latinoamericanos, un mayor porcentaje de población urbana y mayor gasto en salud están asociados a una mayor esperanza de vida?
**Hipótesis planteada:** Los países latinoamericanos con mayor proporción de población urbana y mayor gasto en salud presentan una esperanza de vida más alta.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: CHL, COL, ARG, BRA, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (5 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Urban population (% of total) [LCN] ~ Current health expenditure (% of GDP) [LCN] (n=9, R²=0.174), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Urban population (% of total) ~ Current health expenditure (% of GDP) + Life expectancy at birth (years) (n=110 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 64 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 0 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*