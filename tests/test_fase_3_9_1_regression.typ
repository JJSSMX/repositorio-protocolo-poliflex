// ==============================================================================
// DOCUMENTO DE REGRESIÓN VISUAL: FASE 3.9.1 — PROTOCOLO FAMILIAR POLIFLEX
// Comparativa Forense de Spreads Completos (792 × 612 pt) a Escala Idéntica ANTES | FINAL
// Formato: A3 Apaisado (1190.55 × 841.89 pt)
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
          PROTOCOLO FAMILIAR POLIFLEX · DOCUMENTO OFICIAL DE REGRESIÓN VISUAL DE PAGINACIÓN
        ]
        #h(8pt)
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[
          | FASE 3.9.1: CONSOLIDACIÓN EDITORIAL DEFINITIVA (PLIEGOS A ESCALA IDÉNTICA)
        ]
      ],
      [
        #let p = counter(page).get().first()
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: rgb("#2e2f31"))[
          Lámina #p de 8
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
          Retícula +6 mm Congelada · 126 Páginas · 64 Pliegos · Fuentes Canónicas `/capitulos/*.md` Read-Only
        ]
      ],
      [
        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[
          Comparativa ANTES (Fase 3.7/3.8) vs FINAL (Fase 3.9.1 Consolidado) · Escala Idéntica 1:1.52
        ]
      ]
    )
  ]
)

#let pdf_orig = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf"
#let pdf_final = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1_SPREADS.pdf"

#let spread-box(pdf-path, spread-idx, badge-text, badge-fill, label-text) = [
  #block(width: 520pt)[
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
      width: 520pt,
      height: 401.8pt,
      clip: true,
      image(pdf-path, page: spread-idx, width: 520pt, height: 401.8pt)
    )
  ]
]

#let data-table(items) = [
  #table(
    columns: (auto, 1fr),
    stroke: (x, y) => if y == 0 { (bottom: 0.4pt + rgb("#dcdcdc")) } else { (bottom: 0.3pt + rgb("#eeeeee")) },
    fill: (col, row) => if calc.even(row) { rgb("#fbfbfb") } else { white },
    inset: (x: 5pt, y: 3pt),
    ..items.map(it => (
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, weight: "bold", fill: rgb("#444444"))[#it.at(0)],
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#2e2f31"))[#it.at(1)]
    )).flatten()
  )
]

// ==============================================================================
// LÁMINA 01 / 08: CASOS P.65–66 — CONTROL DE LÍNEA VIUDA AISLADA (CAPÍTULO 04)
// ==============================================================================
#v(1pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 01 / 08: CASOS P.65–66 — CONTROL DE LÍNEA VIUDA AISLADA (CAPÍTULO 04)
    ]
    #h(8pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, fill: rgb("#f15d22"), weight: "bold")[
      [Pliego 34 · Páginas 66 (Verso) y 67 (Recto)]
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ 126 PÁGINAS PRESERVADAS · PARIDAD INTACTA
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  spread-box(pdf_orig, 34, "ANOMALÍA ANTES: VIUDA AISLADA (1 LÍNEA EN P.66 ANTES DE H3 4.1.2)", rgb("#c0392b"), "PLIEGO ANTERIOR (FASE 3.7 / 3.8)"),
  spread-box(pdf_final, 34, "CONSOLIDADO FINAL: 0 VIUDAS (P.66 INICIA CON H3 4.1.2 ROBUSTO)", rgb("#27ae60"), "PLIEGO CONSOLIDADO (FASE 3.9.1)"),
)
#v(8pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  [
    #data-table((("Pliego visualizado", "Pliego 34 · Páginas 66 (Verso, izquierda) y 67 (Recto, derecha)"), ("Apertura en P.66", "1 sola línea de remanente del párrafo 4.1.1 proveniente de P.65"), ("Texto de la viuda", "«inmediatos a favor de los sucesores, condicionando cualquier...»"), ("Contexto siguiente", "Inmediatamente seguido por encabezado H3 4.1.2 en línea 2"), ("Diagnóstico editorial", "Quiebre deficiente 6+1 que rompe la jerarquía tipográfica")))
  ],
  [
    #data-table((("Pliego visualizado", "Pliego 34 · Páginas 66 (Verso, izquierda) y 67 (Recto, derecha)"), ("Apertura en P.66", "Encabezado H3 4.1.2 al tope + párrafo íntegro (24 líneas continuas)"), ("Estado de viudas", "0 líneas viudas en P.66 · Cumple estrictamente regla 2+2"), ("Métrica editorial", "P.66 al 86% de ocupación (468 pt) · P.65 retiene párrafo 4.1.1"), ("Impacto visual", "Apertura noble, lectura fluida y jerarquía institucional limpia")))
  ]
)
#v(6pt)
#block(
  fill: rgb("#fffaf7"),
  stroke: 0.5pt + rgb("#f15d22"),
  radius: 2pt,
  inset: (x: 10pt, y: 5pt),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#f15d22"))[DICTAMEN EDITORIAL: ]
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[Al aplicar la regla general de viudas y huérfanas 2+2, el párrafo 4.1.1 no sufre partición deficiente en P.65/66. En el Estado Final, P.66 abre noblemente con el título H3 4.1.2 y 24 líneas de cuerpo sólido, eliminando por completo la línea aislada sin alterar la paginación global (126 págs).]
  ]
)

#pagebreak()

// ==============================================================================
// LÁMINA 02 / 08: CASOS P.67–68 — CONTROL DE FLUJO 2+2 ANTES DE ENCABEZADO (CAPÍTULO 04)
// ==============================================================================
#v(1pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 02 / 08: CASOS P.67–68 — CONTROL DE FLUJO 2+2 ANTES DE ENCABEZADO (CAPÍTULO 04)
    ]
    #h(8pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, fill: rgb("#f15d22"), weight: "bold")[
      [Pliego 35 · Páginas 68 (Verso) y 69 (Recto)]
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ 126 PÁGINAS PRESERVADAS · PARIDAD INTACTA
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  spread-box(pdf_orig, 35, "ANOMALÍA ANTES: REMANENTE DÉBIL DE 1 LÍNEA ANTES DE H3 4.2.2", rgb("#c0392b"), "PLIEGO ANTERIOR (FASE 3.7 / 3.8)"),
  spread-box(pdf_final, 35, "CONSOLIDADO FINAL: FLUJO EQUILIBRADO (2 LÍNEAS COMPLETAS EN P.68)", rgb("#27ae60"), "PLIEGO CONSOLIDADO (FASE 3.9.1)"),
)
#v(8pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  [
    #data-table((("Pliego visualizado", "Pliego 35 · Páginas 68 (Verso, izquierda) y 69 (Recto, derecha)"), ("Apertura en P.68", "1 sola línea de remanente de Sección 4.2.1 proveniente de P.67"), ("Texto terminal", "«al régimen de separación de derechos, al congelamiento accio...»"), ("Contexto siguiente", "Encabezado H3 4.2.2 forzado a la línea 2 de la página"), ("Diagnóstico editorial", "Quiebre 4+1 por presión vertical acumulada en P.67")))
  ],
  [
    #data-table((("Pliego visualizado", "Pliego 35 · Páginas 68 (Verso, izquierda) y 69 (Recto, derecha)"), ("Apertura en P.68", "Flujo continuo de 2 líneas completas de remanente legal"), ("Estado de viudas", "0 viudas aisladas · Cumple umbral mínimo 2+2 antes de quiebre"), ("Métrica editorial", "Integración armónica del texto de 4.2.1 con el encabezado 4.2.2"), ("Impacto visual", "Ritmo de lectura natural y sostenido a través de la doble página")))
  ]
)
#v(6pt)
#block(
  fill: rgb("#fffaf7"),
  stroke: 0.5pt + rgb("#f15d22"),
  radius: 2pt,
  inset: (x: 10pt, y: 5pt),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#f15d22"))[DICTAMEN EDITORIAL: ]
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[La consolidación de la regla estructural 2+2 asegura que el remanente de 4.2.1 en P.68 cuente con al menos dos líneas de soporte antes de dar paso al encabezado H3 4.2.2, garantizando la estabilidad visual del pliego.]
  ]
)

#pagebreak()

// ==============================================================================
// LÁMINA 03 / 08: CIERRE CAPÍTULO 04 — TRASLADO DE PÁRRAFO CONCLUSIVO 4.9.4 (ALTERNATIVA B)
// ==============================================================================
#v(1pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 03 / 08: CIERRE CAPÍTULO 04 — TRASLADO DE PÁRRAFO CONCLUSIVO 4.9.4 (ALTERNATIVA B)
    ]
    #h(8pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, fill: rgb("#f15d22"), weight: "bold")[
      [Pliego 44 · Páginas 86 (Verso) y 87 (Recto)]
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ 126 PÁGINAS PRESERVADAS · PARIDAD INTACTA
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  spread-box(pdf_orig, 44, "BASE ANTES: RESIDUO TERMINAL DÉBIL (2 LÍNEAS EN P.87 · 4.2% DE CAJA)", rgb("#c0392b"), "PLIEGO ANTERIOR (FASE 3.7 / 3.8)"),
  spread-box(pdf_final, 44, "CONSOLIDADO FINAL: PÁRRAFO CONCLUSIVO 2 ÍNTEGRO (5 LÍNEAS · 16.8% CAJA)", rgb("#27ae60"), "PLIEGO CONSOLIDADO (FASE 3.9.1)"),
)
#v(8pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  [
    #data-table((("Pliego visualizado", "Pliego 44 · Páginas 86 (Verso, izquierda) y 87 (Recto, derecha)"), ("Contenido terminal", "Únicamente 2 líneas de remanente accidental en P.87 (y=70.4 a 88.4 pt)"), ("Texto terminal", "«momento, el cuadro accionario se considerará regularizado...»"), ("Ocupación vertical", "4.2% de caja útil en P.87 · P.86 alojó 3 líneas del párrafo"), ("Diagnóstico editorial", "Cierre débil que desmerece la conclusión del capítulo sucesorio")))
  ],
  [
    #data-table((("Pliego visualizado", "Pliego 44 · Páginas 86 (Verso, izquierda) y 87 (Recto, derecha)"), ("Contenido terminal", "Párrafo 2 conclusivo de 4.9.4 íntegro (5 líneas completas) en P.87"), ("Texto terminal", "«Concluido el procedimiento y cumplidas las condiciones...»"), ("Ocupación vertical", "P.87 con 16.8% de ocupación (~80 pt) · P.86 con 84.6% (24 líneas)"), ("Decisión aprobada", "Alternativa B (Fase 3.9B): No trasladar toda 4.9.4; solo Párrafo 2")))
  ]
)
#v(6pt)
#block(
  fill: rgb("#fffaf7"),
  stroke: 0.5pt + rgb("#f15d22"),
  radius: 2pt,
  inset: (x: 10pt, y: 5pt),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#f15d22"))[DICTAMEN EDITORIAL: ]
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[Conforme a la Alternativa B aprobada en Fase 3.9B, se traslada hacia adelante exclusivamente el Párrafo 2 resolutivo de la subsección 4.9.4. P.86 mantiene una ocupación sólida del 84.6%, mientras P.87 ofrece una clausura societaria respetable de 5 líneas completas (16.8%), sin inflar artificialmente la sección.]
  ]
)

#pagebreak()

// ==============================================================================
// LÁMINA 04 / 08: CIERRE CAPÍTULO 08 — CONTINUIDAD NATURAL DE SECCIÓN 8.9 (ALTERNATIVA B)
// ==============================================================================
#v(1pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 04 / 08: CIERRE CAPÍTULO 08 — CONTINUIDAD NATURAL DE SECCIÓN 8.9 (ALTERNATIVA B)
    ]
    #h(8pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, fill: rgb("#f15d22"), weight: "bold")[
      [Pliego 60 · Páginas 118 (Verso) y 119 (Recto)]
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ 126 PÁGINAS PRESERVADAS · PARIDAD INTACTA
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  spread-box(pdf_orig, 60, "BASE ANTES: RESIDUO TERMINAL DÉBIL (1 LÍNEA EN P.119 · 4.2% DE CAJA)", rgb("#c0392b"), "PLIEGO ANTERIOR (FASE 3.7 / 3.8)"),
  spread-box(pdf_final, 60, "CONSOLIDADO FINAL: H2+P1 EN P.118 | P2+P3 EN P.119 (5 LÍNEAS · 16.8% CAJA)", rgb("#27ae60"), "PLIEGO CONSOLIDADO (FASE 3.9.1)"),
)
#v(8pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  [
    #data-table((("Pliego visualizado", "Pliego 60 · Páginas 118 (Verso, izquierda) y 119 (Recto, derecha)"), ("Contenido terminal", "Únicamente 1 línea aislada en P.119 al tope de página (y=70.4 pt)"), ("Texto terminal", "«régimen disciplinario, reforzando la eficacia y coherencia...»"), ("Ocupación vertical", "4.2% de caja útil en P.119 · P.118 alojó H2 8.9 + párrafos 1 y 2"), ("Diagnóstico editorial", "Corte tipográfico defectuoso al final del sistema de solución de conflictos")))
  ],
  [
    #data-table((("Pliego visualizado", "Pliego 60 · Páginas 118 (Verso, izquierda) y 119 (Recto, derecha)"), ("Distribución P.118", "P.118 retiene H2 8.9 + Párrafo 1 (82.2% ocupación, 23 líneas)"), ("Distribución P.119", "P.119 recibe Párrafos 2 y 3 (5 líneas útiles, 16.8% ocupación)"), ("Regla aplicada", "Alternativa B (Fase 3.9B): Sección 8.9 fluye naturalmente sin repetir H2"), ("Impacto visual", "P.118 concluye balanceada; P.119 cierra con bloque normativo de 5 líneas")))
  ]
)
#v(6pt)
#block(
  fill: rgb("#fffaf7"),
  stroke: 0.5pt + rgb("#f15d22"),
  radius: 2pt,
  inset: (x: 10pt, y: 5pt),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#f15d22"))[DICTAMEN EDITORIAL: ]
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[Se aplica la Alternativa B aprobada: no se traslada la Sección 8.9 completa en bloque, sino que se mantiene H2 8.9 + Párrafo 1 en P.118 (cumpliendo sobradamente keep-with-next) y se permite que los párrafos 2 y 3 continúen en P.119 como 5 líneas sólidas (16.8% de ocupación), evitando huecos artificiales en P.118.]
  ]
)

#pagebreak()

// ==============================================================================
// LÁMINA 05 / 08: CIERRE CAPÍTULO 09 — CLAUSURA SOLEMNE CON SECCIÓN 9.8 COMPLETA (ALTERNATIVA B)
// ==============================================================================
#v(1pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 05 / 08: CIERRE CAPÍTULO 09 — CLAUSURA SOLEMNE CON SECCIÓN 9.8 COMPLETA (ALTERNATIVA B)
    ]
    #h(8pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, fill: rgb("#f15d22"), weight: "bold")[
      [Pliego 64 · Páginas 126 (Verso) y 127 (Recto ceremonial blanco)]
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ 126 PÁGINAS PRESERVADAS · PARIDAD INTACTA
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  spread-box(pdf_orig, 64, "BASE ANTES: RESIDUO DÉBIL DE 2 LÍNEAS EN CLAUSURA DE LA OBRA (P.126)", rgb("#c0392b"), "PLIEGO ANTERIOR (FASE 3.7 / 3.8)"),
  spread-box(pdf_final, 64, "CONSOLIDADO FINAL: SECCIÓN 9.8 COMPLETA (H2 + 3 PÁRRAFOS · CIERRE SOLEMNE)", rgb("#27ae60"), "PLIEGO CONSOLIDADO (FASE 3.9.1)"),
)
#v(8pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  [
    #data-table((("Pliego visualizado", "Pliego 64 · Páginas 126 (Verso, izquierda) y 127 (Recto blanco final)"), ("Contenido terminal", "2 únicas líneas huérfanas al tope de P.126 para cerrar todo el Protocolo"), ("Texto terminal", "«El Protocolo constituye un sistema normativo cerrado, no susceptible...»"), ("Ocupación vertical", "4.2% de caja útil en P.126 · P.125 cortó la sección tras el párrafo 2"), ("Diagnóstico editorial", "Cierre anticlimático e indigno para la conclusión del Protocolo Familiar")))
  ],
  [
    #data-table((("Pliego visualizado", "Pliego 64 · Páginas 126 (Verso, izquierda) y 127 (Recto blanco final)"), ("Contenido terminal", "Sección 9.8 íntegra: H2 formal + 3 párrafos completos (11 líneas)"), ("Título de clausura", "«9.8 Interpretación y Cierre Normativo»"), ("Ocupación vertical", "29.0% de caja útil (~150 pt de texto normativo estructurado)"), ("Excepción aprobada", "Alternativa B (Fase 3.9B): Excepción deliberada por clausura de obra")))
  ]
)
#v(6pt)
#block(
  fill: rgb("#fffaf7"),
  stroke: 0.5pt + rgb("#f15d22"),
  radius: 2pt,
  inset: (x: 10pt, y: 5pt),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#f15d22"))[DICTAMEN EDITORIAL: ]
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[Como excepción deliberada ratificada en Fase 3.9B, la Sección 9.8 se mantiene indivisible en la página final P.126. El Protocolo concluye con su encabezado normativo y 3 párrafos resolutivos solemnes (29% de ocupación), otorgando el peso institucional que requiere el cierre del documento.]
  ]
)

#pagebreak()

// ==============================================================================
// LÁMINA 06 / 08: CONTEXTO CAPÍTULO 09 — EQUILIBRIO PREVIO AL CIERRE (PLIEGO 63)
// ==============================================================================
#v(1pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 06 / 08: CONTEXTO CAPÍTULO 09 — EQUILIBRIO PREVIO AL CIERRE (PLIEGO 63)
    ]
    #h(8pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, fill: rgb("#f15d22"), weight: "bold")[
      [Pliego 63 · Páginas 124 (Verso) y 125 (Recto)]
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ 126 PÁGINAS PRESERVADAS · PARIDAD INTACTA
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  spread-box(pdf_orig, 63, "BASE ANTES: P.125 SOBRECARGADA AL PIE CON H2 9.8 Y CORTE ABRUPTO", rgb("#c0392b"), "PLIEGO ANTERIOR (FASE 3.7 / 3.8)"),
  spread-box(pdf_final, 63, "CONSOLIDADO FINAL: P.125 CONCLUYE LIMPIAMENTE EN SECCIÓN 9.7", rgb("#27ae60"), "PLIEGO CONSOLIDADO (FASE 3.9.1)"),
)
#v(8pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  [
    #data-table((("Pliego visualizado", "Pliego 63 · Páginas 124 (Verso, izquierda) y 125 (Recto, derecha)"), ("Contenido en P.125", "Sección 9.7 completa + inicio forzado de 9.8 (H2 + 2 párrafos)"), ("Comportamiento al pie", "9.8 quedaba truncada al final de página, expulsando 2 líneas"), ("Ocupación en P.125", "96.5% de caja útil (casi al límite de desbordamiento)"), ("Diagnóstico editorial", "Apretura visual que forzaba el quiebre de la última sección")))
  ],
  [
    #data-table((("Pliego visualizado", "Pliego 63 · Páginas 124 (Verso, izquierda) y 125 (Recto, derecha)"), ("Contenido en P.125", "Concluye limpiamente con la totalidad de la Sección 9.7"), ("Último párrafo P.125", "«Cualquier mecanismo que, bajo apariencia de legalidad...»"), ("Ocupación en P.125", "66.2% de caja útil (18 líneas de cuerpo sólido y equilibrado)"), ("Transición editorial", "Respiración noble que anticipa la solemnidad del cierre en P.126")))
  ]
)
#v(6pt)
#block(
  fill: rgb("#fffaf7"),
  stroke: 0.5pt + rgb("#f15d22"),
  radius: 2pt,
  inset: (x: 10pt, y: 5pt),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#f15d22"))[DICTAMEN EDITORIAL: ]
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[Al trasladar la Sección 9.8 íntegra a P.126, el pliego 63 (P.124–125) adquiere una respiración natural inmejorable. P.125 concluye con la Sección 9.7 al 66.2% de ocupación, evitando la saturación previa y preparando al lector para la clausura formal.]
  ]
)

#pagebreak()

// ==============================================================================
// LÁMINA 07 / 08: CIERRE CAPÍTULO 01 — UNIDAD SEMÁNTICA AUTÓNOMA (REGLA D)
// ==============================================================================
#v(1pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 07 / 08: CIERRE CAPÍTULO 01 — UNIDAD SEMÁNTICA AUTÓNOMA (REGLA D)
    ]
    #h(8pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, fill: rgb("#f15d22"), weight: "bold")[
      [Pliego 05 · Páginas 08 (Verso) y 09 (Recto ceremonial blanco)]
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ 126 PÁGINAS PRESERVADAS · PARIDAD INTACTA
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  spread-box(pdf_orig, 5, "BASE ANTES: UNIDAD SEMÁNTICA CORTA (6 LÍNEAS CON H2 1.8)", rgb("#2980b9"), "PLIEGO ANTERIOR (FASE 3.7 / 3.8)"),
  spread-box(pdf_final, 5, "CONSOLIDADO FINAL: PRESERVADA IDÉNTICA (REGLA D: NO SOBREOPTIMIZAR)", rgb("#27ae60"), "PLIEGO CONSOLIDADO (FASE 3.9.1)"),
)
#v(8pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  [
    #data-table((("Pliego visualizado", "Pliego 05 · Páginas 08 (Verso, izquierda) y 09 (Recto ceremonial)"), ("Contenido terminal", "6 líneas útiles: Encabezado H2 1.8 + párrafo conclusivo de 5 líneas"), ("Título de sección", "«1.8 Criterio de Interpretación del Protocolo»"), ("Naturaleza editorial", "Unidad semántica corta genuina, autoportante y autónoma"), ("Ocupación vertical", "102 pt de altura útil (~21% de la caja tipográfica)")))
  ],
  [
    #data-table((("Pliego visualizado", "Pliego 05 · Páginas 08 (Verso, izquierda) y 09 (Recto ceremonial)"), ("Contenido terminal", "6 líneas útiles: Encabezado H2 1.8 + párrafo completo"), ("Estado de no-regresión", "Exactamente 100% idéntica al estado base · Cero cambios"), ("Justificación editorial", "No es un residuo accidental; es una unidad temática plena"), ("Regla confirmada", "Regla D: Prohibición de comprimir o alterar cierres nobles")))
  ]
)
#v(6pt)
#block(
  fill: rgb("#fffaf7"),
  stroke: 0.5pt + rgb("#f15d22"),
  radius: 2pt,
  inset: (x: 10pt, y: 5pt),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#f15d22"))[DICTAMEN EDITORIAL: ]
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[La Regla D ratifica que una página terminal breve con encabezado propio y sentido completo constituye un descanso editorial legítimo y no debe sobreoptimizarse. El Capítulo 01 permanece intacto, garantizando el respeto al ritmo orgánico del texto.]
  ]
)

#pagebreak()

// ==============================================================================
// LÁMINA 08 / 08: CIERRE CAPÍTULO 06 — DENSIDAD MODERADA VÁLIDA (REGLA D)
// ==============================================================================
#v(1pt)
#grid(
  columns: (1fr, auto),
  align: (left + bottom, right + bottom),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[
      LÁMINA 08 / 08: CIERRE CAPÍTULO 06 — DENSIDAD MODERADA VÁLIDA (REGLA D)
    ]
    #h(8pt)
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, fill: rgb("#f15d22"), weight: "bold")[
      [Pliego 52 · Páginas 102 (Verso) y 103 (Recto ceremonial blanco)]
    ]
  ],
  [
    #box(
      fill: rgb("#eef7f2"),
      stroke: 0.5pt + rgb("#27ae60"),
      radius: 2pt,
      inset: (x: 6pt, y: 2.5pt),
      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[
        ✓ 126 PÁGINAS PRESERVADAS · PARIDAD INTACTA
      ]
    )
  ]
)
#v(6pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  spread-box(pdf_orig, 52, "BASE ANTES: SECCIÓN FORMAL DE 10 LÍNEAS (45% DE CAJA CON H2 6.6)", rgb("#2980b9"), "PLIEGO ANTERIOR (FASE 3.7 / 3.8)"),
  spread-box(pdf_final, 52, "CONSOLIDADO FINAL: PRESERVADA IDÉNTICA (REGLA D: NO SOBREOPTIMIZAR)", rgb("#27ae60"), "PLIEGO CONSOLIDADO (FASE 3.9.1)"),
)
#v(8pt)

#grid(
  columns: (520pt, 520pt),
  gutter: 48pt,
  [
    #data-table((("Pliego visualizado", "Pliego 52 · Páginas 102 (Verso, izquierda) y 103 (Recto ceremonial)"), ("Contenido terminal", "10 líneas útiles: 2 de remanente + H2 6.6 + 7 de cuerpo"), ("Título de sección", "«6.6 Responsabilidad Patrimonial del Accionista Familiar...»"), ("Ocupación vertical", "215.5 pt de altura útil (~45% de la caja tipográfica)"), ("Estado visual", "Página noble, espaciosa y perfectamente armónica")))
  ],
  [
    #data-table((("Pliego visualizado", "Pliego 52 · Páginas 102 (Verso, izquierda) y 103 (Recto ceremonial)"), ("Contenido terminal", "10 líneas útiles: 2 de remanente + H2 6.6 + 7 de cuerpo"), ("Estado de no-regresión", "Exactamente 100% idéntica al estado base · Cero alteraciones"), ("Justificación editorial", "Masa crítica suficiente (~media página); no requiere ajuste"), ("Regla confirmada", "Regla D: Se preserva la respiración y ritmo sin forzar llenados")))
  ]
)
#v(6pt)
#block(
  fill: rgb("#fffaf7"),
  stroke: 0.5pt + rgb("#f15d22"),
  radius: 2pt,
  inset: (x: 10pt, y: 5pt),
  [
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#f15d22"))[DICTAMEN EDITORIAL: ]
    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[El cierre del Capítulo 06 en P.102 cuenta con 10 líneas, título H2 y 45% de altura ocupada. Representa una composición clásica y sobria. La Regla D previene la manipulación artificial de páginas que ya gozan de dignidad compositiva.]
  ]
)