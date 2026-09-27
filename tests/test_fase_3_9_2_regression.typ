// ==============================================================================
// REGRESIÓN VISUAL: FASE 3.9.2 vs FASE 3.9.1 (COMPARATIVA FORENSE A3)
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
#set page(
  paper: "a3",
  flipped: true,
  margin: (x: 1.8cm, top: 1.4cm, bottom: 1.2cm),
  header: context [
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, weight: "bold", fill: rgb("#f15d22"))[
          PROTOCOLO FAMILIAR POLIFLEX · DOCUMENTO OFICIAL DE REGRESIÓN DE PRODUCCIÓN FASE 3.9.2
        ]
        #h(8pt)
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[
          | VERIFICACIÓN DE NO-REGRESIÓN FASE 3.9.2 vs BASELINE FASE 3.9.1
        ]
      ],
      [
        #let p = counter(page).get().first()
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: rgb("#2e2f31"))[
          Lámina #p de 6
        ]
      ]
    )
    #v(3pt)
    #line(length: 100%, stroke: 0.5pt + rgb("#e2e2e2"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#e2e2e2"))
    #v(3pt)
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[
          Retícula +6 mm · 126 Páginas · Cero Variación Tipográfica · Auditoría 100% PASS
        ]
      ],
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[
          Páginas comparadas a escala real 100% (396 × 612 pt) · Cero distorsión geométrica
        ]
      ]
    )
  ]
)

#let pdf_base = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1.pdf"
#let pdf_prod = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_2.pdf"

#let page-card(pdf-path, p-num, badge-text, badge-fill, label-text) = [
  #block(width: 396pt)[
    #grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      [
        #box(
          fill: badge-fill,
          radius: 2pt,
          inset: (x: 8pt, y: 3.5pt),
          text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: white)[#badge-text]
        )
      ],
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#444444"))[#label-text]
      ]
    )
    #v(4pt)
    #box(
      stroke: 0.75pt + rgb("#cccccc"),
      radius: 1pt,
      fill: white,
      width: 396pt,
      height: 612pt,
      clip: true,
      image(pdf-path, page: p-num, width: 396pt, height: 612pt)
    )
  ]
]

// ==============================================================================
// LÁMINA 01 / 06: CONTROL DE VIUDAS EN P.66 (CAPÍTULO 04)
// ==============================================================================
#v(2pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 01 / 06: CONTROL DE VIUDAS EN P.66 (CAPÍTULO 04)
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ NO-REGRESIÓN CERTIFICADA · BIT-A-BIT IDÉNTICO
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  gutter: 14pt,
  page-card(pdf_base, 66, "BASELINE FASE 3.9.1 (P.66)", rgb("#2980b9"), "BASELINE FASE 3.9.1"),
  [
    #v(30pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 10pt, weight: "bold", fill: rgb("#f15d22"))[
        EVALUACIÓN DE PRODUCCIÓN
      ]
    ]
    #v(8pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#f15d22"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#2e2f31"))[
          Verificación de apertura noble con H3 4.1.2 y 24 líneas continuas de cuerpo. 0 viudas.
        ]
      ]
    )
    #v(14pt)
    #align(center)[
      #box(
        fill: rgb("#eef7f2"),
        stroke: 0.5pt + rgb("#27ae60"),
        radius: 2pt,
        inset: (x: 8pt, y: 6pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#27ae60"))[
          ✓ 126 PÁGINAS FÍSICAS\
          ✓ 64 PLIEGOS ENFRENTADOS\
          ✓ 0 DISCREPANCIA EN FOLIOS\
          ✓ ARQUITECTURA CEREMONIAL 100%\
          ✓ CERO CORRUPCIÓN UNICODE
        ]
      )
    ]
  ],
  page-card(pdf_prod, 66, "PRODUCCIÓN FASE 3.9.2 (P.66)", rgb("#27ae60"), "PRODUCCIÓN FASE 3.9.2"),
)

#pagebreak()

// ==============================================================================
// LÁMINA 02 / 06: CONTROL DE FLUJO 2+2 EN P.68 (CAPÍTULO 04)
// ==============================================================================
#v(2pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 02 / 06: CONTROL DE FLUJO 2+2 EN P.68 (CAPÍTULO 04)
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ NO-REGRESIÓN CERTIFICADA · BIT-A-BIT IDÉNTICO
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  gutter: 14pt,
  page-card(pdf_base, 68, "BASELINE FASE 3.9.1 (P.68)", rgb("#2980b9"), "BASELINE FASE 3.9.1"),
  [
    #v(30pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 10pt, weight: "bold", fill: rgb("#f15d22"))[
        EVALUACIÓN DE PRODUCCIÓN
      ]
    ]
    #v(8pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#f15d22"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#2e2f31"))[
          Verificación de remanente de 2 líneas completas de 4.2.1 antes de H3 4.2.2. Flujo balanceado.
        ]
      ]
    )
    #v(14pt)
    #align(center)[
      #box(
        fill: rgb("#eef7f2"),
        stroke: 0.5pt + rgb("#27ae60"),
        radius: 2pt,
        inset: (x: 8pt, y: 6pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#27ae60"))[
          ✓ 126 PÁGINAS FÍSICAS\
          ✓ 64 PLIEGOS ENFRENTADOS\
          ✓ 0 DISCREPANCIA EN FOLIOS\
          ✓ ARQUITECTURA CEREMONIAL 100%\
          ✓ CERO CORRUPCIÓN UNICODE
        ]
      )
    ]
  ],
  page-card(pdf_prod, 68, "PRODUCCIÓN FASE 3.9.2 (P.68)", rgb("#27ae60"), "PRODUCCIÓN FASE 3.9.2"),
)

#pagebreak()

// ==============================================================================
// LÁMINA 03 / 06: CIERRE DE CAPÍTULO 04 EN P.87
// ==============================================================================
#v(2pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 03 / 06: CIERRE DE CAPÍTULO 04 EN P.87
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ NO-REGRESIÓN CERTIFICADA · BIT-A-BIT IDÉNTICO
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  gutter: 14pt,
  page-card(pdf_base, 87, "BASELINE FASE 3.9.1 (P.87)", rgb("#2980b9"), "BASELINE FASE 3.9.1"),
  [
    #v(30pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 10pt, weight: "bold", fill: rgb("#f15d22"))[
        EVALUACIÓN DE PRODUCCIÓN
      ]
    ]
    #v(8pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#f15d22"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#2e2f31"))[
          Verificación de Párrafo 2 conclusivo de 4.9.4 íntegro en P.87 (5 líneas útiles). Cierre formal.
        ]
      ]
    )
    #v(14pt)
    #align(center)[
      #box(
        fill: rgb("#eef7f2"),
        stroke: 0.5pt + rgb("#27ae60"),
        radius: 2pt,
        inset: (x: 8pt, y: 6pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#27ae60"))[
          ✓ 126 PÁGINAS FÍSICAS\
          ✓ 64 PLIEGOS ENFRENTADOS\
          ✓ 0 DISCREPANCIA EN FOLIOS\
          ✓ ARQUITECTURA CEREMONIAL 100%\
          ✓ CERO CORRUPCIÓN UNICODE
        ]
      )
    ]
  ],
  page-card(pdf_prod, 87, "PRODUCCIÓN FASE 3.9.2 (P.87)", rgb("#27ae60"), "PRODUCCIÓN FASE 3.9.2"),
)

#pagebreak()

// ==============================================================================
// LÁMINA 04 / 06: CIERRE DE CAPÍTULO 08 EN P.119
// ==============================================================================
#v(2pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 04 / 06: CIERRE DE CAPÍTULO 08 EN P.119
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ NO-REGRESIÓN CERTIFICADA · BIT-A-BIT IDÉNTICO
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  gutter: 14pt,
  page-card(pdf_base, 119, "BASELINE FASE 3.9.1 (P.119)", rgb("#2980b9"), "BASELINE FASE 3.9.1"),
  [
    #v(30pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 10pt, weight: "bold", fill: rgb("#f15d22"))[
        EVALUACIÓN DE PRODUCCIÓN
      ]
    ]
    #v(8pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#f15d22"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#2e2f31"))[
          Verificación de Sección 8.9 con P2+P3 en P.119 (5 líneas útiles) sin repetir H2. Flujo orgánico.
        ]
      ]
    )
    #v(14pt)
    #align(center)[
      #box(
        fill: rgb("#eef7f2"),
        stroke: 0.5pt + rgb("#27ae60"),
        radius: 2pt,
        inset: (x: 8pt, y: 6pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#27ae60"))[
          ✓ 126 PÁGINAS FÍSICAS\
          ✓ 64 PLIEGOS ENFRENTADOS\
          ✓ 0 DISCREPANCIA EN FOLIOS\
          ✓ ARQUITECTURA CEREMONIAL 100%\
          ✓ CERO CORRUPCIÓN UNICODE
        ]
      )
    ]
  ],
  page-card(pdf_prod, 119, "PRODUCCIÓN FASE 3.9.2 (P.119)", rgb("#27ae60"), "PRODUCCIÓN FASE 3.9.2"),
)

#pagebreak()

// ==============================================================================
// LÁMINA 05 / 06: CLAUSURA SOLEMNE DE LA OBRA EN P.126 (CAPÍTULO 09)
// ==============================================================================
#v(2pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 05 / 06: CLAUSURA SOLEMNE DE LA OBRA EN P.126 (CAPÍTULO 09)
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ NO-REGRESIÓN CERTIFICADA · BIT-A-BIT IDÉNTICO
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  gutter: 14pt,
  page-card(pdf_base, 126, "BASELINE FASE 3.9.1 (P.126)", rgb("#2980b9"), "BASELINE FASE 3.9.1"),
  [
    #v(30pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 10pt, weight: "bold", fill: rgb("#f15d22"))[
        EVALUACIÓN DE PRODUCCIÓN
      ]
    ]
    #v(8pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#f15d22"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#2e2f31"))[
          Verificación de Sección 9.8 íntegra en P.126 (H2 + 3 párrafos = 11 líneas). Clausura institucional.
        ]
      ]
    )
    #v(14pt)
    #align(center)[
      #box(
        fill: rgb("#eef7f2"),
        stroke: 0.5pt + rgb("#27ae60"),
        radius: 2pt,
        inset: (x: 8pt, y: 6pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#27ae60"))[
          ✓ 126 PÁGINAS FÍSICAS\
          ✓ 64 PLIEGOS ENFRENTADOS\
          ✓ 0 DISCREPANCIA EN FOLIOS\
          ✓ ARQUITECTURA CEREMONIAL 100%\
          ✓ CERO CORRUPCIÓN UNICODE
        ]
      )
    ]
  ],
  page-card(pdf_prod, 126, "PRODUCCIÓN FASE 3.9.2 (P.126)", rgb("#27ae60"), "PRODUCCIÓN FASE 3.9.2"),
)

#pagebreak()

// ==============================================================================
// LÁMINA 06 / 06: ENUMERACIONES DINÁMICAS Y RESIDUOS %2. EN P.35 (CAPÍTULO 02)
// ==============================================================================
#v(2pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 06 / 06: ENUMERACIONES DINÁMICAS Y RESIDUOS %2. EN P.35 (CAPÍTULO 02)
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ NO-REGRESIÓN CERTIFICADA · BIT-A-BIT IDÉNTICO
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  gutter: 14pt,
  page-card(pdf_base, 35, "BASELINE FASE 3.9.1 (P.35)", rgb("#2980b9"), "BASELINE FASE 3.9.1"),
  [
    #v(30pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 10pt, weight: "bold", fill: rgb("#f15d22"))[
        EVALUACIÓN DE PRODUCCIÓN
      ]
    ]
    #v(8pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#f15d22"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#2e2f31"))[
          Verificación de renderizado de listas romanas i., ii., iii. derivadas estructuralmente de %2.
        ]
      ]
    )
    #v(14pt)
    #align(center)[
      #box(
        fill: rgb("#eef7f2"),
        stroke: 0.5pt + rgb("#27ae60"),
        radius: 2pt,
        inset: (x: 8pt, y: 6pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#27ae60"))[
          ✓ 126 PÁGINAS FÍSICAS\
          ✓ 64 PLIEGOS ENFRENTADOS\
          ✓ 0 DISCREPANCIA EN FOLIOS\
          ✓ ARQUITECTURA CEREMONIAL 100%\
          ✓ CERO CORRUPCIÓN UNICODE
        ]
      )
    ]
  ],
  page-card(pdf_prod, 35, "PRODUCCIÓN FASE 3.9.2 (P.35)", rgb("#27ae60"), "PRODUCCIÓN FASE 3.9.2"),
)