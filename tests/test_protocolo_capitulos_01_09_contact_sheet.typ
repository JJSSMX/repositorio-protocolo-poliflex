// ============================================================================== 
// CONTACT SHEET — PROTOCOLO CAPÍTULOS 01–09 (ORGANIZADO POR SPREADS VERSO | RECTO)
// ============================================================================== 

#set page(
  paper: "a3",
  flipped: true,
  margin: (x: 1.2cm, y: 1.0cm),
  header: [
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, weight: "bold", fill: rgb("#f15d22"))[
        PROTOCOLO FAMILIAR POLIFLEX · CONTACT SHEET DE PLIEGOS (VERSO | RECTO)
      ]
      #h(12pt)
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.0pt, fill: rgb("#6c6b67"))[
        (Inspección de Ritmo, Densidad, Simetría y Aperturas · 64 Pliegos / 126 Páginas)
      ]
    ]
  ],
  footer: context [
    #let p = counter(page).get().first()
    #align(center)[#text(size: 7pt, fill: rgb("#6c6b67"))[Hoja #p]]
  ]
)

#let spreads_pdf = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf"

#let spread-card(s_num, v_desc, r_desc) = [
  #align(center)[
    #box(
      stroke: 0.5pt + rgb("#cccccc"),
      radius: 1pt,
      fill: rgb("#ffffff"),
      clip: true,
      width: 172pt,
      height: 132.8pt,
      image(spreads_pdf, page: s_num, width: 172pt, height: 132.8pt)
    )
    #v(2.5pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6pt, weight: "bold", fill: rgb("#f15d22"))[
      Pliego #if s_num < 10 { "0" + str(s_num) } else { str(s_num) }
    ]
    #h(4pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 5.5pt, fill: rgb("#2e2f31"))[
      [#v_desc | #r_desc]
    ]
  ]
]

// HOJA 01: Pliegos 01 a 08
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  row-gutter: 14pt,
  column-gutter: 10pt,
  spread-card(1, "VACÍO", "P.01 Cortesía"),
  spread-card(2, "P.02 Blanca Op 01", "P.03 Opening 01"),
  spread-card(3, "P.04 Blanca FP 01", "P.05 First Page 01"),
  spread-card(4, "P.06 Cap 01", "P.07 Cap 01"),
  spread-card(5, "P.08 Cap 01", "P.09 Blanca Transición"),
  spread-card(6, "P.10 Blanca Op 02", "P.11 Opening 02"),
  spread-card(7, "P.12 Blanca FP 02", "P.13 First Page 02"),
  spread-card(8, "P.14 Cap 02", "P.15 Cap 02"),
)
#pagebreak()

// HOJA 02: Pliegos 09 a 16
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  row-gutter: 14pt,
  column-gutter: 10pt,
  spread-card(9, "P.16 Cap 02", "P.17 Cap 02"),
  spread-card(10, "P.18 Cap 02", "P.19 Cap 02"),
  spread-card(11, "P.20 Cap 02", "P.21 Cap 02"),
  spread-card(12, "P.22 Cap 02", "P.23 Cap 02"),
  spread-card(13, "P.24 Cap 02", "P.25 Cap 02"),
  spread-card(14, "P.26 Cap 02", "P.27 Cap 02"),
  spread-card(15, "P.28 Cap 02", "P.29 Cap 02"),
  spread-card(16, "P.30 Cap 02", "P.31 Cap 02"),
)
#pagebreak()

// HOJA 03: Pliegos 17 a 24
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  row-gutter: 14pt,
  column-gutter: 10pt,
  spread-card(17, "P.32 Cap 02", "P.33 Cap 02"),
  spread-card(18, "P.34 Cap 02", "P.35 Cap 02"),
  spread-card(19, "P.36 Cap 02", "P.37 Cap 02"),
  spread-card(20, "P.38 Cap 02", "P.39 Cap 02"),
  spread-card(21, "P.40 Cap 02", "P.41 Blanca Transición"),
  spread-card(22, "P.42 Blanca Op 03", "P.43 Opening 03"),
  spread-card(23, "P.44 Blanca FP 03", "P.45 First Page 03"),
  spread-card(24, "P.46 Cap 03", "P.47 Cap 03"),
)
#pagebreak()

// HOJA 04: Pliegos 25 a 32
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  row-gutter: 14pt,
  column-gutter: 10pt,
  spread-card(25, "P.48 Cap 03", "P.49 Cap 03"),
  spread-card(26, "P.50 Cap 03", "P.51 Cap 03"),
  spread-card(27, "P.52 Cap 03", "P.53 Cap 03"),
  spread-card(28, "P.54 Cap 03", "P.55 Cap 03"),
  spread-card(29, "P.56 Cap 03", "P.57 Cap 03"),
  spread-card(30, "P.58 Cap 03", "P.59 Cap 03"),
  spread-card(31, "P.60 Cap 03", "P.61 Cap 03"),
  spread-card(32, "P.62 Blanca Op 04", "P.63 Opening 04"),
)
#pagebreak()

// HOJA 05: Pliegos 33 a 40
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  row-gutter: 14pt,
  column-gutter: 10pt,
  spread-card(33, "P.64 Blanca FP 04", "P.65 First Page 04"),
  spread-card(34, "P.66 Cap 04", "P.67 Cap 04"),
  spread-card(35, "P.68 Cap 04", "P.69 Cap 04"),
  spread-card(36, "P.70 Cap 04", "P.71 Cap 04"),
  spread-card(37, "P.72 Cap 04", "P.73 Cap 04"),
  spread-card(38, "P.74 Cap 04", "P.75 Cap 04"),
  spread-card(39, "P.76 Cap 04", "P.77 Cap 04"),
  spread-card(40, "P.78 Cap 04", "P.79 Cap 04"),
)
#pagebreak()

// HOJA 06: Pliegos 41 a 48
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  row-gutter: 14pt,
  column-gutter: 10pt,
  spread-card(41, "P.80 Cap 04", "P.81 Cap 04"),
  spread-card(42, "P.82 Cap 04", "P.83 Cap 04"),
  spread-card(43, "P.84 Cap 04", "P.85 Cap 04"),
  spread-card(44, "P.86 Cap 04", "P.87 Cap 04"),
  spread-card(45, "P.88 Blanca Op 05", "P.89 Opening 05"),
  spread-card(46, "P.90 Blanca FP 05", "P.91 First Page 05"),
  spread-card(47, "P.92 Cap 05", "P.93 Cap 05"),
  spread-card(48, "P.94 Cap 05", "P.95 Blanca Transición"),
)
#pagebreak()

// HOJA 07: Pliegos 49 a 56
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  row-gutter: 14pt,
  column-gutter: 10pt,
  spread-card(49, "P.96 Blanca Op 06", "P.97 Opening 06"),
  spread-card(50, "P.98 Blanca FP 06", "P.99 First Page 06"),
  spread-card(51, "P.100 Cap 06", "P.101 Cap 06"),
  spread-card(52, "P.102 Cap 06", "P.103 Blanca Transición"),
  spread-card(53, "P.104 Blanca Op 07", "P.105 Opening 07"),
  spread-card(54, "P.106 Blanca FP 07", "P.107 First Page 07"),
  spread-card(55, "P.108 Cap 07", "P.109 Cap 07"),
  spread-card(56, "P.110 Cap 07", "P.111 Cap 07"),
)
#pagebreak()

// HOJA 08: Pliegos 57 a 64
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  row-gutter: 14pt,
  column-gutter: 10pt,
  spread-card(57, "P.112 Blanca Op 08", "P.113 Opening 08"),
  spread-card(58, "P.114 Blanca FP 08", "P.115 First Page 08"),
  spread-card(59, "P.116 Cap 08", "P.117 Cap 08"),
  spread-card(60, "P.118 Cap 08", "P.119 Cap 08"),
  spread-card(61, "P.120 Blanca Op 09", "P.121 Opening 09"),
  spread-card(62, "P.122 Blanca FP 09", "P.123 First Page 09"),
  spread-card(63, "P.124 Cap 09", "P.125 Cap 09"),
  spread-card(64, "P.126 Cap 09", "VACÍO"),
)