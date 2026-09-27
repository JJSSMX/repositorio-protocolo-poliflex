// ==============================================================================
// TEST INTERIOR SPREAD GRID — FASE 3.6.3: GUÍAS DIAGNÓSTICAS DE RETÍCULA Y NAVEGACIÓN
// ==============================================================================
// Doble página enfrentada (Spread: 792 × 612 pt) con sobreimpresión vectorial
// de guías diagnósticas para evaluar retícula, running header y folios exteriores.
// ==============================================================================

#set page(
  width: 792pt,
  height: 612pt,
  margin: 0pt,
  fill: rgb("#ffffff")
)

// 1. Contenido editorial subyacente
#place(top + left, dx: 0pt, dy: 0pt, image("/dist/TEST_INTERIOR_PAGE_VERSO.pdf", width: 396pt, height: 612pt))
#place(top + left, dx: 396pt, dy: 0pt, image("/dist/TEST_CHAPTER_FIRST_PAGE.pdf", width: 396pt, height: 612pt))

// 2. Bandas de Margen Exterior / Corte (Púrpura translúcido, 22.70 pt)
// Verso: x = 0 a 22.70 pt
#place(top + left, dx: 0pt, dy: 0pt)[
  #rect(width: 22.70pt, height: 612pt, fill: rgb(147, 51, 234, 12%), stroke: (right: 0.5pt + rgb(147, 51, 234)))
]
// Recto: x = 769.30 a 792.00 pt (396 + 373.30 = 769.30 pt)
#place(top + left, dx: 769.30pt, dy: 0pt)[
  #rect(width: 22.70pt, height: 612pt, fill: rgb(147, 51, 234, 12%), stroke: (left: 0.5pt + rgb(147, 51, 234)))
]

// 3. Bandas de Margen Interior / Lomo (Verde translúcido, 58.74 pt)
// Verso: x = 337.26 a 396.00 pt
#place(top + left, dx: 337.26pt, dy: 0pt)[
  #rect(width: 58.74pt, height: 612pt, fill: rgb(22, 163, 74, 10%), stroke: (left: 0.5pt + rgb(22, 163, 74), right: none))
]
// Recto: x = 396.00 a 454.74 pt
#place(top + left, dx: 396.00pt, dy: 0pt)[
  #rect(width: 58.74pt, height: 612pt, fill: rgb(22, 163, 74, 10%), stroke: (right: 0.5pt + rgb(22, 163, 74), left: none))
]

// 4. Cajas principales de contenido (Azul translúcido, ancho 314.56 pt)
// Verso: x = 22.70 a 337.26 pt, y = 120 a 540 pt
#place(top + left, dx: 22.70pt, dy: 120pt)[
  #rect(width: 314.56pt, height: 420pt, fill: rgb(37, 99, 235, 6%), stroke: 0.75pt + rgb(37, 99, 235))
]
// Recto: x = 454.74 a 769.30 pt, y = 225 a 520 pt
#place(top + left, dx: 454.74pt, dy: 225pt)[
  #rect(width: 314.56pt, height: 295pt, fill: rgb(37, 99, 235, 6%), stroke: 0.75pt + rgb(37, 99, 235))
]

// 5. Filetes del lomo (Guías naranja intenso)
// Verso: x = 365.87 pt
#place(top + left, dx: 365.87pt, dy: 0pt)[
  #line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: (paint: rgb("#f97316"), thickness: 1.0pt, dash: "densely-dashed"))
]
// Recto: x = 426.13 pt (396.00 + 30.13)
#place(top + left, dx: 426.13pt, dy: 0pt)[
  #line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: (paint: rgb("#f97316"), thickness: 1.0pt, dash: "densely-dashed"))
]

// 6. EJE CENTRAL DEL SPREAD / LOMO (Rojo continuo destacado, x = 396.00 pt)
#place(top + left, dx: 396.00pt, dy: 0pt)[
  #line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: (paint: rgb("#dc2626"), thickness: 1.5pt, dash: "dashed"))
]

// 7. Bordes exteriores de la página
#place(top + left, dx: 0pt, dy: 0pt)[
  #rect(width: 792pt, height: 612pt, stroke: 1.0pt + rgb("#64748b"), fill: none)
]

// 8. Rótulos y cotas diagnósticas
#let tag(txt, col) = box(
  fill: rgb(col),
  inset: (x: 4pt, y: 2pt),
  radius: 2pt
)[#text(size: 6.5pt, fill: white, weight: "bold", font: "Segoe UI")[#txt]]

// Rótulos de encabezados
#place(top + left, dx: 4pt, dy: 8pt)[#tag("CORTE 22.70pt", "#9333ea")]
#place(top + left, dx: 24pt, dy: 22pt)[#tag("RUNNING HEADER: x = 22.70pt (ALINEADO A CORTE)", "#0891b2")]
#place(top + left, dx: 110pt, dy: 8pt)[#tag("COLUMNA VERSO: 314.56pt", "#2563eb")]
#place(top + left, dx: 340pt, dy: 8pt)[#tag("LOMO 58.74pt", "#16a34a")]
#place(top + center, dy: 8pt)[#tag("EJE CENTRAL / LOMO (396.00pt)", "#dc2626")]
#place(top + left, dx: 400pt, dy: 8pt)[#tag("LOMO 58.74pt", "#16a34a")]
#place(top + left, dx: 540pt, dy: 8pt)[#tag("COLUMNA RECTO: 314.56pt", "#2563eb")]
#place(top + right, dx: -4pt, dy: 8pt)[#tag("CORTE 22.70pt", "#9333ea")]

// Rótulos de folios y filetes
#place(top + left, dx: 24pt, dy: 575pt)[#tag("FOLIO VERSO: x = 22.70pt", "#ea580c")]
#place(top + left, dx: 348pt, dy: 570pt)[#tag("FILETE: 365.87pt", "#ea580c")]
#place(top + left, dx: 410pt, dy: 570pt)[#tag("FILETE: 426.13pt", "#ea580c")]
#place(top + right, dx: -24pt, dy: 575pt)[#tag("FOLIO RECTO: x = 769.30pt", "#ea580c")]

// Cota de simetría en pie de página
#place(bottom + center, dy: -8pt)[
  #box(fill: rgb(15, 23, 42, 85%), inset: (x: 8pt, y: 4pt), radius: 3pt)[
    #text(size: 7pt, fill: white, font: "Segoe UI")[
      *SISTEMA EDITORIAL FASE 3.6.3:* [Verso: Continuación (Limpia + Running Header + Folio Ext)] | [Recto: Apertura (Arcos 50% + Claim + Folio Ext)]
    ]
  ]
]
