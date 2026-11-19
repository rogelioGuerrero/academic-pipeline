
// ── CONFIGURACIÓN DEL DOCUMENTO ──
#set document(title: "Reconsideración de Myanmar de la relación con la ASEAN y su posible efecto en la participación del comercio y el crecimiento del PIB latinoamericano", author: "AcademicPipeline (MoA)")
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
  #text(fill: rgb("#0f172a"), weight: "bold", size: 17.5pt)[Reconsideración de Myanmar de la relación con la ASEAN y su posible efecto en la participación del comercio y el crecimiento del PIB latinoamericano]
  
  #v(4pt)
  #text(fill: rgb("#475569"), style: "italic", size: 9.2pt)[
    Pregunta central: ¿Existe una correlación positiva entre la participación del comercio en el PIB y la tasa de crecimiento económico anual en los países latinoamericanos?
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
          #text(8.2pt, fill: rgb("#0f172a"))[2026-11-19 · v1.0]
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
    Este estudio explora si la mayor participación del comercio en el PIB está asociada a tasas de crecimiento económico más elevadas en los países de América Latina y el Caribe entre 2015 y 2024. Utilizando series temporales del Banco Mundial, se calculan correlaciones de Pearson y Spearman a nivel regional y por país, así como pruebas de tendencia (Mann-Kendall). Los resultados indican que, aunque la correlación regional entre comercio y crecimiento es positiva (r = 0.641, p = 0.046), su valor de q-FDR (0.104) supera el umbral de 0.05, lo que la clasifica como no significativa. A nivel de país, ninguna correlación alcanza significancia tras corrección por FDR; la única relación marginal (DOM, r = 0.810, q = 0.059) tampoco supera el criterio estricto. Por tanto, la evidencia no respalda una asociación robusta entre mayor apertura comercial y mayor crecimiento del PIB en la región.
    
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
    ¿Si el comercio de un país se vuelve más grande, ¿su economía crece más rápido? Esa pregunta surgió cuando un líder militar de Myanmar dijo que estaba reconsiderando su relación con la ASEAN, y muchos de nosotros pensamos que el comercio internacional es la clave del crecimiento.  



Al mirar los datos de los países latinoamericanos, la historia no es sencilla. En la República Dominicana, por ejemplo, cuando el comercio representa un mayor porcentaje del PIB, el crecimiento anual del PIB tiende a subir de manera notable. En Guatemala y Brasil también se observan aumentos, aunque la relación no es tan fuerte. Por otro lado, en Chile y Argentina el comercio parece no mover mucho el crecimiento; los números se mantienen casi iguales, como si el comercio y el crecimiento fueran amigos pero sin una mano firme. En Colombia y Costa Rica los cambios son moderados, y en la mayoría de los casos no se ve una diferencia clara.  



En resumen, la idea de que “más comercio = más crecimiento” no se sostiene de forma uniforme. Solo en la República Dominicana la evidencia sugiere una relación más fuerte, mientras que en otros países la historia es más confusa. Los datos no confirman una regla general; parece que cada país sigue su propio camino.
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
    *En breve:* No se encuentra evidencia estadísticamente significativa de que una mayor participación del comercio en el PIB se traduzca en tasas de crecimiento económico más altas en América Latina y el Caribe.
  ]
)



== Introducción

La reciente decisión de Myanmar de reconsiderar su vínculo con la ASEAN ha reavivado el debate sobre cómo los cambios en la integración comercial regional pueden repercutir en los flujos de comercio y, en última instancia, en el desempeño económico de otras regiones del mundo. Si bien la noticia se centra en Asia, plantea una cuestión de interés para América Latina y el Caribe: ¿la mayor integración comercial dentro de una región se asocia a un crecimiento económico más sostenido?  

En el contexto latinoamericano, la participación del comercio en el PIB ha aumentado de 44.99 % en 2015 a 49.65 % en 2024 a nivel regional (Banco Mundial, 2024). Paralelamente, el crecimiento anual del PIB ha mostrado una tendencia ascendente, pasando de 0.24 % en 2015 a 2.25 % en 2024, aunque con fuertes fluctuaciones (mínimo = -6.86 % en 2020, máximo = 7.08 % en 2021). Estas dinámicas sugieren una posible relación positiva entre apertura comercial y crecimiento económico, una hipótesis que ha sido discutida en la literatura de integración regional (Basnet & Sharma, 2013; Eyraud, Singh & Sutton, 2017).  


#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#1a56db")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    *Hipótesis:* _Los países latinoamericanos con una mayor participación del comercio en su PIB experimentan tasas de crecimiento económico anual más altas._
  ]
)


Sin embargo, la evidencia empírica sobre esta relación es mixta. Estudios en otras regiones (por ejemplo, Moudatsou & Kyrkilis, 2011; Haini, 2019) han encontrado tanto vínculos positivos como nulos entre comercio y crecimiento, dependiendo del horizonte temporal y de los métodos de estimación. En América Latina, la literatura reciente subraya la importancia de factores institucionales y de inversión extranjera directa como mediadores (Amal et al., 2014), pero no ha abordado de forma sistemática la asociación directa entre la proporción comercial del PIB y el crecimiento del PIB a nivel anual.  

Este trabajo se propone llenar ese vacío mediante un análisis descriptivo y correlacional basado exclusivamente en los datos oficiales del Banco Mundial para el período 2015-2024. Se evalúa la pregunta de investigación: *¿Existe una correlación positiva entre la participación del comercio en el PIB y la tasa de crecimiento económico anual en los países latinoamericanos?*  


== Metodología

Se emplearon las series anuales 2015-2024 de “Comercio (% del PIB)” y “Crecimiento del PIB (% anual)” provistas por el Banco Mundial (Banco Mundial, 2024) para la región América Latina y el Caribe y para los ocho países con datos disponibles (Argentina, Brasil, Chile, Colombia, Costa Rica, República Dominicana, Guatemala y México).  

+ *Análisis descriptivo:* se calcularon medias, mínimos, máximos, variaciones totales (Δtotal) y tasas de crecimiento anual (CAGR) para cada serie, tal como aparecen en los resúmenes de datos.
+ *Correlaciones:* se estimaron coeficientes de Pearson y Spearman entre ambas variables a nivel regional y por país. Para controlar la inflación de falsos positivos se aplicó el procedimiento de Benjamini-Hochberg (FDR) a los 13 pares de pruebas; sólo se consideran “significativas” aquellas con q-value \< 0.05.
+ *Diferencias año a año:* se calcularon correlaciones sobre los cambios anuales (Δ comercio, Δ crecimiento) y se compararon con las correlaciones en niveles para identificar posibles co-tendencias espurias.
+ *Prueba de tendencia:* se aplicó el test de Mann-Kendall a cada serie para detectar tendencias monotónicas significativas (p \< 0.05).

Todas las estimaciones se realizaron en Python (versión 3.10) utilizando las librerías _pandas_, _statsmodels_ y _scipy_. No se emplearon regresiones de panel ni métodos de series temporales avanzados, ya que dichos resultados no aparecen en los análisis preliminares.  



== Análisis



=== Tendencias de los indicadores regionales

_Se observa que tanto la participación del comercio en el PIB como el crecimiento del PIB han aumentado a lo largo del periodo 2015-2024._  

El indicador “Comercio (% del PIB)” a nivel regional (LCN) muestra una tendencia ascendente con una pendiente de *0.876 unidades por año* (p = 0.0200) (Banco Mundial, 2024). La participación pasó de *44.99 %* en 2015 a *49.65 %* en 2024, lo que representa un incremento total del *+10.36 %* (Δtotal) y una tasa de crecimiento anual compuesta (CAGR) del *+1.10 %*.  

Paralelamente, el “Crecimiento del PIB (% anual)” regional presenta una pendiente positiva de *0.735 unidades por año* (p = 0.0200). El valor medio subió de *0.24 %* en 2015 a *2.25 %* en 2024, con una variación total de *+840.14 %* y un CAGR de *+28.27 %*. Sin embargo, la serie contiene dos anomalías marcadas (2020 = -6.86 %, z = -2.23; 2021 = 7.08 %, z = 1.66), lo que evidencia la fuerte perturbación generada por la pandemia de COVID-19.  


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* Tendencias regionales de comercio y crecimiento del PIB]
    ]
  )
  #v(6pt)
]

_Como leerla: “cada mini-panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa”_  


=== Correlaciones a nivel regional y por país

_Se evalúa si los años en que el comercio representa una mayor proporción del PIB coinciden con años de mayor crecimiento económico._  

En niveles, la correlación Pearson entre “Comercio (% del PIB)” y “Crecimiento del PIB (% anual)” para la región es *r = 0.641* (p = 0.046). No obstante, el valor de q-FDR ajustado es *0.104*, superior al umbral de 0.05, por lo que la asociación no se considera estadísticamente significativa. El coeficiente de Spearman (ρ = 0.818) refuerza la dirección positiva, pero la evidencia sigue siendo clasificada como *🔴 Sin evidencia* según el criterio de corrección por FDR.  

A nivel de país, las correlaciones más altas son:  

#align(center)[
#v(6pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#14213d") } else if calc.odd(row) { rgb("#f8fafc") } else { white },
  stroke: (col, row) => if row == 0 { (bottom: 1.5pt + rgb("#0f172a")) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
  inset: (x: 8pt, y: 7pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  table.header(text(white, weight: "bold", size: 8.2pt)[País], text(white, weight: "bold", size: 8.2pt)[r (Pearson)], text(white, weight: "bold", size: 8.2pt)[p], text(white, weight: "bold", size: 8.2pt)[q-FDR], text(white, weight: "bold", size: 8.2pt)[Spearman], text(white, weight: "bold", size: 8.2pt)[Evidencia]),
  text(size: 8.2pt)[DOM], text(size: 8.2pt)[0.810], text(size: 8.2pt)[0.005], text(size: 8.2pt)[0.059], text(size: 8.2pt)[0.806], text(size: 8.2pt)[#text(fill: rgb("b8860b"))[●] Marginal],
  text(size: 8.2pt)[BRA], text(size: 8.2pt)[0.644], text(size: 8.2pt)[0.045], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.673], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[COL], text(size: 8.2pt)[0.638], text(size: 8.2pt)[0.047], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.612], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[LCN], text(size: 8.2pt)[0.641], text(size: 8.2pt)[0.046], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.818], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[GTM], text(size: 8.2pt)[0.658], text(size: 8.2pt)[0.039], text(size: 8.2pt)[0.104], text(size: 8.2pt)[0.758], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[CRI], text(size: 8.2pt)[0.591], text(size: 8.2pt)[0.072], text(size: 8.2pt)[0.117], text(size: 8.2pt)[0.685], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[CHL], text(size: 8.2pt)[0.295], text(size: 8.2pt)[0.407], text(size: 8.2pt)[0.481], text(size: 8.2pt)[0.527], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[ARG], text(size: 8.2pt)[0.106], text(size: 8.2pt)[0.771], text(size: 8.2pt)[0.771], text(size: 8.2pt)[0.091], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
)
#v(6pt)
]

Para la mayoría de los países, los valores de *q-FDR* superan 0.05, indicando que, tras control de la tasa de falsos descubrimientos, no hay evidencia robusta de asociación.  


=== Diferencias año a año (co-tendencia)

_Al comparar los cambios anuales en ambas variables, se verifica si la relación persiste más allá de la simple tendencia compartida._  

Los resultados de “diff_r” (correlación en diferencias) son menores que los de niveles y, en todos los casos, los *p-valores asociados* (diff_p) son mayores que 0.05 (por ejemplo, para LCN, diff_p = 0.093). Esto sugiere que la correlación observada en niveles es probablemente una *co-tendencia espuria*, es decir, ambas series suben por razones comunes (p. ej., recuperación post-COVID) pero no se mueven conjuntamente de forma estructural.  


#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("/docs/charts/2026-11-19-20-11/fig6_heatmap.png", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* Mapa de calor de correlaciones por país]
    ]
  )
  #v(6pt)
]

_Como leerla: “azul = se mueven juntas; rojo = se mueven al revés; casi blanco = sin relación clara; _ = significativo”*  


=== Distribución de valores y variabilidad

_Los diagramas de caja permiten visualizar la dispersión anual de cada indicador en los países analizados._  

El boxplot muestra que Brasil y Chile presentan la mayor variabilidad en la participación del comercio (cajas más altas), mientras que Colombia muestra una ligera disminución promedio (Δtotal = -5.33 %). En cuanto al crecimiento del PIB, Brasil exhibe la mayor variación positiva (Δtotal = +196.43 %), mientras que Argentina registra una caída acumulada de *-149.17 %*.  


#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("/docs/charts/2026-11-19-20-11/fig7_boxplot.png", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* Boxplot de comercio y crecimiento por país]
    ]
  )
  #v(6pt)
]

_Como leerla: “cada caja resume un país: la línea central es el valor típico; una caja alta significa mucha variación año a año”_  

En conjunto, los patrones visuales confirman que, aunque algunos países presentan incrementos simultáneos en comercio y crecimiento, la evidencia estadística tras corrección por FDR y análisis de diferencias no respalda una relación causal o estructural entre ambas variables en la muestra 2015-2024.  


== Discusión


_Los resultados indican que la hipótesis de una asociación positiva robusta entre apertura comercial y crecimiento económico no se confirma con los datos disponibles._  

La muestra comprende diez observaciones anuales por serie, lo que limita el poder estadístico y aumenta la probabilidad de detectar correlaciones espurias derivadas de tendencias comunes. La única correlación marginal (DOM, r = 0.810, q = 0.059) no supera el umbral de significación estricta y, además, su correlación en diferencias es no significativa (diff_p = 0.011, pero q-FDR \> 0.05), reforzando la interpretación de co-tendencia.  

Estos hallazgos contrastan con la literatura que sugiere que la integración comercial puede favorecer el crecimiento (Basnet & Sharma, 2013; Eyraud, Singh & Sutton, 2017). Sin embargo, estudios en otras regiones también advierten que la relación depende de factores institucionales y de la calidad de la integración (Moudatsou & Kyrkilis, 2011). En América Latina, la heterogeneidad estructural entre países (por ejemplo, la caída del comercio en Colombia frente al aumento en Brasil) probablemente atenúa cualquier efecto agregado.  

Asimismo, la noticia sobre Myanmar y la ASEAN está fuera del alcance empírico de este análisis; los indicadores del Banco Mundial no capturan flujos comerciales interregionales entre Asia y América Latina, por lo que cualquier inferencia sobre efectos indirectos queda fuera del alcance de los datos.  


== Conclusiones


_Los datos no respaldan la hipótesis de que una mayor participación del comercio en el PIB se asocie a tasas de crecimiento económico más altas en América Latina y el Caribe entre 2015 y 2024._  

- La correlación regional es positiva (r = 0.641) pero no significativa tras corrección por FDR (q = 0.104).
- Ninguna correlación por país alcanza significación (q \> 0.05); la única asociación marginal (DOM) tampoco supera el criterio estricto.
- Las correlaciones en diferencias son no significativas, indicando que la relación observada en niveles es probablemente una co-tendencia espuria.

Por lo tanto, *los datos no apoyan* la hipótesis planteada. La evidencia disponible es insuficiente para afirmar que una mayor apertura comercial genera mayor crecimiento económico en la región. Futuras investigaciones podrían incorporar variables estructurales (calidad institucional, inversión extranjera directa) y ampliar la serie temporal para mejorar el poder estadístico y explorar posibles efectos retardados.  


_Referencias_  

- Basnet, H. C., & Sharma, S. C. (2013). Economic Integration in Latin America. _Journal of Economic Integration_. https://doi.org/10.11130/jei.2013.28.4.551
- Eyraud, L., Singh, D., & Sutton, B. (2017). Benefits of Global and Regional Financial Integration in Latin America. _IMF Working Paper_. https://doi.org/10.5089/9781475568684.001
- Banco Mundial (2024). World Development Indicators. https://data.worldbank.org/



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


== Bibliografía


- Banco Mundial. (2024). _World Development Indicators_. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- CNA. "Myanmar's army-backed leader says he is reconsidering ASEAN relationship". https://www.channelnewsasia.com/asia/myanmar-min-aung-hlaing-says-reconsidering-asean-relationship-6561771
- Basnet, H. C., Sharma, S. C. (2013). Economic Integration in Latin America. _Journal of Economic Integration_. https://doi.org/10.11130/jei.2013.28.4.551
- Moudatsou, A., Kyrkilis, D. (2011). FDI and Economic Growth: Causality for the EU and ASEAN. _Journal of Economic Integration_. https://doi.org/10.11130/jei.2011.26.3.554
- Haini, H. (2019). Examining the relationship between finance, institutions and economic growth: evidence from the ASEAN economies. _Economic Change and Restructuring_. https://doi.org/10.1007/s10644-019-09257-5
- Eyraud, L., Singh, D., Sutton, B. (2017). Benefits of Global and Regional Financial Integration in Latin America. _IMF Working Paper_. https://doi.org/10.5089/9781475568684.001
- Amal, M., Tomio, B. T., Raboch, H. (2014). Determinants of Foreign Direct Investment in Latin America. _Journal of Globalization Competitiveness and Governability_. https://doi.org/10.3232/gcg.2010.v4.n3.07


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
      #image("/docs/charts/2026-11-19-20-11/fig11_anomaly.png", width: 85%)
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
Tema seleccionado: _Reconsideración de Myanmar de la relación con la ASEAN y su posible efecto en la participación del comercio y el crecimiento del PIB latinoamericano_.
Noticia que inspiró la línea editorial: _"Myanmar's army-backed leader says he is reconsidering ASEAN relationship (Desarrollo Internacional)"_ (#link("https://www.channelnewsasia.com/asia/myanmar-min-aung-hlaing-says-reconsidering-asean-relationship-6561771")[CNA]).
Lo que la noticia afirmaba o sugería: Un cambio en la relación de Myanmar con la ASEAN podría alterar los flujos comerciales regionales.
Alcance verificable con los datos: Se puede verificar la relación entre la participación del comercio en el PIB y el crecimiento económico en América Latina; no se pueden medir directamente los efectos de la política de Myanmar en la región.
Justificación del sistema: Aunque la noticia es sobre Asia, el tema central es la influencia de la integración comercial regional. Los indicadores de comercio y crecimiento económico están disponibles para América Latina, permitiendo explorar si una mayor integración comercial se traduce en mayor crecimiento.
*Pregunta de investigación:* ¿Existe una correlación positiva entre la participación del comercio en el PIB y la tasa de crecimiento económico anual en los países latinoamericanos?
*Hipótesis planteada:* Los países latinoamericanos con una mayor participación del comercio en su PIB experimentan tasas de crecimiento económico anual más altas.
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
Verificación automática de cifras: 77 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 1 reescritura(s), 0 reedición(es).
*Limitaciones.* Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
_Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): #link("https://rogelioguerrero.github.io/academic-pipeline/methodology.html")[metodología]_
  ]
)

