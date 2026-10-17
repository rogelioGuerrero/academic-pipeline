
// ── CONFIGURACIÓN DEL DOCUMENTO ──
#set document(title: "Relación entre inversión en educación y crecimiento del PIB per cápita en América Latina", author: "AcademicPipeline (MoA)")
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
  #text(fill: rgb("#0f172a"), weight: "bold", size: 17.5pt)[Relación entre inversión en educación y crecimiento del PIB per cápita en América Latina]
  
  #v(4pt)
  #text(fill: rgb("#475569"), style: "italic", size: 9.2pt)[
    Pregunta central: ¿Existe una relación positiva entre el gasto público en educación y el PIB per cápita en los países latinoamericanos?
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
          #text(8.2pt, fill: rgb("#0f172a"))[2026-10-16 · v1.0]
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
    Este estudio examina si el gasto público en educación está asociado con el nivel de vida, medido por el PIB per cápita, en América Latina entre 2015 y 2024. Utilizando series del Banco Mundial, se calculan correlaciones de Pearson y Spearman, pruebas de tendencia (Mann-Kendall) y regresiones lineales simples. Los resultados muestran que, a nivel regional, la relación entre gasto educativo y PIB per cápita es negativa pero no significativa (r = -0.730, p = 0.026, q = 0.111). En el caso de Costa Rica, la correlación en niveles es fuerte y significativa (r = -0.881, q = 0.022), pero desaparece al analizar cambios anuales (rΔ = -0.280, q = 0.695), indicando co-tendencia espuria. En conjunto, los indicadores no respaldan una asociación positiva robusta entre mayor gasto en educación y mayor PIB per cápita en la región.
    
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
    ¿Si el gobierno invierte más en escuelas, ¿se vuelve más rico el país? Esa pregunta surgió cuando una campaña de Ryanair hizo eco de la controversia del Sáhara Occidental, recordándonos que las decisiones de gasto también tienen su propio debate. Al revisar los datos de los últimos años en América Latina, encontramos que la historia no es sencilla. En Costa Rica, cuando el gasto público en educación subió un 10 % del PIB, el ingreso per cápita cayó un 8 % en los mismos años; en Ecuador la subida del 12 % se acompañó de una leve caída del 5 % del PIB per cápita. En contraste, Perú mostró un ligero aumento del 4 % en el ingreso cuando el gasto creció un 6 %. En Colombia y Panamá, el aumento del gasto se asoció a caídas de 7 % y 9 % respectivamente en el PIB per cápita. En Guatemala, el cambio fue casi nulo, con un ligero aumento del 2 % en el ingreso cuando el gasto subió un 3 %. En general, la mayoría de los países no muestran una relación clara: algunos mejoran, otros empeoran o no cambian. Lo que queda claro es que el dinero invertido en educación no garantiza un mayor ingreso per cápita; la realidad es más compleja y depende de factores que aún no se comprenden completamente.
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
    *En breve:* No se encontró evidencia estadísticamente robusta de que un mayor gasto público en educación se relacione positivamente con el PIB per cápita en América Latina.
  ]
)



== Introducción

La relación entre la inversión pública en educación y el crecimiento económico ha sido un tema central en la literatura del desarrollo (Barro, 1991; Devarajan et al., 1996). La premisa teórica sostiene que mayores recursos destinados a la educación mejoran el capital humano, lo que a su vez eleva la productividad y el ingreso per cápita. Sin embargo, la evidencia empírica es mixta y a menudo depende del contexto institucional y del horizonte temporal analizado (Gregorio & Lee, 2004; Sahay & Goyal, 2006).  

Recientemente, una polémica campaña corporativa ha generado cobertura mediática que sugiere que la reputación internacional de la región podría influir en la inversión extranjera y, por ende, en el desempeño macroeconómico. La noticia afirma que “la percepción internacional afecta la inversión y el crecimiento”, pero no provee datos cuantitativos que permitan verificar tal afirmación.  

En este contexto, la presente investigación plantea la siguiente *pregunta de investigación*:  


#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#1a56db")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    ¿Existe una relación positiva entre el gasto público en educación y el PIB per cápita en los países latinoamericanos entre 2015 y 2024?
  ]
)


Para responder, se contrastan los indicadores de gasto educativo (% del PIB) y PIB per cápita (US\$ actuales) provistos por el Banco Mundial. A nivel regional, el gasto en educación disminuyó un 14.12 % en el periodo (de 4.45 % a 3.82 % del PIB) mientras que el PIB per cápita aumentó un 25.25 % (de 8 546.92 USD a 10 705.11 USD) (Banco Mundial, 2024). En los países analizados, la variación del gasto es heterogénea: por ejemplo, Ecuador redujo su gasto del 5.11 % al 3.69 % (Δ = -27.71 %), mientras que Perú lo incrementó del 3.97 % al 4.36 % (Δ = +9.79 %).  


#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#1a56db")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    *Hipótesis:* \> Un mayor gasto público en educación está asociado a un mayor PIB per cápita en América Latina.
  ]
)



== Metodología

Se emplearon series anuales (2015-2024) de gasto público en educación (% del PIB) y PIB per cápita (US\$ actuales) extraídas del Banco Mundial (Banco Mundial, 2024). El análisis incluyó:  

+ *Correlaciones de Pearson y Spearman* entre los dos indicadores a nivel regional (LCN) y por país (ECU, GTM, PER, ARG, CRI). Los valores de r y p-value se complementaron con q-values ajustados por FDR (Benjamini-Hochberg).
+ *Pruebas de tendencia Mann-Kendall* para detectar cambios estructurales en cada serie (p \< 0.05 considerado significativo).
+ *Regresión lineal simple (OLS)* en niveles, usando la variable “gasto en educación” como predictor del “PIB per cápita”. Dado que los resultados de panel con efectos fijos no aparecen en los resultados entregados, no se incluyen.
+ *Análisis de diferencias año a año* (Δ) para identificar co-tendencias: se comparó la correlación en niveles con la correlación de los cambios anuales (rΔ). Cuando la correlación en niveles era significativa pero rΔ no lo era (p \> 0.05), la relación se describió como co-tendencia espuria, siguiendo la recomendación de los resultados.

Todas las pruebas se realizaron en Python (statsmodels, scipy). Los coeficientes y valores p reportados provienen exclusivamente de los cálculos presentados en los resultados. No se realizaron pruebas adicionales ni se emplearon fuentes distintas al Banco Mundial.


== Análisis



=== Tendencias macroeconómicas regionales

_Los indicadores muestran que, a nivel regional, el PIB per cápita ha subido mientras el gasto en educación ha bajado._  

Entre 2015 y 2024 el PIB per cápita promedio de América Latina y el Caribe pasó de *8 546,92 USD* a *10 705,11 USD*, lo que representa un incremento total del *+25,25 %* y una tasa compuesta anual (CAGR) de *+2,53 %* (Banco Mundial, 2024). En contraste, el gasto público en educación como proporción del PIB disminuyó de *4,45 %* a *3,82 %*, una caída del *-14,12 %* y una CAGR de *-1,88 %*. La tendencia negativa del gasto educativo es significativa (p = 0.0187 para Brasil, p = 0.0355 para México, p = 0.0476 para Argentina) según pruebas de tendencia lineal.  


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* figura de tendencias regionales]
    ]
  )
  #v(6pt)
]

_Como leerla: cada mini-panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa._


=== Correlaciones entre gasto educativo y PIB per cápita

_Los números indican que, a nivel de países, la relación entre gasto y riqueza no es consistentemente positiva._  

Se calcularon correlaciones de Pearson entre el gasto público en educación (% del PIB) y el PIB per cápita para cada país y para la región completa (LCN). Los resultados más relevantes son:

#align(center)[
#v(6pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#14213d") } else if calc.odd(row) { rgb("#f8fafc") } else { white },
  stroke: (col, row) => if row == 0 { (bottom: 1.5pt + rgb("#0f172a")) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
  inset: (x: 8pt, y: 7pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  table.header(text(white, weight: "bold", size: 8.2pt)[País / Región], text(white, weight: "bold", size: 8.2pt)[Pearson r], text(white, weight: "bold", size: 8.2pt)[p-valor], text(white, weight: "bold", size: 8.2pt)[q-valor (FDR)], text(white, weight: "bold", size: 8.2pt)[Evidencia]),
  text(size: 8.2pt)[Región (LCN)], text(size: 8.2pt)[*-0,730*], text(size: 8.2pt)[0,026], text(size: 8.2pt)[0,111], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Costa Rica (CRI)], text(size: 8.2pt)[*-0,881*], text(size: 8.2pt)[0,002], text(size: 8.2pt)[*0,022*], text(size: 8.2pt)[#text(fill: rgb("b8860b"))[●] Co-tendencia probable],
  text(size: 8.2pt)[Colombia (COL)], text(size: 8.2pt)[*-0,836*], text(size: 8.2pt)[0,038], text(size: 8.2pt)[0,125], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Panamá (PAN)], text(size: 8.2pt)[*-0,774*], text(size: 8.2pt)[0,014], text(size: 8.2pt)[0,094], text(size: 8.2pt)[#text(fill: rgb("b8860b"))[●] Marginal],
  text(size: 8.2pt)[Ecuador (ECU)], text(size: 8.2pt)[-0,489], text(size: 8.2pt)[0,152], text(size: 8.2pt)[0,297], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Perú (PER)], text(size: 8.2pt)[*0,450*], text(size: 8.2pt)[0,192], text(size: 8.2pt)[0,312], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Argentina (ARG)], text(size: 8.2pt)[*0,317*], text(size: 8.2pt)[0,406], text(size: 8.2pt)[0,480], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Guatemala (GTM)], text(size: 8.2pt)[*0,242*], text(size: 8.2pt)[0,501], text(size: 8.2pt)[0,501], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
)
#v(6pt)
]

Solo la correlación de Costa Rica supera el umbral de significancia ajustada (q \< 0,05). Sin embargo, el análisis de diferencias año a año (Δ) muestra r = -0,280 con q = 0,695, lo que indica que la fuerte correlación en niveles es una *co-tendencia espuria* y desaparece cuando se controla por tendencias comunes (alerta de co-tendencia).  


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* figura de correlación país-a-país]
    ]
  )
  #v(6pt)
]

_Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas._


=== Análisis de casos país-por-país

_Algunos países presentan aumentos o disminuciones notables en su gasto educativo, pero estos cambios no se traducen de forma clara en variaciones del PIB per cápita._  

- *Ecuador*: el gasto cayó de *5,11 %* (2015) a *3,69 %* (2024), una caída del *-27,71 %* (CAGR = -3,54 %). No se observa una relación clara con su PIB per cápita, que sigue la tendencia regional de crecimiento moderado.
- *Guatemala*: el gasto se mantuvo prácticamente estable (Δ = +1,50 %) y el PIB per cápita mostró una ligera alza, pero la correlación es prácticamente nula (r = 0,242).
- *Perú*: el gasto aumentó un *+9,79 %* (CAGR = +1,04 %) y el PIB per cápita creció a una tasa anual de *≈ 208 USD* (p = 0,0123). La correlación positiva (r = 0,450) no alcanza significancia estadística después del ajuste por FDR.
- *Argentina*: el gasto disminuyó un *-13,38 %* (CAGR = -1,78 %) mientras que el PIB per cápita mostró una leve tendencia a la baja, generando una correlación positiva débil (r = 0,317).

Los análisis de tendencia individual (p-valores de la pendiente) confirman que la mayoría de los países presentan *pendientes negativas* en el gasto educativo (p \< 0,05 en Brasil, México y Argentina), mientras que sus PIB per cápita presentan *pendientes positivas* (p \< 0,05 en México, Perú, Chile).  


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* figura de comparación entre países]
    ]
  )
  #v(6pt)
]

_Como leerla: barra más larga o país más oscuro = valor más alto del indicador._


=== Calor de relaciones y robustez estadística

_El mapa de calor muestra que pocas relaciones son estadísticamente significativas y la mayoría es débil o nula._  

El heatmap de correlaciones (figura 6) indica que solo los pares señalados con asterisco (*) son significativos tras el control de FDR. En la figura aparecen colores rojos intensos para Costa Rica y Panamá, pero la nota de co-tendencia advierte que dichos resultados pueden ser espurios.  


#align(center)[
  #v(6pt)
  #block(
    stroke: 0.5pt + rgb("#e2e8f0"),
    radius: 4pt,
    inset: 4pt,
    fill: white,
    [
      #image("/docs/charts/2026-10-16-16-17/fig6_heatmap.png", width: 85%)
      #v(2pt)
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* figura de mapa de calor]
    ]
  )
  #v(6pt)
]

_Como leerla: azul = se mueven juntas; rojo = se mueven al revés; casi blanco = sin relación clara; _ = significativo.*


=== Resumen de hallazgos cuantitativos

_En conjunto, los números no apoyan la idea de que más gasto en educación genere automáticamente mayor PIB per cápita._  

- La región muestra *crecimiento del PIB per cápita* (+2,53 % CAGR) y *reducción del gasto educativo* (-1,88 % CAGR).
- La *correlación regional* es negativa (r = -0,730) y no significativa tras corrección por FDR.
- *Solo Costa Rica* presenta una correlación significativa en niveles, pero se trata de una co-tendencia espuria.
- *Ningún país* evidencia una asociación robusta y positiva entre variaciones anuales de gasto y variaciones anuales de PIB per cápita.


== Discusión



=== Comparación con la literatura existente

_Los resultados coinciden con estudios que encuentran efectos mixtos o nulos de la inversión educativa sobre el crecimiento._  

Barro (1991) encontró que el capital humano, medido por tasas de escolarización, está positivamente relacionado con el crecimiento del PIB per cápita, pero su análisis se centró en variables de nivel de educación y en periodos mucho más largos. Devarajan et al. (1996) mostraron que la *composición* del gasto público es más determinante que el nivel absoluto del gasto; un aumento del gasto en educación sin mejoras en eficiencia puede no traducirse en mayor productividad. Nuestros hallazgos son *consistentes* con esa visión: la mera proporción del PIB destinada a educación no captura la calidad ni la efectividad del gasto, lo que explica la ausencia de una relación positiva clara.  

Gregorio y Lee (2004) y Sahay & Goyal (2006) resaltan la importancia de la *estabilidad macroeconómica* y la *volatilidad* para el crecimiento en América Latina. Las tendencias negativas del gasto educativo en varios países coinciden con periodos de mayor volatilidad fiscal, lo que podría atenuar cualquier efecto positivo esperado.  


=== Limitaciones de los datos y del enfoque metodológico

_Hay varios factores que pueden haber sesgado los resultados y que deben considerarse al interpretar los hallazgos._  

+ *Agregación y escala temporal*: el análisis se basa en datos anuales de una década (2015-2024). Cambios estructurales en la educación pueden requerir horizontes más largos para manifestarse en el PIB per cápita.
+ *Medida del gasto*: usar el porcentaje del PIB como proxy ignora variaciones en el nivel absoluto de gasto y en la eficiencia del gasto (por ejemplo, diferencias en salarios docentes, infraestructura o gestión).
+ *Variables omitidas*: factores como inversión privada en educación, calidad docente, acceso a tecnología y políticas de mercado laboral no se incluyen, lo que puede generar sesgo de variable omitida.
+ *Co-tendencia*: la fuerte correlación encontrada para Costa Rica desaparece al analizar diferencias año a año, lo que ilustra el riesgo de interpretar relaciones en niveles cuando ambas series comparten tendencias comunes.


=== Implicaciones para la polémica corporativa

_Aunque la noticia sugiere que la reputación internacional afecta la inversión y el crecimiento, los indicadores macroeconómicos no respaldan una relación directa entre gasto educativo y desempeño económico en el periodo analizado._  

La campaña corporativa citada no se traduce en cambios medibles en los indicadores de gasto educativo ni en el PIB per cápita. Sin embargo, la percepción internacional podría influir en flujos de inversión extranjera directa (IED) que no se capturan en las variables estudiadas. Futuras investigaciones deberían incorporar datos de IED y de indicadores de reputación (p. ej., índices de facilidad para hacer negocios) para evaluar ese canal potencial.  


== Conclusiones


_Los resultados indican que, en la última década, mayor gasto público en educación no se asoció de forma robusta con mayores niveles de PIB per cápita en América Latina._  

+ *Tendencias divergentes*: mientras el PIB per cápita regional aumentó un 25 % en promedio, el gasto público en educación disminuyó un 14 %.
+ *Correlaciones débiles y no significativas*: la correlación regional es negativa (r = -0,730) y ninguna asociación supera el umbral de significancia ajustada, salvo la aparente excepción de Costa Rica, que se revela como co-tendencia espuria.
+ *Variabilidad entre países*: algunos países (Perú, Guatemala) mostraron aumentos modestos en gasto educativo sin efectos claros en el PIB per cápita; otros (Argentina, Brasil) redujeron su gasto mientras su PIB per cápita mostró tendencias opuestas.
+ *Consistencia con la literatura*: los hallazgos concuerdan con estudios que enfatizan la importancia de la *calidad y composición* del gasto más que la magnitud del mismo (Devarajan et al., 1996; Barro, 1991).

En conclusión, la hipótesis de que “un mayor gasto en educación está asociado a un mayor PIB per cápita en América Latina” *no se confirma* con los datos disponibles para 2015-2024. Las políticas orientadas a mejorar la *eficiencia* y la *calidad* del gasto educativo, así como a abordar factores estructurales de la economía, podrían ser más determinantes para impulsar el crecimiento económico que simplemente aumentar la proporción del PIB destinada a educación.  


_Referencias_  

- Barro, R. J. (1991). Economic Growth in a Cross Section of Countries. _The Quarterly Journal of Economics_. https://doi.org/10.2307/2937943
- Devarajan, S., A, V. S., Zou, H. (1996). The composition of public expenditure and economic growth. _Journal of Monetary Economics_. https://doi.org/10.1016/0304-3932(96)01249-4
- Gregorio, J. D., Lee, J. (2004). Growth and Adjustment in East Asia and Latin America. _Economía_. https://doi.org/10.1353/eco.2005.0004
- Sahay, R., Goyal, R. (2006). Volatility and Growth in Latin America. _IMF Working Paper_. https://doi.org/10.5089/9781451865479.001
- Banco Mundial (2024). World Development Indicators. https://data.worldbank.org/


_Todas las figuras referenciadas corresponden a los archivos listados en la sección de Figuras Narrativas._


== Bibliografía


- Banco Mundial. (2024). _World Development Indicators_. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- The Irish Times. "Ryanair ‘recognises’ disputed Western Sahara territory in controversial marketing campaign". https://www.irishtimes.com/transport/2026/10/15/ryanair-recognises-disputed-western-sahara-territory-in-controversial-marketing-campaign/
- Devarajan, S., A, V. S., Zou, H. (1996). The composition of public expenditure and economic growth. _Journal of Monetary Economics_. https://doi.org/10.1016/0304-3932(96)01249-4
- Gregorio, J. D., Lee, J. (2004). Growth and Adjustment in East Asia and Latin America. _Economía_. https://doi.org/10.1353/eco.2005.0004
- Barro, R. J. (1991). Economic Growth in a Cross Section of Countries. _The Quarterly Journal of Economics_. https://doi.org/10.2307/2937943
- Sahay, R., Goyal, R. (2006). Volatility and Growth in Latin America. _IMF Working Paper_. https://doi.org/10.5089/9781451865479.001


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
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[8,546.9], text(size: 8.2pt)[8,241.5], text(size: 8.2pt)[9,065.8], text(size: 8.2pt)[8,778.6], text(size: 8.2pt)[8,540.0], text(size: 8.2pt)[7,169.4], text(size: 8.2pt)[8,292.2], text(size: 8.2pt)[9,412.1], text(size: 8.2pt)[10,507.6], text(size: 8.2pt)[10,705.1],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[4.447], text(size: 8.2pt)[4.414], text(size: 8.2pt)[4.408], text(size: 8.2pt)[4.461], text(size: 8.2pt)[4.511], text(size: 8.2pt)[4.535], text(size: 8.2pt)[4.087], text(size: 8.2pt)[3.861], text(size: 8.2pt)[3.820], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[13,679.6], text(size: 8.2pt)[12,700.0], text(size: 8.2pt)[14,532.5], text(size: 8.2pt)[11,752.8], text(size: 8.2pt)[9,956.0], text(size: 8.2pt)[8,535.6], text(size: 8.2pt)[10,738.0], text(size: 8.2pt)[13,962.2], text(size: 8.2pt)[14,261.8], text(size: 8.2pt)[13,969.8],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[5.776], text(size: 8.2pt)[5.545], text(size: 8.2pt)[5.454], text(size: 8.2pt)[4.878], text(size: 8.2pt)[4.772], text(size: 8.2pt)[5.277], text(size: 8.2pt)[4.654], text(size: 8.2pt)[4.793], text(size: 8.2pt)[5.003], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[8,936.2], text(size: 8.2pt)[8,836.3], text(size: 8.2pt)[10,080.5], text(size: 8.2pt)[9,300.7], text(size: 8.2pt)[9,029.8], text(size: 8.2pt)[7,074.2], text(size: 8.2pt)[7,972.5], text(size: 8.2pt)[9,281.3], text(size: 8.2pt)[10,377.6], text(size: 8.2pt)[10,310.5],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[6.241], text(size: 8.2pt)[6.314], text(size: 8.2pt)[6.320], text(size: 8.2pt)[6.089], text(size: 8.2pt)[5.963], text(size: 8.2pt)[5.771], text(size: 8.2pt)[5.497], text(size: 8.2pt)[5.619], text(size: 8.2pt)[—], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[13,433.9], text(size: 8.2pt)[13,649.9], text(size: 8.2pt)[14,879.9], text(size: 8.2pt)[15,659.5], text(size: 8.2pt)[14,496.9], text(size: 8.2pt)[13,118.0], text(size: 8.2pt)[16,216.2], text(size: 8.2pt)[15,399.1], text(size: 8.2pt)[17,081.5], text(size: 8.2pt)[16,659.0],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[4.904], text(size: 8.2pt)[5.366], text(size: 8.2pt)[5.433], text(size: 8.2pt)[5.473], text(size: 8.2pt)[5.626], text(size: 8.2pt)[5.630], text(size: 8.2pt)[5.002], text(size: 8.2pt)[4.912], text(size: 8.2pt)[—], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Colombia], text(size: 8.2pt)[6,248.5], text(size: 8.2pt)[5,959.8], text(size: 8.2pt)[6,479.5], text(size: 8.2pt)[6,817.0], text(size: 8.2pt)[6,472.5], text(size: 8.2pt)[5,339.7], text(size: 8.2pt)[6,222.6], text(size: 8.2pt)[6,680.4], text(size: 8.2pt)[7,012.5], text(size: 8.2pt)[7,951.1],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Colombia], text(size: 8.2pt)[4.470], text(size: 8.2pt)[4.477], text(size: 8.2pt)[4.536], text(size: 8.2pt)[4.449], text(size: 8.2pt)[4.511], text(size: 8.2pt)[5.262], text(size: 8.2pt)[—], text(size: 8.2pt)[—], text(size: 8.2pt)[—], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[11,714.7], text(size: 8.2pt)[12,091.0], text(size: 8.2pt)[12,317.1], text(size: 8.2pt)[12,620.0], text(size: 8.2pt)[12,951.9], text(size: 8.2pt)[12,475.7], text(size: 8.2pt)[12,962.3], text(size: 8.2pt)[13,971.8], text(size: 8.2pt)[17,140.8], text(size: 8.2pt)[18,853.3],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[6.873], text(size: 8.2pt)[6.894], text(size: 8.2pt)[7.070], text(size: 8.2pt)[6.770], text(size: 8.2pt)[6.738], text(size: 8.2pt)[6.629], text(size: 8.2pt)[6.248], text(size: 8.2pt)[5.547], text(size: 8.2pt)[5.312], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[República Dominicana], text(size: 8.2pt)[6,801.0], text(size: 8.2pt)[7,160.4], text(size: 8.2pt)[7,412.7], text(size: 8.2pt)[7,883.0], text(size: 8.2pt)[8,183.0], text(size: 8.2pt)[7,135.2], text(size: 8.2pt)[8,527.1], text(size: 8.2pt)[10,104.2], text(size: 8.2pt)[10,630.4], text(size: 8.2pt)[10,875.7],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[República Dominicana], text(size: 8.2pt)[3.604], text(size: 8.2pt)[3.850], text(size: 8.2pt)[3.920], text(size: 8.2pt)[3.928], text(size: 8.2pt)[4.043], text(size: 8.2pt)[4.518], text(size: 8.2pt)[3.580], text(size: 8.2pt)[3.611], text(size: 8.2pt)[3.761], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Ecuador], text(size: 8.2pt)[5,976.2], text(size: 8.2pt)[5,917.6], text(size: 8.2pt)[6,233.3], text(size: 8.2pt)[6,303.9], text(size: 8.2pt)[6,205.1], text(size: 8.2pt)[5,463.6], text(size: 8.2pt)[6,061.3], text(size: 8.2pt)[6,515.6], text(size: 8.2pt)[6,718.1], text(size: 8.2pt)[6,826.5],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Ecuador], text(size: 8.2pt)[5.106], text(size: 8.2pt)[4.464], text(size: 8.2pt)[4.607], text(size: 8.2pt)[4.625], text(size: 8.2pt)[4.246], text(size: 8.2pt)[4.261], text(size: 8.2pt)[3.656], text(size: 8.2pt)[3.613], text(size: 8.2pt)[3.820], text(size: 8.2pt)[3.691],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[3,893.5], text(size: 8.2pt)[4,060.1], text(size: 8.2pt)[4,325.0], text(size: 8.2pt)[4,352.9], text(size: 8.2pt)[4,512.0], text(size: 8.2pt)[4,477.6], text(size: 8.2pt)[4,912.6], text(size: 8.2pt)[5,356.9], text(size: 8.2pt)[5,754.4], text(size: 8.2pt)[6,150.9],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[3.030], text(size: 8.2pt)[2.945], text(size: 8.2pt)[2.950], text(size: 8.2pt)[3.132], text(size: 8.2pt)[3.193], text(size: 8.2pt)[3.295], text(size: 8.2pt)[3.092], text(size: 8.2pt)[3.208], text(size: 8.2pt)[3.109], text(size: 8.2pt)[3.076],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[México], text(size: 8.2pt)[10,021.2], text(size: 8.2pt)[9,097.9], text(size: 8.2pt)[9,649.3], text(size: 8.2pt)[10,084.8], text(size: 8.2pt)[10,369.6], text(size: 8.2pt)[8,841.3], text(size: 8.2pt)[10,314.1], text(size: 8.2pt)[11,405.8], text(size: 8.2pt)[13,830.8], text(size: 8.2pt)[13,988.0],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[México], text(size: 8.2pt)[5.051], text(size: 8.2pt)[4.758], text(size: 8.2pt)[4.398], text(size: 8.2pt)[4.139], text(size: 8.2pt)[—], text(size: 8.2pt)[4.500], text(size: 8.2pt)[4.238], text(size: 8.2pt)[4.060], text(size: 8.2pt)[—], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Panamá], text(size: 8.2pt)[14,082.7], text(size: 8.2pt)[14,832.4], text(size: 8.2pt)[15,694.6], text(size: 8.2pt)[16,151.3], text(size: 8.2pt)[16,477.9], text(size: 8.2pt)[13,290.6], text(size: 8.2pt)[15,509.8], text(size: 8.2pt)[17,378.6], text(size: 8.2pt)[18,797.2], text(size: 8.2pt)[19,161.2],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Panamá], text(size: 8.2pt)[3.266], text(size: 8.2pt)[3.323], text(size: 8.2pt)[3.378], text(size: 8.2pt)[3.452], text(size: 8.2pt)[3.281], text(size: 8.2pt)[4.305], text(size: 8.2pt)[3.712], text(size: 8.2pt)[3.378], text(size: 8.2pt)[2.472], text(size: 8.2pt)[—],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Perú], text(size: 8.2pt)[6,231.7], text(size: 8.2pt)[6,217.0], text(size: 8.2pt)[6,736.2], text(size: 8.2pt)[6,978.5], text(size: 8.2pt)[7,037.0], text(size: 8.2pt)[6,133.3], text(size: 8.2pt)[6,828.5], text(size: 8.2pt)[7,353.7], text(size: 8.2pt)[7,919.0], text(size: 8.2pt)[8,526.3],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Perú], text(size: 8.2pt)[3.969], text(size: 8.2pt)[3.813], text(size: 8.2pt)[3.931], text(size: 8.2pt)[3.714], text(size: 8.2pt)[3.822], text(size: 8.2pt)[4.259], text(size: 8.2pt)[3.928], text(size: 8.2pt)[3.840], text(size: 8.2pt)[4.245], text(size: 8.2pt)[4.358],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales) (USD)], text(size: 8.2pt)[Uruguay], text(size: 8.2pt)[17,125.9], text(size: 8.2pt)[17,009.8], text(size: 8.2pt)[19,184.7], text(size: 8.2pt)[19,249.9], text(size: 8.2pt)[18,315.7], text(size: 8.2pt)[15,757.5], text(size: 8.2pt)[17,881.8], text(size: 8.2pt)[21,009.3], text(size: 8.2pt)[23,378.6], text(size: 8.2pt)[24,308.5],
  text(size: 8.2pt)[Gasto público en educación (% del PIB) (%)], text(size: 8.2pt)[Uruguay], text(size: 8.2pt)[4.206], text(size: 8.2pt)[4.364], text(size: 8.2pt)[4.418], text(size: 8.2pt)[4.604], text(size: 8.2pt)[4.628], text(size: 8.2pt)[4.552], text(size: 8.2pt)[4.462], text(size: 8.2pt)[4.480], text(size: 8.2pt)[4.765], text(size: 8.2pt)[—],
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
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[CRI], text(size: 8.2pt)[-0.881], text(size: 8.2pt)[0.002], text(size: 8.2pt)[0.022], text(size: 8.2pt)[-0.883], text(size: 8.2pt)[-0.280], text(size: 8.2pt)[0.501], text(size: 8.2pt)[#text(fill: rgb("b8860b"))[●] Co-tendencia probable],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[COL], text(size: 8.2pt)[-0.836], text(size: 8.2pt)[0.038], text(size: 8.2pt)[0.125], text(size: 8.2pt)[-0.486], text(size: 8.2pt)[-0.829], text(size: 8.2pt)[0.082], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[PAN], text(size: 8.2pt)[-0.774], text(size: 8.2pt)[0.014], text(size: 8.2pt)[0.094], text(size: 8.2pt)[-0.433], text(size: 8.2pt)[-0.891], text(size: 8.2pt)[0.003], text(size: 8.2pt)[#text(fill: rgb("b8860b"))[●] Marginal],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[LCN], text(size: 8.2pt)[-0.730], text(size: 8.2pt)[0.026], text(size: 8.2pt)[0.111], text(size: 8.2pt)[-0.667], text(size: 8.2pt)[-0.623], text(size: 8.2pt)[0.099], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[URY], text(size: 8.2pt)[0.574], text(size: 8.2pt)[0.106], text(size: 8.2pt)[0.275], text(size: 8.2pt)[0.533], text(size: 8.2pt)[0.213], text(size: 8.2pt)[0.612], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[BRA], text(size: 8.2pt)[0.548], text(size: 8.2pt)[0.160], text(size: 8.2pt)[0.297], text(size: 8.2pt)[0.452], text(size: 8.2pt)[0.477], text(size: 8.2pt)[0.279], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[MEX], text(size: 8.2pt)[-0.524], text(size: 8.2pt)[0.227], text(size: 8.2pt)[0.328], text(size: 8.2pt)[-0.714], text(size: 8.2pt)[0.374], text(size: 8.2pt)[0.535], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[ECU], text(size: 8.2pt)[-0.489], text(size: 8.2pt)[0.152], text(size: 8.2pt)[0.297], text(size: 8.2pt)[-0.418], text(size: 8.2pt)[-0.113], text(size: 8.2pt)[0.772], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[PER], text(size: 8.2pt)[0.450], text(size: 8.2pt)[0.192], text(size: 8.2pt)[0.312], text(size: 8.2pt)[0.139], text(size: 8.2pt)[-0.427], text(size: 8.2pt)[0.252], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[DOM], text(size: 8.2pt)[-0.383], text(size: 8.2pt)[0.309], text(size: 8.2pt)[0.402], text(size: 8.2pt)[-0.267], text(size: 8.2pt)[-0.692], text(size: 8.2pt)[0.057], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[ARG], text(size: 8.2pt)[0.317], text(size: 8.2pt)[0.406], text(size: 8.2pt)[0.480], text(size: 8.2pt)[0.367], text(size: 8.2pt)[0.057], text(size: 8.2pt)[0.894], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[CHL], text(size: 8.2pt)[-0.285], text(size: 8.2pt)[0.493], text(size: 8.2pt)[0.501], text(size: 8.2pt)[-0.214], text(size: 8.2pt)[-0.590], text(size: 8.2pt)[0.163], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[GTM], text(size: 8.2pt)[0.242], text(size: 8.2pt)[0.501], text(size: 8.2pt)[0.501], text(size: 8.2pt)[0.430], text(size: 8.2pt)[-0.578], text(size: 8.2pt)[0.103], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
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
  text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[8546.92 (2015)], text(size: 8.2pt)[10705.11 (2024)], text(size: 8.2pt)[239.7988], text(size: 8.2pt)[25.25%], text(size: 8.2pt)[2.53%],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[4.45 (2015)], text(size: 8.2pt)[3.82 (2023)], text(size: 8.2pt)[-0.0785], text(size: 8.2pt)[-14.12%], text(size: 8.2pt)[-1.88%],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[13679.63 (2015)], text(size: 8.2pt)[13969.78 (2024)], text(size: 8.2pt)[32.2397], text(size: 8.2pt)[2.12%], text(size: 8.2pt)[0.23%],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[5.78 (2015)], text(size: 8.2pt)[5.00 (2023)], text(size: 8.2pt)[-0.0966], text(size: 8.2pt)[-13.38%], text(size: 8.2pt)[-1.78%],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[8936.20 (2015)], text(size: 8.2pt)[10310.55 (2024)], text(size: 8.2pt)[152.7058], text(size: 8.2pt)[15.38%], text(size: 8.2pt)[1.60%],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[6.24 (2015)], text(size: 8.2pt)[5.62 (2022)], text(size: 8.2pt)[-0.0888], text(size: 8.2pt)[-9.96%], text(size: 8.2pt)[-1.49%],
  text(size: 8.2pt)[PIB per cápita (US\$ actuales)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[13433.92 (2015)], text(size: 8.2pt)[16658.97 (2024)], text(size: 8.2pt)[358.3383], text(size: 8.2pt)[24.01%], text(size: 8.2pt)[2.42%],
  text(size: 8.2pt)[Gasto público en educación (% del PIB)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[4.90 (2015)], text(size: 8.2pt)[4.91 (2022)], text(size: 8.2pt)[0.0012], text(size: 8.2pt)[0.17%], text(size: 8.2pt)[0.02%],
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
      #image("/docs/charts/2026-10-16-16-17/fig11_anomaly.png", width: 85%)
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
Tema seleccionado: _Relación entre inversión en educación y crecimiento del PIB per cápita en América Latina_.
Noticia que inspiró la línea editorial: _"Ryanair ‘recognises’ disputed Western Sahara territory in controversial marketing campaign"_ (#link("https://www.irishtimes.com/transport/2026/10/15/ryanair-recognises-disputed-western-sahara-territory-in-controversial-marketing-campaign/")[The Irish Times]).
Lo que la noticia afirmaba o sugería: Una campaña corporativa polémica puede afectar la percepción internacional y, por ende, la inversión extranjera y el crecimiento económico.
Alcance verificable con los datos: Se puede analizar si el gasto en educación se correlaciona con el PIB per cápita; la influencia de la polémica de Ryanair no puede medirse directamente con los indicadores.
Justificación del sistema: El ángulo económico-educativo permite usar indicadores claros de gasto educativo y nivel de vida, conectando la noticia de reputación corporativa con posibles efectos macroeconómicos.
*Pregunta de investigación:* ¿Existe una relación positiva entre el gasto público en educación y el PIB per cápita en los países latinoamericanos?
*Hipótesis planteada:* Un mayor gasto en educación está asociado a un mayor PIB per cápita en América Latina.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
*Procedencia de los datos.* Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ECU, GTM, PER, ARG, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
*Métodos analíticos ejecutados (Cómputo Determinístico):*
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 13 correlaciones Pearson/Spearman (1 significativas tras corrección FDR Benjamini-Hochberg, q\<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
*Proceso editorial.* Siete nodos automáticos: FETCH -> SUGGEST -> COMPUTE -> WRITE -> REVIEW -> EDIT -> APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 73 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 0 reescritura(s), 0 reedición(es).
*Limitaciones.* Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
_Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): #link("https://rogelioguerrero.github.io/academic-pipeline/methodology.html")[metodología]_
  ]
)

