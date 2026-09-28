// ==============================================================================
// DOCUMENTO MAESTRO CANDIDATO: PROTOCOLO FAMILIAR POLIFLEX [FASE 4.7]
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Ensamblaje integral de todas las secciones en su orden canónico:
// - PÁGS. 01–02: Portada Institucional + Blanco Ceremonial
// - PÁGS. 03–04: Tabla de Contenido Completa + Blanco Ceremonial
// - PÁGS. 05–06: Introducción Institucional + Blanco Ceremonial
// - PÁGS. 07–130: Capítulos 01–09 (Baseline Oficial Fase 3.9.3)
// - PÁGS. 131–154: Reglamentos de Órganos de Gobierno (Fase 4.5.8 Locked)
// - PÁGS. 155–170: Anexos y Formatos Operativos (Fase 4.7 Candidato Completo)
// ==============================================================================

#import "/templates/typst/componentes.typ": *
#import "/tests/corpus_capitulos_01_09.typ": *
#import "/tests/corpus_reglamentos_fase_4_5_8.typ": *
#import "/tests/corpus_actas_fase_4_6_5.typ": *
#import "/tests/corpus_convocatorias_fase_4_6_7.typ": *
#import "/tests/corpus_anexos_adicionales_fase_4_7.typ": *
#import "/templates/typst/indice_temas_y_anexos.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

// ------------------------------------------------------------------------------
// 1. FRONT MATTER (PÁGINAS 01 A 06)
// ------------------------------------------------------------------------------

// PÁG 01: Portada Institucional (Recto)
#set page(
  width: to-len(cfg.cover.page.width),
  height: to-len(cfg.cover.page.height),
  margin: 0pt,
  fill: rgb("#ffffff"),
  header: none,
  footer: none
)

#cover-page(cfg)

// PÁG 02: Blanco Ceremonial (Verso)
#page(margin: 0pt, header: none, footer: none)[
  #metadata("ceremonial-blank-cover") <blank-page-marker>
]

// PÁG 03: Tabla de Contenido Completa (Recto)
#page(margin: 0pt, header: none, footer: none)[
  #metadata("toc-start") <toc-start>
  #dynamic-table-of-contents(cfg)
]

// PÁG 04: Blanco Ceremonial (Verso)
#page(margin: 0pt, header: none, footer: none)[
  #metadata("ceremonial-blank-toc") <blank-page-marker>
]

// PÁG 05: Introducción Institucional (Recto / Folio 05)
#introduction-page(cfg, page_num: 5, show_spread: false)

// PÁG 06: Blanco Ceremonial (Verso)
#page(margin: 0pt, header: none, footer: none)[
  #metadata("ceremonial-blank-intro") <blank-page-marker>
]

// ------------------------------------------------------------------------------
// 2. CAPÍTULOS 01 A 09 (PÁGINAS 07 A 130)
// ------------------------------------------------------------------------------

#show par: it => [
  #it
  #metadata("par") <content-marker>
]

#let ceremonial-blank-page() = [
  #page(margin: 0pt, header: none, footer: none)[
    #metadata("ceremonial-blank") <blank-page-marker>
  ]
]

#set page(
  width: 396pt,
  height: 612pt,
  margin: (
    inside: 58.74pt,   // Lomo: 58.74pt
    outside: 22.70pt,  // Corte: 22.70pt
    top: 71.0079pt,      // Consolidado +6 mm
    bottom: 65.00pt
  ),
  header: context [
    #let p = counter(page).get().first()
    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)
    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)
    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)
    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)

    #if not is_opening and not is_first and not is_blank and has_content [
      #let is_recto = calc.odd(p)
      #let minion = ("Minion Pro", "Georgia")
      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
      #let iso = interior-isotype(width: 7.1186pt, height: 7.0000pt, opacity: 50%)

      #let ch_markers = query(selector(<chapter-marker>))
      #let cur_num = 1
      #for m in ch_markers {
        if m.location().page() <= p {
          cur_num = m.value
        }
      }

      #let titles_map = (
        "1": "DECLARACIÓN DE PRINCIPIOS Y VISIÓN",
        "2": "PROPIEDAD ACCIONARIA Y CONTROL",
        "3": "GOBIERNO CORPORATIVO FAMILIAR",
        "4": "RÉGIMEN DE SUCESIÓN FAMILIAR",
        "5": "CONTROL DE LA INFORMACIÓN",
        "6": "DISCIPLINA FINANCIERA FAMILIAR",
        "7": "PROCEDIMIENTO SANCIONADOR",
        "8": "SOLUCIÓN DE CONFLICTOS",
        "9": "RÉGIMEN JURÍDICO DEL PROTOCOLO"
      )
      #let ch_title = titles_map.at(str(cur_num), default: "PROTOCOLO FAMILIAR")

      #let rh_text(t, col) = text(
        font: neuzeit,
        size: 5.5pt,
        fill: col,
        tracking: 0.200em,
        weight: "regular"
      )[#t]

      #let inst_unit = [
        #rh_text("PROTOCOLO FAMILIAR", rgb("#6c6b67"))#h(8pt)#rh_text("VERSION 1.0", rgb("#f15d22"))
      ]
      #let chap_unit = rh_text(ch_title, rgb("#6c6b67"))

      #place(top + left, dx: 0pt, dy: 25.5pt)[
        #if is_recto [
          #grid(
            columns: (0.975fr, 1.025fr),
            align: (left + horizon, right + horizon),
            inst_unit,
            [#chap_unit#h(5pt)#box(baseline: 15%)[#iso]]
          )
        ] else [
          #grid(
            columns: (1.025fr, 0.975fr),
            align: (left + horizon, right + horizon),
            [#box(baseline: 15%)[#iso]#h(5pt)#chap_unit],
            inst_unit
          )
        ]
      ]
    ]
  ],
  footer: context [
    #let p = counter(page).get().first()
    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)
    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)
    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)
    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)

    #if not is_opening and not is_blank and has_content [
      #let is_recto = calc.odd(p)
      #let minion = ("Minion Pro", "Georgia")
      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
      #let p_str = if p < 10 { "0" + str(p) } else { str(p) }
      #let folio_txt = text(font: minion, size: 8pt, fill: rgb("#f15d22"), weight: "medium")[#p_str]

      #if is_first [
        #let iso_ftr = interior-isotype(width: 6.2288pt, height: 6.1250pt, opacity: 50%)
        #let ftr_phrase = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.200em)[PROTOCOLO FAMILIAR]
        #let ftr_ver = text(font: neuzeit, size: 4.8234pt, fill: rgb("#f15d22"), tracking: 0.200em)[VERSION 1.0]

        #v(14pt)
        #if is_recto [
          #grid(
            columns: (1fr, 1fr),
            align: (left + horizon, right + horizon),
            [#box(baseline: 20%)[#iso_ftr]#h(4pt)#ftr_phrase#h(6pt)#ftr_ver],
            folio_txt
          )
        ] else [
          #grid(
            columns: (1fr, 1fr),
            align: (left + horizon, right + horizon),
            folio_txt,
            [#ftr_phrase#h(6pt)#ftr_ver#h(4pt)#box(baseline: 20%)[#iso_ftr]]
          )
        ]
      ] else [
        #v(20pt)
        #if is_recto [
          #align(right)[#folio_txt]
        ] else [
          #align(left)[#folio_txt]
        ]
      ]
    ]
  ],
  background: context [
    #let p = counter(page).get().first()
    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)
    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)
    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)
    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)

    #if not is_opening and not is_blank and has_content [
      #let is_recto = calc.odd(p)
      #let rule_x = if is_recto { 30.13pt } else { 365.87pt }
      #place(top + left, dx: rule_x, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + rgb("#f15d22")))

      #if is_first [
        #interior-arcs(cfg, opacity: 50%)
      ]
    ]
  ]
)

#set text(
  font: ("Neuzeit Grotesk", "Segoe UI"),
  size: 7.9077pt,
  fill: rgb("#2e2f31"),
  tracking: 0em,
  hyphenate: false
)
#set par(
  leading: 12.72949pt,
  justify: true,
  spacing: 12.72949pt,
  linebreaks: "simple"
)

#set heading(numbering: "1.1")

#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 18.35pt + 18.00pt, below: 15.42pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 10pt, fill: rgb("#f15d22"), stroke: 0.4pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(5.5pt)#text(font: minion, size: 10pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

#show heading.where(level: 3): it => block(width: 100%, breakable: false, sticky: true, above: 14.00pt + 18.00pt, below: 10.00pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 9.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(5.0pt)#text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

#show heading.where(level: 4): it => block(width: 100%, breakable: false, sticky: true, above: 10.00pt + 18.00pt, below: 8.00pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 9pt, fill: rgb("#f15d22"), stroke: 0.2pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(4.5pt)#text(font: minion, size: 9pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

#let legal-alpha(marker, content) = block(width: 100%, inset: (left: 20pt), breakable: true, below: 12.73pt)[
  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content
]

#let legal-roman(marker, content) = block(width: 100%, inset: (left: 40pt), breakable: true, below: 12.73pt)[
  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content
]

// Renderizado de Capítulos 01–09
#render-capitulos-01-09(cfg)


// ------------------------------------------------------------------------------
// 3. REGLAMENTOS DE ÓRGANOS DE GOBIERNO (PÁGINAS 131 A 154)
// ------------------------------------------------------------------------------

// 3.1 REGLAMENTO DE LA ASAMBLEA DE FAMILIA
#pagebreak(to: "odd")
#metadata("reglamentos-start") <reglamentos-start>
#metadata("reg-asamblea-start") <reg-asamblea-start>
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("opening-asamblea") <regulation-opening-marker>
  #regulation-opening(cfg, reg_key: "asamblea")
]
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("ceremonial-blank") <blank-page-marker>
]
#regulation-page(cfg, variant: "A8", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-reglamento-asamblea()
]

// 3.2 REGLAMENTO DEL CONSEJO DE FAMILIA
#pagebreak(to: "odd")
#metadata("reg-consejo-start") <reg-consejo-start>
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("opening-consejo") <regulation-opening-marker>
  #regulation-opening(cfg, reg_key: "consejo")
]
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("ceremonial-blank") <blank-page-marker>
]
#regulation-page(cfg, variant: "A8", reg_name: "CONSEJO DE FAMILIA")[
  #render-reglamento-consejo()
]

// 3.3 REGLAMENTO DEL COMITÉ DE HONOR FAMILIAR
#pagebreak(to: "odd")
#metadata("reg-comite-start") <reg-comite-start>
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("opening-comite") <regulation-opening-marker>
  #regulation-opening(cfg, reg_key: "comite")
]
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("ceremonial-blank") <blank-page-marker>
]
#regulation-page(cfg, variant: "A8", reg_name: "COMITÉ DE HONOR FAMILIAR")[
  #render-reglamento-comite()
]


// ------------------------------------------------------------------------------
// 4. ANEXOS Y FORMATOS OPERATIVOS (PÁGINAS 155 A 170)
// ------------------------------------------------------------------------------

// 4.1 PORTADILLA GENERAL DE ANEXOS (Pág 155 / Recto)
#pagebreak(to: "odd")
#metadata("anexos-start") <anexos-start>
#page(margin: 0pt, header: none, footer: none)[
  #metadata("opening-anexos") <annex-opening-marker>
  #annex-opening(cfg)
]

// 4.2 BLANCO CEREMONIAL (Pág 156 / Verso)
#page(margin: 0pt, header: none, footer: none)[
  #metadata("ceremonial-blank-anexos-01") <blank-page-marker>
]

// 4.3 AVISO DE EXCLUSIVIDAD Y PERSONALIZACIÓN (Pág 157 / Recto / Folio 01)
#metadata("aviso-start") <aviso-start>
#annex-page(
  form_title: "AVISO DE EXCLUSIVIDAD Y PERSONALIZACIÓN",
  short_header_title: "AVISO DE EXCLUSIVIDAD",
  full_header_title: false,
  binding: left,
  start_page: 1
)[
  #render-aviso-exclusividad()
]

// 4.4 CARTA DE ACEPTACIÓN Y ADHESIÓN (Págs 158–159 / Pliego Verso-Recto / Folios 02-03)
#metadata("carta-start") <carta-start>
#annex-page(
  form_title: "CARTA DE ACEPTACIÓN Y ADHESIÓN AL PROTOCOLO FAMILIAR",
  short_header_title: "CARTA DE ADHESIÓN",
  full_header_title: false,
  binding: left,
  start_page: 2
)[
  #render-carta-adhesion()
]

// 4.5 BLANCO CEREMONIAL (Pág 160 / Verso)
#page(margin: 0pt, header: none, footer: none)[
  #metadata("ceremonial-blank-anexos-02") <blank-page-marker>
]

// 4.6 CONVOCATORIA DE ASAMBLEA DE FAMILIA (Pág 161 / Recto / Folio 01)
#metadata("conv-asamblea-start") <conv-asamblea-start>
#annex-page(
  form_title: "CONVOCATORIA DE ASAMBLEA DE FAMILIA",
  short_header_title: "CONVOCATORIA DE ASAMBLEA",
  full_header_title: false,
  binding: left,
  start_page: 1
)[
  #render-convocatoria-asamblea()
]

// 4.7 ACTA DE ASAMBLEA GENERAL FAMILIAR (Págs 162–163 / Pliego Verso-Recto / Folios 02-03)
#metadata("acta-asamblea-start") <acta-asamblea-start>
#annex-page(
  form_title: "ACTA DE ASAMBLEA GENERAL FAMILIAR",
  short_header_title: "ACTA DE ASAMBLEA",
  full_header_title: false,
  binding: left,
  start_page: 2
)[
  #render-acta-asamblea()
]

// 4.8 BLANCO CEREMONIAL (Pág 164 / Verso)
#page(margin: 0pt, header: none, footer: none)[
  #metadata("ceremonial-blank-anexos-03") <blank-page-marker>
]

// 4.9 CONVOCATORIA A SESIÓN DE CONSEJO DE FAMILIA (Pág 165 / Recto / Folio 01)
#metadata("conv-consejo-start") <conv-consejo-start>
#annex-page(
  form_title: "CONVOCATORIA A SESIÓN DE CONSEJO DE FAMILIA",
  short_header_title: "CONVOCATORIA DE CONSEJO",
  full_header_title: false,
  binding: left,
  start_page: 1
)[
  #render-convocatoria-consejo()
]

// 4.10 ACTA DE SESIÓN DEL CONSEJO DE FAMILIA (Págs 166–167 / Pliego Verso-Recto / Folios 02-03)
#metadata("acta-consejo-start") <acta-consejo-start>
#annex-page(
  form_title: "ACTA DE SESIÓN DEL CONSEJO DE FAMILIA",
  short_header_title: "ACTA DEL CONSEJO DE FAMILIA",
  full_header_title: false,
  binding: left,
  start_page: 2
)[
  #render-acta-consejo()
]

// 4.11 ACTA DEL COMITÉ DE HONOR FAMILIAR (Págs 168–169 / Pliego Verso-Recto / Folios 02-03)
#metadata("acta-comite-start") <acta-comite-start>
#annex-page(
  form_title: "ACTA DE CONSTITUCIÓN Y SESIÓN DEL COMITÉ DE HONOR FAMILIAR",
  short_header_title: "ACTA DEL COMITÉ DE HONOR",
  full_header_title: false,
  binding: left,
  start_page: 2
)[
  #render-acta-comite()
]

// 4.12 BLANCO CEREMONIAL DE CIERRE (Pág 170 / Verso)
#page(margin: 0pt, header: none, footer: none)[
  #metadata("ceremonial-blank-anexos-cierre") <blank-page-marker>
]

// ------------------------------------------------------------------------------
// 5. ÍNDICE DE TEMAS Y ANEXOS DEFINITIVO
// ------------------------------------------------------------------------------

#pagebreak(to: "odd")
#metadata("indice-start") <indice-start>
#counter(page).update(171)

#set page(
  width: 396pt,
  height: 612pt,
  margin: (
    top: 48pt,
    bottom: 42pt,
    inside: 48pt,
    outside: 33.44pt
  ),
  header: context [
    #let p = here().position().page
    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)
    #if not is_blank [
      #let is_recto = calc.odd(p)
      #let p_str = if p < 10 { "0" + str(p) } else { str(p) }
      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
      #let minion = ("Minion Pro", "Georgia")
      
      #let hdr_text = if is_recto { "ÍNDICE DE TEMAS Y ANEXOS" } else { "POLIDUCTOS FLEXIBLES, S.A. DE C.V. · PROTOCOLO FAMILIAR" }
      
      #if is_recto [
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          text(font: neuzeit, size: 5.2pt, fill: rgb("#6c6b67"), tracking: 0.140em)[#hdr_text],
          text(font: minion, size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[#p_str]
        )
      ] else [
        #grid(
          columns: (auto, 1fr),
          align: (left, right),
          text(font: minion, size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[#p_str],
          text(font: neuzeit, size: 5.2pt, fill: rgb("#6c6b67"), tracking: 0.140em)[#hdr_text]
        )
      ]
      #v(3pt)
      #line(length: 100%, stroke: 0.6pt + rgb("#f15d22"))
    ]
  ],
  footer: none
)

#render-indice-temas-y-anexos(cfg)


