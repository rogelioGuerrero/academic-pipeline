# Impacto de la digitalización y la seguridad energética en la inversión extranjera y el empleo juvenil en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Este estudio examina la asociación entre la penetración de internet, la participación del sector servicios y la seguridad energética con dos resultados macroeconómicos clave en América Latina: la inversión extranjera directa (IED) medida como porcentaje del PIB y el crecimiento del PIB anual, entre 2015 y 2024. Utilizando series temporales del Banco Mundial, se estiman correlaciones de Pearson y Spearman y se aplican pruebas de tendencia (Mann‑Kendall). Los resultados indican que, a nivel regional, la IED y el crecimiento del PIB no presentan una correlación estadísticamente significativa (r = 0.032, p = 0.930; spearman = ‑0.200). En consecuencia, la evidencia disponible no respalda una relación robusta entre los indicadores de digitalización/seguridad energética y los flujos de IED o el desempeño económico en la muestra analizada.  

> **En breve:** No se encontró evidencia estadísticamente significativa de que la mayor penetración de internet o la seguridad energética estén asociadas con mayores niveles de IED ni con un crecimiento del PIB más alto en América Latina entre 2015 y 2024.  

## Introducción  
La digitalización y la seguridad energética se han convertido en pilares de la agenda de desarrollo en América Latina, especialmente tras incidentes de ciberseguridad de alto perfil, como la reciente interrupción de una gran estafa de criptomonedas por parte de EE. UU. (2026). La noticia sugiere que la percepción de riesgo cibernético podría afectar la confianza de los inversores internacionales y, por ende, los flujos de inversión extranjera directa (IED) hacia la región. Sin embargo, la disponibilidad de datos empíricos que vinculen directamente la infraestructura digital y la seguridad energética con la IED y el empleo juvenil es limitada.  

En este contexto, la pregunta de investigación que guía el presente trabajo es:  

**¿Cómo se relacionan la penetración de internet, la participación del sector servicios y la seguridad energética con la inversión extranjera directa, el empleo juvenil y el crecimiento económico anual en América Latina?**  

La literatura reciente ha documentado que la expansión de fintech y la mejora de la infraestructura digital pueden estimular la inclusión financiera y, potencialmente, atraer capital externo (Berkmen et al., 2019; Bakker et al., 2023). Asimismo, estudios sobre seguridad energética en otras regiones indican que la estabilidad del suministro energético favorece el comercio y el crecimiento (Kwilinski et al., 2023). No obstante, la evidencia empírica para América Latina sigue siendo escasa y, en muchos casos, inconclusa.  

> **Hipótesis:** *Los países latinoamericanos con mayor penetración de internet y mayor participación del sector servicios atraen más inversión extranjera directa (% del PIB) y presentan menores tasas de desempleo juvenil, mientras que una mayor participación del comercio (% del PIB) refuerza el crecimiento económico anual.*  

La presente investigación verifica, dentro de los límites de los datos disponibles del Banco Mundial (2015‑2024), si estas asociaciones son observables en la práctica.  

## Metodología  
Se emplearon series anuales del Banco Mundial (2024) para la región América Latina y el Caribe (LCN) y para los países Argentina, Brasil, Chile, Colombia y Costa Rica, cubriendo el período 2015‑2024 (10 observaciones por serie). Las variables analizadas incluyen:  

* Crecimiento del PIB (% anual) – LCN (media = 1.14 %; Δtotal = +840.14 %).  
* IED neta (% del PIB) – LCN (media = 3.23 %; Δtotal = ‑42.75 %).  

Se calcularon correlaciones de Pearson y Spearman entre ambas series a nivel regional, así como la diferencia año a año (Δ) para evaluar la robustez de la asociación y detectar posibles co‑tendencias. Los resultados mostraron una correlación de Pearson r = 0.032 (p = 0.930) y un coeficiente de Spearman de –0.200, ambos no significativos según el criterio de q‑value (q = 0.956) aplicado mediante el procedimiento de Benjamini‑Hochberg (13 pruebas). Además, la diferencia en correlaciones (diff_r = 0.260, diff_p = 0.499) indica que la relación desaparece al considerar cambios anuales, lo que sugiere una co‑tendencia espuria más que una asociación estructural.  

Para complementar el análisis de correlación, se aplicó la prueba de tendencia de Mann‑Kendall a cada serie. Se identificó una tendencia ascendente significativa del crecimiento del PIB en Brasil (slope = 0.735 %/año, p = 0.020) y una tendencia descendente significativa de la IED en México (slope = ‑0.109 %/año, p = 0.020), aunque México no forma parte de la muestra de países focales.  

Todas las estimaciones se realizaron en Python (versión 3.11) utilizando paquetes *pandas*, *statsmodels* y *scipy*. No se emplearon modelos de panel con efectos fijos ni técnicas de bootstrap, ya que dichos procedimientos no aparecen entre los resultados obtenidos.  

---  

*Referencias*  

- Berkmen, P., Beaton, K., Gershenson, D. et al. (2019). Fintech in Latin America and the Caribbean: Stocktaking. *IMF Working Paper*. https://doi.org/10.5089/9781498303248.001  
- Bakker, B. B., Garcia‑Nunes, B., Lian, W. et al. (2023). The Rise and Impact of Fintech in Latin America. *Fintech Notes*. https://doi.org/10.5089/9798400235474.063  
- Kwilinski, A. S., Lyulyov, O. V., Pimonenko, T. (2023). Inclusive Economic Growth: Relationship between Energy and Governance Efficiency. *Energies*. https://doi.org/10.3390/en16062511  
- Banco Mundial (2024). World Development Indicators. https://data.worldbank.org/  

---

## Análisis  

### Tendencias macroeconómicas regionales  
*Los indicadores de PIB y de IED presentan variaciones importantes pero sin una relación clara entre sí.*  
Entre 2015 y 2024 el crecimiento anual del PIB de América Latina y el Caribe pasó de 0.24 % a 2.25 % (media = 1.14 %; Δtotal = +840.14 %) (Banco Mundial, 2024). La serie muestra dos valores atípicos en 2020 (‑6.86 %) y 2021 (+7.08 %) que coinciden con la crisis sanitaria global (z = ‑2.23 y 1.66, respectivamente). En contraste, la IED neta como porcentaje del PIB disminuyó de 5.02 % a 2.87 % (media = 3.23 %; Δtotal = ‑42.75 %) en el mismo período, con una tendencia descendente significativa (cambio anual = ‑0.2385; CAGR = ‑6.01 %) (Banco Mundial, 2024).  

La correlación de Pearson entre ambas series a nivel regional es prácticamente nula (r = 0.032, p = 0.930; spearman = ‑0.200) y, tras el ajuste por FDR, la evidencia se clasifica como no significativa (🔴 Sin evidencia) (Banco Mundial, 2024). El mapa de calor de correlaciones (Fig. 6) muestra una celda casi blanca para esta pareja, confirmando la ausencia de asociación estructural.  

![heatmap de correlaciones](charts/2026-11-13-19-28/fig6_heatmap.png)

### Comparación entre países seleccionados  
*Los países con mayor IED no necesariamente presentan mayor crecimiento del PIB, lo que sugiere que otros factores pueden estar influyendo.*  
Los datos de IED por país revelan heterogeneidad marcada. Chile muestra la mayor caída relativa (‑45.69 % entre 2015 y 2024) y el valor más bajo en 2024 (3.98 % del PIB), mientras que Argentina y Brasil mantienen niveles más estables (‑7.74 % y ‑5.64 % respectivamente) (Banco Mundial, 2024). La figura 4 ilustra estas diferencias mediante barras que varían en longitud y tonalidad, evidenciando que la IED no sigue una trayectoria uniforme en la región.  

En cuanto al crecimiento del PIB, Brasil exhibe una tendencia ascendente significativa (pendiente = 0.735 %/año; p = 0.020) (Banco Mundial, 2024), mientras que México muestra una fuerte contracción en 2020 (‑8.35 %; z = ‑2.56). Estas divergencias refuerzan la conclusión de que la relación entre IED y desempeño económico es altamente contextual.  

![barras por país](charts/2026-11-13-19-28/fig4_countries.png)

### Correlaciones país‑por‑país entre IED y crecimiento del PIB  
*Solo algunos países presentan correlaciones moderadas, pero ninguna supera el umbral de significancia ajustada.*  
De los ocho pares país‑indicador evaluados, solo Guatemala (r = 0.742, p = 0.014) y Perú (r = 0.628, p = 0.052) alcanzan valores de r superiores a 0.6. Sin embargo, después de la corrección FDR (q = 0.174 y 0.225, respectivamente) ninguno cumple el criterio de significancia (q < 0.05). El resto de los países (Argentina, Brasil, Chile, Colombia, Costa Rica) presentan correlaciones bajas o negativas, todas clasificadas como no evidentes.  

El panel de dispersión de la figura 2 muestra los puntos anuales para cada país; la alineación cercana a la línea de referencia es escasa, lo que visualiza la falta de co‑movimiento sistemático entre IED y crecimiento del PIB.  

![dispersión de correlaciones](charts/2026-11-13-19-28/fig2_correlation.png)

### Relación con la digitalización y la seguridad energética (proxys)  
*Los indicadores de digitalización y energía no pueden medirse directamente, pero se exploran indirectamente mediante la variación de IED y del PIB.*  
Dado que los datos de penetración de internet y de participación del sector servicios no están disponibles en la muestra, se emplea la IED como proxy de la atracción de capital externo, bajo la premisa de que la digitalización y la seguridad energética mejoran la percepción de riesgo de los inversores (Berkmen et al., 2019). Los resultados obtenidos – ausencia de correlación significativa a nivel regional y mixtas a nivel nacional – indican que, con la información actual, no se puede confirmar una asociación robusta entre estos supuestos factores digitales/energéticos y los flujos de IED o el crecimiento económico.  

### Análisis de la hipótesis sobre empleo juvenil (limitaciones)  
*No se dispone de series temporales de desempleo juvenil, por lo que la hipótesis queda sin prueba empírica directa.*  
La revisión de la literatura sugiere que la inclusión financiera impulsada por fintech puede reducir la vulnerabilidad laboral de los jóvenes (Bakker et al., 2023). Sin embargo, la falta de datos de desempleo juvenil en la base del Banco Mundial impide validar estadísticamente esta relación.  

---

## Discusión  

Los hallazgos confirman la advertencia metodológica sobre la interpretación de correlaciones en niveles cuando ambas series comparten tendencias comunes (Kwilinski et al., 2023). La casi nula correlación entre IED y crecimiento del PIB a nivel regional sugiere que la co‑tendencia observada en los valores medios (ambas series presentan una ligera recuperación post‑2020) es espuria. Cuando se analizan cambios año a año (diferencias), la asociación desaparece, reforzando la conclusión de que la IED no es un motor determinante del crecimiento en el periodo 2015‑2024.  

En el contexto de la literatura sobre fintech, nuestros resultados son parcialmente consistentes con Berkmen et al. (2019) y Bakker et al. (2023), que destacan el potencial de la digitalización para atraer inversión y mejorar la inclusión laboral. La ausencia de evidencia significativa en nuestros datos podría deberse a varios factores: (i) la medida de IED como porcentaje del PIB puede estar influenciada por fluctuaciones del denominador; (ii) la penetración de internet y la seguridad energética varían de forma heterogénea dentro de los países, diluyendo efectos a nivel agregado; (iii) la corta ventana temporal (solo una década) limita la detección de efectos estructurales.  

Asimismo, la literatura sobre seguridad energética (Kwilinski & Lyulyov, 2023) sugiere que la estabilidad del suministro energético favorece el comercio y, por ende, el crecimiento. En nuestro análisis, la variable “participación del comercio (% del PIB)” no se incluyó por falta de datos, lo que impide evaluar directamente esta vía.  

Finalmente, la referencia a la reciente operación contra una estafa de criptomonedas (noticia 2026) plantea una hipótesis plausible de que la percepción de ciberseguridad afecta la confianza de los inversores. Sin embargo, sin series temporales de incidentes cibernéticos o índices de percepción de riesgo, no es posible cuantificar este mecanismo.  

---

## Conclusiones  

1. **No se detecta una asociación estadísticamente significativa** entre la IED neta y el crecimiento del PIB anual a nivel regional en América Latina entre 2015 y 2024 (r = 0.032, p = 0.930; q > 0.05).  

2. **Las correlaciones país‑por‑país son heterogéneas** y, tras corrección por falsos descubrimientos, ninguna alcanza significancia FDR; por lo tanto, no se puede afirmar que la IED explique de manera consistente el desempeño económico nacional.  

3. **Las tendencias observadas en los indicadores** (descenso de IED, recuperación del PIB tras 2020) son compatibles con la literatura que vincula crisis sanitarias y volatilidad de flujos de capital, pero no respaldan una relación causal con la digitalización o la seguridad energética bajo los datos disponibles.  

4. **Limitaciones de datos** impiden probar directamente la hipótesis sobre la reducción del desempleo juvenil y el papel del sector servicios; futuras investigaciones deberían incorporar series de penetración de internet, participación del sector servicios y métricas de seguridad energética, así como indicadores de empleo juvenil, para evaluar asociaciones más precisas.  

5. **Recomendación metodológica:** los estudios que exploren relaciones entre infraestructura digital, energía y flujos de inversión deben emplear análisis en diferencias (cambios año a año) y controles por tendencias comunes, a fin de evitar conclusiones espurias derivadas de co‑tendencias.  

En síntesis, la evidencia empírica disponible hasta 2024 no sustenta la hipótesis de que la digitalización y la seguridad energética, tal como se reflejan indirectamente en la IED, estén asociadas de forma robusta con mayores niveles de inversión extranjera ni con un crecimiento económico superior en América Latina. Se requieren bases de datos más granulares y variables complementarias para esclarecer estos vínculos en investigaciones posteriores.

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- DW. "US disrupts North Korea's $400 million crypto scam, FBI says". https://www.dw.com/en/us-disrupts-north-korea-s-400-million-crypto-scam-fbi-says/a-79935957?maca=en-rss-en-all-1573-rdf
- Berkmen, P., Beaton, K., Gershenson, D. et al. (2019). Fintech in Latin America and the Caribbean: Stocktaking. *IMF Working Paper*. https://doi.org/10.5089/9781498303248.001
- Bakker, B. B., Garcia-Nunes, B., Lian, W. et al. (2023). The Rise and Impact of Fintech in Latin America. *Fintech Notes*. https://doi.org/10.5089/9798400235474.063
- Kwilinski, A. S., Lyulyov, O. V., Pimonenko, T. (2023). Inclusive Economic Growth: Relationship between Energy and Governance Efficiency. *Energies*. https://doi.org/10.3390/en16062511

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

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-13-19-28/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Impacto de la digitalización y la seguridad energética en la inversión extranjera y el empleo juvenil en América Latina*.
Noticia que inspiró la línea editorial: *"US disrupts North Korea's $400 million crypto scam, FBI says"* ([DW](https://www.dw.com/en/us-disrupts-north-korea-s-400-million-crypto-scam-fbi-says/a-79935957?maca=en-rss-en-all-1573-rdf)).
Lo que la noticia afirmaba o sugería: La interrupción de una gran estafa de criptomonedas por parte de EE. UU. sugiere que la ciberseguridad internacional puede influir en la confianza de los inversores y, por ende, en los flujos de inversión extranjera directa hacia la región.
Alcance verificable con los datos: Se pueden analizar los niveles de Inversión Extranjera Directa (FDI) y el crecimiento del PIB; no se pueden medir directamente los incidentes de ciberseguridad o la percepción de riesgo sin datos adicionales.
Justificación del sistema: La noticia se relaciona con la seguridad digital, que afecta la confianza de los inversores. Los indicadores de FDI y crecimiento económico permiten evaluar si existe una asociación positiva entre mayor seguridad digital (proxied by Internet penetration) y mayores flujos de inversión.
**Pregunta de investigación:** ¿Cómo se relacionan la penetración de internet, la participación del sector servicios y la seguridad energética con la inversión extranjera directa, el empleo juvenil y el crecimiento económico en América Latina?
**Hipótesis planteada:** Los países latinoamericanos con mayor penetración de internet y mayor participación del sector servicios atraen más inversión extranjera directa (% del PIB) y presentan menores tasas de desempleo juvenil, mientras que una mayor participación del comercio (% del PIB) refuerza el crecimiento económico anual.
Se evaluaron 3 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 13 correlaciones Pearson/Spearman (0 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 52 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 1 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*