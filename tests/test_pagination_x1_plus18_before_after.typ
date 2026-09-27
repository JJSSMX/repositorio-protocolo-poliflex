// ==============================================================================
// COMPARATIVA FORENSE DE SIMULACIÓN — FASE 3.9A
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// Hipótesis: Desfase Global Mediante Respiración en x.1 (+18 pt)
// Formato: A3 Apaisado (1190.55 × 841.89 pt) · Escala Real 1:1 (396 × 612 pt)
// ==============================================================================

#set page(
  paper: "a3",
  flipped: true,
  margin: (x: 2.2cm, top: 1.8cm, bottom: 1.6cm),
  header: context [
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, weight: "bold", fill: rgb("#d35400"))[
          PROTOCOLO FAMILIAR POLIFLEX · SIMULACIÓN DIAGNÓSTICA FASE 3.9A
        ]
        #h(8pt)
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[
          | EVALUACIÓN DE HIPÓTESIS: DESFASE VERTICAL EN x.1 (+18 pt) A ESCALA 1:1
        ]
      ],
      [
        #let p = counter(page).get().first()
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "medium", fill: rgb("#2e2f31"))[
          Lámina #p de 6
        ]
      ]
    )
    #v(4pt)
    #line(length: 100%, stroke: 0.5pt + rgb("#e2e2e2"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#e2e2e2"))
    #v(4pt)
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[
          Fase 3.9A (Diagnóstica) · Retícula +6 mm · Fuentes Canónicas Read-Only · Cero Modificación de Producción
        ]
      ],
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[
          Páginas renderizadas a escala real 100% (396 × 612 pt) · Cero distorsión geométrica
        ]
      ]
    )
  ]
)

#let orig_pdf = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09.pdf"
#let sim_pdf = "/dist/TEST_PAGINATION_X1_PLUS18.pdf"

#let page-card(pdf-path, p-num, badge-text, badge-fill) = [
  #block(width: 396pt)[
    #align(center)[
      #box(
        fill: badge-fill,
        radius: 2pt,
        inset: (x: 8pt, y: 4pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold", fill: white)[#badge-text]
      )
    ]
    #v(6pt)
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

#let data-table(items) = [
  #table(
    columns: (auto, 1fr),
    stroke: (x, y) => if y == 0 { (bottom: 0.5pt + rgb("#dcdcdc")) } else { (bottom: 0.3pt + rgb("#eeeeee")) },
    fill: (col, row) => if calc.even(row) { rgb("#fbfbfb") } else { white },
    inset: (x: 6pt, y: 4pt),
    ..items.map(it => (
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#444444"))[#it.at(0)],
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[#it.at(1)]
    )).flatten()
  )
]

// ==============================================================================
// LÁMINA 01 / 06: DESFASE VERTICAL EN CHAPTER-FIRST-PAGE — CAPÍTULO 01 (PÁGINA 05)
// ==============================================================================
#v(2pt)
#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[
  LÁMINA 01 / 06: DESFASE VERTICAL EN CHAPTER-FIRST-PAGE — CAPÍTULO 01 (PÁGINA 05)
]
#v(10pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  align: (top + left, top + center, top + right),
  gutter: 14pt,
  page-card(orig_pdf, 5, "ESTADO A: RESPIRACIÓN BASE NOMINAL (y = 248.05 pt)", rgb("#2980b9")),
  [
    #v(15pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 9.5pt, weight: "bold", fill: rgb("#d35400"))[
        DIAGNÓSTICO: DESFASE EFECTIVO PERO ABSORBIDO
      ]
    ]
    #v(6pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#d35400"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.4pt, fill: rgb("#2e2f31"))[
          Se constata que el desplazamiento vertical de +18 pt se aplica matemáticamente antes del encabezado 1.1 (Y0 pasa de 248.05 pt a 266.05 pt). No obstante, debido a la holgura natural de la caja tipográfica en P.05, el contenido no desborda hacia la página siguiente y el desfase no se transmite al flujo posterior.
        ]
      ]
    )
    #v(8pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#2980b9"))[ESTADO A (Base Nominal):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 05 · Recto (impar) · Chapter First Page"), ("Posición Y0 de 1.1", "y0 = 248.05 pt (coordenada nominal base)"), ("Líneas de cuerpo", "18 líneas de texto útil en página"), ("Línea final de página", "«...naturaleza corporativa, patrimonial y familiar...»"), ("Comportamiento", "Ritmo vertical estándar sin desplazamiento previo")))
    #v(6pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#d35400"))[ESTADO C (Simulación x.1 +18 pt):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 05 · Recto (impar) — Paridad y folios idénticos"), ("Posición Y0 de 1.1", "y0 = 266.05 pt (+18.00 pt de respiración adicional)"), ("Líneas de cuerpo", "18 líneas de texto útil (idéntico número de líneas)"), ("Línea final de página", "«...naturaleza corporativa, patrimonial y familiar...»"), ("Hallazgo diagnóstico", "El espacio +18 pt fue absorbido por la holgura inferior; no expulsó ninguna línea")))
    #v(10pt)
    #align(center)[
      #box(
        fill: rgb("#fef9e7"),
        stroke: 0.5pt + rgb("#f39c12"),
        radius: 2pt,
        inset: (x: 8pt, y: 5pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#7f4f00"))[
          • *Desfase vertical en x.1:* +18.00 pt exactos\
• *Líneas desplazadas a P.06:* 0 líneas (absorbido por holgura)\
• *Impacto en páginas siguientes:* NULO (flujo idéntico en P.06 a P.08)
        ]
      )
    ]
  ],
  page-card(sim_pdf, 5, "ESTADO C: RESPIRACIÓN +18 pt EN x.1 (y = 266.05 pt)", rgb("#d35400")),
)

#pagebreak()

// ==============================================================================
// LÁMINA 02 / 06: IMPACTO EN LÍNEA VIUDA AISLADA — CAPÍTULO 04 (PÁGINA 66)
// ==============================================================================
#v(2pt)
#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[
  LÁMINA 02 / 06: IMPACTO EN LÍNEA VIUDA AISLADA — CAPÍTULO 04 (PÁGINA 66)
]
#v(10pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  align: (top + left, top + center, top + right),
  gutter: 14pt,
  page-card(orig_pdf, 66, "ESTADO A: VIUDA AISLADA (1 LÍNEA ANTES DE H3 4.1.2)", rgb("#c0392b")),
  [
    #v(15pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 9.5pt, weight: "bold", fill: rgb("#d35400"))[
        EVALUACIÓN: HIPÓTESIS REFUTADA EN P.66
      ]
    ]
    #v(6pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#d35400"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.4pt, fill: rgb("#2e2f31"))[
          En el Capítulo 04, el encabezado 4.1 se desplazó +18 pt (Y0 pasó de 224.04 pt a 242.04 pt en P.65). Sin embargo, P.65 tenía holgura vertical suficiente para albergar exactamente las mismas 20 líneas. En consecuencia, el párrafo 4.1.1 se cortó en el mismo carácter y expulsó la misma línea viuda a P.66.
        ]
      ]
    )
    #v(8pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#2980b9"))[ESTADO A (Base Nominal):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 66 · Verso (par)"), ("Contenido al tope", "1 sola línea de remanente de Subsección 4.1.1 (y=70.4 pt)"), ("Texto de la viuda", "«inmediatos a favor de los sucesores, condicionando cualquier...»"), ("Contexto siguiente", "Encabezado H3 4.1.2 inmediatamente debajo"), ("Causa en Estado A", "P.65 alojó 6 líneas de 4.1.1 y expulsó 1 línea por fin de caja")))
    #v(6pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#d35400"))[ESTADO C (Simulación x.1 +18 pt):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 66 · Verso (par)"), ("Contenido al tope", "1 sola línea de remanente de Subsección 4.1.1 (y=70.4 pt)"), ("Texto de la viuda", "«inmediatos a favor de los sucesores, condicionando cualquier...»"), ("Contexto siguiente", "Encabezado H3 4.1.2 inmediatamente debajo"), ("Resultado en Estado C", "IDÉNTICO: El desfase de +18 pt en P.65 no alteró el quiebre de 4.1.1")))
    #v(10pt)
    #align(center)[
      #box(
        fill: rgb("#fef9e7"),
        stroke: 0.5pt + rgb("#f39c12"),
        radius: 2pt,
        inset: (x: 8pt, y: 5pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#7f4f00"))[
          • *Estado de la viuda:* PERSISTE (1 línea al tope)\
• *Comparación vs Fase 3.9:* Fase 3.9 eliminó la viuda con párrafo atómico\
• *Efectividad de +18 pt:* 0% de resolución
        ]
      )
    ]
  ],
  page-card(sim_pdf, 66, "ESTADO C (+18 pt): VIUDA PERSISTE IDÉNTICA (FRACASO DE HIPÓTESIS)", rgb("#c0392b")),
)

#pagebreak()

// ==============================================================================
// LÁMINA 03 / 06: IMPACTO EN LÍNEA VIUDA EN FLUJO — CAPÍTULO 04 (PÁGINA 68)
// ==============================================================================
#v(2pt)
#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[
  LÁMINA 03 / 06: IMPACTO EN LÍNEA VIUDA EN FLUJO — CAPÍTULO 04 (PÁGINA 68)
]
#v(10pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  align: (top + left, top + center, top + right),
  gutter: 14pt,
  page-card(orig_pdf, 68, "ESTADO A: REMANENTE DÉBIL DE 1 LÍNEA ANTES DE H3 4.2.2", rgb("#c0392b")),
  [
    #v(15pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 9.5pt, weight: "bold", fill: rgb("#d35400"))[
        EVALUACIÓN: HIPÓTESIS REFUTADA EN P.68
      ]
    ]
    #v(6pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#d35400"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.4pt, fill: rgb("#2e2f31"))[
          Al no haberse corregido el quiebre de P.65-P.66, el flujo tipográfico en P.67 y P.68 permanece inalterado. La línea viuda de la Subsección 4.2.1 se mantiene en la cabeza de P.68 precediendo al encabezado 4.2.2, confirmando que la respiración en x.1 no resuelve el problema.
        ]
      ]
    )
    #v(8pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#2980b9"))[ESTADO A (Base Nominal):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 68 · Verso (par)"), ("Contenido al tope", "1 sola línea de remanente de Subsección 4.2.1"), ("Texto de la viuda", "«al régimen de separación de derechos, al congelamiento accio...»"), ("Contexto siguiente", "Encabezado H3 4.2.2 en línea 2 de página"), ("Causa en Estado A", "Quiebre defectuoso 4+1 acumulado desde P.67")))
    #v(6pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#d35400"))[ESTADO C (Simulación x.1 +18 pt):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 68 · Verso (par)"), ("Contenido al tope", "1 sola línea de remanente de Subsección 4.2.1"), ("Texto de la viuda", "«al régimen de separación de derechos, al congelamiento accio...»"), ("Contexto siguiente", "Encabezado H3 4.2.2 en línea 2 de página"), ("Resultado en Estado C", "IDÉNTICO: La viuda en P.68 reaparece exactamente sin variación")))
    #v(10pt)
    #align(center)[
      #box(
        fill: rgb("#fef9e7"),
        stroke: 0.5pt + rgb("#f39c12"),
        radius: 2pt,
        inset: (x: 8pt, y: 5pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#7f4f00"))[
          • *Estado de la viuda:* PERSISTE (1 línea al tope)\
• *Comparación vs Fase 3.9:* Fase 3.9 logró quiebre balanceado 2+2\
• *Efectividad de +18 pt:* 0% de resolución
        ]
      )
    ]
  ],
  page-card(sim_pdf, 68, "ESTADO C (+18 pt): VIUDA PERSISTE IDÉNTICA (FRACASO DE HIPÓTESIS)", rgb("#c0392b")),
)

#pagebreak()

// ==============================================================================
// LÁMINA 04 / 06: IMPACTO EN CIERRE DE CAPÍTULO — CAPÍTULO 04 (PÁGINA 87)
// ==============================================================================
#v(2pt)
#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[
  LÁMINA 04 / 06: IMPACTO EN CIERRE DE CAPÍTULO — CAPÍTULO 04 (PÁGINA 87)
]
#v(10pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  align: (top + left, top + center, top + right),
  gutter: 14pt,
  page-card(orig_pdf, 87, "ESTADO A: RESIDUO DÉBIL DE 2 LÍNEAS (4.2% DE CAJA)", rgb("#c0392b")),
  [
    #v(15pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 9.5pt, weight: "bold", fill: rgb("#d35400"))[
        EVALUACIÓN: RESIDUO PERSISTE EN CAPÍTULO 04
      ]
    ]
    #v(6pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#d35400"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.4pt, fill: rgb("#2e2f31"))[
          El desfase de +18 pt en 4.1 (P.65) se disipó completamente a lo largo de las 22 páginas intermedias del capítulo. Al llegar a P.86 y P.87, la distribución de líneas es exactamente la misma que en el Estado A, dejando a P.87 con solo 2 líneas descontextualizadas.
        ]
      ]
    )
    #v(8pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#2980b9"))[ESTADO A (Base Nominal):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 87 · Recto (impar) · Cierre de Cap 04"), ("Contenido útil", "Únicamente 2 líneas terminales (y=70.4 a 88.4 pt)"), ("Texto terminal", "«momento, el cuadro accionario se considerará regularizado y...»"), ("Ocupación vertical", "4.2% de caja útil (25.9 pt de texto)"), ("Página anterior (P.86)", "P.86 alojó 3 líneas de 4.9.4 y expulsó 2 líneas")))
    #v(6pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#d35400"))[ESTADO C (Simulación x.1 +18 pt):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 87 · Recto (impar) · Cierre de Cap 04"), ("Contenido útil", "Únicamente 2 líneas terminales (y=70.4 a 88.4 pt)"), ("Texto terminal", "«momento, el cuadro accionario se considerará regularizado y...»"), ("Ocupación vertical", "4.2% de caja útil (25.9 pt de texto)"), ("Resultado en Estado C", "CERO MEJORA: El remanente débil de 2 líneas se mantiene idéntico")))
    #v(10pt)
    #align(center)[
      #box(
        fill: rgb("#fef9e7"),
        stroke: 0.5pt + rgb("#f39c12"),
        radius: 2pt,
        inset: (x: 8pt, y: 5pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#7f4f00"))[
          • *Líneas en P.87:* 2 líneas (idéntico a Estado A)\
• *Comparación vs Fase 3.9:* Fase 3.9 pobló P.87 con 5 líneas completas (24% caja)\
• *Efectividad de +18 pt:* 0% de resolución
        ]
      )
    ]
  ],
  page-card(sim_pdf, 87, "ESTADO C (+18 pt): RESIDUO DE 2 LÍNEAS PERSISTE (SIN MEJORA)", rgb("#c0392b")),
)

#pagebreak()

// ==============================================================================
// LÁMINA 05 / 06: IMPACTO EN CIERRE DE CAPÍTULO — CAPÍTULO 08 (PÁGINA 119)
// ==============================================================================
#v(2pt)
#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[
  LÁMINA 05 / 06: IMPACTO EN CIERRE DE CAPÍTULO — CAPÍTULO 08 (PÁGINA 119)
]
#v(10pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  align: (top + left, top + center, top + right),
  gutter: 14pt,
  page-card(orig_pdf, 119, "ESTADO A: RESIDUO DÉBIL DE 1 LÍNEA (4.2% DE CAJA)", rgb("#c0392b")),
  [
    #v(15pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 9.5pt, weight: "bold", fill: rgb("#d35400"))[
        EVALUACIÓN: RESIDUO PERSISTE EN CAPÍTULO 08
      ]
    ]
    #v(6pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#d35400"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.4pt, fill: rgb("#2e2f31"))[
          En el Capítulo 08, el desfase de +18 pt en 8.1 (P.115) no evitó que la Sección 8.9 comenzara al fondo de P.118, expulsando una única línea solitaria a P.119. La página terminal queda degradada a un residuo accidental del 1.6% de ocupación vertical.
        ]
      ]
    )
    #v(8pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#2980b9"))[ESTADO A (Base Nominal):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 119 · Recto (impar) · Cierre de Cap 08"), ("Contenido útil", "Únicamente 1 línea terminal (y=70.4 pt)"), ("Texto terminal", "«régimen disciplinario, reforzando la eficacia y coherencia...»"), ("Ocupación vertical", "1.6% de caja útil (7.9 pt de texto)"), ("Página anterior (P.118)", "P.118 alojó H2 8.9 + párrafos 1 y 2, expulsando el párrafo 3")))
    #v(6pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#d35400"))[ESTADO C (Simulación x.1 +18 pt):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 119 · Recto (impar) · Cierre de Cap 08"), ("Contenido útil", "Únicamente 1 línea terminal (y=70.4 pt)"), ("Texto terminal", "«régimen disciplinario, reforzando la eficacia y coherencia d...»"), ("Ocupación vertical", "1.6% de caja útil (7.9 pt de texto)"), ("Resultado en Estado C", "EMPEORA O PERSISTE: Sigue siendo una página con 1 sola línea")))
    #v(10pt)
    #align(center)[
      #box(
        fill: rgb("#fef9e7"),
        stroke: 0.5pt + rgb("#f39c12"),
        radius: 2pt,
        inset: (x: 8pt, y: 5pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#7f4f00"))[
          • *Líneas en P.119:* 1 línea solitaria (página casi vacía)\
• *Comparación vs Fase 3.9:* Fase 3.9 trasladó Sección 8.9 completa (7 lín. con H2)\
• *Efectividad de +18 pt:* 0% de resolución
        ]
      )
    ]
  ],
  page-card(sim_pdf, 119, "ESTADO C (+18 pt): 1 SOLA LÍNEA SOLITARIA (PÁGINA DEFICIENTE)", rgb("#c0392b")),
)

#pagebreak()

// ==============================================================================
// LÁMINA 06 / 06: IMPACTO EN CIERRE DEL PROTOCOLO — CAPÍTULO 09 (PÁGINA 126)
// ==============================================================================
#v(2pt)
#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[
  LÁMINA 06 / 06: IMPACTO EN CIERRE DEL PROTOCOLO — CAPÍTULO 09 (PÁGINA 126)
]
#v(10pt)

#grid(
  columns: (396pt, 1fr, 396pt),
  align: (top + left, top + center, top + right),
  gutter: 14pt,
  page-card(orig_pdf, 126, "ESTADO A: RESIDUO DÉBIL DE 2 LÍNEAS EN CLAUSURA DEL LIBRO", rgb("#c0392b")),
  [
    #v(15pt)
    #align(center)[
      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 9.5pt, weight: "bold", fill: rgb("#d35400"))[
        EVALUACIÓN: RESIDUO PERSISTE EN CLAUSURA FINAL
      ]
    ]
    #v(6pt)
    #block(
      fill: rgb("#fffaf7"),
      stroke: 0.5pt + rgb("#d35400"),
      radius: 3pt,
      inset: 8pt,
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.4pt, fill: rgb("#2e2f31"))[
          El desfase de +18 pt en 9.1 (P.123) no alteró la partición de la Sección 9.8 en P.125. La última página de todo el Protocolo Familiar continúa cerrando con solo 2 líneas al tope, privando a la obra de la solemnidad que sí proporciona la redistribución semántica de la Fase 3.9.
        ]
      ]
    )
    #v(8pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#2980b9"))[ESTADO A (Base Nominal):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 126 · Verso (par) · Cierre Definitivo del Protocolo"), ("Contenido útil", "Únicamente 2 líneas terminales (y=70.4 a 88.4 pt)"), ("Texto terminal", "«El Protocolo constituye un sistema normativo cerrado, no sus...»"), ("Ocupación vertical", "4.2% de caja útil (25.9 pt de texto)"), ("Página anterior (P.125)", "P.125 alojó H2 9.8 + párrafos 1 y 2, expulsando el párrafo final")))
    #v(6pt)
    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#d35400"))[ESTADO C (Simulación x.1 +18 pt):]]
    #v(2pt)
    #data-table((("Folio y paridad", "Pág. 126 · Verso (par) · Cierre Definitivo del Protocolo"), ("Contenido útil", "Únicamente 2 líneas terminales (y=70.4 a 88.4 pt)"), ("Texto terminal", "«El Protocolo constituye un sistema normativo cerrado, no sus...»"), ("Ocupación vertical", "4.2% de caja útil (25.9 pt de texto)"), ("Resultado en Estado C", "FRACASO EDITORIAL: La clausura solemne de la obra termina en 2 lín.")))
    #v(10pt)
    #align(center)[
      #box(
        fill: rgb("#fef9e7"),
        stroke: 0.5pt + rgb("#f39c12"),
        radius: 2pt,
        inset: (x: 8pt, y: 5pt),
        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#7f4f00"))[
          • *Líneas en P.126:* 2 líneas terminales\
• *Comparación vs Fase 3.9:* Fase 3.9 trasladó Sección 9.8 completa (8 lín. con H2)\
• *Efectividad de +18 pt:* 0% de resolución
        ]
      )
    ]
  ],
  page-card(sim_pdf, 126, "ESTADO C (+18 pt): RESIDUO DE 2 LÍNEAS PERSISTE EN CLAUSURA", rgb("#c0392b")),
)