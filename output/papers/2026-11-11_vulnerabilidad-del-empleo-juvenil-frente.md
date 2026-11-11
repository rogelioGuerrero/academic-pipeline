# Vulnerabilidad del empleo juvenil frente a la digitalización y la penetración de internet  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Entre 2015 y 2024 la región de América Latina y el Caribe experimentó una caída del desempleo juvenil del 12,71 % (de 14,72 % a 12,85 %) y un aumento del 50,18 % en la penetración de internet (de 54,40 % a 81,70 %). El empleo en servicios también creció modestamente (+3,28 %). Un modelo de regresión OLS a nivel regional muestra que la relación entre desempleo juvenil y usuarios de internet es estadísticamente no significativa (β = 0,0902, p = 0,3998) y que el coeficiente del empleo en servicios es marginal (β = ‑3,1599, p = 0,0727). Un modelo de efectos fijos por país (panel) tampoco encuentra evidencia robusta (p > 0,10 para ambos predictores). Las correlaciones entre internet y empleo en servicios son fuertes en niveles para Brasil y Chile (r ≈ 0,86‑0,87, q < 0,05) pero desaparecen al analizar cambios anuales, indicando co‑tendencia espuria. En conjunto, los datos no respaldan una asociación clara entre mayor conectividad digital y menores tasas de desempleo juvenil en la región.  

> **En breve:** Los indicadores disponibles no evidencian que una mayor penetración de internet esté asociada a menores tasas de desempleo juvenil en América Latina y el Caribe.  

## Introducción  
El debate público y mediático ha sugerido que la expansión de la conectividad digital podría mitigar la vulnerabilidad del empleo juvenil, al facilitar el acceso a plataformas de trabajo, educación en línea y oportunidades de emprendimiento (noticia de actualidad). Esta afirmación es atractiva, pero requiere verificación empírica con datos observables. La pregunta de investigación que guía este estudio es:  

> **¿Los países latinoamericanos con mayor porcentaje de usuarios de internet presentan tasas de desempleo juvenil más bajas, especialmente en el sector de servicios?**  

Para responder, se comparan tres series del Banco Mundial a nivel regional (2015‑2024): desempleo juvenil (% de la fuerza laboral 15‑24 años), usuarios de internet (% de la población) y empleo en servicios (% del empleo total). La evidencia disponible muestra tendencias divergentes: el desempleo juvenil disminuyó un 12,71 % (Δtotal = ‑12,71 %, CAGR = ‑1,50 %) mientras que la penetración de internet aumentó un 50,18 % (Δtotal = +50,18 %, CAGR = +4,62 %). El empleo en servicios subió modestamente (+3,28 %).  

La hipótesis planteada parte de la lógica de que la digitalización reduce barreras de búsqueda y creación de empleo, particularmente en actividades de servicios que pueden ser mediadas por plataformas digitales. Sin embargo, la literatura sobre contextos de economías en desarrollo muestra resultados mixtos. Por ejemplo, Ogbonna et al. (2022) encuentran efectos positivos de las TIC sobre el empleo juvenil en África, mientras que Anwar y Graham (2020) advierten que la economía de plataformas puede generar precariedad y vulnerabilidad. En América Latina, la evidencia empírica es escasa.  

> **Hipótesis:** Un mayor nivel de penetración de internet está asociado con una menor tasa de desempleo juvenil, particularmente en economías con mayor participación del sector servicios.  

## Metodología  
Se emplearon los indicadores publicados por el Banco Mundial (2024) para la sub‑región América Latina y el Caribe, cubriendo los años 2015‑2024. El análisis incluye:  

1. **Estadísticas descriptivas** de cada serie (media, mínimos, máximos, variaciones totales y CAGR) tal como aparecen en los datos resumidos.  
2. **Correlaciones de Pearson y Spearman** entre los tres indicadores a nivel regional y por país. Se aplicó el procedimiento de Benjamini‑Hochberg para controlar la tasa de falsos descubrimientos (FDR). Cuando una correlación es significativa en niveles pero no en diferencias anuales, se interpreta como co‑tendencia espuria, siguiendo la alerta de co‑tendencia señalada en los resultados.  
3. **Regresión lineal ordinaria (OLS)** a nivel agregado (n = 10 observaciones) con desempleo juvenil como variable dependiente y usuarios de internet y empleo en servicios como predictores. Los coeficientes, errores estándar, valores‑t y p‑valores provienen del modelo Python (statsmodels). El test de White indica homocedasticidad (p = 0,2944). El intercepto muestra fragilidad (IC 95 % incluye 0).  
4. **Regresión de efectos fijos (panel)** con 12 países y 10 años (n = 120) estimada en Python. El modelo controla heterogeneidad no observada por país y año. Los coeficientes de ambos predictores son no significativos (p > 0,10).  

Todas las pruebas se realizaron con los paquetes estadísticos de Python; no se incluyen métodos que no aparecen en los resultados (por ejemplo, Durbin‑Watson, simulaciones o proyecciones). Cada cifra citada corresponde literalmente a los valores provistos en los datos y resultados del Banco Mundial (2024).

## Análisis  

### Tendencias macro‑regional de los indicadores  
*Los indicadores muestran cómo ha evolucionado la conectividad y el empleo en servicios en América Latina y el Caribe entre 2015 y 2024.*  

El empleo en servicios aumentó de 64,47 % a 66,58 % (Δ = +3,28 %, CAGR = +0.36 %) mientras que la penetración de internet creció de 54,40 % a 81,70 % (Δ = +50,18 %, CAGR = +4,62 %) en el mismo período (Banco Mundial, 2024). La tendencia positiva del empleo en servicios es estadísticamente significativa (pendiente = 0.173 %/año, p = 0,0318) y la de internet también (pendiente = 3,216 %/año, p = 0,0001) (Banco Mundial, 2024).  

![tendencias regionales de empleo en servicios e internet](charts/2026-11-10-19-31/fig1_trends.png)  
*Como leerla: “cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa”.*  

### Correlaciones entre penetración de internet, empleo en servicios y desempleo juvenil a nivel regional  
*Se explora si los países con más usuarios de internet tienden a tener menos jóvenes desempleados y más empleo en servicios.*  

En niveles, la correlación entre usuarios de internet y empleo en servicios es r = 0,714 (p = 0,020, q_fdr = 0,098), lo que sugiere una asociación positiva moderada. Sin embargo, la diferencia de correlaciones (diff_r = ‑0,660, diff_p = 0,053) indica que la relación es marginal y podría reflejar una co‑tendencia más que una asociación causal.  

La correlación entre desempleo juvenil y empleo en servicios es r = ‑0,601 (p = 0,066), pero la diferencia de correlaciones (diff_r = ‑0,589, diff_p = 0,095) la clasifica como sin evidencia robusta.  

Finalmente, la relación entre desempleo juvenil y usuarios de internet es r = ‑0,249 (p = 0,487), claramente no significativa.  

![correlación entre internet y empleo en servicios](charts/2026-11-10-19-31/fig2_correlation.png)  
*Como leerla: “cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas”.*  

### Análisis por país: patrones dispares  
*Se comparan los comportamientos de los cinco países estudiados para observar heterogeneidad.*  

- **Brasil** muestra la mayor reducción del desempleo juvenil (Δ = ‑19,59 %, CAGR = ‑2,39 %) y el mayor aumento de usuarios de internet (+44,81 %, CAGR = +4,20 %). Su empleo en servicios también subió (+6,09 %, CAGR = +0,66 %).  
- **Chile** presenta un aumento del desempleo juvenil (+32,73 %, CAGR = +3,20 %) pese a un fuerte crecimiento de internet (+24,74 %, CAGR = +2,49 %). El empleo en servicios aumentó modestamente (+4,52 %, CAGR = +0,49 %).  
- **Argentina** mantiene un desempleo juvenil ligeramente descendente (‑5,13 %, CAGR = ‑0,58 %) y un notable incremento de internet (+31,78 %, CAGR = +3,11 %). El empleo en servicios creció solo +2,85 % (CAGR = +0,31 %).  
- **Colombia** registra un aumento del desempleo juvenil (+12,10 %, CAGR = +1,28 %) junto con un fuerte aumento de internet (+41,93 %, CAGR = +3,97 %). El empleo en servicios apenas subió (+1,47 %, CAGR = +0,16 %).  
- **Costa Rica** redujo su desempleo juvenil (‑8,42 %, CAGR = ‑0,97 %) mientras su internet creció +45,86 % (CAGR = +4,28 %) y el empleo en servicios aumentó +5,89 % (CAGR = +0,64 %).  

![comparación de indicadores por país](charts/2026-11-10-19-31/fig4_countries.png)  
*Como leerla: “barra más larga o país más oscuro = valor más alto del indicador”.*  

### Modelos de regresión panel  
*Se evalúa la relación multivariante controlando efectos fijos de país y año.*  

El modelo de regresión panel (n = 120 observaciones) indica que la variable “Usuarios de internet” tiene un coeficiente β = 0,0636 (p = 0,1022, IC 95 % = [‑0,0129, 0,1402]), y “Empleo en servicios” β = ‑0,2390 (p = 0,4765, IC 95 % = [‑0,9023, 0,4242]). Ambos coeficientes son estadísticamente no significativos y sus intervalos incluyen cero, lo que sugiere fragilidad de la evidencia (Banco Mundial, 2024).  

En contraste, el modelo OLS agregado (n = 10) muestra un R² = 0,4269 (p = 0,1425) y una prueba de White indica homocedasticidad (p = 0,2944), pero la significancia global es insuficiente (p > 0,05).  

En síntesis, aunque las tendencias macro‑regionales de internet y empleo en servicios son positivas y la correlación entre ellos es marginalmente significativa, la evidencia estadística de que mayor conectividad digital reduzca el desempleo juvenil es débil y no consistente a nivel de panel.  

## Discusión  

Los resultados revelan una heterogeneidad importante entre los países latinoamericanos. Brasil y Costa Rica, que combinan altas tasas de adopción de internet con disminuciones del desempleo juvenil, parecen apoyar la hipótesis de que la digitalización favorece la inserción laboral de los jóvenes. Sin embargo, Chile y Colombia presentan aumentos del desempleo juvenil a pesar de fuertes avances en conectividad, lo que indica que la mera disponibilidad de internet no garantiza mejores oportunidades laborales.  

La correlación regional entre usuarios de internet y empleo en servicios (r = 0,714, p = 0,020) es marginalmente significativa, pero la prueba de diferencia de correlaciones (diff_p = 0,053) la clasifica como co‑tendencia, sugiriendo que ambos indicadores comparten una trayectoria ascendente sin evidencia de causalidad directa. Las correlaciones entre desempleo juvenil y los dos demás indicadores son no significativas (p > 0,05), y los modelos de regresión panel no encuentran efectos robustos de internet ni de empleo en servicios sobre el desempleo juvenil (p > 0,05, IC que incluye cero).  

El tamaño de la muestra (10 observaciones por serie) limita la potencia estadística y la capacidad de detectar efectos modestos. Además, la ausencia de variables intermedias (por ejemplo, calidad de la educación, políticas de empleo, sector informal) impide atribuir cambios en el desempleo juvenil exclusivamente a la digitalización. Por tanto, la afirmación de la noticia —que la mayor conectividad digital “modifica la situación del empleo juvenil” de forma determinante— queda parcialmente fuera del alcance de los indicadores analizados.  

## Conclusiones  

Los datos disponibles indican que la penetración de internet y la expansión del empleo en servicios han crecido de forma sostenida en América Latina y el Caribe entre 2015 y 2024. No obstante, la evidencia empírica no respalda de manera consistente la hipótesis de que mayores niveles de conectividad digital se asocien con menores tasas de desempleo juvenil en la región. Las correlaciones marginales y los coeficientes no significativos en los modelos de panel sugieren que, si existe un efecto, es débil o está mediado por factores no capturados en la base de datos del Banco Mundial.  

En conclusión, **los datos son insuficientes para evaluar con confianza la hipótesis** de que la digitalización reduce el desempleo juvenil, particularmente en el sector servicios. La afirmación de la noticia permanece parcialmente no verificada; futuros estudios deberían incorporar variables estructurales adicionales y ampliar la muestra temporal para esclarecer la relación entre digitalización y vulnerabilidad laboral juvenil.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- DW. "Will Australia push for fossil fuel exit at UN talks?". https://www.dw.com/en/will-australia-push-for-fossil-fuel-exit-at-un-talks/a-79782066?maca=en-rss-en-all-1573-rdf
- Ogbonna, A. E., Adediran, I. A., Oloko, T. F. et al. (2022). Information and Communication Technology (ICT) and youth unemployment in Africa. *Quality & Quantity*. https://doi.org/10.1007/s11135-022-01600-9
- Anwar, M. A., Graham, M. (2020). Between a rock and a hard place: Freedom, flexibility, precarity and vulnerability in the gig economy in Africa. *Competition & Change*. https://doi.org/10.1177/1024529420914473

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Empleo en servicios (% del empleo total) (%) | América Latina y el Caribe (LCN) | 64.47 | 64.95 | 65.11 | 65.29 | 65.82 | 64.94 | 64.90 | 65.61 | 66.23 | 66.58 |
| Usuarios de internet (% de la población) (%) | América Latina y el Caribe (LCN) | 54.40 | 57.50 | 60.20 | 63.50 | 67.80 | 73.80 | 75.80 | 77.10 | 80.00 | 81.70 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | América Latina y el Caribe (LCN) | 14.72 | 16.96 | 17.39 | 17.35 | 17.44 | 20.65 | 18.52 | 14.77 | 13.42 | 12.85 |
| Empleo en servicios (% del empleo total) (%) | Argentina | 69.65 | 70.49 | 71.10 | 71.49 | 71.77 | 71.31 | 71.77 | 71.32 | 71.22 | 71.64 |
| Usuarios de internet (% de la población) (%) | Argentina | 68.04 | 70.97 | 74.29 | 77.70 | 79.95 | 85.51 | 87.15 | 88.38 | 89.23 | 89.67 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Argentina | 20.27 | 21.80 | 22.84 | 23.84 | 25.84 | 30.43 | 23.37 | 19.00 | 17.95 | 19.23 |
| Empleo en servicios (% del empleo total) (%) | Brasil | 67.85 | 68.83 | 69.86 | 70.41 | 70.72 | 70.43 | 69.77 | 70.78 | 71.63 | 71.98 |
| Usuarios de internet (% de la población) (%) | Brasil | 58.33 | 60.87 | 67.47 | 70.43 | 73.91 | 81.34 | 80.69 | 80.53 | 84.15 | 84.46 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Brasil | 19.49 | 26.60 | 28.59 | 27.96 | 27.10 | 30.27 | 28.31 | 20.73 | 17.94 | 15.67 |
| Empleo en servicios (% del empleo total) (%) | Chile | 68.98 | 69.76 | 70.21 | 70.70 | 71.11 | 70.88 | 70.45 | 70.83 | 71.69 | 72.10 |
| Usuarios de internet (% de la población) (%) | Chile | 76.63 | 83.56 | 82.33 | 84.90 | 85.02 | 87.46 | 90.23 | 92.32 | 94.46 | 95.59 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Chile | 15.81 | 15.80 | 17.73 | 18.14 | 18.95 | 24.38 | 20.48 | 18.29 | 21.97 | 20.99 |
| Empleo en servicios (% del empleo total) (%) | Colombia | 64.77 | 65.25 | 64.42 | 63.87 | 64.40 | 64.37 | 64.88 | 65.03 | 65.61 | 65.72 |
| Usuarios de internet (% de la población) (%) | Colombia | 55.90 | 58.14 | 62.26 | 64.13 | 65.01 | 69.80 | 73.03 | 72.80 | 77.34 | 79.35 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Colombia | 17.32 | 18.27 | 18.47 | 19.45 | 20.66 | 27.25 | 24.76 | 20.97 | 19.36 | 19.41 |
| Empleo en servicios (% del empleo total) (%) | Costa Rica | 65.75 | 66.31 | 66.76 | 65.30 | 66.60 | 65.38 | 67.21 | 67.62 | 66.38 | 69.62 |
| Usuarios de internet (% de la población) (%) | Costa Rica | 59.76 | 65.88 | 71.58 | 73.48 | 81.20 | 80.53 | 82.75 | 82.60 | 85.40 | 87.17 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Costa Rica | 22.36 | 21.65 | 20.74 | 25.07 | 31.19 | 40.11 | 39.20 | 30.72 | 24.31 | 20.48 |
| Empleo en servicios (% del empleo total) (%) | República Dominicana | 71.15 | 71.26 | 70.22 | 70.31 | 71.65 | 71.57 | 71.74 | 72.77 | 73.44 | 73.75 |
| Usuarios de internet (% de la población) (%) | República Dominicana | 54.22 | 63.87 | 67.57 | 74.82 | 79.72 | 81.62 | 85.24 | 81.51 | 86.13 | 91.00 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | República Dominicana | 16.43 | 16.74 | 13.44 | 14.85 | 15.84 | 14.77 | 16.87 | 12.85 | 11.56 | 12.87 |
| Empleo en servicios (% del empleo total) (%) | Ecuador | 54.41 | 54.65 | 53.96 | 52.87 | 53.20 | 52.32 | 50.98 | 51.13 | 52.54 | 50.77 |
| Usuarios de internet (% de la población) (%) | Ecuador | 48.94 | 54.06 | 55.80 | 57.50 | 59.20 | 70.70 | 69.11 | 69.72 | 72.69 | 77.17 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Ecuador | 8.824 | 10.35 | 8.465 | 7.956 | 8.733 | 11.07 | 9.136 | 8.298 | 7.782 | 8.574 |
| Empleo en servicios (% del empleo total) (%) | Guatemala | 49.23 | 49.61 | 49.22 | 47.98 | 49.86 | 49.05 | 48.76 | 50.85 | 47.68 | 48.02 |
| Usuarios de internet (% de la población) (%) | Guatemala | 28.81 | 34.51 | 37.90 | 41.50 | 44.40 | 47.51 | 50.84 | 54.40 | 56.73 | 60.22 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Guatemala | 5.581 | 5.582 | 4.939 | 4.679 | 4.461 | 5.157 | 3.789 | 6.274 | 4.326 | 4.624 |
| Empleo en servicios (% del empleo total) (%) | México | 62.40 | 62.34 | 61.95 | 62.12 | 62.80 | 62.47 | 62.22 | 62.38 | 63.00 | 63.70 |
| Usuarios de internet (% de la población) (%) | México | 57.43 | 59.54 | 53.03 | 56.66 | 69.63 | 71.49 | 75.63 | 78.63 | 81.18 | 83.12 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | México | 8.516 | 7.621 | 6.849 | 6.815 | 7.160 | 8.053 | 7.626 | 6.465 | 5.844 | 5.760 |
| Empleo en servicios (% del empleo total) (%) | Panamá | 66.07 | 65.67 | 66.43 | 66.52 | 67.28 | 67.20 | 67.51 | 67.93 | 67.83 | 66.62 |
| Usuarios de internet (% de la población) (%) | Panamá | 51.21 | 54.00 | 59.95 | 61.81 | 63.63 | 64.82 | 66.04 | 67.28 | 68.55 | 72.77 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Panamá | 11.68 | 12.29 | 14.82 | 14.10 | 17.13 | 33.03 | 22.34 | 19.19 | 16.77 | 19.68 |
| Empleo en servicios (% del empleo total) (%) | Perú | 57.85 | 58.24 | 59.62 | 59.79 | 60.34 | 52.78 | 57.37 | 57.63 | 59.68 | 59.80 |
| Usuarios de internet (% de la población) (%) | Perú | 40.85 | 45.46 | 50.45 | 55.05 | 59.95 | 65.25 | 71.11 | 74.67 | 79.48 | 81.96 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Perú | 6.877 | 8.272 | 8.319 | 8.342 | 7.405 | 12.66 | 9.586 | 7.681 | 8.846 | 9.704 |
| Empleo en servicios (% del empleo total) (%) | Uruguay | 71.59 | 72.61 | 72.37 | 73.29 | 73.63 | 73.50 | 73.15 | 73.33 | 72.64 | 72.92 |
| Usuarios de internet (% de la población) (%) | Uruguay | 64.57 | 66.40 | 70.32 | 80.73 | 83.35 | 85.47 | 87.64 | 89.87 | 90.93 | 91.99 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Uruguay | 22.88 | 24.15 | 25.25 | 26.54 | 28.47 | 34.22 | 31.81 | 25.32 | 26.22 | 26.70 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | 216.7920 | 93.0681 | t = 2.33 | 0.0527 | [-318.814, 376.882] | 🟡 Marginal |
| OLS Agregado (LCN) | Usuarios de internet (% de la población) | 0.0902 | 0.1006 | t = 0.90 | 0.3998 | [-0.469, 0.275] | 🔴 Sin evidencia |
| OLS Agregado (LCN) | Empleo en servicios (% del empleo total) | -3.1599 | 1.4973 | t = -2.11 | 0.0727 | [-5.717, 5.500] | 🟡 Marginal |
| *Diagnóstico OLS* | *R² = 0.4269, R²-adj = 0.2631, F = 2.61 (p = 0.1425), n = 10, dof = 7* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Usuarios de internet (% de la población) | 0.0636 | 0.0386 | t = 1.65 | 0.1022 | [-0.013, 0.140] | 🔴 Sin evidencia |
| Panel Efectos Fijos (País) | Empleo en servicios (% del empleo total) | -0.2390 | 0.3345 | t = -0.71 | 0.4765 | [-0.902, 0.424] | 🔴 Sin evidencia |
| *Diagnóstico Panel* | *R² = 0.8230, n = 120 obs (12 países), dof = 106* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | ECU | -0.883 | 0.001 | 0.015 | -0.855 | -0.049 | 0.900 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | CHL | 0.873 | 0.001 | 0.015 | 0.842 | 0.126 | 0.747 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | BRA | 0.866 | 0.001 | 0.015 | 0.818 | 0.095 | 0.808 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | ARG | 0.743 | 0.014 | 0.098 | 0.564 | -0.106 | 0.787 | 🟡 Marginal |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | PAN | 0.719 | 0.019 | 0.098 | 0.782 | -0.096 | 0.805 | 🟡 Marginal |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | LCN | 0.714 | 0.020 | 0.098 | 0.661 | -0.660 | 0.053 | 🟡 Marginal |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | MEX | 0.712 | 0.021 | 0.098 | 0.733 | 0.574 | 0.106 | 🟡 Marginal |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Empleo en servicios (% del empleo total) | PER | -0.711 | 0.021 | 0.098 | -0.188 | -0.852 | 0.004 | 🟡 Marginal |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Empleo en servicios (% del empleo total) | CHL | 0.699 | 0.024 | 0.098 | 0.818 | 0.204 | 0.599 | 🟡 Marginal |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | DOM | 0.685 | 0.029 | 0.098 | 0.842 | -0.245 | 0.525 | 🟡 Marginal |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Empleo en servicios (% del empleo total) | GTM | 0.675 | 0.032 | 0.098 | 0.624 | 0.700 | 0.036 | 🟡 Marginal |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Empleo en servicios (% del empleo total) | URY | 0.674 | 0.032 | 0.098 | 0.770 | 0.051 | 0.897 | 🟡 Marginal |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | URY | 0.674 | 0.033 | 0.098 | 0.418 | 0.477 | 0.194 | 🟡 Marginal |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Usuarios de internet (% de la población) | CHL | 0.647 | 0.043 | 0.120 | 0.782 | -0.148 | 0.703 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Empleo en servicios (% del empleo total) | LCN | -0.601 | 0.066 | 0.172 | -0.491 | -0.589 | 0.095 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | América Latina y el Caribe (LCN) | 14.72 (2015) | 12.85 (2024) | -0.2079 | -12.71% | -1.50% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Argentina | 20.27 (2015) | 19.23 (2024) | -0.1154 | -5.13% | -0.58% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Brasil | 19.49 (2015) | 15.67 (2024) | -0.4243 | -19.59% | -2.39% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Chile | 15.81 (2015) | 20.99 (2024) | 0.5750 | 32.73% | 3.20% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Colombia | 17.32 (2015) | 19.41 (2024) | 0.2328 | 12.10% | 1.28% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Costa Rica | 22.36 (2015) | 20.48 (2024) | -0.2091 | -8.42% | -0.97% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | República Dominicana | 16.43 (2015) | 12.87 (2024) | -0.3949 | -21.64% | -2.67% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Ecuador | 8.82 (2015) | 8.57 (2024) | -0.0278 | -2.83% | -0.32% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-11-10-19-31/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Usuarios de internet (% de la población) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-11-10-19-31/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-11-10-19-31/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-10-19-31/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Vulnerabilidad del empleo juvenil frente a la digitalización y la penetración de internet*.
Noticia que inspiró la línea editorial: *"Will Australia push for fossil fuel exit at UN talks?"* ([DW](https://www.dw.com/en/will-australia-push-for-fossil-fuel-exit-at-un-talks/a-79782066?maca=en-rss-en-all-1573-rdf)).
Lo que la noticia afirmaba o sugería: La transición tecnológica y la mayor conectividad digital pueden modificar la situación del empleo juvenil en la región.
Alcance verificable con los datos: Se pueden relacionar Youth unemployment (% of labor force 15-24) con Internet users (% of population) y con Employment in services (% of total employment). No hay datos directos sobre políticas de transición energética, por lo que esa parte queda fuera.
Justificación del sistema: El vínculo entre digitalización y empleo juvenil es plausible y los indicadores disponibles permiten probar si mayor conectividad se asocia con menores tasas de desempleo juvenil.
**Pregunta de investigación:** ¿Los países latinoamericanos con mayor porcentaje de usuarios de internet presentan tasas de desempleo juvenil más bajas, especialmente en el sector de servicios?
**Hipótesis planteada:** Un mayor nivel de penetración de internet está asociado con una menor tasa de desempleo juvenil, particularmente en economías con mayor participación del sector servicios.
Se evaluaron 5 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (3 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Youth unemployment (% of labor force 15-24) [LCN] ~ Internet users (% of population) [LCN] + Employment in services (% of total employment) [LCN] (n=10, R²=0.427), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Youth unemployment (% of labor force 15-24) ~ Internet users (% of population) + Employment in services (% of total employment) (n=120 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 88 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 2 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*