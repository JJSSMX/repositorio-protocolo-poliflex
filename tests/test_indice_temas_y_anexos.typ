// ==============================================================================
// TEST INDEPENDIENTE: ÍNDICE DE TEMAS Y ANEXOS [FASE 4.8]
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
#import "/templates/typst/componentes.typ": *
#import "/templates/typst/indice_temas_y_anexos.typ": *
#import "/tests/corpus_capitulos_01_09.typ": *
#import "/tests/corpus_reglamentos_fase_4_5_8.typ": *
#import "/tests/corpus_actas_fase_4_6_5.typ": *
#import "/tests/corpus_convocatorias_fase_4_6_7.typ": *
#import "/tests/corpus_anexos_adicionales_fase_4_7.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#set document(title: "Índice de Temas y Anexos - Protocolo Familiar POLIFLEX")

// PÁG 01 A 06: Front Matter
#cover-page(cfg)
#page(margin: 0pt, header: none, footer: none)[]
#page(margin: 0pt, header: none, footer: none)[
  #metadata("toc-start") <toc-start>
  #dynamic-table-of-contents(cfg)
]
#page(margin: 0pt, header: none, footer: none)[]
#introduction-page(cfg, page_num: 5, show_spread: false)
#page(margin: 0pt, header: none, footer: none)[]

// Capítulos 01–09
#set heading(numbering: "1.1")
#show heading.where(level: 2): it => block[#it]
#show heading.where(level: 3): it => block[#it]
#show heading.where(level: 4): it => block[#it]
#render-capitulos-01-09(cfg)

// Reglamentos
#pagebreak(to: "odd")
#metadata("reglamentos-start") <reglamentos-start>
#metadata("reg-asamblea-start") <reg-asamblea-start>
#page[#metadata("opening-asamblea") <regulation-opening-marker>]
#page[]
#regulation-page(cfg, variant: "A8", reg_name: "ASAMBLEA DE FAMILIA")[#render-reglamento-asamblea()]

#pagebreak(to: "odd")
#metadata("reg-consejo-start") <reg-consejo-start>
#page[#metadata("opening-consejo") <regulation-opening-marker>]
#page[]
#regulation-page(cfg, variant: "A8", reg_name: "CONSEJO DE FAMILIA")[#render-reglamento-consejo()]

#pagebreak(to: "odd")
#metadata("reg-comite-start") <reg-comite-start>
#page[#metadata("opening-comite") <regulation-opening-marker>]
#page[]
#regulation-page(cfg, variant: "A8", reg_name: "COMITÉ DE HONOR FAMILIAR")[#render-reglamento-comite()]

// Anexos
#pagebreak(to: "odd")
#metadata("anexos-start") <anexos-start>
#page[#metadata("opening-anexos") <annex-opening-marker>]
#page[]
#metadata("aviso-start") <aviso-start>
#page[]
#metadata("carta-start") <carta-start>
#page[]
#page[]
#page[]
#metadata("conv-asamblea-start") <conv-asamblea-start>
#page[]
#metadata("acta-asamblea-start") <acta-asamblea-start>
#page[]
#page[]
#page[]
#metadata("conv-consejo-start") <conv-consejo-start>
#page[]
#metadata("acta-consejo-start") <acta-consejo-start>
#page[]
#page[]
#metadata("acta-comite-start") <acta-comite-start>
#page[]
#page[]
#page[]

// Índice de Temas y Anexos
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
