// ==============================================================================
// COMPARATIVO FORENSE A ESCALA 1:1 — FASE 4.3.3
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
//
// Comparación lado a lado a escala 1:1:
// Fase 4.3.2 (content_dy 135 pt) vs. Fase 4.3.3 (content_dy 126 pt)
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
        #text(size: 6pt, fill: rgb("#6c6b67"), tracking: 0.200em)[POLIDUCTOS FLEXIBLES, S.A. DE C.V. · PROTOCOLO FAMILIAR · FASE 4.3.3]
        #v(1pt)
        #text(size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[COMPARATIVA FORENSE A ESCALA 1:1 · MICROAJUSTE VERTICAL DE INTRODUCTION-PAGE()]
      ],
      [
        #text(size: 8pt, weight: "bold", fill: rgb("#f04e23"))[LÁMINA COMPARATIVA A3 (ESCALA 1:1)]
        #v(1pt)
        #text(size: 6.5pt, fill: rgb("#6c6b67"))[Fase 4.3.2 (135 pt) vs. Fase 4.3.3 (126 pt)]
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
      #text(weight: "bold", size: 9pt, fill: rgb("#6c6b67"))[FASE 4.3.2 · BASELINE PREVIA (content_dy = 135.00 pt)]
      #v(3pt)
      #set text(size: 6.8pt, fill: rgb("#2e2f31"))
      #list(
        [*content_dy:* 135.00 pt.],
        [*Regla naranja:* y = 110.00 pt (inferior: 110.90 pt).],
        [*Distancia regla → 1ª línea:* 23.51 pt (luz libre) / 24.41 pt (cota).],
        [*Inicio del cuerpo (P1):* y0 = 134.41 pt.],
        [*Final del cuerpo (P6):* y1 = 538.32 pt.],
        [*Aire inferior resultante:* 56.32 pt libres (4.43 líneas de ritmo).]
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
      inset: 8pt,
      radius: 3pt
    )[
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[FASE 4.3.3 · MICROAJUSTE (content_dy = 126.00 pt)]
      #v(3pt)
      #set text(size: 6.8pt, fill: rgb("#2e2f31"))
      #list(
        [*content_dy:* 126.00 pt (-9.00 pt vertical).],
        [*Regla naranja:* y = 110.00 pt (inferior: 110.90 pt).],
        [*Distancia regla → 1ª línea:* 14.51 pt (luz libre) / 15.41 pt (cota).],
        [*Inicio del cuerpo (P1):* y0 = 125.41 pt (-9.00 pt).],
        [*Final del cuerpo (P6):* y1 = 529.32 pt (-9.00 pt).],
        [*Aire inferior resultante:* 65.32 pt libres (5.13 líneas, +9.00 pt holgura).]
      )
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#f04e23"), radius: 2pt, clip: true)[
      #image("/dist/TEST_INTRODUCCION_FASE_4_3_3.pdf", page: 2, width: 396pt, height: 612pt)
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
      #text(weight: "bold", size: 9.5pt, fill: rgb("#2e2f31"))[AUDITORÍA FORENSE DEL MICROAJUSTE]
      #v(4pt)
      #set text(size: 7.0pt, fill: rgb("#2e2f31"))
      *1. Parámetros Invariables al 100%:*
      #list(
        [Geometría: 396 × 612 pt (Media Carta)],
        [Tipografía de título: Minion Pro 15.9929 pt],
        [Posición de título: dy = 85.00 pt (y0 = 83.78 pt)],
        [Regla naranja: x = 60.10 pt, y = 110.00 pt (\#f15d22)],
        [Claim institucional superior (4 líneas) intacto],
        [Arcos concéntricos al 50% intactos],
        [Filete de lomo en x = 30.13 pt intacto],
        [Neuzeit Grotesk 7.9077 pt, leading 12.72949 pt],
        [Separación entre párrafos: 12.72949 pt],
        [Justificación: true, hyphenate: false],
        [Ancho de caja útil: 314.56 pt],
        [Pie institucional y folio: 594.64 pt intacto]
      )

      *2. Única Modificación Experimental:*
      #list(
        [Desplazamiento en bloque del cuerpo: -9.00 pt],
        [content_dy: 135.00 pt → 126.00 pt]
      )

      *3. Comparativa de Distancias y Espacios:*
      #list(
        [Regla → 1ª línea (luz libre): 23.51 pt → 14.51 pt],
        [Regla → 1ª línea (cota top): 24.41 pt → 15.41 pt],
        [Inicio de cuerpo: 134.41 pt → 125.41 pt],
        [Final de cuerpo: 538.32 pt → 529.32 pt],
        [Aire inferior libre: 56.32 pt → 65.32 pt (+9.00 pt)]
      )

      *4. Integridad Textual Canónica:*
      #list(
        [Texto canónico: 305 palabras (100% idéntico)],
        [Líneas totales: 23 líneas exactas (6 párrafos)],
        [Distribución: 3 + 6 + 4 + 4 + 3 + 3 = 23 líneas]
      )

      *5. Veredicto Técnico:*
      La transición entre el título, la regla acento y el cuerpo de texto adquiere una cadencia más compacta y armónica (14.51 pt de luz), a la vez que maximiza la holgura y dignidad ceremonial del pie de página (65.32 pt libres).
    ]
  ]
)

// ------------------------------------------------------------------------------
// PÁGINA 2: SPREAD 1:1 DE FASE 4.3.3 (792 × 612 pt)
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
  image("/dist/TEST_INTRODUCCION_FASE_4_3_3.pdf", page: 1, width: 396pt, height: 612pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_3.pdf", page: 2, width: 396pt, height: 612pt)
)

// ------------------------------------------------------------------------------
// PÁGINA 3: SPREAD 1:1 DE FASE 4.3.2 (792 × 612 pt)
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
