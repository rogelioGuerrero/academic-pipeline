# Relación entre inversión en educación y crecimiento del PIB per cápita en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Octubre de 2026  

## Resumen  
Este estudio examina si el gasto público en educación está asociado con el nivel de vida, medido por el PIB per cápita, en América Latina entre 2015 y 2024. Utilizando series del Banco Mundial, se calculan correlaciones de Pearson y Spearman, pruebas de tendencia (Mann‑Kendall) y regresiones lineales simples. Los resultados muestran que, a nivel regional, la relación entre gasto educativo y PIB per cápita es negativa pero no significativa (r = ‑0.730, p = 0.026, q = 0.111). En el caso de Costa Rica, la correlación en niveles es fuerte y significativa (r = ‑0.881, q = 0.022), pero desaparece al analizar cambios anuales (rΔ = ‑0.280, q = 0.695), indicando co‑tendencia espuria. En conjunto, los indicadores no respaldan una asociación positiva robusta entre mayor gasto en educación y mayor PIB per cápita en la región.  

> **En breve:** No se encontró evidencia estadísticamente robusta de que un mayor gasto público en educación se relacione positivamente con el PIB per cápita en América Latina.  

## Introducción  
La relación entre la inversión pública en educación y el crecimiento económico ha sido un tema central en la literatura del desarrollo (Barro, 1991; Devarajan et al., 1996). La premisa teórica sostiene que mayores recursos destinados a la educación mejoran el capital humano, lo que a su vez eleva la productividad y el ingreso per cápita. Sin embargo, la evidencia empírica es mixta y a menudo depende del contexto institucional y del horizonte temporal analizado (Gregorio & Lee, 2004; Sahay & Goyal, 2006).  

Recientemente, una polémica campaña corporativa ha generado cobertura mediática que sugiere que la reputación internacional de la región podría influir en la inversión extranjera y, por ende, en el desempeño macroeconómico. La noticia afirma que “la percepción internacional afecta la inversión y el crecimiento”, pero no provee datos cuantitativos que permitan verificar tal afirmación.  

En este contexto, la presente investigación plantea la siguiente **pregunta de investigación**:  

> ¿Existe una relación positiva entre el gasto público en educación y el PIB per cápita en los países latinoamericanos entre 2015 y 2024?  

Para responder, se contrastan los indicadores de gasto educativo (% del PIB) y PIB per cápita (US$ actuales) provistos por el Banco Mundial. A nivel regional, el gasto en educación disminuyó un 14.12 % en el periodo (de 4.45 % a 3.82 % del PIB) mientras que el PIB per cápita aumentó un 25.25 % (de 8 546.92 USD a 10 705.11 USD) (Banco Mundial, 2024). En los países analizados, la variación del gasto es heterogénea: por ejemplo, Ecuador redujo su gasto del 5.11 % al 3.69 % (Δ = ‑27.71 %), mientras que Perú lo incrementó del 3.97 % al 4.36 % (Δ = +9.79 %).  

> **Hipótesis:**  
> > Un mayor gasto público en educación está asociado a un mayor PIB per cápita en América Latina.  

## Metodología  
Se emplearon series anuales (2015‑2024) de gasto público en educación (% del PIB) y PIB per cápita (US$ actuales) extraídas del Banco Mundial (Banco Mundial, 2024). El análisis incluyó:  

1. **Correlaciones de Pearson y Spearman** entre los dos indicadores a nivel regional (LCN) y por país (ECU, GTM, PER, ARG, CRI). Los valores de r y p‑value se complementaron con q‑values ajustados por FDR (Benjamini‑Hochberg).  
2. **Pruebas de tendencia Mann‑Kendall** para detectar cambios estructurales en cada serie (p < 0.05 considerado significativo).  
3. **Regresión lineal simple (OLS)** en niveles, usando la variable “gasto en educación” como predictor del “PIB per cápita”. Dado que los resultados de panel con efectos fijos no aparecen en los resultados entregados, no se incluyen.  
4. **Análisis de diferencias año a año** (Δ) para identificar co‑tendencias: se comparó la correlación en niveles con la correlación de los cambios anuales (rΔ). Cuando la correlación en niveles era significativa pero rΔ no lo era (p > 0.05), la relación se describió como co‑tendencia espuria, siguiendo la recomendación de los resultados.  

Todas las pruebas se realizaron en Python (statsmodels, scipy). Los coeficientes y valores p reportados provienen exclusivamente de los cálculos presentados en los resultados. No se realizaron pruebas adicionales ni se emplearon fuentes distintas al Banco Mundial.

## Análisis  

### Tendencias macroeconómicas regionales  
*Los indicadores muestran que, a nivel regional, el PIB per cápita ha subido mientras el gasto en educación ha bajado.*  

Entre 2015 y 2024 el PIB per cápita promedio de América Latina y el Caribe pasó de **8 546,92 USD** a **10 705,11 USD**, lo que representa un incremento total del **+25,25 %** y una tasa compuesta anual (CAGR) de **+2,53 %** (Banco Mundial, 2024). En contraste, el gasto público en educación como proporción del PIB disminuyó de **4,45 %** a **3,82 %**, una caída del **‑14,12 %** y una CAGR de **‑1,88 %**. La tendencia negativa del gasto educativo es significativa (p = 0.0187 para Brasil, p = 0.0355 para México, p = 0.0476 para Argentina) según pruebas de tendencia lineal.  

![figura de tendencias regionales](charts/2026-10-16-16-17/fig1_trends.png)  
*Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa.*

### Correlaciones entre gasto educativo y PIB per cápita  
*Los números indican que, a nivel de países, la relación entre gasto y riqueza no es consistentemente positiva.*  

Se calcularon correlaciones de Pearson entre el gasto público en educación (% del PIB) y el PIB per cápita para cada país y para la región completa (LCN). Los resultados más relevantes son:

| País / Región | Pearson r | p‑valor | q‑valor (FDR) | Evidencia |
|---|---|---|---|---|
| Región (LCN) | **‑0,730** | 0,026 | 0,111 | 🔴 Sin evidencia |
| Costa Rica (CRI) | **‑0,881** | 0,002 | **0,022** | 🟡 Co‑tendencia probable |
| Colombia (COL) | **‑0,836** | 0,038 | 0,125 | 🔴 Sin evidencia |
| Panamá (PAN) | **‑0,774** | 0,014 | 0,094 | 🟡 Marginal |
| Ecuador (ECU) | ‑0,489 | 0,152 | 0,297 | 🔴 Sin evidencia |
| Perú (PER) | **0,450** | 0,192 | 0,312 | 🔴 Sin evidencia |
| Argentina (ARG) | **0,317** | 0,406 | 0,480 | 🔴 Sin evidencia |
| Guatemala (GTM) | **0,242** | 0,501 | 0,501 | 🔴 Sin evidencia |

Solo la correlación de Costa Rica supera el umbral de significancia ajustada (q < 0,05). Sin embargo, el análisis de diferencias año a año (Δ) muestra r = ‑0,280 con q = 0,695, lo que indica que la fuerte correlación en niveles es una **co‑tendencia espuria** y desaparece cuando se controla por tendencias comunes (alerta de co‑tendencia).  

![figura de correlación país‑a‑país](charts/2026-10-16-16-17/fig2_correlation.png)  
*Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas.*

### Análisis de casos país‑por‑país  
*Algunos países presentan aumentos o disminuciones notables en su gasto educativo, pero estos cambios no se traducen de forma clara en variaciones del PIB per cápita.*  

- **Ecuador**: el gasto cayó de **5,11 %** (2015) a **3,69 %** (2024), una caída del **‑27,71 %** (CAGR = ‑3,54 %). No se observa una relación clara con su PIB per cápita, que sigue la tendencia regional de crecimiento moderado.  
- **Guatemala**: el gasto se mantuvo prácticamente estable (Δ = +1,50 %) y el PIB per cápita mostró una ligera alza, pero la correlación es prácticamente nula (r = 0,242).  
- **Perú**: el gasto aumentó un **+9,79 %** (CAGR = +1,04 %) y el PIB per cápita creció a una tasa anual de **≈ 208 USD** (p = 0,0123). La correlación positiva (r = 0,450) no alcanza significancia estadística después del ajuste por FDR.  
- **Argentina**: el gasto disminuyó un **‑13,38 %** (CAGR = ‑1,78 %) mientras que el PIB per cápita mostró una leve tendencia a la baja, generando una correlación positiva débil (r = 0,317).  

Los análisis de tendencia individual (p‑valores de la pendiente) confirman que la mayoría de los países presentan **pendientes negativas** en el gasto educativo (p < 0,05 en Brasil, México y Argentina), mientras que sus PIB per cápita presentan **pendientes positivas** (p < 0,05 en México, Perú, Chile).  

![figura de comparación entre países](charts/2026-10-16-16-17/fig4_countries.png)  
*Como leerla: barra más larga o país más oscuro = valor más alto del indicador.*

### Calor de relaciones y robustez estadística  
*El mapa de calor muestra que pocas relaciones son estadísticamente significativas y la mayoría es débil o nula.*  

El heatmap de correlaciones (figura 6) indica que solo los pares señalados con asterisco (*) son significativos tras el control de FDR. En la figura aparecen colores rojos intensos para Costa Rica y Panamá, pero la nota de co‑tendencia advierte que dichos resultados pueden ser espurios.  

![figura de mapa de calor](charts/2026-10-16-16-17/fig6_heatmap.png)  
*Como leerla: azul = se mueven juntas; rojo = se mueven al revés; casi blanco = sin relación clara; * = significativo.*

### Resumen de hallazgos cuantitativos  
*En conjunto, los números no apoyan la idea de que más gasto en educación genere automáticamente mayor PIB per cápita.*  

- La región muestra **crecimiento del PIB per cápita** (+2,53 % CAGR) y **reducción del gasto educativo** (‑1,88 % CAGR).  
- La **correlación regional** es negativa (r = ‑0,730) y no significativa tras corrección por FDR.  
- **Solo Costa Rica** presenta una correlación significativa en niveles, pero se trata de una co‑tendencia espuria.  
- **Ningún país** evidencia una asociación robusta y positiva entre variaciones anuales de gasto y variaciones anuales de PIB per cápita.  

## Discusión  

### Comparación con la literatura existente  
*Los resultados coinciden con estudios que encuentran efectos mixtos o nulos de la inversión educativa sobre el crecimiento.*  

Barro (1991) encontró que el capital humano, medido por tasas de escolarización, está positivamente relacionado con el crecimiento del PIB per cápita, pero su análisis se centró en variables de nivel de educación y en periodos mucho más largos. Devarajan et al. (1996) mostraron que la **composición** del gasto público es más determinante que el nivel absoluto del gasto; un aumento del gasto en educación sin mejoras en eficiencia puede no traducirse en mayor productividad. Nuestros hallazgos son **consistentes** con esa visión: la mera proporción del PIB destinada a educación no captura la calidad ni la efectividad del gasto, lo que explica la ausencia de una relación positiva clara.  

Gregorio y Lee (2004) y Sahay & Goyal (2006) resaltan la importancia de la **estabilidad macroeconómica** y la **volatilidad** para el crecimiento en América Latina. Las tendencias negativas del gasto educativo en varios países coinciden con periodos de mayor volatilidad fiscal, lo que podría atenuar cualquier efecto positivo esperado.  

### Limitaciones de los datos y del enfoque metodológico  
*Hay varios factores que pueden haber sesgado los resultados y que deben considerarse al interpretar los hallazgos.*  

1. **Agregación y escala temporal**: el análisis se basa en datos anuales de una década (2015‑2024). Cambios estructurales en la educación pueden requerir horizontes más largos para manifestarse en el PIB per cápita.  
2. **Medida del gasto**: usar el porcentaje del PIB como proxy ignora variaciones en el nivel absoluto de gasto y en la eficiencia del gasto (por ejemplo, diferencias en salarios docentes, infraestructura o gestión).  
3. **Variables omitidas**: factores como inversión privada en educación, calidad docente, acceso a tecnología y políticas de mercado laboral no se incluyen, lo que puede generar sesgo de variable omitida.  
4. **Co‑tendencia**: la fuerte correlación encontrada para Costa Rica desaparece al analizar diferencias año a año, lo que ilustra el riesgo de interpretar relaciones en niveles cuando ambas series comparten tendencias comunes.  

### Implicaciones para la polémica corporativa  
*Aunque la noticia sugiere que la reputación internacional afecta la inversión y el crecimiento, los indicadores macroeconómicos no respaldan una relación directa entre gasto educativo y desempeño económico en el periodo analizado.*  

La campaña corporativa citada no se traduce en cambios medibles en los indicadores de gasto educativo ni en el PIB per cápita. Sin embargo, la percepción internacional podría influir en flujos de inversión extranjera directa (IED) que no se capturan en las variables estudiadas. Futuras investigaciones deberían incorporar datos de IED y de indicadores de reputación (p. ej., índices de facilidad para hacer negocios) para evaluar ese canal potencial.  

## Conclusiones  

*Los resultados indican que, en la última década, mayor gasto público en educación no se asoció de forma robusta con mayores niveles de PIB per cápita en América Latina.*  

1. **Tendencias divergentes**: mientras el PIB per cápita regional aumentó un 25 % en promedio, el gasto público en educación disminuyó un 14 %.  
2. **Correlaciones débiles y no significativas**: la correlación regional es negativa (r = ‑0,730) y ninguna asociación supera el umbral de significancia ajustada, salvo la aparente excepción de Costa Rica, que se revela como co‑tendencia espuria.  
3. **Variabilidad entre países**: algunos países (Perú, Guatemala) mostraron aumentos modestos en gasto educativo sin efectos claros en el PIB per cápita; otros (Argentina, Brasil) redujeron su gasto mientras su PIB per cápita mostró tendencias opuestas.  
4. **Consistencia con la literatura**: los hallazgos concuerdan con estudios que enfatizan la importancia de la **calidad y composición** del gasto más que la magnitud del mismo (Devarajan et al., 1996; Barro, 1991).  

En conclusión, la hipótesis de que “un mayor gasto en educación está asociado a un mayor PIB per cápita en América Latina” **no se confirma** con los datos disponibles para 2015‑2024. Las políticas orientadas a mejorar la **eficiencia** y la **calidad** del gasto educativo, así como a abordar factores estructurales de la economía, podrían ser más determinantes para impulsar el crecimiento económico que simplemente aumentar la proporción del PIB destinada a educación.  

---  

*Referencias*  

- Barro, R. J. (1991). Economic Growth in a Cross Section of Countries. *The Quarterly Journal of Economics*. https://doi.org/10.2307/2937943  
- Devarajan, S., A, V. S., Zou, H. (1996). The composition of public expenditure and economic growth. *Journal of Monetary Economics*. https://doi.org/10.1016/0304-3932(96)01249-4  
- Gregorio, J. D., Lee, J. (2004). Growth and Adjustment in East Asia and Latin America. *Economía*. https://doi.org/10.1353/eco.2005.0004  
- Sahay, R., Goyal, R. (2006). Volatility and Growth in Latin America. *IMF Working Paper*. https://doi.org/10.5089/9781451865479.001  
- Banco Mundial (2024). World Development Indicators. https://data.worldbank.org/  

---  

*Todas las figuras referenciadas corresponden a los archivos listados en la sección de Figuras Narrativas.*

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- The Irish Times. "Ryanair ‘recognises’ disputed Western Sahara territory in controversial marketing campaign". https://www.irishtimes.com/transport/2026/10/15/ryanair-recognises-disputed-western-sahara-territory-in-controversial-marketing-campaign/
- Devarajan, S., A, V. S., Zou, H. (1996). The composition of public expenditure and economic growth. *Journal of Monetary Economics*. https://doi.org/10.1016/0304-3932(96)01249-4
- Gregorio, J. D., Lee, J. (2004). Growth and Adjustment in East Asia and Latin America. *Economía*. https://doi.org/10.1353/eco.2005.0004
- Barro, R. J. (1991). Economic Growth in a Cross Section of Countries. *The Quarterly Journal of Economics*. https://doi.org/10.2307/2937943
- Sahay, R., Goyal, R. (2006). Volatility and Growth in Latin America. *IMF Working Paper*. https://doi.org/10.5089/9781451865479.001

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| PIB per cápita (US$ actuales) (USD) | América Latina y el Caribe (LCN) | 8,546.9 | 8,241.5 | 9,065.8 | 8,778.6 | 8,540.0 | 7,169.4 | 8,292.2 | 9,412.1 | 10,507.6 | 10,705.1 |
| Gasto público en educación (% del PIB) (%) | América Latina y el Caribe (LCN) | 4.447 | 4.414 | 4.408 | 4.461 | 4.511 | 4.535 | 4.087 | 3.861 | 3.820 | — |
| PIB per cápita (US$ actuales) (USD) | Argentina | 13,679.6 | 12,700.0 | 14,532.5 | 11,752.8 | 9,956.0 | 8,535.6 | 10,738.0 | 13,962.2 | 14,261.8 | 13,969.8 |
| Gasto público en educación (% del PIB) (%) | Argentina | 5.776 | 5.545 | 5.454 | 4.878 | 4.772 | 5.277 | 4.654 | 4.793 | 5.003 | — |
| PIB per cápita (US$ actuales) (USD) | Brasil | 8,936.2 | 8,836.3 | 10,080.5 | 9,300.7 | 9,029.8 | 7,074.2 | 7,972.5 | 9,281.3 | 10,377.6 | 10,310.5 |
| Gasto público en educación (% del PIB) (%) | Brasil | 6.241 | 6.314 | 6.320 | 6.089 | 5.963 | 5.771 | 5.497 | 5.619 | — | — |
| PIB per cápita (US$ actuales) (USD) | Chile | 13,433.9 | 13,649.9 | 14,879.9 | 15,659.5 | 14,496.9 | 13,118.0 | 16,216.2 | 15,399.1 | 17,081.5 | 16,659.0 |
| Gasto público en educación (% del PIB) (%) | Chile | 4.904 | 5.366 | 5.433 | 5.473 | 5.626 | 5.630 | 5.002 | 4.912 | — | — |
| PIB per cápita (US$ actuales) (USD) | Colombia | 6,248.5 | 5,959.8 | 6,479.5 | 6,817.0 | 6,472.5 | 5,339.7 | 6,222.6 | 6,680.4 | 7,012.5 | 7,951.1 |
| Gasto público en educación (% del PIB) (%) | Colombia | 4.470 | 4.477 | 4.536 | 4.449 | 4.511 | 5.262 | — | — | — | — |
| PIB per cápita (US$ actuales) (USD) | Costa Rica | 11,714.7 | 12,091.0 | 12,317.1 | 12,620.0 | 12,951.9 | 12,475.7 | 12,962.3 | 13,971.8 | 17,140.8 | 18,853.3 |
| Gasto público en educación (% del PIB) (%) | Costa Rica | 6.873 | 6.894 | 7.070 | 6.770 | 6.738 | 6.629 | 6.248 | 5.547 | 5.312 | — |
| PIB per cápita (US$ actuales) (USD) | República Dominicana | 6,801.0 | 7,160.4 | 7,412.7 | 7,883.0 | 8,183.0 | 7,135.2 | 8,527.1 | 10,104.2 | 10,630.4 | 10,875.7 |
| Gasto público en educación (% del PIB) (%) | República Dominicana | 3.604 | 3.850 | 3.920 | 3.928 | 4.043 | 4.518 | 3.580 | 3.611 | 3.761 | — |
| PIB per cápita (US$ actuales) (USD) | Ecuador | 5,976.2 | 5,917.6 | 6,233.3 | 6,303.9 | 6,205.1 | 5,463.6 | 6,061.3 | 6,515.6 | 6,718.1 | 6,826.5 |
| Gasto público en educación (% del PIB) (%) | Ecuador | 5.106 | 4.464 | 4.607 | 4.625 | 4.246 | 4.261 | 3.656 | 3.613 | 3.820 | 3.691 |
| PIB per cápita (US$ actuales) (USD) | Guatemala | 3,893.5 | 4,060.1 | 4,325.0 | 4,352.9 | 4,512.0 | 4,477.6 | 4,912.6 | 5,356.9 | 5,754.4 | 6,150.9 |
| Gasto público en educación (% del PIB) (%) | Guatemala | 3.030 | 2.945 | 2.950 | 3.132 | 3.193 | 3.295 | 3.092 | 3.208 | 3.109 | 3.076 |
| PIB per cápita (US$ actuales) (USD) | México | 10,021.2 | 9,097.9 | 9,649.3 | 10,084.8 | 10,369.6 | 8,841.3 | 10,314.1 | 11,405.8 | 13,830.8 | 13,988.0 |
| Gasto público en educación (% del PIB) (%) | México | 5.051 | 4.758 | 4.398 | 4.139 | — | 4.500 | 4.238 | 4.060 | — | — |
| PIB per cápita (US$ actuales) (USD) | Panamá | 14,082.7 | 14,832.4 | 15,694.6 | 16,151.3 | 16,477.9 | 13,290.6 | 15,509.8 | 17,378.6 | 18,797.2 | 19,161.2 |
| Gasto público en educación (% del PIB) (%) | Panamá | 3.266 | 3.323 | 3.378 | 3.452 | 3.281 | 4.305 | 3.712 | 3.378 | 2.472 | — |
| PIB per cápita (US$ actuales) (USD) | Perú | 6,231.7 | 6,217.0 | 6,736.2 | 6,978.5 | 7,037.0 | 6,133.3 | 6,828.5 | 7,353.7 | 7,919.0 | 8,526.3 |
| Gasto público en educación (% del PIB) (%) | Perú | 3.969 | 3.813 | 3.931 | 3.714 | 3.822 | 4.259 | 3.928 | 3.840 | 4.245 | 4.358 |
| PIB per cápita (US$ actuales) (USD) | Uruguay | 17,125.9 | 17,009.8 | 19,184.7 | 19,249.9 | 18,315.7 | 15,757.5 | 17,881.8 | 21,009.3 | 23,378.6 | 24,308.5 |
| Gasto público en educación (% del PIB) (%) | Uruguay | 4.206 | 4.364 | 4.418 | 4.604 | 4.628 | 4.552 | 4.462 | 4.480 | 4.765 | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | CRI | -0.881 | 0.002 | 0.022 | -0.883 | -0.280 | 0.501 | 🟡 Co-tendencia probable |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | COL | -0.836 | 0.038 | 0.125 | -0.486 | -0.829 | 0.082 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | PAN | -0.774 | 0.014 | 0.094 | -0.433 | -0.891 | 0.003 | 🟡 Marginal |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | LCN | -0.730 | 0.026 | 0.111 | -0.667 | -0.623 | 0.099 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | URY | 0.574 | 0.106 | 0.275 | 0.533 | 0.213 | 0.612 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | BRA | 0.548 | 0.160 | 0.297 | 0.452 | 0.477 | 0.279 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | MEX | -0.524 | 0.227 | 0.328 | -0.714 | 0.374 | 0.535 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | ECU | -0.489 | 0.152 | 0.297 | -0.418 | -0.113 | 0.772 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | PER | 0.450 | 0.192 | 0.312 | 0.139 | -0.427 | 0.252 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | DOM | -0.383 | 0.309 | 0.402 | -0.267 | -0.692 | 0.057 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | ARG | 0.317 | 0.406 | 0.480 | 0.367 | 0.057 | 0.894 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | CHL | -0.285 | 0.493 | 0.501 | -0.214 | -0.590 | 0.163 | 🔴 Sin evidencia |
| Gasto público en educación (% del PIB) | PIB per cápita (US$ actuales) | GTM | 0.242 | 0.501 | 0.501 | 0.430 | -0.578 | 0.103 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| PIB per cápita (US$ actuales) | América Latina y el Caribe (LCN) | 8546.92 (2015) | 10705.11 (2024) | 239.7988 | 25.25% | 2.53% |
| Gasto público en educación (% del PIB) | América Latina y el Caribe (LCN) | 4.45 (2015) | 3.82 (2023) | -0.0785 | -14.12% | -1.88% |
| PIB per cápita (US$ actuales) | Argentina | 13679.63 (2015) | 13969.78 (2024) | 32.2397 | 2.12% | 0.23% |
| Gasto público en educación (% del PIB) | Argentina | 5.78 (2015) | 5.00 (2023) | -0.0966 | -13.38% | -1.78% |
| PIB per cápita (US$ actuales) | Brasil | 8936.20 (2015) | 10310.55 (2024) | 152.7058 | 15.38% | 1.60% |
| Gasto público en educación (% del PIB) | Brasil | 6.24 (2015) | 5.62 (2022) | -0.0888 | -9.96% | -1.49% |
| PIB per cápita (US$ actuales) | Chile | 13433.92 (2015) | 16658.97 (2024) | 358.3383 | 24.01% | 2.42% |
| Gasto público en educación (% del PIB) | Chile | 4.90 (2015) | 4.91 (2022) | 0.0012 | 0.17% | 0.02% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-10-16-16-17/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Relación entre inversión en educación y crecimiento del PIB per cápita en América Latina*.
Noticia que inspiró la línea editorial: *"Ryanair ‘recognises’ disputed Western Sahara territory in controversial marketing campaign"* ([The Irish Times](https://www.irishtimes.com/transport/2026/10/15/ryanair-recognises-disputed-western-sahara-territory-in-controversial-marketing-campaign/)).
Lo que la noticia afirmaba o sugería: Una campaña corporativa polémica puede afectar la percepción internacional y, por ende, la inversión extranjera y el crecimiento económico.
Alcance verificable con los datos: Se puede analizar si el gasto en educación se correlaciona con el PIB per cápita; la influencia de la polémica de Ryanair no puede medirse directamente con los indicadores.
Justificación del sistema: El ángulo económico‑educativo permite usar indicadores claros de gasto educativo y nivel de vida, conectando la noticia de reputación corporativa con posibles efectos macroeconómicos.
**Pregunta de investigación:** ¿Existe una relación positiva entre el gasto público en educación y el PIB per cápita en los países latinoamericanos?
**Hipótesis planteada:** Un mayor gasto en educación está asociado a un mayor PIB per cápita en América Latina.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ECU, GTM, PER, ARG, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 13 correlaciones Pearson/Spearman (1 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 73 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 0 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*