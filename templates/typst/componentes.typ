// ==============================================================================
// SISTEMA DE COMPONENTES EDITORIALES REUTILIZABLES — TYPST
// Proyecto: Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Este módulo define los 16 componentes maestros del sistema editorial.
// Ningún archivo de contenido ni prueba debe requerir maquetación manual.
// ==============================================================================

// Helper para convertir strings con unidades a longitudes de Typst
#let to-len(val) = {
  if type(val) == length or type(val) == relative {
    val
  } else if type(val) == str {
    eval(val)
  } else {
    val
  }
}

// ------------------------------------------------------------------------------
// 1. CONFIGURACIÓN GLOBAL Y SHOW RULES (setup-protocolo)
// ------------------------------------------------------------------------------
#let setup-protocolo(cfg, body) = {
  let meta = cfg.metadata
  let pg = cfg.page
  let typo = cfg.typography
  let cols = cfg.colors
  let lns = cfg.lines
  let par_cfg = cfg.paragraphs
  let h_cfg = cfg.headings

  // Metadatos del documento PDF
  set document(
    title: meta.title + " — " + meta.brand,
    author: meta.family
  )

  // Configuración de página con doble faz (páginas enfrentadas)
  set page(
    width: to-len(pg.width),
    height: to-len(pg.height),
    margin: (
      top: to-len(pg.margins.top),
      bottom: to-len(pg.margins.bottom),
      inside: to-len(pg.margins.inside),   // Lomo / encuadernación (izq en impar, der en par)
      outside: to-len(pg.margins.outside)  // Corte / exterior (der en impar, izq en par)
    ),
    header: context {
      let p = counter(page).get().first()
      // Omitir en portada (pág 1), en páginas blancas sin contenido, o cuando la página contiene apertura de capítulo (H1)
      let h1_on_page = query(heading.where(level: 1)).filter(h => h.location().page() == p)
      let has_content = query(selector.or(heading, par, table, <signature-marker>, <annex-marker>)).filter(it => it.location().page() == p).len() > 0
      if p > 1 and has_content and h1_on_page.len() == 0 {
        let prev_headings = query(heading.where(level: 1)).filter(h => h.location().page() <= p)
        let chapter_title = if prev_headings.len() > 0 { prev_headings.last().body } else { [] }
        
        let header_style(content) = text(
          size: to-len(typo.sizes.header_text),
          fill: rgb(cols.text_muted),
          weight: "regular"
        )[#content]

        if calc.even(p) {
          // PÁGINA VERSO (Par / Izquierda): Folio/Título hacia el exterior (izquierda)
          align(left)[#header_style(cfg.headers_footers.header.verso)]
        } else {
          // PÁGINA RECTO (Impar / Derecha): Título de capítulo activo hacia el exterior (derecha)
          align(right)[#header_style(chapter_title)]
        }
      }
    },
    footer: context {
      let p = counter(page).get().first()
      let has_content = query(selector.or(heading, par, table, <signature-marker>, <annex-marker>)).filter(it => it.location().page() == p).len() > 0
      // Omitir en portada y en páginas blancas de respeto
      if p > 1 and has_content {
        let folio_style(num) = text(
          size: to-len(typo.sizes.folio),
          fill: rgb(cols.text_muted),
          weight: "medium"
        )[#num]

        let content = if calc.even(p) {
          // VERSO: Folio al exterior izquierdo
          align(left)[#folio_style(p)]
        } else {
          // RECTO: Folio al exterior derecho
          align(right)[#folio_style(p)]
        }

        if cfg.headers_footers.footer.show_border {
          line(length: 100%, stroke: to-len(lns.footer_rule_width) + rgb(cols.border))
          v(2pt)
          content
        } else {
          content
        }
      }
    }
  )

  // Configuración tipográfica base
  set text(
    font: ("Segoe UI", "Arial"),
    size: to-len(typo.sizes.body),
    lang: par_cfg.language,
    fill: rgb(cols.text_main),
    spacing: 100%
  )

  // Configuración de párrafos e interlineado
  set par(
    justify: par_cfg.justify,
    leading: to-len(typo.leading),
    linebreaks: "optimized"
  )

  // Reglas de títulos jerárquicos (H1 - H4)
  // Control editorial: sticky evita títulos huérfanos al pie de página
  show heading.where(level: 1): it => block(width: 100%, breakable: false, sticky: true)[
    #v(to-len(h_cfg.h1.space_above))
    #text(
      size: to-len(typo.sizes.h1),
      fill: rgb(cols.primary),
      weight: "bold"
    )[#it.body]
    #if h_cfg.h1.line_rule_below [
      #v(3pt)
      #line(length: 100%, stroke: to-len(lns.h1_rule_width) + rgb(cols.accent))
    ]
    #v(to-len(h_cfg.h1.space_below))
  ]

  show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true)[
    #v(to-len(h_cfg.h2.space_above))
    #text(
      size: to-len(typo.sizes.h2),
      fill: rgb(cols.secondary),
      weight: "bold"
    )[#it.body]
    #v(to-len(h_cfg.h2.space_below))
  ]

  show heading.where(level: 3): it => block(width: 100%, breakable: false, sticky: true)[
    #v(to-len(h_cfg.h3.space_above))
    #text(
      size: to-len(typo.sizes.h3),
      fill: rgb(cols.accent),
      weight: "bold"
    )[#it.body]
    #v(to-len(h_cfg.h3.space_below))
  ]

  show heading.where(level: 4): it => block(width: 100%, breakable: false, sticky: true)[
    #v(to-len(h_cfg.h4.space_above))
    #text(
      size: to-len(typo.sizes.h4),
      fill: rgb(cols.secondary),
      weight: "bold"
    )[#it.body]
    #v(to-len(h_cfg.h4.space_below))
  ]

  body
}

// ------------------------------------------------------------------------------
// 2. PORTADA GENERAL (cover-page) [APPROVED / LOCKED]
// Estado: Bloqueado formalmente en Fase 3.2. Prohibida su modificación directa o indirecta.
// ------------------------------------------------------------------------------
#let cover-page(cfg) = {
  let c = cfg.cover
  let minion = (c.title.font, c.title.fallback_font)
  let neuzeit = (c.motto.font, c.motto.fallback_font)

  // 1. Fondo vectorial corporativo (fondo crema, líneas, círculos de profundidad,
  // corte diagonal con sombras, logotipo POLIFLEX, filetes horizontales y puntos naranjas)
  place(top + left, dx: 0pt, dy: 0pt, image(c.assets.background_vector, width: to-len(c.page.width), height: to-len(c.page.height)))

  // 2. Título central: PROTOCOLO FAMILIAR
  // Medidas Illustrator: Minion Pro Medium Display, 33.4913 pt, Leading: 33 pt, Tracking: 19 (0.019em), Color: #2e2f31
  place(
    top + left,
    dx: 0pt,
    dy: to-len(c.title.dy_line1),
    block(width: to-len(c.page.width))[
      #align(center)[
        #text(
          font: minion,
          size: to-len(c.title.size),
          fill: rgb(c.title.color),
          tracking: eval(c.title.tracking),
          weight: "medium"
        )[#c.title.text_line1]
      ]
    ]
  )

  place(
    top + left,
    dx: 0pt,
    dy: to-len(c.title.dy_line2),
    block(width: to-len(c.page.width))[
      #align(center)[
        #text(
          font: minion,
          size: to-len(c.title.size),
          fill: rgb(c.title.color),
          tracking: eval(c.title.tracking),
          weight: "medium"
        )[#c.title.text_line2]
      ]
    ]
  )

  // 3. Lema principal: VISIÓN · UNIDAD · LEGADO
  // Medidas Illustrator: Neuzeit Grotesk Regular, 7.9077 pt, Tracking: 371 (0.371em), Color: #2e2f31
  // Los puntos separadores naranjas vectoriales ya residen en el fondo en x=165.25 y x=227.42
  place(top + left, dx: to-len(c.motto.x_word1), dy: to-len(c.motto.dy))[
    #text(font: neuzeit, size: to-len(c.motto.size), fill: rgb(c.motto.color), tracking: eval(c.motto.tracking))[#c.motto.word1]
  ]
  place(top + left, dx: to-len(c.motto.x_word2), dy: to-len(c.motto.dy))[
    #text(font: neuzeit, size: to-len(c.motto.size), fill: rgb(c.motto.color), tracking: eval(c.motto.tracking))[#c.motto.word2]
  ]
  place(top + left, dx: to-len(c.motto.x_word3), dy: to-len(c.motto.dy))[
    #text(font: neuzeit, size: to-len(c.motto.size), fill: rgb(c.motto.color), tracking: eval(c.motto.tracking))[#c.motto.word3]
  ]

  // 4. Frase inferior izquierda: UN FUTURO QUE CONSTRUIMOS JUNTOS.
  // Medidas Illustrator: Neuzeit Grotesk Regular, 4.8234 pt, Tracking: 371 (0.371em)
  // Base: #6c6b67. Destacado: #f15e22, Stroke: 0.2 pt #f15e22
  place(top + left, dx: to-len(c.footer_phrase.x), dy: to-len(c.footer_phrase.dy))[#text(font: neuzeit, size: to-len(c.footer_phrase.size), fill: rgb(c.footer_phrase.color_base), tracking: eval(c.footer_phrase.tracking))[#c.footer_phrase.text_base]#text(font: neuzeit, size: to-len(c.footer_phrase.size), fill: rgb(c.footer_phrase.color_highlight), tracking: eval(c.footer_phrase.tracking), stroke: to-len(c.footer_phrase.stroke_highlight) + rgb(c.footer_phrase.stroke_color))[#c.footer_phrase.text_highlight]]

  // 5. Versión: VERSION 1.0
  // Medidas Illustrator: Neuzeit Grotesk Regular, 4.8234 pt, Tracking: 371 (0.371em), Color: #f15e22, Stroke: 0.2 pt
  place(top + left, dx: to-len(c.version.x), dy: to-len(c.version.dy))[
    #text(font: neuzeit, size: to-len(c.version.size), fill: rgb(c.version.color), tracking: eval(c.version.tracking), stroke: to-len(c.version.stroke) + rgb(c.version.stroke_color))[#c.version.text]
  ]

  // 6. Fecha: AGOSTO 2026
  // Medidas Illustrator: Neuzeit Grotesk Regular, 4.8234 pt, Tracking: 371 (0.371em), Color: #6c6b67
  place(top + left, dx: to-len(c.date.x), dy: to-len(c.date.dy))[
    #text(font: neuzeit, size: to-len(c.date.size), fill: rgb(c.date.color), tracking: eval(c.date.tracking))[#c.date.text]
  ]

  pagebreak()
}

// ------------------------------------------------------------------------------
// 3. TABLA DE CONTENIDOS (table-of-contents) [APPROVED / LOCKED]
// Estado: Bloqueado formalmente en Fase 3.3 tras validación 1:1 con Illustrator.
// Prohibida su modificación directa o indirecta en fases subsecuentes.
// Preserva modo estático ("00") para regresiones y modo dinámico para libro completo.
// ------------------------------------------------------------------------------
#let table-of-contents(cfg, chapters: none) = {
  let t = cfg.toc
  let st = t.styles
  let minion = (t.header.title.font, t.header.title.fallback_font)
  let neuzeit = (t.header.prefix.font, t.header.prefix.fallback_font)

  // 1. Header: TABLA DE
  place(top + left, dx: to-len(t.header.prefix.x), dy: to-len(t.header.prefix.dy))[
    #text(
      font: neuzeit,
      size: to-len(t.header.prefix.size),
      fill: rgb(t.header.prefix.color),
      stroke: to-len(t.header.prefix.stroke) + rgb(t.header.prefix.stroke_color),
      tracking: eval(t.header.prefix.tracking),
      weight: "regular"
    )[#t.header.prefix.text]
  ]

  // 2. Header: CONTENIDO
  place(top + left, dx: to-len(t.header.title.x), dy: to-len(t.header.title.dy))[
    #text(
      font: minion,
      size: to-len(t.header.title.size),
      fill: rgb(t.header.title.color),
      tracking: eval(t.header.title.tracking),
      weight: "medium"
    )[#t.header.title.text]
  ]

  // 3. Filete naranja (orange rule)
  place(top + left, dx: to-len(t.header.rule.x), dy: to-len(t.header.rule.y))[
    #rect(
      width: to-len(t.header.rule.width),
      height: to-len(t.header.rule.height),
      fill: rgb(t.header.rule.color),
      stroke: none
    )
  ]

  // 4. Matriz decorativa de puntos (7 columnas x 38 filas = 266 puntos)
  let dm = t.dot_matrix
  let dm_cols = dm.cols
  let dm_rows = dm.rows
  let dm_x0 = to-len(dm.x0)
  let dm_y0 = to-len(dm.y0)
  let dm_dx = to-len(dm.dx)
  let dm_dy = to-len(dm.dy)
  let dm_r = to-len(dm.radius)
  let dm_fill = rgb(dm.color)

  for c in range(dm_cols) {
    let cx = dm_x0 + c * dm_dx
    for r in range(dm_rows) {
      let cy = dm_y0 + r * dm_dy
      place(
        top + left,
        dx: cx - dm_r,
        dy: cy - dm_r,
        circle(radius: dm_r, fill: dm_fill, stroke: none)
      )
    }
  }

  // 5. Entradas de capítulos
  // Si chapters == none, utiliza cfg.toc.chapters
  let ch_list = if chapters != none { chapters } else { t.chapters }

  for item in ch_list {
    let num_str = item.num
    let num_x = if "num_x" in item { to-len(item.num_x) } else { to-len(st.number.default_x) }
    let baseline_y = to-len(item.baseline_y)
    let dy_val = baseline_y - to-len(st.ascent_neuzeit)
    let title_val = item.title
    let page_val = item.page

    // Columna 1: Número de capítulo (01 - 09)
    place(top + left, dx: num_x, dy: dy_val)[
      #text(
        font: neuzeit,
        size: to-len(st.number.size),
        fill: rgb(st.number.color),
        stroke: to-len(st.number.stroke) + rgb(st.number.stroke_color),
        weight: "regular"
      )[#num_str]
    ]

    // Columna 2: Título de capítulo
    place(top + left, dx: to-len(st.title.x), dy: dy_val)[
      #block(width: to-len(st.title.width))[
        #set text(
          font: neuzeit,
          size: to-len(st.title.size),
          fill: rgb(st.title.color),
          weight: "regular"
        )
        #set par(leading: to-len(st.title.typst_leading), justify: false)
        #if type(title_val) == str {
          eval("[" + title_val + "]")
        } else {
          title_val
        }
      ]
    ]

    // Columna 3: Número de página (00 o número calculado dinámicamente)
    place(top + left, dx: to-len(st.page.x), dy: dy_val)[
      #text(
        font: neuzeit,
        size: to-len(st.page.size),
        fill: rgb(st.page.color),
        stroke: to-len(st.page.stroke) + rgb(st.page.stroke_color),
        tracking: eval(st.page.tracking),
        weight: "regular"
      )[#page_val]
    ]
  }

  // 6. Footer institucional
  let ftr = t.footer
  // Frase: PROTOCOLO FAMILIAR
  place(top + left, dx: to-len(ftr.phrase.x), dy: to-len(ftr.phrase.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.phrase.size),
      fill: rgb(ftr.phrase.color),
      stroke: to-len(ftr.phrase.stroke) + rgb(ftr.phrase.stroke_color),
      tracking: eval(ftr.phrase.tracking),
      weight: "regular"
    )[#ftr.phrase.text]
  ]

  // Versión: VERSION 1.0
  place(top + left, dx: to-len(ftr.version.x), dy: to-len(ftr.version.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.version.size),
      fill: rgb(ftr.version.color),
      stroke: to-len(ftr.version.stroke) + rgb(ftr.version.stroke_color),
      tracking: eval(ftr.version.tracking),
      weight: "regular"
    )[#ftr.version.text]
  ]
}

// ------------------------------------------------------------------------------
// 3.1 TABLA DE CONTENIDOS DEFINITIVA DINÁMICA (dynamic-table-of-contents) [FASE 4.8]
// Resuelve dinámicamente las páginas sin hardcodear mediante consultas context
// ------------------------------------------------------------------------------
#let dynamic-table-of-contents(cfg, definitions: none) = {
  let default_defs = (
    (
      id: <intro-start>,
      num: "—",
      title: "INTRODUCCIÓN INSTITUCIONAL",
      lines: 1,
      fallback_page: "05"
    ),
    (
      id: <chapter-01-start>,
      ch_index: 0,
      num: "01",
      title: "DECLARACIÓN DE PRINCIPIOS FAMILIARES Y \\ VISIÓN INTERGENERACIONAL",
      lines: 2,
      fallback_page: "09"
    ),
    (
      id: <chapter-02-start>,
      ch_index: 1,
      num: "02",
      title: "PROPIEDAD ACCIONARIA, CONTROL FAMILIAR Y \\ LIQUIDEZ PATRIMONIAL",
      lines: 2,
      fallback_page: "17"
    ),
    (
      id: <chapter-03-start>,
      ch_index: 2,
      num: "03",
      title: "GOBIERNO CORPORATIVO FAMILIAR, \\ INSTITUCIONALIZACIÓN Y RÉGIMEN DE \\ PROFESIONALIZACIÓN",
      lines: 3,
      fallback_page: "49"
    ),
    (
      id: <chapter-04-start>,
      ch_index: 3,
      num: "04",
      title: "RÉGIMEN DE SUCESIÓN FAMILIAR EMPRESARIAL",
      lines: 1,
      fallback_page: "69"
    ),
    (
      id: <chapter-05-start>,
      ch_index: 4,
      num: "05",
      title: "CONTROL INSTITUCIONAL DE LA INFORMACIÓN Y \\ COMUNICACIÓN FAMILIAR–EMPRESARIAL",
      lines: 2,
      fallback_page: "95"
    ),
    (
      id: <chapter-06-start>,
      ch_index: 5,
      num: "06",
      title: "RÉGIMEN DE DISCIPLINA FINANCIERA \\ FAMILIAR–EMPRESARIAL",
      lines: 2,
      fallback_page: "103"
    ),
    (
      id: <chapter-07-start>,
      ch_index: 6,
      num: "07",
      title: "PROCEDIMIENTO SANCIONADOR Y RÉGIMEN DE \\ SANCIONES INTERNAS",
      lines: 2,
      fallback_page: "111"
    ),
    (
      id: <chapter-08-start>,
      ch_index: 7,
      num: "08",
      title: "MEDIOS ALTERNATIVOS DE SOLUCIÓN DE \\ CONFLICTOS FAMILIARES–EMPRESARIALES",
      lines: 2,
      fallback_page: "119"
    ),
    (
      id: <chapter-09-start>,
      ch_index: 8,
      num: "09",
      title: "RÉGIMEN JURÍDICO DEL PROTOCOLO FAMILIAR",
      lines: 1,
      fallback_page: "127"
    ),
    (
      id: <reglamentos-start>,
      num: "10",
      title: "REGLAMENTOS DE ÓRGANOS DE GOBIERNO",
      lines: 1,
      fallback_page: "131"
    ),
    (
      id: <anexos-start>,
      num: "11",
      title: "ANEXOS Y FORMATOS OPERATIVOS",
      lines: 1,
      fallback_page: "155"
    ),
    (
      id: <indice-start>,
      num: "12",
      title: "ÍNDICE DE TEMAS Y ANEXOS",
      lines: 1,
      fallback_page: "171"
    ),
  )

  let defs = if definitions != none { definitions } else { default_defs }
  let t = cfg.toc
  let st = t.styles
  let minion = (t.header.title.font, t.header.title.fallback_font)
  let neuzeit = (t.header.prefix.font, t.header.prefix.fallback_font)

  // 1. Header: TABLA DE
  place(top + left, dx: to-len(t.header.prefix.x), dy: to-len(t.header.prefix.dy))[
    #text(
      font: neuzeit,
      size: to-len(t.header.prefix.size),
      fill: rgb(t.header.prefix.color),
      stroke: to-len(t.header.prefix.stroke) + rgb(t.header.prefix.stroke_color),
      tracking: eval(t.header.prefix.tracking),
      weight: "regular"
    )[#t.header.prefix.text]
  ]

  // 2. Header: CONTENIDO
  place(top + left, dx: to-len(t.header.title.x), dy: to-len(t.header.title.dy))[
    #text(
      font: minion,
      size: to-len(t.header.title.size),
      fill: rgb(t.header.title.color),
      tracking: eval(t.header.title.tracking),
      weight: "medium"
    )[#t.header.title.text]
  ]

  // 3. Filete naranja (orange rule)
  place(top + left, dx: to-len(t.header.rule.x), dy: to-len(t.header.rule.y))[
    #rect(
      width: to-len(t.header.rule.width),
      height: to-len(t.header.rule.height),
      fill: rgb(t.header.rule.color),
      stroke: none
    )
  ]

  // 4. Matriz decorativa de puntos (7 columnas x 38 filas = 266 puntos)
  let dm = t.dot_matrix
  let dm_cols = dm.cols
  let dm_rows = dm.rows
  let dm_x0 = to-len(dm.x0)
  let dm_y0 = to-len(dm.y0)
  let dm_dx = to-len(dm.dx)
  let dm_dy = to-len(dm.dy)
  let dm_r = to-len(dm.radius)
  let dm_fill = rgb(dm.color)

  for c in range(dm_cols) {
    let cx = dm_x0 + c * dm_dx
    for r in range(dm_rows) {
      let cy = dm_y0 + r * dm_dy
      place(
        top + left,
        dx: cx - dm_r,
        dy: cy - dm_r,
        circle(radius: dm_r, fill: dm_fill, stroke: none)
      )
    }
  }

  // 5. Entradas dinámicas calculadas contextualmente
  context {
    let start_y = 86.0pt
    let line_step = 12.0pt
    let gap = 14.0pt
    let ascent = to-len(st.ascent_neuzeit)

    let curr_y = start_y

    for item in defs {
      let baseline_y = curr_y
      let dy_val = baseline_y - ascent

      // Consulta de página en tiempo real
      let q = query(item.id)
      let page_str = if q.len() > 0 {
        let p = q.first().location().page()
        if p < 10 { "0" + str(p) } else { str(p) }
      } else if "ch_index" in item {
        let q_ch = query(selector(<chapter-opening-marker>))
        if q_ch.len() > item.ch_index {
          let p = q_ch.at(item.ch_index).location().page()
          if p < 10 { "0" + str(p) } else { str(p) }
        } else {
          item.fallback_page
        }
      } else {
        item.fallback_page
      }

      // Columna 1: Número o distintivo
      let num_color = if item.num == "—" { rgb("#94a3b8") } else { rgb(st.number.color) }
      place(top + left, dx: to-len(st.number.default_x), dy: dy_val)[
        #text(
          font: neuzeit,
          size: to-len(st.number.size),
          fill: num_color,
          stroke: if item.num == "—" { none } else { to-len(st.number.stroke) + rgb(st.number.stroke_color) },
          weight: "regular"
        )[#item.num]
      ]

      // Columna 2: Título institucional
      place(top + left, dx: to-len(st.title.x), dy: dy_val)[
        #block(width: to-len(st.title.width))[
          #set text(
            font: neuzeit,
            size: to-len(st.title.size),
            fill: rgb(st.title.color),
            weight: "regular"
          )
          #set par(leading: to-len(st.title.typst_leading), justify: false)
          #if type(item.title) == str {
            eval("[" + item.title + "]")
          } else {
            item.title
          }
        ]
      ]

      // Columna 3: Número de página dinámico
      place(top + left, dx: to-len(st.page.x), dy: dy_val)[
        #text(
          font: neuzeit,
          size: to-len(st.page.size),
          fill: rgb(st.page.color),
          stroke: to-len(st.page.stroke) + rgb(st.page.stroke_color),
          tracking: eval(st.page.tracking),
          weight: "regular"
        )[#page_str]
      ]

      // Avance vertical para el siguiente elemento
      let block_height = (item.lines - 1) * line_step
      curr_y = curr_y + block_height + gap + 10.0pt
    }
  }

  // 6. Footer institucional
  let ftr = t.footer
  place(top + left, dx: to-len(ftr.phrase.x), dy: to-len(ftr.phrase.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.phrase.size),
      fill: rgb(ftr.phrase.color),
      stroke: to-len(ftr.phrase.stroke) + rgb(ftr.phrase.stroke_color),
      tracking: eval(ftr.phrase.tracking),
      weight: "regular"
    )[#ftr.phrase.text]
  ]

  place(top + left, dx: to-len(ftr.version.x), dy: to-len(ftr.version.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.version.size),
      fill: rgb(ftr.version.color),
      stroke: to-len(ftr.version.stroke) + rgb(ftr.version.stroke_color),
      tracking: eval(ftr.version.tracking),
      weight: "regular"
    )[#ftr.version.text]
  ]
}



// ------------------------------------------------------------------------------
// 4. APERTURA DE CAPÍTULO (chapter-opening)
// Fidelidad 1:1 con Illustrator / referencias/03 portada capitulos.pdf
// Modular, dinámico y calibrado con precisión submilimétrica.
// ------------------------------------------------------------------------------
#let chapter-opening(
  arg1,
  number: none,
  title: none,
  opening_title: none,
  description: none,
  subtitle: none,
  label: none,
  cfg: none,
  is_recto: false
) = {
  // Determinar si arg1 es la configuración o un título legado
  let c = if type(arg1) == dictionary { arg1 } else if cfg != none { cfg } else { none }
  let co = if c != none and "chapter_opening" in c { c.chapter_opening } else { none }

  // Fallback para llamadas de fase previa sin configuración centralizada
  if co == none {
    let t_str = if opening_title != none {
      opening_title
    } else if title != none {
      title
    } else if type(arg1) == dictionary {
      ""
    } else {
      arg1
    }
    let s_str = if description != none { description } else { subtitle }
    if is_recto { pagebreak(to: "odd") }
    if label != none [ #text(size: 10pt, fill: rgb("#64748b"), weight: "bold")[#upper(label)] \ ]
    heading(level: 1)[#t_str]
    if s_str != none [ #text(size: 10pt, fill: rgb("#475569"), style: "italic")[#s_str] ]
    return
  }

  // Resolver número, título y descripción dinámicos
  let num_val = if number != none {
    number
  } else if type(arg1) == dictionary and "default_chapter" in co {
    co.default_chapter.num
  } else {
    "01"
  }

  let num_str = if type(num_val) == int {
    if num_val < 10 { "0" + str(num_val) } else { str(num_val) }
  } else {
    str(num_val)
  }

  let raw_title = if opening_title != none {
    opening_title
  } else if title != none {
    title
  } else if type(arg1) != dictionary and type(arg1) != none {
    arg1
  } else if "default_chapter" in co {
    co.default_chapter.title
  } else {
    ""
  }

  let title_val = if type(raw_title) == array {
    eval("[" + raw_title.join(" \\ ") + "]")
  } else if type(raw_title) == str {
    eval("[" + raw_title + "]")
  } else {
    raw_title
  }

  let raw_desc = if description != none {
    description
  } else if subtitle != none {
    subtitle
  } else if type(arg1) == dictionary and "default_chapter" in co {
    co.default_chapter.description
  } else {
    none
  }

  let desc_val = if type(raw_desc) == array {
    eval("[" + raw_desc.join(" \\ ") + "]")
  } else if type(raw_desc) == str {
    eval("[" + raw_desc + "]")
  } else {
    raw_desc
  }

  let minion = (co.number.font, co.number.fallback_font)
  let neuzeit = (co.description.font, co.description.fallback_font)

  // Salto a página impar si se requiere en contexto de libro completo
  if is_recto {
    pagebreak(to: "odd")
  }

  // 1. Fondo vectorial corporativo (fondo crema, retícula de 371 puntos, plano diagonal,
  // 2 Form XObjects de sombras suaves, logotipo POLIFLEX y filete naranja horizontal)
  place(
    top + left,
    dx: 0pt,
    dy: 0pt,
    image(co.assets.background_vector, width: to-len(co.page.width), height: to-len(co.page.height))
  )

  // 2. Número de capítulo ("01", "02", etc.)
  // Medidas Illustrator: Minion Pro Medium Display, 39.3657 pt, Tracking: -50 (-0.050em), Color: #f15d22
  place(
    top + left,
    dx: to-len(co.number.x),
    dy: to-len(co.number.dy)
  )[
    #text(
      font: minion,
      size: to-len(co.number.size),
      fill: rgb(co.number.color),
      tracking: eval(co.number.tracking),
      weight: "medium"
    )[#num_str]
  ]

  // 3. Título de capítulo y 4. Descripción dinámica
  // El título conserva su posición inicial fija calibrada (dy = 412.3005pt / baseline 422.7119pt).
  // La descripción se posiciona dinámicamente según la última línea real del título,
  // conservando exactamente la separación baseline-to-baseline de 25.6729pt del capítulo 01.
  context {
    let title_block = block(width: to-len(co.title.width))[
      #set text(
        font: minion,
        size: to-len(co.title.size),
        fill: rgb(co.title.color),
        tracking: eval(co.title.tracking),
        weight: "medium"
      )
      #set par(leading: to-len(co.title.typst_leading), justify: false)
      #if type(title_val) == str {
        eval("[" + title_val + "]")
      } else {
        title_val
      }
    ]

    // Medición de altura real del título y cálculo de líneas
    let m = measure(title_block)
    let n_lines = calc.round((m.height.pt() - 10.41) / 24.0) + 1
    let last_title_baseline = 422.7119pt + (n_lines - 1) * 24.0053pt
    let desc_baseline_sep = 25.6729pt
    let desc_first_baseline = last_title_baseline + desc_baseline_sep
    let desc_ascent = 5.2705pt
    let desc_dy = desc_first_baseline - desc_ascent

    // Renderizar título
    place(
      top + left,
      dx: to-len(co.title.x),
      dy: to-len(co.title.dy)
    )[#title_block]

    // Renderizar descripción con dy dinámico
    if desc_val != none and desc_val != "" {
      place(
        top + left,
        dx: to-len(co.description.x),
        dy: desc_dy
      )[
        #block(width: to-len(co.description.width))[
          #set text(
            font: neuzeit,
            size: to-len(co.description.size),
            fill: rgb(co.description.color),
            tracking: eval(co.description.tracking),
            weight: "regular"
          )
          #set par(leading: to-len(co.description.typst_leading), justify: false)
          #if type(desc_val) == str {
            eval("[" + desc_val + "]")
          } else {
            desc_val
          }
        ]
      ]
    }
  }

  // 5. Footer institucional
  let ftr = co.footer
  // Frase: PROTOCOLO FAMILIAR
  place(top + left, dx: to-len(ftr.phrase.x), dy: to-len(ftr.phrase.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.phrase.size),
      fill: rgb(ftr.phrase.color),
      stroke: to-len(ftr.phrase.stroke) + rgb(ftr.phrase.stroke_color),
      tracking: eval(ftr.phrase.tracking),
      weight: "regular"
    )[#ftr.phrase.text]
  ]

  // Versión: VERSION 1.0
  place(top + left, dx: to-len(ftr.version.x), dy: to-len(ftr.version.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.version.size),
      fill: rgb(ftr.version.color),
      stroke: to-len(ftr.version.stroke) + rgb(ftr.version.stroke_color),
      tracking: eval(ftr.version.tracking),
      weight: "regular"
    )[#ftr.version.text]
  ]
}

// ------------------------------------------------------------------------------
// 5. APERTURA DE ANEXOS / FORMATOS OPERATIVOS (annex-opening)
// Consistente con chapter-opening() y regulation-opening().
// Soporta firma institucional moderna con cfg o firma legada.
// ------------------------------------------------------------------------------
#let annex-opening(
  arg1,
  title: none,
  subtitle: none,
  opening_title: none,
  upper_label: "ANEXOS",
  description: none,
  show_blank_verso: false,
  is_recto: false,
  cfg: none
) = {
  let c = if type(arg1) == dictionary { arg1 } else if cfg != none { cfg } else { none }
  let co = if c != none and "chapter_opening" in c { c.chapter_opening } else { none }

  if co == none {
    // Fallback legado para llamadas previas sin configuración centralizada
    let code_str = if type(arg1) == str { arg1 } else { "ANEXO" }
    let t_str = if title != none { title } else { "" }
    let s_str = if subtitle != none { subtitle } else { description }
    if is_recto { pagebreak(to: "odd") }
    block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: (left: 3pt + rgb("#0284c7")),
      inset: (x: 12pt, y: 10pt),
      radius: (right: 4pt)
    )[
      #text(size: 9pt, fill: rgb("#0284c7"), weight: "bold")[#upper(code_str)]
      #v(2pt)
      #text(size: 13pt, fill: rgb("#0f172a"), weight: "bold")[#t_str]
      #if s_str != none [
        #v(2pt)
        #text(size: 9.5pt, fill: rgb("#64748b"))[#s_str]
      ]
    ]
    [#metadata((type: "annex", code: code_str, title: t_str)) <annex-marker>]
    heading(level: 1, outlined: true)[#code_str: #t_str]
    v(12pt)
    return
  }

  // 1. Verso en blanco ceremonial previo si se requiere
  if show_blank_verso {
    page(
      width: to-len(co.page.width),
      height: to-len(co.page.height),
      margin: 0pt,
      fill: rgb("#ffffff"),
      header: none,
      footer: none
    )[]
  }

  // 2. Salto ceremonial a página impar (Recto)
  if is_recto {
    pagebreak(to: "odd")
  }

  let minion = (co.number.font, co.number.fallback_font)
  let neuzeit = (co.description.font, co.description.fallback_font)

  // 3. Fondo vectorial corporativo institucional
  place(
    top + left,
    dx: 0pt,
    dy: 0pt,
    image(co.assets.background_vector, width: to-len(co.page.width), height: to-len(co.page.height))
  )

  // 4. Identificador superior ceremonial: "ANEXOS"
  // dy = 352.0000 pt (baseline = 365.0200 pt, luz libre a regla = 18.4740 pt)
  place(
    top + left,
    dx: to-len(co.number.x),
    dy: 352.00pt
  )[
    #text(
      font: minion,
      size: 20.0pt,
      fill: rgb(co.number.color),
      tracking: 0.050em,
      weight: "medium"
    )[#upper(upper_label)]
  ]

  // 5. Título institucional
  let lines = if opening_title != none {
    if type(opening_title) == array { opening_title } else { (opening_title,) }
  } else if title != none {
    if type(title) == array { title } else { (title,) }
  } else {
    ("Y FORMATOS", "OPERATIVOS")
  }

  place(
    top + left,
    dx: to-len(co.title.x),
    dy: to-len(co.title.dy)
  )[
    #block(width: to-len(co.title.width))[
      #set text(
        font: minion,
        size: to-len(co.title.size),
        fill: rgb(co.title.color),
        tracking: eval(co.title.tracking),
        weight: "medium"
      )
      #set par(leading: to-len(co.title.typst_leading), justify: false)
      #lines.map(l => upper(str(l))).join([\ ])
    ]
  ]

  // 6. Descripción institucional
  let desc = if description != none {
    description
  } else if subtitle != none {
    subtitle
  } else {
    [Formatos de gobierno, convocatorias institucionales, actas de asamblea \ y cartas de adhesión para la ejecución formal del Protocolo Familiar.]
  }

  if desc != none {
    place(
      top + left,
      dx: to-len(co.description.x),
      dy: to-len(co.description.dy)
    )[
      #block(width: to-len(co.description.width))[
        #set text(
          font: neuzeit,
          size: to-len(co.description.size),
          fill: rgb(co.description.color),
          weight: "regular"
        )
        #set par(leading: to-len(co.description.typst_leading), justify: false)
        #desc
      ]
    ]
  }

  // 7. Footer institucional
  let ftr = co.footer
  place(top + left, dx: to-len(ftr.phrase.x), dy: to-len(ftr.phrase.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.phrase.size),
      fill: rgb(ftr.phrase.color),
      stroke: to-len(ftr.phrase.stroke) + rgb(ftr.phrase.stroke_color),
      tracking: eval(ftr.phrase.tracking),
      weight: "regular"
    )[#ftr.phrase.text]
  ]

  place(top + left, dx: to-len(ftr.version.x), dy: to-len(ftr.version.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.version.size),
      fill: rgb(ftr.version.color),
      stroke: to-len(ftr.version.stroke) + rgb(ftr.version.stroke_color),
      tracking: eval(ftr.version.tracking),
      weight: "regular"
    )[#ftr.version.text]
  ]
}


// ------------------------------------------------------------------------------
// 6. ENCABEZADOS DE SECCIÓN (section-heading H2, H3, H4)
// ------------------------------------------------------------------------------
#let section-heading(title) = heading(level: 2)[#title]
#let subsection-heading(title) = heading(level: 3)[#title]
#let subsubsection-heading(title) = heading(level: 4)[#title]

// ------------------------------------------------------------------------------
// 7. PÁRRAFO DE CUERPO (body-text)
// ------------------------------------------------------------------------------
#let body-text(content) = [
  #content
  #parbreak()
]

// ------------------------------------------------------------------------------
// 8. LISTAS JURÍDICAS ESTRUCTURADAS (legal-item)
// Conserva incisos a), sub-incisos i., fracciones I., y pasos 1.
// ------------------------------------------------------------------------------
#let legal-item(prefix, content, kind: "alpha", cfg: none) = {
  let prefix_w = if kind == "roman-upper" {
    22pt
  } else if kind == "roman-lower" {
    18pt
  } else {
    18pt
  }

  let item-grid = grid(
    columns: (prefix_w, 1fr),
    align: (left, left),
    [#text(weight: "bold")[#prefix]],
    [#content]
  )

  if kind == "roman-lower" {
    pad(left: 15pt, bottom: 4pt)[#item-grid]
  } else {
    pad(bottom: 4pt)[#item-grid]
  }
}

// ------------------------------------------------------------------------------
// 9. TABLA EDITORIAL ESTILIZADA (table-style)
// ------------------------------------------------------------------------------
#let table-style(columns: (), headers: (), rows: (), caption: none) = {
  block(width: 100%, breakable: false)[
    #if caption != none [
      #text(size: 8.5pt, weight: "bold", fill: rgb("#334155"))[#caption]
      #v(4pt)
    ]
    #align(center)[
      #table(
        columns: columns,
        fill: (col, row) => if row == 0 { rgb("#f1f5f9") } else if calc.even(row) { rgb("#f8fafc") } else { none },
        stroke: (x, y) => if y == 0 {
          (bottom: 1.2pt + rgb("#0284c7"), rest: 0.5pt + rgb("#cbd5e1"))
        } else {
          0.5pt + rgb("#cbd5e1")
        },
        align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
        table.header(..headers.map(h => [#strong[#h]])),
        ..rows.flatten()
      )
    ]
  ]
}

// ------------------------------------------------------------------------------
// 10. BLOQUE DE FIRMAS INDIVISIBLE (signature-block)
// Evita rupturas a media firma en cortes de página
// ------------------------------------------------------------------------------
#let signature-block(signers: (), date-text: none, note: none) = {
  block(width: 100%, breakable: false)[
    #metadata("signatures") <signature-marker>
    #v(20pt)
    #if note != none [
      #align(center)[#text(size: 8.5pt, fill: rgb("#64748b"), style: "italic")[#note]]
      #v(15pt)
    ]
    #grid(
      columns: (1fr, 1fr),
      row-gutter: 28pt,
      column-gutter: 20pt,
      ..signers.map(s => align(center)[
        #line(length: 135pt, stroke: 0.75pt + rgb("#0f172a"))
        #v(4pt)
        #text(size: 8.5pt, weight: "bold")[#s.name]
        #if "role" in s [
          \
          #text(size: 7.5pt, fill: rgb("#64748b"))[#s.role]
        ]
        #if "rep" in s [
          \
          #text(size: 7.5pt, fill: rgb("#64748b"), style: "italic")[#s.rep]
        ]
      ])
    )
    #if date-text != none [
      #v(15pt)
      #align(center)[#text(size: 8pt, fill: rgb("#64748b"))[#date-text]]
    ]
  ]
}

// ------------------------------------------------------------------------------
// 11. SUBSECTION HEADING DE PÁGINAS INTERIORES (interior-heading) [FASE 3.6]
// Minion Pro Medium Display 10pt, tracking 0.019em, número con trazo 0.4pt naranja
// ------------------------------------------------------------------------------
// 11. HEADINGS Y ARCOS DE PÁGINAS INTERIORES [FASE 3.6.2]
// Minion Pro Medium Display 10pt, tracking +0.019em, leading armónico 18pt
// Gap geométrico parametrizado entre número y título
// Soporta numeración dinámica automática (1.1, 1.2...) o manual
// ------------------------------------------------------------------------------
#let interior-chapter-counter = counter("interior-chapter-counter")
#let interior-section-counter = counter("interior-section-counter")

#let interior-heading(
  arg1,
  ..args
) = {
  let named = args.named()
  let pos = args.pos()

  let num_val = none
  let title_val = none

  if pos.len() > 0 {
    num_val = arg1
    title_val = pos.at(0)
  } else if "number" in named and named.number != auto {
    num_val = named.number
    title_val = arg1
  } else {
    title_val = arg1
    num_val = auto
  }

  let minion = ("Minion Pro", "Georgia")
  let v_before = if "space_before" in named and named.space_before != auto and named.space_before != none { named.space_before } else { 0pt }
  let v_after = if "space_after" in named and named.space_after != auto and named.space_after != none { named.space_after } else { 15.4200pt }
  let gap = if "gap" in named and named.gap != auto and named.gap != none { named.gap } else { 5.5pt }

  // Extraer número si el título viene como "1.1 TÍTULO"
  if type(title_val) == str and num_val == auto {
    let m = title_val.match(regex("^([0-9]+(?:\.[0-9]+)*)\s+(.*)$"))
    if m != none {
      num_val = m.captures.at(0)
      title_val = m.captures.at(1)
    }
  }

  if v_before > 0pt {
    v(v_before, weak: false)
  }

  block(width: 100%, breakable: false)[
    #if num_val != auto and num_val != none [
      #box[
        #text(
          font: minion,
          size: 10pt,
          fill: rgb("#f15d22"),
          stroke: 0.4pt + rgb("#f15d22"),
          tracking: 0.019em,
          weight: "medium"
        )[#num_val]
      ]#h(gap)#text(
        font: minion,
        size: 10pt,
        fill: rgb("#2e2f31"),
        tracking: 0.019em,
        weight: "medium"
      )[#title_val]
    ] else [
      #interior-section-counter.step()
      #context {
        let ch = interior-chapter-counter.get().first()
        let sec = interior-section-counter.get().first()
        let auto_num = str(ch) + "." + str(sec)
        box[
          #text(
            font: minion,
            size: 10pt,
            fill: rgb("#f15d22"),
            stroke: 0.4pt + rgb("#f15d22"),
            tracking: 0.019em,
            weight: "medium"
          )[#auto_num]
        ] + h(gap) + text(
          font: minion,
          size: 10pt,
          fill: rgb("#2e2f31"),
          tracking: 0.019em,
          weight: "medium"
        )[#title_val]
      }
    ]
  ]

  if v_after > 0pt {
    v(v_after)
  }
}

// ------------------------------------------------------------------------------
// 12. LISTAS ALFABÉTICAS DE PÁGINAS INTERIORES (interior-list) [FASE 3.6]
// Sangría de bloque 20pt, sin sangría francesa, paso continuo de 18pt
// ------------------------------------------------------------------------------
#let interior-list(items, cfg: none) = {
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  block(inset: (left: 20.00pt), width: 100%)[
    #set text(font: neuzeit, size: 7.9077pt, fill: rgb("#2e2f31"), tracking: 0em, hyphenate: false)
    #set par(leading: 12.72949pt, justify: true, spacing: 12.72949pt, linebreaks: "simple")
    #for item in items [
      #item
      #parbreak()
    ]
  ]
}

// ------------------------------------------------------------------------------
// 12a. ARCOS SUPERIORES UNIFICADOS (interior-arcs) [FASE 3.6.2]
// Composición única maestra basada en chapter-first-page (esquina superior derecha)
// Opacidad al 50%, sin variantes por paridad, sin espejado ni sombras
// ------------------------------------------------------------------------------
#let interior-arcs(cfg, opacity: 50%) = {
  let ip = cfg.interior_page
  let xc = to-len(ip.arcs.center_x)
  let yc = to-len(ip.arcs.center_y)
  let radii = ip.arcs.radii.map(r => to-len(r))
  let base_col = rgb(ip.arcs.color)
  let arc_stroke = to-len(ip.arcs.stroke) + rgb(base_col.components().at(0), base_col.components().at(1), base_col.components().at(2), opacity)

  for r in radii {
    place(
      top + left,
      dx: xc - r,
      dy: yc - r,
      circle(radius: r, stroke: arc_stroke, fill: none)
    )
  }
}

// ------------------------------------------------------------------------------
// 12b. ISOTIPO INSTITUCIONAL POLIFLEX (interior-isotype) [FASE 3.6.3]
// Recurso vectorial autoritativo exclusivo de /referencias/icono.svg
// Opacidad al 50% requerida en todo el sistema de páginas interiores
// ------------------------------------------------------------------------------
#let interior-isotype(
  width: 7.1186pt,
  height: 7.0000pt,
  opacity: 50%
) = {
  let raw_svg = read("/referencias/icono.svg")
  let op_val = if type(opacity) == ratio { opacity / 100% } else { float(opacity) }
  let op_str = str(op_val)
  let mod_svg = raw_svg.replace(".st0 {", ".st0 {\n        fill-opacity: " + op_str + ";").replace(".st1 {", ".st1 {\n        fill-opacity: " + op_str + ";")
  image(bytes(mod_svg), format: "svg", width: width, height: height)
}

// ------------------------------------------------------------------------------
// 12c. MARCO / BLOQUE INTERIOR CON DESPLAZAMIENTO HORIZONTAL (interior-frame) [FASE 3.6.1]
// Permite reproducir cajas de texto con desplazamiento opcional
// ------------------------------------------------------------------------------
#let interior-frame(dx: 0pt, width: auto, content) = {
  if dx != 0pt {
    move(dx: dx)[
      #block(width: if width != auto { width } else { 100% })[
        #content
      ]
    ]
  } else {
    block(width: if width != auto { width } else { 100% })[
      #content
    ]
  }
}

// ------------------------------------------------------------------------------
// 13. PÁGINAS INTERIORES RECTO / VERSO (interior-page) [FASE 3.6]
// Manejador común de páginas interiores con paridad, filete, arcos, claim y footer
// ------------------------------------------------------------------------------
#let interior-page(
  cfg,
  is_recto: auto,
  page_num: auto,
  with_shadow: false,
  arcs_opacity: 50%,
  has_arcs: false,
  has_claim: false,
  has_running_header: true,
  has_footer_institutional: false,
  content_dy: auto,
  header_decorations: none,
  chapter: auto,
  section_reset: false,
  body
) = {
  let ip = cfg.interior_page
  let neuzeit = (ip.claim.font, ip.claim.fallback_font)
  let minion = (ip.folio.font, ip.folio.fallback_font)

  // Actualizar contador de capítulo si se proporciona
  if chapter != auto and chapter != none {
    let ch_num = if type(chapter) == int { chapter } else { int(chapter) }
    interior-chapter-counter.update(ch_num)
  }
  if section_reset {
    interior-section-counter.update(0)
  }

  // Determinar paridad
  let recto_mode = if is_recto != auto {
    is_recto
  } else {
    true
  }

  let p_cfg = if recto_mode { ip.parity.recto } else { ip.parity.verso }

  // 1. Configuración de página
  set page(
    width: to-len(ip.page.width),
    height: to-len(ip.page.height),
    margin: 0pt,
    fill: rgb(ip.page.fill)
  )

  // 2. Filete vertical continuo pegado al lomo (x=30.13pt en recto, x=365.87pt en verso)
  let rule_x = to-len(p_cfg.spine_rule_x)
  place(
    top + left,
    dx: rule_x,
    dy: 0pt,
    line(start: (0pt, 0pt), end: (0pt, to-len(ip.page.height)), stroke: to-len(ip.spine_rule.stroke) + rgb(ip.spine_rule.color))
  )

  // 3. Arcos concéntricos fijos (exclusivos de chapter-first-page) [FASE 3.6.3]
  if has_arcs {
    interior-arcs(cfg, opacity: arcs_opacity)
  }

  // 4. Claim institucional superior (exclusivo de chapter-first-page) [FASE 3.6.3]
  if has_claim {
    let clm = ip.claim
    let clm_x = to-len(p_cfg.claim_x)
    let clm_ascent = to-len(clm.ascent)
    let clm_ys = clm.baselines_y.map(y => to-len(y))
    let clm_style(txt, col) = text(
      font: neuzeit,
      size: to-len(clm.size),
      fill: rgb(col),
      tracking: eval(clm.tracking),
      weight: "regular"
    )[#txt]

    // Línea 1
    place(top + left, dx: clm_x, dy: clm_ys.at(0) - clm_ascent)[
      #clm_style("UN LEGADO", clm.color_main)
    ]
    // Línea 2
    place(top + left, dx: clm_x, dy: clm_ys.at(1) - clm_ascent)[
      #clm_style("QUE TRASCIENDE,", clm.color_main)
    ]
    // Línea 3
    place(top + left, dx: clm_x, dy: clm_ys.at(2) - clm_ascent)[
      #clm_style("UN FUTURO QUE", clm.color_main)
    ]
    // Línea 4
    place(top + left, dx: clm_x, dy: clm_ys.at(3) - clm_ascent)[
      #clm_style("CONSTRUIMOS ", clm.color_main)#clm_style("JUNTOS.", clm.color_highlight)
    ]
  }

  // 4b. Running Header funcional y dinámico (exclusivo de páginas de continuación) [FASE 3.6.3]
  if has_running_header {
    let rh = if "running_header" in ip { ip.running_header } else {
      (
        font: neuzeit,
        size: 5.5pt,
        tracking: 0.200em,
        color: "#6c6b67",
        baseline_y: 35.00pt,
        ascent: 3.66pt,
        unit_gap: 8.0pt,
        isotype: (
          width: 7.1186pt,
          height: 7.0000pt,
          gap: 5.0pt,
          opacity: 50%
        )
      )
    }
    let rh_ascent = if "ascent" in rh { to-len(rh.ascent) } else { 3.66pt }
    let rh_base_y = to-len(rh.baseline_y)
    let rh_dy = rh_base_y - rh_ascent

    let iso_w = if "isotype" in rh and "width" in rh.isotype { to-len(rh.isotype.width) } else { 7.1186pt }
    let iso_h = if "isotype" in rh and "height" in rh.isotype { to-len(rh.isotype.height) } else { 7.0000pt }
    let iso_gap = if "isotype" in rh and "gap" in rh.isotype { to-len(rh.isotype.gap) } else { 5.0pt }
    let iso_op = if "isotype" in rh and "opacity" in rh.isotype {
      if type(rh.isotype.opacity) == str { eval(rh.isotype.opacity) } else { rh.isotype.opacity }
    } else { 50% }

    // Centrado vertical óptico del isotipo respecto al texto Neuzeit 5.5pt
    let y_iso = rh_base_y - (rh_ascent / 2) - (iso_h / 2)
    let unit_gap = if "unit_gap" in rh { to-len(rh.unit_gap) } else { 8.0pt }

    // Unidad institucional: PROTOCOLO FAMILIAR + VERSION 1.0
    let ftr = ip.footer
    let institutional_unit = [
      #text(
        font: neuzeit,
        size: to-len(rh.size),
        fill: rgb(ftr.phrase.color),
        tracking: if type(rh.tracking) == str { eval(rh.tracking) } else { rh.tracking },
        weight: "regular"
      )[#ftr.phrase.text]#h(unit_gap)#text(
        font: neuzeit,
        size: to-len(rh.size),
        fill: rgb(ftr.version.color),
        tracking: if type(rh.tracking) == str { eval(rh.tracking) } else { rh.tracking },
        weight: "regular"
      )[#ftr.version.text]
    ]

    let m_cut = to-len(p_cfg.margin_cut)
    let m_spine = to-len(p_cfg.margin_spine)

    context {
      let ch_num = if chapter != auto and chapter != none {
        if type(chapter) == int { chapter } else { int(chapter) }
      } else {
        interior-chapter-counter.get().first()
      }
      let ch_str = if ch_num < 10 { "0" + str(ch_num) } else { str(ch_num) }
      let ch_label = text(
        font: neuzeit,
        size: to-len(rh.size),
        fill: rgb(rh.color),
        tracking: if type(rh.tracking) == str { eval(rh.tracking) } else { rh.tracking },
        weight: "regular"
      )[CAPÍTULO #ch_str]

      if recto_mode {
        // RECTO de continuación:
        // Lado Lomo (izq): PROTOCOLO FAMILIAR  VERSION 1.0 (en x = 58.74pt)
        place(top + left, dx: m_spine, dy: rh_dy)[#institutional_unit]

        // Lado Corte (der): CAPÍTULO ##  [ISOTIPO 50%]
        // Isotipo pegado al margen de corte (x_fin = 396 - 22.70 = 373.30pt)
        place(top + right, dx: -m_cut, dy: y_iso)[
          #interior-isotype(width: iso_w, height: iso_h, opacity: iso_op)
        ]
        place(top + right, dx: -(m_cut + iso_w + iso_gap), dy: rh_dy)[
          #ch_label
        ]
      } else {
        // VERSO de continuación:
        // Lado Corte (izq): [ISOTIPO 50%]  CAPÍTULO ##
        // Isotipo pegado al margen de corte (x = 22.70pt)
        place(top + left, dx: m_cut, dy: y_iso)[
          #interior-isotype(width: iso_w, height: iso_h, opacity: iso_op)
        ]
        place(top + left, dx: m_cut + iso_w + iso_gap, dy: rh_dy)[
          #ch_label
        ]

        // Lado Lomo (der): PROTOCOLO FAMILIAR  VERSION 1.0 (en x_fin = 396 - 58.74 = 337.26pt)
        place(top + right, dx: -m_spine, dy: rh_dy)[#institutional_unit]
      }
    }
  }

  // 5. Footer institucional y Folio
  let ftr = ip.footer
  let ftr_ascent = to-len(ftr.ascent)
  let folio_ascent = to-len(ip.folio.ascent)

  // Folio dinámico
  let folio_text = if page_num != auto and page_num != none {
    if type(page_num) == int {
      if page_num < 10 { "0" + str(page_num) } else { str(page_num) }
    } else {
      str(page_num)
    }
  } else {
    context {
      let p = counter(page).get().first()
      if p < 10 { "0" + str(p) } else { str(p) }
    }
  }

  let folio_content = text(
    font: minion,
    size: to-len(ip.folio.size),
    fill: rgb(ip.folio.color),
    weight: "medium"
  )[#folio_text]

  let folio_dy = to-len(ip.folio.baseline_y) - folio_ascent
  let m_cut = to-len(p_cfg.margin_cut)

  if recto_mode {
    // RECTO: Folio alineado a corte exterior derecho (x = 373.30pt) [FASE 3.6.3]
    place(top + right, dx: -m_cut, dy: folio_dy)[#folio_content]

    // Composición institucional inferior (exclusiva de chapter-first-page)
    if has_footer_institutional {
      if p_cfg.has_isotype {
        let iso_ftr_op = if "isotype_opacity" in p_cfg {
          if type(p_cfg.isotype_opacity) == str { eval(p_cfg.isotype_opacity) } else { p_cfg.isotype_opacity }
        } else { 50% }
        place(
          top + left,
          dx: to-len(p_cfg.isotype_x),
          dy: to-len(p_cfg.isotype_y),
          interior-isotype(width: to-len(p_cfg.isotype_width), height: to-len(p_cfg.isotype_height), opacity: iso_ftr_op)
        )
      }
      place(top + left, dx: to-len(p_cfg.footer_phrase_x), dy: to-len(ftr.baseline_y) - ftr_ascent)[
        #text(
          font: neuzeit,
          size: to-len(ftr.size),
          fill: rgb(ftr.phrase.color),
          stroke: to-len(ftr.phrase.stroke) + rgb(ftr.phrase.stroke_color),
          tracking: eval(ftr.tracking),
          weight: "regular"
        )[#ftr.phrase.text]
      ]
      place(top + left, dx: to-len(p_cfg.footer_version_x), dy: to-len(ftr.baseline_y) - ftr_ascent)[
        #text(
          font: neuzeit,
          size: to-len(ftr.size),
          fill: rgb(ftr.version.color),
          stroke: to-len(ftr.version.stroke) + rgb(ftr.version.stroke_color),
          tracking: eval(ftr.tracking),
          weight: "regular"
        )[#ftr.version.text]
      ]
    }
  } else {
    // VERSO: Folio alineado a corte exterior izquierdo (x = 22.70pt) [FASE 3.6.3]
    place(top + left, dx: m_cut, dy: folio_dy)[#folio_content]

    // Composición institucional inferior (si aplica en primera página verso)
    if has_footer_institutional {
      place(top + left, dx: to-len(p_cfg.footer_phrase_x), dy: to-len(ftr.baseline_y) - ftr_ascent)[
        #text(
          font: neuzeit,
          size: to-len(ftr.size),
          fill: rgb(ftr.phrase.color),
          stroke: to-len(ftr.phrase.stroke) + rgb(ftr.phrase.stroke_color),
          tracking: eval(ftr.tracking),
          weight: "regular"
        )[#ftr.phrase.text]
      ]
      place(top + left, dx: to-len(p_cfg.footer_version_x), dy: to-len(ftr.baseline_y) - ftr_ascent)[
        #text(
          font: neuzeit,
          size: to-len(ftr.size),
          fill: rgb(ftr.version.color),
          stroke: to-len(ftr.version.stroke) + rgb(ftr.version.stroke_color),
          tracking: eval(ftr.tracking),
          weight: "regular"
        )[#ftr.version.text]
      ]
    }
  }

  // 6. Elementos adicionales de cabecera si se suministran (ej. de chapter-first-page)
  if header_decorations != none {
    header_decorations
  }

  // 7. Flujo principal de contenido
  let start_y = if content_dy != auto {
    content_dy
  } else if recto_mode {
    to-len(ip.chapter_first_page.content_dy)
  } else {
    123.6900pt
  }

  let box_x = if recto_mode { to-len(p_cfg.margin_spine) } else { to-len(p_cfg.margin_cut) }
  let box_w = to-len(p_cfg.content_width)

  place(top + left, dx: box_x, dy: start_y)[
    #block(width: box_w)[
      #set text(
        font: neuzeit,
        size: to-len(ip.body.size),
        fill: rgb(ip.body.color),
        tracking: eval(ip.body.tracking),
        hyphenate: if "hyphenate" in ip.body { ip.body.hyphenate } else { false }
      )
      #set par(
        leading: to-len(ip.body.typst_leading),
        justify: ip.body.justify,
        spacing: to-len(ip.body.typst_leading),
        linebreaks: if "linebreaks" in ip.body { ip.body.linebreaks } else { "simple" }
      )
      #body
    ]
  ]
}

// ------------------------------------------------------------------------------
// 14. PRIMERA PÁGINA DE CAPÍTULO (chapter-first-page) [FASE 3.6]
// Reutiliza interior-page() añadiendo número, regla y título
// ------------------------------------------------------------------------------
#let chapter-first-page(
  cfg,
  number: "01",
  title: none,
  opening_title: none,
  is_recto: true,
  page_num: auto,
  with_shadow: false,
  arcs_opacity: 50%,
  body
) = {
  let ip = cfg.interior_page
  let cfp = ip.chapter_first_page
  let minion = (cfp.number.font, cfp.number.fallback_font)

  let num_int = if type(number) == int { number } else { int(number) }
  interior-chapter-counter.update(num_int)
  interior-section-counter.update(0)

  let num_str = if type(number) == int {
    if number < 10 { "0" + str(number) } else { str(number) }
  } else {
    str(number)
  }

  let title_content = if title != none {
    title
  } else {
    []
  }

  let header_decorations = [
    // 1. Número de capítulo
    #place(top + left, dx: to-len(cfp.number.x), dy: to-len(cfp.number.dy))[
      #text(
        font: minion,
        size: to-len(cfp.number.size),
        fill: rgb(cfp.number.color),
        tracking: eval(cfp.number.tracking),
        weight: "medium"
      )[#num_str]
    ]

    // 2. Regla horizontal
    #place(top + left, dx: to-len(cfp.rule.x), dy: to-len(cfp.rule.y))[
      #rect(
        width: to-len(cfp.rule.width),
        height: to-len(cfp.rule.height),
        fill: rgb(cfp.rule.color),
        stroke: none
      )
    ]

    // 3. Título del capítulo
    #place(top + left, dx: to-len(cfp.title.x), dy: to-len(cfp.title.dy))[
      #block(width: to-len(cfp.title.width))[
        #set text(
          font: minion,
          size: to-len(cfp.title.size),
          fill: rgb(cfp.title.color),
          tracking: eval(cfp.title.tracking),
          weight: "medium"
        )
        #set par(leading: to-len(cfp.title.typst_leading), justify: false)
        #title_content
      ]
    ]
  ]

  // Reutiliza interior-page pasando la infraestructura
  interior-page(
    cfg,
    is_recto: is_recto,
    page_num: page_num,
    with_shadow: false,
    arcs_opacity: arcs_opacity,
    has_arcs: true,
    has_claim: true,
    has_running_header: false,
    has_footer_institutional: true,
    content_dy: to-len(cfp.content_dy),
    header_decorations: header_decorations,
    body
  )
}


// ------------------------------------------------------------------------------
// 15. PÁGINA DE INTRODUCCIÓN (introduction-page) [FASE 4.3.4 - LOCKED]
// Variante semántica de chapter-first-page() para la Introducción noble unitaria.
// Sin número de capítulo, sin etiqueta CAPÍTULO, sin subtítulos agregados.
// Calibración consolidada: content_dy = 126.00 pt.
// ------------------------------------------------------------------------------
#let introduction-page(
  cfg,
  page_num: 5,
  show_spread: true,
  content_dy: 126.0pt,
  body: none
) = {
  let ip = cfg.interior_page
  let cfp = ip.chapter_first_page
  let minion = (cfp.title.font, cfp.title.fallback_font)

  // 1. Cabecera decorativa institucional (heredada de chapter-first-page)
  // Calibración vertical: título INTRODUCCIÓN en dy: 85.0 pt y regla en dy: 110.0 pt.
  let header_decorations = [
    // Título INTRODUCCIÓN (Minion Pro Medium Display 15.9929 pt)
    #place(top + left, dx: to-len(cfp.title.x), dy: 85.0pt)[
      #block(width: to-len(cfp.title.width))[
        #set text(
          font: minion,
          size: to-len(cfp.title.size),
          fill: rgb(cfp.title.color),
          tracking: eval(cfp.title.tracking),
          weight: "medium"
        )
        #set par(leading: to-len(cfp.title.typst_leading), justify: false)
        INTRODUCCIÓN
      ]
    ]

    // Regla decorativa horizontal naranja institucional
    #place(top + left, dx: to-len(cfp.rule.x), dy: 110.0pt)[
      #rect(
        width: to-len(cfp.rule.width),
        height: to-len(cfp.rule.height),
        fill: rgb(cfp.rule.color),
        stroke: none
      )
    ]
  ]

  // 2. Contenido canónico de 00_introduccion.md (6 párrafos, 305 palabras) si no se especifica body
  let default_body = [
    El presente Protocolo Familiar es un acuerdo institucional construido por la familia con el propósito de preservar la empresa, proteger el patrimonio común y mantener la armonía familiar a lo largo del tiempo.

    Este instrumento parte del reconocimiento de que la empresa y la familia conforman un sistema interdependiente, cuya adecuada relación requiere reglas claras, mecanismos institucionales y una visión compartida de largo plazo. En este sentido, el Protocolo establece un marco ordenado para la toma de decisiones, la prevención de conflictos y la conducción del sistema familiar–empresarial, evitando prácticas informales que puedan afectar la estabilidad de la empresa o las relaciones entre sus integrantes.

    El Protocolo no sustituye los Estatutos Sociales ni la legislación aplicable, sino que los complementa, articulando principios y lineamientos internos que regulan la participación de la familia, el funcionamiento de los órganos de gobierno y los procesos clave para la continuidad del proyecto empresarial, en congruencia con lo previsto en dichos instrumentos.

    Su finalidad no es restringir derechos patrimoniales, sino establecer reglas claras de interacción, responsabilidad y actuación institucional, que permitan anticipar decisiones relevantes, ordenar la participación familiar y asegurar que la empresa opere bajo criterios profesionales, disciplinados y alineados con los valores que le dieron origen.

    La adopción del presente Protocolo representa un compromiso consciente de la familia por preservar el legado construido, fortalecer la empresa como un proyecto común y consolidar una estructura sólida que permita su continuidad hacia las siguientes generaciones.

    Con este instrumento, la familia asume la responsabilidad de actuar con visión de largo plazo, tomar decisiones dentro de un marco institucional y resguardar la estabilidad, el control y la permanencia del proyecto empresarial en beneficio de su futuro.
  ]

  let content_body = if body != none { body } else { default_body }

  // 3. Generación opcional del Verso ceremonial en blanco previo (pág 4) para observar el spread
  if show_spread {
    page(
      width: to-len(ip.page.width),
      height: to-len(ip.page.height),
      margin: 0pt,
      fill: rgb(ip.page.fill),
      header: none,
      footer: none
    )[
      // Blanco ceremonial deliberado previo a la Introducción (página 4)
    ]
  }

  // 4. Invocación de interior-page() con paridad RECTO y parámetros idénticos a chapter-first-page()
  interior-page(
    cfg,
    is_recto: true,
    page_num: page_num,
    with_shadow: false,
    arcs_opacity: 50%,
    has_arcs: true,
    has_claim: true,
    has_running_header: false,
    has_footer_institutional: true,
    content_dy: content_dy,
    header_decorations: header_decorations,
    content_body
  )
}


// ------------------------------------------------------------------------------
// 16. APERTURA DE REGLAMENTO (regulation-opening) [APPROVED / LOCKED]
// Estado: Consolidado y bloqueado formalmente en Fase 4.4.2 (Variante A0 / ALL CAPS).
// Variante semántica de chapter-opening().
// Identificador "REGLAMENTO" en Minion Pro Medium Display 20pt (#f15d22) en dy=352.0pt.
// Título en Minion Pro Medium Display 15.9929pt (#2e2f31) en dy=412.3005pt.
// Saltos de línea editoriales fijos controlados.
// ------------------------------------------------------------------------------
#let canonical-regulation-titles = (
  "11": ("DE LA ASAMBLEA", "DE FAMILIA"),
  "asamblea": ("DE LA ASAMBLEA", "DE FAMILIA"),
  "12": ("DEL CONSEJO", "DE FAMILIA"),
  "consejo": ("DEL CONSEJO", "DE FAMILIA"),
  "13": ("DEL COMITÉ DE", "HONOR FAMILIAR"),
  "comite": ("DEL COMITÉ DE", "HONOR FAMILIAR"),
)

#let regulation-opening(
  cfg,
  reg_key: none,             // "asamblea", "consejo", "comite", "11", "12", "13"
  title: none,               // array de líneas o string personalizado
  upper_label: "REGLAMENTO", // "REGLAMENTO" consolidado
  show_blank_verso: false,   // Si es true, genera página par en blanco ceremonial previa
  is_recto: false            // Salto a página impar (Recto)
) = {
  // 1. Verso en blanco ceremonial previo si se requiere para spread aislado
  if show_blank_verso {
    page(
      width: to-len(cfg.chapter_opening.page.width),
      height: to-len(cfg.chapter_opening.page.height),
      margin: 0pt,
      fill: rgb("#ffffff"),
      header: none,
      footer: none
    )[
      // Blanco ceremonial deliberado previo a la apertura del Reglamento
    ]
  }

  // 2. Salto ceremonial a página impar (Recto) en flujo continuo
  if is_recto {
    pagebreak(to: "odd")
  }

  let co = if cfg != none and "chapter_opening" in cfg { cfg.chapter_opening } else { none }
  let minion = (co.number.font, co.number.fallback_font)
  let neuzeit = (co.description.font, co.description.fallback_font)

  // 3. Fondo vectorial corporativo institucional (idéntico a chapter-opening)
  // Fondo crema, retícula de puntos, sombras suaves, plano diagonal naranja,
  // logotipo POLIFLEX y la regla horizontal naranja fija en y = 388.954pt
  place(
    top + left,
    dx: 0pt,
    dy: 0pt,
    image(co.assets.background_vector, width: to-len(co.page.width), height: to-len(co.page.height))
  )

  // 4. Identificador superior ceremonial: "REGLAMENTO"
  // Medidas locked Fase 4.4.2: Minion Pro Medium Display, 20.0000 pt, Tracking: +0.050 em, Color: #f15d22
  // dy = 352.0000 pt (baseline = 365.0200 pt, luz libre a regla = 18.4740 pt)
  place(
    top + left,
    dx: to-len(co.number.x),
    dy: 352.00pt
  )[
    #text(
      font: minion,
      size: 20.0pt,
      fill: rgb(co.number.color),
      tracking: 0.050em,
      weight: "medium"
    )[#upper(upper_label)]
  ]

  // 5. Título del órgano normado con saltos editoriales fijos controlados
  // Medidas locked Fase 4.4.2: Minion Pro Medium Display, 15.9929 pt, Leading: 24.0053 pt, Color: #2e2f31
  // dy = 412.3005 pt (baseline L1 = 422.7119 pt, luz libre desde regla = 21.2291 pt)
  let lines = if title != none {
    if type(title) == array { title } else { (title,) }
  } else if reg_key != none and reg_key in canonical-regulation-titles {
    canonical-regulation-titles.at(reg_key)
  } else {
    ("DE LA ASAMBLEA", "DE FAMILIA")
  }

  let formatted_lines = lines.map(l => upper(l))

  place(
    top + left,
    dx: to-len(co.title.x),
    dy: to-len(co.title.dy)
  )[
    #block(width: to-len(co.title.width))[
      #set text(
        font: minion,
        size: to-len(co.title.size),
        fill: rgb(co.title.color),
        tracking: eval(co.title.tracking),
        weight: "medium"
      )
      #set par(leading: to-len(co.title.typst_leading), justify: false)
      #formatted_lines.join([\ ])
    ]
  ]

  // 6. Footer institucional locked (idéntico a chapter-opening)
  let ftr = co.footer
  // Frase: PROTOCOLO FAMILIAR
  place(top + left, dx: to-len(ftr.phrase.x), dy: to-len(ftr.phrase.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.phrase.size),
      fill: rgb(ftr.phrase.color),
      stroke: to-len(ftr.phrase.stroke) + rgb(ftr.phrase.stroke_color),
      tracking: eval(ftr.phrase.tracking),
      weight: "regular"
    )[#ftr.phrase.text]
  ]

  // Versión: VERSION 1.0
  place(top + left, dx: to-len(ftr.version.x), dy: to-len(ftr.version.dy))[
    #text(
      font: neuzeit,
      size: to-len(ftr.version.size),
      fill: rgb(ftr.version.color),
      stroke: to-len(ftr.version.stroke) + rgb(ftr.version.stroke_color),
      tracking: eval(ftr.version.tracking),
      weight: "regular"
    )[#ftr.version.text]
  ]
}

// ==============================================================================
// 17. ENTORNO Y ELEMENTOS NORMATIVOS DE REGLAMENTO (regulation-page)
// [APPROVED / LOCKED — FASE 4.5.8]
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================

// ------------------------------------------------------------------------------
// 17.1 RUNNING HEADER DE REGLAMENTOS [LOCKED — FASE 4.5.8]
// Variante H2: Grid asimétrico 1.025fr / 0.975fr con inversión Recto / Verso
// ------------------------------------------------------------------------------
#let regulation-running-header(
  cfg,
  reg_name: "ASAMBLEA DE FAMILIA",
  variant: "A8",
  is_recto: true
) = {
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let iso = interior-isotype(width: 7.1186pt, height: 7.0000pt, opacity: 50%)

  let header_title = "REGLAMENTO · " + reg_name
  let header_font_size = 5.5pt
  let header_tracking = 0.200em
  let header_color = rgb("#6c6b67")
  let header_weight = "regular"

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
        columns: (0.975fr, 1.025fr),
        align: (left + horizon, right + horizon),
        inst_unit,
        [#reg_unit#h(5pt)#box(baseline: 15%)[#iso]]
      )
    ] else [
      #grid(
        columns: (1.025fr, 0.975fr),
        align: (left + horizon, right + horizon),
        [#box(baseline: 15%)[#iso]#h(5pt)#reg_unit],
        inst_unit
      )
    ]
  ]
}

// ------------------------------------------------------------------------------
// 17.2 PIE Y FOLIO DE REGLAMENTOS [LOCKED — FASE 4.5.8]
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
// 17.3 FILETE VERTICAL DE LOMO [LOCKED — FASE 4.5.8]
// Filete de 0.5pt en #f15d22 pegado al lomo (x=30.13pt recto, x=365.87pt verso)
// ------------------------------------------------------------------------------
#let regulation-spine-rule(is_recto: true) = {
  let rule_x = if is_recto { 30.13pt } else { 365.87pt }
  place(top + left, dx: rule_x, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + rgb("#f15d22")))
}

// ------------------------------------------------------------------------------
// 17.4 CAPÍTULO REGLAMENTARIO [LOCKED — FASE 4.5.8]
// Bloque indivisible (sticky: true) Minion Pro Medium con jerarquía de color
// ------------------------------------------------------------------------------
#let regulation-chapter(
  roman_num,
  title,
  variant: "A8",
  above_spacing: auto,
  below_spacing: auto
) = {
  let minion = ("Minion Pro", "Georgia")

  let sp_above = if above_spacing != auto { above_spacing } else { 18.00pt }
  let sp_below = if below_spacing != auto { below_spacing } else { 12.73pt }

  block(width: 100%, breakable: false, sticky: true, above: sp_above, below: sp_below)[
    #metadata((type: "reg-chapter", roman: roman_num, title: title)) <reg-chapter-marker>
    #text(font: minion, size: 10.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), tracking: 0.050em, weight: "medium")[#roman_num]
    #v(3.5pt)
    #text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.020em, weight: "medium")[#title]
  ]
}

// ------------------------------------------------------------------------------
// 17.5 ARTÍCULO REGLAMENTARIO [LOCKED — FASE 4.5.8]
// Encabezado normativo (sticky: true) con pulso O1 (12.72949pt) y respiro A12 (12.00pt)
// ------------------------------------------------------------------------------
#let regulation-article(
  art_num,
  art_name,
  variant: "A8",
  above_spacing: auto,
  below_spacing: auto
) = {
  let minion = ("Minion Pro", "Georgia")

  let sp_above = if above_spacing != auto { above_spacing } else { 12.72949pt }
  let sp_below = if below_spacing != auto { below_spacing } else { 12.00pt }

  block(width: 100%, breakable: false, sticky: true, above: sp_above, below: sp_below)[
    #box[#text(font: minion, size: 9.2pt, fill: rgb("#f15d22"), stroke: 0.2pt + rgb("#f15d22"), weight: "medium")[#art_num]]#h(5.0pt)#text(font: minion, size: 9.2pt, fill: rgb("#2e2f31"), tracking: 0.015em, weight: "medium")[#art_name]
  ]
}

// ------------------------------------------------------------------------------
// 17.6 FRACCIONES ROMANAS Y LISTAS NORMATIVAS [LOCKED — FASE 4.5.8]
// Variante M1: hanging indent 14pt, intra-leading 5.0pt, inter 7.5pt, post 14.0pt, ragged-right
// ------------------------------------------------------------------------------
#let regulation-fraction(
  marker,
  body,
  variant: "A8",
  is_last: false,
  justify: false,
  intra_leading: auto,
  below_spacing: auto
) = {
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

  let lead_val = if intra_leading != auto { intra_leading } else { 5.00pt }
  let def_below = if is_last { 14.00pt } else { 7.50pt }
  let sp_below = if below_spacing != auto {
    below_spacing
  } else {
    def_below
  }

  block(width: 100%, breakable: true, below: sp_below)[
    #grid(
      columns: (14.0pt, 1fr),
      column-gutter: 4.0pt,
      align: (right + top, left + top),
      text(font: neuzeit, size: 7.9077pt, fill: rgb("#2e2f31"), weight: "medium")[#marker],
      [
        #set par(leading: lead_val, justify: justify, linebreaks: "simple")
        #text(font: neuzeit, size: 7.9077pt, fill: rgb("#2e2f31"))[#body]
      ]
    )
  ]
}

// ------------------------------------------------------------------------------
// 17.7 TRANSITORIO ÚNICO [LOCKED — FASE 4.5.8]
// Cláusula de cierre normativo: above 18.00pt, below 12.00pt (T12)
// ------------------------------------------------------------------------------
#let regulation-transitory(
  title: "TRANSITORIO ÚNICO",
  body: none,
  variant: "A8",
  above_spacing: auto,
  below_spacing: auto
) = {
  let minion = ("Minion Pro", "Georgia")

  let sp_above = if above_spacing != auto { above_spacing } else { 18.00pt }
  let sp_below = if below_spacing != auto { below_spacing } else { 12.00pt }

  block(width: 100%, breakable: false, sticky: true, above: sp_above, below: sp_below)[
    #metadata((type: "reg-transitory", title: title)) <reg-transitory-marker>
    #text(font: minion, size: 10.0pt, fill: rgb("#f15d22"), stroke: 0.25pt + rgb("#f15d22"), tracking: 0.050em, weight: "medium")[#title]
  ]
  if body != none [
    #body
  ]
}

// ------------------------------------------------------------------------------
// 17.8 ENTORNO BASE DE PÁGINA INTERIOR DE REGLAMENTO (regulation-page)
// [APPROVED / LOCKED — FASE 4.5.8]
// Geometría canónica Media Carta (396pt x 612pt), retícula +6mm, lomo 58.74pt, corte 22.70pt
// ------------------------------------------------------------------------------
#let regulation-page(
  cfg,
  variant: "A8",
  reg_name: "ASAMBLEA DE FAMILIA",
  body
) = {
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")

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
    spacing: 12.72949pt,
    linebreaks: "simple"
  )

  body
}


// ==============================================================================
// 18. ANEXOS — SISTEMA DE ACTAS
// Fase 4.6.5 — LOCK PARCIAL
// ==============================================================================
// Infraestructura editorial y helpers funcionales para la familia de Actas:
// - Acta de Asamblea General Familiar (A2: 2/3/3/3)
// - Acta de Sesión del Consejo de Familia
// - Acta de Constitución y Sesión del Comité de Honor Familiar
//
// Invariantes geométricas:
// - Página: Media Carta (396 pt x 612 pt)
// - Margen interior (lomo): 58.74 pt
// - Margen exterior (corte): 22.70 pt
// - Margen superior: 71.0079 pt (+6 mm consolidado)
// - Margen inferior: 65.00 pt
// - Caja útil horizontal real: 314.56 pt
// - Filete de lomo: 0.5 pt (#f15d22) a 30.13 pt del lomo
// - Canal libre de seguridad al filete: >= 28 pt (cero cruces vectoriales)
// - Paridad de encuadernación: binding sincronizado con start_page
// - Tablas: row_height 22.0 pt, cabeceras en #f8fafc, trazo 0.5 pt (#cbd5e1)
// - Renglones manuscritos: interlínea 14.5 pt (5.11 mm), par(spacing: 0pt)
// - Firmas: Keep-together indivisible (clausura + mesa de firmas)
// ==============================================================================

// Paleta cromática y familias tipográficas para anexos y formularios
#let font-neuzeit = ("Neuzeit Grotesk",)
#let font-minion = ("Minion Pro",)

#let col-primary = rgb("#f15d22")   // Naranja institucional POLIFLEX
#let col-text = rgb("#2e2f31")      // Gris oscuro de lectura
#let col-muted = rgb("#6c6b67")     // Gris medio de metadatos y etiquetas
#let col-border = rgb("#cbd5e1")    // Borde de tablas y reglas secundarias
#let col-line = rgb("#94a3b8")      // Líneas vectoriales de captura manuscrita
#let col-header-bg = rgb("#f8fafc") // Fondo para encabezados de tabla

// ------------------------------------------------------------------------------
// 18.1 CAMPO VECTORIAL DE CAPTURA EN LÍNEA (form-field-line)
// Sustituye las secuencias de "_" por líneas horizontales nítidas alineadas al texto.
// ------------------------------------------------------------------------------
#let form-field-line(
  width: auto,
  min_width: 20pt,
  stroke: 0.5pt + col-line,
  baseline: 1.0pt,
  content: none
) = {
  let w = if width != auto { width } else { min_width }
  box(width: w, baseline: baseline)[
    #if content != none [
      #align(center + bottom)[#content]
    ]
    #place(bottom + left, line(length: 100%, stroke: stroke))
  ]
}

// ------------------------------------------------------------------------------
// 18.2 CHECKBOX VECTORIAL CONSISTENTE (form-checkbox)
// Sustituye el glifo Unicode ☐ por una caja geométrica con radio y alineación óptica.
// ------------------------------------------------------------------------------
#let form-checkbox(
  label: none,
  checked: false,
  size: 7.0pt,
  stroke: 0.6pt + col-muted,
  radius: 1.2pt
) = {
  let box-elem = box(
    width: size,
    height: size,
    baseline: -0.5pt,
    stroke: stroke,
    radius: radius,
    fill: if checked { col-primary } else { none }
  )
  if label != none [
    #box(baseline: 0pt)[#box-elem#h(3.5pt)#text(font: font-neuzeit, size: 7.5pt, fill: col-text)[#label]]
  ] else [
    #box-elem
  ]
}

// ------------------------------------------------------------------------------
// 18.3 TÍTULO PRINCIPAL DEL FORMULARIO (form-title)
// Jerarquía operativa/institucional en Minion Pro Medium Display, 13.5 pt.
// ------------------------------------------------------------------------------
#let form-title(
  title,
  above: 0pt,
  below: 8.0pt
) = {
  block(
    width: 100%,
    breakable: false,
    above: above,
    below: below
  )[
    #text(
      font: font-minion,
      size: 13.5pt,
      fill: col-text,
      weight: "medium",
      tracking: 0.020em
    )[#title]
  ]
}

// ------------------------------------------------------------------------------
// 18.4 METADATOS SUPERIORES DEL DOCUMENTO (form-header-meta)
// Identificador y tipo en Neuzeit Grotesk Medium 7.5 pt con campos vectoriales.
// ------------------------------------------------------------------------------
#let form-header-meta(
  label: "Número:",
  prefix: "AGF",
  suffix: "/20",
  num_width: 50pt,
  year_width: 15pt,
  show_type: true,
  type_label: "Tipo:",
  type_options: ("Ordinaria", "Extraordinaria"),
  doc_number_prefix: none,
  doc_year_suffix: none,
  below: 10pt
) = {
  let pref = if doc_number_prefix != none { doc_number_prefix } else { prefix }
  let suff = if doc_year_suffix != none { doc_year_suffix } else { suffix }
  block(
    width: 100%,
    breakable: false,
    below: below
  )[
    #grid(
      columns: if show_type { (1fr, auto) } else { (1fr,) },
      align: if show_type { (left + horizon, right + horizon) } else { (left + horizon,) },
      [
        #text(font: font-neuzeit, size: 7.5pt, fill: col-muted, weight: "medium")[#label]#h(4pt)
        #text(font: font-neuzeit, size: 7.5pt, fill: col-text)[#pref]#form-field-line(width: num_width)#text(font: font-neuzeit, size: 7.5pt, fill: col-text)[#suff]#form-field-line(width: year_width)
      ],
      if show_type [
        #text(font: font-neuzeit, size: 7.5pt, fill: col-muted, weight: "medium")[#type_label]#h(6pt)
        #for (i, opt) in type_options.enumerate() [
          #if i > 0 [#h(8pt)]
          #form-checkbox(label: opt)
        ]
      ]
    )
    #v(3pt)
    #line(length: 100%, stroke: 0.5pt + col-border)
  ]
}

// ------------------------------------------------------------------------------
// 18.5 TÍTULO DE SECCIÓN OPERATIVA (form-section-title)
// Encabezado indivisible con acento institucional naranja y texto en gris oscuro.
// ------------------------------------------------------------------------------
#let form-section-title(
  num_str,
  title,
  above: 11.5pt,
  below: 5.0pt
) = {
  block(
    width: 100%,
    breakable: false,
    sticky: true,
    above: above,
    below: below
  )[
    #text(
      font: font-minion,
      size: 9.5pt,
      fill: col-primary,
      weight: "medium"
    )[#num_str]#h(4.5pt)#text(
      font: font-minion,
      size: 9.5pt,
      fill: col-text,
      weight: "medium",
      tracking: 0.015em
    )[#title]
  ]
}

// ------------------------------------------------------------------------------
// 18.6 CAMPO NARRATIVO MULTILÍNEA (form-multiline-field)
// Genera renglones horizontales vectoriales para redacción manuscrita estructurada.
// ------------------------------------------------------------------------------
#let form-multiline-field(
  label,
  num_lines: 2,
  line_spacing: 14.5pt,
  below: 6.0pt,
  stroke: 0.5pt + col-border
) = {
  block(
    width: 100%,
    breakable: false,
    below: below
  )[
    #set par(spacing: 0pt)
    #grid(
      columns: (auto, 1fr),
      column-gutter: 5pt,
      align: (bottom, bottom),
      text(font: font-neuzeit, size: 7.5pt, fill: col-text, weight: "medium")[#label],
      box(baseline: -1pt, line(length: 100%, stroke: stroke))
    )
    #for i in range(num_lines - 1) [
      #v(line_spacing)
      #line(length: 100%, stroke: stroke)
    ]
  ]
}

// ------------------------------------------------------------------------------
// 18.7 TABLA OPERATIVA DE FORMULARIO (form-table)
// Renderiza tablas institucionales con row_height configurable y bordes finos.
// ------------------------------------------------------------------------------
#let form-table(
  columns: (1.1fr, 1.0fr, 0.65fr, 1.15fr, 1.1fr),
  headers: (),
  rows_data: (),
  row_height: 22.0pt,
  stroke: 0.5pt + col-border
) = {
  let num_data_rows = rows_data.len()
  set text(font: font-neuzeit, size: 7.0pt, fill: col-text)

  table(
    columns: columns,
    rows: (auto, ..(row_height,) * num_data_rows),
    align: (col, row) => {
      if row == 0 {
        if type(headers.at(col)) == dictionary and "align" in headers.at(col) { headers.at(col).align } else { left + horizon }
      } else {
        left + horizon
      }
    },
    fill: (col, row) => if row == 0 { col-header-bg } else { none },
    stroke: (col, row) => stroke,
    table.header(
      ..headers.map(h => {
        let content = if type(h) == dictionary { h.body } else { h }
        let al = if type(h) == dictionary and "align" in h { h.align } else { left + horizon }
        align(al)[#text(font: font-neuzeit, size: 7.0pt, weight: "medium", fill: col-text)[#content]]
      })
    ),
    ..rows_data.flatten()
  )
}

// ------------------------------------------------------------------------------
// 18.8 BLOQUE INDIVISIBLE DE FIRMAS Y CIERRE (form-signature-block)
// Garantiza que el cierre y la tabla de firmas nunca queden desvinculados ni huérfanos.
// ------------------------------------------------------------------------------
#let form-signature-block(
  above: 11.5pt,
  content
) = {
  block(
    width: 100%,
    breakable: false,
    above: above
  )[
    #content
  ]
}

// ------------------------------------------------------------------------------
// 18.9 ENCABEZADO CORRIENTE DE ANEXOS (annex-running-header)
// Sigue la distribución recto/verso del libro, con isotipo exterior.
// ------------------------------------------------------------------------------
#let annex-running-header(
  form_title: "ACTA DE ASAMBLEA GENERAL FAMILIAR",
  short_title: "ACTA DE ASAMBLEA",
  full_title: false,
  is_recto: true
) = {
  let iso = interior-isotype(width: 7.1186pt, height: 7.0000pt, opacity: 50%)

  let effective_title = if full_title {
    form_title
  } else if short_title != none {
    short_title
  } else {
    form_title
  }
  let header_title = "ANEXOS · " + effective_title

  let rh_text(t, col) = text(
    font: font-neuzeit,
    size: 5.5pt,
    fill: col,
    tracking: 0.200em,
    weight: "regular"
  )[#t]

  let inst_unit = [
    #rh_text("PROTOCOLO FAMILIAR", col-muted)#h(8pt)#rh_text("VERSION 1.0", col-primary)
  ]

  let annex_unit = rh_text(header_title, col-muted)

  place(top + left, dx: 0pt, dy: 25.5pt)[
    #if is_recto [
      #grid(
        columns: (0.975fr, 1.025fr),
        align: (left + horizon, right + horizon),
        inst_unit,
        [#annex_unit#h(5pt)#box(baseline: 15%)[#iso]]
      )
    ] else [
      #grid(
        columns: (1.025fr, 0.975fr),
        align: (left + horizon, right + horizon),
        [#box(baseline: 15%)[#iso]#h(5pt)#annex_unit],
        inst_unit
      )
    ]
  ]
}

// ------------------------------------------------------------------------------
// 18.10 PIE Y FOLIO DE ANEXOS (annex-footer)
// Minion Pro Medium 8pt alineado al corte exterior.
// ------------------------------------------------------------------------------
#let annex-footer(page_num, is_recto: true) = {
  let p_str = if page_num < 10 { "0" + str(page_num) } else { str(page_num) }
  let folio_txt = text(font: font-minion, size: 8pt, fill: col-primary, weight: "medium")[#p_str]

  v(20pt)
  if is_recto [
    #align(right)[#folio_txt]
  ] else [
    #align(left)[#folio_txt]
  ]
}

// ------------------------------------------------------------------------------
// 18.11 FILETE VERTICAL INSTITUCIONAL DE LOMO (annex-spine-rule)
// Regla vertical de 0.5pt en #f15d22 situada a 30.13pt del lomo (recto o verso).
// ------------------------------------------------------------------------------
#let annex-spine-rule(is_recto: true) = {
  let rule_x = if is_recto { 30.13pt } else { 365.87pt }
  place(top + left, dx: rule_x, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + col-primary))
}

// ------------------------------------------------------------------------------
// 18.12 ENTORNO BASE DE PÁGINA DE ANEXOS (annex-page)
// [APPROVED / LOCKED PARCIAL — FASE 4.6.5: FAMILIA DE ACTAS]
// Geometría Media Carta (396 x 612 pt), retícula +6mm, lomo 58.74pt, corte 22.70pt.
// Caja útil horizontal real: 314.56 pt
// ------------------------------------------------------------------------------
#let annex-page(
  cfg: none,
  form_title: "ACTA DE ASAMBLEA GENERAL FAMILIAR",
  short_header_title: "ACTA DE ASAMBLEA",
  full_header_title: false,
  start_page: 2, // Inicia en verso (página par) para formar pliego enfrentado natural
  binding: auto,
  body
) = {
  if start_page != none {
    counter(page).update(start_page)
  }

  // Paridad de encuadernación para páginas enfrentadas:
  // Typst calcula márgenes inside/outside según el índice físico de página (1-indexed).
  // Con binding: left, las páginas impares físicas reciben inside a la izquierda (Recto)
  // y las pares reciben inside a la derecha (Verso).
  // Si binding == auto:
  // - En pruebas aisladas donde start_page es par pero la página física es 1 (impar),
  //   se usa binding: right para forzar que la primera página física sea Verso.
  // - En documentos continuos (o cuando se especifica binding explícito), se respeta binding.
  let pg-binding = if binding != auto {
    binding
  } else if start_page != none and calc.even(start_page) {
    right
  } else {
    left
  }

  set page(
    width: 396pt,
    height: 612pt,
    binding: pg-binding,
    margin: (
      inside: 58.74pt,   // Lomo: 58.74pt
      outside: 22.70pt,  // Corte: 22.70pt
      top: 71.0079pt,    // Consolidado +6 mm
      bottom: 65.00pt
    ),
    header: context [
      #let p = counter(page).get().first()
      #let is_recto = calc.odd(p)
      #annex-running-header(form_title: form_title, short_title: short_header_title, full_title: full_header_title, is_recto: is_recto)
    ],
    footer: context [
      #let p = counter(page).get().first()
      #let is_recto = calc.odd(p)
      #annex-footer(p, is_recto: is_recto)
    ],
    background: context [
      #let p = counter(page).get().first()
      #let is_recto = calc.odd(p)
      #annex-spine-rule(is_recto: is_recto)
    ]
  )

  set text(
    font: font-neuzeit,
    size: 7.9077pt,
    fill: col-text,
    tracking: 0em,
    hyphenate: false
  )

  set par(
    leading: 12.0pt,
    justify: true,
    spacing: 10.0pt,
    linebreaks: "simple"
  )

  body
}

// ==============================================================================
// 19. ANEXOS — SISTEMA DE CONVOCATORIAS
// Fase 4.6.7 — LOCK
// ==============================================================================
// Helpers semánticos específicos para la familia de Convocatorias:
// - Convocatoria de Asamblea de Familia
// - Convocatoria a Sesión de Consejo de Familia
//
// Invariantes aprobadas:
// - Arquitectura unifoliar: exactamente 1 página (Recto / Folio 01)
// - Caja útil horizontal real: 314.56 pt
// - convocation-agenda(): num_width: auto, column_gutter: 3.5pt, text 7.2pt, tracking 0em
// - convocation-recipient(): Neuzeit 8.5pt bold + subtítulo 7.5pt medium
// - convocation-notice(): borde 1.5pt col-primary con pad(left: 1.5pt)
// - form-single-signature(): firma individual centrada e indivisible
// ==============================================================================

// ------------------------------------------------------------------------------
// 19.1 DESTINATARIO FORMAL DE CONVOCATORIA (convocation-recipient)
// ------------------------------------------------------------------------------
#let convocation-recipient(
  name,
  subtitle: "Presente",
  below: 8pt
) = {
  block(width: 100%, breakable: false, below: below)[
    #text(font: font-neuzeit, size: 8.5pt, weight: "bold", fill: col-text)[#name] \
    #v(2pt)
    #text(font: font-neuzeit, size: 7.5pt, weight: "medium", fill: col-muted, tracking: 0.04em)[#subtitle]
  ]
}

// ------------------------------------------------------------------------------
// 19.2 BLOQUE DE ORDEN DEL DÍA (convocation-agenda)
// [APPROVED / LOCKED — FASE 4.6.7: FAMILIA DE CONVOCATORIAS]
// Numerales en columna auto (13.66 pt max para VIII.), gutter 3.5 pt, texto 7.2 pt.
// ------------------------------------------------------------------------------
#let convocation-agenda(
  title: "ORDEN DEL DÍA",
  items: (),
  above: 8pt,
  below: 6pt,
  item_gutter: 3.0pt,
  num_width: auto,
  column_gutter: 3.5pt
) = {
  block(width: 100%, breakable: false, above: above, below: below)[
    #text(font: font-minion, size: 9.0pt, weight: "medium", fill: col-primary, tracking: 0.04em)[#title]
    #v(3pt)
    #line(length: 100%, stroke: 0.5pt + col-border)
    #v(4pt)
    #grid(
      columns: (num_width, 1fr),
      column-gutter: column_gutter,
      row-gutter: item_gutter,
      ..items.map(it => {
        (
          align(left + top)[#text(font: font-minion, size: 7.5pt, weight: "medium", fill: col-primary)[#it.at(0)]],
          align(left + top)[#text(font: font-neuzeit, size: 7.2pt, fill: col-text)[#it.at(1)]]
        )
      }).flatten()
    )
  ]
}

// ------------------------------------------------------------------------------
// 19.3 AVISO DOCUMENTAL INSTITUCIONAL (convocation-notice)
// Recuadro con acento lateral naranja de 1.5 pt; pad(left: 1.5pt) protege canal de lomo.
// ------------------------------------------------------------------------------
#let convocation-notice(
  content,
  above: 7pt,
  below: 7pt
) = {
  pad(left: 1.5pt)[
    #block(
      width: 100% - 1.5pt,
      stroke: (left: 1.5pt + col-primary),
      inset: (left: 6.5pt, top: 3.5pt, bottom: 3.5pt),
      above: above,
      below: below
    )[
      #set text(font: font-neuzeit, size: 6.8pt, fill: col-muted, style: "italic")
      #content
    ]
  ]
}

// ------------------------------------------------------------------------------
// 19.4 FIRMA INDIVIDUAL DE EMISOR (form-single-signature)
// Bloque indivisible centrado con espacio autógrafo y cargo abierto o institucional.
// ------------------------------------------------------------------------------
#let form-single-signature(
  salutation: "Atentamente,",
  line_width: 160pt,
  name_label: "Nombre:",
  name_content: none,
  name_field_width: 110pt,
  cargo_label: "Cargo:",
  cargo_content: none,
  above: 8pt,
  v_space: 20pt
) = {
  block(width: 100%, breakable: false, above: above)[
    #align(center)[
      #text(font: font-neuzeit, size: 7.5pt, weight: "medium", fill: col-text)[#salutation]
      #v(v_space) // Espacio para firma manuscrita autógrafa
      #line(length: line_width, stroke: 0.5pt + col-line)
      #v(3.5pt)
      #if name_content != none [
        #text(font: font-neuzeit, size: 7.5pt, fill: col-text)[#name_label #name_content]
      ] else [
        #text(font: font-neuzeit, size: 7.5pt, fill: col-text)[#name_label]#h(4pt)#form-field-line(width: name_field_width)
      ]
      #if cargo_content != none [
        #v(2.5pt)
        #text(font: font-neuzeit, size: 7.5pt, weight: "medium", fill: col-muted)[#cargo_content]
      ] else if cargo_label != none [
        #v(2.5pt)
        #text(font: font-neuzeit, size: 7.5pt, fill: col-text)[#cargo_label]#h(4pt)#form-field-line(width: 110pt)
      ]
    ]
  ]
}
