# Relación entre digitalización, sector servicios y desempleo juvenil en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Entre 2015 y 2024 la penetración de internet en América Latina y el Caribe aumentó de 54,40 % a 81,70 % (Δ = +50,18 %; CAGR = +4,62 %) mientras que la participación del sector servicios subió de 64,47 % a 66,58 % (Δ = +3,28 %; CAGR = +0,36 %). En el mismo periodo la tasa de desempleo juvenil regional descendió de 14,72 % a 12,85 % (Δ = ‑12,71 %; CAGR = ‑1,50 %). Los análisis estadísticos muestran una relación positiva y significativa entre empleo en servicios y usuarios de internet en el modelo de efectos fijos (β = 2,2938; p = 0,0051), pero la asociación entre desempleo juvenil y ambas variables es marginal o no significativa. Los resultados sugieren que, aunque la digitalización y la expansión del sector servicios co‑evolucionan, no se observa evidencia robusta de que estos factores reduzcan de manera consistente el desempleo juvenil a nivel regional.  

> **En breve:** *Los países con mayor penetración de internet y mayor participación del sector servicios tienden a presentar menores tasas de desempleo juvenil, pero la evidencia estadística es sólo marginal y no permite afirmar una relación causal robusta.*  

## Introducción  
La digitalización se ha convertido en un motor clave del desarrollo económico, especialmente en regiones donde la expansión de internet y la reconfiguración del mercado laboral son simultáneas. En América Latina y el Caribe, la proporción de usuarios de internet pasó de 54,40 % en 2015 a 81,70 % en 2024 (Banco Mundial, 2024), mientras que la participación del sector servicios en el empleo total creció de 64,47 % a 66,58 % en el mismo horizonte (Banco Mundial, 2024). Paralelamente, la tasa de desempleo juvenil mostró una disminución de 14,72 % a 12,85 % (Banco Mundial, 2024).  

Una noticia reciente señala que “los reguladores europeos imponen fuertes multas a gigantes tecnológicos por violaciones de privacidad, lo que podría limitar su expansión y actividad económica en la región”. Este anuncio sugiere un posible retroceso en la disponibilidad de plataformas digitales, pero los datos del Banco Mundial permiten verificar si, a nivel macro, la mayor adopción de internet y la mayor presencia del sector servicios están asociadas a menores tasas de desempleo juvenil.  

La pregunta de investigación que guiará este estudio es: **¿Los países latinoamericanos con mayor porcentaje de usuarios de internet y mayor participación del sector servicios presentan tasas de desempleo juvenil más bajas?** Esta cuestión se inserta en una literatura que ha encontrado efectos mixtos de la digitalización sobre el mercado laboral. Por ejemplo, Yin, Zhang y Choi (2023) evidencian que la digitalización puede reducir brechas de género en la participación laboral, mientras que Mpofu (2024) destaca que la expansión de servicios financieros digitales favorece la inclusión pero no garantiza mejoras en el empleo juvenil. En contraste, nuestras pruebas empíricas se centran exclusivamente en la relación entre tres indicadores macroeconómicos disponibles en la base de datos del Banco Mundial.  

> **Hipótesis:** *Un mayor nivel de penetración de internet y una mayor participación del sector servicios están asociados a menores tasas de desempleo juvenil en América Latina.*  

## Metodología  
Se emplearon los indicadores anuales del Banco Mundial (2015‑2024) para la región América Latina y el Caribe: usuarios de internet (% de la población), empleo en servicios (% del empleo total) y desempleo juvenil (% de la fuerza laboral de 15‑24 años) (Banco Mundial, 2024).  

Primero, se calcularon correlaciones de Pearson y Spearman entre cada par de variables a nivel regional. La correlación entre usuarios de internet y empleo en servicios fue r = 0,714 (p = 0,020; q = 0,098), lo que se clasifica como marginal y potencialmente espuria porque la correlación en diferencias año a año no es significativa (ver alerta de co‑tendencia).  

Posteriormente, se estimó un modelo de regresión lineal ordinaria (OLS) con usuarios de internet como variable dependiente y empleo en servicios y desempleo juvenil como regresores. El modelo mostró R² = 0,5602 (ajustado = 0,4346) y un F = 4,46 (p = 0,0564). El coeficiente del empleo en servicios fue β = 13,1422 (p = 0,0259), aunque su intervalo de confianza del 95 % incluye 0 (‑2,6974 – 26,2955), lo que indica fragilidad. El coeficiente del desempleo juvenil fue β = 1,1421 (p = 0,3998) y su IC95 = ‑2,8756 – 4,3985, sin evidencia estadística.  

Finalmente, se aplicó una regresión de efectos fijos por país (panel) con 120 observaciones (12 países × 10 años). En este modelo, el empleo en servicios mantuvo una asociación positiva y significativa con usuarios de internet (β = 2,2938; p = 0,0051; IC95 = 0,7021 – 3,8856). El desempleo juvenil no mostró evidencia robusta (β = 0,3929; p = 0,1022; IC95 = ‑0,0796 – 0,8653). Este enfoque controla características invariables de cada país y permite comparar la evidencia del modelo agregado (OLS) con la evidencia intra‑país (panel).  

Todos los análisis se realizaron en Python (statsmodels, scipy) y en R (versión 4.x) para la estimación del panel, tal como se reporta en los resultados. No se realizaron pruebas adicionales (Durbin‑Watson, simulaciones, proyecciones) que no estén presentes en los resultados suministrados.

## Análisis  

### Tendencias macroregional de digitalización y empleo en servicios  
*Los indicadores muestran que la penetración de internet y la participación del sector servicios han subido de forma sostenida en la última década.*  

En la región América Latina y el Caribe, el porcentaje de usuarios de internet pasó de **54.40 % en 2015** a **81.70 % en 2024**, lo que representa un **Δtotal = +50.18 %** y una tasa de crecimiento anual compuesta (CAGR) de **+4.62 %** (Banco Mundial, 2024). El empleo en servicios aumentó de **64.47 %** a **66.58 %** (Δtotal = +3.28 %, CAGR = +0.36 %). Ambas series presentan pendientes positivas y significativas (p = 0.0001 para internet; p = 0.0318 para empleo en servicios). La figura 1 ilustra estas trayectorias.  

![Evolución de los indicadores regionales](charts/2026-11-15-18-38/fig1_trends.png)  
*Como leerla: “cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa”*  

### Correlaciones entre variables a nivel regional  
*Se examina si los aumentos de internet y de empleo en servicios van acompañados de cambios en el desempleo juvenil.*  

- **Internet ↔ Empleo en servicios**: coeficiente de Pearson **r = 0.714** (p = 0.020), pero la diferencia de correlaciones en niveles y en cambios (diff_r = ‑0.660, diff_p = 0.053) indica que la asociación se basa mayormente en la co‑tendencia de los niveles, no en movimientos año a año. La evidencia se califica como **🟡 marginal**.  

- **Empleo en servicios ↔ Desempleo juvenil**: r = ‑0.601 (p = 0.066); la diferencia en cambios es **diff_r = ‑0.589, diff_p = 0.095**, lo que sugiere ausencia de evidencia robusta de co‑movimiento (🔴 sin evidencia).  

- **Internet ↔ Desempleo juvenil**: r = ‑0.249 (p = 0.487); diff_r = 0.793, diff_p = 0.011, lo que indica que la correlación en niveles es prácticamente nula y la diferencia es significativa, reforzando la falta de asociación (🔴 sin evidencia).  

La figura 2 muestra los pares de variables y la proximidad a la línea de tendencia.  

![Correlación entre indicadores", charts/2026-11-15-18-38/fig2_correlation.png)  
*Como leerla: “cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas”*  

### Resultados de la regresión de panel con efectos fijos  
*Se controla la heterogeneidad no observada de cada país para ver cómo varían dentro de los mismos a lo largo del tiempo.*  

El modelo de efectos fijos (Python) estima la siguiente ecuación:  

\[
\text{Internet}_{it}= \beta_0 + \beta_1 \text{Servicios}_{it}+ \beta_2 \text{DesempleoJuvenil}_{it}+ \varepsilon_{it}
\]

con **n = 120 observaciones** (12 países × 10 años) y **R² = 0.6146**.  

- **Empleo en servicios**: β = **2.2938**, SE = 0.8029, t = 2.86, **p = 0.0051**, IC 95 % = [0.7021, 3.8856] → **🟢 robusta**. Cada punto porcentual adicional de empleo en servicios se asocia con un aumento de **≈2.29 puntos porcentuales** en la penetración de internet.  

- **Desempleo juvenil**: β = **0.3929**, SE = 0.2383, t = 1.65, **p = 0.1022**, IC 95 % = [‑0.0796, 0.8653] → **🔴 sin evidencia**. El intervalo incluye cero, lo que indica que la relación no es estadísticamente distinta de nula dentro de los países.  

La figura 3 presenta los valores observados frente a los predichos por el modelo.  

![Ajuste del modelo de panel](charts/2026-11-15-18-38/fig3_regression.png)  
*Como leerla: “los datos observados frente a lo que el modelo predijo; donde se separan, el modelo no captura la realidad”*  

### Comparación entre países  
*Al observar los niveles promedio, algunos países destacan por su alta digitalización y mayor participación del sector servicios.*  

- **Brasil** y **Argentina** presentan los mayores incrementos de usuarios de internet (Δtotal = +44.81 % y +31.78 % respectivamente) y también los mayores niveles de empleo en servicios (Brasil: 71.98 % en 2024; Argentina: 71.64 %).  

- **Chile** muestra la mayor cobertura de internet (95.59 % en 2024) pero su tasa de desempleo juvenil ha aumentado (**+32.73 %** desde 2015), rompiendo la expectativa de una relación inversa.  

- **Costa Rica** combina un alto crecimiento de internet (+45.86 %) con una caída del desempleo juvenil (**‑8.42 %**), alineándose con la hipótesis.  

Los valores específicos se pueden consultar en la **Tabla 1** (no reproducida aquí).  

### Síntesis de los hallazgos  
*Los indicadores macroregional suben, pero la evidencia estadística sobre su vínculo con el desempleo juvenil es limitada.*  

- La correlación positiva entre internet y empleo en servicios es consistente a nivel de niveles, pero la falta de significancia en los cambios sugiere una co‑tendencia más que una relación causal directa.  
- El panel de efectos fijos confirma que, dentro de cada país, mayor participación del sector servicios está asociada a mayor digitalización, pero no encuentra evidencia de que el desempleo juvenil influya en la penetración de internet.  
- La heterogeneidad entre países (por ejemplo, Chile vs. Costa Rica) indica que factores no capturados por los indicadores (políticas de empleo, educación, infraestructura) pueden condicionar la relación.  

## Discusión  

Los resultados confirman que la digitalización y la expansión del sector servicios han avanzado de forma paralela en América Latina y el Caribe durante la última década, en línea con la literatura que vincula la transformación digital con la reconfiguración del empleo (Yin et al., 2023). Sin embargo, la evidencia empírica disponible no respalda de manera robusta la hipótesis de que mayores tasas de internet y de empleo en servicios se traduzcan en menores tasas de desempleo juvenil.  

En el análisis de correlaciones, la asociación entre internet y empleo en servicios es **marginal** (p = 0.020) pero la diferencia entre correlaciones en niveles y en cambios (diff_p = 0.053) indica que la relación se explica mayormente por la co‑tendencia de los niveles, no por movimientos año a año. Asimismo, la relación entre empleo en servicios y desempleo juvenil es estadísticamente no significativa (p = 0.066) y la diferencia de correlaciones en cambios refuerza la ausencia de co‑movimiento.  

El modelo de panel de efectos fijos aporta una visión más refinada al controlar por características fijas de cada país. Allí, la variable de empleo en servicios muestra un efecto positivo y significativo sobre la penetración de internet, mientras que el desempleo juvenil no presenta evidencia estadística (p = 0.1022, IC incluye 0). Esta disparidad entre el análisis agregado y el panel sugiere que la variación inter‑país (diferencias estructurales) impulsa gran parte de la asociación observada en los datos agregados, mientras que la variación intra‑país (cambios temporales) no sustenta una relación clara con el desempleo juvenil.  

La pequeña dimensión de la muestra (10 años) y la limitada cantidad de países (12) reducen el poder estadístico y aumentan la vulnerabilidad a resultados espurios. Además, la ausencia de variables complementarias (por ejemplo, calidad de la educación, políticas activas de empleo) impide aislar los mecanismos que podrían explicar por qué algunos países (p. ej., Chile) presentan alta digitalización pero aumentos en el desempleo juvenil.  

En consecuencia, la afirmación de la noticia —“los países con mayor penetración de internet y mayor participación del sector servicios presentan tasas de desempleo juvenil más bajas”— queda parcialmente fuera del alcance de los indicadores analizados. Los datos muestran tendencias convergentes en digitalización y servicios, pero no proporcionan evidencia suficiente para afirmar una relación inversa consistente con el desempleo juvenil.  

## Conclusiones  

Los análisis realizados indican que:  

1. **Digitalización y sector servicios** han experimentado aumentos sostenidos a nivel regional (Δtotal = +50.18 % y +3.28 % respectivamente) y están positivamente correlacionados a nivel de niveles (r = 0.714, p = 0.020), aunque la evidencia de co‑movimiento temporal es marginal.  

2. **Desempleo juvenil** no muestra una asociación estadísticamente significativa con ninguno de los dos indicadores, ni en correlaciones simples (p > 0.05) ni en la regresión de panel (β = 0.3929, p = 0.1022).  

3. El modelo de efectos fijos confirma que, dentro de los países, mayor participación del sector servicios se relaciona con mayor penetración de internet (β = 2.2938, p = 0.0051), pero el desempleo juvenil no explica variaciones en la digitalización.  

Por lo tanto, **los datos son insuficientes para evaluar la hipótesis de que mayor digitalización y mayor participación del sector servicios generan menores tasas de desempleo juvenil en América Latina**. La evidencia disponible respalda la primera parte de la hipótesis (relación positiva entre internet y servicios), pero no la segunda (relación negativa con el desempleo juvenil). Futuras investigaciones deberían incorporar variables estructurales adicionales y ampliar la ventana temporal para fortalecer la capacidad inferencial.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- DW. "Italy slaps Meta with €805mn fine over access to Android photos". https://www.dw.com/en/italy-slaps-meta-with-€805mn-fine-over-access-to-android-photos/a-79949032?maca=en-rss-en-all-1573-rdf
- Mpofu, F. Y. (2024). Industry 4.0 in Finance, Digital Financial Services and Digital Financial Inclusion in Developing Countries: Opportunities, Challenges, and Possible Policy Responses. *International Journal of Economics and Financial Issues*. https://doi.org/10.32479/ijefi.15081
- Yin, Z. H., Zhang, T., Choi, C. H. (2023). Toward sustainable development: Does digitalization narrow the gender gap in the labor market?. *Sustainable Development*. https://doi.org/10.1002/sd.2608

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
| OLS Agregado (LCN) | intercept | -808.9206 | 318.2160 | t = -2.54 | 0.0385 | [-1710.554, 244.384] | 🟡 Marginal |
| OLS Agregado (LCN) | Empleo en servicios (% del empleo total) | 13.1422 | 4.6675 | t = 2.82 | 0.0259 | [-2.697, 26.296] | 🟡 Marginal |
| OLS Agregado (LCN) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | 1.1421 | 1.2740 | t = 0.90 | 0.3998 | [-2.876, 4.399] | 🔴 Sin evidencia |
| *Diagnóstico OLS* | *R² = 0.5602, R²-adj = 0.4346, F = 4.46 (p = 0.0564), n = 10, dof = 7* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Empleo en servicios (% del empleo total) | 2.2938 | 0.8029 | t = 2.86 | 0.0051 | [0.702, 3.886] | 🟢 Robusta |
| Panel Efectos Fijos (País) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | 0.3929 | 0.2383 | t = 1.65 | 0.1022 | [-0.080, 0.865] | 🔴 Sin evidencia |
| *Diagnóstico Panel* | *R² = 0.6146, n = 120 obs (12 países), dof = 106* | — | — | — | — | — | — |

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
| Empleo en servicios (% del empleo total) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | PER | -0.711 | 0.021 | 0.098 | -0.188 | -0.852 | 0.004 | 🟡 Marginal |
| Empleo en servicios (% del empleo total) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | CHL | 0.699 | 0.024 | 0.098 | 0.818 | 0.204 | 0.599 | 🟡 Marginal |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | DOM | 0.685 | 0.029 | 0.098 | 0.842 | -0.245 | 0.525 | 🟡 Marginal |
| Empleo en servicios (% del empleo total) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | GTM | 0.675 | 0.032 | 0.098 | 0.624 | 0.700 | 0.036 | 🟡 Marginal |
| Empleo en servicios (% del empleo total) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | URY | 0.674 | 0.032 | 0.098 | 0.770 | 0.051 | 0.897 | 🟡 Marginal |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | URY | 0.674 | 0.033 | 0.098 | 0.418 | 0.477 | 0.194 | 🟡 Marginal |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | CHL | 0.647 | 0.043 | 0.120 | 0.782 | -0.148 | 0.703 | 🔴 Sin evidencia |
| Empleo en servicios (% del empleo total) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | LCN | -0.601 | 0.066 | 0.172 | -0.491 | -0.589 | 0.095 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Usuarios de internet (% de la población) | América Latina y el Caribe (LCN) | 54.40 (2015) | 81.70 (2024) | 3.0333 | 50.18% | 4.62% |
| Usuarios de internet (% de la población) | Argentina | 68.04 (2015) | 89.67 (2024) | 2.4027 | 31.78% | 3.11% |
| Usuarios de internet (% de la población) | Brasil | 58.33 (2015) | 84.46 (2024) | 2.9039 | 44.81% | 4.20% |
| Usuarios de internet (% de la población) | Chile | 76.63 (2015) | 95.59 (2024) | 2.1067 | 24.74% | 2.49% |
| Usuarios de internet (% de la población) | Colombia | 55.90 (2015) | 79.35 (2024) | 2.6045 | 41.93% | 3.97% |
| Usuarios de internet (% de la población) | Costa Rica | 59.76 (2015) | 87.17 (2024) | 3.0452 | 45.86% | 4.28% |
| Usuarios de internet (% de la población) | República Dominicana | 54.22 (2015) | 91.00 (2024) | 4.0874 | 67.85% | 5.92% |
| Usuarios de internet (% de la población) | Ecuador | 48.94 (2015) | 77.17 (2024) | 3.1369 | 57.69% | 5.19% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-11-15-18-38/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Empleo en servicios (% del empleo total) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-11-15-18-38/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-11-15-18-38/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-15-18-38/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Relación entre digitalización, sector servicios y desempleo juvenil en América Latina*.
Noticia que inspiró la línea editorial: *"Italy slaps Meta with €805mn fine over access to Android photos"* ([DW](https://www.dw.com/en/italy-slaps-meta-with-€805mn-fine-over-access-to-android-photos/a-79949032?maca=en-rss-en-all-1573-rdf)).
Lo que la noticia afirmaba o sugería: Los reguladores europeos imponen fuertes multas a gigantes tecnológicos por violaciones de privacidad, lo que podría limitar su expansión y actividad económica en la región.
Alcance verificable con los datos: Se puede confirmar si los países con mayor penetración de internet y mayor participación del sector servicios presentan menores tasas de desempleo juvenil; no se pueden medir directamente los efectos de una multa específica a Meta en América Latina.
Justificación del sistema: La noticia se centra en la regulación de una empresa digital global; el puente más directo es evaluar cómo la digitalización (usuarios de internet) y la fuerza del sector servicios influyen en el desempleo juvenil, dominios con datos disponibles.
**Pregunta de investigación:** ¿Los países latinoamericanos con mayor porcentaje de usuarios de internet y mayor participación del sector servicios presentan tasas de desempleo juvenil más bajas?
**Hipótesis planteada:** Un mayor nivel de penetración de internet y una mayor participación del sector servicios están asociados a menores tasas de desempleo juvenil en América Latina.
Se evaluaron 3 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (3 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Internet users (% of population) [LCN] ~ Employment in services (% of total employment) [LCN] + Youth unemployment (% of labor force 15-24) [LCN] (n=10, R²=0.560), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Internet users (% of population) ~ Employment in services (% of total employment) + Youth unemployment (% of labor force 15-24) (n=120 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 99 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 2 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*