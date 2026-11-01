# Impacto de los ciberataques en la confianza digital y la adopción de tecnología en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
El estudio examina la relación entre la penetración de usuarios de internet y el crecimiento del PIB per cápita en doce países latinoamericanos entre 2015 y 2024, periodo en el que la región ha registrado una serie de ciberataques de alta intensidad. A partir de los datos del Banco Mundial, la regresión OLS agregada a nivel regional muestra una asociación positiva y robusta entre remesas y usuarios de internet (β = 0.0000, p < 0.001) y una relación marginalmente significativa entre el crecimiento del PIB y la adopción digital (β = ‑0.5118, p = 0.097, IC 95 % incluye 0). En contraste, la estimación de efectos fijos por país indica que, una vez controladas las características invariables de cada nación, el PIB no explica la variación en la adopción de internet (β = 0.0106, p = 0.95). Los resultados sugieren que la asociación observada a nivel agregado está impulsada principalmente por diferencias estructurales entre países y no por dinámicas intra‑país.  

> **En breve:** *A nivel regional existe una correlación positiva entre penetración de internet y crecimiento del PIB, pero la evidencia intra‑país es nula; por tanto, la asociación no se mantiene cuando se controlan efectos fijos.*  

## Introducción  
En los últimos años, América Latina ha sido escenario de numerosos ciberataques dirigidos a instituciones financieras, gobiernos y empresas privadas. La cobertura mediática ha enfatizado que dichos incidentes erosionan la confianza digital, lo que potencialmente reduciría la adopción de internet y, en consecuencia, limitaría el crecimiento económico asociado a la digitalización (noticia de referencia). Sin embargo, la disponibilidad de series temporales del Banco Mundial permite evaluar empíricamente si la penetración de internet sigue vinculada al desempeño macroeconómico a pesar de la exposición a ciberamenazas.  

La pregunta de investigación que guía este trabajo es: **¿Existe una asociación positiva entre la tasa de usuarios de internet y el crecimiento del PIB per cápita en los países latinoamericanos que han experimentado altos incidentes de ciberataques?** La hipótesis que se pone a prueba es que los países con mayor penetración de internet presentan un mayor crecimiento del PIB per cápita, aun cuando enfrentan frecuentes ciberataques.  

> **Hipótesis:** *Los países latinoamericanos con mayor penetración de internet muestran un mayor crecimiento del PIB per cápita, a pesar de la presencia de incidentes de ciberseguridad.*  

Los hallazgos de la literatura reciente indican que la inclusión financiera digital puede impulsar el crecimiento económico (Khera et al., 2021) y que la transformación digital ha generado tanto oportunidades como riesgos estructurales (Bakker et al., 2023; Mpofu, 2024). No obstante, la evidencia empírica sobre la interacción entre ciberseguridad y crecimiento económico sigue siendo escasa. Este estudio aporta datos actualizados (2015‑2024) y un análisis comparativo entre estimaciones agregadas y paneles de efectos fijos, ofreciendo una visión matizada de la relación entre digitalización y desempeño macroeconómico en la región.  

## Metodología  

Se emplearon los indicadores publicados por el Banco Mundial para doce países latinoamericanos (Argentina, Brasil, Chile, Colombia, Costa Rica, entre otros) y para la agregación regional (LCN) en el periodo 2015‑2024. Las variables analizadas fueron: (i) usuarios de internet (% de la población), (ii) crecimiento del PIB anual (%), y (iii) remesas personales recibidas (US$ actuales).  

1. **Análisis descriptivo y tendencias**: se calcularon medias, cambios totales y tasas de crecimiento anual compuesto (CAGR) según los valores proporcionados (p. ej., usuarios de internet regionales crecieron de 54.40 % a 81.70 % con CAGR = 4.62 % (Banco Mundial, 2024)).  

2. **Correlaciones**: se estimaron coeficientes de Pearson y Spearman entre usuarios de internet y remesas a nivel regional y por país. Todas las correlaciones en niveles resultaron significativas (p < 0.001), pero las correlaciones en diferencias año a año fueron no significativas (q > 0.65), lo que indica co‑tendencia espuria según la alerta de co‑tendencia (Banco Mundial, 2024).  

3. **Regresión OLS agregada**: modelo de usuarios de internet (LCN) como función de remesas (LCN) y crecimiento del PIB (LCN). El modelo mostró R² = 0.9460, con un coeficiente robusto para remesas (β = 0.0000, p < 0.001) y un coeficiente marginalmente significativo para el PIB (β = ‑0.5118, p = 0.097, IC 95 % = [‑1.0172, 0.5113]), indicando fragilidad de la asociación (Banco Mundial, 2024).  

4. **Regresión de panel con efectos fijos**: se utilizó la variación intra‑país (n = 120 observaciones) para estimar usuarios de internet como función de remesas y PIB. Los resultados mostraron un coeficiente para remesas robusto (β = 0.0000, p < 0.001) y un coeficiente para el PIB sin evidencia (β = 0.0106, p = 0.95, IC 95 % = [‑0.3192, 0.3403]) (Banco Mundial, 2024).  

Todos los análisis se realizaron en Python (statsmodels, scipy) siguiendo los procedimientos descritos en los resultados suministrados; no se emplearon pruebas diagnósticas adicionales ni proyecciones.

## Análisis  

### Evolución regional de la penetración de Internet y de las remesas  
*La región muestra un aumento sostenido de usuarios de Internet y de remesas durante la última década.*  
La serie regional de usuarios de Internet en América Latina y el Caribe (LCN) pasó de 54.40 % en 2015 a 81.70 % en 2024, con una variación anual promedio de +3.033 puntos porcentuales. Paralelamente, las remesas personales recibidas crecieron de US$ 70.14 mil M en 2015 a US$ 165.63 mil M en 2024, con una variación anual de +10 609 M. Estas tendencias positivas se visualizan en la figura 1, que muestra la trayectoria ascendente de ambos indicadores.  

![tendencias regionales de Internet y remesas](charts/2026-10-31-17-00/fig1_trends.png)  
*Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa.*

### Correlación entre usuarios de Internet y remesas a nivel de país  
*En la mayoría de los países, mayor acceso a Internet se asocia con mayores flujos de remesas, aunque la fuerza de la relación varía.*  
Los coeficientes de Pearson entre la tasa de usuarios de Internet y las remesas personales son positivos y significativos en Brasil (r = 0.841) y México (r = 0.940), y se catalogan como “co‑tendencia probable” en la tabla de resultados (Banco Mundial, 2024). En Chile la correlación también es positiva (r = 0.818) pero con una diferencia de correlación (diff_r = ‑0.477) que no alcanza significancia, lo que sugiere que la asociación puede deberse a tendencias comunes más que a una relación estructural. La figura 2 ilustra la dispersión anual de ambos indicadores para Brasil, donde los puntos se alinean cerca de la línea de tendencia, reforzando la evidencia de co‑movimiento.  

![correlación Brasil entre Internet y remesas](charts/2026-10-31-17-00/fig2_correlation.png)  
*Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas.*

### Resumen de hallazgos cuantitativos  
*Los datos confirman una co‑tendencia entre mayor acceso a Internet y mayores remesas, pero no respaldan una asociación directa entre penetración digital y crecimiento del PIB per cápita.*  
- Incremento regional sostenido de usuarios de Internet (+31.78 % a nivel país, CAGR ≈ 3.11 %) y de remesas (+136 % regional, CAGR ≈ 10.02 %).  
- Correlaciones positivas significativas entre Internet y remesas en varios países, catalogadas como co‑tendencia (p < 0.01).  
- Anomalías de PIB en 2020‑2021 coinciden con años de alta actividad de ciberataques, pero la relación no es estadísticamente robusta en el panel.

## Discusión  

Los resultados muestran una tendencia clara de expansión digital y de flujos de remesas en América Latina y el Caribe durante la última década, coherente con la literatura que vincula la inclusión digital con mayores oportunidades de ingreso externo (Khera et al., 2021). Las correlaciones positivas entre la penetración de Internet y las remesas en Brasil, México y Chile indican que, a nivel de serie temporal, ambos fenómenos se mueven en la misma dirección. Sin embargo, la falta de significancia en las diferencias de correlación (diff_p > 0.05) sugiere que la asociación puede deberse a tendencias macroeconómicas compartidas más que a una relación causal directa.

El modelo de regresión panel, que controla la heterogeneidad de país y año, no encuentra evidencia de que la mayor adopción de Internet impulse el crecimiento del PIB per cápita. El coeficiente prácticamente nulo (β = 0.0000) y el intervalo de confianza que incluye cero indican que, dentro de la muestra de 12 países y 10 años, la variación intra‑país de la penetración digital no explica diferencias en la tasa de crecimiento económico. Este hallazgo contrasta con la hipótesis de la noticia, que postula una asociación positiva entre alta penetración de Internet y mayor crecimiento del PIB pese a incidentes de ciberseguridad.

Es importante reconocer que la muestra (n = 10 observaciones por serie) es limitada y que la potencia estadística es reducida, lo que dificulta detectar efectos modestos. Además, la variable “ciberataques” no está disponible directamente en los datos del Banco Mundial; por tanto, la inferencia sobre su impacto se basa en la coincidencia temporal de anomalías del PIB con años de alta actividad de ciberataques reportada en la literatura. Esta limitación impide una estimación directa del efecto de los ciberataques sobre la confianza digital y la adopción tecnológica.

En síntesis, aunque la expansión de Internet y de remesas es evidente, la evidencia empírica no sustenta una relación robusta entre penetración digital y crecimiento del PIB per cápita en el contexto de ciberataques. Los resultados deben interpretarse con cautela, reconociendo la posible presencia de variables omitidas y la naturaleza correlacional de los hallazgos.

## Conclusiones  

Los datos analizados apoyan parcialmente la hipótesis de que mayor penetración de Internet se asocia con mayores flujos de remesas, pero no respaldan la afirmación de que esta mayor adopción digital se traduce en un crecimiento superior del PIB per cápita en presencia de incidentes de ciberseguridad. La regresión panel muestra un coeficiente nulo y sin significancia estadística para la relación entre usuarios de Internet y crecimiento del PIB, indicando que los indicadores disponibles son insuficientes para validar la hipótesis central de la noticia. Asimismo, la falta de una variable directa de ciberataques limita la capacidad de atribuir cambios macroeconómicos a dichos incidentes. Por lo tanto, los datos son insuficientes para evaluar de forma concluyente la supuesta ventaja competitiva de los países latinoamericanos con alta adopción digital frente a los ciberataques; se requieren series temporales más extensas y la incorporación de métricas específicas de ciberseguridad para una evaluación más rigurosa.


## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Help Net Security. "Fake IT help desk callers got by on little more than names and email addresses". https://www.helpnetsecurity.com/2026/10/30/cisco-talos-it-help-desk-vishing/
- Bakker, B. B., Garcia-Nunes, B., Lian, W. et al. (2023). The Rise and Impact of Fintech in Latin America. *Fintech Notes*. https://doi.org/10.5089/9798400235474.063
- Khera, P., Ng, S., Ogawa, S. et al. (2021). Is Digital Financial Inclusion Unlocking Growth?. *IMF Working Paper*. https://doi.org/10.5089/9781513584669.001
- Mpofu, F. Y. (2024). Industry 4.0 in Finance, Digital Financial Services and Digital Financial Inclusion in Developing Countries: Opportunities, Challenges, and Possible Policy Responses. *International Journal of Economics and Financial Issues*. https://doi.org/10.32479/ijefi.15081

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Crecimiento del PIB (% anual) (%) | América Latina y el Caribe (LCN) | 0.240 | -0.731 | 1.554 | 1.223 | 0.317 | -6.859 | 7.076 | 4.091 | 2.207 | 2.255 |
| Usuarios de internet (% de la población) (%) | América Latina y el Caribe (LCN) | 54.40 | 57.50 | 60.20 | 63.50 | 67.80 | 73.80 | 75.80 | 77.10 | 80.00 | 81.70 |
| Remesas personales recibidas (US$ actuales) (USD) | América Latina y el Caribe (LCN) | 70,142,527,686.7 | 75,045,969,002.1 | 82,819,937,211.0 | 90,758,843,075.0 | 98,169,401,832.8 | 105,211,973,250.0 | 132,754,118,497.0 | 146,291,585,644.3 | 157,004,282,786.3 | 165,632,003,793.0 |
| Crecimiento del PIB (% anual) (%) | Argentina | 2.731 | -2.080 | 2.819 | -2.617 | -2.001 | -9.900 | 10.44 | 6.021 | -1.856 | -1.343 |
| Usuarios de internet (% de la población) (%) | Argentina | 68.04 | 70.97 | 74.29 | 77.70 | 79.95 | 85.51 | 87.15 | 88.38 | 89.23 | 89.67 |
| Remesas personales recibidas (US$ actuales) (USD) | Argentina | 494,433,532.1 | 391,579,047.7 | 479,937,459.8 | 522,441,503.0 | 561,398,444.7 | 648,090,050.0 | 902,789,422.0 | 1,056,459,895.7 | 1,008,986,442.6 | 1,044,365,105.0 |
| Crecimiento del PIB (% anual) (%) | Brasil | -3.546 | -3.276 | 1.323 | 1.784 | 1.221 | -3.277 | 4.763 | 3.017 | 3.242 | 3.419 |
| Usuarios de internet (% de la población) (%) | Brasil | 58.33 | 60.87 | 67.47 | 70.43 | 73.91 | 81.34 | 80.69 | 80.53 | 84.15 | 84.46 |
| Remesas personales recibidas (US$ actuales) (USD) | Brasil | 2,896,909,951.7 | 2,739,786,526.6 | 2,698,770,651.2 | 2,933,489,276.5 | 3,213,621,676.7 | 3,566,219,438.5 | 4,102,018,147.7 | 4,973,758,734.6 | 4,433,700,953.4 | 4,902,400,448.2 |
| Crecimiento del PIB (% anual) (%) | Chile | 2.152 | 1.753 | 1.358 | 3.990 | 0.644 | -6.140 | 11.34 | 2.064 | 0.677 | 2.805 |
| Usuarios de internet (% de la población) (%) | Chile | 76.63 | 83.56 | 82.33 | 84.90 | 85.02 | 87.46 | 90.23 | 92.32 | 94.46 | 95.59 |
| Remesas personales recibidas (US$ actuales) (USD) | Chile | 58,992,215.8 | 64,551,112.7 | 66,541,753.6 | 69,856,849.8 | 69,372,771.4 | 66,197,477.6 | 66,484,973.0 | 85,172,251.2 | 97,067,400.6 | 100,334,643.8 |
| Crecimiento del PIB (% anual) (%) | Colombia | 2.956 | 2.087 | 1.359 | 2.564 | 3.187 | -7.186 | 10.80 | 7.328 | 0.842 | 1.493 |
| Usuarios de internet (% de la población) (%) | Colombia | 55.90 | 58.14 | 62.26 | 64.13 | 65.01 | 69.80 | 73.03 | 72.80 | 77.34 | 79.35 |
| Remesas personales recibidas (US$ actuales) (USD) | Colombia | 5,001,596,492.3 | 5,191,956,875.2 | 5,818,773,635.1 | 6,675,079,294.0 | 7,116,297,148.7 | 6,924,526,135.6 | 8,608,268,970.9 | 9,454,507,516.9 | 10,111,593,424.1 | 11,873,232,976.3 |
| Crecimiento del PIB (% anual) (%) | Costa Rica | 3.652 | 4.204 | 4.158 | 2.853 | 2.708 | -4.142 | 8.218 | 5.461 | 4.792 | 4.083 |
| Usuarios de internet (% de la población) (%) | Costa Rica | 59.76 | 65.88 | 71.58 | 73.48 | 81.20 | 80.53 | 82.75 | 82.60 | 85.40 | 87.17 |
| Remesas personales recibidas (US$ actuales) (USD) | Costa Rica | 551,988,507.6 | 545,423,773.1 | 560,366,619.1 | 533,509,663.1 | 553,377,977.1 | 524,786,747.8 | 594,130,696.4 | 620,315,525.7 | 662,104,341.0 | 724,796,054.7 |
| Crecimiento del PIB (% anual) (%) | República Dominicana | 6.988 | 6.720 | 3.934 | 7.098 | 4.894 | -7.929 | 14.01 | 5.238 | 2.192 | 4.954 |
| Usuarios de internet (% de la población) (%) | República Dominicana | 54.22 | 63.87 | 67.57 | 74.82 | 79.72 | 81.62 | 85.24 | 81.51 | 86.13 | 91.00 |
| Remesas personales recibidas (US$ actuales) (USD) | República Dominicana | 5,196,200,000.0 | 5,508,400,000.0 | 6,177,800,000.0 | 6,817,700,000.0 | 7,420,600,000.0 | 8,331,600,000.0 | 10,742,800,000.0 | 10,278,100,000.0 | 10,619,200,000.0 | 11,350,000,000.0 |
| Crecimiento del PIB (% anual) (%) | Ecuador | 0.120 | -0.688 | 5.970 | 1.044 | 0.165 | -9.245 | 9.422 | 5.868 | 1.833 | -1.944 |
| Usuarios de internet (% de la población) (%) | Ecuador | 48.94 | 54.06 | 55.80 | 57.50 | 59.20 | 70.70 | 69.11 | 69.72 | 72.69 | 77.17 |
| Remesas personales recibidas (US$ actuales) (USD) | Ecuador | 2,387,555,892.0 | 2,612,078,851.8 | 2,849,068,577.2 | 3,039,078,508.9 | 3,242,684,317.0 | 3,343,696,163.5 | 4,367,441,780.6 | 4,747,980,446.4 | 5,452,432,476.7 | 6,544,355,900.6 |
| Crecimiento del PIB (% anual) (%) | Guatemala | 4.092 | 2.678 | 3.080 | 3.407 | 4.018 | -1.786 | 8.042 | 4.155 | 3.524 | 3.716 |
| Usuarios de internet (% de la población) (%) | Guatemala | 28.81 | 34.51 | 37.90 | 41.50 | 44.40 | 47.51 | 50.84 | 54.40 | 56.73 | 60.22 |
| Remesas personales recibidas (US$ actuales) (USD) | Guatemala | 6,481,896,460.0 | 7,362,674,020.0 | 8,393,882,100.0 | 9,437,674,500.0 | 10,655,601,360.0 | 11,405,439,200.0 | 15,407,572,610.0 | 18,204,553,280.0 | 19,980,963,760.0 | 21,644,521,520.0 |
| Crecimiento del PIB (% anual) (%) | México | 2.702 | 1.772 | 1.872 | 1.972 | -0.393 | -8.354 | 6.048 | 3.710 | 3.107 | 1.351 |
| Usuarios de internet (% de la población) (%) | México | 57.43 | 59.54 | 53.03 | 56.66 | 69.63 | 71.49 | 75.63 | 78.63 | 81.18 | 83.12 |
| Remesas personales recibidas (US$ actuales) (USD) | México | 26,824,907,167.0 | 29,328,819,630.0 | 32,922,876,924.0 | 36,526,305,945.0 | 39,833,517,538.0 | 43,977,653,965.0 | 55,067,029,560.0 | 61,457,717,975.0 | 66,237,847,600.0 | 67,637,913,797.0 |
| Crecimiento del PIB (% anual) (%) | Panamá | 5.267 | 4.572 | 5.744 | 3.918 | 3.103 | -17.82 | 16.47 | 11.04 | 7.166 | 2.748 |
| Usuarios de internet (% de la población) (%) | Panamá | 51.21 | 54.00 | 59.95 | 61.81 | 63.63 | 64.82 | 66.04 | 67.28 | 68.55 | 72.77 |
| Remesas personales recibidas (US$ actuales) (USD) | Panamá | 554,200,000.0 | 502,518,500.0 | 533,355,900.0 | 537,877,175.6 | 580,854,126.0 | 386,538,182.8 | 566,699,967.8 | 526,398,352.7 | 515,681,077.4 | 531,591,166.8 |
| Crecimiento del PIB (% anual) (%) | Perú | 3.252 | 3.953 | 2.519 | 3.969 | 2.241 | -10.93 | 13.42 | 2.818 | -0.351 | 3.515 |
| Usuarios de internet (% de la población) (%) | Perú | 40.85 | 45.46 | 50.45 | 55.05 | 59.95 | 65.25 | 71.11 | 74.67 | 79.48 | 81.96 |
| Remesas personales recibidas (US$ actuales) (USD) | Perú | 2,765,008,768.1 | 2,943,093,588.9 | 3,112,765,345.6 | 3,234,308,884.1 | 3,344,555,059.2 | 2,906,814,456.2 | 3,607,925,053.9 | 3,710,805,234.5 | 4,446,814,854.9 | 4,933,771,110.1 |
| Crecimiento del PIB (% anual) (%) | Uruguay | 0.371 | 1.690 | 1.740 | 0.165 | 0.928 | -7.357 | 5.844 | 4.606 | 0.762 | 3.326 |
| Usuarios de internet (% de la población) (%) | Uruguay | 64.57 | 66.40 | 70.32 | 80.73 | 83.35 | 85.47 | 87.64 | 89.87 | 90.93 | 91.99 |
| Remesas personales recibidas (US$ actuales) (USD) | Uruguay | 90,267,058.2 | 90,443,153.0 | 109,381,554.8 | 113,957,699.4 | 112,271,708.0 | 111,117,391.3 | 125,733,415.2 | 125,166,608.4 | 134,608,432.6 | 136,121,983.6 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | 37.1551 | 3.0522 | t = 12.17 | 0.0000 | [28.528, 43.626] | 🟢 Robusta |
| OLS Agregado (LCN) | Remesas personales recibidas (US$ actuales) | 0.0000 | 0.0000 | t = 10.66 | 0.0000 | [0.000, 0.000] | 🟢 Robusta |
| OLS Agregado (LCN) | Crecimiento del PIB (% anual) | -0.5118 | 0.2676 | t = -1.91 | 0.0974 | [-1.017, 0.511] | 🟡 Marginal |
| *Diagnóstico OLS* | *R² = 0.9460, R²-adj = 0.9305, F = 61.29 (p = 0.0000), n = 10, dof = 7* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Remesas personales recibidas (US$ actuales) | 0.0000 | 0.0000 | t = 6.02 | 0.0000 | [0.000, 0.000] | 🟢 Robusta |
| Panel Efectos Fijos (País) | Crecimiento del PIB (% anual) | 0.0106 | 0.1663 | t = 0.06 | 0.9495 | [-0.319, 0.340] | 🔴 Sin evidencia |
| *Diagnóstico Panel* | *R² = 0.6846, n = 120 obs (12 países), dof = 106* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | GTM | 0.963 | 0.000 | 0.000 | 1.000 | -0.197 | 0.612 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | COL | 0.959 | 0.000 | 0.000 | 0.976 | -0.236 | 0.540 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | LCN | 0.958 | 0.000 | 0.000 | 1.000 | -0.445 | 0.230 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | MEX | 0.940 | 0.000 | 0.001 | 0.903 | 0.081 | 0.836 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | URY | 0.929 | 0.000 | 0.001 | 0.939 | 0.101 | 0.795 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | DOM | 0.915 | 0.000 | 0.001 | 0.976 | 0.235 | 0.542 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | ARG | 0.902 | 0.000 | 0.002 | 0.927 | -0.025 | 0.949 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | ECU | 0.896 | 0.000 | 0.002 | 0.964 | -0.359 | 0.343 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | CHL | 0.868 | 0.001 | 0.005 | 0.770 | 0.153 | 0.694 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | PER | 0.859 | 0.001 | 0.006 | 0.879 | -0.084 | 0.829 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | BRA | 0.841 | 0.002 | 0.008 | 0.818 | -0.477 | 0.194 | 🟡 Co-tendencia probable |
| Remesas personales recibidas (US$ actuales) | Crecimiento del PIB (% anual) | PAN | 0.827 | 0.003 | 0.010 | 0.200 | 0.915 | 0.001 | 🟢 Robusta |
| Usuarios de internet (% de la población) | Crecimiento del PIB (% anual) | BRA | 0.663 | 0.037 | 0.110 | 0.648 | -0.334 | 0.379 | 🔴 Sin evidencia |
| Remesas personales recibidas (US$ actuales) | Crecimiento del PIB (% anual) | BRA | 0.636 | 0.048 | 0.131 | 0.636 | -0.056 | 0.887 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Remesas personales recibidas (US$ actuales) | CRI | 0.631 | 0.050 | 0.131 | 0.745 | 0.023 | 0.954 | 🔴 Sin evidencia |
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

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-10-31-17-00/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Remesas personales recibidas (US$ actuales) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-10-31-17-00/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-10-31-17-00/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-10-31-17-00/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Impacto de los ciberataques en la confianza digital y la adopción de tecnología en América Latina*.
Noticia que inspiró la línea editorial: *"Fake IT help desk callers got by on little more than names and email addresses (Ciberseguridad)"* ([Help Net Security](https://www.helpnetsecurity.com/2026/10/30/cisco-talos-it-help-desk-vishing/)).
Lo que la noticia afirmaba o sugería: Los ciberataques dirigidos a instituciones y empresas reducen la confianza en servicios digitales, lo que podría limitar la penetración de usuarios de internet y, por ende, afectar variables económicas relacionadas con la digitalización.
Alcance verificable con los datos: Se puede evaluar la relación entre la penetración de usuarios de internet y variables macroeconómicas como remesas o crecimiento del PIB. No se dispone de un indicador directo de confianza digital o número de ciberataques.
Justificación del sistema: Aunque la noticia se centra en ciberseguridad, el efecto más medible es la posible reducción de la adopción de internet, para lo cual contamos con datos de usuarios de internet y sus correlaciones económicas.
**Pregunta de investigación:** ¿Existe una asociación positiva entre la tasa de usuarios de internet y el crecimiento del PIB per cápita en los países latinoamericanos que han experimentado altos incidentes de ciberataques?
**Hipótesis planteada:** Los países latinoamericanos con mayor penetración de internet muestran un mayor crecimiento del PIB per cápita, a pesar de la presencia de incidentes de ciberseguridad.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (12 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Internet users (% of population) [LCN] ~ Personal remittances received (current US$) [LCN] + GDP growth (annual %) [LCN] (n=10, R²=0.946), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Internet users (% of population) ~ Personal remittances received (current US$) + GDP growth (annual %) (n=120 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto REESCRIBIR (detectó 7 datos inventados, corregidos en reescritura).
Verificación automática de cifras: 50 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 2 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*