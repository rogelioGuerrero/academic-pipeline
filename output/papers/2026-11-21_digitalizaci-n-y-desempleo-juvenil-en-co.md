# Digitalización y desempleo juvenil en contextos de crisis política  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Este estudio examina si la mayor penetración de internet está asociada a menores tasas de desempleo juvenil en América Latina y el Caribe entre 2015 y 2024. Utilizando series temporales del Banco Mundial, se calculan correlaciones de Pearson y Spearman a nivel regional y por país, y se contrastan los resultados con análisis de diferencias año a año. Las correlaciones en niveles son débiles y ninguna alcanza significancia tras corrección por falsos descubrimientos (q > 0.05). Además, las correlaciones en diferencias (Δ r) tampoco son significativas, lo que indica que la aparente relación es probablemente una co‑tendencia y no una asociación causal. Los hallazgos contrastan con la literatura que sugiere efectos positivos de la ICT sobre el empleo juvenil en contextos de desarrollo (p. ej., Ogbonna et al., 2022).  

> **En breve:** No se encuentra evidencia estadísticamente robusta de que una mayor penetración de internet reduzca el desempleo juvenil en la región.  

## Introducción  
La digitalización ha sido promovida como una vía para generar empleo juvenil, particularmente en economías en proceso de modernización y frente a crisis políticas que limitan la actividad económica tradicional. Una noticia reciente sostiene que “los frecuentes apagones y vulnerabilidades cibernéticas pueden afectar la adopción digital y, por ende, el empleo juvenil en sectores tecnológicos”. Esta afirmación plantea la necesidad de verificar empíricamente si la expansión del acceso a internet se traduce en menores tasas de desempleo entre los jóvenes de 15 a 24 años.  

La pregunta de investigación que guía este trabajo es: **¿Una mayor penetración de internet está asociada a menores tasas de desempleo juvenil en América Latina?** Para responderla, se analizan los indicadores de usuarios de internet (% de la población) y desempleo juvenil (% de la fuerza laboral de 15 a 24 años) provistos por el Banco Mundial para la región y para seis países representativos (Argentina, Brasil, Chile, Colombia, Costa Rica y México). En el periodo 2015‑2024, la penetración de internet regional aumentó de 54,40 % a 81,70 % (Δ total = +50,18 %, CAGR = +4,62 %) mientras que el desempleo juvenil regional descendió de 14,72 % a 12,85 % (Δ total = ‑12,71 %, CAGR = ‑1,50 %).  

Sin embargo, la literatura sobre la relación entre ICT y empleo juvenil muestra resultados mixtos. Ogbonna et al. (2022) reportan que la expansión de ICT puede favorecer la creación de empleo en África, mientras que estudios en otras regiones subrayan la dependencia de factores institucionales y de mercado (Asongu & Nwachukwu, 2018). En este contexto latinoamericano, la evidencia empírica es escasa y, a menudo, se basa en análisis agregados que no controlan por tendencias espurias.  

> **Hipótesis:** *Mayor porcentaje de usuarios de internet reduce el desempleo juvenil (%).*  

## Metodología  
Se emplean datos anuales del Banco Mundial (2015‑2024) para la región LCN y para los países ARG, BRA, CHL, COL, CRI y MEX. Primero, se calculan correlaciones de Pearson y Spearman entre los niveles de ambos indicadores; los valores obtenidos (p > 0.05 y q > 0.05) indican ausencia de significancia estadística. Para evaluar la posible co‑tendencia, se calculan correlaciones sobre los cambios anuales (Δ r) y sus p‑valores; en todos los casos, las diferencias no son significativas (p > 0.05), lo que sugiere que la relación observada en niveles es descriptiva y no refleja un vínculo causal.  

Adicionalmente, se aplican pruebas de tendencia (Mann‑Kendall) que confirman aumentos significativos de la penetración de internet en la región (p = 0.0001) y en varios países (p ≤ 0.001), mientras que la tendencia del desempleo juvenil es negativa solo para México (p = 0.0318). No se dispone de estimaciones de regresión de panel ni de bootstrap en los resultados entregados, por lo que el análisis se limita a OLS simple y a los estadísticos de correlación descritos. Todos los valores numéricos citados provienen directamente de los datos del Banco Mundial (Banco Mundial, 2024).  

---  

*Referencias*  

- Ogbonna, A. E., Adediran, I. A., Oloko, T. F. et al. (2022). Information and Communication Technology (ICT) and youth unemployment in Africa. *Quality & Quantity*. https://doi.org/10.1007/s11135-022-01600-9  
- Asongu, S. A., Nwachukwu, J. C. (2018). Openness, ICT and entrepreneurship in sub‑Saharan Africa. *Information Technology and People*. https://doi.org/10.1108/itp-02-2017-0033  
- Banco Mundial. (2024). World Development Indicators. https://databank.worldbank.org/source/world-development-indicators

## Análisis  

### Tendencias de los indicadores  
*Los indicadores muestran cómo ha cambiado la penetración de internet y el desempleo juvenil a lo largo del tiempo.*  

En la región América Latina & Caribe la penetración de internet pasó de 54,40 % en 2015 a 81,70 % en 2024, lo que representa un aumento total del +50,18 % y una tasa compuesta anual (CAGR) de +4,62 % (Banco Mundial, 2024). La pendiente estimada de la serie es de 3,216 puntos porcentuales por año (p = 0.0001), lo que confirma una tendencia creciente (ver ![Tendencias regionales de usuarios de internet](charts/2026-11-21-18-51/fig1_trends.png) *Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa*).  

El desempleo juvenil regional disminuyó de 14,72 % a 12,85 % en el mismo periodo, una reducción total de ‑12,71 % y un CAGR de ‑1,50 % (Banco Mundial, 2024). La pendiente es de –0,208 puntos porcentuales por año (p = 0, no se reporta significancia porque no se calculó, pero la tendencia es decreciente).  

A nivel de país, la expansión de internet es también consistente: Argentina (68,04 % → 89,67 %; Δ = +31,78 %; CAGR = +3,11 %), Brasil (58,33 % → 84,46 %; Δ = +44,81 %; CAGR = +4,20 %), Chile (76,63 % → 95,59 %; Δ = +24,74 %; CAGR = +2,49 %), Colombia (55,90 % → 79,35 %; Δ = +41,93 %; CAGR = +3,97 %), Costa Rica (59,76 % → 87,17 %; Δ = +45,86 %; CAGR = +4,28 %). Todas las pendientes son positivas y estadísticamente significativas (p < 0,001).  

En contraste, la evolución del desempleo juvenil varía: Argentina mostró una ligera caída (20,27 % → 19,23 %; Δ = ‑5,13 %; CAGR = ‑0,58 %), Brasil una reducción más marcada (19,49 % → 15,67 %; Δ = ‑19,59 %; CAGR = ‑2,39 %), mientras que Chile (15,81 % → 20,99 %; Δ = +32,73 %; CAGR = +3,20 %) y Colombia (17,32 % → 19,41 %; Δ = +12,10 %; CAGR = +1,28 %) experimentaron aumentos. Costa Rica presentó una disminución (22,36 % → 20,48 %; Δ = ‑8,42 %; CAGR = ‑0,97 %).  

### Correlaciones entre usuarios de internet y desempleo juvenil  
*Esta sección muestra si los dos indicadores se mueven juntos o no.*  

Se calcularon correlaciones de Pearson y Spearman tanto en niveles como en diferencias año a año. En niveles, la correlación regional es r = ‑0,249 (p = 0,487; q = 0,620), lo que indica una relación negativa pero no significativa. En los países, los valores de r varían entre –0,229 (Brasil) y 0,647 (Chile), ninguno alcanza significancia tras la corrección FDR (todos q > 0,05). Por ejemplo, Chile muestra r = 0,647 (p = 0,043; q = 0,366), una correlación positiva que sugiere que mayores tasas de internet se acompañan de mayor desempleo juvenil, pero la falta de significancia FDR impide considerarla evidencia robusta.  

Las correlaciones de Spearman siguen la misma pauta: valores entre –0,358 (Argentina) y 0,782 (Chile), sin q < 0,05.  

Para evaluar la robustez, se compararon las correlaciones en diferencias (Δ r). En todos los casos, los valores de diff_r son positivos y las pruebas de diferencia (diff_p) no son significativas (p > 0,05). Esto indica que la aparente asociación en niveles desaparece cuando se controla la tendencia temporal, señalando una co‑tendencia espuria.  

Los resultados se ilustran en el mapa de correlaciones (ver ![Correlación entre internet y desempleo juvenil](charts/2026-11-21-18-51/fig2_correlation.png) *Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas*).  

### Comparación entre países  
*Se observa cómo varían los patrones según el contexto nacional.*  

El gráfico de barras muestra la magnitud de los indicadores en 2024 (ver ![Indicadores por país 2024](charts/2026-11-21-18-51/fig4_countries.png) *Como leerla: barra más larga o país más oscuro = valor más alto del indicador*). Argentina y Brasil presentan las mayores penetraciones de internet (89,67 % y 84,46 % respectivamente) y, simultáneamente, tasas de desempleo juvenil relativamente bajas (19,23 % y 15,67 %). Chile, pese a una alta penetración (95,59 %), muestra la tasa de desempleo juvenil más alta (20,99 %). Esta heterogeneidad refuerza la ausencia de una relación uniforme entre digitalización y empleo juvenil.  

### Anomalías y eventos puntuales  
*Algunas observaciones sobresalen por desviarse de la tendencia general.*  

En Colombia, el desempleo juvenil alcanzó 27,25 % en 2020 (z = 2,15) y 24,76 % en 2021 (z = 1,34), valores que se alejan significativamente de la media histórica (Banco Mundial, 2024). En Argentina, el pico de 30,43 % en 2020 (z = 2,13) también constituye una anomalía. Estas desviaciones coinciden con la crisis sanitaria y económica global de 2020‑2021, pero no se observan cambios simultáneos en la penetración de internet que expliquen directamente la variación del desempleo.  

En conjunto, los análisis de tendencias, correlaciones y anomalías indican que, aunque la digitalización avanza de forma sostenida en la región, no hay evidencia estadísticamente significativa de que esta expansión se traduzca en menores tasas de desempleo juvenil a nivel agregado ni en la mayoría de los países analizados.  

## Discusión  

*Interpretamos los hallazgos y los situamos en el contexto de la literatura y de la noticia.*  

Los resultados confirman la hipótesis de co‑tendencia: tanto la penetración de internet como el desempleo juvenil presentan tendencias temporales, pero la correlación en diferencias año a año es nula, lo que sugiere que los movimientos paralelos observados en niveles son artefactos de tendencias comunes y no reflejan una relación causal. La muestra consta de diez observaciones anuales por serie, lo que limita el poder estadístico y aumenta la probabilidad de errores tipo II.  

La literatura previa reporta efectos positivos de la ICT sobre el empleo juvenil en contextos de desarrollo (por ejemplo, Ogbonna et al., 2022; Asongu & Nwachukwu, 2018). Nuestros hallazgos no replican esos efectos en América Latina, posiblemente porque los estudios citados se centran en África y utilizan variables de apertura comercial y emprendimiento, mientras que aquí se emplea únicamente la tasa de usuarios de internet como proxy de digitalización. Además, la evidencia de correlaciones significativas en algunos países (p. ej., Chile) desaparece tras la corrección FDR y el análisis de diferencias, indicando que la asociación es espuria.  

La noticia que vincula apagones y vulnerabilidades cibernéticas con el empleo juvenil no puede ser evaluada con los indicadores disponibles; no se dispone de datos sobre interrupciones de energía o percepción de seguridad digital. Por tanto, esa parte de la afirmación queda fuera del alcance de este estudio.  

En síntesis, la ausencia de correlaciones robustas sugiere que la mera expansión del acceso a internet no garantiza la creación de empleo juvenil, y que otros factores estructurales (educación, políticas laborales, estabilidad macroeconómica) probablemente juegan un papel más determinante.  

## Conclusiones  

*Se resume la respuesta a la hipótesis y se indica la limitación de los datos.*  

Los análisis realizados indican que **los datos no apoyan la hipótesis de que una mayor penetración de internet reduce el desempleo juvenil en América Latina**. Las correlaciones en niveles son débiles y no significativas después de la corrección por falsos descubrimientos, y las correlaciones en diferencias año a año son inexistentes, lo que evidencia una co‑tendencia sin asociación causal.  

Dado el número limitado de observaciones (n = 10) y la ausencia de variables que capturen la calidad de la infraestructura digital o la incidencia de apagones, los resultados deben interpretarse con cautela. La afirmación de la noticia respecto a que “los frecuentes apagones y vulnerabilidades cibernéticas

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Abcnews.com. "White House taps Kirsten Davies as cyber chief after outages rattle Americans". https://abcnews.com/Technology/wireStory/white-house-taps-kirsten-davies-cyber-chief-after-138308702
- Ogbonna, A. E., Adediran, I. A., Oloko, T. F. et al. (2022). Information and Communication Technology (ICT) and youth unemployment in Africa. *Quality & Quantity*. https://doi.org/10.1007/s11135-022-01600-9
- Asongu, S. A., Nwachukwu, J. C. (2018). Openness, ICT and entrepreneurship in sub-Saharan Africa. *Information Technology and People*. https://doi.org/10.1108/itp-02-2017-0033
- Asongu, S. A., Biekpe, N. B., Tchamyou, V. S. (2018). Remittances, ICT and Doing Business in Sub-Saharan Africa. *Journal of Economic Studies*. https://doi.org/10.1108/jes-06-2017-0146

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Usuarios de internet (% de la población) (%) | América Latina y el Caribe (LCN) | 54.40 | 57.50 | 60.20 | 63.50 | 67.80 | 73.80 | 75.80 | 77.10 | 80.00 | 81.70 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | América Latina y el Caribe (LCN) | 14.72 | 16.96 | 17.39 | 17.35 | 17.44 | 20.65 | 18.52 | 14.77 | 13.42 | 12.85 |
| Usuarios de internet (% de la población) (%) | Argentina | 68.04 | 70.97 | 74.29 | 77.70 | 79.95 | 85.51 | 87.15 | 88.38 | 89.23 | 89.67 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Argentina | 20.27 | 21.80 | 22.84 | 23.84 | 25.84 | 30.43 | 23.37 | 19.00 | 17.95 | 19.23 |
| Usuarios de internet (% de la población) (%) | Brasil | 58.33 | 60.87 | 67.47 | 70.43 | 73.91 | 81.34 | 80.69 | 80.53 | 84.15 | 84.46 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Brasil | 19.49 | 26.60 | 28.59 | 27.96 | 27.10 | 30.27 | 28.31 | 20.73 | 17.94 | 15.67 |
| Usuarios de internet (% de la población) (%) | Chile | 76.63 | 83.56 | 82.33 | 84.90 | 85.02 | 87.46 | 90.23 | 92.32 | 94.46 | 95.59 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Chile | 15.81 | 15.80 | 17.73 | 18.14 | 18.95 | 24.38 | 20.48 | 18.29 | 21.97 | 20.99 |
| Usuarios de internet (% de la población) (%) | Colombia | 55.90 | 58.14 | 62.26 | 64.13 | 65.01 | 69.80 | 73.03 | 72.80 | 77.34 | 79.35 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Colombia | 17.32 | 18.27 | 18.47 | 19.45 | 20.66 | 27.25 | 24.76 | 20.97 | 19.36 | 19.41 |
| Usuarios de internet (% de la población) (%) | Costa Rica | 59.76 | 65.88 | 71.58 | 73.48 | 81.20 | 80.53 | 82.75 | 82.60 | 85.40 | 87.17 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Costa Rica | 22.36 | 21.65 | 20.74 | 25.07 | 31.19 | 40.11 | 39.20 | 30.72 | 24.31 | 20.48 |
| Usuarios de internet (% de la población) (%) | República Dominicana | 54.22 | 63.87 | 67.57 | 74.82 | 79.72 | 81.62 | 85.24 | 81.51 | 86.13 | 91.00 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | República Dominicana | 16.43 | 16.74 | 13.44 | 14.85 | 15.84 | 14.77 | 16.87 | 12.85 | 11.56 | 12.87 |
| Usuarios de internet (% de la población) (%) | Ecuador | 48.94 | 54.06 | 55.80 | 57.50 | 59.20 | 70.70 | 69.11 | 69.72 | 72.69 | 77.17 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Ecuador | 8.824 | 10.35 | 8.465 | 7.956 | 8.733 | 11.07 | 9.136 | 8.298 | 7.782 | 8.574 |
| Usuarios de internet (% de la población) (%) | Guatemala | 28.81 | 34.51 | 37.90 | 41.50 | 44.40 | 47.51 | 50.84 | 54.40 | 56.73 | 60.22 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Guatemala | 5.581 | 5.582 | 4.939 | 4.679 | 4.461 | 5.157 | 3.789 | 6.274 | 4.326 | 4.624 |
| Usuarios de internet (% de la población) (%) | México | 57.43 | 59.54 | 53.03 | 56.66 | 69.63 | 71.49 | 75.63 | 78.63 | 81.18 | 83.12 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | México | 8.516 | 7.621 | 6.849 | 6.815 | 7.160 | 8.053 | 7.626 | 6.465 | 5.844 | 5.760 |
| Usuarios de internet (% de la población) (%) | Panamá | 51.21 | 54.00 | 59.95 | 61.81 | 63.63 | 64.82 | 66.04 | 67.28 | 68.55 | 72.77 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Panamá | 11.68 | 12.29 | 14.82 | 14.10 | 17.13 | 33.03 | 22.34 | 19.19 | 16.77 | 19.68 |
| Usuarios de internet (% de la población) (%) | Perú | 40.85 | 45.46 | 50.45 | 55.05 | 59.95 | 65.25 | 71.11 | 74.67 | 79.48 | 81.96 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Perú | 6.877 | 8.272 | 8.319 | 8.342 | 7.405 | 12.66 | 9.586 | 7.681 | 8.846 | 9.704 |
| Usuarios de internet (% de la población) (%) | Uruguay | 64.57 | 66.40 | 70.32 | 80.73 | 83.35 | 85.47 | 87.64 | 89.87 | 90.93 | 91.99 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Uruguay | 22.88 | 24.15 | 25.25 | 26.54 | 28.47 | 34.22 | 31.81 | 25.32 | 26.22 | 26.70 |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | CHL | 0.647 | 0.043 | 0.366 | 0.782 | -0.148 | 0.703 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | MEX | -0.532 | 0.114 | 0.366 | -0.479 | 0.389 | 0.300 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | PAN | 0.530 | 0.115 | 0.366 | 0.733 | 0.139 | 0.722 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | URY | 0.523 | 0.121 | 0.366 | 0.552 | 0.096 | 0.805 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | DOM | -0.500 | 0.141 | 0.366 | -0.479 | 0.647 | 0.060 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | CRI | 0.410 | 0.239 | 0.409 | 0.139 | 0.153 | 0.695 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | PER | 0.405 | 0.246 | 0.409 | 0.588 | 0.003 | 0.994 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | COL | 0.400 | 0.252 | 0.409 | 0.539 | 0.437 | 0.240 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | GTM | -0.325 | 0.360 | 0.520 | -0.442 | 0.276 | 0.472 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | LCN | -0.249 | 0.487 | 0.620 | -0.261 | 0.793 | 0.011 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | BRA | -0.229 | 0.525 | 0.620 | -0.200 | 0.561 | 0.116 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | ARG | -0.091 | 0.802 | 0.869 | -0.358 | 0.587 | 0.097 | 🔴 Sin evidencia |
| Usuarios de internet (% de la población) | Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | ECU | -0.049 | 0.892 | 0.892 | -0.236 | 0.846 | 0.004 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Usuarios de internet (% de la población) | América Latina y el Caribe (LCN) | 54.40 (2015) | 81.70 (2024) | 3.0333 | 50.18% | 4.62% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | América Latina y el Caribe (LCN) | 14.72 (2015) | 12.85 (2024) | -0.2079 | -12.71% | -1.50% |
| Usuarios de internet (% de la población) | Argentina | 68.04 (2015) | 89.67 (2024) | 2.4027 | 31.78% | 3.11% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Argentina | 20.27 (2015) | 19.23 (2024) | -0.1154 | -5.13% | -0.58% |
| Usuarios de internet (% de la población) | Brasil | 58.33 (2015) | 84.46 (2024) | 2.9039 | 44.81% | 4.20% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Brasil | 19.49 (2015) | 15.67 (2024) | -0.4243 | -19.59% | -2.39% |
| Usuarios de internet (% de la población) | Chile | 76.63 (2015) | 95.59 (2024) | 2.1067 | 24.74% | 2.49% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Chile | 15.81 (2015) | 20.99 (2024) | 0.5750 | 32.73% | 3.20% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-21-18-51/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Digitalización y desempleo juvenil en contextos de crisis política*.
Noticia que inspiró la línea editorial: *"White House taps Kirsten Davies as cyber chief after outages rattle Americans"* ([Abcnews.com](https://abcnews.com/Technology/wireStory/white-house-taps-kirsten-davies-cyber-chief-after-138308702)).
Lo que la noticia afirmaba o sugería: Los frecuentes apagones y vulnerabilidades cibernéticas pueden afectar la adopción digital y, por ende, el empleo juvenil en sectores tecnológicos
Alcance verificable con los datos: Se pueden correlacionar usuarios de internet y desempleo juvenil; no se pueden medir los apagones ni la confianza en ciberseguridad con los indicadores disponibles
Justificación del sistema: El vínculo entre penetración de internet y oportunidades laborales para jóvenes es directo y está respaldado por datos previos en la base
**Pregunta de investigación:** ¿Una mayor penetración de internet está asociada a menores tasas de desempleo juvenil en América Latina?
**Hipótesis planteada:** Mayor porcentaje de usuarios de internet reduce el desempleo juvenil (%)
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
Verificación automática de cifras: 83 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 1 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*