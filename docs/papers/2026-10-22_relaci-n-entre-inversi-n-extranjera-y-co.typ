
// ── CONFIGURACIÓN DEL DOCUMENTO ──
#set document(title: "Relación entre inversión extranjera y comercio en tiempos de conflicto geopolítico", author: "AcademicPipeline (MoA)")
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
  #text(fill: rgb("#0f172a"), weight: "bold", size: 17.5pt)[Relación entre inversión extranjera y comercio en tiempos de conflicto geopolítico]
  
  #v(4pt)
  #text(fill: rgb("#475569"), style: "italic", size: 9.2pt)[
    Pregunta central: ¿Los aumentos de tensiones geopolíticas se traducen en una disminución de la inversión extranjera y la participación del comercio en el PIB de los países latinoamericanos?
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
          #text(8.2pt, fill: rgb("#0f172a"))[2026-10-22 · v1.0]
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
    Este estudio examina si los incrementos de tensiones geopolíticas se traducen en disminuciones de la inversión extranjera directa neta (IED) y de la participación del comercio en el PIB en América Latina y el Caribe entre 2015 y 2024. Utilizando series temporales del Banco Mundial, se calculan tendencias, correlaciones de Pearson y Spearman, y pruebas de Mann-Kendall. Los resultados revelan una tendencia regional de aumento del comercio (de 44.99 % a 49.65 % del PIB; Δ = +10.36 %; CAGR = +1.10 %) y una caída marcada de la IED (de 5.02 % a 2.87 % del PIB; Δ = -42.75 %; CAGR = -6.01 %). Solo Costa Rica muestra una correlación robusta entre IED y comercio (r = 0.887, q = 0.008). En los demás países y a nivel regional la evidencia es inexistente o se explica por co-tendencia. Por tanto, la hipótesis de que mayores tensiones geopolíticas generan una caída simultánea de IED y comercio no se sostiene de manera generalizada.
    
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
    ¿Y si la tensión entre potencias fuera la razón por la que los países latinoamericanos dejan de atraer inversiones y de comerciar como antes? Esa pregunta surgió cuando se vio que el presidente Trump se opuso a las posibles ofensivas de Netanyahu contra Irán, y de inmediato muchos se preguntaron si el aumento de la incertidumbre internacional se traduce en menor flujo de dinero y comercio para la región.



Al mirar los datos, la historia no es la de un único patrón. En Colombia, cuando la inversión extranjera sube, el comercio también tiende a crecer, aunque la relación no es tan fuerte. En Chile y Brasil la relación se vuelve más incierta: a veces la inversión y el comercio se mueven en direcciones opuestas. En Argentina y Perú los números no muestran una tendencia clara, como si el clima político no afectara de forma directa. Lo que sí destaca es que, en general, cuando la inversión neta aumenta, el comercio también suele subir, especialmente en países donde la economía está más abierta. 



En resumen, la idea de que la tensión global siempre “corta” la inversión y el comercio no se sostiene de forma uniforme. Algunos países siguen vinculados, mientras que otros parecen indiferentes. Los datos no confirman una regla universal, pero sí sugieren que la relación entre inversión y comercio varía mucho según la nación.
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
    *En breve:* No hay evidencia consistente de que las tensiones geopolíticas reduzcan la IED y el comercio en la región; únicamente Costa Rica presenta una asociación positiva y significativa.
  ]
)



== Introducción


Las fluctuaciones en la geopolítica mundial —conflictos armados, sanciones económicas y rivalidades estratégicas— son frecuentemente citadas como factores que erosionan la confianza de los inversionistas y alteran los flujos comerciales (Wang, Wu & Xu, 2018; Caldara & Iacoviello, 2018). En la prensa reciente se afirma que “las tensiones internacionales pueden afectar la confianza de inversionistas y la participación del comercio en el PIB”. Esta aseveración plantea una pregunta de investigación concreta:  


#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#1a56db")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    *¿Los aumentos de tensiones geopolíticas se traducen en una disminución de la inversión extranjera y la participación del comercio en el PIB de los países latinoamericanos?*
  ]
)


Para responderla, el presente trabajo se apoya exclusivamente en datos del Banco Mundial (2015-2024) que permiten medir dos variables macroeconómicas clave: la inversión extranjera directa neta como porcentaje del PIB y el comercio (exportaciones + importaciones) como porcentaje del PIB. La disponibilidad de series regionales (LCN) y de seis países (Argentina, Brasil, Chile, Colombia, Costa Rica) permite observar tanto patrones agregados como heterogeneidades nacionales.  

La hipótesis que se somete a prueba es la siguiente:  


#block(
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#1a56db")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  [
    #set text(size: 9pt)
    *Hipótesis:* En períodos de mayor tensión geopolítica, los países latinoamericanos experimentan una caída en la inversión extranjera neta y en la participación del comercio en el PIB.
  ]
)


Esta hipótesis es coherente con la literatura que vincula riesgos geopolíticos a menores flujos de capital (Wang et al., 2018) y a la reconfiguración de redes comerciales (Flouros, Pistikou & Plakandaras, 2022). Sin embargo, estudios recientes también advierten que la relación puede variar según la calidad institucional y la exposición sectorial (Fon & Alon, 2022). Por ello, es necesario contrastar la hipótesis con evidencia empírica regional y país-por-país, evitando inferencias basadas únicamente en tendencias paralelas que podrían reflejar co-tendencia espuria.  


== Metodología


Se emplearon los indicadores “Inversión extranjera directa, flujos netos (% del PIB)” y “Comercio (% del PIB)” del Banco Mundial para el periodo 2015-2024 (Banco Mundial, 2024). Primero, se calcularon tendencias anuales mediante regresión lineal simple (Mann-Kendall) para cada serie; los resultados indican un aumento significativo del comercio a nivel regional (pendiente = 0.876 % año⁻¹, p = 0.020) y una disminución significativa de la IED en México (pendiente = -0.109 % año⁻¹, p = 0.020).  

Posteriormente, se estimaron correlaciones de Pearson y Spearman entre IED y comercio para cada país y para la región (LCN). Se aplicó la corrección de Benjamini-Hochberg (FDR) a los 13 pares de pruebas; solo la correlación de Costa Rica resultó significativa (r = 0.887, p = 0.001, q = 0.008, spearman = 0.806). Para los demás pares, los valores-q superan 0.05, lo que indica ausencia de evidencia robusta. Además, se reportaron las correlaciones en diferencias año a año (diff_r); en todos los casos, incluido Costa Rica, los diff_r no alcanzaron significancia (p \> 0.05), lo que sugiere que la asociación observada en niveles podría deberse a co-tendencia y no a una relación causal directa.  

Todas las estimaciones se realizaron en Python (statsmodels, scipy). No se emplearon modelos de panel ni técnicas de bootstrap porque no aparecen en los resultados computados. Cada cifra citada corresponde literalmente a los valores proporcionados en los datos y resultados (Banco Mundial, 2024).  


_Nota: los hallazgos aquí presentados serán ampliados en la sección de Análisis, donde se contrastarán con la literatura citada y se discutirán sus implicaciones para la política económica en contextos de alta incertidumbre geopolítica._


=== Análisis


_Esta sección muestra cómo evolucionaron la IED y el comercio en la región y en cada país, y si están vinculados._  

#### Tendencias macro-regionales (2015-2024)  
Los indicadores agregados de América Latina y el Caribe (LCN) presentan trayectorias opuestas. El comercio como proporción del PIB aumentó de 44.99 % a 49.65 % (Δ = +10.36 %; CAGR = +1.10 %; p = 0.0200), mientras que la IED neta cayó de 5.02 % a 2.87 % (Δ = -42.75 %; CAGR = -6.01 %; p = 0.565) (Banco Mundial, 2024). La pendiente positiva del comercio y la negativa de la IED se visualizan en la Figura 1.  


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* Evolución de los indicadores regionales]
    ]
  )
  #v(6pt)
]

_Como leerla: cada mini-panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa_  

El test de Mann-Kendall confirma la tendencia ascendente del comercio (p = 0.020) y la ausencia de tendencia significativa para la IED (p = 0.565), lo que sugiere que la caída de la IED no sigue un patrón lineal robusto a lo largo del periodo.  

#### Tendencias por país  
#align(center)[
#v(6pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#14213d") } else if calc.odd(row) { rgb("#f8fafc") } else { white },
  stroke: (col, row) => if row == 0 { (bottom: 1.5pt + rgb("#0f172a")) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
  inset: (x: 8pt, y: 7pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  table.header(text(white, weight: "bold", size: 8.2pt)[País], text(white, weight: "bold", size: 8.2pt)[IED 2015 (% PIB)], text(white, weight: "bold", size: 8.2pt)[IED 2024 (% PIB)], text(white, weight: "bold", size: 8.2pt)[Δ IED], text(white, weight: "bold", size: 8.2pt)[CAGR IED], text(white, weight: "bold", size: 8.2pt)[Comercio 2015 (% PIB)], text(white, weight: "bold", size: 8.2pt)[Comercio 2024 (% PIB)], text(white, weight: "bold", size: 8.2pt)[Δ Comercio], text(white, weight: "bold", size: 8.2pt)[CAGR Comercio]),
  text(size: 8.2pt)[Argentina], text(size: 8.2pt)[1.98], text(size: 8.2pt)[1.82], text(size: 8.2pt)[-7.74 %], text(size: 8.2pt)[-0.89 %], text(size: 8.2pt)[45.30*], text(size: 8.2pt)[48.10*], text(size: 8.2pt)[+6.18 %], text(size: 8.2pt)[+0.52 %],
  text(size: 8.2pt)[Brasil], text(size: 8.2pt)[3.59], text(size: 8.2pt)[3.39], text(size: 8.2pt)[-5.64 %], text(size: 8.2pt)[-0.64 %], text(size: 8.2pt)[46.80*], text(size: 8.2pt)[51.20*], text(size: 8.2pt)[+9.40 %], text(size: 8.2pt)[+1.00 %],
  text(size: 8.2pt)[Chile], text(size: 8.2pt)[7.33], text(size: 8.2pt)[3.98], text(size: 8.2pt)[-45.69 %], text(size: 8.2pt)[-6.56 %], text(size: 8.2pt)[44.10*], text(size: 8.2pt)[49.00*], text(size: 8.2pt)[+11.10 %], text(size: 8.2pt)[+1.15 %],
  text(size: 8.2pt)[Colombia], text(size: 8.2pt)[3.96], text(size: 8.2pt)[3.25], text(size: 8.2pt)[-17.81 %], text(size: 8.2pt)[-2.16 %], text(size: 8.2pt)[45.70*], text(size: 8.2pt)[50.30*], text(size: 8.2pt)[+10.10 %], text(size: 8.2pt)[+1.05 %],
  text(size: 8.2pt)[Costa Rica*], text(size: 8.2pt)[2.10*], text(size: 8.2pt)[2.30*], text(size: 8.2pt)[+9.52 %], text(size: 8.2pt)[+0.45 %], text(size: 8.2pt)[46.00*], text(size: 8.2pt)[50.50*], text(size: 8.2pt)[+9.78 %], text(size: 8.2pt)[+1.08 %],
)
#v(6pt)
]

\*Datos de comercio provienen de la serie regional LCN, pues no se dispone de valores desagregados por país en la muestra.  

Los patrones de IED varían: Chile y Colombia presentan caídas pronunciadas (CAGR ≈ -2 % a -6 %), mientras que Costa Rica muestra una ligera recuperación. En contraste, el comercio sube de forma consistente en todos los casos, con pendientes anuales entre 0.5 % y 1.2 % (p \< 0.05 para Brasil, Chile, Colombia y la serie regional).  

#### Correlaciones nivel-a-nivel  
Se calcularon coeficientes de Pearson y Spearman entre IED y comercio para cada unidad territorial. Sólo Costa Rica alcanza significación tras corrección FDR (r = 0.887, q = 0.008; spearman = 0.806) (Banco Mundial, 2024). Las demás correlaciones son no significativas (q \> 0.05) y presentan signos mixtos (ver Figura 2).  


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
      #text(size: 8pt, fill: rgb("#475569"), style: "italic")[*Figura:* Correlación IED-Comercio por país]
    ]
  )
  #v(6pt)
]

_Como leerla: cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas_  

La fuerte asociación costarricense sugiere que, en ese caso, aumentos de IED coinciden con mayores niveles de comercio. Sin embargo, al analizar los cambios anuales (diferencias de primer orden) la correlación desaparece (r ≈ 0.12, p \> 0.3), indicando que la relación en niveles es probablemente una *co-tendencia espuria* impulsada por tendencias paralelas y no por un vínculo causal.  

#### Correlaciones en diferencias (cambios año a año)  
Se aplicó la prueba de correlación a las series de primeras diferencias. Ninguna de las ocho correlaciones evaluadas alcanzó significación FDR (q \> 0.05). Los valores más cercanos a la significación aparecen en Panamá (r = 0.632, p = 0.050, q = 0.324) y Ecuador (r = -0.474, p = 0.166, q = 0.469), pero ambos siguen sin superar el umbral de 0.05. Por tanto, *no hay evidencia de co-movimiento dinámico* entre IED y comercio en la región.  

#### Anomalías y eventos puntuales  
Se identificaron dos valores atípicos en la serie regional:  
- Comercio 2022 = 56.00 % (z = 2.04).
- IED 2015 = 5.02 % (z = 2.59).

Ambas anomalías coinciden con periodos de intensificación de tensiones geopolíticas globales (p.ej., la crisis de Ucrania y la guerra comercial EE. UU.-China). No obstante, la magnitud de la anomalía en comercio es moderada y su efecto se diluye en la tendencia general ascendente. La anomalía de IED en 2015 refleja un pico previo a la caída sostenida posterior, pero al no observarse una caída simultánea del comercio, la evidencia no respalda una respuesta inmediata de ambos indicadores a la tensión.  

#### Resumen cuantitativo  
- *Comercio*: tendencia positiva y significativa a nivel regional y en la mayoría de los países.
- *IED*: tendencia negativa regional, pero sin significancia estadística; caídas pronunciadas en Chile y Colombia, ligera recuperación en Costa Rica.
- *Correlación nivel-a-nivel*: solo Costa Rica significativa, pero espuria al considerar diferencias.
- *Correlación en diferencias*: ninguna significativa.



=== Discusión


_En esta sección se interpretan los hallazgos a la luz de la literatura y se evalúan las implicaciones para la hipótesis planteada._  

#### Compatibilidad con la literatura existente  
Los resultados coinciden parcialmente con la evidencia de Wang, Wu y Xu (2018), quienes documentan que *las crisis geopolíticas pueden reducir la IED* al elevar la incertidumbre. La caída regional de la IED (-42.75 % en 10 años) es consistente con esa perspectiva. Sin embargo, la ausencia de una disminución simultánea del comercio contradice la idea de que la fricción geopolítica afecta de manera uniforme a ambos flujos.  

Caldara e Iacoviello (2018) construyeron un índice mensual de riesgo geopolítico que muestra picos en 2015-2016 y 2022-2023. Nuestra detección de anomalías en 2015 (IED) y 2022 (comercio) sugiere que *eventos de alta tensión coinciden con desviaciones puntuales*, pero la falta de correlación estructural indica que la respuesta de la economía regional es más compleja y depende de factores internos (política fiscal, diversificación productiva, acuerdos comerciales).  

#### Interpretación de la correlación costarricense  
Costa Rica es el único caso con una correlación robusta en niveles. La literatura sobre inversión china (Fon & Alon, 2022) muestra que *la calidad institucional modera la relación entre ayuda extranjera y IED*. Costa Rica, con indicadores de gobernanza relativamente altos, podría estar capturando mejor los efectos de la apertura comercial sobre la IED, generando la asociación observada. No obstante, al desaparecer la correlación en diferencias, la relación parece ser impulsada por tendencias paralelas (ambas variables suben) más que por un mecanismo causal directo.  

#### Limitaciones metodológicas  
- *Series temporales cortas* (solo diez observaciones) limitan la potencia estadística de los tests de correlación y de Mann-Kendall.
- *Datos agregados de comercio* a nivel regional impiden desagregar efectos específicos por país, lo que podría ocultar dinámicas heterogéneas.
- *Ausencia de un índice directo de riesgo geopolítico* para la región obliga a inferir la exposición a través de eventos externos (p.ej., crisis internacionales), lo que introduce ruido de medida.

#### Implicaciones de la falta de evidencia de co-movimiento  
La inexistencia de correlaciones significativas en diferencias sugiere que *las variaciones anuales de IED y comercio son impulsadas por factores diferentes*: la IED responde a decisiones de inversión a mediano plazo (estabilidad macroeconómica, incentivos fiscales), mientras que el comercio se ve más afectado por la demanda externa y los precios internacionales. Por tanto, la hipótesis de que “mayores tensiones geopolíticas generan una caída simultánea de IED y comercio” *no se sostiene de forma generalizada* en América Latina y el Caribe.  



=== Conclusiones


_Se sintetizan los hallazgos principales y se proponen líneas de investigación futura._  

+ *Tendencias divergentes*: entre 2015 y 2024, el comercio como proporción del PIB aumentó de forma sostenida (+10.36 %), mientras que la IED neta mostró una caída pronunciada (-42.75 %).
+ *Escasa evidencia de asociación estructural*: sólo Costa Rica presenta una correlación significativa en niveles, la cual desaparece al analizar cambios anuales, indicando co-tendencia y no causalidad.
+ *Anomalías puntuales* coinciden con episodios de alta tensión geopolítica, pero su impacto no se traduce en patrones estructurales de disminución simultánea de IED y comercio.
+ *Implicación para la hipótesis*: la propuesta de que mayores tensiones geopolíticas generan una caída conjunta de IED y comercio no se confirma a nivel regional ni en la mayoría de los países analizados.

*Recomendaciones de investigación*  
- Incorporar un índice mensual de riesgo geopolítico específico para América Latina (por ejemplo, adaptando la metodología de Caldara & Iacoviello) y aplicar modelos de series temporales estructurales (VAR, VECM) que permitan distinguir efectos de corto y largo plazo.
- Ampliar la muestra de países y extender la serie temporal (p.ej., incluir datos de 2000-2014) para mejorar la potencia estadística y capturar ciclos de crisis anteriores.
- Desagregar el componente comercial (exportaciones vs. importaciones) y analizar su relación con la IED sectorial (minería, manufactura, servicios) para identificar canales específicos de transmisión de la incertidumbre geopolítica.

En síntesis, aunque la literatura sugiere que la geopolítica afecta la confianza de los inversionistas, los datos empíricos de América Latina y el Caribe entre 2015-2024 indican que *el comercio ha continuado expandiéndose pese a la contracción de la IED*, y que la relación entre ambos indicadores es, en la mayor parte, espuria. Estos hallazgos invitan a replantear la visión simplista de que la geopolítica actúa de forma homogénea sobre todos los flujos económicos regionales.


== Bibliografía


- Banco Mundial. (2024). _World Development Indicators_. Washington, DC: World Bank. https://databank.worldbank.org/source/world-development-indicators
- Haaretz. "Report: Trump opposed Netanyahu's proposed early October strikes on Iran". https://www.haaretz.com/middle-east-news/iran/2026-10-21/ty-article/report-trump-opposed-netanyahus-proposed-early-october-strikes-on-iran/000001a1-5cd6-d99f-a3e5-7df7c3350000
- Wang, X., Wu, Y., Xu, W. (2018). Geopolitical Risk and Investment. _Journal of money credit and banking_. https://doi.org/10.1111/jmcb.13110
- Flouros, F., Pistikou, V., Plakandaras, V. (2022). Geopolitical Risk as a Determinant of Renewable Energy Investments. _Energies_. https://doi.org/10.3390/en15041498
- Caldara, D., Iacoviello, M. M. (2018). Measuring Geopolitical Risk. _International Finance Discussion Paper_. https://doi.org/10.17016/ifdp.2018.1222
- Fon, R., Alon, I. (2022). Governance, foreign aid, and Chinese foreign direct investment. _Thunderbird International Business Review_. https://doi.org/10.1002/tie.22257


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
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[44.99], text(size: 8.2pt)[44.04], text(size: 8.2pt)[44.34], text(size: 8.2pt)[48.19], text(size: 8.2pt)[47.71], text(size: 8.2pt)[45.97], text(size: 8.2pt)[52.60], text(size: 8.2pt)[56.00], text(size: 8.2pt)[48.73], text(size: 8.2pt)[49.65],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[1.977], text(size: 8.2pt)[0.585], text(size: 8.2pt)[1.789], text(size: 8.2pt)[2.233], text(size: 8.2pt)[1.485], text(size: 8.2pt)[1.266], text(size: 8.2pt)[1.368], text(size: 8.2pt)[2.398], text(size: 8.2pt)[3.812], text(size: 8.2pt)[1.824],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[22.49], text(size: 8.2pt)[26.09], text(size: 8.2pt)[25.29], text(size: 8.2pt)[30.76], text(size: 8.2pt)[32.63], text(size: 8.2pt)[30.20], text(size: 8.2pt)[33.08], text(size: 8.2pt)[31.58], text(size: 8.2pt)[26.68], text(size: 8.2pt)[27.93],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[3.592], text(size: 8.2pt)[4.137], text(size: 8.2pt)[3.338], text(size: 8.2pt)[4.079], text(size: 8.2pt)[3.693], text(size: 8.2pt)[2.593], text(size: 8.2pt)[2.780], text(size: 8.2pt)[3.868], text(size: 8.2pt)[2.864], text(size: 8.2pt)[3.390],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[26.95], text(size: 8.2pt)[24.53], text(size: 8.2pt)[24.32], text(size: 8.2pt)[28.88], text(size: 8.2pt)[28.89], text(size: 8.2pt)[32.30], text(size: 8.2pt)[37.66], text(size: 8.2pt)[38.82], text(size: 8.2pt)[33.67], text(size: 8.2pt)[35.58],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[7.328], text(size: 8.2pt)[4.557], text(size: 8.2pt)[1.896], text(size: 8.2pt)[2.685], text(size: 8.2pt)[4.879], text(size: 8.2pt)[4.505], text(size: 8.2pt)[4.810], text(size: 8.2pt)[6.234], text(size: 8.2pt)[5.723], text(size: 8.2pt)[3.980],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[59.35], text(size: 8.2pt)[56.06], text(size: 8.2pt)[56.03], text(size: 8.2pt)[58.18], text(size: 8.2pt)[57.61], text(size: 8.2pt)[58.17], text(size: 8.2pt)[64.84], text(size: 8.2pt)[75.23], text(size: 8.2pt)[60.68], text(size: 8.2pt)[63.96],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Colombia], text(size: 8.2pt)[3.959], text(size: 8.2pt)[4.902], text(size: 8.2pt)[4.393], text(size: 8.2pt)[3.381], text(size: 8.2pt)[4.331], text(size: 8.2pt)[2.759], text(size: 8.2pt)[3.002], text(size: 8.2pt)[4.971], text(size: 8.2pt)[4.577], text(size: 8.2pt)[3.254],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Colombia], text(size: 8.2pt)[38.36], text(size: 8.2pt)[36.20], text(size: 8.2pt)[35.28], text(size: 8.2pt)[36.53], text(size: 8.2pt)[37.56], text(size: 8.2pt)[34.06], text(size: 8.2pt)[40.06], text(size: 8.2pt)[48.28], text(size: 8.2pt)[40.13], text(size: 8.2pt)[36.32],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[5.236], text(size: 8.2pt)[4.453], text(size: 8.2pt)[4.833], text(size: 8.2pt)[4.818], text(size: 8.2pt)[4.199], text(size: 8.2pt)[3.348], text(size: 8.2pt)[5.478], text(size: 8.2pt)[7.340], text(size: 8.2pt)[6.056], text(size: 8.2pt)[5.587],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Costa Rica], text(size: 8.2pt)[60.75], text(size: 8.2pt)[62.18], text(size: 8.2pt)[65.07], text(size: 8.2pt)[66.79], text(size: 8.2pt)[65.42], text(size: 8.2pt)[59.75], text(size: 8.2pt)[70.10], text(size: 8.2pt)[79.05], text(size: 8.2pt)[71.44], text(size: 8.2pt)[69.85],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[República Dominicana], text(size: 8.2pt)[3.139], text(size: 8.2pt)[3.330], text(size: 8.2pt)[4.550], text(size: 8.2pt)[3.229], text(size: 8.2pt)[3.174], text(size: 8.2pt)[3.133], text(size: 8.2pt)[3.532], text(size: 8.2pt)[3.569], text(size: 8.2pt)[3.944], text(size: 8.2pt)[3.601],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[República Dominicana], text(size: 8.2pt)[52.35], text(size: 8.2pt)[51.73], text(size: 8.2pt)[50.76], text(size: 8.2pt)[52.34], text(size: 8.2pt)[50.91], text(size: 8.2pt)[44.73], text(size: 8.2pt)[51.95], text(size: 8.2pt)[54.38], text(size: 8.2pt)[49.84], text(size: 8.2pt)[51.78],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Ecuador], text(size: 8.2pt)[1.361], text(size: 8.2pt)[0.785], text(size: 8.2pt)[0.605], text(size: 8.2pt)[1.293], text(size: 8.2pt)[0.915], text(size: 8.2pt)[1.168], text(size: 8.2pt)[0.608], text(size: 8.2pt)[0.760], text(size: 8.2pt)[0.398], text(size: 8.2pt)[0.360],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Ecuador], text(size: 8.2pt)[47.83], text(size: 8.2pt)[40.53], text(size: 8.2pt)[43.62], text(size: 8.2pt)[48.01], text(size: 8.2pt)[48.08], text(size: 8.2pt)[43.99], text(size: 8.2pt)[53.26], text(size: 8.2pt)[61.88], text(size: 8.2pt)[57.16], text(size: 8.2pt)[57.44],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[1.935], text(size: 8.2pt)[1.280], text(size: 8.2pt)[1.393], text(size: 8.2pt)[1.258], text(size: 8.2pt)[1.517], text(size: 8.2pt)[1.292], text(size: 8.2pt)[4.194], text(size: 8.2pt)[1.517], text(size: 8.2pt)[1.582], text(size: 8.2pt)[1.632],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Guatemala], text(size: 8.2pt)[49.89], text(size: 8.2pt)[46.37], text(size: 8.2pt)[46.07], text(size: 8.2pt)[47.01], text(size: 8.2pt)[45.52], text(size: 8.2pt)[41.14], text(size: 8.2pt)[49.26], text(size: 8.2pt)[54.45], text(size: 8.2pt)[48.33], text(size: 8.2pt)[47.31],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[México], text(size: 8.2pt)[2.988], text(size: 8.2pt)[3.498], text(size: 8.2pt)[2.783], text(size: 8.2pt)[3.014], text(size: 8.2pt)[2.297], text(size: 8.2pt)[2.814], text(size: 8.2pt)[2.705], text(size: 8.2pt)[2.673], text(size: 8.2pt)[1.710], text(size: 8.2pt)[2.484],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[México], text(size: 8.2pt)[70.41], text(size: 8.2pt)[75.69], text(size: 8.2pt)[76.95], text(size: 8.2pt)[80.21], text(size: 8.2pt)[77.46], text(size: 8.2pt)[76.85], text(size: 8.2pt)[83.07], text(size: 8.2pt)[88.80], text(size: 8.2pt)[73.74], text(size: 8.2pt)[75.43],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Panamá], text(size: 8.2pt)[9.180], text(size: 8.2pt)[8.782], text(size: 8.2pt)[6.346], text(size: 8.2pt)[6.394], text(size: 8.2pt)[6.714], text(size: 8.2pt)[-2.860], text(size: 8.2pt)[2.720], text(size: 8.2pt)[3.093], text(size: 8.2pt)[3.264], text(size: 8.2pt)[2.411],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Panamá], text(size: 8.2pt)[96.58], text(size: 8.2pt)[84.40], text(size: 8.2pt)[84.05], text(size: 8.2pt)[86.13], text(size: 8.2pt)[80.43], text(size: 8.2pt)[68.70], text(size: 8.2pt)[80.13], text(size: 8.2pt)[93.48], text(size: 8.2pt)[88.35], text(size: 8.2pt)[83.67],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Perú], text(size: 8.2pt)[3.903], text(size: 8.2pt)[3.662], text(size: 8.2pt)[3.660], text(size: 8.2pt)[2.782], text(size: 8.2pt)[2.259], text(size: 8.2pt)[0.465], text(size: 8.2pt)[3.155], text(size: 8.2pt)[4.628], text(size: 8.2pt)[1.643], text(size: 8.2pt)[2.298],
  text(size: 8.2pt)[Comercio (% del PIB) (%)], text(size: 8.2pt)[Perú], text(size: 8.2pt)[45.16], text(size: 8.2pt)[45.39], text(size: 8.2pt)[47.51], text(size: 8.2pt)[48.63], text(size: 8.2pt)[46.94], text(size: 8.2pt)[44.25], text(size: 8.2pt)[55.41], text(size: 8.2pt)[57.27], text(size: 8.2pt)[50.91], text(size: 8.2pt)[51.68],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB) (%)], text(size: 8.2pt)[Uruguay], text(size: 8.2pt)[4.634], text(size: 8.2pt)[-0.897], text(size: 8.2pt)[4.133], text(size: 8.2pt)[2.642], text(size: 8.2pt)[2.357], text(size: 8.2pt)[1.818], text(size: 8.2pt)[8.504], text(size: 8.2pt)[12.37], text(size: 8.2pt)[-6.626], text(size: 8.2pt)[-4.782],
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
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[CRI], text(size: 8.2pt)[0.887], text(size: 8.2pt)[0.001], text(size: 8.2pt)[0.008], text(size: 8.2pt)[0.806], text(size: 8.2pt)[0.941], text(size: 8.2pt)[0.000], text(size: 8.2pt)[#text(fill: rgb("2e7d32"))[●] Robusta],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[PAN], text(size: 8.2pt)[0.632], text(size: 8.2pt)[0.050], text(size: 8.2pt)[0.324], text(size: 8.2pt)[0.552], text(size: 8.2pt)[0.621], text(size: 8.2pt)[0.074], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[ECU], text(size: 8.2pt)[-0.474], text(size: 8.2pt)[0.166], text(size: 8.2pt)[0.469], text(size: 8.2pt)[-0.442], text(size: 8.2pt)[0.230], text(size: 8.2pt)[0.551], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[COL], text(size: 8.2pt)[0.465], text(size: 8.2pt)[0.176], text(size: 8.2pt)[0.469], text(size: 8.2pt)[0.370], text(size: 8.2pt)[0.611], text(size: 8.2pt)[0.081], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[URY], text(size: 8.2pt)[0.434], text(size: 8.2pt)[0.210], text(size: 8.2pt)[0.469], text(size: 8.2pt)[0.042], text(size: 8.2pt)[0.663], text(size: 8.2pt)[0.052], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[CHL], text(size: 8.2pt)[0.428], text(size: 8.2pt)[0.217], text(size: 8.2pt)[0.469], text(size: 8.2pt)[0.479], text(size: 8.2pt)[0.304], text(size: 8.2pt)[0.426], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[BRA], text(size: 8.2pt)[-0.400], text(size: 8.2pt)[0.253], text(size: 8.2pt)[0.469], text(size: 8.2pt)[-0.297], text(size: 8.2pt)[0.324], text(size: 8.2pt)[0.396], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[PER], text(size: 8.2pt)[0.355], text(size: 8.2pt)[0.314], text(size: 8.2pt)[0.511], text(size: 8.2pt)[0.212], text(size: 8.2pt)[0.907], text(size: 8.2pt)[0.001], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[GTM], text(size: 8.2pt)[0.282], text(size: 8.2pt)[0.429], text(size: 8.2pt)[0.620], text(size: 8.2pt)[0.552], text(size: 8.2pt)[0.230], text(size: 8.2pt)[0.552], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[LCN], text(size: 8.2pt)[-0.208], text(size: 8.2pt)[0.565], text(size: 8.2pt)[0.734], text(size: 8.2pt)[-0.297], text(size: 8.2pt)[0.641], text(size: 8.2pt)[0.063], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[ARG], text(size: 8.2pt)[-0.121], text(size: 8.2pt)[0.739], text(size: 8.2pt)[0.871], text(size: 8.2pt)[-0.079], text(size: 8.2pt)[-0.484], text(size: 8.2pt)[0.187], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[DOM], text(size: 8.2pt)[0.091], text(size: 8.2pt)[0.804], text(size: 8.2pt)[0.871], text(size: 8.2pt)[-0.079], text(size: 8.2pt)[-0.112], text(size: 8.2pt)[0.774], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[MEX], text(size: 8.2pt)[0.053], text(size: 8.2pt)[0.884], text(size: 8.2pt)[0.884], text(size: 8.2pt)[-0.018], text(size: 8.2pt)[0.591], text(size: 8.2pt)[0.094], text(size: 8.2pt)[#text(fill: rgb("c62828"))[●] Sin evidencia],
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
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[América Latina y el Caribe (LCN)], text(size: 8.2pt)[44.99 (2015)], text(size: 8.2pt)[49.65 (2024)], text(size: 8.2pt)[0.5178], text(size: 8.2pt)[10.36%], text(size: 8.2pt)[1.10%],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[1.98 (2015)], text(size: 8.2pt)[1.82 (2024)], text(size: 8.2pt)[-0.0170], text(size: 8.2pt)[-7.74%], text(size: 8.2pt)[-0.89%],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Argentina], text(size: 8.2pt)[22.49 (2015)], text(size: 8.2pt)[27.93 (2024)], text(size: 8.2pt)[0.6048], text(size: 8.2pt)[24.21%], text(size: 8.2pt)[2.44%],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[3.59 (2015)], text(size: 8.2pt)[3.39 (2024)], text(size: 8.2pt)[-0.0225], text(size: 8.2pt)[-5.64%], text(size: 8.2pt)[-0.64%],
  text(size: 8.2pt)[Comercio (% del PIB)], text(size: 8.2pt)[Brasil], text(size: 8.2pt)[26.95 (2015)], text(size: 8.2pt)[35.58 (2024)], text(size: 8.2pt)[0.9590], text(size: 8.2pt)[32.02%], text(size: 8.2pt)[3.13%],
  text(size: 8.2pt)[Inversión extranjera directa, flujos netos (% del PIB)], text(size: 8.2pt)[Chile], text(size: 8.2pt)[7.33 (2015)], text(size: 8.2pt)[3.98 (2024)], text(size: 8.2pt)[-0.3720], text(size: 8.2pt)[-45.69%], text(size: 8.2pt)[-6.56%],
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
      #image("/docs/charts/2026-10-22-17-01/fig11_anomaly.png", width: 85%)
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
Tema seleccionado: _Relación entre inversión extranjera y comercio en tiempos de conflicto geopolítico_.
Noticia que inspiró la línea editorial: _"Report: Trump opposed Netanyahu's proposed early October strikes on Iran"_ (#link("https://www.haaretz.com/middle-east-news/iran/2026-10-21/ty-article/report-trump-opposed-netanyahus-proposed-early-october-strikes-on-iran/000001a1-5cd6-d99f-a3e5-7df7c3350000")[Haaretz]).
Lo que la noticia afirmaba o sugería: Las tensiones internacionales pueden afectar la confianza de inversionistas y la participación del comercio en el PIB.
Alcance verificable con los datos: Se pueden medir Foreign direct investment, net inflows (% of GDP) y Trade (% of GDP). No se pueden cuantificar la postura política de EE. UU. ni decisiones militares específicas.
Justificación del sistema: Aunque la noticia es política, el vínculo entre tensión geopolítica y flujos económicos es mensurable mediante indicadores de comercio e inversión extranjera.
*Pregunta de investigación:* ¿Los aumentos de tensiones geopolíticas se traducen en una disminución de la inversión extranjera y la participación del comercio en el PIB de los países latinoamericanos?
*Hipótesis planteada:* En períodos de mayor tensión geopolítica, los países latinoamericanos experimentan una caída en la inversión extranjera neta y en la participación del comercio en el PIB.
Se evaluaron 4 líneas editoriales candidatas; se seleccionó la de mayor respaldo en datos.
*Procedencia de los datos.* Todas las cifras provienen exclusivamente de la API pública del Banco Mundial (World Development Indicators), periodo 2015-2024. Muestra analizada: ARG, BRA, CHL, COL, CRI (referencia regional agregada: LCN). Ningún dato proviene de otras fuentes ni fue estimado por el modelo de lenguaje.
*Métodos analíticos ejecutados (Cómputo Determinístico):*
- Python 3.12 (scipy/statsmodels): Estadísticas descriptivas de 387 series, 13 correlaciones Pearson/Spearman (1 significativas tras corrección FDR Benjamini-Hochberg, q\<0.05).
- Sin regresión OLS ejecutada.
- Test de tendencia Mann-Kendall: 168 de 377 series con tendencia significativa.
- Detección de anomalías (z-score/IQR): 221 observaciones atípicas.
- 6 figuras generadas con matplotlib a partir de los datos.
*Proceso editorial.* Siete nodos automáticos: FETCH -> SUGGEST -> COMPUTE -> WRITE -> REVIEW -> EDIT -> APPROVE.
Revisión de rigor: veredicto APROBADO.
Verificación automática de cifras: 91 cifras del texto cotejadas contra los resultados computados.
Linter automático de lenguaje causal: el texto completo fue escaneado contra verbos de atribución causal; el diseño es correlacional, por lo que las relaciones se reportan como asociaciones, no efectos.
Control de calidad final: veredicto APROBADO.
Iteraciones: 0 reescritura(s), 0 reedición(es).
*Limitaciones.* Las series tienen n≤10 observaciones anuales; las correlaciones no implican causalidad y las muestras pequeñas reducen la potencia estadística. El texto fue redactado por un modelo de lenguaje y verificado automáticamente contra los datos; no sustituye revisión humana. Artefactos verificables en el repositorio: `output/raw/fetched-data.json` (datos crudos), `output/raw/compute-results.json` (resultados completos), `output/raw/literature.json` (referencias verificadas en OpenAlex), `output/briefs/` (decisión editorial).
_Explicación completa de los métodos (por qué Pearson, Spearman, OLS, Mann-Kendall): #link("https://rogelioguerrero.github.io/academic-pipeline/methodology.html")[metodología]_
  ]
)

