// ==============================================================================
// COMPONENTES FASE 4 (EXPERIMENTAL / NOT LOCKED)
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
//
// Módulos complementarios: Reglamentos y Anexos.
// Este archivo contiene componentes en fase de prototipado y evaluación.
//
// NOTA DE GRADUACIÓN DE COMPONENTES:
// - introduction-page(): Consolidado formalmente en Fase 4.3.4 [APPROVED / LOCKED]
// - regulation-opening(): Consolidado formalmente en Fase 4.4.2 [APPROVED / LOCKED]
//
// Ambos componentes residen oficialmente en templates/typst/componentes.typ
// y se re-exportan automáticamente al importar este archivo.
// ==============================================================================

#import "/templates/typst/componentes.typ": *

// ==============================================================================
// FASE 4.5: SISTEMA NORMATIVO INTERIOR DE REGLAMENTOS (EXPERIMENTAL / NOT LOCKED)
// ==============================================================================

// ------------------------------------------------------------------------------
// R1. RUNNING HEADER DE REGLAMENTOS
// Adaptado del sistema de interior-page() con lógica Recto/Verso y paridad.
// ------------------------------------------------------------------------------
#let regulation-running-header(
  cfg,
  reg_name: "ASAMBLEA DE FAMILIA",
  variant: "A",
  is_recto: true
) = {
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let iso = interior-isotype(width: 7.1186pt, height: 7.0000pt, opacity: 50%)

  // Título e identidad según variante
  let (header_title, header_font_size, header_tracking, header_color, header_weight) = if variant in ("A", "A4", "A6", "A8") {
    ("REGLAMENTO · " + reg_name, 5.5pt, 0.200em, rgb("#6c6b67"), "regular")
  } else if variant == "B" {
    (reg_name, 5.5pt, 0.220em, rgb("#2e2f31"), "medium")
  } else {
    // Variante C: Título estructurado compacto
    ("REGLAMENTO DE LA " + reg_name, 5.0pt, 0.180em, rgb("#6c6b67"), "regular")
  }

  let rh_text(t, col, sz: 5.5pt, tr: 0.200em, wt: "regular") = text(
    font: neuzeit,
    size: sz,
    fill: col,
    tracking: tr,
    weight: wt
  )[#t]

  let inst_unit = [
    #rh_text("PROTOCOLO FAMILIAR", rgb("#6c6b67"))#h(8pt)#rh_text("VERSION 1.0", rgb("#f15d22"))
  ]

  let reg_unit = rh_text(
    header_title,
    header_color,
    sz: header_font_size,
    tr: header_tracking,
    wt: header_weight
  )

  place(top + left, dx: 0pt, dy: 25.5pt)[
    #if is_recto [
      #grid(
        columns: (1fr, 1fr),
        align: (left + horizon, right + horizon),
        inst_unit,
        [#reg_unit#h(5pt)#box(baseline: 15%)[#iso]]
      )
    ] else [
      #grid(
        columns: (1fr, 1fr),
        align: (left + horizon, right + horizon),
        [#box(baseline: 15%)[#iso]#h(5pt)#reg_unit],
        inst_unit
      )
    ]
  ]
}

// ------------------------------------------------------------------------------
// R1b. PIE Y FOLIO DE REGLAMENTOS
// Folio dinámico en Minion Pro Medium 8pt alineado a corte exterior
// ------------------------------------------------------------------------------
#let regulation-footer(page_num, is_recto: true) = {
  let minion = ("Minion Pro", "Georgia")
  let p_str = if page_num < 10 { "0" + str(page_num) } else { str(page_num) }
  let folio_txt = text(font: minion, size: 8pt, fill: rgb("#f15d22"), weight: "medium")[#p_str]

  v(20pt)
  if is_recto [
    #align(right)[#folio_txt]
  ] else [
    #align(left)[#folio_txt]
  ]
}

// ------------------------------------------------------------------------------
// R1c. FILETE VERTICAL DE LOMO (BACKGROUND)
// Filete de 0.5pt en #f15d22 pegado al lomo (x=30.13pt recto, x=365.87pt verso)
// ------------------------------------------------------------------------------
#let regulation-spine-rule(is_recto: true) = {
  let rule_x = if is_recto { 30.13pt } else { 365.87pt }
  place(top + left, dx: rule_x, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + rgb("#f15d22")))
}

// ------------------------------------------------------------------------------
// R2 & R3. CAPÍTULO [ROMANO] + SUBTÍTULO TEMÁTICO
// Bloque indivisible unido rígidamente (keep-together) para evitar huérfanos
// ------------------------------------------------------------------------------
#let regulation-chapter(roman_num, title, variant: "A") = {
  let minion = ("Minion Pro", "Georgia")
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

  if variant in ("A", "A4", "A6", "A8") {
    // VARIANTE A (y microvariantes A4, A6, A8): Minion Pro serif display con tracking controlado
    block(width: 100%, breakable: false, sticky: true, above: 18.00pt, below: 12.73pt)[
      #text(font: minion, size: 10.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), tracking: 0.050em, weight: "medium")[#roman_num]
      #v(3.5pt)
      #text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.020em, weight: "medium")[#title]
    ]
  } else if variant == "B" {
    // VARIANTE B: Diferenciación Jurídica Dinámica (Minion + Pleca naranja + Neuzeit Bold)
    block(width: 100%, breakable: false, sticky: true, above: 20.00pt, below: 12.73pt)[
      #grid(
        columns: (auto, auto),
        gutter: 8pt,
        align: horizon,
        text(font: minion, size: 11.0pt, fill: rgb("#f15d22"), tracking: 0.080em, weight: "medium")[#roman_num],
        line(length: 14pt, stroke: 0.75pt + rgb("#f15d22"))
      )
      #v(4.0pt)
      #text(font: neuzeit, size: 8.5pt, fill: rgb("#2e2f31"), tracking: 0.040em, weight: "bold")[#title]
    ]
  } else {
    // VARIANTE C: Soberanía Normativa Compacta (Neuzeit Grotesk Bold/Medium sobrio)
    block(width: 100%, breakable: false, sticky: true, above: 14.50pt, below: 9.50pt)[
      #text(font: neuzeit, size: 8.8pt, fill: rgb("#f15d22"), tracking: 0.060em, weight: "bold")[#roman_num]
      #v(2.5pt)
      #text(font: neuzeit, size: 8.0pt, fill: rgb("#6c6b67"), tracking: 0.030em, weight: "medium")[#title]
    ]
  }
}

// ------------------------------------------------------------------------------
// R4. ARTÍCULO [N]. [NOMBRE]
// Encabezado normativo con sticky: true para evitar artículo aislado al pie
// ------------------------------------------------------------------------------
#let regulation-article(art_num, art_name, variant: "A", below_spacing: auto) = {
  let minion = ("Minion Pro", "Georgia")
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

  let sp_below = if below_spacing != auto {
    below_spacing
  } else if variant == "A4" {
    4.00pt
  } else if variant == "A6" {
    6.00pt
  } else if variant == "A8" {
    8.00pt
  } else if variant == "B" {
    6.00pt
  } else if variant == "C" {
    4.50pt
  } else {
    5.50pt // A original por defecto
  }

  if variant in ("A", "A4", "A6", "A8") {
    // VARIANTE A (y microvariantes A4, A6, A8): Minion Pro Medium con etiqueta naranja reforzada
    block(width: 100%, breakable: false, sticky: true, above: 14.00pt, below: sp_below)[
      #box[#text(font: minion, size: 9.2pt, fill: rgb("#f15d22"), stroke: 0.2pt + rgb("#f15d22"), weight: "medium")[#art_num]]#h(5.0pt)#text(font: minion, size: 9.2pt, fill: rgb("#2e2f31"), tracking: 0.015em, weight: "medium")[#art_name]
    ]
  } else if variant == "B" {
    // VARIANTE B: Híbrido técnico (Neuzeit Bold en etiqueta + Minion Bold Italic en nombre)
    block(width: 100%, breakable: false, sticky: true, above: 15.00pt, below: 6.00pt)[
      #box[#text(font: neuzeit, size: 8.2pt, fill: rgb("#f15d22"), tracking: 0.020em, weight: "bold")[#art_num]]#h(5.5pt)#text(font: minion, size: 9.0pt, fill: rgb("#2e2f31"), tracking: 0.010em, style: "italic", weight: "bold")[#art_name]
    ]
  } else {
    // VARIANTE C: Monofamilia técnica (Neuzeit Bold con punto naranja discreto)
    let clean_num = if art_num.ends-with(".") { art_num.slice(0, -1) } else { art_num }
    block(width: 100%, breakable: false, sticky: true, above: 10.50pt, below: 4.50pt)[
      #box[
        #text(font: neuzeit, size: 8.0pt, fill: rgb("#2e2f31"), weight: "bold")[#clean_num]#text(font: neuzeit, size: 8.0pt, fill: rgb("#f15d22"), weight: "bold")[.]
      ]#h(4.5pt)#text(font: neuzeit, size: 8.0pt, fill: rgb("#2e2f31"), tracking: 0.010em, weight: "bold")[#art_name]
    ]
  }
}

// ------------------------------------------------------------------------------
// R6. FRACCIONES ROMANAS Y LISTAS JURÍDICAS
// Hanging indent de alta precisión con alineación a la derecha del numeral romano
// ------------------------------------------------------------------------------
#let regulation-fraction(marker, body, variant: "A") = {
  let minion = ("Minion Pro", "Georgia")
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

  if variant in ("A", "A4", "A6", "A8") {
    // VARIANTE A: Inset 18pt, numeral en Neuzeit Medium #2e2f31
    block(width: 100%, breakable: true, below: 6.00pt)[
      #grid(
        columns: (14.0pt, 1fr),
        column-gutter: 4.0pt,
        align: (right + top, left + top),
        text(font: neuzeit, size: 7.9077pt, fill: rgb("#2e2f31"), weight: "medium")[#marker],
        [
          #set par(leading: 12.72949pt, justify: true, linebreaks: "simple")
          #text(font: neuzeit, size: 7.9077pt, fill: rgb("#2e2f31"))[#body]
        ]
      )
    ]
  } else if variant == "B" {
    // VARIANTE B: Inset 20pt, numeral en Minion Pro Medium #f15d22 (resaltado legal)
    block(width: 100%, breakable: true, below: 6.36pt)[
      #grid(
        columns: (15.0pt, 1fr),
        column-gutter: 5.0pt,
        align: (right + top, left + top),
        text(font: minion, size: 8.2pt, fill: rgb("#f15d22"), weight: "medium")[#marker],
        [
          #set par(leading: 12.72949pt, justify: true, linebreaks: "simple")
          #text(font: neuzeit, size: 7.9077pt, fill: rgb("#2e2f31"))[#body]
        ]
      )
    ]
  } else {
    // VARIANTE C: Inset 16pt, numeral en Neuzeit Bold #6c6b67 (sobrio y compacto)
    block(width: 100%, breakable: true, below: 4.50pt)[
      #grid(
        columns: (13.0pt, 1fr),
        column-gutter: 3.5pt,
        align: (right + top, left + top),
        text(font: neuzeit, size: 7.9077pt, fill: rgb("#6c6b67"), weight: "bold")[#marker],
        [
          #set par(leading: 12.72949pt, justify: true, linebreaks: "simple")
          #text(font: neuzeit, size: 7.9077pt, fill: rgb("#2e2f31"))[#body]
        ]
      )
    ]
  }
}

// ------------------------------------------------------------------------------
// R7. TRANSITORIO ÚNICO
// Cláusula de cierre normativo con anclaje visual sobrio y solemne
// ------------------------------------------------------------------------------
#let regulation-transitory(title: "TRANSITORIO ÚNICO", body: none, variant: "A") = {
  let minion = ("Minion Pro", "Georgia")
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

  if variant in ("A", "A4", "A6", "A8") {
    block(width: 100%, breakable: false, sticky: true, above: 18.00pt, below: 6.00pt)[
      #text(font: minion, size: 10.0pt, fill: rgb("#f15d22"), stroke: 0.25pt + rgb("#f15d22"), tracking: 0.050em, weight: "medium")[#title]
    ]
    if body != none [
      #body
    ]
  } else if variant == "B" {
    block(width: 100%, breakable: false, sticky: true, above: 20.00pt, below: 6.50pt)[
      #grid(
        columns: (auto, auto),
        gutter: 8pt,
        align: horizon,
        text(font: minion, size: 10.5pt, fill: rgb("#f15d22"), tracking: 0.080em, weight: "medium")[#title],
        line(length: 14pt, stroke: 0.75pt + rgb("#f15d22"))
      )
    ]
    if body != none [
      #body
    ]
  } else {
    block(width: 100%, breakable: false, sticky: true, above: 14.50pt, below: 5.00pt)[
      #text(font: neuzeit, size: 8.8pt, fill: rgb("#f15d22"), tracking: 0.060em, weight: "bold")[#title]
    ]
    if body != none [
      #body
    ]
  }
}

// ------------------------------------------------------------------------------
// regulation-page(): ENTORNO BASE DE PÁGINA INTERIOR DE REGLAMENTO
// Variante semántica de interior-page() [EXPERIMENTAL / NOT LOCKED]
// ------------------------------------------------------------------------------
#let regulation-page(
  cfg,
  variant: "A",
  reg_name: "ASAMBLEA DE FAMILIA",
  body
) = {
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

  // Spacing entre párrafos ordinarios según variante
  let par_space = if variant == "C" { 10.50pt } else { 12.72949pt }

  set page(
    width: 396pt,
    height: 612pt,
    margin: (
      inside: 58.74pt,   // Lomo: 58.74pt
      outside: 22.70pt,  // Corte: 22.70pt
      top: 71.0079pt,    // Consolidado +6 mm
      bottom: 65.00pt
    ),
    header: context [
      #let p = counter(page).get().first()
      #let is_recto = calc.odd(p)
      #regulation-running-header(cfg, reg_name: reg_name, variant: variant, is_recto: is_recto)
    ],
    footer: context [
      #let p = counter(page).get().first()
      #let is_recto = calc.odd(p)
      #regulation-footer(p, is_recto: is_recto)
    ],
    background: context [
      #let p = counter(page).get().first()
      #let is_recto = calc.odd(p)
      #regulation-spine-rule(is_recto: is_recto)
    ]
  )

  set text(
    font: neuzeit,
    size: 7.9077pt,
    fill: rgb("#2e2f31"),
    tracking: 0em,
    hyphenate: false
  )

  set par(
    leading: 12.72949pt,
    justify: true,
    spacing: par_space,
    linebreaks: "simple"
  )

  body
}
