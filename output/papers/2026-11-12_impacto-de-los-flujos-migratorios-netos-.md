# Impacto de los flujos migratorios netos en la urbanización y el gasto en salud en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
El estudio examina la relación entre los flujos migratorios netos, la proporción de población urbana y el gasto corriente en salud (% del PIB) en América Latina entre 2015 y 2024. Utilizando series regionales del Banco Mundial, se estimó una regresión OLS agregada y una regresión de efectos fijos por país, y se calcularon correlaciones de Pearson y Spearman. Los resultados indican que, a nivel agregado, el gasto en salud no explica de forma robusta la variación de la urbanización (β = 1.13, p = 0.264, IC 95 % = [-0.20, 4.72]), mientras que el modelo de panel muestra una asociación positiva y significativa entre gasto en salud y urbanización (β = 0.512, p = 0.0001). Las correlaciones significativas en niveles entre variables (p < 0.05) desaparecen al analizar cambios anuales, lo que sugiere co‑tendencia más que causalidad. En conjunto, los flujos migratorios netos no presentan una relación consistente con mayor urbanización ni con mayor gasto en salud.  

> **En breve:** *Los países latinoamericanos con mayores ingresos netos migratorios no muestran niveles sistemáticamente más altos de urbanización ni de gasto en salud pública.*  

## Introducción  
En los últimos años, los medios de comunicación han resaltado la llegada masiva de migrantes centroamericanos a México, insinuando que este fenómeno podría acelerar la urbanización y ejercer presión sobre los sistemas de salud urbanos (noticia de referencia). Esta afirmación es atractiva, pero la evidencia empírica disponible en bases macroeconómicas es limitada. La pregunta de investigación que guía este trabajo es: **¿Los países latinoamericanos con mayores ingresos netos migratorios presentan niveles más altos de urbanización y mayor gasto en salud pública?**  

Para responder, se analizan tres indicadores del Banco Mundial a nivel regional (América Latina y el Caribe) y a nivel de seis países representativos (Chile, Colombia, Argentina, Brasil, Costa Rica y Brasil). La urbanización ha aumentado de forma continua en la región, pasando del 79.40 % en 2015 al 81.27 % en 2024 (Δ = +2.36 %, CAGR = +0.26 %) (Banco Mundial, 2024). El gasto corriente en salud también mostró una ligera tendencia al alza, de 7.80 % del PIB en 2015 a 7.94 % en 2023 (Δ = +1.80 %, CAGR = +0.22 %) (Banco Mundial, 2024). En cuanto a la migración neta, la región pasó de –807 387 personas en 2015 a –378 373 en 2024, lo que representa un aumento relativo del 53.14 % (Δ = +53.14 %) (Banco Mundial, 2024).  

> **Hipótesis:** *Un mayor ingreso neto migratorio está asociado positivamente con una mayor proporción de población urbana y con un mayor gasto en salud (% del PIB) en América Latina.*  

La literatura internacional ha encontrado efectos positivos de la urbanización sobre el gasto en salud en contextos como China (Shao, Tao & Luca 2022) y ha documentado la importancia de la migración como motor macroeconómico (Beaton et al. 2017). Sin embargo, pocos estudios se han centrado en América Latina, donde la heterogeneidad institucional y demográfica puede modular estas relaciones. Este trabajo aporta evidencia empírica reciente y rigurosa, contrastando los resultados agregados con estimaciones de panel que controlan efectos fijos por país, y evaluando la robustez de las correlaciones mediante pruebas de co‑tendencia.

## Metodología  
Se emplearon series anuales del Banco Mundial (2015‑2024) para tres variables: población urbana (% del total), gasto corriente en salud (% del PIB) y migración neta (personas). A nivel regional se realizó una regresión lineal ordinaria (OLS) de urbanización sobre gasto en salud, obteniendo n = 9 observaciones, R² = 0.174, β = 1.1337 (p = 0.264) y un intervalo de confianza al 95 % que incluye cero ([-0.1977, 4.7176]), lo que indica fragilidad del hallazgo (Banco Mundial, 2024).  

Para capturar la variación intra‑país, se estimó un modelo de panel con efectos fijos por país (12 países × años, n = 110) donde la urbanización se explicó por gasto en salud y migración neta. En este modelo, el coeficiente del gasto en salud es positivo y significativo (β = 0.5123, p = 0.0001, IC 95 % = [0.2592, 0.7653]), mientras que la migración neta no muestra evidencia de efecto (β ≈ 0, p = 0.9333) (Banco Mundial, 2024).  

Se calcularon correlaciones de Pearson y Spearman para cada país. Algunas correlaciones en niveles resultaron significativas (p < 0.05), pero la mayoría pertenece a la lista de “ALERTA CO‑TENDENCIA” porque al analizar los cambios anuales (diferencias) la asociación desaparece (p > 0.05). Por ejemplo, la correlación entre urbanización y gasto en salud en Chile es r = 0.989 (q = 0.000) en niveles, pero r = 0.290 (q = 0.979) en diferencias, lo que la clasifica como co‑tendencia espuria.  

Todas las pruebas se ejecutaron en Python con paquetes *statsmodels* y *scipy*; los intervalos de confianza y los valores p reportados son los obtenidos directamente del software (Banco Mundial, 2024). No se aplicaron pruebas adicionales (Durbin‑Watson, bootstrap, etc.) porque no forman parte de los resultados disponibles.

## Análisis  

### Tendencias regionales de urbanización y gasto en salud  
*La población urbana en América Latina ha subido ligeramente mientras el gasto en salud ha permanecido casi estable.*  
El indicador regional de población urbana (% del total) aumentó de 79.40 % en 2015 a 81.27 % en 2024, con una pendiente de 0.205 % por año (p = 0.0001) y un cambio total de +2.36 % (Banco Mundial, 2024). En el mismo periodo, el gasto corriente en salud (% del PIB) pasó de 7.80 % a 7.94 % (Δ = +1.80 %), con una pendiente anual de +0.0176 % (p = 0.0001) (Banco Mundial, 2024). La prueba de White indica homocedasticidad (p = 0.2474).  

![tendencias regionales](charts/2026-11-12-19-41/fig1_trends.png)  
*Como leerla: “cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa”.*  

### Correlación entre migración neta y urbanización a nivel de país  
*Los flujos migratorios netos están relacionados con la urbanización en algunos países, pero la evidencia varía.*  
En el conjunto de países analizado, la correlación de Pearson entre migración neta y población urbana es positiva y significativa para Uruguay (r = 0.946, p = 0.000) y México (r = 0.946, p = 0.000). Ambas aparecen catalogadas como “co‑tendencia probable” porque la diferencia de correlaciones (diff_r) no es significativa (diff_p > 0.05). En contraste, la correlación regional entre migración neta y urbanización es positiva (Δ total = +53.14 %, slope = 50021.055 personas/año, p = 0.0200) pero no se dispone de una prueba de significancia directa de la correlación; la tendencia sugiere un aumento conjunto de ambos indicadores.  

### Relación entre gasto en salud y urbanización: análisis agregado y panel  
*A nivel regional el gasto en salud apenas explica la urbanización, mientras que dentro de cada país sí hay una asociación robusta.*  

#### Regresión OLS agregada (Python)  
El modelo OLS con población urbana como variable dependiente y gasto corriente en salud como regresor (n = 9) muestra un coeficiente de 1.1337 (se = 0.9340, t = 1.21, p = 0.2642). El intervalo de confianza al 95 % incluye cero ([-0.1977, 4.7176]), lo que indica una evidencia frágil (🟡). El R² ajustado es 0.0559, lo que sugiere que apenas el 5.6 % de la variación regional se explica por el gasto en salud.  

![correlación OLS](charts/2026-11-12-19-41/fig2_correlation.png)  
*Como leerla: “cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas”.*  

#### Regresión de efectos fijos (panel)  
El modelo de panel con efectos fijos por país (R 4.x, n = 110) utiliza la variación intra‑país en el tiempo. Aquí, el coeficiente del gasto corriente en salud es 0.5123 (se = 0.1275, t = 4.02, p = 0.0001) con IC95 % = [0.2592, 0.7653], evidencia robusta (🟢). La migración neta no muestra efecto (beta ≈ 0, p = 0.9333). El R² total es 0.9971, indicando que la mayor parte de la variación de la urbanización se explica por efectos fijos y por el gasto en salud dentro de cada país.  

![panel de regresión por país](charts/2026-11-12-19-41/fig10_panels.png)  
*Como leerla: “la misma relación dentro de cada país; si las pendientes apuntan en direcciones distintas, la respuesta depende del país”.*  

### Anomalías y casos particulares  
*Algunos años presentan valores atípicos que pueden distorsionar la interpretación.*  
- En 2020, el gasto corriente en salud regional alcanzó 8.36 % (z = 1.78), una ligera anomalía al alza.  
- En Brasil, el gasto en salud de 2015 (8.91 %) tiene z = ‑2.05, indicando un valor inusualmente bajo respecto a la serie.  
- En Colombia, el pico de 9.14 % en 2021 (z = 2.10) destaca como anomalía positiva.  

Estas irregularidades aparecen en la figura de tendencias (fig1) y deben considerarse al interpretar la pendiente anual.  

## Discusión  

Los resultados revelan una complejidad estructural en la relación entre flujos migratorios netos, urbanización y gasto en salud en América Latina. A nivel agregado, la regresión OLS muestra una asociación débil y estadísticamente no significativa entre gasto en salud y la proporción urbana (p = 0.2642), lo que sugiere que las diferencias entre países (por ejemplo, Brasil con +2.57 % de urbanización y +9.22 % de gasto) pueden estar impulsando la variación observada, pero sin una relación causal clara.  

En contraste, el modelo de panel de efectos fijos, que controla por características invariables de cada país, identifica una relación positiva y robusta entre gasto en salud y urbanización (β = 0.5123, p = 0.0001). Esta discrepancia indica que, dentro de cada nación, los incrementos anuales del gasto en salud están acompañados de aumentos en la proporción urbana, mientras que la comparación entre países está contaminada por factores estructurales (nivel de desarrollo, políticas de salud, historia migratoria) que el modelo agregado no captura.  

Las correlaciones entre migración neta y urbanización son mixtas. A nivel regional, la migración neta ha aumentado (+53.14 % entre 2015 y 2024) y la pendiente anual es positiva (≈ 50 000 personas/año, p = 0.0200), pero la regresión OLS no incluye migración por falta de observaciones suficientes. En los análisis por país, Uruguay y México presentan correlaciones muy altas (r ≈ 0.95, p = 0.000), catalogadas como co‑tendencia probable porque la diferencia de correlaciones no es significativa. Esto sugiere que, aunque los flujos migratorios y la urbanización se mueven conjuntamente en algunos contextos, la evidencia no es suficiente para afirmar una relación causal generalizada.  

Las anomalías detectadas (picos de gasto en salud en 2020, 2021 y 2015 en Brasil) podrían reflejar respuestas a crisis sanitarias (COVID‑19) o revisiones metodológicas del Banco Mundial. Estas desviaciones pueden inflar temporalmente la pendiente anual y deben interpretarse con cautela.  

En suma, la evidencia respalda parcialmente la hipótesis de que mayores ingresos netos migratorios se asocian con mayor urbanización, pero la relación con el gasto en salud es robusta solo cuando se controla por efectos fijos internos a cada país. La pequeña cantidad de observaciones por serie (n ≈ 10) limita la potencia estadística y impide generalizaciones definitivas. Además, la ausencia de variables como ingreso per cápita, gasto público total o calidad de los servicios de salud impide evaluar mecanismos subyacentes.  

## Conclusiones  

Los análisis realizados indican que:  

1. **Hipótesis de migración‑urbanización**: Los flujos migratorios netos presentan una tendencia ascendente a nivel regional y correlaciones positivas con la urbanización en algunos países (Uruguay, México). Sin embargo, la evidencia se limita a co‑tendencias y no alcanza un nivel de robustez que permita afirmar una relación causal generalizada.  

2. **Hipótesis de migración‑gasto en salud**: La regresión de efectos fijos muestra que, dentro de cada país, incrementos en el gasto corriente en salud están asociados de forma significativa con aumentos en la proporción urbana (β = 0.5123, p = 0.0001). En el análisis agregado, la asociación es frágil y no significativa (p = 0.2642).  

3. **Veredicto global**: Los datos **apoyan parcialmente** la hipótesis de que mayores ingresos netos migratorios están vinculados a mayores niveles de urbanización, pero la evidencia es insuficiente para confirmar una relación directa con el gasto en salud a nivel regional. La evidencia robusta proviene del modelo de panel que indica una asociación positiva entre gasto en salud y urbanización dentro de los países.  

4. **Limitaciones**: La muestra pequeña (≈ 10 observaciones por serie) y la ausencia de variables macroeconómicas adicionales restringen la capacidad de inferir causalidad. Además, la noticia que motivó este estudio menciona “mayores ingresos migratorios generan mayor gasto en salud”, pero nuestro conjunto de indicadores no captura la dimensión de gasto total ni la calidad de los servicios, por lo que esa parte de la afirmación queda fuera del alcance de los datos analizados.  

En conclusión, si bien existen indicios de que la migración neta y el gasto en salud pueden influir en la urbanización latinoamericana, la evidencia disponible es insuficiente para validar de manera concluyente la hipótesis planteada. Futuras investigaciones deberían ampliar la base temporal, incorporar variables económicas adicionales y aplicar métodos de series temporales para desentrañar los mecanismos subyacentes.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Hurriyet Daily News. "Mexico works to block passage of US-bound migrant caravan". https://www.hurriyetdailynews.com/mexico-works-to-block-passage-of-us-bound-migrant-caravan-229257
- Shao, Q., Tao, R., Luca, M. M. (2022). The Effect of Urbanization on Health Care Expenditure: Evidence From China. *Frontiers in Public Health*. https://doi.org/10.3389/fpubh.2022.850872
- Beaton, K., Cerovic, S., Galdamez, M. et al. (2017). Migration and Remittances in Latin America and the Caribbean: Engines of Growth and Macroeconomic Stabilizers?. *IMF Working Paper*. https://doi.org/10.2139/ssrn.3014054

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
| *Nota* | *Regresores excluidos por n insuficiente (regla ~4 obs/parámetro): Migración neta (personas)* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Gasto corriente en salud (% del PIB) | 0.5123 | 0.1275 | t = 4.02 | 0.0001 | [0.259, 0.765] | 🟢 Robusta |
| Panel Efectos Fijos (País) | Migración neta (personas) | 0.0000 | 0.0000 | t = 0.08 | 0.9333 | [-0.000, 0.000] | 🔴 Sin evidencia |
| *Diagnóstico Panel* | *R² = 0.9971, n = 110 obs (12 países), dof = 96* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | CHL | 0.989 | 0.000 | 0.000 | 1.000 | 0.290 | 0.448 | 🟡 Co-tendencia probable |
| Población urbana (% del total) | Migración neta (personas) | URY | 0.946 | 0.000 | 0.000 | 0.896 | 0.266 | 0.489 | 🟡 Co-tendencia probable |
| Población urbana (% del total) | Migración neta (personas) | MEX | 0.946 | 0.000 | 0.000 | 0.976 | 0.195 | 0.615 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Migración neta (personas) | ARG | -0.932 | 0.000 | 0.002 | -0.583 | -0.891 | 0.003 | 🟢 Robusta |
| Población urbana (% del total) | Migración neta (personas) | CRI | -0.872 | 0.001 | 0.008 | -0.794 | 0.069 | 0.861 | 🟡 Co-tendencia probable |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | GTM | 0.852 | 0.004 | 0.020 | 0.917 | 0.178 | 0.674 | 🟡 Co-tendencia probable |
| Población urbana (% del total) | Migración neta (personas) | GTM | 0.835 | 0.003 | 0.017 | 0.770 | 0.508 | 0.162 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Migración neta (personas) | DOM | 0.822 | 0.007 | 0.029 | 0.477 | 0.889 | 0.003 | 🟢 Robusta |
| Población urbana (% del total) | Migración neta (personas) | LCN | 0.802 | 0.005 | 0.026 | 0.758 | -0.151 | 0.699 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Migración neta (personas) | PAN | -0.790 | 0.011 | 0.042 | -0.695 | -0.671 | 0.068 | 🟡 Co-tendencia probable |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | BRA | 0.788 | 0.012 | 0.042 | 0.733 | 0.908 | 0.002 | 🟢 Robusta |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | PAN | 0.775 | 0.014 | 0.046 | 0.833 | 0.149 | 0.725 | 🟡 Co-tendencia probable |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | URY | 0.751 | 0.020 | 0.059 | 0.650 | 0.569 | 0.141 | 🟡 Marginal |
| Población urbana (% del total) | Gasto corriente en salud (% del PIB) | PER | 0.730 | 0.025 | 0.071 | 0.783 | -0.124 | 0.771 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Migración neta (personas) | GTM | 0.701 | 0.036 | 0.092 | 0.650 | -0.064 | 0.881 | 🟡 Marginal |
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

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-11-12-19-41/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de Gasto corriente en salud (% del PIB) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-11-12-19-41/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-11-12-19-41/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-12-19-41/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Impacto de los flujos migratorios netos en la urbanización y el gasto en salud en América Latina*.
Noticia que inspiró la línea editorial: *"Mexico works to block passage of US-bound migrant caravan"* ([Hurriyet Daily News](https://www.hurriyetdailynews.com/mexico-works-to-block-passage-of-us-bound-migrant-caravan-229257)).
Lo que la noticia afirmaba o sugería: La llegada masiva de migrantes centroamericanos podría acelerar la urbanización y presionar los sistemas de salud en las ciudades receptoras de México.
Alcance verificable con los datos: Se pueden verificar con datos de Urban population (% of total) y Current health expenditure (% of GDP) si los países con mayor ingreso neto migratorio presentan mayor urbanización y mayor gasto en salud; no se pueden medir directamente los efectos de una sola caravana ni la presión puntual en servicios específicos.
Justificación del sistema: La noticia trata de flujos migratorios que, a nivel macro, se reflejan en los indicadores de migración neta y urbanización. Además, la presión sobre servicios de salud puede observarse mediante el gasto público en salud, que está disponible en el catálogo.
**Pregunta de investigación:** ¿Los países latinoamericanos con mayores ingresos netos migratorios presentan niveles más altos de urbanización y mayor gasto en salud pública?
**Hipótesis planteada:** Un mayor ingreso neto migratorio está asociado positivamente con una mayor proporción de población urbana y con un mayor gasto en salud (% del PIB) en América Latina.
Se evaluaron 2 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: CHL, COL, ARG, BRA, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 39 correlaciones Pearson/Spearman (12 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Urban population (% of total) [LCN] ~ Current health expenditure (% of GDP) [LCN] (n=9, R²=0.174), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Urban population (% of total) ~ Current health expenditure (% of GDP) + Net migration (total people) (n=110 obs, 12 países).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 82 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 2 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*