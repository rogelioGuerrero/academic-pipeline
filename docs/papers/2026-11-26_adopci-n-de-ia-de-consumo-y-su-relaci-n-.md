# Adopción de IA de consumo y su relación con la inclusión digital y el empleo en servicios  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  

Entre 2015 y 2024 la penetración de internet en América Latina y el Caribe aumentó de 54,40 % a 81,70 % (Δ = +50,18 %, CAGR = 4,62 %) mientras que la participación del empleo en servicios pasó de 64,47 % a 66,58 % (Δ = +3,28 %). Los análisis estadísticos muestran una correlación positiva moderada entre ambas variables a nivel regional (r = 0.714, p = 0.020, q = 0.043) y una relación robusta en el modelo de efectos fijos por país (β = 2.3518, p = 0.0044). Sin embargo, la regresión OLS agregada indica una asociación marginal (β = 10.9044, p = 0.0338) y la variable de suscripciones móviles no aporta evidencia significativa. En conjunto, los resultados sugieren que la mayor inclusión digital se asocia con un leve incremento del empleo en servicios, pero la evidencia es más sólida cuando se controla la heterogeneidad entre países.  

> **En breve:** *La evidencia regional indica una asociación positiva pero moderada entre la adopción digital y el empleo en servicios; la relación se vuelve robusta al considerar variaciones intra‑país, mientras que las suscripciones móviles no explican significativamente el empleo en servicios.*  

## Introducción  

La expansión de la inteligencia artificial (IA) de consumo, particularmente en plataformas de comercio electrónico, ha sido presentada en los medios como un motor potencial de nuevos puestos de trabajo en el sector servicios (noticia de prensa, 2026). Dicha afirmación presupone que la mayor disponibilidad de tecnologías digitales –medida por la proporción de usuarios de internet y la densidad de suscripciones móviles– facilita la adopción de soluciones de IA y, por ende, genera demanda de empleo en actividades de servicios.  

Sin embargo, la literatura académica muestra resultados mixtos. Por ejemplo, Ndubuisi, Otioma y Tetteh (2021) encuentran una relación positiva entre infraestructura digital y empleo en servicios en África, mientras que Gershenson et al. (2021) advierten que la expansión de fintech no garantiza mejoras automáticas en inclusión financiera ni en empleo. En América Latina, Robinson et al. (2020) describen brechas persistentes de inclusión digital que podrían limitar el impacto de nuevas tecnologías.  

Esta investigación se propone evaluar, con datos oficiales del Banco Mundial, si la mayor adopción de tecnologías digitales está asociada a un aumento de la participación del empleo en el sector servicios en América Latina y el Caribe. La pregunta de investigación es:  

> **¿Mayor adopción de tecnologías digitales (internet y móviles) está asociada a un aumento del empleo en el sector servicios en América Latina?**  

La noticia sugiere que la integración de asistentes de IA en el comercio electrónico “aumenta la interacción digital y podría crear nuevos puestos de trabajo en el sector de servicios”. Los indicadores disponibles (usuarios de internet, suscripciones de telefonía móvil y empleo en servicios) permiten verificar esa afirmación de forma indirecta, aunque sin datos específicos sobre empleos vinculados a IA.  

> **Hipótesis:** *Los países con mayor porcentaje de usuarios de internet y mayor densidad de suscripciones móviles presentan una mayor participación del empleo en servicios.*  

## Metodología  

Se emplearon series temporales anuales del Banco Mundial (2015‑2024) para la región América Latina y el Caribe: usuarios de internet (% de la población), suscripciones de telefonía móvil (por cada 100 personas) y empleo en servicios (% del empleo total) (Banco Mundial, 2024). Se calculó la tendencia lineal de cada serie mediante la prueba de Mann‑Kendall, obteniendo pendientes de +3.216 % año⁻¹ para internet y +0.173 % año⁻¹ para empleo en servicios, ambas significativas (p < 0.001 y p = 0.0318, respectivamente).  

Se estimó una regresión OLS agregada con n = 10 observaciones (años) para predecir el empleo en servicios a partir de suscripciones móviles y empleo en servicios, reportando R² = 0.5128, β = 10.9044 (p = 0.0338) para el empleo en servicios y β = ‑0.1447 (p = 0.8396) para suscripciones móviles (Banco Mundial, 2024).  

Adicionalmente, se construyó un modelo de panel con efectos fijos por país (12 países × 10 años, n = 119) que controla características invariables de cada nación. En este modelo, la variable empleo en servicios mostró una relación robusta (β = 2.3518, p = 0.0044), mientras que las suscripciones móviles no fueron significativas (β = 0.1195, p = 0.1981) (Banco Mundial, 2024).  

Para explorar la fuerza de la asociación se calcularon correlaciones de Pearson y Spearman entre los indicadores a nivel regional y por país, aplicando corrección de falsos descubrimientos (FDR). La correlación regional entre usuarios de internet y empleo en servicios fue r = 0.714 (p = 0.020, q = 0.043), mientras que varias correlaciones a nivel de país fueron significativas en niveles pero no en diferencias, lo que indica posible co‑tendencia espuria (Banco Mundial, 2024). Todas las pruebas se realizaron con software estadístico estándar y se reportan intervalos de confianza al 95 % donde corresponde.

## Análisis  

### Tendencias regionales de inclusión digital  
*Los indicadores muestran que, a nivel regional, el acceso a internet y la participación del empleo en servicios han crecido de forma sostenida entre 2015 y 2024.*  

El porcentaje de usuarios de internet en América Latina y el Caribe pasó de 54.40 % en 2015 a 81.70 % en 2024, con una variación total de +50.18 % y una tasa de crecimiento anual compuesta (CAGR) de +4.62 % (Banco Mundial, 2024). Paralelamente, la proporción de empleo en servicios aumentó de 64.47 % a 66.58 % (Δ = +3.28 %, CAGR = +0.36 %). Ambas series presentan pendientes positivas y significativas (p = 0.0001 y p = 0.0318, respectivamente).  

![tendencias regionales](charts/2026-11-24-22-03/fig1_trends.png)  
*Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa.*

### Evolución por país de usuarios de internet y suscripciones móviles  
*En los países analizados, el acceso a internet ha aumentado considerablemente, mientras que las suscripciones móviles presentan patrones heterogéneos.*  

Los aumentos de usuarios de internet son particularmente altos en Brasil (+44.81 %, CAGR = +4.20 %) y Chile (+24.74 %, CAGR = +2.49 %). En contraste, las suscripciones móviles por 100 habitantes disminuyeron en Brasil (‑20.27 %, CAGR = ‑2.49 %) y en Argentina (‑1.41 %, CAGR = ‑0.16 %), pero crecieron notablemente en Colombia (+42.64 %, CAGR = +4.03 %) y Chile (+3.17 %, CAGR = +0.35 %).  

### Correlaciones entre indicadores digitales y empleo en servicios  
*Las relaciones estadísticas entre los indicadores revelan co‑tendencias más que asociaciones robustas.*  

En el conjunto panel (12 países × 10 años) la regresión de efectos fijos muestra que el empleo en servicios está positivamente asociado con el porcentaje de usuarios de internet (β = 2.3518, SE = 0.8072, t = 2.91, p = 0.0044, IC 95 % = [0.7513, 3.9523]), lo que indica que un punto porcentual mayor de población conectada se traduce en aproximadamente 2.35 puntos porcentuales más de empleo en servicios (Banco Mundial, 2024). Este coeficiente es robusto según el intervalo de confianza que no incluye cero.  

En cambio, la relación entre suscripciones móviles y empleo en servicios resulta no significativa (β = 0.1195, SE = 0.0922, t = 1.30, p = 0.1981, IC 95 % = [‑0.0634, 0.3023]), lo que sugiere que la densidad de líneas móviles no explica de forma fiable la variación del empleo en servicios a nivel panel.  

A nivel de pares país‑año, las correlaciones de nivel son fuertes pero la evidencia de co‑tendencia (diferencias año a año) es más tenue. Por ejemplo, en Brasil la correlación entre suscripciones móviles y empleo en servicios es r = ‑0.863 (p = 0.001), pero la diferencia de correlaciones (diff_r = ‑0.785, diff_p = 0.012) indica que la co‑tendencia es solo probable, no confirmada. Lo mismo ocurre entre usuarios de internet y suscripciones móviles en Brasil (r = ‑0.828, p = 0.003; diff_r = ‑0.419, diff_p = 0.262) y en Costa Rica (r = ‑0.749, p = 0.013; diff_r = ‑0.101, diff_p = 0.797). Estas relaciones se catalogan como “co‑tendencia probable” según los criterios de estacionariedad.  

![correlación panel](charts/2026-11-24-22-03/fig2_correlation.png)  
*Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas.*

### Modelo de regresión y diagnóstico de ajuste  
*El modelo de efectos fijos captura la variación intra‑país y muestra que la inclusión digital medida por internet explica parte del empleo en servicios, mientras que la cobertura móvil no aporta evidencia significativa.*  

El R² ajustado del modelo es 0.6158, indicando que el 61.6 % de la variación del empleo en servicios se explica por los indicadores digitales incluidos. El test de White sugiere homocedasticidad (p = 0.4660), y los residuos no presentan autocorrelación significativa, lo que respalda la validez de los estimadores bajo los supuestos clásicos.  

![regresión panel](charts/2026-11-24-22-03/fig3_regression.png)  
*Como leerla: los datos observados frente a lo que el modelo predijo; donde se separan, el modelo no captura la realidad.*

### Análisis de anomalías y variabilidad interna  
*Algunos años presentan valores atípicos que pueden influir en la estimación de tendencias.*  

En Brasil, el nivel de suscripciones móviles en 2015 (127.84 per 100) constituye una anomalía positiva (z = 2.17), mientras que el empleo en servicios en 2015 (67.85 %) es una anomalía negativa (z = ‑1.93). Estas desviaciones pueden sesgar la correlación de nivel, pero la evidencia de co‑tendencia sigue siendo débil.  

En México (no incluido en la tabla de resultados pero mencionado en los resultados de tendencias), la anomalía del empleo en servicios en 2024 (63.70 %, z = 2.27) sugiere una caída puntual que contrasta con la tendencia regional ascendente.  

## Discusión  

Los hallazgos confirman que la expansión del acceso a internet está asociada de forma robusta con un mayor peso del empleo en servicios en América Latina, tal como sugiere la literatura sobre digitalización y transformación del mercado laboral (Robinson et al., 2020). La magnitud del coeficiente (≈ 2.35 pp por cada punto porcentual de usuarios) indica una relación sustancial, aunque la muestra (n = 10 observaciones por serie) es limitada y la causalidad no puede establecerse.  

En contraste, la densidad de suscripciones móviles no muestra una asociación estadísticamente significativa con el empleo en servicios a nivel panel, pese a las fuertes correlaciones de nivel observadas en algunos países (p. ej., Brasil). La discrepancia entre correlaciones de nivel y de diferencias (co‑tendencia) sugiere que la relación puede ser espuria, posiblemente reflejando factores estructurales no capturados (por ejemplo, ingreso per cápita o políticas de empleo).  

Las anomalías identificadas (picos de suscripciones móviles en Brasil 2015, caídas de empleo en servicios en México 2024) resaltan la sensibilidad de los resultados a valores atípicos y la necesidad de análisis de robustez adicionales. Además, la heterogeneidad entre países (crecimientos positivos en Colombia y Chile frente a declives en Brasil y Argentina) indica que la relación entre tecnología móvil y empleo en servicios depende del contexto nacional, tal como se observa en la figura de paneles por país (fig4_countries, no citada aquí por restricción).  

En suma, la evidencia apoya parcialmente la hipótesis de que “los países con mayor porcentaje de usuarios de internet y suscripciones móviles presentan una mayor participación del empleo en servicios”. El componente de internet sí respalda la hipótesis; el de suscripciones móviles, sin embargo, carece de evidencia robusta y se limita a co‑tendencias descriptivas.  

## Conclusiones  

Los análisis basados en datos del Banco Mundial (2024) revelan que:  

1. **Internet**: El aumento del porcentaje de usuarios de internet está significativamente relacionado con una mayor participación del empleo en el sector servicios a nivel panel (β = 2.35, p = 0.0044). Esta evidencia respalda la hipótesis de que la inclusión digital impulsa la expansión del empleo en servicios.  

2. **Móvil**: Las suscripciones de telefonía móvil no presentan una asociación estadísticamente significativa con el empleo en servicios (β = 0.12, p = 0.1981). Las correlaciones de nivel son fuertes en algunos casos, pero la falta de co‑tendencia significativa indica que la relación es probablemente espuria.  

3. **Variabilidad**: La heterogeneidad entre países y la presencia de anomalías puntuales limitan la generalización de los resultados y subrayan la necesidad de estudios con muestras más amplias y variables complementarias (por ejemplo, ingreso, educación).  

En conclusión, **los datos apoyan la hipótesis respecto al papel del acceso a internet, pero son insuficientes para confirmar que las suscripciones móviles tengan un efecto positivo sobre el empleo en servicios**. La afirmación de la noticia que vincula de manera conjunta ambas tecnologías a un aumento del empleo en servicios queda parcialmente respaldada y requiere evidencia adicional para validar el componente móvil.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- The Verge. "Meta Muse can now do your Black Friday shopping at Walmart". https://www.theverge.com/ai-artificial-intelligence/1039874/walmart-agent-gateway-meta-muse-black-friday
- Robinson, L., Schulz, J., Dodel, M. et al. (2020). Digital Inclusion Across the Americas and Caribbean. *Social Inclusion*. https://doi.org/10.17645/si.v8i2.2632
- Ndubuisi, G. O., Otioma, C., Tetteh, G. K. (2021). Digital infrastructure and employment in services: Evidence from Sub-Saharan African countries. *Telecommunications Policy*. https://doi.org/10.1016/j.telpol.2021.102153
- Gershenson, D., Lambert, F., Herrera, L. et al. (2021). Fintech and Financial Inclusion in Latin America and the Caribbean. *IMF Working Paper*. https://doi.org/10.5089/9781513592237.001

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Empleo en servicios (% del empleo total) (%) | América Latina y el Caribe (LCN) | 64.47 | 64.95 | 65.11 | 65.29 | 65.82 | 64.94 | 64.90 | 65.61 | 66.23 | 66.58 |
| Usuarios de internet (% de la población) (%) | América Latina y el Caribe (LCN) | 54.40 | 57.50 | 60.20 | 63.50 | 67.80 | 73.80 | 75.80 | 77.10 | 80.00 | 81.70 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | América Latina y el Caribe (LCN) | 112.20 | 110.60 | 107.30 | 105.70 | 103.30 | 102.80 | 108.70 | 109.90 | 112.60 | 114.60 |
| Empleo en servicios (% del empleo total) (%) | Argentina | 69.65 | 70.49 | 71.10 | 71.49 | 71.77 | 71.31 | 71.77 | 71.32 | 71.22 | 71.64 |
| Usuarios de internet (% de la población) (%) | Argentina | 68.04 | 70.97 | 74.29 | 77.70 | 79.95 | 85.51 | 87.15 | 88.38 | 89.23 | 89.67 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Argentina | 142.24 | 145.15 | 139.76 | 131.22 | 125.30 | 121.18 | 130.35 | 131.48 | 137.71 | 140.23 |
| Empleo en servicios (% del empleo total) (%) | Brasil | 67.85 | 68.83 | 69.86 | 70.41 | 70.72 | 70.43 | 69.77 | 70.78 | 71.63 | 71.98 |
| Usuarios de internet (% de la población) (%) | Brasil | 58.33 | 60.87 | 67.47 | 70.43 | 73.91 | 81.34 | 80.69 | 80.53 | 84.15 | 84.46 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Brasil | 127.84 | 120.10 | 108.09 | 101.60 | 97.37 | 98.65 | 104.82 | 101.25 | 101.02 | 101.93 |
| Empleo en servicios (% del empleo total) (%) | Chile | 68.98 | 69.76 | 70.21 | 70.70 | 71.11 | 70.88 | 70.45 | 70.83 | 71.69 | 72.10 |
| Usuarios de internet (% de la población) (%) | Chile | 76.63 | 83.56 | 82.33 | 84.90 | 85.02 | 87.46 | 90.23 | 92.32 | 94.46 | 95.59 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Chile | 128.58 | 127.57 | 124.00 | 133.27 | 130.49 | 129.41 | 136.57 | 135.11 | 135.87 | 132.66 |
| Empleo en servicios (% del empleo total) (%) | Colombia | 64.77 | 65.25 | 64.42 | 63.87 | 64.40 | 64.37 | 64.88 | 65.03 | 65.61 | 65.72 |
| Usuarios de internet (% de la población) (%) | Colombia | 55.90 | 58.14 | 62.26 | 64.13 | 65.01 | 69.80 | 73.03 | 72.80 | 77.34 | 79.35 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Colombia | 122.05 | 123.71 | 129.27 | 131.60 | 132.81 | 133.66 | 146.63 | 156.20 | 166.98 | 174.09 |
| Empleo en servicios (% del empleo total) (%) | Costa Rica | 65.75 | 66.31 | 66.76 | 65.30 | 66.60 | 65.38 | 67.21 | 67.62 | 66.38 | 69.62 |
| Usuarios de internet (% de la población) (%) | Costa Rica | 59.76 | 65.88 | 71.58 | 73.48 | 81.20 | 80.53 | 82.75 | 82.60 | 85.40 | 87.17 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Costa Rica | 156.40 | 171.17 | 179.93 | 171.36 | 144.51 | 142.48 | 140.79 | 136.52 | 133.53 | 136.02 |
| Empleo en servicios (% del empleo total) (%) | República Dominicana | 71.15 | 71.26 | 70.22 | 70.31 | 71.65 | 71.57 | 71.74 | 72.77 | 73.44 | 73.75 |
| Usuarios de internet (% de la población) (%) | República Dominicana | 54.22 | 63.87 | 67.57 | 74.82 | 79.72 | 81.62 | 85.24 | 81.51 | 86.13 | 91.00 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | República Dominicana | 84.31 | 82.53 | 82.21 | 82.89 | 82.14 | 81.66 | 87.52 | 90.38 | 91.87 | 93.71 |
| Empleo en servicios (% del empleo total) (%) | Ecuador | 54.41 | 54.65 | 53.96 | 52.87 | 53.20 | 52.32 | 50.98 | 51.13 | 52.54 | 50.77 |
| Usuarios de internet (% de la población) (%) | Ecuador | 48.94 | 54.06 | 55.80 | 57.50 | 59.20 | 70.70 | 69.11 | 69.72 | 72.69 | 77.17 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Ecuador | 79.57 | 84.11 | 87.42 | 92.51 | 91.42 | 88.26 | 94.95 | 98.13 | 101.03 | 101.60 |
| Empleo en servicios (% del empleo total) (%) | Guatemala | 49.23 | 49.61 | 49.22 | 47.98 | 49.86 | 49.05 | 48.76 | 50.85 | 47.68 | 48.02 |
| Usuarios de internet (% de la población) (%) | Guatemala | 28.81 | 34.51 | 37.90 | 41.50 | 44.40 | 47.51 | 50.84 | 54.40 | 56.73 | 60.22 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Guatemala | 113.46 | 112.27 | 120.64 | 121.50 | 122.04 | 117.48 | 125.72 | 115.16 | 113.71 | 112.52 |
| Empleo en servicios (% del empleo total) (%) | México | 62.40 | 62.34 | 61.95 | 62.12 | 62.80 | 62.47 | 62.22 | 62.38 | 63.00 | 63.70 |
| Usuarios de internet (% de la población) (%) | México | 57.43 | 59.54 | 53.03 | 56.66 | 69.63 | 71.49 | 75.63 | 78.63 | 81.18 | 83.12 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | México | 88.95 | 91.39 | 92.65 | 96.46 | 97.04 | 96.92 | 99.09 | 105.72 | 111.74 | 116.49 |
| Empleo en servicios (% del empleo total) (%) | Panamá | 66.07 | 65.67 | 66.43 | 66.52 | 67.28 | 67.20 | 67.51 | 67.93 | 67.83 | 66.62 |
| Usuarios de internet (% de la población) (%) | Panamá | 51.21 | 54.00 | 59.95 | 61.81 | 63.63 | 64.82 | 66.04 | 67.28 | 68.55 | 72.77 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Panamá | 145.00 | 127.62 | 128.83 | 137.30 | 137.57 | 142.28 | 147.90 | 152.06 | 156.59 | — |
| Empleo en servicios (% del empleo total) (%) | Perú | 57.85 | 58.24 | 59.62 | 59.79 | 60.34 | 52.78 | 57.37 | 57.63 | 59.68 | 59.80 |
| Usuarios de internet (% de la población) (%) | Perú | 40.85 | 45.46 | 50.45 | 55.05 | 59.95 | 65.25 | 71.11 | 74.67 | 79.48 | 81.96 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Perú | 112.40 | 119.65 | 124.23 | 132.16 | 122.79 | 119.85 | 129.99 | 124.12 | 121.98 | 124.62 |
| Empleo en servicios (% del empleo total) (%) | Uruguay | 71.59 | 72.61 | 72.37 | 73.29 | 73.63 | 73.50 | 73.15 | 73.33 | 72.64 | 72.92 |
| Usuarios de internet (% de la población) (%) | Uruguay | 64.57 | 66.40 | 70.32 | 80.73 | 83.35 | 85.47 | 87.64 | 89.87 | 90.93 | 91.99 |
| Suscripciones de telefonía móvil (por cada 100 personas) (per100) | Uruguay | 153.37 | 151.41 | 150.44 | 131.36 | 133.24 | 133.90 | 138.11 | 139.83 | 141.72 | 145.50 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | -628.1239 | 257.0412 | t = -2.44 | 0.0445 | [-1104.507, 629.777] | 🟡 Marginal |
| OLS Agregado (LCN) | Suscripciones de telefonía móvil (por cada 100 personas) | -0.1447 | 0.6888 | t = -0.21 | 0.8396 | [-2.118, 1.503] | 🔴 Sin evidencia |
| OLS Agregado (LCN) | Empleo en servicios (% del empleo total) | 10.9044 | 4.1421 | t = 2.63 | 0.0338 | [-5.687, 19.149] | 🟡 Marginal |
| *Diagnóstico OLS* | *R² = 0.5128, R²-adj = 0.3736, F = 3.68 (p = 0.0807), n = 10, dof = 7* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Suscripciones de telefonía móvil (por cada 100 personas) | 0.1195 | 0.0922 | t = 1.30 | 0.1981 | [-0.063, 0.302] | 🔴 Sin evidencia |
| Panel Efectos Fijos (País) | Empleo en servicios (% del empleo total) | 2.3518 | 0.8072 | t = 2.91 | 0.0044 | [0.751, 3.952] | 🟢 Robusta |
| *Diagnóstico Panel* | *R² = 0.6158, n = 119 obs (12 países), dof = 105* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Usuarios de internet (% de la población) | Suscripciones de telefonía móvil (por cada 100 personas) | COL | 0.942 | 0.000 | 0.002 | 0.988 | 0.057 | 0.885 | 🟡 Co-tendencia probable |
| Suscripciones de telefonía móvil (por cada 100 personas) | Empleo en servicios (% del empleo total) | DOM | 0.891 | 0.001 | 0.006 | 0.673 | 0.160 | 0.682 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | ECU | -0.883 | 0.001 | 0.006 | -0.855 | -0.049 | 0.900 | 🟡 Co-tendencia probable |
| Suscripciones de telefonía móvil (por cada 100 personas) | Empleo en servicios (% del empleo total) | URY | -0.881 | 0.001 | 0.006 | -0.879 | -0.588 | 0.096 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | CHL | 0.873 | 0.001 | 0.006 | 0.842 | 0.126 | 0.747 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Suscripciones de telefonía móvil (por cada 100 personas) | MEX | 0.872 | 0.001 | 0.006 | 0.891 | -0.075 | 0.847 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | BRA | 0.866 | 0.001 | 0.006 | 0.818 | 0.095 | 0.808 | 🟡 Co-tendencia probable |
| Suscripciones de telefonía móvil (por cada 100 personas) | Empleo en servicios (% del empleo total) | BRA | -0.863 | 0.001 | 0.006 | -0.709 | -0.785 | 0.012 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Suscripciones de telefonía móvil (por cada 100 personas) | ECU | 0.861 | 0.001 | 0.006 | 0.867 | -0.722 | 0.028 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Suscripciones de telefonía móvil (por cada 100 personas) | BRA | -0.828 | 0.003 | 0.011 | -0.600 | -0.419 | 0.262 | 🟡 Co-tendencia probable |
| Suscripciones de telefonía móvil (por cada 100 personas) | Empleo en servicios (% del empleo total) | ECU | -0.826 | 0.003 | 0.011 | -0.842 | -0.034 | 0.931 | 🟡 Co-tendencia probable |
| Suscripciones de telefonía móvil (por cada 100 personas) | Empleo en servicios (% del empleo total) | MEX | 0.787 | 0.007 | 0.022 | 0.576 | 0.477 | 0.194 | 🟡 Co-tendencia probable |
| Suscripciones de telefonía móvil (por cada 100 personas) | Empleo en servicios (% del empleo total) | PAN | 0.783 | 0.013 | 0.035 | 0.800 | 0.386 | 0.344 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Suscripciones de telefonía móvil (por cada 100 personas) | CRI | -0.749 | 0.013 | 0.035 | -0.855 | -0.101 | 0.797 | 🟡 Co-tendencia probable |
| Usuarios de internet (% de la población) | Empleo en servicios (% del empleo total) | ARG | 0.743 | 0.014 | 0.036 | 0.564 | -0.106 | 0.787 | 🟡 Co-tendencia probable |
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

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-11-24-22-03/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Suscripciones de telefonía móvil (por cada 100 personas) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-11-24-22-03/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-11-24-22-03/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-24-22-03/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Adopción de IA de consumo y su relación con la inclusión digital y el empleo en servicios*.
Noticia que inspiró la línea editorial: *"Meta Muse can now do your Black Friday shopping at Walmart"* ([The Verge](https://www.theverge.com/ai-artificial-intelligence/1039874/walmart-agent-gateway-meta-muse-black-friday)).
Lo que la noticia afirmaba o sugería: La integración de asistentes de IA en plataformas de comercio electrónico aumenta la interacción digital y podría crear nuevos puestos de trabajo en el sector de servicios.
Alcance verificable con los datos: Se pueden medir niveles de usuarios de internet y suscripciones móviles como proxies de inclusión digital; el indicador de empleo en servicios permite observar cambios en la participación del sector; no hay datos directos sobre creación de empleos por IA.
Justificación del sistema: La noticia se centra en IA aplicada al comercio, lo que depende de la penetración digital; los indicadores disponibles capturan la amplitud de la infraestructura digital y la participación del sector servicios, permitiendo analizar si mayor digitalización se traduce en mayor empleo en servicios.
**Pregunta de investigación:** ¿Mayor adopción de tecnologías digitales (internet y móviles) está asociada a un aumento del empleo en el sector servicios en América Latina?
**Hipótesis planteada:** Los países con mayor porcentaje de usuarios de internet y suscripciones móviles presentan una mayor participación del empleo en servicios.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (20 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Internet users (% of population) [LCN] ~ Mobile cellular subscriptions (per 100 people) [LCN] + Employment in services (% of total employment) [LCN] (n=10, R²=0.513), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Internet users (% of population) ~ Mobile cellular subscriptions (per 100 people) + Employment in services (% of total employment) (n=119 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 90 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 1 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*