// ==============================================================================
// ÍNDICE DE TEMAS Y ANEXOS DEFINITIVO [FASE 4.8]
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Estructura jerárquica real 1:1 derivada de capitulos/*.md:
// - Niveles 1, 2, 3 (y 4) de Capítulos 01–09
// - Secciones y Capítulos de Reglamentos de Órganos de Gobierno
// - Catálogo canónico de Anexos y Formatos Operativos
// Todas las páginas se resuelven dinámicamente mediante context query.
// ==============================================================================

#let fmt-p(p) = {
  if p == none { "—" }
  else if p < 10 { "0" + str(p) }
  else { str(p) }
}

#let leader-dots = box(width: 1fr, baseline: -20%)[
  #repeat[#text(fill: rgb("#cbd5e1"), size: 6.0pt)[ #h(1.2pt).#h(1.2pt) ]]
]

#let chapter-titles-canonical = (
  "1": "Declaración de Principios Familiares y Visión Intergeneracional",
  "2": "Propiedad Accionaria, Control Familiar y Liquidez Patrimonial",
  "3": "Gobierno Corporativo Familiar, Institucionalización y Régimen de Profesionalización",
  "4": "Régimen de Sucesión Familiar Empresarial",
  "5": "Control Institucional de la Información y Comunicación Familiar–Empresarial",
  "6": "Régimen de Disciplina Financiera Familiar–Empresarial",
  "7": "Procedimiento Sancionador y Régimen de Sanciones Internas",
  "8": "Medios Alternativos de Solución de Conflictos Familiares–Empresariales",
  "9": "Régimen Jurídico del Protocolo Familiar",
)

#let render-indice-temas-y-anexos(cfg) = context {
  let minion = ("Minion Pro", "Georgia")
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

  // Consultas dinámicas al documento
  let all-headings = query(heading)
  let ch-openings = query(selector(<chapter-opening-marker>))
  let reg-chapters = query(selector(<reg-chapter-marker>))
  let reg-transitories = query(selector(<reg-transitory-marker>))

  // Función interna para renderizar una línea del índice
  let render-row(num-str, title-content, page-val, level: 1, extra-above: 0pt, is-major: false) = {
    let indent = if level == 1 { 0pt }
                 else if level == 2 { 10pt }
                 else if level == 3 { 20pt }
                 else { 30pt }

    let (font-f, sz, wt, col, p-col, p-wt) = if is-major {
      (minion, 8.8pt, "bold", rgb("#f15d22"), rgb("#f15d22"), "bold")
    } else if level == 1 {
      (minion, 8.0pt, "bold", rgb("#0f172a"), rgb("#f15d22"), "bold")
    } else if level == 2 {
      (neuzeit, 7.3pt, "medium", rgb("#1e293b"), rgb("#1e293b"), "medium")
    } else if level == 3 {
      (neuzeit, 6.8pt, "regular", rgb("#334155"), rgb("#475569"), "regular")
    } else {
      (neuzeit, 6.6pt, "regular", rgb("#475569"), rgb("#64748b"), "regular")
    }

    let sp-above = if extra-above > 0pt { extra-above }
                   else if is-major { 14pt }
                   else if level == 1 { 7.5pt }
                   else if level == 2 { 3.5pt }
                   else if level == 3 { 2.0pt }
                   else { 1.5pt }

    let num-col = if level == 1 { rgb("#f15d22") }
                  else if level == 2 { rgb("#f15d22") }
                  else { rgb("#64748b") }

    block(width: 100%, inset: (left: indent), above: sp-above, below: 1.5pt, breakable: false)[
      #set text(font: font-f, size: sz)
      #set par(leading: 3.5pt, justify: false)
      #if num-str != "" [
        #text(weight: wt, fill: num-col)[#num-str]#h(4pt)
      ]
      #text(weight: wt, fill: col)[#title-content]
      #h(4pt)#leader-dots#h(4pt)
      #text(font: minion, size: 7.2pt, weight: p-wt, fill: p-col)[#fmt-p(page-val)]
    ]
  }

  // Header institucional de apertura
  place(top + left, dx: 0pt, dy: 0pt)[
    #text(font: neuzeit, size: 7.9077pt, fill: rgb("#f15d22"), tracking: 0.140em, weight: "regular")[ÍNDICE DE]
    #v(3pt)
    #text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[TEMAS Y ANEXOS]
    #v(4pt)
    #rect(width: 14.189pt, height: 0.902pt, fill: rgb("#f15d22"), stroke: none)
    #v(10pt)
  ]

  v(62pt)

  // ----------------------------------------------------------------------------
  // PARTE 1: CAPÍTULOS SUSTANTIVOS 01 A 09
  // ----------------------------------------------------------------------------
  let cur-ch = 0
  for h in all-headings {
    let nums = counter(heading).at(h.location())
    let ch-num = nums.first()

    // Si pasamos a un nuevo capítulo, emitir el encabezado de Nivel 1 del capítulo
    if ch-num != cur-ch {
      cur-ch = ch-num
      let ch-str = str(cur-ch)
      let ch-title = chapter-titles-canonical.at(ch-str, default: "")
      let ch-page = if ch-openings.len() >= cur-ch {
        ch-openings.at(cur-ch - 1).location().page()
      } else {
        h.location().page()
      }

      render-row(
        ch-str + ".",
        upper(ch-title),
        ch-page,
        level: 1,
        extra-above: if cur-ch == 1 { 0pt } else { 9.5pt }
      )
    }

    // Encabezados internos del capítulo: Nivel 2, 3 o 4
    let num-display = nums.map(str).join(".")
    let lvl = h.level
    let p-val = h.location().page()

    render-row(
      num-display,
      h.body,
      p-val,
      level: lvl
    )
  }

  // ----------------------------------------------------------------------------
  // PARTE 2: REGLAMENTOS DE ÓRGANOS DE GOBIERNO
  // ----------------------------------------------------------------------------
  v(12pt)
  let reg-start-page = query(selector(<reglamentos-start>)).first().location().page()
  render-row("", "REGLAMENTOS DE ÓRGANOS DE GOBIERNO", reg-start-page, is-major: true, extra-above: 14pt)

  // 2.1 Reglamento de la Asamblea de Familia
  let asamb-start-page = query(selector(<reg-asamblea-start>)).first().location().page()
  render-row("1.", "Reglamento de la Asamblea de Familia", asamb-start-page, level: 1, extra-above: 8pt)

  // Capítulos de Asamblea (índices 0 a 7 en reg-chapters)
  if reg-chapters.len() >= 8 {
    for i in range(0, 8) {
      let m = reg-chapters.at(i)
      let r-title = m.value.roman + ". " + m.value.title
      render-row("", r-title, m.location().page(), level: 2)
    }
  }
  if reg-transitories.len() >= 1 {
    let t = reg-transitories.at(0)
    render-row("", "ARTÍCULOS TRANSITORIOS (" + t.value.title + ")", t.location().page(), level: 2)
  }

  // 2.2 Reglamento del Consejo de Familia
  let cons-start-page = query(selector(<reg-consejo-start>)).first().location().page()
  render-row("2.", "Reglamento del Consejo de Familia", cons-start-page, level: 1, extra-above: 8pt)

  // Capítulos de Consejo (índices 8 a 16 en reg-chapters)
  if reg-chapters.len() >= 17 {
    for i in range(8, 17) {
      let m = reg-chapters.at(i)
      let r-title = m.value.roman + ". " + m.value.title
      render-row("", r-title, m.location().page(), level: 2)
    }
  }
  if reg-transitories.len() >= 2 {
    let t = reg-transitories.at(1)
    render-row("", "ARTÍCULOS TRANSITORIOS (" + t.value.title + ")", t.location().page(), level: 2)
  }

  // 2.3 Reglamento del Comité de Honor Familiar
  let com-start-page = query(selector(<reg-comite-start>)).first().location().page()
  render-row("3.", "Reglamento del Comité de Honor Familiar", com-start-page, level: 1, extra-above: 8pt)

  // Capítulos de Comité (índices 17 a 25 en reg-chapters)
  if reg-chapters.len() >= 26 {
    for i in range(17, 26) {
      let m = reg-chapters.at(i)
      let r-title = m.value.roman + ". " + m.value.title
      render-row("", r-title, m.location().page(), level: 2)
    }
  }
  if reg-transitories.len() >= 3 {
    let t = reg-transitories.at(2)
    render-row("", "ARTÍCULOS TRANSITORIOS (" + t.value.title + ")", t.location().page(), level: 2)
  }

  // ----------------------------------------------------------------------------
  // PARTE 3: ANEXOS Y FORMATOS OPERATIVOS
  // ----------------------------------------------------------------------------
  v(12pt)
  let anx-start-page = query(selector(<anexos-start>)).first().location().page()
  render-row("", "ANEXOS Y FORMATOS OPERATIVOS", anx-start-page, is-major: true, extra-above: 14pt)

  let anx-catalog = (
    ("Aviso de Exclusividad y Personalización", <aviso-start>),
    ("Carta de Aceptación y Adhesión al Protocolo Familiar", <carta-start>),
    ("Convocatoria de Asamblea de Familia", <conv-asamblea-start>),
    ("Acta de Asamblea General Familiar", <acta-asamblea-start>),
    ("Convocatoria a Sesión de Consejo de Familia", <conv-consejo-start>),
    ("Acta de Sesión del Consejo de Familia", <acta-consejo-start>),
    ("Acta de Constitución y Sesión del Comité de Honor Familiar", <acta-comite-start>),
  )

  for (name, lbl) in anx-catalog {
    let matches = query(selector(lbl))
    let p-val = if matches.len() > 0 { matches.first().location().page() } else { none }
    render-row("", name, p-val, level: 2)
  }
}
