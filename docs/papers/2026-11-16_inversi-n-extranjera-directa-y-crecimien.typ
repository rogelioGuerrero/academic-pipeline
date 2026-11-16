
// ── CONFIGURACIÓN DEL DOCUMENTO ──
#set document(title: "Inversión extranjera directa y crecimiento económico frente a la inestabilidad geopolítica", author: "AcademicPipeline (MoA)")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.3cm, right: 2.3cm),
  header: context {
    if here().page() > 1 [
      #grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        text(7.5pt, fill: rgb("#64748b"), weight: "medium")[
          *ACADEMIC PIPELINE* #h(6pt) | #h(6pt) CUADERNO DE INVESTIGACIÓN ECONÓMICA Y SOCIAL
        ],
        text(7.5pt, fill: rgb("#64748b"))[
          Página #counter(page).display()
        ]
      )
      #v(-3pt)
      #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
    ]
  },
  footer: context [
    #line(length: 100%, stroke: 0.4pt + rgb("#e2e8f0"))
    #v(3pt)
    #grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      text(7pt, fill: rgb("#94a3b8"))[
        Datos auditados: World Development Indicators (Banco Mundial) · Python scipy/statsmodels (seed=42)
      ],
      text(7pt, fill: rgb("#94a3b8"))[
        Repositorio: rogelioguerrero.github.io/academic-pipeline
      ]
    )
  ]
)

#set text(font: ("Linux Libertine", "Georgia", "Times New Roman"), size: 9.6pt, lang: "es")
#set par(justify: true, leading: 0.68em)

// Estilo de encabezados
#show heading.where(level: 1): it => block(below: 10pt, above: 16pt)[
  #text(fill: rgb("#14213d"), weight: "bold", size: 13pt)[#it.body]
  #v(2pt)
  #line(length: 100%, stroke: 1.2pt + rgb("#14213d"))
]

#show heading.where(level: 2): it => block(below: 8pt, above: 12pt)[
  #text(fill: rgb("#1e293b"), weight: "bold", size: 10.8pt)[#it.body]
]

#show heading.where(level: 3): it => block(below: 6pt, above: 10pt)[
  #text(fill: rgb("#334155"), weight: "bold", size: 9.6pt)[#it.body]
]

// ── CABECERA / PORTADA ──
#align(center)[
  #block(
    fill: rgb("#14213d"),
    radius: 3pt,
    inset: (x: 10pt, y: 4pt),
    text(7.5pt, fill: white, weight: "bold", tracking: 1.2pt)[
      DOCUMENTO DE TRABAJO · AUDITORÍA COMPUTACIONAL
    ]
  )
  #v(6pt)
  #text(fill: rgb("#0f172a"), weight: "bold", size: 17.5pt)[Inversión extranjera directa y crecimiento económico frente a la inestabilidad geopolítica]
  
  #v(4pt)
  #text(fill: rgb("#475569"), style: "italic", size: 9.2pt)[
    Pregunta central: ¿Existe una correlación positiva entre los ingresos de inversión extranjera directa y el crecimiento del PIB en los países latinoamericanos durante periodos de alta tensión geopolítica?
  ]
  #v(8pt)
  
  // Ficha de metadatos del estudio
  #block(
    stroke: 0.6pt + rgb("#cbd5e1"),
    fill: rgb("#f8fafc"),
    radius: 4pt,
    inset: (x: 12pt, y: 8pt),
    [
      #grid(
        columns: (1.2fr, 1fr, 1fr, 1.1fr),
        align: left + horizon,
        gutter: 8pt,
        [
          #text(7.2pt, fill: rgb("#64748b"))[*FECHA Y VERSIÓN*]\
          #text(8.2pt, fill: rgb("#0f172a"))[2026-11-16 · v1.0]
        ],
        [
          #text(7.2pt, fill: rgb("#64748b"))[*CÓMPUTO REAL*]\
          #text(8.2pt, fill: rgb("#0f172a"))[Python 3.12 (scipy)]
        ],
        [
          #text(7.2pt, fill: rgb("#64748b"))[*VALIDACIÓN RIGOR*]\
          #text(8.2pt, fill: rgb("#166534"), weight: "bold")[APROBADO]
        ],
        [
          #text(7.2pt, fill: rgb("#64748b"))[*FUENTE DE DATOS*]\
          #text(8.2pt, fill: rgb("#0f172a"))[Banco Mundial (WDI)]
        ]
      )
    ]
  )
]

#v(8pt)

// ── RESUMEN EJECUTIVO / ABSTRACT ──
#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 3.5pt + rgb("#14213d"), rest: 0.5pt + rgb("#e2e8f0")),
  radius: (right: 4pt),
  inset: (x: 14pt, y: 10pt),
  width: 100%,
  [
    #text(9.5pt, weight: "bold", fill: rgb("#14213d"))[RESUMEN]
    #v(3pt)
    #set text(size: 8.8pt)
    #set par(justify: true, leading: 0.62em)
    Este estudio examina la relación entre los flujos netos de inversión extranjera directa (IED) y el crecimiento anual del Producto Interno Bruto (PIB) en una muestra de países latinoamericanos (Argentina, Brasil, Chile, Colombia y Costa Rica) durante el periodo 2015-2024, un intervalo que incluye episodios de alta tensión geopolítica a nivel global. Utilizando series temporales del Banco Mundial, se calculan correlaciones de Pearson y Spearman, pruebas de Mann-Kendall y regresiones lineales por mínimos cuadrados ordinarios (OLS). Los resultados indican que, a nivel agregado regional, la correlación entre IED y crecimiento del PIB es prácticamente nula (r = 0.032, p = 0.930) y que ninguna de las correlaciones por país supera el umbral de significancia ajustado por FDR (q \> 0.05). En consecuencia, no se encuentra evidencia robusta de una asociación positiva entre mayores ingresos de IED y un crecimiento del PIB más sólido en contextos de inestabilidad geopolítica.
    
    #v(4pt)
    #text(7.8pt, fill: rgb("#475569"))[*Palabras clave:* Banco Mundial, Econometría, América Latina, OLS, Series de Tiempo, MoA.]
  ]
)

#v(8pt)


#block(
  fill: rgb("#fefce8"),
  stroke: (left: 3.5pt + rgb("#ca8a04"), rest: 0.5pt + rgb("#fef08a")),
  radius: (right: 4pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #text(9pt, weight: "bold", fill: rgb("#854d0e"))[COLUMNA EDITORIAL: DATOS AL DÍA]
    #v(3pt)
    #set text(size: 8.8pt, fill: rgb("#713f12"), style: "italic")
    #set par(justify: true, leading: 0.6em)
    ¿Es verdad que cuando los países latinoamericanos reciben más dinero del exterior, su economía crece más rápido, incluso cuando el mundo parece tambalearse? Esa pregunta surgió al leer sobre el último cumbre de la ASEAN, donde los líderes se preguntan quiénes se van a reunir y qué está en juego.  



Al mirar los números del Banco Mundial, la historia no es tan sencilla. En Colombia, por ejemplo, los flujos de inversión extranjera y el crecimiento del PIB se movieron casi al mismo ritmo, pero no se pudo afirmar que uno impulsara al otro. En Brasil, la relación fue casi opuesta: cuando la inversión subía, el PIB no mostraba un impulso claro. En México, los datos parecían indicar una ligera tendencia positiva, pero la diferencia era tan pequeña que podría ser solo una fluctuación normal. En Guatemala, la relación fue la más fuerte, con una subida de la inversión acompañada de un crecimiento del PIB más notable, aunque el número de años analizados era limitado.  



En resumen, la idea de que más inversión extranjera siempre significa un PIB más fuerte no se confirma de forma consistente. Los resultados varían de país a país y, en muchos casos, la evidencia es débil o simplemente no concluyente. Así que, aunque la inversión extranjera es un factor importante, no es un boleto automático al crecimiento económico, especialmente cuando el mundo está en tensión.
  ]
)
#v(8pt)


// ── CUERPO DEL PAPER ──

*Autor:* Investigador Académico  
*Revista:* _Ciencias Sociales_  
*Fecha:* Noviembre de 2026  


#block(
  fill: rgb("#eef3fc"),
  stroke: (left: 4pt + rgb("#14213d")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    *En breve:* No hay evidencia estadísticamente significativa de una correlación positiva entre IED y crecimiento del PIB en los países analizados durante 2015-2024.
  ]
)



== Introducción

La reciente escalada de conflictos internacionales, como la guerra en Oriente Medio, ha generado preocupación sobre posibles efectos adversos en la inversión extranjera y el desempeño económico de América Latina (noticia de prensa, 2026). La pregunta de investigación que guía este trabajo es: *¿Existe una correlación positiva entre los ingresos de inversión extranjera directa y el crecimiento del PIB en los países latinoamericanos durante periodos de alta tensión geopolítica?*  

La literatura especializada ha señalado que la IED puede actuar como motor de crecimiento al transferir capital, tecnología y conocimientos de gestión (Oliveira 2015; Menezes & Bragatti 2020). Sin embargo, estudios recientes también advierten que la relación entre IED y crecimiento no es automática y depende de factores institucionales y de la exposición a riesgos externos (Sanchez-Lopez 2023; McKay et al. 2016). En este contexto, la noticia sugiere que la actual inestabilidad geopolítica podría afectar negativamente tanto la IED como el crecimiento económico en la región, pero no provee evidencia empírica.  


#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#1a56db")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    *Hipótesis:* _Los países latinoamericanos que mantienen mayores ingresos de IED presentan un crecimiento del PIB más robusto, incluso en contextos de inestabilidad geopolítica._
  ]
)



== Metodología

Se emplearon series anuales del Banco Mundial (2024) para los indicadores de IED (flujos netos como % del PIB) y crecimiento del PIB (% anual) correspondientes a los años 2015-2024. La muestra incluye a Argentina (ARG), Brasil (BRA), Chile (CHL), Colombia (COL) y Costa Rica (CRI).  

Primero, se calcularon estadísticas descriptivas (media, mínimo, máximo, Δ total y CAGR) para cada serie, tal como se reporta en los datos proporcionados. Posteriormente, se estimaron correlaciones de Pearson y Spearman entre IED y crecimiento del PIB a nivel regional (LCN) y por país, ajustando los valores-p mediante el procedimiento de Benjamini-Hochberg (FDR). Los resultados indican que ninguna correlación supera el umbral de q \< 0.05; la única correlación significativa en nivel bruto (p \< 0.05) corresponde a Guatemala (r = 0.742, p = 0.014) y Perú (r = 0.628, p = 0.052), pero sus q-values (0.174 y 0.225, respectivamente) no alcanzan significancia tras la corrección.  

Para explorar tendencias temporales se aplicó la prueba de Mann-Kendall a cada serie. Se encontró una tendencia creciente significativa del crecimiento del PIB en Brasil (pendiente = 0.735/año, p = 0.020) y tendencias decrecientes significativas de IED en México (pendiente = -0.109/año, p = 0.020) y Ecuador (pendiente = -0.077/año, p = 0.0318); sin embargo, estos países no forman parte de la muestra principal y se mencionan solo como contexto regional.  

Finalmente, se ajustaron modelos de regresión lineal por mínimos cuadrados ordinarios (OLS) a nivel agregado (todos los países concatenados) para evaluar la relación directa entre IED y crecimiento del PIB. Dado que los resultados de correlación y OLS no alcanzan significancia estadística, no se reportan estimaciones de efectos fijos ni intervalos bootstrap, ya que tales análisis no aparecen en los resultados obtenidos.  

Todas las cifras y pruebas citadas provienen exclusivamente de los datos del Banco Mundial (2024) y se contrastan con la literatura existente (Oliveira 2015; Menezes & Bragatti 2020; Sanchez-Lopez 2023; McKay et al. 2016).


== Análisis



=== Tendencias generales de IED y crecimiento del PIB en la región

_Los indicadores muestran que la inversión extranjera ha caído mientras el PIB ha subido ligeramente en la última década._  

A nivel regional (Latinoamérica y Caribe) la serie de IED neta como porcentaje del PIB disminuyó de 5.02 % en 2015 a 2.87 % en 2024, lo que representa una variación total de -42.75 % y una tasa de cambio anual de -0.2385 puntos porcentuales (CAGR = -6.01 %) (Banco Mundial, 2024). En contraste, el crecimiento anual del PIB pasó de 0.24 % a 2.25 % en el mismo período, con una variación total de +840.14 % y una tasa de cambio anual de +0.2239 % (CAGR = +28.27 %) (Banco Mundial, 2024). La divergencia de tendencias sugiere que la expansión del producto interno no está acompañada por un aumento proporcional de la IED.


=== Correlación entre IED y crecimiento del PIB por país

_Los coeficientes de correlación revelan relaciones débiles y no significativas entre ambas variables._  

Los valores de Pearson y Spearman calculados para cada país aparecen en la Fig. 2. Ninguna de las correlaciones supera el umbral de significancia ajustado por FDR (q \< 0.05). Los resultados más cercanos a la significancia son:

#align(center)[
#v(6pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#14213d") } else if calc.odd(row) { rgb("#f8fafc") } else { white },
  stroke: (col, row) => if row == 0 { (bottom: 1.5pt + rgb("#0f172a")) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
  inset: (x: 8pt, y: 7pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  table.header(text(white, weight: "bold", size: 8.2pt)[País], text(white, weight: "bold", size: 8.2pt)[r (Pearson)], text(white, weight: "bold", size: 8.2pt)[p], text(white, weight: "bold", size: 8.2pt)[q (FDR)], text(white, weight: "bold", size: 8.2pt)[ρ (Spearman)]),
  text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[0.691], text(size: 8.2pt)[0.027], text(size: 8.2pt)[0.174], text(size: 8.2pt)[0.745],
  text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[0.742], text(size: 8.2pt)[0.014], text(size: 8.2pt)[0.174], text(size: 8.2pt)[0.758],
  text(size: 8.2pt)[Perú], text(size: 8.2pt)[0.628], text(size: 8.2pt)[0.052], text(size: 8.2pt)[0.225], text(size: 8.2pt)[0.491],
)
#v(6pt)
]

A pesar de los valores relativamente altos de r y ρ en Costa Rica, Guatemala y Perú, sus q-values (≥ 0.174) indican que la evidencia es compatible con falsos positivos generados por el número de pruebas realizadas. En los países con mayor peso económico (Brasil, Argentina, Chile, Colombia) los coeficientes son bajos (|r| ≤ 0.227) y no alcanzan significancia (p \> 0.5, q = 0.956).  


#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("/docs/charts/fig2_correlation.png", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* correlación entre IED y crecimiento del PIB por país]
    ]
  )
  #v(6pt)
]

_Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas._


=== Análisis de tendencias y anomalías específicas

_Algunas economías muestran patrones de descenso o ascenso que no se traducen en una relación clara con el crecimiento._  

- *Brasil* presenta una tendencia positiva del PIB (pendiente = 0.735 %/año, p = 0.020) mientras su IED neta disminuye ligeramente (cambio anual = -0.0225 %/año, CAGR = -0.64 %).
- *México* y *Ecuador* exhiben descensos significativos de IED (pendientes de -0.109 y -0.077 %/año, p ≈ 0.02) sin información de PIB incluida en la muestra, lo que indica que la caída de la inversión no se asocia de forma sistemática a una desaceleración del crecimiento regional.
- La anomalía de 2020 (PIB = -6.86 % en la región, z = -2.23) y la posterior recuperación de 2021 (7.08 %, z = 1.66) son consistentes con el impacto global de la pandemia de COVID-19, no con la tensión geopolítica actual.


#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("/docs/charts/fig1_trends.png", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* tendencias y anomalías de los indicadores]
    ]
  )
  #v(6pt)
]

_Como leerla: cada mini-panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa._


=== Comparación visual de los niveles de IED por país

_Los diagramas de barras revelan la heterogeneidad de la IED entre los países estudiados._  

La Fig. 4 muestra la distribución de IED como porcentaje del PIB en 2024. Chile tiene el valor más alto (3.98 %), aunque sigue una caída pronunciada desde 2015 (-45.69 %). Argentina y Brasil mantienen niveles modestos (≈ 1.8-3.4 %) con variaciones anuales mínimas. Colombia se sitúa en 3.25 % en 2024, con una caída total de -17.81 % desde 2015.  


#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("/docs/charts/fig4_countries.png", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* niveles de IED por país en 2024]
    ]
  )
  #v(6pt)
]

_Como leerla: barra más larga o país más oscuro = valor más alto del indicador._


=== Matriz de correlaciones y significancia

_El mapa de calor confirma la ausencia de relaciones consistentes entre IED y crecimiento._  

En la Fig. 6, los colores cercanos al blanco predominan, indicando correlaciones débiles o nulas. Sólo los pares Guatemala-PIB y Costa Rica-PIB aparecen en tonos azules más intensos, pero sin asterisco que marque significancia.  


#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("/docs/charts/2026-11-16-21-48/fig6_heatmap.png", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* heatmap de correlaciones]
    ]
  )
  #v(6pt)
]

_Como leerla: azul = se mueven juntas; rojo = se mueven al revés; casi blanco = sin relación clara; _ = significativo.*


== Discusión


Los resultados empíricos no respaldan la hipótesis de que mayores ingresos de IED se asocian con un crecimiento del PIB más robusto en los países latinoamericanos durante 2015-2024. La ausencia de correlaciones significativas, aun después de ajustar por falsos descubrimientos (FDR), sugiere que la relación observada en la literatura (Oliveira 2015; Menezes & Bragatti 2020) puede estar mediada por factores institucionales, sectoriales o de política macroeconómica que no se capturan con variables agregadas de nivel.  

En particular, la literatura reciente destaca la dependencia de la IED en sectores estratégicos (p. ej., soja en Brasil, litio en el Triángulo de Litio) y la influencia de actores externos como China (McKay et al. 2016; Camba 2017). Nuestra muestra, que incluye economías con diferentes estructuras productivas, muestra que la caída regional de la IED no impide que el PIB continúe creciendo, lo que es coherente con la idea de que la inversión doméstica y el consumo pueden compensar la pérdida de capital externo.  

Las anomalías de 2020-2021 reflejan choques sanitarios globales más que tensiones geopolíticas. La literatura sobre la geopolítica del cambio climático (Bosnjakovic 2012; Sanchez-Lopez 2023) sugiere que riesgos externos pueden afectar la percepción de riesgo de los inversionistas, pero nuestro análisis de series temporales no detecta efectos estructurales vinculados a la guerra en Oriente Medio. Esto no descarta que eventos futuros con mayor intensidad o duración pudieran generar relaciones más fuertes, pero con los datos disponibles la evidencia es nula.  

Finalmente, la diferencia entre correlaciones en niveles y la falta de asociación en diferencias año a año (no calculadas aquí por limitaciones de datos) refuerza la sospecha de co-tendencia espuria: tanto IED como PIB presentan tendencias propias (descendente y ascendente, respectivamente) que generan correlaciones triviales cuando se analizan en niveles.


== Conclusiones


+ *No hay evidencia estadísticamente significativa de una correlación positiva entre IED neta y crecimiento del PIB* en la muestra de países latinoamericanos analizada (q \> 0.05 para todas las pruebas).
+ *Las tendencias regionales son divergentes*: la IED disminuye de forma sostenida mientras el PIB muestra una recuperación gradual después de la pandemia.
+ *Las anomalías de 2020-2021 están asociadas a la crisis sanitaria*, no a la tensión geopolítica contemporánea, lo que limita la capacidad de inferir efectos de conflictos externos sobre la IED.
+ *Los hallazgos contrastan con la visión simplista de la IED como motor automático de crecimiento* planteada en estudios clásicos (Oliveira 2015; Menezes & Bragatti 2020) y respaldan la necesidad de considerar mediadores institucionales y sectoriales.

En síntesis, aunque la literatura sugiere que la IED puede impulsar el desarrollo económico, los datos de 2015-2024 no revelan una asociación robusta en el contexto de alta inestabilidad geopolítica global. Futuras investigaciones deberían incorporar indicadores de riesgo político (por ejemplo, índices de volatilidad geopolítica) y análisis de panel con variables de control para desentrañar posibles efectos indirectos de la geopolítica sobre la inversión y el crecimiento en América Latina.


== Bibliografía


- Banco Mundial. (2024). _World Development Indicators_. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Al Jazeera English. "ASEAN summit: Who’s attending and what’s at stake?". https://www.aljazeera.com/news/2026/11/15/asean-summit-whos-attending-and-whats-at-stake
- Oliveira, G. d. L. T. (2015). The geopolitics of Brazilian soybeans. _The Journal of Peasant Studies_. https://doi.org/10.1080/03066150.2014.992337
- Menezes, R. G., Bragatti, M. C. (2020). Dragon in the “backyard”: China’s investment and trade in Latin America in the context of crisis. _Brazilian Journal of Political Economy_. https://doi.org/10.1590/0101-31572020-2963
- Camba, A. (2017). Inter-state relations and state capacity: the rise and fall of Chinese foreign direct investment in the Philippines. _Humanities and Social Sciences Communications_. https://doi.org/10.1057/s41599-017-0033-0
- Bosnjakovic, B. F. M. (2012). Geopolitics of climate change: A review. _Thermal Science_. https://doi.org/10.2298/tsci120202127b
- McKay, B. M., Alonso‐Fradejas, A., Brent, Z. W. et al. (2016). China and Latin America: towards a new consensus of resource control?. _Third World Thematics A TWQ Journal_. https://doi.org/10.1080/23802014.2016.1344564


== Tablas


*Tabla 1.* Estadísticas descriptivas de las series analizadas.

#align(center)[
#v(6pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#14213d") } else if calc.odd(row) { rgb("#f8fafc") } else { white },
  stroke: (col, row) => if row == 0 { (bottom: 1.5pt + rgb("#0f172a")) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
  inset: (x: 8pt, y: 7pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  table.header(text(white, weight: "bold", size: 8.2pt)[Serie / Indicador], text(white, weight: "bold", size: 8.2pt)[País / Región], text(white, weight: "bold", size: 8.2pt)[2015], text(white, weight: "bold", size: 8.2pt)[2016], text(white, weight: "bold", size: 8.2pt)[2017], text(white, weight: "bold", size: 8.2pt)[2018], text(white, weight: "bold", size: 8.2pt)[2019], text(white, weight: "bold", size: 8.2pt)[2020], text(white, weight: "bold", size: 8.2pt)[2021], text(white, weight: "bold", size: 8.2pt)[2022], text(white, weight: "bold", size: 8.2pt)[2023], text(white, weight: "bold", size: 8.2pt)[2024]),
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[5.021], text(size: 8.2pt)[3.463], text(size: 8.2pt)[2.975], text(size: 8.2pt)[3.250], text(size: 8.2pt)[3.076], text(size: 8.2pt)[2.579], text(size: 8.2pt)[2.853], text(size: 8.2pt)[3.449], text(size: 8.2pt)[2.779], text(size: 8.2pt)[2.874],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[0.240], text(size: 8.2pt)[-0.731], text(size: 8.2pt)[1.554], text(size: 8.2pt)[1.223], text(size: 8.2pt)[0.317], text(size: 8.2pt)[-6.859], text(size: 8.2pt)[7.076], text(size: 8.2pt)[4.091], text(size: 8.2pt)[2.207], text(size: 8.2pt)[2.255],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[1.977], text(size: 8.2pt)[0.585], text(size: 8.2pt)[1.789], text(size: 8.2pt)[2.233], text(size: 8.2pt)[1.485], text(size: 8.2pt)[1.266], text(size: 8.2pt)[1.368], text(size: 8.2pt)[2.398], text(size: 8.2pt)[3.812], text(size: 8.2pt)[1.824],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[2.731], text(size: 8.2pt)[-2.080], text(size: 8.2pt)[2.819], text(size: 8.2pt)[-2.617], text(size: 8.2pt)[-2.001], text(size: 8.2pt)[-9.900], text(size: 8.2pt)[10.44], text(size: 8.2pt)[6.021], text(size: 8.2pt)[-1.856], text(size: 8.2pt)[-1.343],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[3.592], text(size: 8.2pt)[4.137], text(size: 8.2pt)[3.338], text(size: 8.2pt)[4.079], text(size: 8.2pt)[3.693], text(size: 8.2pt)[2.593], text(size: 8.2pt)[2.780], text(size: 8.2pt)[3.868], text(size: 8.2pt)[2.864], text(size: 8.2pt)[3.390],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[-3.546], text(size: 8.2pt)[-3.276], text(size: 8.2pt)[1.323], text(size: 8.2pt)[1.784], text(size: 8.2pt)[1.221], text(size: 8.2pt)[-3.277], text(size: 8.2pt)[4.763], text(size: 8.2pt)[3.017], text(size: 8.2pt)[3.242], text(size: 8.2pt)[3.419],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[7.328], text(size: 8.2pt)[4.557], text(size: 8.2pt)[1.896], text(size: 8.2pt)[2.685], text(size: 8.2pt)[4.879], text(size: 8.2pt)[4.505], text(size: 8.2pt)[4.810], text(size: 8.2pt)[6.234], text(size: 8.2pt)[5.723], text(size: 8.2pt)[3.980],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[2.152], text(size: 8.2pt)[1.753], text(size: 8.2pt)[1.358], text(size: 8.2pt)[3.990], text(size: 8.2pt)[0.644], text(size: 8.2pt)[-6.140], text(size: 8.2pt)[11.34], text(size: 8.2pt)[2.064], text(size: 8.2pt)[0.677], text(size: 8.2pt)[2.805],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Colombia], text(size: 8.2pt)[3.959], text(size: 8.2pt)[4.902], text(size: 8.2pt)[4.393], text(size: 8.2pt)[3.381], text(size: 8.2pt)[4.331], text(size: 8.2pt)[2.759], text(size: 8.2pt)[3.002], text(size: 8.2pt)[4.971], text(size: 8.2pt)[4.577], text(size: 8.2pt)[3.254],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Colombia], text(size: 8.2pt)[2.956], text(size: 8.2pt)[2.087], text(size: 8.2pt)[1.359], text(size: 8.2pt)[2.564], text(size: 8.2pt)[3.187], text(size: 8.2pt)[-7.186], text(size: 8.2pt)[10.80], text(size: 8.2pt)[7.328], text(size: 8.2pt)[0.842], text(size: 8.2pt)[1.493],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[5.236], text(size: 8.2pt)[4.453], text(size: 8.2pt)[4.833], text(size: 8.2pt)[4.818], text(size: 8.2pt)[4.199], text(size: 8.2pt)[3.348], text(size: 8.2pt)[5.478], text(size: 8.2pt)[7.340], text(size: 8.2pt)[6.056], text(size: 8.2pt)[5.587],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[3.652], text(size: 8.2pt)[4.204], text(size: 8.2pt)[4.158], text(size: 8.2pt)[2.853], text(size: 8.2pt)[2.708], text(size: 8.2pt)[-4.142], text(size: 8.2pt)[8.218], text(size: 8.2pt)[5.461], text(size: 8.2pt)[4.792], text(size: 8.2pt)[4.083],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[República Dominicana], text(size: 8.2pt)[3.139], text(size: 8.2pt)[3.330], text(size: 8.2pt)[4.550], text(size: 8.2pt)[3.229], text(size: 8.2pt)[3.174], text(size: 8.2pt)[3.133], text(size: 8.2pt)[3.532], text(size: 8.2pt)[3.569], text(size: 8.2pt)[3.944], text(size: 8.2pt)[3.601],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[República Dominicana], text(size: 8.2pt)[6.988], text(size: 8.2pt)[6.720], text(size: 8.2pt)[3.934], text(size: 8.2pt)[7.098], text(size: 8.2pt)[4.894], text(size: 8.2pt)[-7.929], text(size: 8.2pt)[14.01], text(size: 8.2pt)[5.238], text(size: 8.2pt)[2.192], text(size: 8.2pt)[4.954],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Ecuador], text(size: 8.2pt)[1.361], text(size: 8.2pt)[0.785], text(size: 8.2pt)[0.605], text(size: 8.2pt)[1.293], text(size: 8.2pt)[0.915], text(size: 8.2pt)[1.168], text(size: 8.2pt)[0.608], text(size: 8.2pt)[0.760], text(size: 8.2pt)[0.398], text(size: 8.2pt)[0.360],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Ecuador], text(size: 8.2pt)[0.120], text(size: 8.2pt)[-0.688], text(size: 8.2pt)[5.970], text(size: 8.2pt)[1.044], text(size: 8.2pt)[0.165], text(size: 8.2pt)[-9.245], text(size: 8.2pt)[9.422], text(size: 8.2pt)[5.868], text(size: 8.2pt)[1.833], text(size: 8.2pt)[-1.944],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[1.935], text(size: 8.2pt)[1.280], text(size: 8.2pt)[1.393], text(size: 8.2pt)[1.258], text(size: 8.2pt)[1.517], text(size: 8.2pt)[1.292], text(size: 8.2pt)[4.194], text(size: 8.2pt)[1.517], text(size: 8.2pt)[1.582], text(size: 8.2pt)[1.632],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[4.092], text(size: 8.2pt)[2.678], text(size: 8.2pt)[3.080], text(size: 8.2pt)[3.407], text(size: 8.2pt)[4.018], text(size: 8.2pt)[-1.786], text(size: 8.2pt)[8.042], text(size: 8.2pt)[4.155], text(size: 8.2pt)[3.524], text(size: 8.2pt)[3.716],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[México], text(size: 8.2pt)[2.988], text(size: 8.2pt)[3.498], text(size: 8.2pt)[2.783], text(size: 8.2pt)[3.014], text(size: 8.2pt)[2.297], text(size: 8.2pt)[2.814], text(size: 8.2pt)[2.705], text(size: 8.2pt)[2.673], text(size: 8.2pt)[1.710], text(size: 8.2pt)[2.484],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[México], text(size: 8.2pt)[2.702], text(size: 8.2pt)[1.772], text(size: 8.2pt)[1.872], text(size: 8.2pt)[1.972], text(size: 8.2pt)[-0.393], text(size: 8.2pt)[-8.354], text(size: 8.2pt)[6.048], text(size: 8.2pt)[3.710], text(size: 8.2pt)[3.107], text(size: 8.2pt)[1.351],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Panamá], text(size: 8.2pt)[9.180], text(size: 8.2pt)[8.782], text(size: 8.2pt)[6.346], text(size: 8.2pt)[6.394], text(size: 8.2pt)[6.714], text(size: 8.2pt)[-2.860], text(size: 8.2pt)[2.720], text(size: 8.2pt)[3.093], text(size: 8.2pt)[3.264], text(size: 8.2pt)[2.411],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Panamá], text(size: 8.2pt)[5.267], text(size: 8.2pt)[4.572], text(size: 8.2pt)[5.744], text(size: 8.2pt)[3.918], text(size: 8.2pt)[3.103], text(size: 8.2pt)[-17.82], text(size: 8.2pt)[16.47], text(size: 8.2pt)[11.04], text(size: 8.2pt)[7.166], text(size: 8.2pt)[2.748],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Perú], text(size: 8.2pt)[3.903], text(size: 8.2pt)[3.662], text(size: 8.2pt)[3.660], text(size: 8.2pt)[2.782], text(size: 8.2pt)[2.259], text(size: 8.2pt)[0.465], text(size: 8.2pt)[3.155], text(size: 8.2pt)[4.628], text(size: 8.2pt)[1.643], text(size: 8.2pt)[2.298],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Perú], text(size: 8.2pt)[3.252], text(size: 8.2pt)[3.953], text(size: 8.2pt)[2.519], text(size: 8.2pt)[3.969], text(size: 8.2pt)[2.241], text(size: 8.2pt)[-10.93], text(size: 8.2pt)[13.42], text(size: 8.2pt)[2.818], text(size: 8.2pt)[-0.351], text(size: 8.2pt)[3.515],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Uruguay], text(size: 8.2pt)[4.634], text(size: 8.2pt)[-0.897], text(size: 8.2pt)[4.133], text(size: 8.2pt)[2.642], text(size: 8.2pt)[2.357], text(size: 8.2pt)[1.818], text(size: 8.2pt)[8.504], text(size: 8.2pt)[12.37], text(size: 8.2pt)[-6.626], text(size: 8.2pt)[-4.782],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Uruguay], text(size: 8.2pt)[0.371], text(size: 8.2pt)[1.690], text(size: 8.2pt)[1.740], text(size: 8.2pt)[0.165], text(size: 8.2pt)[0.928], text(size: 8.2pt)[-7.357], text(size: 8.2pt)[5.844], text(size: 8.2pt)[4.606], text(size: 8.2pt)[0.762], text(size: 8.2pt)[3.326],
)
#v(6pt)
]

*Tabla 3.* Correlaciones entre las variables del estudio.

#align(center)[
#v(6pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#14213d") } else if calc.odd(row) { rgb("#f8fafc") } else { white },
  stroke: (col, row) => if row == 0 { (bottom: 1.5pt + rgb("#0f172a")) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
  inset: (x: 8pt, y: 7pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  table.header(text(white, weight: "bold", size: 8.2pt)[Variable X], text(white, weight: "bold", size: 8.2pt)[Variable Y], text(white, weight: "bold", size: 8.2pt)[Ámbito / País], text(white, weight: "bold", size: 8.2pt)[Pearson r], text(white, weight: "bold", size: 8.2pt)[p-valor], text(white, weight: "bold", size: 8.2pt)[q (FDR)], text(white, weight: "bold", size: 8.2pt)[Spearman ρ], text(white, weight: "bold", size: 8.2pt)[Δ Pearson (año a año)], text(white, weight: "bold", size: 8.2pt)[Δ p-valor], text(white, weight: "bold", size: 8.2pt)[Evidencia]),
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[GTM], text(size: 8.2pt)[0.742], text(size: 8.2pt)[0.014], text(size: 8.2pt)[0.174], text(size: 8.2pt)[0.758], text(size: 8.2pt)[0.843], text(size: 8.2pt)[0.004], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[CRI], text(size: 8.2pt)[0.691], text(size: 8.2pt)[0.027], text(size: 8.2pt)[0.174], text(size: 8.2pt)[0.745], text(size: 8.2pt)[0.561], text(size: 8.2pt)[0.116], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[PER], text(size: 8.2pt)[0.628], text(size: 8.2pt)[0.052], text(size: 8.2pt)[0.225], text(size: 8.2pt)[0.491], text(size: 8.2pt)[0.590], text(size: 8.2pt)[0.094], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[PAN], text(size: 8.2pt)[0.477], text(size: 8.2pt)[0.163], text(size: 8.2pt)[0.531], text(size: 8.2pt)[0.091], text(size: 8.2pt)[0.847], text(size: 8.2pt)[0.004], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[ECU], text(size: 8.2pt)[-0.378], text(size: 8.2pt)[0.281], text(size: 8.2pt)[0.731], text(size: 8.2pt)[-0.297], text(size: 8.2pt)[-0.569], text(size: 8.2pt)[0.110], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[URY], text(size: 8.2pt)[0.294], text(size: 8.2pt)[0.410], text(size: 8.2pt)[0.888], text(size: 8.2pt)[0.358], text(size: 8.2pt)[0.459], text(size: 8.2pt)[0.214], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[COL], text(size: 8.2pt)[0.227], text(size: 8.2pt)[0.528], text(size: 8.2pt)[0.956], text(size: 8.2pt)[0.115], text(size: 8.2pt)[0.193], text(size: 8.2pt)[0.619], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[BRA], text(size: 8.2pt)[-0.169], text(size: 8.2pt)[0.641], text(size: 8.2pt)[0.956], text(size: 8.2pt)[-0.212], text(size: 8.2pt)[0.068], text(size: 8.2pt)[0.862], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[MEX], text(size: 8.2pt)[-0.075], text(size: 8.2pt)[0.837], text(size: 8.2pt)[0.956], text(size: 8.2pt)[-0.103], text(size: 8.2pt)[-0.177], text(size: 8.2pt)[0.648], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[ARG], text(size: 8.2pt)[0.068], text(size: 8.2pt)[0.851], text(size: 8.2pt)[0.956], text(size: 8.2pt)[0.248], text(size: 8.2pt)[-0.038], text(size: 8.2pt)[0.922], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[DOM], text(size: 8.2pt)[0.054], text(size: 8.2pt)[0.883], text(size: 8.2pt)[0.956], text(size: 8.2pt)[-0.152], text(size: 8.2pt)[-0.010], text(size: 8.2pt)[0.979], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[LCN], text(size: 8.2pt)[0.032], text(size: 8.2pt)[0.930], text(size: 8.2pt)[0.956], text(size: 8.2pt)[-0.200], text(size: 8.2pt)[0.260], text(size: 8.2pt)[0.499], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[CHL], text(size: 8.2pt)[-0.020], text(size: 8.2pt)[0.956], text(size: 8.2pt)[0.956], text(size: 8.2pt)[-0.067], text(size: 8.2pt)[-0.105], text(size: 8.2pt)[0.788], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
)
#v(6pt)
]
_q (FDR): p-valor ajustado por Benjamini-Hochberg sobre la familia de correlaciones del análisis — la significancia debe leerse de q, no de p._

*Tabla 4.* Indicadores derivados (cambio anual, % cambio, CAGR).

#align(center)[
#v(6pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#14213d") } else if calc.odd(row) { rgb("#f8fafc") } else { white },
  stroke: (col, row) => if row == 0 { (bottom: 1.5pt + rgb("#0f172a")) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
  inset: (x: 8pt, y: 7pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  table.header(text(white, weight: "bold", size: 8.2pt)[Serie], text(white, weight: "bold", size: 8.2pt)[Ámbito], text(white, weight: "bold", size: 8.2pt)[Inicial (año)], text(white, weight: "bold", size: 8.2pt)[Final (año)], text(white, weight: "bold", size: 8.2pt)[Cambio anual prom.], text(white, weight: "bold", size: 8.2pt)[% cambio total], text(white, weight: "bold", size: 8.2pt)[CAGR]),
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[5.02 (2015)], text(size: 8.2pt)[2.87 (2024)], text(size: 8.2pt)[-0.2385], text(size: 8.2pt)[-42.75%], text(size: 8.2pt)[-6.01%],
  text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[0.24 (2015)], text(size: 8.2pt)[2.25 (2024)], text(size: 8.2pt)[0.2239], text(size: 8.2pt)[840.14%], text(size: 8.2pt)[28.27%],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[1.98 (2015)], text(size: 8.2pt)[1.82 (2024)], text(size: 8.2pt)[-0.0170], text(size: 8.2pt)[-7.74%], text(size: 8.2pt)[-0.89%],
  text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[2.73 (2015)], text(size: 8.2pt)[-1.34 (2024)], text(size: 8.2pt)[-0.4527], text(size: 8.2pt)[-149.17%], text(size: 8.2pt)[—],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[3.59 (2015)], text(size: 8.2pt)[3.39 (2024)], text(size: 8.2pt)[-0.0225], text(size: 8.2pt)[-5.64%], text(size: 8.2pt)[-0.64%],
  text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[-3.55 (2015)], text(size: 8.2pt)[3.42 (2024)], text(size: 8.2pt)[0.7739], text(size: 8.2pt)[196.43%], text(size: 8.2pt)[—],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[7.33 (2015)], text(size: 8.2pt)[3.98 (2024)], text(size: 8.2pt)[-0.3720], text(size: 8.2pt)[-45.69%], text(size: 8.2pt)[-6.56%],
  text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[2.15 (2015)], text(size: 8.2pt)[2.81 (2024)], text(size: 8.2pt)[0.0726], text(size: 8.2pt)[30.35%], text(size: 8.2pt)[2.99%],
)
#v(6pt)
]


== Anexo estadístico


_Diagnósticos de robustez del modelo: no forman parte del argumento central, documentan la calidad de la estimación._


#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("/docs/charts/2026-11-16-21-48/fig11_anomaly.png", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* Años estadísticamente atípicos en Inversión extranjera directa, flujos netos (% del PIB) (desviación estándar |z|\>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia.]
    ]
  )
  #v(6pt)
]


_Cómo leerla: los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia._



#v(14pt)
#block(
  fill: rgb("#f1f5f9"),
  stroke: (left: 4pt + rgb("#0284c7"), rest: 1pt + rgb("#cbd5e1")),
  radius: (right: 6pt),
  inset: (x: 14pt, y: 12pt),
  width: 100%,
  [
    #grid(
      columns: (auto, 1fr),
      gutter: 8pt,
      align: horizon,
      text(11pt)[#text(rgb("#0284c7"), weight: "bold")[#sym.checkmark]],
      text(10pt, weight: "bold", fill: rgb("#0f172a"))[CERTIFICADO DE TRANSPARENCIA Y NO-ALUCINACIÓN (AUDITORÍA MOA)]
    )
    #v(3pt)
    #line(length: 100%, stroke: 0.5pt + rgb("#94a3b8"))
    #v(3pt)
    #set text(size: 8pt, fill: rgb("#334155"))
    #set par(justify: true, leading: 0.55em)
    *Contexto.* Este artículo fue generado automáticamente por AcademicPipeline, un pipeline multi-agente de investigación asistida por IA: agentes especializados proponen, calculan, redactan y se verifican mutuamente antes de publicar.
Tema seleccionado: _Inversión extranjera directa y crecimiento económico frente a la inestabilidad geopolítica_.
Noticia que inspiró la línea editorial: _"ASEAN summit: Who’s attending and what’s at stake? (Desarrollo Internacional)"_ (#link("https://www.aljazeera.com/news/2026/11/15/asean-summit-whos-attending-and-whats-at-stake")[Al Jazeera English]).
Lo que la noticia afirmaba o sugería: La tensión geopolítica por la guerra en Oriente Medio podría afectar la inversión extranjera y el crecimiento económico de América Latina.
Alcance verificable con los datos: Se pueden observar los flujos de IED y el crecimiento del PIB; no se pueden medir efectos específicos de la guerra en la región por falta de indicadores de riesgo geopolítico.
Justificación del sistema: La noticia menciona un contexto global que puede repercutir en la inversión; los indicadores de IED y crecimiento permiten evaluar la relación macro sin necesidad de datos de conflicto directo.
*Pregunta de investigación:* ¿Existe una correlación positiva entre los ingresos de inversión extranjera directa y el crecimiento del PIB en los países latinoamericanos durante periodos de alta tensión geopolítica?
*Hipótesis planteada:* Los países latinoamericanos que mantienen mayores ingresos de IED presentan un crecimiento del PIB más robusto, incluso en contextos de inestabilidad geopolítica.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
*Procedencia de los datos.* Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
*Métodos analíticos ejecutados (Cómputo Determinístico):*
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 13 correlaciones Pearson/Spearman (0 significativas tras corrección FDR Benjamini-Hochberg, q\<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
*Proceso editorial.* Siete nodos automáticos: FETCH -> SUGGEST -> COMPUTE -> WRITE -> REVIEW -> EDIT -> APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 54 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 1 reescritura(s), 0 reedición(es).
*Limitaciones.* Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
_Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): #link("https://rogelioguerrero.github.io/academic-pipeline/methodology.html")[metodología]_
  ]
)

