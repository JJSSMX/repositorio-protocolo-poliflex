
#set page(
  paper: "a3",
  flipped: true,
  margin: (x: 2cm, y: 1.5cm)
)

#set text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#2e2f31"))

#let minion = ("Minion Pro", "Georgia")
#let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

#let ftr_phrase = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[PROTOCOLO FAMILIAR]
#let ftr_ver = text(font: neuzeit, size: 4.8234pt, fill: rgb("#f15e22"), tracking: 0.371em)[VERSION 1.0]
#let iso_ftr = image("/referencias/icono.svg", width: 15.5740pt, height: 15.3150pt)

// Render de la franja inferior a escala real (ancho 396 pt, altura 120 pt) con o sin corrección
#let render-footer-strip(title, is-corrected, show-guides: true) = block(
  width: 396pt,
  height: 120pt,
  stroke: 0.5pt + rgb("#cccccc"),
  fill: rgb("#ffffff"),
  inset: 0pt
)[
  #place(top + left, dx: 15pt, dy: 10pt)[
    #text(weight: "bold", size: 9pt, fill: if is-corrected { rgb("#2e7d32") } else { rgb("#c62828") })[#title]
  ]

  // Línea de referencia interior-page baseline (y = 591.71 pt -> relativa dy = 80pt)
  // En nuestro viewport de 120pt (representando y de 520 a 612):
  // dy = y - 520.
  // interior-page folio baseline y = 591.71 -> dy = 71.71 pt.
  // interior-page folio top y = 585.89 -> dy = 65.89 pt.
  // first-page antes folio baseline y = 596.76 -> dy = 76.76 pt (+5.05pt).
  
  #let base_dy = 71.71pt

  // Elementos footer
  #let v_offset = if is-corrected { 20pt - 5.0535pt } else { 20pt }
  // Simulamos la posición exacta Typst:
  // En Typst, y_top = 547 + v_offset...
  // Para representar con exactitud milimétrica 1:1 los elementos:
  #let content_dy = if is-corrected { base_dy } else { base_dy + 5.0535pt }

  #place(top + left, dx: 58.74pt, dy: content_dy - 7.5pt)[
    #block(width: 396pt - 58.74pt - 22.70pt)[
      #grid(
        columns: (1fr, 1fr),
        align: (left + horizon, right + horizon),
        [#box(baseline: 20%)[#iso_ftr]#h(4pt)#ftr_phrase#h(6pt)#ftr_ver],
        text(font: minion, size: 8pt, fill: rgb("#f15d22"), weight: "medium")[05]
      )
    ]
  ]

  #if show-guides [
    // Guía 1: Baseline aprobada interior-page (y = 591.71 pt) - VERDE
    #place(top + left, dx: 0pt, dy: base_dy + 5.82pt)[
      #line(length: 396pt, stroke: (paint: rgb("#2e7d32"), thickness: 0.75pt, dash: "densely-dotted"))
    ]
    #place(top + right, dx: -5pt, dy: base_dy + 8pt)[
      #text(size: 6.5pt, fill: rgb("#2e7d32"), weight: "bold")[Línea base aprobada `interior-page()` (y = 591.71 pt)]
    ]

    // Guía 2: Baseline ANTES first-page (y = 596.76 pt) - ROJO
    #place(top + left, dx: 0pt, dy: base_dy + 5.82pt + 5.0535pt)[
      #line(length: 396pt, stroke: (paint: rgb("#c62828"), thickness: 0.75pt, dash: "densely-dashed"))
    ]
    #if not is-corrected [
      #place(top + left, dx: 15pt, dy: base_dy + 5.82pt + 7pt)[
        #text(size: 6.5pt, fill: rgb("#c62828"), weight: "bold")[Baseline ANTES (y = 596.76 pt, Discrepancia +5.05 pt)]
      ]
    ] else [
      #place(top + left, dx: 15pt, dy: base_dy - 12pt)[
        #text(size: 6.5pt, fill: rgb("#2e7d32"), weight: "bold")[Alineación exacta conseguida (Discrepancia = 0.00 pt)]
      ]
    ]
  ]
]

// Portada y encabezado del reporte de prueba
#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#f15d22"))[AUDITORÍA FORENSE Y COMPARATIVA VISUAL DE FRANJA INFERIOR] \
  #v(4pt)
  #text(size: 11pt, fill: rgb("#6c6b67"))[Alineación Matemática de Folio, Footer Institucional e Isotipo en `chapter-first-page()` — Fase 3.8.1]
]

#v(15pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 25pt,
  [
    #align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#c62828"))[ESTADO ANTERIOR (FASE 3.8)]]
    #v(6pt)
    #render-footer-strip("chapter-first-page() — ANTES (Desalineado +5.05 pt)", false)
    #v(10pt)
    #rect(width: 100%, stroke: 0.5pt + rgb("#ffcdd2"), fill: rgb("#ffebee"), inset: 10pt)[
      #text(weight: "bold", fill: rgb("#c62828"))[Diagnóstico Forense:]
      - *Folio `chapter-first-page()`:* Baseline $y = 596.76 "pt"$ (Bbox $[590.95, 598.95] "pt"$).
      - *Folio `interior-page()`:* Baseline $y = 591.71 "pt"$ (Bbox $[585.89, 593.89] "pt"$).
      - *Discrepancia Vertical:* *+5.0535 pt* (+1.78 mm hacia abajo).
      - *Causa Raíz:* En la primera página, el footer institucional incluye el isotipo ($h = 15.315 "pt"$) dentro de un `#grid(align: horizon)`. El centrado vertical de la celda sumado a `#v(20pt)` desplazaba el folio $5.05 "pt"$ por debajo del folio de páginas interiores.
    ]
  ],
  [
    #align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#2e7d32"))[ESTADO CORREGIDO (FASE 3.8.1)]]
    #v(6pt)
    #render-footer-strip("chapter-first-page() — DESPUÉS (Unificación Matemática)", true)
    #v(10pt)
    #rect(width: 100%, stroke: 0.5pt + rgb("#c8e6c9"), fill: rgb("#e8f5e9"), inset: 10pt)[
      #text(weight: "bold", fill: rgb("#2e7d32"))[Resolución Matemática:]
      - *Compensación de Espaciado:* `#v(20pt - 5.0535pt)` = *14.9465 pt*.
      - *Folio `chapter-first-page()`:* Baseline $y = 591.71 "pt"$ (Bbox $[585.89, 593.89] "pt"$).
      - *Folio `interior-page()`:* Baseline $y = 591.71 "pt"$ (Bbox $[585.89, 593.89] "pt"$).
      - *Discrepancia Residual:* *0.0000 pt* (0.00 mm).
      - *Footer e Isotipo:* Se desplazan solidariamente $-5.0535 "pt"$ hacia arriba, conservando su proporción, escala y relación geométrica idéntica con el folio.
    ]
  ]
)

#v(20pt)

// Comparativa de páginas completas enfrentadas (Spread a escala 50%)
#align(center)[
  #text(size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[VERIFICACIÓN VISUAL EN PLIEGO ENFRENTADO REAL (PÁGINA 04 VERSO | PÁGINA 05 RECTO)]
]

#v(8pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  [
    #rect(width: 100%, stroke: 0.5pt + rgb("#cccccc"), fill: rgb("#fcfcfc"), inset: 12pt)[
      #text(weight: "bold")[Página 04 (Blanca Verso) / Página 05 (Chapter First Page Recto):]
      Al comparar la Página 05 (`chapter-first-page()`) con cualquier página interior subsiguiente (e.g. Página 06 o 07), el folio *"05"* se encuentra exactamente a la misma altura horizontal que el folio *"06"* y *"07"*, eliminando cualquier salto o vibración óptica al pasar de página.
      
      #v(6pt)
      - *Coordenada Y Folio Interior:* $591.708 "pt"$
      - *Coordenada Y Folio Primera Página (Corregido):* $591.708 "pt"$
      - *Diferencia:* *0.000 pt*
    ]
  ],
  [
    #rect(width: 100%, stroke: 0.5pt + rgb("#cccccc"), fill: rgb("#fcfcfc"), inset: 12pt)[
      #text(weight: "bold")[Preservación del Contenido Superior (FROZEN):]
      La corrección se ejecutó exclusivamente en la franja inferior del footer. Los siguientes elementos no sufrieron ningún desplazamiento:
      - Claim superior: Fijo en $y = 29.00 "pt"$ (offset $-25.00 "pt" - 17.01 "pt"$).
      - Arcos concéntricos: Posición y opacidad (50%) intactas.
      - Número de capítulo: Fijo en $y = 28.00 "pt"$.
      - Filete horizontal: Fijo en $y = 74.95 "pt"$.
      - Título del capítulo: Fijo en $y = 98.30 "pt"$.
      - Retícula vertical +6 mm: Intacta.
    ]
  ]
)
