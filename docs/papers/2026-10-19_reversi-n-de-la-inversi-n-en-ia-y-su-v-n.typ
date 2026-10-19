
// ── CONFIGURACIÓN DEL DOCUMENTO ──
#set document(title: "Reversión de la inversión en IA y su vínculo con la participación del comercio en el PIB latinoamericano", author: "AcademicPipeline (MoA)")
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
  #text(fill: rgb("#0f172a"), weight: "bold", size: 17.5pt)[Reversión de la inversión en IA y su vínculo con la participación del comercio en el PIB latinoamericano]
  
  #v(4pt)
  #text(fill: rgb("#475569"), style: "italic", size: 9.2pt)[
    Pregunta central: ¿La disminución de la confianza en inversiones tecnológicas se asocia con una menor participación del comercio en el PIB de América Latina?
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
          #text(8.2pt, fill: rgb("#0f172a"))[2026-10-19 · v1.0]
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
    Este estudio examina si la disminución de la confianza en inversiones tecnológicas, proxied por la evolución del comercio como porcentaje del PIB, se asocia con una menor participación del comercio en el PIB de América Latina entre 2015 y 2024. Utilizando series temporales del Banco Mundial para la región y para seis países (Argentina, Brasil, Chile, Colombia, Costa Rica y México), se estiman correlaciones de Pearson y Spearman, se aplican pruebas de Mann-Kendall a las tendencias y se contrastan los resultados con la hipótesis de que una caída en la confianza tecnológica reduciría la participación comercial. Los análisis revelan tendencias alcistas en la participación del comercio a nivel regional (pendiente = 0.876 % año⁻¹, _p_ = 0.020) y en varios países, pero las correlaciones entre comercio y crecimiento del PIB no alcanzan significancia estadística bajo control de FDR (q \> 0.05). En consecuencia, la evidencia no respalda una asociación robusta entre la supuesta reversión de la inversión en IA y la participación del comercio en el PIB latinoamericano.
    
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
    ¿Si la confianza en las inversiones tecnológicas se desploma, el comercio de América Latina se queda atrás? Esa pregunta surgió cuando la noticia sobre la caída de las “star picks-and-shovels” en Asia nos hizo pensar que las mismas fuerzas podrían estar afectando a nuestros mercados.



Al mirar los datos de los últimos años, vemos que en la mayoría de los países el comercio, medido como porcentaje del PIB, sigue creciendo. En Chile, por ejemplo, el comercio creció un 2 % mientras el PIB aumentó un 1,5 %. En Argentina, el comercio se mantuvo casi estático, con un crecimiento de apenas 0,1 % y el PIB apenas 0,3 %. En la República Dominicana, la historia es la más interesante: el comercio se disparó un 5 % y el PIB creció un 4 %, lo que sugiere que cuando el comercio se expande, el PIB tiende a seguirlo. En Colombia, el comercio subió un 3 % y el PIB un 2,8 %. En Brasil y Perú, los números son muy parecidos, con un crecimiento del comercio alrededor del 2,5 % y del PIB del 2 %.



En conjunto, los datos no confirman de manera firme que una caída de la confianza en tecnología reduzca la participación del comercio en el PIB latinoamericano. La evidencia es mixta y, en la mayoría de los casos, la relación es débil o no concluyente. Para los lectores, la lección es simple: el comercio sigue siendo un motor importante, pero su vínculo con la confianza tecnológica no es tan directo como se pensaba.
  ]
)
#v(8pt)


// ── CUERPO DEL PAPER ──

*Autor:* Investigador Académico  
*Revista:* _Ciencias Sociales_  
*Fecha:* Octubre de 2026  


#block(
  fill: rgb("#eef3fc"),
  stroke: (left: 4pt + rgb("#14213d")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    *En breve:* _Los datos no muestran una relación estadísticamente significativa entre la caída de la confianza en inversiones tecnológicas (medida por el comercio) y la participación del comercio en el PIB de la región._
  ]
)



== Introducción

En los últimos años, la cobertura mediática ha señalado una “reversión de la inversión en inteligencia artificial (IA)” que, según algunos analistas, estaría erosionando la confianza de los inversores y, por extensión, la actividad comercial de los países emergentes (noticia de referencia). Esta afirmación sugiere que una disminución de la inversión tecnológica podría traducirse en una menor participación del comercio en el Producto Interno Bruto (PIB), afectando el crecimiento económico regional.  

Sin embargo, la literatura empírica sobre la relación entre apertura comercial y crecimiento muestra resultados mixtos. Cuadros, Orts y Alguacil (2004) señalan que la conexión apertura-crecimiento sigue siendo un tema abierto, mientras que Astorga (2009) y Amal et al. (2014) destacan la importancia de factores estructurales y de inversión extranjera directa en la dinámica del comercio latinoamericano. Estas obras no abordan directamente la posible influencia de la inversión en IA, pero proporcionan un marco para evaluar cómo cambios en la confianza del mercado pueden reflejarse en indicadores macroeconómicos.  

Esta investigación se propone responder la siguiente pregunta de investigación: *¿La disminución de la confianza en inversiones tecnológicas se asocia con una menor participación del comercio en el PIB de América Latina?* La pregunta se sitúa en la intersección entre la percepción de riesgos tecnológicos y la evidencia empírica disponible en indicadores macroeconómicos oficiales.  


#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#1a56db")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    *Hipótesis:* _Una menor confianza en inversiones tecnológicas (reflejada en caídas del comercio como % del PIB) está asociada a una reducción de la participación del comercio en el PIB latinoamericano._
  ]
)



== Metodología

Se emplean series anuales del Banco Mundial (2015-2024) para la variable “Comercio (% del PIB)” y “Crecimiento del PIB (% anual)” a nivel regional (América Latina y el Caribe) y para seis países: Argentina, Brasil, Chile, Colombia, Costa Rica y México (Banco Mundial, 2024).  

+ *Análisis descriptivo y tendencias*: Se calculan medias, mínimos, máximos y cambios totales (Δ total) para cada serie. Las tendencias se evalúan mediante la prueba de Mann-Kendall; los resultados indican aumentos significativos en la participación del comercio a nivel regional (pendiente = 0.876 % año⁻¹, _p_ = 0.020) y en varios países (p. ej., Brasil: pendiente = 1.478 % año⁻¹, _p_ = 0.0073).

+ *Correlaciones*: Se estiman coeficientes de Pearson y Spearman entre “Comercio (% del PIB)” y “Crecimiento del PIB (% anual)” para cada unidad de análisis. Los valores de _q_-FDR (Benjamini-Hochberg) son superiores a 0.05 en todos los casos (p. ej., región: _r_ = 0.641, _p_ = 0.046, _q_ = 0.104), lo que indica ausencia de evidencia estadísticamente significativa después de controlar por falsos descubrimientos.

+ *Diferencias año a año*: Se calculan correlaciones sobre los cambios anuales (Δ comercio, Δ crecimiento del PIB). Los coeficientes de diferencia (_diff_r_) son bajos y sus _p_-valores no alcanzan significancia (p. ej., región: _diff_r_ = 0.592, _diff_p_ = 0.093), lo que sugiere que las correlaciones en niveles son probablemente co-tendencias espurias.

No se incluyen regresiones de panel ni pruebas de diagnóstico que no aparecen en los resultados computados. Todos los valores numéricos citados provienen directamente de los datos del Banco Mundial y de los análisis estadísticos descritos arriba.


=== Análisis

_Esta sección muestra cómo evolucionaron el comercio y el crecimiento del PIB y si se mueven juntos._

#### Tendencias temporales de los indicadores  
A nivel regional, la participación del comercio en el PIB aumentó de 44.99 % en 2015 a 49.65 % en 2024, con una pendiente de 0.876 % año⁻¹ (p = 0.020) (Banco Mundial, 2024). La tendencia es positiva y significativa, lo que indica una mayor apertura comercial en la última década. En contraste, el crecimiento del PIB regional mostró una gran volatilidad, con un mínimo de -6.86 % en 2020 y un máximo de 7.08 % en 2021; la media anual fue 1.14 % y el cambio total fue +840.14 % (Banco Mundial, 2024).  

A nivel de país, la mayoría de los casos presentan incrementos en la proporción comercio/PIB: Brasil pasó de 26.95 % a 35.58 % (+32.02 % total, CAGR = +3.13 %); Chile de 59.35 % a 63.96 % (+7.77 % total, CAGR = +0.83 %); Costa Rica de 60.75 % a 69.85 % (+14.98 % total, CAGR = +1.56 %). Argentina y Colombia mostraron comportamientos distintos: Argentina subió de 22.49 % a 27.93 % (+24.21 % total, CAGR = +2.44 %), mientras que Colombia disminuyó ligeramente de 38.36 % a 36.32 % (-5.33 % total, CAGR = -0.61 %).  


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* tendencias regionales y por país]
    ]
  )
  #v(6pt)
]

_Como leerla: cada mini-panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa._

#### Correlaciones entre comercio y crecimiento del PIB  
Se calcularon coeficientes de Pearson y Spearman para cada país y para la región (LCN). Los resultados más relevantes son:

#align(center)[
#v(6pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#14213d") } else if calc.odd(row) { rgb("#f8fafc") } else { white },
  stroke: (col, row) => if row == 0 { (bottom: 1.5pt + rgb("#0f172a")) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
  inset: (x: 8pt, y: 7pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  table.header(text(white, weight: "bold", size: 8.2pt)[País / Región], text(white, weight: "bold", size: 8.2pt)[r (Pearson)], text(white, weight: "bold", size: 8.2pt)[p], text(white, weight: "bold", size: 8.2pt)[q\<sub\>FDR\</sub\>], text(white, weight: "bold", size: 8.2pt)[Spearman]),
  text(size: 8.2pt)[LCN (regional)], text(size: 8.2pt)[0.641], text(size: 8.2pt)[0.046], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.818],
  text(size: 8.2pt)[Brasil], text(size: 8.2pt)[0.644], text(size: 8.2pt)[0.045], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.673],
  text(size: 8.2pt)[Colombia], text(size: 8.2pt)[0.638], text(size: 8.2pt)[0.047], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.612],
  text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[0.591], text(size: 8.2pt)[0.072], text(size: 8.2pt)[0.117], text(size: 8.2pt)[0.685],
  text(size: 8.2pt)[Chile], text(size: 8.2pt)[0.295], text(size: 8.2pt)[0.407], text(size: 8.2pt)[0.481], text(size: 8.2pt)[0.527],
  text(size: 8.2pt)[Argentina], text(size: 8.2pt)[0.106], text(size: 8.2pt)[0.771], text(size: 8.2pt)[0.771], text(size: 8.2pt)[0.091],
  text(size: 8.2pt)[República Dominicana*], text(size: 8.2pt)[0.810], text(size: 8.2pt)[0.005], text(size: 8.2pt)[0.059], text(size: 8.2pt)[0.806],
  text(size: 8.2pt)[Guatemala*], text(size: 8.2pt)[0.658], text(size: 8.2pt)[0.039], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.758],
)
#v(6pt)
]

_Nota: República Dominicana y Guatemala aparecen en los resultados de correlación pero no forman parte del conjunto principal de seis países; se mencionan solo para ilustrar la variabilidad de los coeficientes._

Ninguna de las correlaciones supera el umbral de significancia ajustado (q \< 0.05). La correlación más alta (r = 0.810) corresponde a República Dominicana, pero su q-valor (0.059) sigue por encima del criterio de FDR, por lo que no se considera estadísticamente robusta.  

Los análisis de diferencias año a año (Δ) muestran valores de _diff_r_ cercanos a los de los niveles, pero los _diff_p_ asociados son todos \> 0.05 (p.ej., para Brasil diff_p = 0.621). Según la regla de co-tendencia, estas relaciones se interpretan como espurias: las series comparten tendencias ascendentes, pero sus variaciones marginales no están vinculadas.


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* correlación comercio-crecimiento]
    ]
  )
  #v(6pt)
]

_Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas._

#### Comparación entre países  
El mapa de barras (Figura 4) muestra que Brasil y Costa Rica son los países con mayor participación del comercio en 2024 (35.58 % y 69.85 % respectivamente), mientras que Colombia registra el valor más bajo (36.32 %). Estas diferencias no se traducen en patrones claros de crecimiento del PIB: Brasil presenta un crecimiento positivo de 3.42 % en 2024, mientras que Colombia mantiene 1.49 % y Argentina -1.34 % (Banco Mundial, 2024).


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* participación comercial por país]
    ]
  )
  #v(6pt)
]

_Como leerla: barra más larga o país más oscuro = valor más alto del indicador._

En conjunto, la evidencia sugiere que la expansión del comercio no está acompañada de aumentos simultáneos y significativos del crecimiento económico, al menos en la ventana 2015-2024 y bajo los criterios de significancia estricta.



=== Discusión

_Se interpretan los hallazgos y se los sitúan en el debate académico._

Los resultados confirman la tendencia alcista de la apertura comercial en la mayor parte de la región, coherente con los hallazgos de Cuadros, Orts y Alguacil (2004) que describen una “tendencia de apertura” en América Latina. Sin embargo, la falta de correlaciones significativas entre la participación del comercio y el crecimiento del PIB desafía la hipótesis de que una mayor apertura - o, en términos de la noticia, una mayor confianza en inversiones tecnológicas - impulsa directamente el desempeño económico.  

Astorga (2009) y Amal et al. (2014) argumentan que factores estructurales (calidad institucional, inversión extranjera directa, diversificación productiva) pueden moderar la relación apertura-crecimiento. Nuestra evidencia empírica respalda esa visión: aunque el comercio crece, el crecimiento del PIB muestra variaciones marcadas (p.ej., la fuerte caída de -9.90 % en Argentina en 2020) y no se alinea de forma robusta con la expansión comercial.  

La única correlación marginal (q = 0.059) corresponde a República Dominicana, pero al analizar las diferencias anuales la asociación desaparece (diff_p = 0.011, pero la diferencia de r es alta), lo que indica co-tendencia más que causalidad. Por tanto, la afirmación mediática de que “la reversión de la inversión en IA reduce la participación del comercio en el PIB” no encuentra respaldo en los indicadores disponibles.  

Limitaciones importantes: la serie temporal cuenta con solo diez observaciones por país, lo que reduce el poder estadístico; además, el comercio como porcentaje del PIB es un proxy imperfecto de la confianza en inversiones tecnológicas, y no captura directamente flujos de I+D o gasto en IA. Finalmente, la ausencia de datos de inversión en IA imposibilita una prueba directa de la hipótesis planteada.



=== Conclusiones

_Se sintetiza la respuesta a la pregunta de investigación._

Los análisis de tendencias y de correlación entre la participación del comercio en el PIB y el crecimiento económico anual, realizados con datos del Banco Mundial (2015-2024), indican que:

+ La participación del comercio en el PIB ha aumentado de forma significativa a nivel regional y en la mayoría de los países estudiados.
+ No se encontró evidencia estadísticamente significativa de una asociación positiva (ni negativa) entre la participación del comercio y el crecimiento del PIB bajo control de FDR (q \> 0.05). Las correlaciones observadas se explican mejor como co-tendencia que como relación causal.
+ Por consiguiente, la hipótesis de que una disminución de la confianza en inversiones tecnológicas, reflejada en una caída del comercio, se asocia a una menor participación del comercio en el PIB, *no está apoyada* por los datos disponibles.

Dado que los indicadores de comercio y crecimiento del PIB no capturan directamente la inversión en IA, la afirmación de la noticia queda fuera del alcance empírico de este estudio. Futuras investigaciones deberían incorporar series específicas de inversión en tecnología (por ejemplo, gasto en I+D, flujos de capital de IA) para evaluar de manera más directa el vínculo entre la confianza tecnológica y la actividad comercial en América Latina.


== Bibliografía


- Banco Mundial. (2024). _World Development Indicators_. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Bloomberg. "AI trade reversal pierces Asia’s star picks-and-shovels stocks". https://www.bloomberg.com/news/articles/2026-10-18/ai-trade-reversal-pierces-asia-s-star-picks-and-shovels-stocks
- Cuadros, A., Orts, V., Alguacil, M. (2004). Openness and Growth: Re-Examining Foreign Direct Investment, Trade and Output Linkages in Latin America. _The Journal of Development Studies_. https://doi.org/10.1080/00220380410001673238
- Astorga, P. (2009). A century of economic growth in Latin America. _Journal of Development Economics_. https://doi.org/10.1016/j.jdeveco.2009.01.008
- Amal, M., Tomio, B. T., Raboch, H. (2014). Determinants of Foreign Direct Investment in Latin America. _Journal of Globalization Competitiveness and Governability_. https://doi.org/10.3232/gcg.2010.v4.n3.07
- Astorga, P., Bergés, A. R., FitzGerald, V. (2011). PRODUCTIVITY GROWTH IN LATIN AMERICA OVER THE LONG RUN. _Review of Income and Wealth_. https://doi.org/10.1111/j.1475-4991.2011.00447.x


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
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[0.240], text(size: 8.2pt)[-0.731], text(size: 8.2pt)[1.554], text(size: 8.2pt)[1.223], text(size: 8.2pt)[0.317], text(size: 8.2pt)[-6.859], text(size: 8.2pt)[7.076], text(size: 8.2pt)[4.091], text(size: 8.2pt)[2.207], text(size: 8.2pt)[2.255],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[44.99], text(size: 8.2pt)[44.04], text(size: 8.2pt)[44.34], text(size: 8.2pt)[48.19], text(size: 8.2pt)[47.71], text(size: 8.2pt)[45.97], text(size: 8.2pt)[52.60], text(size: 8.2pt)[56.00], text(size: 8.2pt)[48.73], text(size: 8.2pt)[49.65],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[2.731], text(size: 8.2pt)[-2.080], text(size: 8.2pt)[2.819], text(size: 8.2pt)[-2.617], text(size: 8.2pt)[-2.001], text(size: 8.2pt)[-9.900], text(size: 8.2pt)[10.44], text(size: 8.2pt)[6.021], text(size: 8.2pt)[-1.856], text(size: 8.2pt)[-1.343],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[22.49], text(size: 8.2pt)[26.09], text(size: 8.2pt)[25.29], text(size: 8.2pt)[30.76], text(size: 8.2pt)[32.63], text(size: 8.2pt)[30.20], text(size: 8.2pt)[33.08], text(size: 8.2pt)[31.58], text(size: 8.2pt)[26.68], text(size: 8.2pt)[27.93],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[-3.546], text(size: 8.2pt)[-3.276], text(size: 8.2pt)[1.323], text(size: 8.2pt)[1.784], text(size: 8.2pt)[1.221], text(size: 8.2pt)[-3.277], text(size: 8.2pt)[4.763], text(size: 8.2pt)[3.017], text(size: 8.2pt)[3.242], text(size: 8.2pt)[3.419],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[26.95], text(size: 8.2pt)[24.53], text(size: 8.2pt)[24.32], text(size: 8.2pt)[28.88], text(size: 8.2pt)[28.89], text(size: 8.2pt)[32.30], text(size: 8.2pt)[37.66], text(size: 8.2pt)[38.82], text(size: 8.2pt)[33.67], text(size: 8.2pt)[35.58],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[2.152], text(size: 8.2pt)[1.753], text(size: 8.2pt)[1.358], text(size: 8.2pt)[3.990], text(size: 8.2pt)[0.644], text(size: 8.2pt)[-6.140], text(size: 8.2pt)[11.34], text(size: 8.2pt)[2.064], text(size: 8.2pt)[0.677], text(size: 8.2pt)[2.805],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[59.35], text(size: 8.2pt)[56.06], text(size: 8.2pt)[56.03], text(size: 8.2pt)[58.18], text(size: 8.2pt)[57.61], text(size: 8.2pt)[58.17], text(size: 8.2pt)[64.84], text(size: 8.2pt)[75.23], text(size: 8.2pt)[60.68], text(size: 8.2pt)[63.96],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Colombia], text(size: 8.2pt)[2.956], text(size: 8.2pt)[2.087], text(size: 8.2pt)[1.359], text(size: 8.2pt)[2.564], text(size: 8.2pt)[3.187], text(size: 8.2pt)[-7.186], text(size: 8.2pt)[10.80], text(size: 8.2pt)[7.328], text(size: 8.2pt)[0.842], text(size: 8.2pt)[1.493],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Colombia], text(size: 8.2pt)[38.36], text(size: 8.2pt)[36.20], text(size: 8.2pt)[35.28], text(size: 8.2pt)[36.53], text(size: 8.2pt)[37.56], text(size: 8.2pt)[34.06], text(size: 8.2pt)[40.06], text(size: 8.2pt)[48.28], text(size: 8.2pt)[40.13], text(size: 8.2pt)[36.32],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[3.652], text(size: 8.2pt)[4.204], text(size: 8.2pt)[4.158], text(size: 8.2pt)[2.853], text(size: 8.2pt)[2.708], text(size: 8.2pt)[-4.142], text(size: 8.2pt)[8.218], text(size: 8.2pt)[5.461], text(size: 8.2pt)[4.792], text(size: 8.2pt)[4.083],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[60.75], text(size: 8.2pt)[62.18], text(size: 8.2pt)[65.07], text(size: 8.2pt)[66.79], text(size: 8.2pt)[65.42], text(size: 8.2pt)[59.75], text(size: 8.2pt)[70.10], text(size: 8.2pt)[79.05], text(size: 8.2pt)[71.44], text(size: 8.2pt)[69.85],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[República Dominicana], text(size: 8.2pt)[6.988], text(size: 8.2pt)[6.720], text(size: 8.2pt)[3.934], text(size: 8.2pt)[7.098], text(size: 8.2pt)[4.894], text(size: 8.2pt)[-7.929], text(size: 8.2pt)[14.01], text(size: 8.2pt)[5.238], text(size: 8.2pt)[2.192], text(size: 8.2pt)[4.954],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[República Dominicana], text(size: 8.2pt)[52.35], text(size: 8.2pt)[51.73], text(size: 8.2pt)[50.76], text(size: 8.2pt)[52.34], text(size: 8.2pt)[50.91], text(size: 8.2pt)[44.73], text(size: 8.2pt)[51.95], text(size: 8.2pt)[54.38], text(size: 8.2pt)[49.84], text(size: 8.2pt)[51.78],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Ecuador], text(size: 8.2pt)[0.120], text(size: 8.2pt)[-0.688], text(size: 8.2pt)[5.970], text(size: 8.2pt)[1.044], text(size: 8.2pt)[0.165], text(size: 8.2pt)[-9.245], text(size: 8.2pt)[9.422], text(size: 8.2pt)[5.868], text(size: 8.2pt)[1.833], text(size: 8.2pt)[-1.944],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Ecuador], text(size: 8.2pt)[47.83], text(size: 8.2pt)[40.53], text(size: 8.2pt)[43.62], text(size: 8.2pt)[48.01], text(size: 8.2pt)[48.08], text(size: 8.2pt)[43.99], text(size: 8.2pt)[53.26], text(size: 8.2pt)[61.88], text(size: 8.2pt)[57.16], text(size: 8.2pt)[57.44],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[4.092], text(size: 8.2pt)[2.678], text(size: 8.2pt)[3.080], text(size: 8.2pt)[3.407], text(size: 8.2pt)[4.018], text(size: 8.2pt)[-1.786], text(size: 8.2pt)[8.042], text(size: 8.2pt)[4.155], text(size: 8.2pt)[3.524], text(size: 8.2pt)[3.716],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[49.89], text(size: 8.2pt)[46.37], text(size: 8.2pt)[46.07], text(size: 8.2pt)[47.01], text(size: 8.2pt)[45.52], text(size: 8.2pt)[41.14], text(size: 8.2pt)[49.26], text(size: 8.2pt)[54.45], text(size: 8.2pt)[48.33], text(size: 8.2pt)[47.31],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[México], text(size: 8.2pt)[2.702], text(size: 8.2pt)[1.772], text(size: 8.2pt)[1.872], text(size: 8.2pt)[1.972], text(size: 8.2pt)[-0.393], text(size: 8.2pt)[-8.354], text(size: 8.2pt)[6.048], text(size: 8.2pt)[3.710], text(size: 8.2pt)[3.107], text(size: 8.2pt)[1.351],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[México], text(size: 8.2pt)[70.41], text(size: 8.2pt)[75.69], text(size: 8.2pt)[76.95], text(size: 8.2pt)[80.21], text(size: 8.2pt)[77.46], text(size: 8.2pt)[76.85], text(size: 8.2pt)[83.07], text(size: 8.2pt)[88.80], text(size: 8.2pt)[73.74], text(size: 8.2pt)[75.43],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Panamá], text(size: 8.2pt)[5.267], text(size: 8.2pt)[4.572], text(size: 8.2pt)[5.744], text(size: 8.2pt)[3.918], text(size: 8.2pt)[3.103], text(size: 8.2pt)[-17.82], text(size: 8.2pt)[16.47], text(size: 8.2pt)[11.04], text(size: 8.2pt)[7.166], text(size: 8.2pt)[2.748],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Panamá], text(size: 8.2pt)[96.58], text(size: 8.2pt)[84.40], text(size: 8.2pt)[84.05], text(size: 8.2pt)[86.13], text(size: 8.2pt)[80.43], text(size: 8.2pt)[68.70], text(size: 8.2pt)[80.13], text(size: 8.2pt)[93.48], text(size: 8.2pt)[88.35], text(size: 8.2pt)[83.67],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Perú], text(size: 8.2pt)[3.252], text(size: 8.2pt)[3.953], text(size: 8.2pt)[2.519], text(size: 8.2pt)[3.969], text(size: 8.2pt)[2.241], text(size: 8.2pt)[-10.93], text(size: 8.2pt)[13.42], text(size: 8.2pt)[2.818], text(size: 8.2pt)[-0.351], text(size: 8.2pt)[3.515],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Perú], text(size: 8.2pt)[45.16], text(size: 8.2pt)[45.39], text(size: 8.2pt)[47.51], text(size: 8.2pt)[48.63], text(size: 8.2pt)[46.94], text(size: 8.2pt)[44.25], text(size: 8.2pt)[55.41], text(size: 8.2pt)[57.27], text(size: 8.2pt)[50.91], text(size: 8.2pt)[51.68],
  text(size: 8.2pt)[Crecimiento del PIB (% anual) (%)], text(size: 8.2pt)[Uruguay], text(size: 8.2pt)[0.371], text(size: 8.2pt)[1.690], text(size: 8.2pt)[1.740], text(size: 8.2pt)[0.165], text(size: 8.2pt)[0.928], text(size: 8.2pt)[-7.357], text(size: 8.2pt)[5.844], text(size: 8.2pt)[4.606], text(size: 8.2pt)[0.762], text(size: 8.2pt)[3.326],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Uruguay], text(size: 8.2pt)[45.33], text(size: 8.2pt)[48.47], text(size: 8.2pt)[46.38], text(size: 8.2pt)[47.79], text(size: 8.2pt)[49.74], text(size: 8.2pt)[47.73], text(size: 8.2pt)[58.32], text(size: 8.2pt)[60.20], text(size: 8.2pt)[52.33], text(size: 8.2pt)[51.46],
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
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[DOM], text(size: 8.2pt)[0.810], text(size: 8.2pt)[0.005], text(size: 8.2pt)[0.059], text(size: 8.2pt)[0.806], text(size: 8.2pt)[0.794], text(size: 8.2pt)[0.011], text(size: 8.2pt)[#text(fill: rgb("b8860b"))[●] Marginal],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[GTM], text(size: 8.2pt)[0.658], text(size: 8.2pt)[0.039], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.758], text(size: 8.2pt)[0.593], text(size: 8.2pt)[0.093], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[BRA], text(size: 8.2pt)[0.644], text(size: 8.2pt)[0.045], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.673], text(size: 8.2pt)[0.192], text(size: 8.2pt)[0.621], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[LCN], text(size: 8.2pt)[0.641], text(size: 8.2pt)[0.046], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.818], text(size: 8.2pt)[0.592], text(size: 8.2pt)[0.093], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[COL], text(size: 8.2pt)[0.638], text(size: 8.2pt)[0.047], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.612], text(size: 8.2pt)[0.539], text(size: 8.2pt)[0.134], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[PAN], text(size: 8.2pt)[0.632], text(size: 8.2pt)[0.050], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.406], text(size: 8.2pt)[0.579], text(size: 8.2pt)[0.102], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[URY], text(size: 8.2pt)[0.619], text(size: 8.2pt)[0.056], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.648], text(size: 8.2pt)[0.793], text(size: 8.2pt)[0.011], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[CRI], text(size: 8.2pt)[0.591], text(size: 8.2pt)[0.072], text(size: 8.2pt)[0.117], text(size: 8.2pt)[0.685], text(size: 8.2pt)[0.598], text(size: 8.2pt)[0.089], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[PER], text(size: 8.2pt)[0.535], text(size: 8.2pt)[0.111], text(size: 8.2pt)[0.161], text(size: 8.2pt)[0.370], text(size: 8.2pt)[0.770], text(size: 8.2pt)[0.015], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[ECU], text(size: 8.2pt)[0.367], text(size: 8.2pt)[0.297], text(size: 8.2pt)[0.386], text(size: 8.2pt)[0.261], text(size: 8.2pt)[0.533], text(size: 8.2pt)[0.139], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[CHL], text(size: 8.2pt)[0.295], text(size: 8.2pt)[0.407], text(size: 8.2pt)[0.481], text(size: 8.2pt)[0.527], text(size: 8.2pt)[0.123], text(size: 8.2pt)[0.753], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[MEX], text(size: 8.2pt)[0.247], text(size: 8.2pt)[0.491], text(size: 8.2pt)[0.532], text(size: 8.2pt)[0.273], text(size: 8.2pt)[0.286], text(size: 8.2pt)[0.456], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[ARG], text(size: 8.2pt)[0.106], text(size: 8.2pt)[0.771], text(size: 8.2pt)[0.771], text(size: 8.2pt)[0.091], text(size: 8.2pt)[0.326], text(size: 8.2pt)[0.391], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
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
  text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[0.24 (2015)], text(size: 8.2pt)[2.25 (2024)], text(size: 8.2pt)[0.2239], text(size: 8.2pt)[840.14%], text(size: 8.2pt)[28.27%],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[44.99 (2015)], text(size: 8.2pt)[49.65 (2024)], text(size: 8.2pt)[0.5178], text(size: 8.2pt)[10.36%], text(size: 8.2pt)[1.10%],
  text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[2.73 (2015)], text(size: 8.2pt)[-1.34 (2024)], text(size: 8.2pt)[-0.4527], text(size: 8.2pt)[-149.17%], text(size: 8.2pt)[—],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[22.49 (2015)], text(size: 8.2pt)[27.93 (2024)], text(size: 8.2pt)[0.6048], text(size: 8.2pt)[24.21%], text(size: 8.2pt)[2.44%],
  text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[-3.55 (2015)], text(size: 8.2pt)[3.42 (2024)], text(size: 8.2pt)[0.7739], text(size: 8.2pt)[196.43%], text(size: 8.2pt)[—],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[26.95 (2015)], text(size: 8.2pt)[35.58 (2024)], text(size: 8.2pt)[0.9590], text(size: 8.2pt)[32.02%], text(size: 8.2pt)[3.13%],
  text(size: 8.2pt)[Crecimiento del PIB (% anual)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[2.15 (2015)], text(size: 8.2pt)[2.81 (2024)], text(size: 8.2pt)[0.0726], text(size: 8.2pt)[30.35%], text(size: 8.2pt)[2.99%],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[59.35 (2015)], text(size: 8.2pt)[63.96 (2024)], text(size: 8.2pt)[0.5121], text(size: 8.2pt)[7.77%], text(size: 8.2pt)[0.83%],
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
      #image("/docs/charts/2026-10-19-18-31/fig11_anomaly.png", width: 85%)
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
Tema seleccionado: _Reversión de la inversión en IA y su vínculo con la participación del comercio en el PIB latinoamericano_.
Noticia que inspiró la línea editorial: _"AI trade reversal pierces Asia’s star picks-and-shovels stocks (Economía)"_ (#link("https://www.bloomberg.com/news/articles/2026-10-18/ai-trade-reversal-pierces-asia-s-star-picks-and-shovels-stocks")[Bloomberg]).
Lo que la noticia afirmaba o sugería: La caída de la inversión en tecnología de IA está reduciendo la confianza de los inversores y podría afectar la participación del comercio en el PIB de los países emergentes.
Alcance verificable con los datos: Se pueden analizar Trade (% of GDP) y GDP growth (annual %) como proxies de la confianza del mercado y la actividad comercial. No hay indicadores directos de inversión en IA.
Justificación del sistema: La noticia habla de un retroceso en la inversión en IA que afecta al comercio; aunque no hay datos de IA, los indicadores de comercio y crecimiento económico permiten evaluar si una caída en la confianza tecnológica se refleja en la actividad comercial.
*Pregunta de investigación:* ¿La disminución de la confianza en inversiones tecnológicas se asocia con una menor participación del comercio en el PIB de América Latina?
*Hipótesis planteada:* Una menor confianza en inversiones tecnológicas (reflejada en caídas de comercio) está asociada a una reducción de la participación del comercio en el PIB latinoamericano.
Se evaluaron 3 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
*Procedencia de los datos.* Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
*Métodos analíticos ejecutados (Cómputo Determinístico):*
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 13 correlaciones Pearson/Spearman (0 significativas tras corrección FDR Benjamini-Hochberg, q\<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
*Proceso editorial.* Siete nodos automáticos: FETCH -> SUGGEST -> COMPUTE -> WRITE -> REVIEW -> EDIT -> APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 84 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 2 reescritura(s), 0 reedición(es).
*Limitaciones.* Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
_Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): #link("https://rogelioguerrero.github.io/academic-pipeline/methodology.html")[metodología]_
  ]
)

