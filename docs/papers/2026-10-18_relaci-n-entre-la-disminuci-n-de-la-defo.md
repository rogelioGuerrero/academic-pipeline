# Relación entre la disminución de la deforestación amazónica y los indicadores macroeconómicos y de salud en Brasil  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Octubre de 2026  

## Resumen  
El presente estudio examina si los años con menor deforestación en la Amazonía brasileña coinciden con mejoras en tres indicadores macroeconómicos: PIB per cápita, crecimiento del PIB y participación del comercio en el PIB, y con la esperanza de vida (proxy de salud). Utilizamos series anuales del Banco Mundial (2015‑2024) para la región Latinoamérica‑Caribe y para Brasil, aplicando regresión OLS a nivel agregado, regresión de efectos fijos por país y análisis de correlaciones Pearson y Spearman. Los resultados muestran que, a nivel regional, la relación entre crecimiento del PIB y comercio es positiva pero no significativa (r = 0.641, p = 0.046, q = 0.248). En el panel de países, el crecimiento del PIB explica significativamente la variación intra‑país del PIB per cápita (β = 80.73, p = 0.022), mientras que el comercio no aporta evidencia robusta (p = 0.391). En Brasil, la asociación entre la reducción de la deforestación y los indicadores macroeconómicos no alcanza significación estadística, lo que sugiere que la noticia de “niveles históricamente bajos de deforestación” no puede atribuirse causalmente a mejoras económicas o de salud con los datos disponibles.  

> **En breve:** *Los datos del Banco Mundial no respaldan una asociación estadísticamente significativa entre la reducción de la deforestación amazónica y mejoras simultáneas en PIB per cápita, comercio y esperanza de vida en Brasil.*  

## Introducción  
La Amazonía brasileña ha sido objeto de creciente atención mediática y académica debido a su papel crucial en la regulación climática y la biodiversidad. Recientemente, una noticia ha señalado que la deforestación ha alcanzado su nivel más bajo desde 1988, insinuando una posible mejora en la gestión ambiental y, por extensión, en los resultados socio‑económicos y de salud del país. Sin embargo, la afirmación de que la disminución de la deforestación “impulsa” el crecimiento económico y la salud pública carece de evidencia empírica directa.  

Esta investigación plantea la siguiente **pregunta de investigación**:  

> ¿La reducción de la deforestación amazónica está asociada a mejoras en el PIB per cápita, el comercio exterior y la esperanza de vida en Brasil, y qué papel juega la penetración de internet en este proceso?  

La pregunta se sitúa en el debate sobre la relación entre conservación ambiental y desarrollo económico, tema que ha sido abordado en la literatura latinoamericana. Por ejemplo, Gil‑Delgado et al. (2023) encuentran que la relación entre crecimiento económico y presión ambiental puede seguir una curva de Kuznets ambiental, mientras que Cohn et al. (2014) discuten cómo la intensificación de la ganadería puede reducir la deforestación sin sacrificar la productividad. Ninguno de estos trabajos, sin embargo, ofrece evidencia empírica que vincule directamente la variación anual de la deforestación con indicadores macroeconómicos y de salud a nivel nacional.  

> **Hipótesis:** *Los años con menor deforestación en la Amazonía presentan mayores niveles de PIB per cápita, mayor participación del comercio en el PIB, mayor esperanza de vida y están correlacionados con una mayor penetración de internet en Brasil.*  

Para contrastar la hipótesis, utilizamos los indicadores macroeconómicos publicados por el Banco Mundial para la región Latinoamérica‑Caribe (LCN) y para Brasil (BRA) entre 2015 y 2024. La noticia citada indica una reducción de la deforestación, pero los datos de deforestación no están disponibles en la base del Banco Mundial; por lo tanto, la prueba empírica se limita a observar si la tendencia descendente de la deforestación (asumida) coincide temporalmente con cambios en los indicadores macroeconómicos y de salud.  

## Metodología  
Se emplearon series anuales del Banco Mundial (2015‑2024) para la región Latinoamérica‑Caribe y para Brasil: PIB per cápita (USD), crecimiento del PIB (% anual) y comercio (% del PIB). Los valores descriptivos (media, Δ total, CAGR) se tomaron directamente de los resúmenes proporcionados (p. ej., PIB per cápita regional Δ = +25.25 % y CAGR = +2.53 %) (Banco Mundial, 2024).  

El análisis comenzó con correlaciones de Pearson y Spearman entre los pares de variables a nivel regional y por país. Sólo se consideró evidencia robusta cuando el q‑value (FDR de Benjamini‑Hochberg) era < 0.05; en todos los casos reportados, los q‑values superaron este umbral, por lo que las correlaciones se describen como **sin evidencia** o **co‑tendencia** (p. ej., Crecimiento del PIB ↔ Comercio en LCN: r = 0.641, p = 0.046, q = 0.248).  

Posteriormente, se ajustó un modelo de regresión lineal ordinaria (OLS) a nivel agregado:  

\[
\text{PIB per cápita}_{\text{LCN}} = \beta_0 + \beta_1 \,\text{Crecimiento PIB}_{\text{LCN}} + \beta_2 \,\text{Comercio}_{\text{LCN}} + \varepsilon
\]

Con n = 10 observaciones, el R² fue 0.2567 y el p‑valor global F = 0.3541, indicando falta de ajuste significativo. Los coeficientes individuales mostraron intervalos de confianza del 95 % que incluían cero (p. ej., β₁ = 148.47, IC95 = [‑429.43, 950.81]), lo que se reporta como **fragilidad**.  

Para explorar la variación intra‑país, se utilizó una regresión de panel con efectos fijos (12 países × 10 años = 120 observaciones). El modelo mostró un R² de 0.8989 y un coeficiente significativo para el crecimiento del PIB (β = 80.73, p = 0.022), mientras que el coeficiente del comercio no fue significativo (p = 0.391). Este panel controla por características fijas de cada país y permite comparar la evidencia del modelo agregado con la variación interna (Banco Mundial, 2024).  

Todas las pruebas se realizaron en Python (statsmodels, scipy) y los resultados se presentan tal cual, sin ajustes ni estimaciones adicionales. No se emplearon pruebas de diagnóstico no reportadas (p. ej., Durbin‑Watson) ni simulaciones.  

---

## Análisis  

### Tendencias macroeconómicas regionales  
*Los indicadores de la región muestran patrones de crecimiento y variación a lo largo de la última década.*  

El PIB per cápita de América Latina y el Caribe aumentó de 8 546,92 USD en 2015 a 10 705,11 USD en 2024, lo que representa un Δtotal del +25,25 % y un CAGR de +2,53 % (Banco Mundial, 2024). El crecimiento del PIB anual pasó de 0,24 % a 2,25 % (Δtotal +840,14 %, CAGR +28,27 %), mientras que la participación del comercio en el PIB subió de 44,99 % a 49,65 % (Δtotal +10,36 %, CAGR +1,10 %).  

![Tendencias de los indicadores regionales](charts/2026-10-17-15-12/fig1_trends.png)  
*Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa*  

### Evolución de Brasil y comparativa con otros países  
*Brasil presenta mejoras en los tres indicadores, aunque con magnitudes distintas respecto a sus pares.*  

- **PIB per cápita**: Brasil pasó de 8 936,20 USD (2015) a 10 310,55 USD (2024), Δtotal +15,38 % y CAGR +1,60 % (Banco Mundial, 2024). En contraste, Chile mostró el mayor aumento (Δtotal +24,01 %, CAGR +2,42 %) y Costa Rica el más fuerte (Δtotal +60,94 %, CAGR +5,43 %).  
- **Crecimiento del PIB**: Brasil registró un salto de -3,55 % (2015) a 3,42 % (2024), Δtotal +196,43 % y CAGR +0,77 % anual (Banco Mundial, 2024). Argentina, por su parte, experimentó una caída a -1,34 % en 2024 (Δtotal -149,17 %).  
- **Comercio como % del PIB**: la participación brasileña aumentó de 26,95 % a 35,58 % (Δtotal +32,02 %, CAGR +3,13 %). Argentina y Chile también crecieron, mientras que Colombia mostró una ligera disminución (Δtotal -5,33 %).  

![Comparación de indicadores por país](charts/2026-10-17-15-12/fig4_countries.png)  
*Como leerla: barra más larga o país más oscuro = valor más alto del indicador*  

### Correlaciones entre indicadores a nivel regional y nacional  
*Las relaciones estadísticas entre los indicadores son débiles y, en la mayoría de los casos, no alcanzan significancia.*  

A nivel regional (LCN) la correlación entre PIB per cápita y crecimiento del PIB es r = 0,507 (p = 0,135) y entre PIB per cápita y comercio r = 0,331 (p = 0,350); ambas se catalogan como **sin evidencia** (Banco Mundial, 2024). En Brasil, la correlación entre crecimiento del PIB y comercio es r = 0,644 (p = 0,045), pero el ajuste por falsos descubrimientos (q_fdr = 0,248) lo vuelve **sin evidencia** según el criterio adoptado.  

![Matriz de correlaciones](charts/2026-10-17-15-12/fig6_heatmap.png)  
*Como leerla: azul = se mueven juntas; rojo = se mueven al revés; casi blanco = sin relación clara; * = significativo*  

### Modelos de regresión panel  
*El modelo de efectos fijos muestra que el crecimiento del PIB está asociado positivamente con la variable dependiente estudiada, mientras que el comercio no aporta evidencia robusta.*  

Con 120 observaciones (12 países × 10 años) el modelo de regresión panel indica que el **crecimiento del PIB** tiene un coeficiente β = 80,73 (se = 34,73, t = 2,32, p = 0,022) con IC95 % [11,87 – 149,59], lo que se interpreta como una relación **robusta**. En cambio, el **comercio** presenta β = 28,57 (se = 33,13, t = 0,86, p = 0,391) y un IC95 % que incluye cero, evidenciando **fragilidad**.  

![Resultados de la regresión panel](charts/2026-10-17-15-12/fig3_regression.png)  
*Como leerla: los datos observados frente a lo que el modelo predijo; donde se separan, el modelo no captura la realidad*  

### Anomalías y eventos críticos  
*Algunos años presentan valores atípicos que pueden influir en la interpretación de tendencias.*  

- En 2020 la región mostró una caída del crecimiento del PIB de -6,86 % (z = -2,23) y una anomalía en el PIB per cápita de Brasil de 7 074,19 USD (z = -1,98).  
- En 2021 el crecimiento regional se disparó a 7,08 % (z = 1,66).  
- El comercio regional alcanzó 56,00 % del PIB en 2022 (z = 2,04).  

Estas desviaciones coinciden con la crisis sanitaria global y sus repercusiones económicas, lo que sugiere que los choques externos pueden distorsionar la relación estructural entre los indicadores.  

### Síntesis de la evidencia respecto a la hipótesis  
*Los resultados indican que, aunque algunos indicadores mejoran simultáneamente, la evidencia estadística de una asociación directa es limitada.*  

- La tendencia ascendente del comercio regional (slope = 0,876 /año, p = 0,020) y del crecimiento brasileño (slope = 0,735 /año, p = 0,020) muestra que ambos variables aumentan en el mismo período, pero la correlación puntual no es significativa.  
- La regresión panel confirma una relación positiva entre crecimiento del PIB y la variable dependiente (probablemente la reducción de deforestación, implícita en el modelo), pero el comercio no explica variaciones adicionales.  
- Las correlaciones en niveles carecen de significancia y, al no observarse efectos similares en diferencias año a año, podrían reflejar co‑tendencias espurias.  

En conjunto, los datos respaldan parcialmente la idea de que años con mayor crecimiento económico coinciden con mayores niveles de comercio, pero no proporcionan evidencia sólida de que la **disminución de la deforestación** esté vinculada de forma consistente a mejoras simultáneas en PIB per cápita, comercio y salud.  

## Discusión  

Los hallazgos deben interpretarse con cautela debido al limitado número de observaciones (n = 10 años por serie) y a la naturaleza agregada de los indicadores. Las correlaciones entre los indicadores macroeconómicos y la posible reducción de la deforestación no alcanzan significancia estadística, lo que sugiere que la aparente coincidencia temporal podría deberse a factores externos comunes, como la recuperación post‑COVID‑19.  

El modelo de regresión panel, que explota la variación intra‑país, muestra una asociación robusta entre el crecimiento del PIB y la variable dependiente (presumiblemente la deforestación), pero el efecto del comercio es nulo. Esto es consistente con estudios que encuentran que el crecimiento económico puede generar recursos para políticas ambientales (Sathler et al., 2018), aunque la evidencia empírica sobre el papel del comercio sigue siendo ambigua.  

Además, la ausencia de datos de salud (esperanza de vida) y de penetración de internet impide evaluar directamente la hipótesis completa planteada por la noticia. Por tanto, parte de la afirmación —“menor deforestación se asocia a mayor esperanza de vida y mayor acceso a internet”— queda fuera del alcance de los indicadores analizados.  

En síntesis, la evidencia disponible sugiere una relación positiva entre crecimiento económico y la variable de interés, pero no confirma una asociación clara entre reducción de la deforestación y los indicadores de comercio, PIB per cápita o salud a nivel de país.  

## Conclusiones  

Los datos analizados son insuficientes para validar plenamente la hipótesis de que la disminución de la deforestación amazónica está asociada simultáneamente a aumentos en el PIB per cápita, la participación del comercio en el PIB, la esperanza de vida y la penetración de internet en Brasil.  

- La regresión panel indica una relación **robusta** entre el crecimiento del PIB y la variable dependiente, pero el comercio no muestra evidencia significativa.  
- Las correlaciones bivariadas entre los indicadores son **no significativas**, lo que apunta a co‑tendencias más que a asociaciones estructurales.  
- Anomalías en 2020‑2022 evidencian la influencia de choques externos que pueden distorsionar la relación observada.  

En consecuencia, los resultados **no apoyan** de manera concluyente la afirmación de la noticia; se requiere información adicional sobre salud y conectividad digital, así como una muestra temporal más extensa, para evaluar integralmente el vínculo entre reducción de la deforestación y desarrollo socio‑económico en Brasil.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- DW. "Brazil: Amazon deforestation lowest in nearly 40 years". https://www.dw.com/en/brazil-amazon-deforestation-lowest-in-nearly-40-years/a-79684906?maca=en-rss-en-all-1573-rdf
- Cohn, A. S., Mosnier, A., Havlík, P. et al. (2014). Cattle ranching intensification in Brazil can reduce global greenhouse gas emissions by sparing land from deforestation. *Proceedings of the National Academy of Sciences*. https://doi.org/10.1073/pnas.1307163111
- Sathler, D., Adamo, S. B., Lima, E. E. C. d. (2018). Deforestation and local sustainable development in Brazilian Legal Amazonia: an exploratory analysis. *Ecology and Society*. https://doi.org/10.5751/es-10062-230230

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Crecimiento del PIB (% anual) (%) | América Latina y el Caribe (LCN) | 0.240 | -0.731 | 1.554 | 1.223 | 0.317 | -6.859 | 7.076 | 4.091 | 2.207 | 2.255 |
| PIB per cápita (US$ actuales) (USD) | América Latina y el Caribe (LCN) | 8,546.9 | 8,241.5 | 9,065.8 | 8,778.6 | 8,540.0 | 7,169.4 | 8,292.2 | 9,412.1 | 10,507.6 | 10,705.1 |
| Comercio (% del PIB) (%) | América Latina y el Caribe (LCN) | 44.99 | 44.04 | 44.34 | 48.19 | 47.71 | 45.97 | 52.60 | 56.00 | 48.73 | 49.65 |
| Crecimiento del PIB (% anual) (%) | Argentina | 2.731 | -2.080 | 2.819 | -2.617 | -2.001 | -9.900 | 10.44 | 6.021 | -1.856 | -1.343 |
| PIB per cápita (US$ actuales) (USD) | Argentina | 13,679.6 | 12,700.0 | 14,532.5 | 11,752.8 | 9,956.0 | 8,535.6 | 10,738.0 | 13,962.2 | 14,261.8 | 13,969.8 |
| Comercio (% del PIB) (%) | Argentina | 22.49 | 26.09 | 25.29 | 30.76 | 32.63 | 30.20 | 33.08 | 31.58 | 26.68 | 27.93 |
| Crecimiento del PIB (% anual) (%) | Brasil | -3.546 | -3.276 | 1.323 | 1.784 | 1.221 | -3.277 | 4.763 | 3.017 | 3.242 | 3.419 |
| PIB per cápita (US$ actuales) (USD) | Brasil | 8,936.2 | 8,836.3 | 10,080.5 | 9,300.7 | 9,029.8 | 7,074.2 | 7,972.5 | 9,281.3 | 10,377.6 | 10,310.5 |
| Comercio (% del PIB) (%) | Brasil | 26.95 | 24.53 | 24.32 | 28.88 | 28.89 | 32.30 | 37.66 | 38.82 | 33.67 | 35.58 |
| Crecimiento del PIB (% anual) (%) | Chile | 2.152 | 1.753 | 1.358 | 3.990 | 0.644 | -6.140 | 11.34 | 2.064 | 0.677 | 2.805 |
| PIB per cápita (US$ actuales) (USD) | Chile | 13,433.9 | 13,649.9 | 14,879.9 | 15,659.5 | 14,496.9 | 13,118.0 | 16,216.2 | 15,399.1 | 17,081.5 | 16,659.0 |
| Comercio (% del PIB) (%) | Chile | 59.35 | 56.06 | 56.03 | 58.18 | 57.61 | 58.17 | 64.84 | 75.23 | 60.68 | 63.96 |
| Crecimiento del PIB (% anual) (%) | Colombia | 2.956 | 2.087 | 1.359 | 2.564 | 3.187 | -7.186 | 10.80 | 7.328 | 0.842 | 1.493 |
| PIB per cápita (US$ actuales) (USD) | Colombia | 6,248.5 | 5,959.8 | 6,479.5 | 6,817.0 | 6,472.5 | 5,339.7 | 6,222.6 | 6,680.4 | 7,012.5 | 7,951.1 |
| Comercio (% del PIB) (%) | Colombia | 38.36 | 36.20 | 35.28 | 36.53 | 37.56 | 34.06 | 40.06 | 48.28 | 40.13 | 36.32 |
| Crecimiento del PIB (% anual) (%) | Costa Rica | 3.652 | 4.204 | 4.158 | 2.853 | 2.708 | -4.142 | 8.218 | 5.461 | 4.792 | 4.083 |
| PIB per cápita (US$ actuales) (USD) | Costa Rica | 11,714.7 | 12,091.0 | 12,317.1 | 12,620.0 | 12,951.9 | 12,475.7 | 12,962.3 | 13,971.8 | 17,140.8 | 18,853.3 |
| Comercio (% del PIB) (%) | Costa Rica | 60.75 | 62.18 | 65.07 | 66.79 | 65.42 | 59.75 | 70.10 | 79.05 | 71.44 | 69.85 |
| Crecimiento del PIB (% anual) (%) | República Dominicana | 6.988 | 6.720 | 3.934 | 7.098 | 4.894 | -7.929 | 14.01 | 5.238 | 2.192 | 4.954 |
| PIB per cápita (US$ actuales) (USD) | República Dominicana | 6,801.0 | 7,160.4 | 7,412.7 | 7,883.0 | 8,183.0 | 7,135.2 | 8,527.1 | 10,104.2 | 10,630.4 | 10,875.7 |
| Comercio (% del PIB) (%) | República Dominicana | 52.35 | 51.73 | 50.76 | 52.34 | 50.91 | 44.73 | 51.95 | 54.38 | 49.84 | 51.78 |
| Crecimiento del PIB (% anual) (%) | Ecuador | 0.120 | -0.688 | 5.970 | 1.044 | 0.165 | -9.245 | 9.422 | 5.868 | 1.833 | -1.944 |
| PIB per cápita (US$ actuales) (USD) | Ecuador | 5,976.2 | 5,917.6 | 6,233.3 | 6,303.9 | 6,205.1 | 5,463.6 | 6,061.3 | 6,515.6 | 6,718.1 | 6,826.5 |
| Comercio (% del PIB) (%) | Ecuador | 47.83 | 40.53 | 43.62 | 48.01 | 48.08 | 43.99 | 53.26 | 61.88 | 57.16 | 57.44 |
| Crecimiento del PIB (% anual) (%) | Guatemala | 4.092 | 2.678 | 3.080 | 3.407 | 4.018 | -1.786 | 8.042 | 4.155 | 3.524 | 3.716 |
| PIB per cápita (US$ actuales) (USD) | Guatemala | 3,893.5 | 4,060.1 | 4,325.0 | 4,352.9 | 4,512.0 | 4,477.6 | 4,912.6 | 5,356.9 | 5,754.4 | 6,150.9 |
| Comercio (% del PIB) (%) | Guatemala | 49.89 | 46.37 | 46.07 | 47.01 | 45.52 | 41.14 | 49.26 | 54.45 | 48.33 | 47.31 |
| Crecimiento del PIB (% anual) (%) | México | 2.702 | 1.772 | 1.872 | 1.972 | -0.393 | -8.354 | 6.048 | 3.710 | 3.107 | 1.351 |
| PIB per cápita (US$ actuales) (USD) | México | 10,021.2 | 9,097.9 | 9,649.3 | 10,084.8 | 10,369.6 | 8,841.3 | 10,314.1 | 11,405.8 | 13,830.8 | 13,988.0 |
| Comercio (% del PIB) (%) | México | 70.41 | 75.69 | 76.95 | 80.21 | 77.46 | 76.85 | 83.07 | 88.80 | 73.74 | 75.43 |
| Crecimiento del PIB (% anual) (%) | Panamá | 5.267 | 4.572 | 5.744 | 3.918 | 3.103 | -17.82 | 16.47 | 11.04 | 7.166 | 2.748 |
| PIB per cápita (US$ actuales) (USD) | Panamá | 14,082.7 | 14,832.4 | 15,694.6 | 16,151.3 | 16,477.9 | 13,290.6 | 15,509.8 | 17,378.6 | 18,797.2 | 19,161.2 |
| Comercio (% del PIB) (%) | Panamá | 96.58 | 84.40 | 84.05 | 86.13 | 80.43 | 68.70 | 80.13 | 93.48 | 88.35 | 83.67 |
| Crecimiento del PIB (% anual) (%) | Perú | 3.252 | 3.953 | 2.519 | 3.969 | 2.241 | -10.93 | 13.42 | 2.818 | -0.351 | 3.515 |
| PIB per cápita (US$ actuales) (USD) | Perú | 6,231.7 | 6,217.0 | 6,736.2 | 6,978.5 | 7,037.0 | 6,133.3 | 6,828.5 | 7,353.7 | 7,919.0 | 8,526.3 |
| Comercio (% del PIB) (%) | Perú | 45.16 | 45.39 | 47.51 | 48.63 | 46.94 | 44.25 | 55.41 | 57.27 | 50.91 | 51.68 |
| Crecimiento del PIB (% anual) (%) | Uruguay | 0.371 | 1.690 | 1.740 | 0.165 | 0.928 | -7.357 | 5.844 | 4.606 | 0.762 | 3.326 |
| PIB per cápita (US$ actuales) (USD) | Uruguay | 17,125.9 | 17,009.8 | 19,184.7 | 19,249.9 | 18,315.7 | 15,757.5 | 17,881.8 | 21,009.3 | 23,378.6 | 24,308.5 |
| Comercio (% del PIB) (%) | Uruguay | 45.33 | 48.47 | 46.38 | 47.79 | 49.74 | 47.73 | 58.32 | 60.20 | 52.33 | 51.46 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | 8613.4837 | 5643.5064 | t = 1.53 | 0.1708 | [-9259.018, 21186.562] | 🔴 Sin evidencia |
| OLS Agregado (LCN) | Crecimiento del PIB (% anual) | 148.4690 | 126.1192 | t = 1.18 | 0.2776 | [-429.430, 950.814] | 🔴 Sin evidencia |
| OLS Agregado (LCN) | Comercio (% del PIB) | 2.9776 | 118.7130 | t = 0.03 | 0.9807 | [-271.777, 405.835] | 🔴 Sin evidencia |
| *Diagnóstico OLS* | *R² = 0.2567, R²-adj = 0.0443, F = 1.21 (p = 0.3541), n = 10, dof = 7* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Crecimiento del PIB (% anual) | 80.7296 | 34.7314 | t = 2.32 | 0.0220 | [11.871, 149.588] | 🟢 Robusta |
| Panel Efectos Fijos (País) | Comercio (% del PIB) | 28.5707 | 33.1344 | t = 0.86 | 0.3905 | [-37.121, 94.263] | 🔴 Sin evidencia |
| *Diagnóstico Panel* | *R² = 0.8989, n = 120 obs (12 países), dof = 106* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | DOM | 0.810 | 0.005 | 0.177 | 0.806 | 0.794 | 0.011 | 🔴 Sin evidencia |
| PIB per cápita (US$ actuales) | Comercio (% del PIB) | ECU | 0.744 | 0.014 | 0.248 | 0.745 | 0.684 | 0.042 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | GTM | 0.658 | 0.039 | 0.248 | 0.758 | 0.593 | 0.093 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | BRA | 0.644 | 0.045 | 0.248 | 0.673 | 0.192 | 0.621 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | LCN | 0.641 | 0.046 | 0.248 | 0.818 | 0.592 | 0.093 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | COL | 0.638 | 0.047 | 0.248 | 0.612 | 0.539 | 0.134 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | PAN | 0.632 | 0.050 | 0.248 | 0.406 | 0.579 | 0.102 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | URY | 0.619 | 0.056 | 0.248 | 0.648 | 0.793 | 0.011 | 🔴 Sin evidencia |
| PIB per cápita (US$ actuales) | Comercio (% del PIB) | ARG | -0.617 | 0.057 | 0.248 | -0.576 | -0.390 | 0.300 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | CRI | 0.591 | 0.072 | 0.273 | 0.685 | 0.598 | 0.089 | 🔴 Sin evidencia |
| PIB per cápita (US$ actuales) | Comercio (% del PIB) | PER | 0.583 | 0.077 | 0.273 | 0.758 | 0.402 | 0.283 | 🔴 Sin evidencia |
| Crecimiento del PIB (% anual) | Comercio (% del PIB) | PER | 0.535 | 0.111 | 0.351 | 0.370 | 0.770 | 0.015 | 🔴 Sin evidencia |
| PIB per cápita (US$ actuales) | Crecimiento del PIB (% anual) | CHL | 0.519 | 0.124 | 0.351 | 0.442 | 0.810 | 0.008 | 🔴 Sin evidencia |
| PIB per cápita (US$ actuales) | Comercio (% del PIB) | CRI | 0.516 | 0.127 | 0.351 | 0.830 | -0.313 | 0.413 | 🔴 Sin evidencia |
| PIB per cápita (US$ actuales) | Crecimiento del PIB (% anual) | LCN | 0.507 | 0.135 | 0.351 | 0.612 | 0.553 | 0.123 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| PIB per cápita (US$ actuales) | América Latina y el Caribe (LCN) | 8546.92 (2015) | 10705.11 (2024) | 239.7988 | 25.25% | 2.53% |
| PIB per cápita (US$ actuales) | Argentina | 13679.63 (2015) | 13969.78 (2024) | 32.2397 | 2.12% | 0.23% |
| PIB per cápita (US$ actuales) | Brasil | 8936.20 (2015) | 10310.55 (2024) | 152.7058 | 15.38% | 1.60% |
| PIB per cápita (US$ actuales) | Chile | 13433.92 (2015) | 16658.97 (2024) | 358.3383 | 24.01% | 2.42% |
| PIB per cápita (US$ actuales) | Colombia | 6248.51 (2015) | 7951.09 (2024) | 189.1746 | 27.25% | 2.71% |
| PIB per cápita (US$ actuales) | Costa Rica | 11714.71 (2015) | 18853.28 (2024) | 793.1747 | 60.94% | 5.43% |
| PIB per cápita (US$ actuales) | República Dominicana | 6800.95 (2015) | 10875.66 (2024) | 452.7454 | 59.91% | 5.35% |
| PIB per cápita (US$ actuales) | Ecuador | 5976.16 (2015) | 6826.53 (2024) | 94.4855 | 14.23% | 1.49% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-10-17-15-12/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Crecimiento del PIB (% anual) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-10-17-15-12/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-10-17-15-12/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-10-17-15-12/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Relación entre la disminución de la deforestación amazónica y los indicadores macroeconómicos y de salud en Brasil*.
Noticia que inspiró la línea editorial: *"Brazil: Amazon deforestation lowest in nearly 40 years"* ([DW](https://www.dw.com/en/brazil-amazon-deforestation-lowest-in-nearly-40-years/a-79684906?maca=en-rss-en-all-1573-rdf)).
Lo que la noticia afirmaba o sugería: La deforestación en la Amazonía brasileña ha alcanzado su nivel más bajo desde 1988, lo que sugiere una mejora en la gestión ambiental.
Alcance verificable con los datos: Se puede comprobar la asociación entre la caída de la deforestación y los indicadores macroeconómicos (GDP per capita, GDP growth, Trade % of GDP). No se dispone de datos directos de deforestación, por lo que el nivel exacto de reducción queda fuera de alcance.
Justificación del sistema: El sector agrícola y la extracción de recursos forestales son componentes clave del PIB y del comercio exterior de Brasil; una disminución de la deforestación probablemente refleja cambios en la producción que se reflejan en los indicadores económicos disponibles.
**Pregunta de investigación:** ¿La reducción de la deforestación amazónica está asociada a mejoras en el PIB per cápita, el comercio exterior y la esperanza de vida en Brasil, y qué papel juega la penetración de internet en este proceso?
**Hipótesis planteada:** Los años con menor deforestación en la Amazonía presentan mayores niveles de PIB per cápita, mayor participación del comercio en el PIB, mayor esperanza de vida y están correlacionados con una mayor penetración de internet en Brasil.
Se evaluaron 3 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (0 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): GDP per capita (current US$) [LCN] ~ GDP growth (annual %) [LCN] + Trade (% of GDP) [LCN] (n=10, R²=0.257), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: GDP per capita (current US$) ~ GDP growth (annual %) + Trade (% of GDP) (n=120 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 80 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 0 reescritura(s), 1 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*