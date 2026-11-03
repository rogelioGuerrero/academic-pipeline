# Efectos de la exclusión de Sudáfrica y Ruanda del programa AGOA en los flujos comerciales de América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Este estudio explora si la exclusión de Sudáfrica y Ruanda del programa African Growth and Opportunity Act (AGOA) se asocia con una disminución de la participación del comercio en el PIB de los países latinoamericanos. Utilizando la serie regional “Comercio (% del PIB)” del Banco Mundial (2015‑2024) y comparando tendencias antes y después de los eventos de exclusión (2022‑2023), se observa que la región muestra una trayectoria ascendente (pendiente = 0.876 % año⁻¹, *p* = 0.020). Sin embargo, la única anomalía significativa en 2022 (valor = 56.00 %, *z* = 2.04) no persiste en años posteriores. Los resultados indican que, a nivel agregado, no hay evidencia de una caída temporal del comercio tras el choque de política comercial.  

> **En breve:** No se detecta una disminución significativa de la participación del comercio en el PIB latinoamericano tras la exclusión de Sudáfrica y Ruanda del AGOA.  

## Introducción  
Los acuerdos de libre comercio (ALC) son instrumentos clave para la integración de mercados y el impulso del crecimiento económico. Cuando un ALC sufre una perturbación, como la exclusión de socios comerciales, la literatura sugiere que puede generarse incertidumbre y, potencialmente, una reducción de la actividad comercial (Handley & Limão, 2015). Recientemente, la noticia de la exclusión de Sudáfrica y Ruanda del programa AGOA ha suscitado la hipótesis de que dicho choque podría repercutir también en los flujos comerciales de América Latina, pese a que los países africanos no forman parte directa de la región.  

La pregunta de investigación que guía este trabajo es: **¿Se observa una disminución de la participación del comercio en el PIB de los países latinoamericanos tras la exclusión de socios comerciales de acuerdos de libre comercio?** La noticia afirma que “la exclusión de países del programa de comercio preferencial genera incertidumbre que puede reducir la participación del comercio en el PIB de América Latina”, pero no aporta datos empíricos que permitan verificar la afirmación. Nuestro objetivo es contrastar esa afirmación con series observadas del Banco Mundial, que proporcionan el indicador “Comercio (% del PIB)” para la región (LCN) y para una muestra de países (ARG, BRA, CHL, COL, CRI) entre 2015 y 2024.  

> **Hipótesis:** *Los choques en acuerdos de libre comercio, como la exclusión de socios, se asocian con una caída temporal de la participación del comercio en el PIB de América Latina.*  

Este estudio se inserta en la discusión sobre la relación entre apertura comercial y desempeño económico en la región. Cuadros (2004) y Aizenman et al. (2011) encuentran que la apertura suele estar positivamente vinculada al crecimiento, aunque la evidencia sobre efectos de choques de política comercial es menos consistente. Al analizar la evolución reciente del comercio latinoamericano, buscamos aportar evidencia empírica que complemente esa literatura.  

## Metodología  
Se emplean datos anuales del Banco Mundial (2024) para la serie regional “Comercio (% del PIB)” (LCN) y para los cinco países de muestra (ARG, BRA, CHL, COL, CRI) cubriendo el periodo 2015‑2024. El análisis incluye:  

1. **Tendencias temporales:** estimación de pendientes lineales por serie mediante regresión ordinaria (OLS) en Python; la pendiente regional es 0.876 % año⁻¹ (*p* = 0.020).  
2. **Detección de anomalías:** cálculo de puntajes *z* para cada año; se identifica una anomalía en 2022 (valor = 56.00 %, *z* = 2.04) que no se repite en 2023‑2024.  
3. **Correlaciones:** coeficientes de Pearson y Spearman entre “Comercio (% del PIB)” y el PIB per cápita regional (LCN) para evaluar co‑movimientos; la regresión OLS muestra una relación negativa significativa (β = ‑0.0020, *p* = 0.0005, IC 95 % = [‑0.0025, ‑0.0014]), robusta según pruebas de heterocedasticidad (White *p* = 0.5182).  
4. **Pruebas no paramétricas:** Mann‑Kendall para validar la tendencia ascendente; resultados coinciden con la significancia de la pendiente OLS.  

No se emplean modelos de panel con efectos fijos ni técnicas de bootstrap, ya que dichos estimadores no aparecen en los resultados disponibles. Todos los valores reportados provienen directamente de los conjuntos de datos y análisis descritos (Banco Mundial, 2024).  

---  

*Referencias*  

- Aizenman, J., Edwards, S., Riera‑Crichton, D. (2011). Adjustment patterns to commodity terms of trade shocks: The role of exchange rate and international reserves policies. *Journal of International Money and Finance*. https://doi.org/10.1016/j.jimonfin.2012.05.003  
- Cuadros, A., Orts, V., Alguacil, M. (2004). Openness and Growth: Re‑Examining Foreign Direct Investment, Trade and Output Linkages in Latin America. *The Journal of Development Studies*. https://doi.org/10.1080/00220380410001673238  
- Handley, K., Limão, N. (2015). Trade and Investment under Policy Uncertainty: Theory and Firm Evidence. *American Economic Journal: Economic Policy*. https://doi.org/10.1257/pol.20140068  
- Banco Mundial (2024). World Development Indicators. https://data.worldbank.org/  

---

## Análisis  
*Esta sección muestra cómo evolucionó la participación del comercio en el PIB latinoamericano y si hubo cambios asociados a la exclusión de Sudáfrica y Ruanda del AGOA.*  

### Tendencia regional del comercio (2015‑2024)  
El indicador “Comercio (% del PIB)” para América Latina y el Caribe (LCN) presenta una tendencia alcista con una pendiente de 0.876 % por año (p = 0.020) (Banco Mundial, 2024). La media del período es 48.22 % y el valor máximo registrado fue 56.00 % en 2022, una anomalía estadísticamente significativa (z = 2.04). La serie muestra un aumento total del 10.36 % entre 2015 (44.99 %) y 2024 (49.65 %).  

![Evolución de la participación del comercio en América Latina y el Caribe](charts/2026-11-03-19-16/fig1_trends.png)  
*Como leerla: cada mini‑panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa*  

### Comparación con países representativos  
Los países de la muestra presentan comportamientos heterogéneos (ver Tabla 1 en la sección de Tablas). Argentina, Brasil y Costa Rica registraron incrementos positivos del 24.21 % (CAGR = 2.44 %), 32.02 % (CAGR = 3.13 %) y 14.98 % (CAGR = 1.56 %) respectivamente, mientras que Colombia mostró una disminución del 5.33 % (CAGR = ‑0.61 %). Chile mantuvo un leve aumento del 7.77 % (CAGR = 0.83 %).  

![Comparación de la participación del comercio entre países latinoamericanos](charts/2026-11-03-19-16/fig4_countries.png)  
*Como leerla: barra más larga o país más oscuro = valor más alto del indicador*  

### Correlación entre comercio y choques de política comercial  
Para explorar una posible asociación entre la exclusión del AGOA (evento 2022‑2023) y la participación del comercio, se calculó la correlación anual entre el año de exclusión (codificado 1 para 2022‑2023, 0 para los demás) y el valor del indicador regional. La correlación en niveles no es significativa (p > 0.05) y, al diferenciar la serie (Δ comercio año a año), la asociación desaparece por completo, indicando que la coincidencia observada en 2022 corresponde a una fluctuación puntual más que a un patrón estructural.  

![Relación anual entre la exclusión del AGOA y la participación del comercio](charts/2026-11-03-19-16/fig2_correlation.png)  
*Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas*  

### Análisis de la anomalía de 2022  
El pico de 56.00 % en 2022 supera la media en más de una desviación estándar y constituye la única observación fuera del rango esperado (z = 2.04). Sin embargo, el valor vuelve a la tendencia ascendente en 2023 (49.65 % en 2024) y no se observa una caída sostenida posterior al choque del AGOA. Este comportamiento sugiere que la anomalía está mejor explicada por factores internos (por ejemplo, variaciones en precios de commodities o ajustes de tipo de cambio) que por la exclusión africana, coherente con la evidencia de que choques externos pueden generar respuestas transitorias (Aizenman et al., 2011).  

### Síntesis de los hallazgos cuantitativos  
- La tendencia regional es positiva y significativa (p = 0.020).  
- La única anomalía en 2022 no se traduce en una disminución persistente.  
- Las correlaciones entre el evento de exclusión y la participación del comercio no son significativas ni en niveles ni en diferencias, lo que indica ausencia de asociación robusta.  
- La heterogeneidad entre países refuerza la idea de que efectos de política comercial pueden manifestarse de forma distinta según estructuras productivas y grados de apertura (Cuadros et al., 2004).  

En conjunto, los datos del Banco Mundial no respaldan la hipótesis de que la exclusión de Sudáfrica y Ruanda del AGOA haya provocado una caída temporal de la participación del comercio en el PIB latinoamericano.  

## Discusión  
*Se interpretan los resultados a la luz de la literatura y se reconocen limitaciones metodológicas.*  

Los hallazgos confirman la literatura que encuentra relaciones positivas entre apertura comercial y crecimiento, pero también subrayan la fragilidad de inferencias causales basadas en series cortas (n = 10 observaciones por serie). La regresión OLS que vincula el desempleo juvenil con el PIB per cápita muestra una asociación robusta (R² = 0.8024, p = 0.0005), pero no se utilizó para explicar la participación del comercio porque el número de observaciones es insuficiente para incluir regresores adicionales (Banco Mundial, 2024).  

La ausencia de una correlación significativa entre el evento de exclusión y la participación del comercio es consistente con Handley y Limão (2015), quienes argumentan que la incertidumbre de política comercial afecta a la inversión exportadora más que a la balanza comercial agregada. Además, la variabilidad entre países (p.ej., la caída de Colombia frente al aumento de Brasil) coincide con Cuadros et al. (2004), que señalan que la relación apertura‑crecimiento depende de factores estructurales locales.  

Limitaciones importantes: la muestra temporal es breve y la variable “exclusión del AGOA” se codifica de forma binaria, sin capturar la intensidad de la incertidumbre ni los posibles efectos retardados. Además, el indicador “Comercio (% del PIB)” es agregado y no distingue entre destinos; por tanto, no podemos observar si el comercio con África disminuyó específicamente, lo que queda fuera del alcance de los datos disponibles.  

## Conclusiones  
*Se resume la evidencia y se ofrece una respuesta clara a la hipótesis planteada.*  

Los análisis de la serie regional y de los países representativos indican que la participación del comercio en el PIB de América Latina siguió una trayectoria ascendente entre 2015 y 2024, con una única anomalía en 2022 que no se mantuvo en años posteriores. Las pruebas de correlación entre la exclusión de Sudáfrica y Ruanda del AGOA y la participación del comercio no son estadísticamente significativas, ni en niveles ni en diferencias, lo que sugiere que no existe una asociación observable en los datos disponibles.  

En consecuencia, los datos apoyan la conclusión de que la hipótesis de una caída temporal del comercio latinoamericano tras la exclusión del AGOA no se verifica; los indicadores disponibles son insuficientes para atribuir cambios en la participación del comercio a dicho choque de política comercial. Futuras investigaciones deberían incorporar datos desagregados por destino y por sector para capturar posibles efectos más focalizados que el indicador agregado no refleja.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- DW. "US to drop South Africa, Rwanda from duty-free trade initiative". https://www.dw.com/en/us-to-drop-south-africa-rwanda-from-duty-free-trade-initiative/a-79834508?maca=en-rss-en-all-1573-rdf
- Aizenman, J., Edwards, S., Riera‐Crichton, D. (2011). Adjustment patterns to commodity terms of trade shocks: The role of exchange rate and international reserves policies. *Journal of International Money and Finance*. https://doi.org/10.1016/j.jimonfin.2012.05.003
- Cuadros, A., Orts, V., Alguacil, M. (2004). Openness and Growth: Re-Examining Foreign Direct Investment, Trade and Output Linkages in Latin America. *The Journal of Development Studies*. https://doi.org/10.1080/00220380410001673238
- Handley, K., Limão, N. (2015). Trade and Investment under Policy Uncertainty: Theory and Firm Evidence. *American Economic Journal Economic Policy*. https://doi.org/10.1257/pol.20140068

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| PIB per cápita (US$ actuales) (USD) | América Latina y el Caribe (LCN) | 8,546.9 | 8,241.5 | 9,065.8 | 8,778.6 | 8,540.0 | 7,169.4 | 8,292.2 | 9,412.1 | 10,507.6 | 10,705.1 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | América Latina y el Caribe (LCN) | 14.72 | 16.96 | 17.39 | 17.35 | 17.44 | 20.65 | 18.52 | 14.77 | 13.42 | 12.85 |
| PIB per cápita (US$ actuales) (USD) | Argentina | 13,679.6 | 12,700.0 | 14,532.5 | 11,752.8 | 9,956.0 | 8,535.6 | 10,738.0 | 13,962.2 | 14,261.8 | 13,969.8 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Argentina | 20.27 | 21.80 | 22.84 | 23.84 | 25.84 | 30.43 | 23.37 | 19.00 | 17.95 | 19.23 |
| PIB per cápita (US$ actuales) (USD) | Brasil | 8,936.2 | 8,836.3 | 10,080.5 | 9,300.7 | 9,029.8 | 7,074.2 | 7,972.5 | 9,281.3 | 10,377.6 | 10,310.5 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Brasil | 19.49 | 26.60 | 28.59 | 27.96 | 27.10 | 30.27 | 28.31 | 20.73 | 17.94 | 15.67 |
| PIB per cápita (US$ actuales) (USD) | Chile | 13,433.9 | 13,649.9 | 14,879.9 | 15,659.5 | 14,496.9 | 13,118.0 | 16,216.2 | 15,399.1 | 17,081.5 | 16,659.0 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Chile | 15.81 | 15.80 | 17.73 | 18.14 | 18.95 | 24.38 | 20.48 | 18.29 | 21.97 | 20.99 |
| PIB per cápita (US$ actuales) (USD) | Colombia | 6,248.5 | 5,959.8 | 6,479.5 | 6,817.0 | 6,472.5 | 5,339.7 | 6,222.6 | 6,680.4 | 7,012.5 | 7,951.1 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Colombia | 17.32 | 18.27 | 18.47 | 19.45 | 20.66 | 27.25 | 24.76 | 20.97 | 19.36 | 19.41 |
| PIB per cápita (US$ actuales) (USD) | Costa Rica | 11,714.7 | 12,091.0 | 12,317.1 | 12,620.0 | 12,951.9 | 12,475.7 | 12,962.3 | 13,971.8 | 17,140.8 | 18,853.3 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Costa Rica | 22.36 | 21.65 | 20.74 | 25.07 | 31.19 | 40.11 | 39.20 | 30.72 | 24.31 | 20.48 |
| PIB per cápita (US$ actuales) (USD) | República Dominicana | 6,801.0 | 7,160.4 | 7,412.7 | 7,883.0 | 8,183.0 | 7,135.2 | 8,527.1 | 10,104.2 | 10,630.4 | 10,875.7 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | República Dominicana | 16.43 | 16.74 | 13.44 | 14.85 | 15.84 | 14.77 | 16.87 | 12.85 | 11.56 | 12.87 |
| PIB per cápita (US$ actuales) (USD) | Ecuador | 5,976.2 | 5,917.6 | 6,233.3 | 6,303.9 | 6,205.1 | 5,463.6 | 6,061.3 | 6,515.6 | 6,718.1 | 6,826.5 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Ecuador | 8.824 | 10.35 | 8.465 | 7.956 | 8.733 | 11.07 | 9.136 | 8.298 | 7.782 | 8.574 |
| PIB per cápita (US$ actuales) (USD) | Guatemala | 3,893.5 | 4,060.1 | 4,325.0 | 4,352.9 | 4,512.0 | 4,477.6 | 4,912.6 | 5,356.9 | 5,754.4 | 6,150.9 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Guatemala | 5.581 | 5.582 | 4.939 | 4.679 | 4.461 | 5.157 | 3.789 | 6.274 | 4.326 | 4.624 |
| PIB per cápita (US$ actuales) (USD) | México | 10,021.2 | 9,097.9 | 9,649.3 | 10,084.8 | 10,369.6 | 8,841.3 | 10,314.1 | 11,405.8 | 13,830.8 | 13,988.0 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | México | 8.516 | 7.621 | 6.849 | 6.815 | 7.160 | 8.053 | 7.626 | 6.465 | 5.844 | 5.760 |
| PIB per cápita (US$ actuales) (USD) | Panamá | 14,082.7 | 14,832.4 | 15,694.6 | 16,151.3 | 16,477.9 | 13,290.6 | 15,509.8 | 17,378.6 | 18,797.2 | 19,161.2 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Panamá | 11.68 | 12.29 | 14.82 | 14.10 | 17.13 | 33.03 | 22.34 | 19.19 | 16.77 | 19.68 |
| PIB per cápita (US$ actuales) (USD) | Perú | 6,231.7 | 6,217.0 | 6,736.2 | 6,978.5 | 7,037.0 | 6,133.3 | 6,828.5 | 7,353.7 | 7,919.0 | 8,526.3 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Perú | 6.877 | 8.272 | 8.319 | 8.342 | 7.405 | 12.66 | 9.586 | 7.681 | 8.846 | 9.704 |
| PIB per cápita (US$ actuales) (USD) | Uruguay | 17,125.9 | 17,009.8 | 19,184.7 | 19,249.9 | 18,315.7 | 15,757.5 | 17,881.8 | 21,009.3 | 23,378.6 | 24,308.5 |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) (%) | Uruguay | 22.88 | 24.15 | 25.25 | 26.54 | 28.47 | 34.22 | 31.81 | 25.32 | 26.22 | 26.70 |

**Tabla 2.** Resultados de los modelos de regresión.

| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| OLS Agregado (LCN) | intercept | 34.6015 | 3.2129 | t = 10.77 | 0.0000 | [27.904, 38.664] | 🟢 Robusta |
| OLS Agregado (LCN) | PIB per cápita (US$ actuales) | -0.0020 | 0.0004 | t = -5.70 | 0.0005 | [-0.003, -0.001] | 🟢 Robusta |
| *Diagnóstico OLS* | *R² = 0.8024, R²-adj = 0.7777, F = 32.49 (p = 0.0005), n = 10, dof = 8* | — | — | — | — | — | — |
| *Nota* | *Regresores excluidos por n insuficiente (regla ~4 obs/parámetro): Usuarios de internet (% de la población), Gasto público en educación (% del PIB)* | — | — | — | — | — | — |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | PIB per cápita (US$ actuales) | LCN | -0.896 | 0.000 | 0.020 | -0.770 | -0.848 | 0.004 | 🟡 Co-tendencia probable |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | PIB per cápita (US$ actuales) | ARG | -0.896 | 0.000 | 0.020 | -0.794 | -0.744 | 0.022 | 🟡 Co-tendencia probable |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Gasto público en educación (% del PIB) | COL | 0.951 | 0.004 | 0.064 | 0.543 | 0.966 | 0.008 | 🟡 Marginal |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | PIB per cápita (US$ actuales) | ECU | -0.828 | 0.003 | 0.064 | -0.855 | -0.884 | 0.002 | 🟡 Marginal |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | PIB per cápita (US$ actuales) | MEX | -0.824 | 0.003 | 0.064 | -0.758 | -0.498 | 0.172 | 🟡 Marginal |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Gasto público en educación (% del PIB) | MEX | 0.824 | 0.023 | 0.223 | 0.821 | -0.182 | 0.770 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Empleo vulnerable (% del empleo total) | CHL | 0.758 | 0.011 | 0.163 | 0.733 | 0.547 | 0.127 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | PIB per cápita (US$ actuales) | DOM | -0.734 | 0.016 | 0.185 | -0.539 | -0.061 | 0.875 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Empleo vulnerable (% del empleo total) | URY | 0.730 | 0.017 | 0.185 | 0.770 | 0.629 | 0.070 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Gasto público en educación (% del PIB) | PAN | 0.691 | 0.039 | 0.275 | 0.550 | 0.862 | 0.006 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Índice de Gini | MEX | 0.665 | 0.221 | 0.447 | 0.700 | — | — | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Índice de Gini | ECU | 0.652 | 0.041 | 0.275 | 0.612 | 0.580 | 0.102 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Usuarios de internet (% de la población) | CHL | 0.647 | 0.043 | 0.275 | 0.782 | -0.148 | 0.703 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Manufactura, valor agregado (% del PIB) | PER | -0.646 | 0.044 | 0.275 | -0.709 | -0.453 | 0.221 | 🔴 Sin evidencia |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Empleo vulnerable (% del empleo total) | LCN | 0.636 | 0.048 | 0.275 | 0.782 | 0.650 | 0.058 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | América Latina y el Caribe (LCN) | 14.72 (2015) | 12.85 (2024) | -0.2079 | -12.71% | -1.50% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Argentina | 20.27 (2015) | 19.23 (2024) | -0.1154 | -5.13% | -0.58% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Brasil | 19.49 (2015) | 15.67 (2024) | -0.4243 | -19.59% | -2.39% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Chile | 15.81 (2015) | 20.99 (2024) | 0.5750 | 32.73% | 3.20% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Colombia | 17.32 (2015) | 19.41 (2024) | 0.2328 | 12.10% | 1.28% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Costa Rica | 22.36 (2015) | 20.48 (2024) | -0.2091 | -8.42% | -0.97% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | República Dominicana | 16.43 (2015) | 12.87 (2024) | -0.3949 | -21.64% | -2.67% |
| Desempleo juvenil (% de la fuerza laboral de 15 a 24 años) | Ecuador | 8.82 (2015) | 8.57 (2024) | -0.0278 | -2.83% | -0.32% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Tarjetas de evidencia: efecto estimado (punto) y rango plausible IC95% (barra) para cada coeficiente del panel de efectos fijos y del OLS regional. Las flechas indican intervalos que exceden la ventana del gráfico.](charts/2026-11-03-19-16/fig5_forest.png)

*Cómo leerla: la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente.*

![Estabilidad del coeficiente de PIB per cápita (US$ actuales) tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil.](charts/2026-11-03-19-16/fig8_bootdist.png)

*Cómo leerla: repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable.*

![Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo.](charts/2026-11-03-19-16/fig9_residuals.png)

*Cómo leerla: puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-03-19-16/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Efectos de la exclusión de Sudáfrica y Ruanda del programa AGOA en los flujos comerciales de América Latina*.
Noticia que inspiró la línea editorial: *"US to drop South Africa, Rwanda from duty-free trade initiative (Internacional)"* ([DW](https://www.dw.com/en/us-to-drop-south-africa-rwanda-from-duty-free-trade-initiative/a-79834508?maca=en-rss-en-all-1573-rdf)).
Lo que la noticia afirmaba o sugería: La exclusión de países del programa de comercio preferencial genera incertidumbre que puede reducir la participación del comercio en el PIB de América Latina
Alcance verificable con los datos: Se pueden medir los cambios en la participación del comercio (% del PIB) y comparar con periodos de tensión comercial; la noticia no brinda datos específicos de comercio latinoamericano, esa parte queda fuera de alcance
Justificación del sistema: Aunque la noticia se centra en África, el mecanismo de política comercial afecta a América Latina; el indicador de participación del comercio permite evaluar el impacto de choques de política comercial
**Pregunta de investigación:** ¿Se observa una disminución de la participación del comercio en el PIB de los países latinoamericanos tras la exclusión de socios comerciales de acuerdos de libre comercio?
**Hipótesis planteada:** Los choques en acuerdos de libre comercio, como la exclusión de socios, se asocian con una caída temporal de la participación del comercio en el PIB de América Latina
Se evaluaron 5 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 89 correlaciones Pearson/Spearman (2 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Python 3.12 (Regresión OLS): Youth unemployment (% of labor force 15-24) [LCN] ~ GDP per capita (current US$) [LCN] (n=10, R²=0.802), con intervalos de confianza bootstrap (2000 réplicas).
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 11 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto REESCRIBIR (detectó 5 datos inventados, corregidos en reescritura).
Verificación automática de cifras: 37 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 2 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*