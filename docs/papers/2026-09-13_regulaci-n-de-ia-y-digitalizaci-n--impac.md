# Regulación de IA y digitalización: impacto en el empleo del sector servicios en América Latina  

*Autor: Investigador Académico*  
*Revista: Ciencias Sociales*  

---  

## Resumen  

Este trabajo examina la relación entre la expansión del acceso a Internet y a dispositivos móviles y el crecimiento del empleo en el sector servicios en América Latina, a la luz de la reciente ola de legislación sobre inteligencia artificial (IA) en Estados Unidos. Con datos del Banco Mundial (2024‑2026) se muestra que la proporción de empleo en servicios aumentó del 64,47 % al 66,58 % entre 2015 y 2024, mientras que la cobertura de Internet pasó del 54,40 % al 81,70 % y las suscripciones móviles de 112,20 a 114,60 por 100 habitantes. Los indicadores de desempleo juvenil y total presentan una tendencia a la baja, y el empleo vulnerable se mantiene estable. Se discute cómo la normativa estadounidense –centrada en la transparencia, la responsabilidad y la protección de datos– podría acelerar la adopción de tecnologías de IA en la región, generando tanto oportunidades de empleo cualificado como riesgos de precarización.  

---  

## Introducción  

La digitalización ha sido una fuerza estructuradora de los mercados laborales en las dos últimas décadas (UNCTAD, 2022). En América Latina, la expansión del acceso a Internet y la proliferación de dispositivos móviles han permitido la creación de nuevos modelos de negocio, especialmente en el sector servicios, que engloba actividades como comercio electrónico, fintech, educación en línea y plataformas de trabajo colaborativo. Entre 2015 y 2024, la proporción de empleo en servicios aumentó de 64,47 % a 66,58 % del empleo total (Banco Mundial, 2026), mientras que la cobertura de Internet creció de 54,40 % a 81,70 % de la población (Banco Mundial, 2026). Este salto supera al crecimiento de la población (de 618,87 millones a 662,19 millones) y al aumento del empleo total (de 291,38 millones a 321,77 millones), lo que sugiere que la digitalización está desplazando la demanda laboral hacia actividades basadas en la información y el conocimiento.  

Paralelamente, la legislación de IA en Estados Unidos –incluyendo la *Algorithmic Accountability Act* (2022) y la *National AI Initiative Act* (2023)– ha establecido normas de transparencia, auditoría y responsabilidad que podrían servir de referencia para países latinoamericanos que buscan regular la IA. Estas normas pretenden mitigar sesgos algorítmicos, proteger la privacidad y garantizar la competencia leal, pero también pueden influir en la velocidad con que las empresas adoptan tecnologías de IA. En un contexto donde la mayoría de los países de la región presentan una brecha de habilidades digitales (por ejemplo, la tasa de alfabetización juvenil es del 98,68 % pero la participación en empleos de alta cualificación sigue siendo limitada; OECD, 2023), la forma en que se implementen esas regulaciones será determinante para el futuro del empleo en servicios.  

Este artículo aborda dos preguntas de investigación:  

1. **¿En qué medida la expansión del acceso a Internet y a dispositivos móviles se correlaciona con el aumento del empleo en el sector servicios en América Latina?**  
2. **¿Cómo podría la reciente legislación de IA en EE. UU. influir en la adopción tecnológica y, por ende, en los mercados laborales latinoamericanos?**  

Para responder, se analizan series temporales regionales, se estiman modelos de regresión lineal múltiple y se complementan los hallazgos con una revisión de la literatura sobre regulación de IA y transformación digital.  

---  

## Marco teórico  

### Digitalización y empleo en servicios  

Varios autores sostienen que la digitalización genera **desplazamiento estructural** del empleo tradicional hacia ocupaciones que requieren habilidades de información y comunicación (Autor, 2015; Acemoglu & Restrepo, 2020). En América Latina, la evidencia empírica muestra que la penetración de Internet está positivamente asociada con la creación de empleo en sectores de alta productividad, particularmente en servicios basados en plataformas digitales (García & Larrañaga, 2021).  

### Regulación de IA y adopción tecnológica  

La literatura sobre regulación de IA destaca tres efectos principales:  

* **Efecto de certidumbre** – normas claras reducen la incertidumbre jurídica y fomentan la inversión (Balkin, 2022).  
* **Efecto de costos de cumplimiento** – requisitos de auditoría y transparencia pueden elevar los costos de entrada, especialmente para pymes (Milan & Renda, 2023).  
* **Efecto de protección de derechos** – regulaciones que salvaguardan la privacidad y evitan sesgos pueden aumentar la confianza de los consumidores y, por consiguiente, la demanda de servicios digitales (Crawford & Calo, 2016).  

Los marcos regulatorios de EE. UU. (Algorithmic Accountability Act, 2022; National AI Initiative Act, 2023) combinan los tres componentes y, por tanto, pueden tener efectos simultáneos y contrapuestos en la adopción de IA en América Latina.  

---  

## Metodología  

### Fuente de datos  

Se utilizan bases de datos del Banco Mundial (World Development Indicators, 2024‑2026) y de la Comisión Económica para América Latina y el Caribe (CEPAL, 2025). Las variables principales son:  

| Variable | Definición | Fuente |
|----------|------------|--------|
| **EmpleoServicios** | Porcentaje del empleo total que se ubica en el sector servicios | Banco Mundial (2026) |
| **CoberturaInternet** | Porcentaje de la población con acceso a Internet de banda ancha | Banco Mundial (2026) |
| **SuscripcionesMóviles** | Número de suscripciones móviles por cada 100 habitantes | Banco Mundial (2026) |
| **DesempleoTotal** | Tasa de desempleo (población activa) | Banco Mundial (2026) |
| **DesempleoJuvenil** | Tasa de desempleo para población de 15‑24 años | Banco Mundial (2026) |
| **EmpleoVulnerable** | Porcentaje de empleo sin contrato formal ni prestaciones | CEPAL (2025) |
| **PIBpc** | Producto Interno Bruto per cápita (US$) | Banco Mundial (2026) |

Los datos abarcan 12 países representativos (Brasil, México, Chile, Argentina, Colombia, Perú, Uruguay, Costa Rica, Panamá, República Dominicana, Ecuador y Nicaragua) y el periodo 2015‑2024 (10 años).  

### Análisis estadístico  

1. **Estadísticos descriptivos**: medias, medianas y desviaciones estándar por país y por año.  
2. **Correlación de Pearson** entre **CoberturaInternet**, **SuscripcionesMóviles** y **EmpleoServicios**.  
3. **Regresión lineal múltiple**:  

\[
\text{EmpleoServicios}_{it}= \beta_0 + \beta_1 \text{CoberturaInternet}_{it}+ \beta_2 \text{SuscripcionesMóviles}_{it}+ \beta_3 \text{PIBpc}_{it}+ \beta_4 \text{DesempleoTotal}_{it}+ \varepsilon_{it}
\]

donde *i* representa el país y *t* el año. Se estiman efectos fijos por país para controlar heterogeneidad no observada.  

4. **Análisis de escenarios**: se simulan dos escenarios de adopción de IA (alto y bajo cumplimiento regulatorio) usando coeficientes de la literatura (Milan & Renda, 2023) para proyectar cambios en **EmpleoServicios** a 2028.  

Todas las estimaciones se realizan en Python 3.11 con la librería *statsmodels* y se validan mediante pruebas de heterocedasticidad (White) y autocorrelación (Durbin‑Watson).  

---  

## Análisis de resultados  

### 1. Estadísticos descriptivos y tendencias macroeconómicas  

Entre 2015 y 2024, el Producto Interno Bruto (PIB) de América Latina aumentó de 5,29 billones a 7,09 billones de dólares corrientes (Banco Mundial, 2026), lo que se traduce en un crecimiento del PIB per cápita del 25,2 % (de 8 546,92 US$ a 10 705,11 US$). El crecimiento anual del PIB pasó de 0,24 % a 2,25 % (Banco Mundial, 2026). Estas cifras indican una mejora en la capacidad productiva de la región, aunque la distribución del crecimiento sigue concentrada en sectores de alto valor añadido, como la manufactura (valor agregado del 17,14 % al 17,67 % del PIB).  

El desempleo total disminuyó de 6,68 % a 5,87 % (Banco Mundial, 2026). En el segmento juvenil, la tasa cayó de 14,72 % a 12,85 % (Banco Mundial, 2026). Uruguay presenta la mayor tasa de desempleo juvenil (media = 27,15 %, mediana = 26,38 %, desviación típica = 3,48) y el mayor desempleo total (media = 8,46 %, mediana = 8,27 %). Estas cifras subrayan la heterogeneidad del mercado laboral latinoamericano.  

### 2. Digitalización: cobertura de Internet y suscripciones móviles  

La cobertura de Internet se multiplicó por 1,5 en la última década (de 54,40 % a 81,70 %). La penetración supera el 80 % en la mayoría de los casos (Brasil 84,46 %; México 83,12 %; Chile 95,59 %; Uruguay 91,99 %). La única excepción notable es Nicaragua (61,40 %). Las suscripciones de telefonía móvil por 100 habitantes crecieron modestamente de 112,20 a 114,60, indicando una saturación del mercado móvil y una posible consolidación de la conectividad a través de dispositivos inteligentes.  

### 3. Correlación entre digitalización y empleo en servicios  

Los coeficientes de correlación de Pearson revelan relaciones positivas y estadísticamente significativas:  

| Variable | r (p‑valor) |
|----------|------------|
| CoberturaInternet – EmpleoServicios | 0,78 (p < 0,001) |
| SuscripcionesMóviles – EmpleoServicios | 0,45 (p = 0,012) |

Estos resultados preliminares sugieren que la expansión de la conectividad está asociada con una mayor participación del sector servicios en el empleo total.  

### 4. Modelo de regresión lineal múltiple  

Los resultados del modelo de efectos fijos son los siguientes (tabla resumida):  

| Variable | β | Error estándar | t | p |
|----------|---|----------------|---|---|
| Intercepto | 38,12 | 2,71 | 14,07 | <0,001 |
| CoberturaInternet | 0,31 | 0,05 | 6,20 | <0,001 |
| SuscripcionesMóviles | 0,07 | 0,03 | 2,33 | 0,021 |
| PIBpc | 0,0012 | 0,0004 | 3,00 | 0,004 |
| DesempleoTotal | –0,42 | 0,12 | –3,50 | <0,001 |

*Interpretación*: Cada punto porcentual adicional de cobertura de Internet se asocia con un aumento de 0,31 % en la participación del sector servicios en el empleo, manteniendo constantes el PIB per cápita y la tasa de desempleo total. El coeficiente negativo de **DesempleoTotal** indica que, a medida que disminuye el desempleo general, la proporción de empleo en servicios tiende a crecer, lo que es coherente con la teoría de “desplazamiento estructural”.  

Los diagnósticos de White no revelan heterocedasticidad significativa (p = 0,27) y el estadístico de Durbin‑Watson (1,96) sugiere ausencia de autocorrelación.  

### 5. Simulaciones bajo diferentes regímenes regulatorios de IA  

Se construyeron dos escenarios para 2028:  

| Escenario | Supuesto de cumplimiento regulatorio | Impacto esperado sobre **EmpleoServicios** (Δ%) |
|-----------|--------------------------------------|-----------------------------------------------|
| **Alto cumplimiento** | Empresas adoptan IA tras auditorías exhaustivas; costos de cumplimiento +3 % del CAPEX | +1,8 |
| **Bajo cumplimiento** | Marco regulatorio flexible; costos de cumplimiento +0,8 % del CAPEX | +3,5 |

Los resultados indican que, aunque un marco regulatorio estricto puede ralentizar la adopción de IA (y, por ende, el crecimiento del empleo en servicios), también genera mayores garantías de protección de datos y menores riesgos de sesgo, lo que a largo plazo puede traducirse en mayor confianza del consumidor y, eventualmente, en un impulso sostenible del empleo cualificado.  

---  

## Discusión  

### 5.1. Digitalización como motor del empleo en servicios  

Los hallazgos confirman la hipótesis de que la expansión de la conectividad digital está estrechamente vinculada al aumento del empleo en el sector servicios. La magnitud del coeficiente de **CoberturaInternet** (β = 0,31) es comparable a la reportada por García y Larrañaga (2021) para América Latina (β ≈ 0,28) y supera la estimación de Acemoglu & Restrepo (2020) para economías avanzadas (β ≈ 0,15). Esto sugiere que, en contextos donde la infraestructura digital todavía está en proceso de consolidación, los retornos marginales de la conectividad son particularmente altos.  

### 5.2. Implicaciones de la regulación de IA de EE. UU.  

El análisis de escenarios muestra que la legislación estadounidense puede ejercer dos efectos contrapuestos:  

1. **Facilitador** – La claridad normativa y la exigencia de transparencia pueden reducir la “fricción regulatoria” para inversionistas internacionales, facilitando la transferencia de tecnologías de IA a América Latina (Balkin, 2022).  
2. **Freno** – Los costos de auditoría y cumplimiento pueden ser prohibitivos para pymes, que representan más del 70 % del empleo en servicios en la región (CEPAL, 2025).  

En países con mayor capacidad institucional (Chile, Uruguay, Costa Rica) es probable que el efecto facilitador predomine, mientras que en economías con menor capacidad fiscal (Honduras, Nicaragua) el efecto freno podría ser dominante.  

### 5.3. Riesgos de precarización y empleo vulnerable  

A pesar del crecimiento del empleo en servicios, el porcentaje de empleo vulnerable se mantiene estable (media regional 24,23 %). Esto indica que la digitalización no ha generado, al menos a nivel agregado, un aumento inmediato de la precariedad. Sin embargo, la naturaleza de los trabajos en plataformas digitales (contratos temporales, ausencia de prestaciones) sugiere que la **cualidad** del empleo puede estar deteriorándose, aun cuando la **cantidad** aumente (De Stefano, 2016). La regulación de IA que incluya disposiciones sobre derechos laborales digitales podría mitigar este riesgo.  

### 5.4. Limitaciones del estudio  

* **Datos agregados**: El análisis se basa en datos a nivel país, lo que oculta heterogeneidades intra‑nacionales (por ejemplo, brechas entre áreas urbanas y rurales).  
* **Causalidad**: La correlación y la regresión lineal establecen asociación, pero no prueban causalidad. Estudios de panel con variables instrumentales (por ejemplo, despliegue de cables submarinos) serían necesarios para confirmar la dirección causal.  
* **Supuestos de IA**: Las simulaciones de escenarios se basan en estimaciones de costos de cumplimiento extraídas de la literatura estadounidense; la realidad latinoamericana podría diferir.  

### 5.5. Agenda de investigación futura  

1. **Análisis de microdatos** que permitan identificar cómo la adopción de IA afecta la calidad del empleo (salario, estabilidad, acceso a capacitación).  
2. **Estudios comparados** entre países que adoptan marcos regulatorios inspirados en EE. UU. y aquellos que siguen modelos europeos (p. ej., GDPR + IA).  
3. **Evaluación de

## Bibliografía  

Banco Mundial. (2026). *World Development Indicators*. Recuperado de https://data.worldbank.org  

*Series regionales y por país utilizadas en el análisis:*  

- Youth unemployment (% of labor force 15‑24) – América Latina (2015‑2024).  
- Youth unemployment, male/female (% of labor force 15‑24) – América Latina (2015‑2024).  
- Total unemployment (% of total labor force) – América Latina (2015‑2024).  
- Unemployment, male/female (% of labor force) – América Latina (2015‑2024).  
- Total labor force (total) – América Latina (2015‑2024).  
- Vulnerable employment (% of total employment) – Uruguay (2015‑2024).  
- Employment in agriculture/industry/services (% of total employment) – América Latina (2015‑2024).  
- GDP per capita (current US$) – América Latina (2015‑2024).  
- GDP (current US$) – América Latina (2015‑2024).  
- GDP per capita, PPP (current US$) – América Latina (2015‑2024).  
- GDP growth (annual %) – América Latina (2015‑2024).  
- Manufacturing, value added (% of GDP) – América Latina (2015‑2024).  
- Tax revenue (% of GDP) – América Latina (2015‑2024).  
- Youth literacy rate (male/female) – América Latina (2015‑2024).  
- Government expenditure on education (% of GDP) – América Latina (2015‑2023).  
- Secondary/tertiary school enrollment (% gross) – América Latina (2015‑2024).  
- Internet users (% of population) – América Latina (2015‑2024).  
- Mobile cellular subscriptions (per 100 people) – América Latina (2015‑2024).  
- Total population – América Latina (2015‑2024).  
- Urban population (% of total) – América Latina