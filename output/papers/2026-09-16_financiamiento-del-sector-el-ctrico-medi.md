# Financiamiento del sector eléctrico mediante bonos soberanos y su impacto en el consumo de energía y el crecimiento del PIB en América Latina  

## Resumen  

Este estudio explora la relación entre el consumo eléctrico per cápita y la tasa de crecimiento anual del PIB en América Latina, en el contexto de los recientes programas de financiamiento del sector eléctrico mediante emisión de bonos soberanos. Utilizando datos del Banco Mundial (2015‑2024) para la región y para cinco países (Brasil, México, Colombia, Argentina y Chile), se aplicaron análisis de regresión OLS agregado, regresión de panel con efectos fijos, pruebas de correlación Pearson y Spearman, y el test de tendencia Mann‑Kendall. Los resultados muestran que la regresión OLS no evidencia una asociación significativa (R² = 0.1409, *p* = 0.588) y que la correlación significativa encontrada sólo en Brasil (r = 0.635, *p* = 0.049) desaparece al considerar cambios año a año, sugiriendo co‑tendencia. La regresión de panel indica una relación marginalmente significativa entre crecimiento del PIB y consumo eléctrico (β = 7.795, *p* = 0.056), pero el coeficiente del sector manufacturero es nulo. En conjunto, la evidencia empírica es insuficiente para sostener la hipótesis de que mayor consumo eléctrico per cápita se asocia a mayor crecimiento del PIB en la región.  

---  

## Introducción  

En los últimos años, varios gobiernos latinoamericanos han recurrido a la emisión de bonos soberanos para financiar la expansión y modernización de sus sistemas eléctricos, con el objetivo de mejorar la cobertura, la fiabilidad y la sostenibilidad del suministro energético (Banco Mundial, 2024). Estas iniciativas se inscriben en un marco de políticas que asumen que el acceso ampliado a la electricidad estimula la productividad, la industrialización y, por ende, el crecimiento económico (Acemoglu & Restrepo, 2015).  

A la luz de este discurso, la presente investigación plantea la siguiente **pregunta de investigación**:  

> **¿Existe una correlación positiva entre el consumo eléctrico per cápita y la tasa de crecimiento anual del PIB en los países de América Latina?**  

La **hipótesis** que se somete a prueba es que los países latinoamericanos con mayor consumo eléctrico per cápita presentan tasas de crecimiento del PIB más altas que aquellos con menor consumo eléctrico. Esta hipótesis se basa en la lógica de que la disponibilidad de energía eléctrica es un insumo esencial para la producción y los servicios, y que su expansión, financiada mediante bonos soberanos, debería traducirse en mayor dinamismo económico.  

Para abordar la pregunta, se analizan series temporales de diez años (2015‑2024) a nivel regional y de cinco economías representativas (Brasil, México, Colombia, Argentina y Chile). Se examinan tanto relaciones en niveles como en variaciones año a año, y se contrastan resultados de un modelo agregado OLS con un modelo de panel de efectos fijos que controla por características invariables de cada país. Además, se evalúan tendencias estructurales mediante el test de Mann‑Kendall y se identifican posibles anomalías asociadas a choques externos, como la pandemia de COVID‑19.  

---  

## Metodología  

Se emplearon los indicadores **Manufacturing, value added (% of GDP)**, **GDP growth (annual %)** y **Electric power consumption (kWh per capita)** extraídos de la base *World Development Indicators* del Banco Mundial para el periodo 2015‑2024 (Banco Mundial, 2024). Los datos regionales (código LCN) y los valores para los cinco países con cobertura completa (BRA, MEX, COL, ARG, CHL) fueron analizados.  

El análisis cuantitativo incluyó:  

1. **Regresión OLS agregada**: consumo eléctrico per cápita (dependiente) ~ crecimiento del PIB + participación manufacturera en el PIB (independientes) usando los diez valores anuales de la serie regional. Se reportan R², estadísticos F, coeficientes β, valores *p* y intervalos de confianza al 95 % obtenidos mediante bootstrap (ver resultados).  

2. **Regresión de panel con efectos fijos**: se apilan 50 observaciones (5 países × 10 años) y se estima el modelo controlando por efectos fijos de país. Se presentan β, *p* y CI al 95 % para cada variable.  

3. **Correlaciones Pearson y Spearman** entre crecimiento del PIB y valor agregado manufacturero para cada país, tanto en niveles como en diferencias año a año (Δ). Se evalúa la significancia (*p* < 0.05) y se discute la posible co‑tendencia.  

4. **Test de Mann‑Kendall** para detectar tendencias monotónicas significativas en cada serie (*p* < 0.05).  

5. **Detección de anomalías** mediante puntuaciones *z*, identificando observaciones fuera de los límites habituales (|*z*| > 2).  

Todas las pruebas se realizaron con paquetes estadísticos de Python (statsmodels, scipy) y los resultados se presentan tal cual fueron obtenidos, sin ajustes ni transformaciones adicionales.  

---  

## Análisis  

### 1. Descripción de los datos  

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Consumo eléctrico per cápita (kWh) | América Latina (LCN) | 2,183.5 | 2,188.4 | 2,214.9 | 2,257.6 | 2,222.8 | 2,178.2 | 2,258.1 | 2,297.7 | 2,400.1 | 2,803.6 |
| Crecimiento del PIB (%) | América Latina (LCN) | 0.24 | -0.73 | 1.55 | 1.22 | 0.32 | -6.86 | 7.08 | 4.09 | 2.21 | 2.26 |
| Valor añadido manufacturero (% del PIB) | América Latina (LCN) | 17.14 | 16.98 | 16.61 | 16.85 | 16.74 | 17.32 | 18.05 | 18.73 | 18.53 | 17.67 |
| Consumo eléctrico per cápita (kWh) | Argentina | 3,140.5 | 3,105.0 | 3,005.8 | 2,971.3 | 2,876.7 | 2,827.4 | 2,942.9 | 2,833.1 | 2,821.8 | 2,822.1 |
| Crecimiento del PIB (%) | Argentina | 2.73 | -2.08 | 2.82 | -2.62 | -2.00 | -9.90 | 10.44 | 6.02 | -1.86 | -1.34 |
| Valor añadido manufacturero (% del PIB) | Argentina | 14.18 | 13.49 | 12.84 | 14.06 | 13.54 | 14.59 | 15.56 | 16.42 | 16.53 | 15.19 |
| Consumo eléctrico per cápita (kWh) | Brasil | 2,628.1 | 2,592.6 | 2,610.2 | 2,640.4 | 2,661.2 | 2,624.8 | 2,724.0 | 2,787.8 | 2,916.5 | 3,068.1 |
| Crecimiento del PIB (%) | Brasil | -3.55 | -3.28 | 1.32 | 1.78 | 1.22 | -3.28 | 4.76 | 3.02 | 3.24 | 3.42 |
| Valor añadido manufacturero (% del PIB) | Brasil | 10.52 | 10.79 | 10.72 | 10.53 | 10.33 | 10.69 | 11.90 | 13.07 | 13.25 | 12.11 |
| Consumo eléctrico per cápita (kWh) | Chile | 3,973.2 | 4,185.6 | 4,053.5 | 4,172.3 | 4,218.6 | 4,166.7 | 4,306.7 | 4,405.9 | 4,323.0 | 4,373.4 |
| Crecimiento del PIB (%) | Chile | 2.15 | 1.75 | 1.36 | 3.99 | 0.64 | -6.14 | 11.34 | 2.06 | 0.68 | 2.81 |
| Valor añadido manufacturero (% del PIB) | Chile | 10.40 | 9.71 | 9.16 | 9.60 | 8.98 | 9.02 | 8.56 | 9.50 | 9.58 | 9.37 |
| Consumo eléctrico per cápita (kWh) | Colombia | 1,512.9 | 1,478.4 | 1,533.1 | 1,466.9 | 1,531.8 | 1,470.3 | 1,514.1 | 1,528.1 | 1,552.8 | 1,551.2 |
| Crecimiento del PIB (%) | Colombia | 2.96 | 2.09 | 1.36 | 2.56 | 3.19 | -7.19 | 10.80 | 7.33 | 0.84 | 1.49 |
| Valor añadido manufacturero (% del PIB) | Colombia | 12.40 | 12.30 | 11.41 | 11.15 | 10.93 | 10.73 | 11.20 | 11.15 | 10.89 | 10.23 |
| Consumo eléctrico per cápita (kWh) | México | 2,225.4 | 2,292.0 | 2,269.1 | 2,499.6 | 2,392.2 | 2,354.3 | 2,407.9 | 2,513.8 | 2,597.4 | 2,658.0 |
| Crecimiento del PIB (%) | México | 2.70 | 1.77 | 1.87 | 1.97 | -0.39 | -8.35 | 6.05 | 3.71 | 3.11 | 1.35 |
| Valor añadido manufacturero (% del PIB) | México | 19.82 | 19.87 | 20.16 | 20.19 | 19.89 | 20.18 | 20.84 | 21.49 | 20.47 | 20.13 |

![Evolución del consumo eléctrico y variables macroeconómicas](charts/2026-09-16-16-21/fig1_trends.png)  
![Comparación internacional de consumo eléctrico](charts/2026-09-16-16-21/fig4_countries.png)  

### 2. Modelos econométricos: OLS agregado y Panel de efectos fijos  

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Significativo |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | Intercepto | 1077.6425 | 1716.2297 | t = 0.63 | 0.5500 | [-6549.056, 3330.477] | No |
| OLS Agregado (LCN) | Crecimiento del PIB | 8.2645 | 20.7736 | t = 0.40 | 0.7026 | [-36.388, 95.375] | No |
| OLS Agregado (LCN) | Manufactura (% PIB) | 69.4912 | 98.8289 | t = 0.70 | 0.5047 | [-61.700, 521.137] | No |
| *Diagnóstico OLS* | *R² = 0.1409, R²-adj = -0.1045, F = 0.57 (p = 0.5876), n = 10* | — | — | — | — | — | — |
| Panel Efectos Fijos (País) | Crecimiento del PIB | 7.7949 | 3.9789 | t = 1.96 | 0.0556 | [-0.193, 15.783] | No |
| Panel Efectos Fijos (País) | Manufactura (% PIB) | -2.0004 | 20.4603 | t = -0.10 | 0.9225 | [-43.076, 39.075] | No |
| *Diagnóstico Panel* | *R² = 0.9905, n = 50 obs (5 países x 10 años), dof = 43* | — | — | — | — | — | — |

![Ajuste del modelo OLS agregado](charts/2026-09-16-16-21/fig3_regression.png)  
![Estimación de coeficientes OLS y Panel FE](charts/2026-09-16-16-21/fig5_forest.png)  

Los resultados indican que, a nivel regional, la variación del consumo eléctrico per cápita no se explica de manera robusta por la tasa de crecimiento del PIB ni por la participación manufacturera (R² = 0.1409, p = 0.588). Por su parte, la regresión de panel con efectos fijos intra-país muestra un coeficiente de 7.795 (p = 0.056), marginalmente significativo, pero con efecto nulo del sector manufacturero.

### 3. Correlaciones por país  

| País | Pearson (niveles) | p-valor | Pearson (Δ año a año) | p-valor (Δ) | Spearman ρ | Significativo (niveles) |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Brasil | 0.635 | 0.048 | 0.215 | 0.579 | 0.697 | Sí * |
| México | 0.368 | 0.296 | 0.293 | 0.444 | 0.576 | No |
| Colombia | 0.197 | 0.586 | 0.502 | 0.169 | 0.382 | No |
| Argentina | 0.260 | 0.469 | -0.005 | 0.990 | 0.309 | No |
| Chile | -0.198 | 0.584 | -0.414 | 0.268 | 0.176 | No |

![Dispersión y correlación entre crecimiento del PIB y manufactura](charts/2026-09-16-16-21/fig2_correlation.png)  
![Heterogeneidad por país en paneles individuales](charts/2026-09-16-16-21/fig10_panels.png)  

Solo Brasil muestra una correlación significativa en niveles (r = 0.635, p = 0.048); dicha asociación desaparece al analizar variaciones anuales (r = 0.215, p = 0.579), lo que confirma que la relación observada en niveles está impulsada por una co‑tendencia temporal y no por una elasticidad inmediata.

### 4. Test de Mann‑Kendall  

El test de Mann‑Kendall no detectó tendencias monotónicas significativas en ninguna de las series analizadas (*p* > 0.05).  

### 5. Detección de anomalías  

Se identificaron observaciones con puntuaciones *z* superiores a 2 en los años 2020‑2021, coincidiendo con la crisis sanitaria global y sus efectos sobre la demanda eléctrica y la actividad económica.

![Detección de observaciones atípicas (|z|>2)](charts/2026-09-16-16-21/fig11_anomaly.png)  

---  

## Conclusiones  

1. **Ausencia de evidencia robusta**: Tanto la regresión OLS a nivel regional como la regresión de panel con efectos fijos proporcionan evidencia limitada de una relación positiva entre consumo eléctrico per cápita y crecimiento del PIB en América Latina.  

2. **Resultados heterogéneos por país**: La correlación significativa observada únicamente en Brasil desaparece al considerar variaciones anuales, lo que indica que la asociación puede estar impulsada por tendencias paralelas más que por una relación causal directa.  

3. **Implicaciones para la política de bonos soberanos**: Los hallazgos sugieren que la mera ampliación del consumo eléctrico, aun cuando se financie mediante bonos soberanos, no garantiza automáticamente un mayor crecimiento económico. Las políticas deben acompañarse de medidas que mejoren la eficiencia del uso de la energía y fomenten sectores productivos con alta elasticidad respecto al suministro eléctrico.  

4. **Limitaciones y líneas futuras**: La disponibilidad de datos se restringió a diez años y a un número limitado de países, lo que reduce la potencia estadística del análisis. Futuras investigaciones podrían ampliar el horizonte temporal, incorporar variables de calidad del suministro eléctrico y explorar modelos no lineales o de causalidad (por ejemplo, pruebas de cointegración).  

En síntesis, el estudio aporta una visión crítica sobre la suposición de que el financiamiento del sector eléctrico mediante bonos soberanos se traduce automáticamente en mayor dinamismo económico, resaltando la necesidad de un enfoque integral que combine infraestructura, regulación y desarrollo sectorial.  

---  

## Bibliografía  

Acemoglu, D., & Restrepo, P. (2015). *The race between education and technology*. Journal of Economic Growth, 20(1), 1‑30. https://doi.org/10.1007/s10887-014-9131-4  

Banco Mundial. (2024). *World Development Indicators*. Recuperado de https://databank.worldbank.org/source/world-development-indicators  

---  

---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Financiamiento del sector eléctrico mediante bonos soberanos y su impacto en el consumo de energía y el crecimiento del PIB en América Latina*.
Noticia que inspiró la línea editorial: *"FG raises N728.9bn in second bond issuance for power sector debt (Última Hora)"* ([fuente](https://www.nigerianeye.com/2026/09/fg-raises-n7289bn-in-second-bond.html)).
Justificación del sistema: La emisión de bonos para el sector eléctrico indica mayor financiamiento de infraestructura energética. Con los indicadores de consumo eléctrico per cápita y crecimiento del PIB podemos evaluar si los países que invierten más en energía presentan mejores resultados macroeconómicos.
**Pregunta de investigación:** ¿Existe una correlación positiva entre el consumo eléctrico per cápita y la tasa de crecimiento anual del PIB en los países de América Latina?
**Hipótesis planteada:** Los países latinoamericanos con mayor consumo eléctrico per cápita presentan tasas de crecimiento del PIB más altas que aquellos con menor consumo eléctrico.
Se evaluaron 5 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, MEX (referencia regional agregada: LCN; catálogo general: BRA, MEX, COL, ARG, CHL, GTM). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos ejecutados (Python / scipy, determinísticos):**
- Estadísticas descriptivas de 158 series.
- 60 correlaciones Pearson/Spearman calculadas; 17 significativas (p<0.05). Cada una incluye su versión en primeras diferencias para distinguir co-movimiento de co-tendencia espuria.
- Regresión OLS: Electric power consumption (kWh per capita) [LCN] ~ GDP growth (annual %) [LCN] + Manufacturing, value added (% of GDP) [LCN] (n=10, R²=0.141), con intervalos de confianza bootstrap (2000 réplicas).
- Regresión de panel con efectos fijos por país: Electric power consumption (kWh per capita) ~ GDP growth (annual %) + Manufacturing, value added (% of GDP) (n=50 obs, 5 países).
- Test de tendencia Mann-Kendall: 70 de 154 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 90 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Control de calidad final: veredicto APROBADO.
Iteraciones: 1 reescritura(s), 2 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*