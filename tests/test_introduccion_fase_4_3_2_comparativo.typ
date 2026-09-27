// ==============================================================================
// COMPARATIVO FORENSE A ESCALA 1:1 — FASE 4.3.2
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
//
// Comparación lado a lado a escala 1:1:
// CHAPTER-FIRST-PAGE() de Capítulo 01 (LOCKED) vs. INTRODUCCIÓN NUEVA (EXPERIMENTAL)
// ==============================================================================

#set text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt)

// ------------------------------------------------------------------------------
// PÁGINA 1: LÁMINA A3 HORIZONTAL — COMPARACIÓN 1:1 LADO A LADO CON FICHA TÉCNICA
// ------------------------------------------------------------------------------
#set page(
  paper: "a3",
  flipped: true,
  margin: (x: 1.5cm, top: 1.2cm, bottom: 1.0cm),
  header: context [
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #text(size: 6pt, fill: rgb("#6c6b67"), tracking: 0.200em)[POLIDUCTOS FLEXIBLES, S.A. DE C.V. · PROTOCOLO FAMILIAR · FASE 4.3.2]
        #v(1pt)
        #text(size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[COMPARATIVA FORENSE A ESCALA 1:1 · CHAPTER-FIRST-PAGE() vs. INTRODUCCIÓN NUEVA]
      ],
      [
        #text(size: 8pt, weight: "bold", fill: rgb("#f04e23"))[LÁMINA COMPARATIVA A3 (ESCALA 1:1)]
        #v(1pt)
        #text(size: 6.5pt, fill: rgb("#6c6b67"))[Herencia Directa de Componentes Aprobados]
      ]
    )
    #v(3pt)
    #line(length: 100%, stroke: 0.8pt + rgb("#f04e23"))
  ],
  footer: context [
    #line(length: 100%, stroke: 0.4pt + rgb("#cbd5e1"))
    #v(2pt)
    #grid(
      columns: (1fr, 1fr),
      text(size: 6pt, fill: rgb("#6c6b67"))[Protocolo Familiar POLIFLEX · Familia Velasco Chedraui · Septiembre 2026],
      align(right)[#text(size: 6pt, fill: rgb("#6c6b67"))[Página 1 de 3]]
    )
  ]
)

#v(8pt)

#grid(
  columns: (396pt, 396pt, 1fr),
  column-gutter: 1.0cm,
  [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 3pt
    )[
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[CHAPTER-FIRST-PAGE() · CAPÍTULO 01 (LOCKED)]
      #v(3pt)
      #set text(size: 6.8pt, fill: rgb("#2e2f31"))
      #list(
        [*Número de capítulo:* "01" (Minion Pro 39.37 pt en dy = 82.45 pt).],
        [*Regla naranja:* x = 60.10 pt, y = 128.95 pt, ancho = 14.19 pt.],
        [*Título de capítulo:* Minion Pro 15.99 pt en dy = 152.30 pt.],
        [*Inicio de cuerpo:* content_dy = 231.80 pt (2 encabezados + 2 párrafos).],
        [*Claim y Arcos:* Arcos 50% top-right, Claim institucional a 4 líneas.]
      )
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#94a3b8"), radius: 2pt, clip: true)[
      #image("/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_3.pdf", page: 5, width: 396pt, height: 612pt)
    ]
  ],
  [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 3pt
    )[
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[INTRODUCCIÓN NUEVA · FASE 4.3.2 (EXPERIMENTAL)]
      #v(3pt)
      #set text(size: 6.8pt, fill: rgb("#2e2f31"))
      #list(
        [*Número de capítulo:* SUPRIMIDO (no es un capítulo; sin CAPÍTULO 00).],
        [*Título de sección:* INTRODUCCIÓN (Minion Pro 15.99 pt en dy = 85.0 pt).],
        [*Regla naranja:* x = 60.10 pt, y = 110.00 pt, ancho = 14.19 pt (\#f15d22).],
        [*Inicio de cuerpo:* content_dy = 135.00 pt (6 párrafos íntegros, 23 líneas).],
        [*Claim y Arcos:* Arcos 50% y Claim institucional 100% IDÉNTICOS.]
      )
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#94a3b8"), radius: 2pt, clip: true)[
      #image("/dist/TEST_INTRODUCCION_FASE_4_3_2_CHAPTER_STYLE.pdf", page: 2, width: 396pt, height: 612pt)
    ]
  ],
  [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 10pt,
      radius: 4pt
    )[
      #text(weight: "bold", size: 9.5pt, fill: rgb("#2e2f31"))[AUDITORÍA DE HERENCIA DIRECTA]
      #v(4pt)
      #set text(size: 7.0pt, fill: rgb("#2e2f31"))
      *1. Parámetros Heredados Literalmente:*
      #list(
        [Formato de página: 396 × 612 pt (Media Carta)],
        [Retícula vertical y horizontal consolidada],
        [Margen interior (lomo): 58.74 pt],
        [Margen exterior (corte): 22.70 pt],
        [Filete vertical de lomo en x = 30.13 pt],
        [Arcos superiores concéntricos al 50% de opacidad],
        [Claim institucional: "UN LEGADO QUE TRASCIENDE..."],
        [Tipografía de título: Minion Pro Medium Display 15.99 pt],
        [Regla horizontal institucional: width 14.19 pt (\#f15d22)],
        [Tipografía de cuerpo: Neuzeit Grotesk 7.9077 pt],
        [Interlineado (leading Typst): 12.72949 pt],
        [Ancho útil de texto: 314.56 pt (sin sangría)],
        [Justificación: true, hyphenate: false, linebreaks: "simple"],
        [Pie institucional: Frase, Versión e Isotipo al 50%],
        [Folio dinámico en corte exterior: "05" en Minion 10 pt]
      )

      *2. Elementos Exclusivamente Suprimidos:*
      #list(
        [Número grande de capítulo (39.37 pt)],
        [Etiqueta "CAPÍTULO 00" o "00"],
        [Cualquier numeración ficticia],
        [Subtítulos o cintillos inventados]
      )

      *3. Métricas Verticales de Calibración:*
      #list(
        [Posición Y de INTRODUCCIÓN: y0 = 83.8 pt, y1 = 99.8 pt],
        [Posición Y de regla naranja: y = 110.00 pt],
        [Inicio de cuerpo de texto: y = 134.40 pt],
        [Fin de cuerpo de texto: y = 538.32 pt (23 líneas)],
        [Aire inferior libre: 56.32 pt antes del folio institucional]
      )

      *4. Veredicto Técnico:*
      La Introducción se integra orgánicamente en el sistema editorial matriz sin romper la armonía ceremonial de la obra.
    ]
  ]
)

// ------------------------------------------------------------------------------
// PÁGINA 2: SPREAD 1:1 DE INTRODUCCIÓN (792 × 612 pt)
// ------------------------------------------------------------------------------
#set page(
  width: 792pt,
  height: 612pt,
  flipped: false,
  margin: 0pt,
  header: none,
  footer: none
)

#grid(
  columns: (396pt, 396pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_2_CHAPTER_STYLE.pdf", page: 1, width: 396pt, height: 612pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_2_CHAPTER_STYLE.pdf", page: 2, width: 396pt, height: 612pt)
)

// ------------------------------------------------------------------------------
// PÁGINA 3: SPREAD 1:1 DE CAPÍTULO 01 (792 × 612 pt)
// ------------------------------------------------------------------------------
#set page(
  width: 792pt,
  height: 612pt,
  flipped: false,
  margin: 0pt,
  header: none,
  footer: none
)

#grid(
  columns: (396pt, 396pt),
  image("/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_3.pdf", page: 4, width: 396pt, height: 612pt),
  image("/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_3.pdf", page: 5, width: 396pt, height: 612pt)
)
