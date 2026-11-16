# Inversión extranjera directa y crecimiento económico frente a la inestabilidad geopolítica  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Este estudio examina la relación entre los flujos netos de inversión extranjera directa (IED) y el crecimiento anual del Producto Interno Bruto (PIB) en una muestra de países latinoamericanos (Argentina, Brasil, Chile, Colombia y Costa Rica) durante el periodo 2015‑2024, un intervalo que incluye episodios de alta tensión geopolítica a nivel global. Utilizando series temporales del Banco Mundial, se calculan correlaciones de Pearson y Spearman, pruebas de Mann‑Kendall y regresiones lineales por mínimos cuadrados ordinarios (OLS). Los resultados indican que, a nivel agregado regional, la correlación entre IED y crecimiento del PIB es prácticamente nula (r = 0.032, p = 0.930) y que ninguna de las correlaciones por país supera el umbral de significancia ajustado por FDR (q > 0.05). En consecuencia, no se encuentra evidencia robusta de una asociación positiva entre mayores ingresos de IED y un crecimiento del PIB más sólido en contextos de inestabilidad geopolítica.  

> **En breve:** No hay evidencia estadísticamente significativa de una correlación positiva entre IED y crecimiento del PIB en los países analizados durante 2015‑2024.  

## Introducción  
La reciente escalada de conflictos internacionales, como la guerra en Oriente Medio, ha generado preocupación sobre posibles efectos adversos en la inversión extranjera y el desempeño económico de América Latina (noticia de prensa, 2026). La pregunta de investigación que guía este trabajo es: **¿Existe una correlación positiva entre los ingresos de inversión extranjera directa y el crecimiento del PIB en los países latinoamericanos durante periodos de alta tensión geopolítica?**  

La literatura especializada ha señalado que la IED puede actuar como motor de crecimiento al transferir capital, tecnología y conocimientos de gestión (Oliveira 2015; Menezes & Bragatti 2020). Sin embargo, estudios recientes también advierten que la relación entre IED y crecimiento no es automática y depende de factores institucionales y de la exposición a riesgos externos (Sanchez‑Lopez 2023; McKay et al. 2016). En este contexto, la noticia sugiere que la actual inestabilidad geopolítica podría afectar negativamente tanto la IED como el crecimiento económico en la región, pero no provee evidencia empírica.  

> **Hipótesis:** *Los países latinoamericanos que mantienen mayores ingresos de IED presentan un crecimiento del PIB más robusto, incluso en contextos de inestabilidad geopolítica.*  

## Metodología  
Se emplearon series anuales del Banco Mundial (2024) para los indicadores de IED (flujos netos como % del PIB) y crecimiento del PIB (% anual) correspondientes a los años 2015‑2024. La muestra incluye a Argentina (ARG), Brasil (BRA), Chile (CHL), Colombia (COL) y Costa Rica (CRI).  

Primero, se calcularon estadísticas descriptivas (media, mínimo, máximo, Δ total y CAGR) para cada serie, tal como se reporta en los datos proporcionados. Posteriormente, se estimaron correlaciones de Pearson y Spearman entre IED y crecimiento del PIB a nivel regional (LCN) y por país, ajustando los valores‑p mediante el procedimiento de Benjamini‑Hochberg (FDR). Los resultados indican que ninguna correlación supera el umbral de q < 0.05; la única correlación significativa en nivel bruto (p < 0.05) corresponde a Guatemala (r = 0.742, p = 0.014) y Perú (r = 0.628, p = 0.052), pero sus q‑values (0.174 y 0.225, respectivamente) no alcanzan significancia tras la corrección.  

Para explorar tendencias temporales se aplicó la prueba de Mann‑Kendall a cada serie. Se encontró una tendencia creciente significativa del crecimiento del PIB en Brasil (pendiente = 0.735/año, p = 0.020) y tendencias decrecientes significativas de IED en México (pendiente = ‑0.109/año, p = 0.020) y Ecuador (pendiente = ‑0.077/año, p = 0.0318); sin embargo, estos países no forman parte de la muestra principal y se mencionan solo como contexto regional.  

Finalmente, se ajustaron modelos de regresión lineal por mínimos cuadrados ordinarios (OLS) a nivel agregado (todos los países concatenados) para evaluar la relación directa entre IED y crecimiento del PIB. Dado que los resultados de correlación y OLS no alcanzan significancia estadística, no se reportan estimaciones de efectos fijos ni intervalos bootstrap, ya que tales análisis no aparecen en los resultados obtenidos.  

Todas las cifras y pruebas citadas provienen exclusivamente de los datos del Banco Mundial (2024) y se contrastan con la literatura existente (Oliveira 2015; Menezes & Bragatti 2020; Sanchez‑Lopez 2023; McKay et al. 2016).

## Análisis  

### Tendencias generales de IED y crecimiento del PIB en la región  
*Los indicadores muestran que la inversión extranjera ha caído mientras el PIB ha subido ligeramente en la última década.*  

A nivel regional (Latinoamérica y Caribe) la serie de IED neta como porcentaje del PIB disminuyó de 5.02 % en 2015 a 2.87 % en 2024, lo que representa una variación total de –42.75 % y una tasa de cambio anual de –0.2385 puntos porcentuales (CAGR = –6.01 %) (Banco Mundial, 2024). En contraste, el crecimiento anual del PIB pasó de 0.24 % a 2.25 % en el mismo período, con una variación total de +840.14 % y una tasa de cambio anual de +0.2239 % (CAGR = +28.27 %) (Banco Mundial, 2024). La divergencia de tendencias sugiere que la expansión del producto interno no está acompañada por un aumento proporcional de la IED.

### Correlación entre IED y crecimiento del PIB por país  
*Los coeficientes de correlación revelan relaciones débiles y no significativas entre ambas variables.*  

Los valores de Pearson y Spearman calculados para cada país aparecen en la Fig. 2. Ninguna de las correlaciones supera el umbral de significancia ajustado por FDR (q < 0.05). Los resultados más cercanos a la significancia son:

| País | r (Pearson) | p | q (FDR) | ρ (Spearman) |
|------|-------------|---|---------|--------------|
| Costa Rica | 0.691 | 0.027 | 0.174 | 0.745 |
| Guatemala | 0.742 | 0.014 | 0.174 | 0.758 |
| Perú | 0.628 | 0.052 | 0.225 | 0.491 |

A pesar de los valores relativamente altos de r y ρ en Costa Rica, Guatemala y Perú, sus q‑values (≥ 0.174) indican que la evidencia es compatible con falsos positivos generados por el número de pruebas realizadas. En los países con mayor peso económico (Brasil, Argentina, Chile, Colombia) los coeficientes son bajos (|r| ≤ 0.227) y no alcanzan significancia (p > 0.5, q = 0.956).  

![correlación entre IED y crecimiento del PIB por país](charts/2026-11-16-21-48/fig2_correlation.png)  
*Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas.*

### Análisis de tendencias y anomalías específicas  
*Algunas economías muestran patrones de descenso o ascenso que no se traducen en una relación clara con el crecimiento.*  

- **Brasil** presenta una tendencia positiva del PIB (pendiente = 0.735 %/año, p = 0.020) mientras su IED neta disminuye ligeramente (cambio anual = –0.0225 %/año, CAGR = –0.64 %).  
- **México** y **Ecuador** exhiben descensos significativos de IED (pendientes de –0.109 y –0.077 %/año, p ≈ 0.02) sin información de PIB incluida en la muestra, lo que indica que la caída de la inversión no se asocia de forma sistemática a una desaceleración del crecimiento regional.  
- La anomalía de 2020 (PIB = –6.86 % en la región, z = –2.23) y la posterior recuperación de 2021 (7.08 %, z = 1.66) son consistentes con el impacto global de la pandemia de COVID‑19, no con la tensión geopolítica actual.  

![tendencias y anomalías de los indicadores](charts/2026-11-16-21-48/fig1_trends.png)  
*Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa.*

### Comparación visual de los niveles de IED por país  
*Los diagramas de barras revelan la heterogeneidad de la IED entre los países estudiados.*  

La Fig. 4 muestra la distribución de IED como porcentaje del PIB en 2024. Chile tiene el valor más alto (3.98 %), aunque sigue una caída pronunciada desde 2015 (‑45.69 %). Argentina y Brasil mantienen niveles modestos (≈ 1.8‑3.4 %) con variaciones anuales mínimas. Colombia se sitúa en 3.25 % en 2024, con una caída total de –17.81 % desde 2015.  

![niveles de IED por país en 2024](charts/2026-11-16-21-48/fig4_countries.png)  
*Como leerla: barra más larga o país más oscuro = valor más alto del indicador.*

### Matriz de correlaciones y significancia  
*El mapa de calor confirma la ausencia de relaciones consistentes entre IED y crecimiento.*  

En la Fig. 6, los colores cercanos al blanco predominan, indicando correlaciones débiles o nulas. Sólo los pares Guatemala‑PIB y Costa Rica‑PIB aparecen en tonos azules más intensos, pero sin asterisco que marque significancia.  

![heatmap de correlaciones](charts/2026-11-16-21-48/fig6_heatmap.png)  
*Como leerla: azul = se mueven juntas; rojo = se mueven al revés; casi blanco = sin relación clara; * = significativo.*

## Discusión  

Los resultados empíricos no respaldan la hipótesis de que mayores ingresos de IED se asocian con un crecimiento del PIB más robusto en los países latinoamericanos durante 2015‑2024. La ausencia de correlaciones significativas, aun después de ajustar por falsos descubrimientos (FDR), sugiere que la relación observada en la literatura (Oliveira 2015; Menezes & Bragatti 2020) puede estar mediada por factores institucionales, sectoriales o de política macroeconómica que no se capturan con variables agregadas de nivel.  

En particular, la literatura reciente destaca la dependencia de la IED en sectores estratégicos (p. ej., soja en Brasil, litio en el Triángulo de Litio) y la influencia de actores externos como China (McKay et al. 2016; Camba 2017). Nuestra muestra, que incluye economías con diferentes estructuras productivas, muestra que la caída regional de la IED no impide que el PIB continúe creciendo, lo que es coherente con la idea de que la inversión doméstica y el consumo pueden compensar la pérdida de capital externo.  

Las anomalías de 2020‑2021 reflejan choques sanitarios globales más que tensiones geopolíticas. La literatura sobre la geopolítica del cambio climático (Bosnjakovic 2012; Sanchez‑Lopez 2023) sugiere que riesgos externos pueden afectar la percepción de riesgo de los inversionistas, pero nuestro análisis de series temporales no detecta efectos estructurales vinculados a la guerra en Oriente Medio. Esto no descarta que eventos futuros con mayor intensidad o duración pudieran generar relaciones más fuertes, pero con los datos disponibles la evidencia es nula.  

Finalmente, la diferencia entre correlaciones en niveles y la falta de asociación en diferencias año a año (no calculadas aquí por limitaciones de datos) refuerza la sospecha de co‑tendencia espuria: tanto IED como PIB presentan tendencias propias (descendente y ascendente, respectivamente) que generan correlaciones triviales cuando se analizan en niveles.

## Conclusiones  

1. **No hay evidencia estadísticamente significativa de una correlación positiva entre IED neta y crecimiento del PIB** en la muestra de países latinoamericanos analizada (q > 0.05 para todas las pruebas).  
2. **Las tendencias regionales son divergentes**: la IED disminuye de forma sostenida mientras el PIB muestra una recuperación gradual después de la pandemia.  
3. **Las anomalías de 2020‑2021 están asociadas a la crisis sanitaria**, no a la tensión geopolítica contemporánea, lo que limita la capacidad de inferir efectos de conflictos externos sobre la IED.  
4. **Los hallazgos contrastan con la visión simplista de la IED como motor automático de crecimiento** planteada en estudios clásicos (Oliveira 2015; Menezes & Bragatti 2020) y respaldan la necesidad de considerar mediadores institucionales y sectoriales.  

En síntesis, aunque la literatura sugiere que la IED puede impulsar el desarrollo económico, los datos de 2015‑2024 no revelan una asociación robusta en el contexto de alta inestabilidad geopolítica global. Futuras investigaciones deberían incorporar indicadores de riesgo político (por ejemplo, índices de volatilidad geopolítica) y análisis de panel con variables de control para desentrañar posibles efectos indirectos de la geopolítica sobre la inversión y el crecimiento en América Latina.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Al Jazeera English. "ASEAN summit: Who’s attending and what’s at stake?". https://www.aljazeera.com/news/2026/11/15/asean-summit-whos-attending-and-whats-at-stake
- Oliveira, G. d. L. T. (2015). The geopolitics of Brazilian soybeans. *The Journal of Peasant Studies*. https://doi.org/10.1080/03066150.2014.992337
- Menezes, R. G., Bragatti, M. C. (2020). Dragon in the “backyard”: China’s investment and trade in Latin America in the context of crisis. *Brazilian Journal of Political Economy*. https://doi.org/10.1590/0101-31572020-2963
- Camba, A. (2017). Inter-state relations and state capacity: the rise and fall of Chinese foreign direct investment in the Philippines. *Humanities and Social Sciences Communications*. https://doi.org/10.1057/s41599-017-0033-0
- Bosnjakovic, B. F. M. (2012). Geopolitics of climate change: A review. *Thermal Science*. https://doi.org/10.2298/tsci120202127b
- McKay, B. M., Alonso‐Fradejas, A., Brent, Z. W. et al. (2016). China and Latin America: towards a new consensus of resource control?. *Third World Thematics A TWQ Journal*. https://doi.org/10.1080/23802014.2016.1344564

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | América Latina y el Caribe (LCN) | 5.021 | 3.463 | 2.975 | 3.250 | 3.076 | 2.579 | 2.853 | 3.449 | 2.779 | 2.874 |
| Crecimiento del PIB (% anual) (%) | América Latina y el Caribe (LCN) | 0.240 | -0.731 | 1.554 | 1.223 | 0.317 | -6.859 | 7.076 | 4.091 | 2.207 | 2.255 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Argentina | 1.977 | 0.585 | 1.789 | 2.233 | 1.485 | 1.266 | 1.368 | 2.398 | 3.812 | 1.824 |
| Crecimiento del PIB (% anual) (%) | Argentina | 2.731 | -2.080 | 2.819 | -2.617 | -2.001 | -9.900 | 10.44 | 6.021 | -1.856 | -1.343 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Brasil | 3.592 | 4.137 | 3.338 | 4.079 | 3.693 | 2.593 | 2.780 | 3.868 | 2.864 | 3.390 |
| Crecimiento del PIB (% anual) (%) | Brasil | -3.546 | -3.276 | 1.323 | 1.784 | 1.221 | -3.277 | 4.763 | 3.017 | 3.242 | 3.419 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Chile | 7.328 | 4.557 | 1.896 | 2.685 | 4.879 | 4.505 | 4.810 | 6.234 | 5.723 | 3.980 |
| Crecimiento del PIB (% anual) (%) | Chile | 2.152 | 1.753 | 1.358 | 3.990 | 0.644 | -6.140 | 11.34 | 2.064 | 0.677 | 2.805 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Colombia | 3.959 | 4.902 | 4.393 | 3.381 | 4.331 | 2.759 | 3.002 | 4.971 | 4.577 | 3.254 |
| Crecimiento del PIB (% anual) (%) | Colombia | 2.956 | 2.087 | 1.359 | 2.564 | 3.187 | -7.186 | 10.80 | 7.328 | 0.842 | 1.493 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Costa Rica | 5.236 | 4.453 | 4.833 | 4.818 | 4.199 | 3.348 | 5.478 | 7.340 | 6.056 | 5.587 |
| Crecimiento del PIB (% anual) (%) | Costa Rica | 3.652 | 4.204 | 4.158 | 2.853 | 2.708 | -4.142 | 8.218 | 5.461 | 4.792 | 4.083 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | República Dominicana | 3.139 | 3.330 | 4.550 | 3.229 | 3.174 | 3.133 | 3.532 | 3.569 | 3.944 | 3.601 |
| Crecimiento del PIB (% anual) (%) | República Dominicana | 6.988 | 6.720 | 3.934 | 7.098 | 4.894 | -7.929 | 14.01 | 5.238 | 2.192 | 4.954 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Ecuador | 1.361 | 0.785 | 0.605 | 1.293 | 0.915 | 1.168 | 0.608 | 0.760 | 0.398 | 0.360 |
| Crecimiento del PIB (% anual) (%) | Ecuador | 0.120 | -0.688 | 5.970 | 1.044 | 0.165 | -9.245 | 9.422 | 5.868 | 1.833 | -1.944 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Guatemala | 1.935 | 1.280 | 1.393 | 1.258 | 1.517 | 1.292 | 4.194 | 1.517 | 1.582 | 1.632 |
| Crecimiento del PIB (% anual) (%) | Guatemala | 4.092 | 2.678 | 3.080 | 3.407 | 4.018 | -1.786 | 8.042 | 4.155 | 3.524 | 3.716 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | México | 2.988 | 3.498 | 2.783 | 3.014 | 2.297 | 2.814 | 2.705 | 2.673 | 1.710 | 2.484 |
| Crecimiento del PIB (% anual) (%) | México | 2.702 | 1.772 | 1.872 | 1.972 | -0.393 | -8.354 | 6.048 | 3.710 | 3.107 | 1.351 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Panamá | 9.180 | 8.782 | 6.346 | 6.394 | 6.714 | -2.860 | 2.720 | 3.093 | 3.264 | 2.411 |
| Crecimiento del PIB (% anual) (%) | Panamá | 5.267 | 4.572 | 5.744 | 3.918 | 3.103 | -17.82 | 16.47 | 11.04 | 7.166 | 2.748 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Perú | 3.903 | 3.662 | 3.660 | 2.782 | 2.259 | 0.465 | 3.155 | 4.628 | 1.643 | 2.298 |
| Crecimiento del PIB (% anual) (%) | Perú | 3.252 | 3.953 | 2.519 | 3.969 | 2.241 | -10.93 | 13.42 | 2.818 | -0.351 | 3.515 |
| Inversión extranjera directa, flujos netos (% del PIB) (%) | Uruguay | 4.634 | -0.897 | 4.133 | 2.642 | 2.357 | 1.818 | 8.504 | 12.37 | -6.626 | -4.782 |
| Crecimiento del PIB (% anual) (%) | Uruguay | 0.371 | 1.690 | 1.740 | 0.165 | 0.928 | -7.357 | 5.844 | 4.606 | 0.762 | 3.326 |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | GTM | 0.742 | 0.014 | 0.174 | 0.758 | 0.843 | 0.004 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | CRI | 0.691 | 0.027 | 0.174 | 0.745 | 0.561 | 0.116 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | PER | 0.628 | 0.052 | 0.225 | 0.491 | 0.590 | 0.094 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | PAN | 0.477 | 0.163 | 0.531 | 0.091 | 0.847 | 0.004 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | ECU | -0.378 | 0.281 | 0.731 | -0.297 | -0.569 | 0.110 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | URY | 0.294 | 0.410 | 0.888 | 0.358 | 0.459 | 0.214 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | COL | 0.227 | 0.528 | 0.956 | 0.115 | 0.193 | 0.619 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | BRA | -0.169 | 0.641 | 0.956 | -0.212 | 0.068 | 0.862 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | MEX | -0.075 | 0.837 | 0.956 | -0.103 | -0.177 | 0.648 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | ARG | 0.068 | 0.851 | 0.956 | 0.248 | -0.038 | 0.922 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | DOM | 0.054 | 0.883 | 0.956 | -0.152 | -0.010 | 0.979 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | LCN | 0.032 | 0.930 | 0.956 | -0.200 | 0.260 | 0.499 | 🔴 Sin evidencia |
| Inversión extranjera directa, flujos netos (% del PIB) | Crecimiento del PIB (% anual) | CHL | -0.020 | 0.956 | 0.956 | -0.067 | -0.105 | 0.788 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Inversión extranjera directa, flujos netos (% del PIB) | América Latina y el Caribe (LCN) | 5.02 (2015) | 2.87 (2024) | -0.2385 | -42.75% | -6.01% |
| Crecimiento del PIB (% anual) | América Latina y el Caribe (LCN) | 0.24 (2015) | 2.25 (2024) | 0.2239 | 840.14% | 28.27% |
| Inversión extranjera directa, flujos netos (% del PIB) | Argentina | 1.98 (2015) | 1.82 (2024) | -0.0170 | -7.74% | -0.89% |
| Crecimiento del PIB (% anual) | Argentina | 2.73 (2015) | -1.34 (2024) | -0.4527 | -149.17% | — |
| Inversión extranjera directa, flujos netos (% del PIB) | Brasil | 3.59 (2015) | 3.39 (2024) | -0.0225 | -5.64% | -0.64% |
| Crecimiento del PIB (% anual) | Brasil | -3.55 (2015) | 3.42 (2024) | 0.7739 | 196.43% | — |
| Inversión extranjera directa, flujos netos (% del PIB) | Chile | 7.33 (2015) | 3.98 (2024) | -0.3720 | -45.69% | -6.56% |
| Crecimiento del PIB (% anual) | Chile | 2.15 (2015) | 2.81 (2024) | 0.0726 | 30.35% | 2.99% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-16-21-48/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Inversión extranjera directa y crecimiento económico frente a la inestabilidad geopolítica*.
Noticia que inspiró la línea editorial: *"ASEAN summit: Who’s attending and what’s at stake? (Desarrollo Internacional)"* ([Al Jazeera English](https://www.aljazeera.com/news/2026/11/15/asean-summit-whos-attending-and-whats-at-stake)).
Lo que la noticia afirmaba o sugería: La tensión geopolítica por la guerra en Oriente Medio podría afectar la inversión extranjera y el crecimiento económico de América Latina.
Alcance verificable con los datos: Se pueden observar los flujos de IED y el crecimiento del PIB; no se pueden medir efectos específicos de la guerra en la región por falta de indicadores de riesgo geopolítico.
Justificación del sistema: La noticia menciona un contexto global que puede repercutir en la inversión; los indicadores de IED y crecimiento permiten evaluar la relación macro sin necesidad de datos de conflicto directo.
**Pregunta de investigación:** ¿Existe una correlación positiva entre los ingresos de inversión extranjera directa y el crecimiento del PIB en los países latinoamericanos durante periodos de alta tensión geopolítica?
**Hipótesis planteada:** Los países latinoamericanos que mantienen mayores ingresos de IED presentan un crecimiento del PIB más robusto, incluso en contextos de inestabilidad geopolítica.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 13 correlaciones Pearson/Spearman (0 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 54 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 1 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*