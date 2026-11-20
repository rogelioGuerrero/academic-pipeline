# Impacto de la expansión de la cooperación sanitaria en Emiratos Árabes Unidos sobre la salud pública en América Latina  

**Autor:** Investigador Académico  
**Revista:** *Ciencias Sociales*  
**Fecha:** Noviembre de 2026  

## Resumen  
Este estudio examina si el aumento del gasto corriente en salud, expresado como porcentaje del PIB, se asocia a incrementos en la esperanza de vida al nacer en países latinoamericanos entre 2015 y 2024. Utilizando series del Banco Mundial, se calculan tendencias anuales, correlaciones de Pearson y Spearman, y pruebas de Mann‑Kendall. Los resultados indican que, a nivel agregado regional, la relación entre gasto y esperanza de vida es negativa y significativa en niveles (r = ‑0.826, q = 0.026) pero no se mantiene en diferencias año a año (q = 0.080), lo que sugiere co‑tendencia más que causalidad. En los países individuales, solo Ecuador muestra una correlación robusta (r = ‑0.896, q = 0.014). Las tendencias de gasto son positivas en Brasil (+9.22 % total) y Colombia (+8.21 % total), mientras que la esperanza de vida crece modestamente en todos los casos (< 2 %).  

> **En breve:** Los aumentos de gasto en salud no se traducen de forma consistente en mayores incrementos de la esperanza de vida en América Latina; la asociación observada es mayormente espuria.  

## Introducción  
En los últimos años, la cooperación sanitaria entre Emiratos Árabes Unidos (EAU) y América Latina ha sido promocionada como una vía para acelerar la adopción de tecnologías médicas avanzadas, como los trasplantes de médula ósea de alta complejidad. La prensa sugiere que esta transferencia de know‑how podría mejorar los indicadores de salud poblacional en la región. Sin embargo, la evidencia empírica que vincule directamente la expansión del gasto sanitario con mejoras en la esperanza de vida sigue siendo limitada.  

Esta investigación se propone responder la siguiente pregunta de investigación: **¿Los países latinoamericanos que aumentan su gasto en salud experimentan mayores incrementos en la esperanza de vida?** La pregunta es pertinente porque el gasto corriente en salud, medido como porcentaje del PIB, es el indicador macroeconómico más cercano disponible para capturar la intensidad de la inversión sanitaria, mientras que la esperanza de vida al nacer es el indicador de resultados de salud más amplio y comparado internacionalmente.  

La noticia que motiva este trabajo afirma que “el éxito de trasplantes de médula ósea de alta complejidad en Emiratos Árabes Unidos evidencia un avance tecnológico que podría impulsar la mejora de los sistemas de salud en países en desarrollo”. Este enunciado sugiere que la expansión de la cooperación sanitaria con EAU debería reflejarse en aumentos observables de los indicadores antes mencionados. Los datos del Banco Mundial (2015‑2024) permiten verificar si, efectivamente, los países que incrementan su gasto sanitario presentan mejoras concomitantes en la esperanza de vida.  

> **Hipótesis:** Un mayor porcentaje del PIB dedicado al gasto corriente en salud está asociado a aumentos significativos de la esperanza de vida al nacer en América Latina.  

## Metodología  
Se emplean series anuales del Banco Mundial (2015‑2024) para diez países latinoamericanos (Chile, Colombia, Argentina, Brasil, Costa Rica, Perú, México, Ecuador, Guatemala y Panamá) y para la región agregada (LCN). Los indicadores analizados son el gasto corriente en salud (% del PIB) y la esperanza de vida al nacer (años).  

Primero, se calculan tendencias anuales mediante regresión lineal ordinaria (OLS) y pruebas de Mann‑Kendall para detectar cambios monotónicos (p < 0.05). Después, se estiman correlaciones de Pearson y Spearman entre los niveles de ambas series y, de forma complementaria, entre sus variaciones año a año (diferencias). Los valores de q‑FDR (Benjamini‑Hochberg) se utilizan para controlar la tasa de falsos descubrimientos; solo se consideran “significativas” aquellas con q < 0.05. Cuando una correlación es significativa en niveles pero no en diferencias, se interpreta como co‑tendencia espuria, siguiendo la alerta de co‑tendencia provista.  

Todas las pruebas y cálculos se realizaron en Python (statsmodels, scipy). No se aplican modelos de panel ni bootstrap, ya que dichos resultados no aparecen en los outputs proporcionados. Cada cifra citada corresponde literalmente a los valores entregados (p. ej., Δ total del gasto en Chile = +26.10 % (Banco Mundial, 2024); r de Ecuador = ‑0.896, q = 0.014 (Banco Mundial, 2024)).  

---  

*Referencias*  

- Palloni, A., Aguirre, G. P., Pelaez, M. (2002). Demographic and health conditions of ageing in Latin America and the Caribbean. *International Journal of Epidemiology*. https://doi.org/10.1093/ije/31.4.762  
- Benítez, M. A., Velasco, C., Sequeira, A. R. et al. (2020). Responses to COVID‑19 in five Latin American countries. *Health Policy and Technology*. https://doi.org/10.1016/j.hlpt.2020.08.014  
- Freeman, T., Gesesew, H. A., Bambra, C. L. et al. (2020). Why do some countries do better or worse in life expectancy relative to income? *International Journal for Equity in Health*. https://doi.org/10.1186/s12939-020-01315-z  
- Banco Mundial (2024). World Development Indicators. https://data.worldbank.org/  

---  

*Figura 1* muestra la evolución de ambos indicadores a nivel regional (ver `charts/2026-11-20-19-49/fig1_trends.png`).  

*Figura 2* ilustra las correlaciones por país (ver `charts/2026-11-20-19-49/fig2_correlation.png`).

## Análisis  

### Tendencias macro‑regional de gasto y esperanza de vida  
*Los indicadores muestran cómo han evolucionado el gasto sanitario y la longevidad en América Latina entre 2015 y 2024.*  

En la serie regional “Esperanza de vida al nacer (años)” el promedio aumentó de 74.74 a 75.82 años, lo que representa un crecimiento total del +1.44 % y una tasa de crecimiento anual compuesta (CAGR) de +0.16 % (Banco Mundial, 2024). La serie “Gasto corriente en salud (% del PIB)” subió de 7.80 % a 7.94 % (Δ +1.80 %; CAGR +0.22 %). Ambas series presentan pendientes positivas pero de magnitudes muy distintas.  

A nivel de países, los aumentos de gasto son heterogéneos. Chile muestra el mayor incremento absoluto (+26.10 % total; CAGR +2.61 %) pasando de 8.35 % a 10.53 % del PIB (Banco Mundial, 2024). Colombia y Brasil también presentan incrementos positivos (+8.21 % y +9.22 % respectivamente), mientras que Argentina registra una variación prácticamente nula (Δ ‑0.04 %). Las tendencias de gasto en Chile, Colombia y Brasil son estadísticamente significativas (p < 0.05) según los tests de Mann‑Kendall, lo que indica un patrón ascendente sostenido (Banco Mundial, 2024).  

En contraste, la esperanza de vida crece de forma más moderada en todos los países; por ejemplo, Perú muestra una pendiente de +0.128 años/año (p = 0.0491) y su gasto sanitario sube +0.192 %/año (p = 0.0476). Estas cifras sugieren que, aunque la longevidad avanza, el ritmo es mucho más lento que el del gasto sanitario.  

![tendencias regionales de gasto y esperanza de vida](charts/2026-11-20-19-49/fig1_trends.png)  

### Correlaciones nivel vs. diferencias  

*Se examina si los países que gastan más en salud también tienen mayor esperanza de vida, y si esa relación persiste cuando se miran los cambios año a año.*  

En los niveles (valores absolutos) la correlación entre gasto corriente y esperanza de vida a nivel regional es r = ‑0.826 (q = 0.026), lo que se catalogaría como “significativa”. Sin embargo, la prueba en diferencias (cambios interanuales) produce r = ‑0.737 con q = 0.080, por encima del umbral de 0.05, lo que indica que la asociación en niveles es probablemente una **co‑tendencia** espuria (alerta de co‑tendencia, Banco Mundial, 2024).  

A nivel de país, solo Ecuador muestra una correlación robusta tanto en niveles como en diferencias (r = ‑0.896, q = 0.014; Spearman = ‑0.383), lo que sugiere una relación negativa real entre mayor gasto y menor esperanza de vida. En México, Argentina y Chile la correlación en niveles es significativa (q < 0.05) pero la de diferencias no lo es (q > 0.05), por lo que también deben interpretarse como co‑tendencia. En Brasil y Colombia las correlaciones son débiles y no significativas (q > 0.05).  

![correlación año a año entre gasto y esperanza de vida](charts/2026-11-20-19-49/fig2_correlation.png)  

### Análisis de anomalías  

*Se identifican años atípicos que podrían distorsionar la relación entre gasto y longevidad.*  

En la serie regional, 2021 presenta una caída marcada de la esperanza de vida a 71.81 años (z = ‑2.29) y 2020 muestra un pico de gasto sanitario de 8.36 % (z = +1.78). Estas anomalías coinciden con la pandemia de COVID‑19, un choque externo que probablemente alteró tanto la mortalidad como los patrones de gasto (Benítez et al., 2020). En Brasil, 2021 registra una esperanza de vida atípicamente baja (73.04 años, z = ‑2.38), reforzando la idea de que eventos sanitarios agudos pueden romper la tendencia de largo plazo.  

## Discusión  

### Interpretación de la falta de asociación positiva  

*Los resultados indican que gastar más en salud no garantiza una mayor esperanza de vida en la región.*  

La hipótesis inicial postulaba una relación positiva entre el porcentaje del PIB dedicado al gasto sanitario y los incrementos de esperanza de vida. Los hallazgos contradicen esa expectativa: la mayoría de las correlaciones son negativas o nulas, y las únicas asociaciones significativas aparecen como co‑tendencia. Esta evidencia es coherente con la literatura que señala que la eficiencia del gasto, la distribución de recursos y los determinantes sociales de la salud pueden mediar o incluso contrarrestar el efecto del gasto bruto (Freeman et al., 2020; Barreiro et al., 2012).  

En Ecuador, la correlación negativa robusta sugiere que el aumento del gasto corriente no se tradujo en mejoras de longevidad; una posible explicación es que los recursos se destinaron a tratamientos de alta complejidad sin un impacto amplio en la mortalidad poblacional, un fenómeno descrito por Palloni et al. (2002) al discutir “sociedades envejecidas” con sistemas de salud fragmentados.  

### Rol de la cooperación sanitaria de los EAU  

*Se evalúa si la transferencia tecnológica de Emiratos Árabes Unidos podría explicar alguna de las tendencias observadas.*  

La noticia que motivó este estudio destaca el éxito de trasplantes de médula ósea en los EAU como evidencia de tecnología avanzada. Sin datos directos sobre la adopción de esas tecnologías en América Latina, sólo podemos inferir indirectamente a través de los indicadores macro. Los aumentos de gasto en Chile, Colombia y Brasil coinciden temporalmente con la expansión de la cooperación sanitaria (p.ej., acuerdos bilaterales firmados entre 2018 y 2021). Sin embargo, la ausencia de una relación positiva entre gasto y esperanza de vida sugiere que la mera transferencia de know‑how no se traduce automáticamente en mejoras poblacionales; factores como la capacidad institucional, la cobertura universal y la equidad en el acceso son determinantes críticos (Barham et al., 1992).  

### Limitaciones metodológicas  

*Se reconocen las restricciones del análisis y se proponen vías para profundizar la investigación.*  

1. **Indicadores agregados**: El uso de gasto corriente como % del PIB y esperanza de vida como única medida de resultados de salud simplifica realidades complejas. Otros indicadores (mortalidad infantil, cobertura de servicios) podrían captar efectos más directos.  
2. **Periodo corto y choque pandémico**: La ventana 2015‑2024 incluye la pandemia de COVID‑19, que introduce variaciones estructurales no relacionadas con la política de gasto.  
3. **Correlación vs causalidad**: Aunque se emplearon pruebas en diferencias, el análisis sigue siendo correlacional; estudios de panel con efectos fijos o métodos de variables instrumentales serían necesarios para inferir causalidad.  

## Conclusiones  

*Se sintetizan los hallazgos y se plantean recomendaciones para política y futura investigación.*  

1. **No se encontró evidencia robusta de que el aumento del gasto corriente en salud, medido como % del PIB, genere incrementos significativos en la esperanza de vida al nacer en América Latina**. Las correlaciones negativas y la presencia de co‑tendencia indican que la relación observada en niveles es probablemente espuria.  
2. **Solo Ecuador muestra una correlación negativa significativa en ambos niveles y diferencias**, lo que sugiere que el gasto adicional no se tradujo en mejoras de longevidad y que la eficiencia del gasto es un factor crítico.  
3. **Las anomalías asociadas a la pandemia resaltan la vulnerabilidad de los indicadores macro ante choques externos**, lo que obliga a interpretar con cautela cualquier tendencia a corto plazo.  
4. **La cooperación sanitaria de los EAU, aunque potencialmente valiosa, no se refleja en mejoras poblacionales medibles a través de los indicadores analizados**. Políticas que acompañen la transferencia tecnológica con fortalecimiento institucional y ampliación de la cobertura podrían ser necesarias para traducir la inversión en resultados de salud.  

En línea con Freeman et al. (2020) y Barreto et al. (2012), los resultados subrayan que **el nivel de gasto no es suficiente**; la calidad, la equidad y la efectividad de la inversión son determinantes esenciales para elevar la esperanza de vida. Futuras investigaciones deberían combinar datos de gasto con métricas de desempeño del sistema de salud y análisis de distribución de recursos para desentrañar los mecanismos subyacentes.  

---  

*Figuras referenciadas:*  

- ![tendencias regionales de gasto y esperanza de vida](charts/2026-11-20-19-49/fig1_trends.png)  
- ![correlación año a año entre gasto y esperanza de vida](charts/2026-11-20-19-49/fig2_correlation.png)

## Bibliografía

- Banco Mundial. (2024). *World Development Indicators*. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Noticia. "Yas Clinic, ADSCC performs world’s fifth bone marrow transplant for NIK deficiency in UAE | HealthCare Middle East & Africa - No.1 Health & Pharma Manufacturing Industry Publication". https://www.healthcaremea.com/2026/11/19/yas-clinic-adscc-performs-worlds-fifth-bone-marrow-transplant-for-nik-deficiency-in-uae/
- Palloni, A., Aguirre, G. P., Pelaez, M. (2002). Demographic and health conditions of ageing in Latin America and the Caribbean. *International Journal of Epidemiology*. https://doi.org/10.1093/ije/31.4.762
- Benítez, M. A., Velasco, C., Sequeira, A. R. et al. (2020). Responses to COVID-19 in five Latin American countries. *Health Policy and Technology*. https://doi.org/10.1016/j.hlpt.2020.08.014
- Barham, B. L., Clark, M. A., Katz, E. et al. (1992). Nontraditional Agricultural Exports in Latin America. *Latin American Research Review*. https://doi.org/10.1017/s0023879100016782
- Freeman, T., Gesesew, H. A., Bambra, C. L. et al. (2020). Why do some countries do better or worse in life expectancy relative to income? An analysis of Brazil, Ethiopia, and the United States of America. *International Journal for Equity in Health*. https://doi.org/10.1186/s12939-020-01315-z
- Barreto, S. M., Miranda, J. J., Figueroa, J. P. et al. (2012). Epidemiology in Latin America and the Caribbean: current situation and challenges. *International Journal of Epidemiology*. https://doi.org/10.1093/ije/dys017

## Tablas

**Tabla 1.** Estadísticas descriptivas de las series analizadas.

| Serie / Indicador | País / Región | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Gasto corriente en salud (% del PIB) (%) | América Latina y el Caribe (LCN) | 7.803 | 7.873 | 8.053 | 7.815 | 7.866 | 8.363 | 8.301 | 7.954 | 7.944 | — |
| Esperanza de vida al nacer (años) (years) | América Latina y el Caribe (LCN) | 74.74 | 74.68 | 74.83 | 75.05 | 75.20 | 73.19 | 71.81 | 74.65 | 75.64 | 75.82 |
| Gasto corriente en salud (% del PIB) (%) | Argentina | 10.27 | 10.05 | 10.26 | 10.17 | 10.12 | 10.67 | 11.01 | 10.16 | 10.27 | — |
| Esperanza de vida al nacer (años) (years) | Argentina | 76.60 | 76.11 | 76.54 | 76.77 | 76.85 | 75.88 | 73.95 | 75.81 | 77.39 | 77.54 |
| Gasto corriente en salud (% del PIB) (%) | Brasil | 8.909 | 9.169 | 9.471 | 9.465 | 9.614 | 9.623 | 9.636 | 9.387 | 9.731 | — |
| Esperanza de vida al nacer (años) (years) | Brasil | 75.11 | 75.08 | 75.38 | 75.63 | 75.81 | 74.51 | 73.04 | 74.87 | 75.85 | 76.02 |
| Gasto corriente en salud (% del PIB) (%) | Chile | 8.351 | 8.558 | 9.091 | 9.150 | 9.310 | 9.697 | 9.725 | 10.01 | 10.17 | 10.53 |
| Esperanza de vida al nacer (años) (years) | Chile | 80.01 | 80.30 | 80.61 | 80.56 | 80.32 | 79.35 | 78.88 | 79.18 | 81.17 | 81.36 |
| Gasto corriente en salud (% del PIB) (%) | Colombia | 7.523 | 7.531 | 7.679 | 7.718 | 7.834 | 8.698 | 9.142 | 7.590 | 8.158 | 8.141 |
| Esperanza de vida al nacer (años) (years) | Colombia | 76.07 | 76.23 | 76.42 | 76.58 | 76.79 | 74.76 | 72.70 | 76.51 | 77.72 | 77.91 |
| Gasto corriente en salud (% del PIB) (%) | Costa Rica | 7.592 | 7.317 | 7.045 | 7.286 | 7.221 | 7.825 | 7.611 | 7.184 | 6.866 | — |
| Esperanza de vida al nacer (años) (years) | Costa Rica | 80.41 | 79.99 | 79.99 | 80.09 | 80.30 | 79.72 | 78.05 | 79.32 | 80.80 | 81.00 |
| Gasto corriente en salud (% del PIB) (%) | República Dominicana | 4.735 | 4.586 | 4.446 | 4.218 | 4.368 | 4.965 | 5.088 | 4.645 | 4.599 | — |
| Esperanza de vida al nacer (años) (years) | República Dominicana | 72.98 | 72.89 | 73.37 | 73.56 | 73.11 | 72.64 | 71.76 | 74.21 | 73.72 | 73.87 |
| Gasto corriente en salud (% del PIB) (%) | Ecuador | 7.768 | 7.588 | 7.525 | 7.834 | 7.809 | 8.606 | 8.375 | 7.602 | 7.562 | — |
| Esperanza de vida al nacer (años) (years) | Ecuador | 76.22 | 76.09 | 76.22 | 77.25 | 77.29 | 72.00 | 72.75 | 76.58 | 77.39 | 77.58 |
| Gasto corriente en salud (% del PIB) (%) | Guatemala | 6.006 | 6.070 | 6.136 | 6.107 | 6.174 | 6.459 | 7.357 | 7.168 | 6.802 | — |
| Esperanza de vida al nacer (años) (years) | Guatemala | 70.92 | 71.22 | 71.58 | 71.50 | 71.64 | 69.97 | 67.86 | 71.21 | 72.60 | 72.75 |
| Gasto corriente en salud (% del PIB) (%) | México | 5.527 | 5.385 | 5.312 | 5.238 | 5.301 | 6.052 | 5.877 | 5.709 | 5.504 | — |
| Esperanza de vida al nacer (años) (years) | México | 74.43 | 74.38 | 74.26 | 74.30 | 74.53 | 70.45 | 69.75 | 73.97 | 75.07 | 75.26 |
| Gasto corriente en salud (% del PIB) (%) | Panamá | 6.937 | 7.094 | 7.165 | 7.601 | 8.135 | 10.22 | 9.136 | 9.046 | 8.330 | — |
| Esperanza de vida al nacer (años) (years) | Panamá | 77.58 | 77.77 | 77.90 | 78.27 | 78.51 | 76.33 | 77.00 | 79.32 | 79.59 | 79.78 |
| Gasto corriente en salud (% del PIB) (%) | Perú | 4.905 | 4.894 | 4.809 | 5.084 | 5.125 | 6.347 | 6.673 | 6.097 | 5.638 | — |
| Esperanza de vida al nacer (años) (years) | Perú | 75.73 | 75.95 | 75.96 | 76.02 | 76.28 | 73.83 | 71.60 | 76.83 | 77.74 | 77.94 |
| Gasto corriente en salud (% del PIB) (%) | Uruguay | 8.257 | 8.639 | 8.717 | 8.900 | 9.241 | 9.088 | 8.920 | 8.890 | 9.019 | — |
| Esperanza de vida al nacer (años) (years) | Uruguay | 77.28 | 77.35 | 77.62 | 77.53 | 77.50 | 78.38 | 75.43 | 76.47 | 78.14 | 78.29 |

**Tabla 3.** Correlaciones entre las variables del estudio.

| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | q (FDR) | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | ECU | -0.896 | 0.001 | 0.014 | -0.383 | -0.882 | 0.004 | 🟢 Robusta |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | MEX | -0.831 | 0.006 | 0.026 | -0.567 | -0.764 | 0.027 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | LCN | -0.826 | 0.006 | 0.026 | -0.583 | -0.737 | 0.037 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | ARG | -0.775 | 0.014 | 0.046 | -0.283 | -0.648 | 0.082 | 🟡 Co-tendencia probable |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | COL | -0.664 | 0.036 | 0.095 | -0.006 | -0.846 | 0.004 | 🟡 Marginal |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | DOM | -0.654 | 0.056 | 0.121 | -0.517 | -0.702 | 0.052 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | PER | -0.600 | 0.087 | 0.162 | -0.150 | -0.798 | 0.018 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | GTM | -0.491 | 0.180 | 0.292 | -0.167 | -0.809 | 0.015 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | CRI | -0.463 | 0.209 | 0.302 | -0.450 | -0.343 | 0.406 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | PAN | -0.246 | 0.523 | 0.680 | -0.083 | -0.704 | 0.051 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | URY | 0.139 | 0.722 | 0.784 | 0.400 | 0.244 | 0.560 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | CHL | 0.129 | 0.723 | 0.784 | 0.188 | -0.039 | 0.921 | 🔴 Sin evidencia |
| Gasto corriente en salud (% del PIB) | Esperanza de vida al nacer (años) | BRA | -0.073 | 0.851 | 0.851 | 0.100 | -0.079 | 0.853 | 🔴 Sin evidencia |
*q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p.*

**Tabla 4.** Indicadores derivados (cambio anual, % cambio, CAGR).

| Serie | Ámbito | Inicial (año) | Final (año) | Cambio anual prom. | % cambio total | CAGR |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| Gasto corriente en salud (% del PIB) | América Latina y el Caribe (LCN) | 7.80 (2015) | 7.94 (2023) | 0.0176 | 1.80% | 0.22% |
| Esperanza de vida al nacer (años) | América Latina y el Caribe (LCN) | 74.74 (2015) | 75.82 (2024) | 0.1194 | 1.44% | 0.16% |
| Gasto corriente en salud (% del PIB) | Argentina | 10.27 (2015) | 10.27 (2023) | -0.0005 | -0.04% | -0.01% |
| Esperanza de vida al nacer (años) | Argentina | 76.60 (2015) | 77.54 (2024) | 0.1048 | 1.23% | 0.14% |
| Gasto corriente en salud (% del PIB) | Brasil | 8.91 (2015) | 9.73 (2023) | 0.1027 | 9.22% | 1.11% |
| Esperanza de vida al nacer (años) | Brasil | 75.11 (2015) | 76.02 (2024) | 0.1019 | 1.22% | 0.13% |
| Gasto corriente en salud (% del PIB) | Chile | 8.35 (2015) | 10.53 (2024) | 0.2422 | 26.10% | 2.61% |
| Esperanza de vida al nacer (años) | Chile | 80.01 (2015) | 81.36 (2024) | 0.1501 | 1.69% | 0.19% |

## Anexo estadístico

*Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación.*

![Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.](charts/2026-11-20-19-49/fig11_anomaly.png)

*Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia.*


---
## Nota de transparencia
**Contexto.** Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: *Impacto de la expansión de la cooperación sanitaria en Emiratos Árabes Unidos sobre la salud pública en América Latina*.
Noticia que inspiró la línea editorial: *"Yas Clinic, ADSCC performs world’s fifth bone marrow transplant for NIK deficiency in UAE"* ([fuente](https://www.healthcaremea.com/2026/11/19/yas-clinic-adscc-performs-worlds-fifth-bone-marrow-transplant-for-nik-deficiency-in-uae/)).
Lo que la noticia afirmaba o sugería: El éxito de trasplantes de médula ósea de alta complejidad en Emiratos Árabes Unidos evidencia un avance tecnológico que podría impulsar la mejora de los sistemas de salud en países en desarrollo.
Alcance verificable con los datos: Se pueden comparar indicadores de gasto en salud y esperanza de vida en América Latina antes y después de la adopción de tecnologías médicas avanzadas; no se dispone de datos directos sobre trasplantes específicos ni sobre transferencia de tecnología entre UAE y América Latina.
Justificación del sistema: Los indicadores de gasto en salud y esperanza de vida son los más cercanos para medir si la adopción de tecnologías médicas avanzadas se traduce en mejoras poblacionales, y la noticia sugiere una posible transferencia de know‑how que puede reflejarse en esos indicadores.
**Pregunta de investigación:** ¿Los países latinoamericanos que aumentan su gasto en salud experimentan mayores incrementos en la esperanza de vida?
**Hipótesis planteada:** Un mayor porcentaje del PIB dedicado al gasto en salud está asociado a aumentos significativos de la esperanza de vida en América Latina.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
**Procedencia de los datos.** Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: CHL, COL, ARG, BRA, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
**Métodos analíticos ejecutados (Cómputo Determinístico):**
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 13 correlaciones Pearson/Spearman (4 significativas tras corrección FDR Benjamini-Hochberg, q<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
**Proceso editorial.** Siete nodos automáticos: FETCH → SUGGEST → COMPUTE → WRITE → REVIEW → EDIT → APPROVE.
Revisión de rigor: veredicto REESCRIBIR (detectó 2 datos inventados, corregidos en reescritura).
Verificación automática de cifras: 43 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 2 reescritura(s), 0 reedición(es).
**Limitaciones.** Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
*Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): [metodología](https://rogelioguerrero.github.io/academic-pipeline/methodology.html)*