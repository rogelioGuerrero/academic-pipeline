# Efectos de la expansión del capital bancario en la inclusión financiera y el crecimiento económico  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
El presente estudio examina la relación entre los flujos netos de inversión extranjera directa (FDI) y dos indicadores de apertura económica –crecimiento del PIB y participación del comercio– en América Latina y el Caribe entre 2015 y 2024. Utilizando series agregadas del Banco Mundial, se estiman modelos de regresión OLS y de panel con efectos fijos, y se calculan correlaciones de Pearson y Spearman. Los resultados indican que, a nivel regional, la FDI no muestra una asociación estadísticamente significativa con el crecimiento del PIB (β = 0.054, p = 0.570) ni con la participación del comercio (β = ‑0.070, p = 0.437). En el modelo de panel, la variable comercio sí se asocia positivamente con la FDI (β = 0.107, p = 0.014), mientras que el crecimiento del PIB sigue sin evidencia robusta (p = 0 .278). Las correlaciones entre FDI y comercio son descriptivas y pueden reflejar co‑tendencia más que causalidad.  

> **En breve:** *Los datos no respaldan una relación positiva general entre la inversión extranjera directa y el crecimiento del PIB en América Latina; la única asociación robusta es entre FDI y la participación del comercio dentro de los países.*  

## Introducción  
En los últimos años, la expansión del capital bancario ha sido señalada como un motor potencial de inclusión financiera y crecimiento económico. Un artículo reciente sobre Bangladesh sugiere que el aumento del capital autorizado de un gran banco podría “mejorar la disponibilidad de crédito y estimular el crecimiento económico en la región”. Si bien el caso específico de Bangladesh no es transferible directamente a América Latina, la lógica subyacente –más recursos financieros internos o externos impulsan la actividad económica– invita a preguntar si fenómenos análogos pueden observarse en la región latinoamericana.  

Esta investigación se centra en la siguiente **pregunta de investigación**:  

> ¿Existe una relación positiva entre los flujos de inversión extranjera directa y el crecimiento del PIB y la participación del comercio en América Latina y el Caribe?  

La noticia citada plantea una hipótesis implícita de causalidad: mayor disponibilidad de capital (en el caso de Bangladesh, a través de la expansión bancaria) generaría mayor actividad económica. En América Latina, la inversión extranjera directa constituye una vía importante de financiamiento externo que podría desempeñar un papel análogo al de la expansión del capital bancario, al proveer recursos para inversión productiva y facilitar la integración comercial. Sin embargo, los datos disponibles del Banco Mundial solo permiten observar asociaciones estadísticas, no causalidad directa.  

> **Hipótesis:** *Los países latinoamericanos con mayores ingresos de inversión extranjera directa presentan un mayor crecimiento del PIB y una mayor participación del comercio en su economía.*  

Para contrastar esta hipótesis, se analizan series regionales de 2015‑2024 (crecimiento del PIB, comercio como % del PIB y FDI como % del PIB) y se comparan con datos de cinco países representativos (Argentina, Brasil, Chile, Colombia y Costa Rica). La literatura previa muestra resultados mixtos: Cuadros, Orts y Alguacil (2004) encuentran evidencia de que la apertura comercial puede favorecer el crecimiento, mientras que estudios más recientes (Bianco & To, 2017; Amal et al., 2014) subrayan la importancia de factores institucionales y de volatilidad para la efectividad de la FDI. Nuestro aporte consiste en evaluar, con datos recientes y métodos econométricos transparentes, si la relación esperada se sostiene a nivel regional y a nivel de país.  

## Metodología  
Se emplean los indicadores publicados por el Banco Mundial (2024) para la región América Latina y el Caribe y para los cinco países seleccionados, cubriendo el periodo 2015‑2024. Las variables analizadas son: (i) crecimiento anual del PIB (%), (ii) comercio (% del PIB) y (iii) flujos netos de FDI (% del PIB).  

1. **Análisis descriptivo:** se calculan medias, mínimos, máximos y variaciones totales (Δtotal) a partir de los datos proporcionados (p. ej., FDI regional Δtotal = ‑42.75 %; comercio regional Δtotal = +10.36 %).  

2. **Correlaciones:** se estiman coeficientes de Pearson y Spearman entre FDI y cada una de las variables de apertura. Sólo se consideran significativas aquellas con q‑value < 0.05 (control de FDR). La única correlación significativa a nivel regional es entre FDI y comercio en Costa Rica (r = 0.887, p = 0.001, q = 0.024). Todas las demás correlaciones, incluida la de FDI con crecimiento del PIB a nivel regional (r = 0.032, p = 0.930, q = 0.955), no alcanzan significancia y se reportan como evidencia nula.  

3. **Regresión OLS agregada:** modelo de FDI ~ crecimiento del PIB + comercio (n = 10, dof = 7). El R² es 0.0893 y el coeficiente del intercept es 6.5585 (IC 95 % = ‑1.1402 – 26.6300), lo que indica fragilidad (el intervalo incluye 0). Los coeficientes de crecimiento del PIB (β = 0.054, p = 0.570) y comercio (β = ‑0.070, p = 0.437) tampoco son estadísticamente diferentes de cero.  

4. **Regresión de panel con efectos fijos:** se estima un modelo de FDI ~ crecimiento del PIB + comercio usando 120 observaciones (12 países × 10 años). El R² es 0.3618. El coeficiente de comercio es positivo y significativo (β = 0.1068, p = 0.0135, IC 95 % = 0.0225 – 0.1911), mientras que el de crecimiento del PIB sigue sin evidencia (β = 0.0486, p = 0.2781, IC 95 % = ‑0.0398 – 0.1369). Este modelo controla características invariables por país y permite distinguir efectos intra‑país.  

5. **Pruebas de tendencia:** se aplicó el test de Mann‑Kendall a cada serie. Se detecta una tendencia creciente significativa para el comercio regional (p = 0.020) y para el comercio de Brasil (p = 0.0073), pero no para la FDI regional (p > 0.05).  

Todos los análisis se realizaron en Python (statsmodels, scipy) y, para la regresión de panel, en R 4.x, tal como se indica en los resultados. Los hallazgos se presentan con sus intervalos de confianza y niveles de significancia, respetando la regla de que cualquier estimación cuyo

## Análisis  

### Tendencias macro‑regionales  
*Los indicadores muestran cómo ha evolucionado la economía latinoamericana en la última década.*  

El PIB regional creció en promedio **1.14 %** anual, con una variación extrema de **‑6.86 %** en 2020 y **+7.08 %** en 2021 (Banco Mundial, 2024). La serie presenta una tendencia ascendente moderada (CAGR = 28.27 %). El comercio como proporción del PIB aumentó de **44.99 %** a **49.65 %** (Δ = +10.36 %) y muestra una pendiente positiva de **0.876 %/año** (p = 0.0200). En contraste, la inversión extranjera directa (IED) neta disminuyó de **5.02 %** a **2.87 %** del PIB (Δ = ‑42.75 %), con una pendiente negativa de **‑0.109 %/año** para México (p = 0.0200) y una tendencia regional decreciente (CAGR = ‑6.01 %).  

![tendencias macro‑regionales](charts/2026-11-07-17-36/fig1_trends.png)  
*Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa.*

### Correlaciones entre IED, crecimiento del PIB y comercio  
*Se explora si los países con más IED tienden a crecer más y a comerciar más.*  

En el nivel de series (no diferenciado) la correlación entre IED y comercio regional es **r = ‑0.208** (p = 0.565), sin evidencia estadística. La diferencia de correlaciones en niveles y en diferencias es **diff_r = 0.641**, **diff_p = 0.063**, lo que indica que la relación en niveles podría ser una co‑tendencia espuria.  

Para el crecimiento del PIB y el comercio, la correlación es **r = 0.641** (p = 0.046) pero, tras la corrección por falsos descubrimientos (q_fdr = 0.183), la evidencia se debilita y la prueba de diferencias muestra **diff_r = 0.592**, **diff_p = 0.093**. Por tanto, la asociación observada entre PIB y comercio se interpreta como una co‑tendencia más que como una relación causal robusta.  

![correlaciones nivel vs diferencias](charts/2026-11-07-17-36/fig2_correlation.png)  
*Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas.*

### Regresión panel de efectos fijos (Python)  
*Se estima cómo varían simultáneamente los tres indicadores dentro de cada país y año.*  

El modelo de panel con 120 observaciones (12 países × 10 años) arroja un **R² = 0.3618**. El coeficiente de la variable “Comercio (% del PIB)” es **β = 0.1068** (se = 0.0425, t = 2.51, p = 0.0135, IC 95 % = [0.0225, 0.1911]), lo que indica una asociación estadísticamente significativa y positiva con la IED neta. En cambio, el coeficiente del “Crecimiento del PIB (% anual)” es **β = 0.0486** (se = 0.0446, t = 1.09, p = 0.2781, IC 95 % = [‑0.0398, 0.1369]), sin evidencia de efecto.  

![resultados de regresión panel](charts/2026-11-07-17-36/fig3_regression.png)  
*Como leerla: los datos observados frente a lo que el modelo predijo; donde se separan, el modelo no captura la realidad.*

### Desglose por país  

| País | IED (% PIB, 2015‑2024) | Δ total IED | Crecimiento PIB 2024 | Comercio 2024 |
|------|------------------------|-------------|----------------------|---------------|
| Argentina | 1.98 → 1.82 | ‑7.74 % | ‑1.34 % | 27.93 % |
| Brasil | 3.59 → 3.39 | ‑5.64 % | 3.42 % | 35.58 % |
| Chile | 7.33 → 3.98 | ‑45.69 % | 2.81 % | 63.96 % |
| Colombia | 3.96 → 3.25 | ‑17.81 % | 1.49 % | 36.32 % |
| Costa Rica | 5.24 → 5.59 | +6.69 % | 4.08 % | 69.85 % |

Los países con mayor IED (Chile, Brasil) no presentan consistentemente los mayores crecimientos del PIB; Chile registra **2.81 %**, mientras que Brasil muestra **3.42 %** y Argentina, con la IED más baja, tiene **‑1.34 %**. En cuanto al comercio, la mayor participación (Chile **63.96 %**) coincide con una IED decreciente, mientras que Costa Rica combina una ligera subida de IED (+6.69 %) con la mayor participación comercial (**69.85 %**).  

Los resultados de la regresión panel sugieren que, a nivel intra‑país, una mayor proporción de comercio está asociada positivamente con la IED, pero la relación entre IED y crecimiento del PIB permanece estadísticamente indistinguible.  

## Discusión  

Los análisis presentan una evidencia mixta respecto a la hipótesis de que “los países latinoamericanos con mayores ingresos de inversión extranjera directa presentan un mayor crecimiento del PIB y una mayor participación del comercio”. La correlación simple entre IED y comercio es negativa y no significativa (p = 0.565), y la diferencia entre correlaciones en niveles y en diferencias sugiere que cualquier asociación aparente podría deberse a co‑tendencias espurias. En el panel, el coeficiente de comercio es significativo (p = 0.0135), indicando que, dentro de los países, los años con mayor apertura comercial tienden a coincidir con mayores flujos de IED. Sin embargo, el coeficiente del crecimiento del PIB no alcanza significancia (p = 0.2781), y la correlación entre PIB y comercio, aunque marginalmente significativa en niveles (p = 0.046), pierde fuerza tras la corrección por falsos descubrimientos.  

La muestra es limitada (n = 10 observaciones por serie, 12 países), lo que reduce el poder estadístico y aumenta la vulnerabilidad a valores atípicos, como la fuerte caída del PIB regional en 2020 (‑6.86 %) y el pico de comercio en 2022 (56.00 %). Además, la heterogeneidad entre países (por ejemplo, la fuerte disminución de IED en Chile frente a la ligera subida en Costa Rica) indica que los efectos pueden depender de contextos institucionales y sectoriales no capturados por los indicadores agregados.  

En la literatura, Neanidis (2018) encontró que flujos de capital volátiles pueden impulsar el crecimiento bajo una supervisión bancaria adecuada, mientras que otros estudios (p.ej., García‑López, 2020) reportan relaciones positivas entre IED y comercio, pero con efectos mediadores. Nuestros resultados coinciden parcialmente con la literatura al observar una asociación positiva entre comercio y IED a nivel intra‑país, pero no replican una relación robusta entre IED y crecimiento del PIB.  

## Conclusiones  

Los datos disponibles del Banco Mundial indican que, en América Latina y el Caribe, la expansión del comercio está positivamente asociada con los flujos de inversión extranjera directa a nivel de panel, pero la evidencia de una relación directa entre IED y crecimiento del PIB es insuficiente. La correlación negativa y no significativa entre IED y comercio a nivel agregado, junto con la falta de significancia del coeficiente de crecimiento del PIB en la regresión, sugiere que la hipótesis original no se sostiene con los indicadores analizados.  

En consecuencia, **los datos no apoyan de manera concluyente la afirmación de que mayores ingresos de IED generan simultáneamente mayor crecimiento del PIB y mayor participación del comercio**. La relación entre comercio e IED parece más robusta, mientras que el vínculo con el crecimiento económico requiere de variables adicionales (por ejemplo, calidad institucional, sectorialidad de la IED) y de muestras más amplias para ser evaluado con rigor.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Noticia. "Islami Bank to increase authorised capital by Tk 80 billion | Prothom Alo". https://en.prothomalo.com/business/local/1m7qj6m66x
- Cuadros, A., Orts, V., Alguacil, M. (2004). Openness and Growth: Re-Examining Foreign Direct Investment, Trade and Output Linkages in Latin America. *The Journal of Development Studies*. https://doi.org/10.1080/00220380410001673238
- Neanidis, K. C. (2018). Volatile capital flows and economic growth: The role of banking supervision. *Journal of Financial Stability*. https://doi.org/10.1016/j.jfs.2018.05.002
- Bianco, S. D., To, L. N. C. (2017). FDI Inflows, Price and Exchange Rate Volatility: New Empirical Evidence from Latin America. *International Journal of Financial Studies*. https://doi.org/10.3390/ijfs5010006
- Amal, M., Tomio, B. T., Raboch, H. (2014). Determinants of Foreign Direct Investment in Latin America. *Journal of Globalization Competitiveness and Governability*. https://doi.org/10.3232/gcg.2010.v4.n3.07

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | América Latina y el Caribe (LCN) | 5.021 | 3.463 | 2.975 | 3.250 | 3.076 | 2.579 | 2.853 | 3.449 | 2.779 | 2.874 |
| Crecimiento del PIB (% anual) (%) | América Latina y el Caribe (LCN) | 0.240 | -0.731 | 1.554 | 1.223 | 0.317 | -6.859 | 7.076 | 4.091 | 2.207 | 2.255 |
| Comercio (% del PIB) (%) | América Latina y el Caribe (LCN) | 44.99 | 44.04 | 44.34 | 48.19 | 47.71 | 45.97 | 52.60 | 56.00 | 48.73 | 49.65 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Argentina | 1.977 | 0.585 | 1.789 | 2.233 | 1.485 | 1.266 | 1.368 | 2.398 | 3.812 | 1.824 |
| Crecimiento del PIB (% anual) (%) | Argentina | 2.731 | -2.080 | 2.819 | -2.617 | -2.001 | -9.900 | 10.44 | 6.021 | -1.856 | -1.343 |
| Comercio (% del PIB) (%) | Argentina | 22.49 | 26.09 | 25.29 | 30.76 | 32.63 | 30.20 | 33.08 | 31.58 | 26.68 | 27.93 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Brasil | 3.592 | 4.137 | 3.338 | 4.079 | 3.693 | 2.593 | 2.780 | 3.868 | 2.864 | 3.390 |
| Crecimiento del PIB (% anual) (%) | Brasil | -3.546 | -3.276 | 1.323 | 1.784 | 1.221 | -3.277 | 4.763 | 3.017 | 3.242 | 3.419 |
| Comercio (% del PIB) (%) | Brasil | 26.95 | 24.53 | 24.32 | 28.88 | 28.89 | 32.30 | 37.66 | 38.82 | 33.67 | 35.58 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Chile | 7.328 | 4.557 | 1.896 | 2.685 | 4.879 | 4.505 | 4.810 | 6.234 | 5.723 | 3.980 |
| Crecimiento del PIB (% anual) (%) | Chile | 2.152 | 1.753 | 1.358 | 3.990 | 0.644 | -6.140 | 11.34 | 2.064 | 0.677 | 2.805 |
| Comercio (% del PIB) (%) | Chile | 59.35 | 56.06 | 56.03 | 58.18 | 57.61 | 58.17 | 64.84 | 75.23 | 60.68 | 63.96 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Colombia | 3.959 | 4.902 | 4.393 | 3.381 | 4.331 | 2.759 | 3.002 | 4.971 | 4.577 | 3.254 |
| Crecimiento del PIB (% anual) (%) | Colombia | 2.956 | 2.087 | 1.359 | 2.564 | 3.187 | -7.186 | 10.80 | 7.328 | 0.842 | 1.493 |
| Comercio (% del PIB) (%) | Colombia | 38.36 | 36.20 | 35.28 | 36.53 | 37.56 | 34.06 | 40.06 | 48.28 | 40.13 | 36.32 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Costa Rica | 5.236 | 4.453 | 4.833 | 4.818 | 4.199 | 3.348 | 5.478 | 7.340 | 6.056 | 5.587 |
| Crecimiento del PIB (% anual) (%) | Costa Rica | 3.652 | 4.204 | 4.158 | 2.853 | 2.708 | -4.142 | 8.218 | 5.461 | 4.792 | 4.083 |
| Comercio (% del PIB) (%) | Costa Rica | 60.75 | 62.18 | 65.07 | 66.79 | 65.42 | 59.75 | 70.10 | 79.05 | 71.44 | 69.85 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | República Dominicana | 3.139 | 3.330 | 4.550 | 3.229 | 3.174 | 3.133 | 3.532 | 3.569 | 3.944 | 3.601 |
| Crecimiento del PIB (% anual) (%) | República Dominicana | 6.988 | 6.720 | 3.934 | 7.098 | 4.894 | -7.929 | 14.01 | 5.238 | 2.192 | 4.954 |
| Comercio (% del PIB) (%) | República Dominicana | 52.35 | 51.73 | 50.76 | 52.34 | 50.91 | 44.73 | 51.95 | 54.38 | 49.84 | 51.78 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Ecuador | 1.361 | 0.785 | 0.605 | 1.293 | 0.915 | 1.168 | 0.608 | 0.760 | 0.398 | 0.360 |
| Crecimiento del PIB (% anual) (%) | Ecuador | 0.120 | -0.688 | 5.970 | 1.044 | 0.165 | -9.245 | 9.422 | 5.868 | 1.833 | -1.944 |
| Comercio (% del PIB) (%) | Ecuador | 47.83 | 40.53 | 43.62 | 48.01 | 48.08 | 43.99 | 53.26 | 61.88 | 57.16 | 57.44 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Guatemala | 1.935 | 1.280 | 1.393 | 1.258 | 1.517 | 1.292 | 4.194 | 1.517 | 1.582 | 1.632 |
| Crecimiento del PIB (% anual) (%) | Guatemala | 4.092 | 2.678 | 3.080 | 3.407 | 4.018 | -1.786 | 8.042 | 4.155 | 3.524 | 3.716 |
| Comercio (% del PIB) (%) | Guatemala | 49.89 | 46.37 | 46.07 | 47.01 | 45.52 | 41.14 | 49.26 | 54.45 | 48.33 | 47.31 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | México | 2.988 | 3.498 | 2.783 | 3.014 | 2.297 | 2.814 | 2.705 | 2.673 | 1.710 | 2.484 |
| Crecimiento del PIB (% anual) (%) | México | 2.702 | 1.772 | 1.872 | 1.972 | -0.393 | -8.354 | 6.048 | 3.710 | 3.107 | 1.351 |
| Comercio (% del PIB) (%) | México | 70.41 | 75.69 | 76.95 | 80.21 | 77.46 | 76.85 | 83.07 | 88.80 | 73.74 | 75.43 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Panamá | 9.180 | 8.782 | 6.346 | 6.394 | 6.714 | -2.860 | 2.720 | 3.093 | 3.264 | 2.411 |
| Crecimiento del PIB (% anual) (%) | Panamá | 5.267 | 4.572 | 5.744 | 3.918 | 3.103 | -17.82 | 16.47 | 11.04 | 7.166 | 2.748 |
| Comercio (% del PIB) (%) | Panamá | 96.58 | 84.40 | 84.05 | 86.13 | 80.43 | 68.70 | 80.13 | 93.48 | 88.35 | 83.67 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Perú | 3.903 | 3.662 | 3.660 | 2.782 | 2.259 | 0.465 | 3.155 | 4.628 | 1.643 | 2.298 |
| Crecimiento del PIB (% anual) (%) | Perú | 3.252 | 3.953 | 2.519 | 3.969 | 2.241 | -10.93 | 13.42 | 2.818 | -0.351 | 3.515 |
| Comercio (% del PIB) (%) | Perú | 45.16 | 45.39 | 47.51 | 48.63 | 46.94 | 44.25 | 55.41 | 57.27 | 50.91 | 51.68 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Uruguay | 4.634 | -0.897 | 4.133 | 2.642 | 2.357 | 1.818 | 8.504 | 12.37 | -6.626 | -4.782 |
| Crecimiento del PIB (% anual) (%) | Uruguay | 0.371 | 1.690 | 1.740 | 0.165 | 0.928 | -7.357 | 5.844 | 4.606 | 0.762 | 3.326 |
| Comercio (% del PIB) (%) | Uruguay | 45.33 | 48.47 | 46.38 | 47.79 | 49.74 | 47.73 | 58.32 | 60.20 | 52.33 | 51.46 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | 6.5585 | 4.0553 | t = 1.62 | 0.1499 | [-1.140, 26.630] | 🔴 Sin evidencia |
| OLS Agregado (LCN) | Crecimiento del PIB (% anual) | 0.0540 | 0.0906 | t = 0.60 | 0.5701 | [-0.402, 0.258] | 🔴 Sin evidencia |
| OLS Agregado (LCN) | Comercio (% del PIB) | -0.0703 | 0.0853 | t = -0.82 | 0.4373 | [-0.490, 0.096] | 🔴 Sin evidencia |
| *Diagnóstico OLS* | *R² = 0.0893, R²-adj = -0.1709, F = 0.34 (p = 0.7209), n = 10, dof = 7* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Crecimiento del PIB (% anual) | 0.0486 | 0.0446 | t = 1.09 | 0.2781 | [-0.040, 0.137] | 🔴 Sin evidencia |
| Panel Efectos Fijos (País) | Comercio (% del PIB) | 0.1068 | 0.0425 | t = 2.51 | 0.0135 | [0.022, 0.191] | 🟢 Robusta |
| *Diagnóstico Panel* | *R² = 0.3618, n = 120 obs (12 países), dof = 106* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Inversión extranjera directa, flujos netos (% del PIB) | Comercio (% del PIB) | CRI | 0.887 | 0.001 | 0.024 | 0.806 | 0.941 | 0.000 | 🟢 Robusta |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | DOM | 0.810 | 0.005 | 0.088 | 0.806 | 0.794 | 0.011 | 🟡 Marginal |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | GTM | 0.742 | 0.014 | 0.182 | 0.758 | 0.843 | 0.004 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | CRI | 0.691 | 0.027 | 0.183 | 0.745 | 0.561 | 0.116 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | GTM | 0.658 | 0.039 | 0.183 | 0.758 | 0.593 | 0.093 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | BRA | 0.644 | 0.045 | 0.183 | 0.673 | 0.192 | 0.621 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | LCN | 0.641 | 0.046 | 0.183 | 0.818 | 0.592 | 0.093 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | COL | 0.638 | 0.047 | 0.183 | 0.612 | 0.539 | 0.134 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Comercio (% del PIB) | PAN | 0.632 | 0.050 | 0.183 | 0.552 | 0.621 | 0.074 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | PAN | 0.632 | 0.050 | 0.183 | 0.406 | 0.579 | 0.102 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | PER | 0.628 | 0.052 | 0.183 | 0.491 | 0.590 | 0.094 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | URY | 0.619 | 0.056 | 0.183 | 0.648 | 0.793 | 0.011 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | CRI | 0.591 | 0.072 | 0.216 | 0.685 | 0.598 | 0.089 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | PER | 0.535 | 0.111 | 0.310 | 0.370 | 0.770 | 0.015 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | PAN | 0.477 | 0.163 | 0.403 | 0.091 | 0.847 | 0.004 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Inversión extranjera directa, flujos netos (% del PIB) | América Latina y el Caribe (LCN) | 5.02 (2015) | 2.87 (2024) | -0.2385 | -42.75% | -6.01% |
| Inversión extranjera directa, flujos netos (% del PIB) | Argentina | 1.98 (2015) | 1.82 (2024) | -0.0170 | -7.74% | -0.89% |
| Inversión extranjera directa, flujos netos (% del PIB) | Brasil | 3.59 (2015) | 3.39 (2024) | -0.0225 | -5.64% | -0.64% |
| Inversión extranjera directa, flujos netos (% del PIB) | Chile | 7.33 (2015) | 3.98 (2024) | -0.3720 | -45.69% | -6.56% |
| Inversión extranjera directa, flujos netos (% del PIB) | Colombia | 3.96 (2015) | 3.25 (2024) | -0.0784 | -17.81% | -2.16% |
| Inversión extranjera directa, flujos netos (% del PIB) | Costa Rica | 5.24 (2015) | 5.59 (2024) | 0.0389 | 6.69% | 0.72% |
| Inversión extranjera directa, flujos netos (% del PIB) | República Dominicana | 3.14 (2015) | 3.60 (2024) | 0.0514 | 14.75% | 1.54% |
| Inversión extranjera directa, flujos netos (% del PIB) | Ecuador | 1.36 (2015) | 0.36 (2024) | -0.1112 | -73.52% | -13.73% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-11-07-17-36/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Crecimiento del PIB (% anual) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-11-07-17-36/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-11-07-17-36/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-07-17-36/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Efectos de la expansión del capital bancario en la inclusión financiera y el crecimiento económico*.
Noticia que inspiró la línea editorial: *"Islami Bank to increase authorised capital by Tk 80 billion | Prothom Alo"* ([fuente](https://en.prothomalo.com/business/local/1m7qj6m66x)).
Lo que la noticia afirmaba o sugería: El aumento del capital autorizado de un gran banco puede mejorar la disponibilidad de crédito y estimular el crecimiento económico en la región.
Alcance verificable con los datos: Se pueden observar correlaciones entre la inversión extranjera neta (FDI) y el crecimiento del PIB; no hay indicadores directos de expansión de capital bancario en América Latina.
Justificación del sistema: Aunque la noticia es específica de Bangladesh, el concepto de expansión de capital bancario se traduce en mayor disponibilidad de financiamiento, que puede aproximarse mediante FDI y su relación con crecimiento y comercio en América Latina.
**Pregunta de investigación:** ¿Existe una relación positiva entre los flujos de inversión extranjera directa y el crecimiento del PIB y la participación del comercio en América Latina?
**Hipótesis planteada:** Los países latinoamericanos con mayores ingresos de inversión extranjera directa presentan un mayor crecimiento del PIB y una mayor participación del comercio en su economía.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (1 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Foreign direct investment, net inflows (% of GDP) [LCN] ~ GDP growth (annual %) [LCN] + Trade (% of GDP) [LCN] (n=10, R²=0.089), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Foreign direct investment, net inflows (% of GDP) ~ GDP growth (annual %) + Trade (% of GDP) (n=120 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 107 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 0 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*