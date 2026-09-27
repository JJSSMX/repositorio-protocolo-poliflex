// ==============================================================================
// TEST CAPÍTULOS 01–03 RETÍCULA +6 MM CONTACT SHEET — FASE 3.7.3
// Mosaicos visuales de alta densidad a tamaño 792 × 612 pt (Letter Landscape)
// ==============================================================================

#set page(width: 792pt, height: 612pt, margin: (x: 20pt, top: 16pt, bottom: 14pt), fill: rgb("#f8fafc"))

#let thumb(pdf_path, p_num, label) = [
  #align(center)[
    #box(stroke: 0.5pt + rgb("#cbd5e1"), radius: 2pt, clip: true, fill: rgb("#ffffff"))[
      #image(pdf_path, page: p_num, width: 152pt)
    ]
    #v(2.5pt)
    #text(font: ("Segoe UI", "Arial"), size: 5.8pt, fill: rgb("#334155"), weight: "bold")[#label]
  ]
]

// ==================== HOJA 1 DE 7 (PÁGINAS 01–08) ====================
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  [#text(font: ("Segoe UI", "Arial"), size: 9.5pt, weight: "bold", fill: rgb("#0f172a"))[PROTOCOLO FAMILIAR · HOJA DE CONTACTO DE DIAGNÓSTICO (RETÍCULA +6 MM)]],
  [#text(font: ("Segoe UI", "Arial"), size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[Hoja 1 de 7 · Páginas 01–08]]
)
#v(4pt)
#line(start: (0pt, 0pt), end: (752pt, 0pt), stroke: 0.5pt + rgb("#cbd5e1"))
#v(4pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 6pt,
  column-gutter: 8pt,
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 1, "Pág 01 (Recto) · Página Blanca"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 2, "Pág 02 (Verso) · Página Blanca"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 3, "Pág 03 (Recto) · Portada Cap 01"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 4, "Pág 04 (Verso) · Página Blanca"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 5, "Pág 05 (Recto) · Interior Cap 01"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 6, "Pág 06 (Verso) · Interior Cap 01"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 7, "Pág 07 (Recto) · Interior Cap 01"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 8, "Pág 08 (Verso) · Página Blanca"),
)
#pagebreak()

// ==================== HOJA 2 DE 7 (PÁGINAS 09–16) ====================
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  [#text(font: ("Segoe UI", "Arial"), size: 9.5pt, weight: "bold", fill: rgb("#0f172a"))[PROTOCOLO FAMILIAR · HOJA DE CONTACTO DE DIAGNÓSTICO (RETÍCULA +6 MM)]],
  [#text(font: ("Segoe UI", "Arial"), size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[Hoja 2 de 7 · Páginas 09–16]]
)
#v(4pt)
#line(start: (0pt, 0pt), end: (752pt, 0pt), stroke: 0.5pt + rgb("#cbd5e1"))
#v(4pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 6pt,
  column-gutter: 8pt,
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 9, "Pág 09 (Recto) · Portada Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 10, "Pág 10 (Verso) · Página Blanca"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 11, "Pág 11 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 12, "Pág 12 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 13, "Pág 13 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 14, "Pág 14 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 15, "Pág 15 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 16, "Pág 16 (Verso) · Interior Cap 02"),
)
#pagebreak()

// ==================== HOJA 3 DE 7 (PÁGINAS 17–24) ====================
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  [#text(font: ("Segoe UI", "Arial"), size: 9.5pt, weight: "bold", fill: rgb("#0f172a"))[PROTOCOLO FAMILIAR · HOJA DE CONTACTO DE DIAGNÓSTICO (RETÍCULA +6 MM)]],
  [#text(font: ("Segoe UI", "Arial"), size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[Hoja 3 de 7 · Páginas 17–24]]
)
#v(4pt)
#line(start: (0pt, 0pt), end: (752pt, 0pt), stroke: 0.5pt + rgb("#cbd5e1"))
#v(4pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 6pt,
  column-gutter: 8pt,
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 17, "Pág 17 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 18, "Pág 18 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 19, "Pág 19 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 20, "Pág 20 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 21, "Pág 21 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 22, "Pág 22 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 23, "Pág 23 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 24, "Pág 24 (Verso) · Interior Cap 02"),
)
#pagebreak()

// ==================== HOJA 4 DE 7 (PÁGINAS 25–32) ====================
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  [#text(font: ("Segoe UI", "Arial"), size: 9.5pt, weight: "bold", fill: rgb("#0f172a"))[PROTOCOLO FAMILIAR · HOJA DE CONTACTO DE DIAGNÓSTICO (RETÍCULA +6 MM)]],
  [#text(font: ("Segoe UI", "Arial"), size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[Hoja 4 de 7 · Páginas 25–32]]
)
#v(4pt)
#line(start: (0pt, 0pt), end: (752pt, 0pt), stroke: 0.5pt + rgb("#cbd5e1"))
#v(4pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 6pt,
  column-gutter: 8pt,
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 25, "Pág 25 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 26, "Pág 26 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 27, "Pág 27 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 28, "Pág 28 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 29, "Pág 29 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 30, "Pág 30 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 31, "Pág 31 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 32, "Pág 32 (Verso) · Interior Cap 02"),
)
#pagebreak()

// ==================== HOJA 5 DE 7 (PÁGINAS 33–40) ====================
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  [#text(font: ("Segoe UI", "Arial"), size: 9.5pt, weight: "bold", fill: rgb("#0f172a"))[PROTOCOLO FAMILIAR · HOJA DE CONTACTO DE DIAGNÓSTICO (RETÍCULA +6 MM)]],
  [#text(font: ("Segoe UI", "Arial"), size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[Hoja 5 de 7 · Páginas 33–40]]
)
#v(4pt)
#line(start: (0pt, 0pt), end: (752pt, 0pt), stroke: 0.5pt + rgb("#cbd5e1"))
#v(4pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 6pt,
  column-gutter: 8pt,
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 33, "Pág 33 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 34, "Pág 34 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 35, "Pág 35 (Recto) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 36, "Pág 36 (Verso) · Interior Cap 02"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 37, "Pág 37 (Recto) · Página Blanca"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 38, "Pág 38 (Verso) · Página Blanca"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 39, "Pág 39 (Recto) · Portada Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 40, "Pág 40 (Verso) · Página Blanca"),
)
#pagebreak()

// ==================== HOJA 6 DE 7 (PÁGINAS 41–48) ====================
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  [#text(font: ("Segoe UI", "Arial"), size: 9.5pt, weight: "bold", fill: rgb("#0f172a"))[PROTOCOLO FAMILIAR · HOJA DE CONTACTO DE DIAGNÓSTICO (RETÍCULA +6 MM)]],
  [#text(font: ("Segoe UI", "Arial"), size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[Hoja 6 de 7 · Páginas 41–48]]
)
#v(4pt)
#line(start: (0pt, 0pt), end: (752pt, 0pt), stroke: 0.5pt + rgb("#cbd5e1"))
#v(4pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 6pt,
  column-gutter: 8pt,
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 41, "Pág 41 (Recto) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 42, "Pág 42 (Verso) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 43, "Pág 43 (Recto) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 44, "Pág 44 (Verso) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 45, "Pág 45 (Recto) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 46, "Pág 46 (Verso) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 47, "Pág 47 (Recto) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 48, "Pág 48 (Verso) · Interior Cap 03"),
)
#pagebreak()

// ==================== HOJA 7 DE 7 (PÁGINAS 49–56) ====================
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  [#text(font: ("Segoe UI", "Arial"), size: 9.5pt, weight: "bold", fill: rgb("#0f172a"))[PROTOCOLO FAMILIAR · HOJA DE CONTACTO DE DIAGNÓSTICO (RETÍCULA +6 MM)]],
  [#text(font: ("Segoe UI", "Arial"), size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[Hoja 7 de 7 · Páginas 49–56]]
)
#v(4pt)
#line(start: (0pt, 0pt), end: (752pt, 0pt), stroke: 0.5pt + rgb("#cbd5e1"))
#v(4pt)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  row-gutter: 6pt,
  column-gutter: 8pt,
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 49, "Pág 49 (Recto) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 50, "Pág 50 (Verso) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 51, "Pág 51 (Recto) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 52, "Pág 52 (Verso) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 53, "Pág 53 (Recto) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 54, "Pág 54 (Verso) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 55, "Pág 55 (Recto) · Interior Cap 03"),
  thumb("/dist/TEST_CAPITULOS_01_03_RETICULA_6MM.pdf", 56, "Pág 56 (Verso) · Interior Cap 03"),
)