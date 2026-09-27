// ==============================================================================
// COMPARATIVO FORENSE DE INTRODUCCIÓN — FASE 4.3
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================

#set text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt)

// ------------------------------------------------------------------------------
// PÁGINA 1: LÁMINA A3 HORIZONTAL — COMPARACIÓN TRIPARTITA A ESCALA EQUIVALENTE
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
        #text(size: 6pt, fill: rgb("#6c6b67"), tracking: 0.200em)[POLIDUCTOS FLEXIBLES, S.A. DE C.V. · PROTOCOLO FAMILIAR · FASE 4.3]
        #v(1pt)
        #text(size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[COMPARATIVA FORENSE DE PROTOTIPOS EDITORIALES: INTRODUCCIÓN]
      ],
      [
        #text(size: 8pt, weight: "bold", fill: rgb("#f04e23"))[LÁMINA COMPARATIVA A3 (ESCALA 1:1)]
        #v(1pt)
        #text(size: 6.5pt, fill: rgb("#6c6b67"))[Alternativa A: Página Noble Unitaria en Recto]
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
      align(right)[#text(size: 6pt, fill: rgb("#6c6b67"))[Página 1 de 4]]
    )
  ]
)

#v(8pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1.2cm,
  [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 3pt
    )[
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[VARIANTE A · SOBRIA / BASELINE]
      #v(2pt)
      #text(size: 6.8pt, fill: rgb("#2e2f31"))[
        • *Filosofía:* Continuidad estricta con la baseline de lectura.\
        • *Tipografía:* Neuzeit Grotesk 7.9077 pt / Leading 12.73 pt.\
        • *Caja de texto:* 314.56 pt (ancho útil completo).\
        • *Encabezado:* Minion Pro 15.99 pt + Cintillo naranja.\
        • *Respiración:* 51.32 pt de aire antes del folio institucional.
      ]
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#94a3b8"), radius: 2pt, clip: true)[
      #image("/dist/TEST_INTRODUCCION_FASE_4_3_A.pdf", page: 2, width: 100%)
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
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[VARIANTE B · RESPIRACIÓN CEREMONIAL]
      #v(2pt)
      #text(size: 6.8pt, fill: rgb("#2e2f31"))[
        • *Filosofía:* Mayor aire periférico y nobleza pausada.\
        • *Tipografía:* Neuzeit 8.0 pt / Lead Par 8.2 pt / Leading 12.8–13.5 pt.\
        • *Caja de texto:* 304.56 pt (10 pt de sangría bilateral noble).\
        • *Encabezado:* Minion Pro 16.5 pt espaciado (tracking 0.080 em).\
        • *Respiración:* 42.14 pt de aire antes del folio noble.
      ]
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#94a3b8"), radius: 2pt, clip: true)[
      #image("/dist/TEST_INTRODUCCION_FASE_4_3_B.pdf", page: 2, width: 100%)
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
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[VARIANTE C · IDENTIDAD ASIMÉTRICA]
      #v(2pt)
      #text(size: 6.8pt, fill: rgb("#2e2f31"))[
        • *Filosofía:* ADN corporativo contemporáneo con barra de acento.\
        • *Tipografía:* Neuzeit 7.9077 pt / Sangría clásica 14 pt.\
        • *Caja de texto:* 314.56 pt + Colofón institucional de cierre.\
        • *Encabezado:* Barra vertical naranja 2 pt + Triple nivel institucional.\
        • *Respiración:* 44.92 pt de aire antes del folio en color acento.
      ]
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#94a3b8"), radius: 2pt, clip: true)[
      #image("/dist/TEST_INTRODUCCION_FASE_4_3_C.pdf", page: 2, width: 100%)
    ]
  ]
)

// ------------------------------------------------------------------------------
// PÁGINAS 2, 3, 4: SPREADS REALES EN TAMAÑO 792 × 612 pt (MEDIA CARTA DOBLE)
// ------------------------------------------------------------------------------
#set page(
  width: 792pt,
  height: 612pt,
  margin: 0pt,
  header: none,
  footer: none
)

// SPREAD VARIANTE A
#grid(
  columns: (396pt, 396pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_A.pdf", page: 1, width: 396pt, height: 612pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_A.pdf", page: 2, width: 396pt, height: 612pt)
)

// SPREAD VARIANTE B
#grid(
  columns: (396pt, 396pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_B.pdf", page: 1, width: 396pt, height: 612pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_B.pdf", page: 2, width: 396pt, height: 612pt)
)

// SPREAD VARIANTE C
#grid(
  columns: (396pt, 396pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_C.pdf", page: 1, width: 396pt, height: 612pt),
  image("/dist/TEST_INTRODUCCION_FASE_4_3_C.pdf", page: 2, width: 396pt, height: 612pt)
)
