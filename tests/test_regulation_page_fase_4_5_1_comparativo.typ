// ==============================================================================
// TEST REGULATION PAGE FASE 4.5.1 — COMPARATIVO FORENSE MULTIPÁGINA
// Microajuste de Espacio R4 (Artículo) -> R5 (Primer Párrafo)
// Protocolo Familiar POLIFLEX
// ==============================================================================

#import "/templates/typst/componentes_fase_4_experimental.typ": *
#import "/tests/corpus_fase_4_5.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

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
        #text(size: 6pt, fill: rgb("#6c6b67"), tracking: 0.200em)[POLIDUCTOS FLEXIBLES, S.A. DE C.V. · PROTOCOLO FAMILIAR · FASE 4.5.1]
        #v(1pt)
        #text(size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[COMPARATIVA FORENSE A ESCALA 1:1 · MICROAJUSTE ESPACIO ARTÍCULO → CUERPO]
      ],
      [
        #text(size: 8pt, weight: "bold", fill: rgb("#f15d22"))[LÁMINA COMPARATIVA A3 (ESCALA 1:1)]
        #v(1pt)
        #text(size: 6.5pt, fill: rgb("#6c6b67"))[A4 (4.0 pt) vs. A orig (5.5 pt) vs. A6 (6.0 pt) vs. A8 (8.0 pt)]
      ]
    )
    #v(3pt)
    #line(length: 100%, stroke: 0.8pt + rgb("#f15d22"))
  ],
  footer: context [
    #line(length: 100%, stroke: 0.4pt + rgb("#cbd5e1"))
    #v(2pt)
    #grid(
      columns: (1fr, 1fr),
      text(size: 6pt, fill: rgb("#6c6b67"))[Protocolo Familiar POLIFLEX · Familia Velasco Chedraui · Septiembre 2026],
      align(right)[#text(size: 6pt, fill: rgb("#6c6b67"))[Página 1 de 17]]
    )
  ]
)

#v(6pt)

#table(
  columns: (1.5fr, 1fr, 1fr, 1fr, 1fr),
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: (x, y) => if y == 0 { rgb("#f1f5f9") } else if calc.even(y) { rgb("#f8fafc") } else { rgb("#ffffff") },
  align: (x, y) => if x == 0 { left } else { center },
  inset: (x: 6pt, y: 5pt),
  table.header(
    [*Parámetro Forense / Métrica*],
    [*A4 (4.0 pt)*],
    [*A original (5.5 pt)*],
    [*A6 (6.0 pt)*],
    [*A8 (8.0 pt)*]
  ),
  [Espaciado posterior `below` configurado], [4.00 pt], [5.50 pt], [6.00 pt], [8.00 pt],
  [Cota $y_1$ del encabezado (Artículo 5)], [122.76 pt], [122.76 pt], [122.76 pt], [122.76 pt],
  [Baseline del encabezado (Minion Medium 9.2pt)], [120.25 pt], [120.25 pt], [120.25 pt], [120.25 pt],
  [Cota $y_0$ primera línea de cuerpo], [123.66 pt], [125.16 pt], [125.66 pt], [127.66 pt],
  [Baseline primera línea de cuerpo], [129.52 pt], [131.02 pt], [131.52 pt], [133.52 pt],
  [*Distancia Baseline → Baseline*], [*9.27 pt*], [*10.77 pt*], [*11.27 pt*], [*13.27 pt*],
  [Ratio vs. Leading de cuerpo ($12.72949$ pt)], [0.73 $times$], [0.85 $times$], [0.89 $times$], [1.04 $times$],
  [*Luz libre óptica (caja a caja)*], [*0.90 pt* (colisión)], [*2.40 pt* (ajustado)], [*2.90 pt* (moderado)], [*4.90 pt* (óptimo)],
  [Ocupación Página 1 (RECTO)], [94.7% (450.62 pt)], [95.3% (453.62 pt)], [95.5% (454.62 pt)], [96.3% (458.62 pt)],
  [Ocupación Página 2 (VERSO)], [92.4% (440.01 pt)], [93.1% (443.01 pt)], [93.3% (444.01 pt)], [94.1% (448.01 pt)],
  [Ocupación Página 3 (RECTO)], [92.0% (437.82 pt)], [92.6% (440.82 pt)], [92.8% (441.82 pt)], [93.7% (445.82 pt)],
  [Ocupación Página 4 (VERSO)], [51.5% (245.05 pt)], [52.1% (248.05 pt)], [52.3% (249.05 pt)], [53.2% (253.05 pt)],
  [Coordenada $y_0$ de `TRANSITORIO ÚNICO`], [258.77 pt], [261.77 pt], [262.77 pt], [266.77 pt],
  [Desplazamiento vertical vs. A original], [-3.00 pt], [0.00 pt (base)], [+1.00 pt], [+5.00 pt],
  [Cambios de corte de página (P1–P4)], [0 cambios], [0 cambios], [0 cambios], [0 cambios],
  [Líneas huérfanas / viudas generadas], [0 huérfanas], [0 huérfanas], [0 huérfanas], [0 huérfanas]
)

#v(8pt)

#image("/dist/lamina_comparativa_fase_4_5_1_art_spacing.png", width: 100%)

// ==============================================================================
// SECCIÓN 2: FLUJO COMPLETO 4 PÁGINAS — A ORIGINAL (below: 5.5 pt)
// ==============================================================================
#pagebreak()
#set page(
  paper: "a4",
  flipped: false,
  margin: auto,
  header: none,
  footer: none
)

#regulation-page(cfg, variant: "A", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "A")
]

// ==============================================================================
// SECCIÓN 3: FLUJO COMPLETO 4 PÁGINAS — MICROVARIANTE A4 (below: 4.0 pt)
// ==============================================================================
#pagebreak()
#regulation-page(cfg, variant: "A4", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "A4")
]

// ==============================================================================
// SECCIÓN 4: FLUJO COMPLETO 4 PÁGINAS — MICROVARIANTE A6 (below: 6.0 pt)
// ==============================================================================
#pagebreak()
#regulation-page(cfg, variant: "A6", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "A6")
]

// ==============================================================================
// SECCIÓN 5: FLUJO COMPLETO 4 PÁGINAS — MICROVARIANTE A8 (below: 8.0 pt)
// ==============================================================================
#pagebreak()
#regulation-page(cfg, variant: "A8", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "A8")
]
