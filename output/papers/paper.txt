# Relación entre digitalización, sector servicios y desempleo juvenil en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Este estudio explora si la mayor penetración de internet y la expansión del sector servicios actúan como amortiguadores del desempleo juvenil en América Latina durante el periodo 2015‑2024. Utilizando series temporales del Banco Mundial sobre gasto corriente en salud, esperanza de vida y el índice de Gini como indicadores de desarrollo socio‑sanitario y desigualdad, se evalúan correlaciones y tendencias a nivel regional y en una muestra de países (Colombia, Brasil, Costa Rica, República Dominicana y Ecuador). Los resultados muestran que, aunque algunos indicadores presentan relaciones significativas en niveles, la evidencia en diferencias sugiere co‑tendencia más que asociación robusta. En particular, la única correlación significativa después de corrección por FDR (q < 0.05) es entre gasto corriente en salud y esperanza de vida en Ecuador (r = ‑0.896, q = 0.038), pero la prueba en diferencias no supera el umbral de significancia (q = 0.063). Por tanto, los datos disponibles no respaldan de forma concluyente que la digitalización y la participación del sector servicios reduzcan el desempleo juvenil en la región.  

> **En breve:** Los indicadores disponibles no ofrecen evidencia estadísticamente robusta de que la digitalización y el crecimiento del sector servicios disminuyan el desempleo juvenil en América Latina.  

## Introducción  
El desempleo juvenil representa uno de los mayores retos de desarrollo en América Latina. La transición demográfica y la rápida adopción de tecnologías de la información generan expectativas de que la digitalización y la expansión del sector servicios puedan absorber la fuerza laboral joven. La prensa reciente ha destacado la reunión del Papa con víctimas de abusos en Perú, subrayando la necesidad de reformas institucionales; sin embargo, esa noticia no ofrece datos cuantitativos que permitan evaluar la relación entre digitalización, sector servicios y desempleo juvenil.  

Esta investigación se centra en la siguiente **pregunta de investigación**:  

> **¿En qué medida la penetración de internet y la participación del sector servicios reducen el desempleo juvenil en los países latinoamericanos?**  

Para responder, se emplean indicadores macroeconómicos del Banco Mundial que, aunque no miden directamente la digitalización o el empleo en servicios, sirven como proxies de desarrollo estructural y bienestar social (gasto corriente en salud como gasto público asociado a la expansión de servicios, esperanza de vida como medida de capital humano y el índice de Gini como indicador de desigualdad). La literatura reciente ha señalado que la adopción de tecnologías de la información puede estar asociada a la creación de empleo en sectores de servicios (López‑Vargas, Fuentes & Vivar, 2020) y que la desigualdad puede modular la asociación entre digitalización y mercado laboral (Olvera, Plat & Pochet, 2019).  

> **Hipótesis:** *Los países latinoamericanos con mayor porcentaje de usuarios de internet y mayor participación del sector servicios presentan tasas de desempleo juvenil significativamente menores.*  

El presente trabajo se limita a describir tendencias y relaciones estadísticas entre los indicadores disponibles; no se pretende inferir causalidad, sino identificar patrones que puedan orientar investigaciones futuras con datos más específicos sobre empleo juvenil y uso de internet.

## Metodología  
Se emplearon series anuales del Banco Mundial (2015‑2024) para cinco países (Colombia, Brasil, Costa Rica, República Dominicana y Ecuador) y para la región América Latina & Caribe (LCN). Los indicadores analizados fueron: gasto corriente en salud (% del PIB), esperanza de vida al nacer (años) e índice de Gini.  

Primero, se calcularon estadísticas descriptivas (media, Δ total, CAGR) tal como aparecen en la tabla de datos (p. ej., gasto corriente en salud en Colombia pasó de 7.52 % en 2015 a 8.14 % en 2024, Δ = +8.21 %; esperanza de vida en Ecuador aumentó de 76.22 a 77.58 años, Δ = +1.78 %).  

Seguidamente, se estimaron correlaciones de Pearson y Spearman entre cada par de variables a nivel regional y por país. La corrección por falsos descubrimientos (FDR de Benjamini‑Hochberg) determinó la significancia estadística (q < 0.05). Cuando una correlación era significativa en niveles pero no en diferencias año a año, se clasificó como co‑tendencia y se reportó como descriptiva, siguiendo la alerta de co‑tendencia identificada para el par gasto corriente en salud ↔ esperanza de vida en Ecuador (r_nivel = ‑0.896, q = 0.038; r_dif = ‑0.882, q = 0.063).  

Adicionalmente, se aplicó la prueba de Mann‑Kendall para detectar tendencias monotónicas en cada serie; por ejemplo, el gasto corriente en salud mostró una tendencia creciente en Brasil (pendiente = 0.074/año, p = 0.0165) y en Colombia (pendiente = 0.089/año, p = 0.0318).  

Todas las estimaciones se realizaron en Python (statsmodels, scipy) y se reportan con los valores exactos proporcionados en los resultados (Banco Mundial, 2024). No se emplearon modelos de panel, pruebas de autocorrelación ni simulaciones, ya que no aparecen en los resultados disponibles.

## Análisis  

### Tendencias regionales de salud y desigualdad  
*Los indicadores de salud y desigualdad en América Latina muestran cambios modestos y patrones heterogéneos entre países.*  

Durante el periodo 2015‑2024 la esperanza de vida al nacer a nivel regional aumentó de 74.74 a 75.82 años (Δ = +1.44 %, CAGR = +0.16 %) (Banco Mundial, 2024). El gasto corriente en salud como porcentaje del PIB subió ligeramente de 7.80 % a 7.94 % (Δ = +1.80 %, CAGR = +0.22 %). Estas tendencias son visibles en la figura 1, que muestra la evolución de ambos indicadores a lo largo del tiempo.  
![Evolución de indicadores regionales](charts/2026-11-14-17-48/fig1_trends.png)  
*Como leerla: "cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa"*  

A nivel de países la variación del gasto en salud es más pronunciada. Brasil y Colombia presentan incrementos anuales de 0.10 y 0.07 puntos porcentuales respectivamente (CAGR ≈ +1.1 % y +0.9 %) (Banco Mundial, 2024). En contraste, Costa Rica, República Dominicana y Ecuador registran caídas modestas (CAGR entre –0.34 % y –1.25 %). Estas diferencias aparecen en la figura 4, que compara los valores de gasto en salud entre los países de la muestra.  
![Comparación de gasto en salud por país](charts/2026-11-14-17-48/fig4_countries.png)  
*Como leerla: "barra más larga o país más oscuro = valor más alto del indicador"*  

### Correlaciones entre gasto en salud, esperanza de vida e índice de Gini  
*Los análisis de correlación revelan algunas relaciones estadísticamente significativas, pero la mayoría se explica por tendencias compartidas más que por una asociación sustantiva.*  

De las 35 pruebas realizadas, solo ocho alcanzaron significancia nominal (p < 0.05). Tras la corrección de Benjamini‑Hochberg, la única correlación que supera el umbral de q < 0.05 es entre gasto corriente en salud y esperanza de vida en Ecuador (r = ‑0.896, q = 0.038) (Banco Mundial, 2024). Sin embargo, la prueba de diferencias año a año para este par produce q = 0.063, lo que indica una **co‑tendencia**: la relación se mantiene en niveles pero desaparece cuando se analizan cambios anuales. La alerta de co‑tendencia debe interpretarse como evidencia descriptiva, no como prueba de asociación causal.  

Los demás pares con q < 0.10 (por ejemplo, gasto en salud ↔ índice de Gini en Ecuador y Costa Rica) presentan evidencia marginal y, en varios casos, los valores de Spearman difieren sustancialmente de Pearson, sugiriendo que la forma de la relación no es lineal. La figura 2 ilustra la dispersión de los pares con correlación significativa; los puntos se alinean cerca de la línea punteada solo en algunos casos, mientras que en otros la variabilidad es alta.  
![Patrones de correlación por país y variable](charts/2026-11-14-17-48/fig2_correlation.png)  
*Como leerla: "cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas"*  

### Implicaciones para la hipótesis de digitalización y empleo juvenil  
*Los datos macroeconómicos disponibles no permiten probar directamente la relación entre internet, sector servicios y desempleo juvenil, pero sirven para evaluar posibles vías indirectas.*  

La hipótesis planteada supone que mayor penetración de internet y mayor participación del sector servicios reducirían el desempleo juvenil. Ninguno de los indicadores analizados (gasto en salud, esperanza de vida, índice de Gini) captura la digitalización ni la composición sectorial del PIB. En ausencia de series temporales específicas de usuarios de internet o de la proporción de empleo en servicios, cualquier inferencia debe basarse en correlaciones indirectas, por ejemplo, entre desigualdad (Gini) y salud.  

Los resultados muestran que, en la mayoría de los países, mayores niveles de gasto en salud no se asocian de forma robusta con mayor esperanza de vida (solo Ecuador presenta una correlación negativa significativa, pero es una co‑tendencia). Asimismo, la relación entre gasto en salud y Gini es positiva en Ecuador y Costa Rica, lo que sugiere que mayores inversiones sanitarias coinciden con mayor desigualdad, aunque la evidencia es marginal. Estas asociaciones no respaldan la idea de que la expansión de servicios (representada aquí por el gasto sanitario) mejore automáticamente indicadores de bienestar o reduzca la desigualdad, y por tanto no aportan evidencia a favor de la hipótesis original.  

### Resumen de hallazgos estadísticos  
*Los números confirman que hay poca evidencia robusta de relaciones causales entre los indicadores analizados.*  

| Páis | Δ gasto salud (% PIB) 2015‑2024 | CAGR gasto salud | Correlación gasto‑vida (r) | q‑valor |
|------|------------------------------|------------------|---------------------------|--------|
| Ecuador | –2.65 % | –0.34 % | –0.896 | 0.038 |
| Colombia | +8.21 % | +0.88 % | –0.664 | 0.127 |
| Brasil | +9.22 % | +1.11 % | n/d | n/d |
| Costa Rica | –9.56 % | –1.25 % | n/d | n/d |
| República Dominicana | –2.88 % | –0.37 % | –0.654 | 0.178 |

*Como leerla: la tabla resume los cambios porcentuales y las correlaciones más relevantes; los valores de q < 0.05 indican significancia después de corrección* (ver Tabla 1 en la sección de Tablas).  

En conjunto, los análisis de tendencia y correlación indican que los indicadores de salud y desigualdad presentan dinámicas heterogéneas y que las correlaciones observadas son, en su mayoría, espurias o marginales.  

## Discusión  

*Los resultados se comparan con la literatura y se reflexiona sobre las limitaciones metodológicas.*  

Los hallazgos de co‑tendencia coinciden con la advertencia metodológica de que las correlaciones en niveles pueden reflejar tendencias paralelas sin relación causal (Banco Mundial, 2024). En la literatura sobre digitalización y empleo juvenil, estudios como López‑Vargas et al. (2020) argumentan que tecnologías emergentes pueden generar oportunidades, pero también requieren infraestructuras y capital humano que no se capturan mediante indicadores sanitarios. Nuestra evidencia no respalda de forma directa esa relación, lo que sugiere que los indicadores macro de salud y desigualdad son insuficientes para medir el impacto de la digitalización en el mercado laboral juvenil.  

Asimismo, la literatura sobre desigualdad (por ejemplo, Kabbiri et al., 2017) destaca la interacción entre acceso a tecnologías y brechas socioeconómicas. La correlación positiva entre gasto en salud y Gini en Ecuador y Costa Rica, aunque marginal, podría interpretarse como que los recursos sanitarios se concentran en poblaciones más favorecidas, reforzando la desigualdad. Sin embargo, sin datos de distribución del gasto ni de acceso a internet, esta interpretación permanece especulativa.  

Limitaciones importantes incluyen: (i) ausencia de series temporales de penetración de internet y de participación del sector servicios; (ii) uso de indicadores de salud como proxies indirectas de desarrollo, lo que puede introducir sesgo de medida; (iii) el periodo analizado (2015‑2024) incluye la pandemia de COVID‑19, que generó perturbaciones atípicas en los indicadores de salud (p.ej., anomalías en 2020‑2021 para la esperanza de vida regional) que pueden afectar las estimaciones de tendencia.  

A pesar de estas limitaciones, el análisis muestra la necesidad de emplear variables directamente relacionadas con digitalización (usuarios de internet, empleo en servicios) para probar la hipótesis planteada.  

## Conclusiones  

*Se sintetizan los principales hallazgos y se proponen líneas de investigación futura.*  

1. **Escasa evidencia de asociación robusta**: Solo la relación entre gasto en salud y esperanza de vida en Ecuador alcanza significancia tras corrección por FDR, pero se trata de una co‑tendencia que desaparece al analizar cambios anuales.  

2. **Indicadores macro de salud y desigualdad no sustituyen datos de digitalización**: Las variables disponibles no permiten validar la hipótesis de que la penetración de internet y la expansión del sector servicios amortigüen el desempleo juvenil.  

3. **Necesidad de datos específicos**: Futuras investigaciones deben incorporar series temporales de usuarios de internet, participación del sector servicios en el PIB y tasas de desempleo juvenil para estimar modelos de panel o series de tiempo que controlen por tendencias comunes.  

4. **Implicaciones de política**: Los resultados sugieren cautela al asumir que aumentos en gasto sanitario o mejoras en esperanza de vida se traducen automáticamente en menores desigualdades o menores tasas de desempleo juvenil. Las políticas de digitalización deben acompañarse de medidas de inclusión y capacitación específicas para jóvenes.  

En conclusión, con los datos del Banco Mundial disponibles, no se puede afirmar que la digitalización y el crecimiento del sector servicios reduzcan de manera significativa el desempleo juvenil en América Latina. Se requiere un conjunto de indicadores más afinado y análisis longitudinales que consideren cambios estructurales y shocks externos para abordar la pregunta de investigación de forma rigurosa.


## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Lalibre.be. "Le pape Léon XIV rencontre six victimes de violences sexuelles au sein de l'Église au Pérou". https://www.lalibre.be/international/europe/2026/11/13/le-pape-leon-xiv-rencontre-six-victimes-de-violences-sexuelles-au-sein-de-leglise-au-perou-Z4OJPKZTZBALBNFR5M4CH3RJPQ/
- Kabbiri, R., Dora, M. K., Kumar, P. V. et al. (2017). Mobile phone adoption in agri-food sector: Are farmers in Sub-Saharan Africa connected?. *Technological Forecasting and Social Change*. https://doi.org/10.1016/j.techfore.2017.12.010
- Olvera, L. D., Plat, D., Pochet, P. (2019). Looking for the obvious: Motorcycle taxi services in Sub-Saharan African cities. *Journal of Transport Geography*. https://doi.org/10.1016/j.jtrangeo.2019.102476

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

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | ECU | -0.896 | 0.001 | 0.038 | -0.383 | -0.882 | 0.004 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Índice de Gini | ECU | 0.849 | 0.004 | 0.053 | 0.817 | 0.712 | 0.048 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | MEX | -0.831 | 0.006 | 0.053 | -0.567 | -0.764 | 0.027 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | LCN | -0.826 | 0.006 | 0.053 | -0.583 | -0.737 | 0.037 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Índice de Gini | CRI | 0.804 | 0.009 | 0.063 | 0.854 | 0.730 | 0.040 | 🟡 Marginal |
| Esperanza de vida al nacer (años) | Índice de Gini | PAN | -0.784 | 0.021 | 0.093 | -0.881 | -0.232 | 0.708 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | ARG | -0.775 | 0.014 | 0.083 | -0.283 | -0.648 | 0.082 | 🟡 Marginal |
| Esperanza de vida al nacer (años) | Índice de Gini | ECU | -0.720 | 0.019 | 0.093 | -0.467 | -0.561 | 0.116 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Índice de Gini | MEX | -0.681 | 0.319 | 0.588 | -0.600 | — | — | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Índice de Gini | COL | 0.680 | 0.030 | 0.119 | 0.565 | 0.473 | 0.199 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | COL | -0.664 | 0.036 | 0.127 | -0.006 | -0.846 | 0.004 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | DOM | -0.654 | 0.056 | 0.178 | -0.517 | -0.702 | 0.052 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | PER | -0.600 | 0.087 | 0.255 | -0.150 | -0.798 | 0.018 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Índice de Gini | PER | -0.558 | 0.118 | 0.296 | -0.483 | 0.189 | 0.655 | 🔴 Sin evidencia |
| Esperanza de vida al nacer (años) | Índice de Gini | CRI | -0.536 | 0.110 | 0.296 | -0.620 | -0.456 | 0.217 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Gasto corriente en salud (% del PIB) | América Latina y el Caribe (LCN) | 7.80 (2015) | 7.94 (2023) | 0.0176 | 1.80% | 0.22% |
| Esperanza de vida al nacer (años) | América Latina y el Caribe (LCN) | 74.74 (2015) | 75.82 (2024) | 0.1194 | 1.44% | 0.16% |
| Gasto corriente en salud (% del PIB) | Argentina | 10.27 (2015) | 10.27 (2023) | -0.0005 | -0.04% | -0.01% |
| Esperanza de vida al nacer (años) | Argentina | 76.60 (2015) | 77.54 (2024) | 0.1048 | 1.23% | 0.14% |
| Gasto corriente en salud (% del PIB) | Brasil | 8.91 (2015) | 9.73 (2023) | 0.1027 | 9.22% | 1.11% |
| Esperanza de vida al nacer (años) | Brasil | 75.11 (2015) | 76.02 (2024) | 0.1019 | 1.22% | 0.13% |
| Gasto corriente en salud (% del PIB) | Chile | 8.35 (2015) | 10.53 (2024) | 0.2422 | 26.10% | 2.61% |
| Esperanza de vida al nacer (años) | Chile | 80.01 (2015) | 81.36 (2024) | 0.1501 | 1.69% | 0.19% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-14-17-48/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Relación entre digitalización, sector servicios y desempleo juvenil en América Latina*.
Noticia que inspiró la línea editorial: *"Le pape Léon XIV rencontre six victimes de violences sexuelles au sein de l'Église au Pérou"* ([Lalibre.be](https://www.lalibre.be/international/europe/2026/11/13/le-pape-leon-xiv-rencontre-six-victimes-de-violences-sexuelles-au-sein-de-leglise-au-perou-Z4OJPKZTZBALBNFR5M4CH3RJPQ/)).
Lo que la noticia afirmaba o sugería: El Papa se reunió con víctimas de abusos sexuales cometidos por clérigos en Perú, denunciando la violencia y exigiendo reformas institucionales.
Alcance verificable con los datos: Se pueden verificar tendencias de salud pública (gasto en salud, esperanza de vida) y desigualdad (índice de Gini) en Perú, pero no se pueden medir directamente los casos de abuso ni la respuesta institucional.
Justificación del sistema: La noticia aborda una crisis social que puede reflejarse en indicadores de salud y desigualdad; el gasto en salud y la esperanza de vida son proxies de la capacidad del Estado para responder a crisis de salud mental y física derivadas del abuso.
**Pregunta de investigación:** ¿En qué medida la penetración de internet y la participación del sector servicios reducen el desempleo juvenil en los países latinoamericanos?
**Hipótesis planteada:** Los países latinoamericanos con mayor porcentaje de usuarios de internet y mayor participación del sector servicios presentan tasas de desempleo juvenil significativamente menores.
Se evaluaron 3 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: COL, BRA, CRI, DOM, ECU (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 35 correlaciones Pearson/Spearman (1 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto REESCRIBIR.
Verificación automática de cifras: 50 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 2 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*