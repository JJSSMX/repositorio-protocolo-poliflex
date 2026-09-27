// ==============================================================================
// CONTACT SHEET 3x4: CAPÍTULOS 01–03 FASE 3.8
// Miniaturas a escala de todas las páginas para auditoría visual global
// ==============================================================================

#set page(paper: "a3", flipped: true, margin: (x: 1.5cm, y: 1.5cm))
#set text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#2e2f31"))

#let master_pdf = "/dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8.pdf"

#let thumb(p) = [
  #align(center)[
    #box(stroke: 0.5pt + rgb("#cccccc"), inset: 0pt)[
      #image(master_pdf, page: p, width: 85pt, height: 131.36pt)
    ]
    #v(3pt)
    #let p_str = if p < 10 { "0" + str(p) } else { str(p) }
    #text(size: 7pt, fill: rgb("#6c6b67"))[Pág. #p_str]
  ]
]

// Hoja 1: Páginas 1 a 12
#align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#f15d22"))[PROTOCOLO FAMILIAR · CONTACT SHEET FASE 3.8 (PÁGINAS 01–12)]]
#v(10pt)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 14pt,
  column-gutter: 10pt,
  thumb(1),
  thumb(2),
  thumb(3),
  thumb(4),
  thumb(5),
  thumb(6),
  thumb(7),
  thumb(8),
  thumb(9),
  thumb(10),
  thumb(11),
  thumb(12)
)
#pagebreak()

// Hoja 2: Páginas 13 a 24
#align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#f15d22"))[PROTOCOLO FAMILIAR · CONTACT SHEET FASE 3.8 (PÁGINAS 13–24)]]
#v(10pt)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 14pt,
  column-gutter: 10pt,
  thumb(13),
  thumb(14),
  thumb(15),
  thumb(16),
  thumb(17),
  thumb(18),
  thumb(19),
  thumb(20),
  thumb(21),
  thumb(22),
  thumb(23),
  thumb(24)
)
#pagebreak()

// Hoja 3: Páginas 25 a 36
#align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#f15d22"))[PROTOCOLO FAMILIAR · CONTACT SHEET FASE 3.8 (PÁGINAS 25–36)]]
#v(10pt)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 14pt,
  column-gutter: 10pt,
  thumb(25),
  thumb(26),
  thumb(27),
  thumb(28),
  thumb(29),
  thumb(30),
  thumb(31),
  thumb(32),
  thumb(33),
  thumb(34),
  thumb(35),
  thumb(36)
)
#pagebreak()

// Hoja 4: Páginas 37 a 48
#align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#f15d22"))[PROTOCOLO FAMILIAR · CONTACT SHEET FASE 3.8 (PÁGINAS 37–48)]]
#v(10pt)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 14pt,
  column-gutter: 10pt,
  thumb(37),
  thumb(38),
  thumb(39),
  thumb(40),
  thumb(41),
  thumb(42),
  thumb(43),
  thumb(44),
  thumb(45),
  thumb(46),
  thumb(47),
  thumb(48)
)
#pagebreak()

// Hoja 5: Páginas 49 a 56
#align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#f15d22"))[PROTOCOLO FAMILIAR · CONTACT SHEET FASE 3.8 (PÁGINAS 49–56)]]
#v(10pt)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 14pt,
  column-gutter: 10pt,
  thumb(49),
  thumb(50),
  thumb(51),
  thumb(52),
  thumb(53),
  thumb(54),
  thumb(55),
  thumb(56)
)
#pagebreak()
