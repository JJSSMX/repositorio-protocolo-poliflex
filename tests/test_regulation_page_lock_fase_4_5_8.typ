// ==============================================================================
// VALIDACIÓN OFICIAL LOCKED: FASE 4.5.8
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// Importa EXCLUSIVAMENTE templates/typst/componentes.typ
// Configuración LOCKED: H2 + O1 (12.72949 pt) + A12 (12.00 pt) + T12 + M1
// ==============================================================================

#import "/templates/typst/componentes.typ": *
#import "/tests/corpus_reglamentos_fase_4_5_8.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#set page(width: 396pt, height: 612pt, margin: 0pt, fill: rgb("#ffffff"))

// 1. REGLAMENTO DE LA ASAMBLEA DE FAMILIA
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("opening-asamblea") <regulation-opening-marker>
  #regulation-opening(cfg, reg_key: "asamblea")
]
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("ceremonial-blank") <blank-page-marker>
]
#regulation-page(cfg, reg_name: "ASAMBLEA DE FAMILIA")[
  #render-reglamento-asamblea()
]

// 2. REGLAMENTO DEL CONSEJO DE FAMILIA
#pagebreak(to: "odd")
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("opening-consejo") <regulation-opening-marker>
  #regulation-opening(cfg, reg_key: "consejo")
]
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("ceremonial-blank") <blank-page-marker>
]
#regulation-page(cfg, reg_name: "CONSEJO DE FAMILIA")[
  #render-reglamento-consejo()
]

// 3. REGLAMENTO DEL COMITÉ DE HONOR FAMILIAR
#pagebreak(to: "odd")
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("opening-comite") <regulation-opening-marker>
  #regulation-opening(cfg, reg_key: "comite")
]
#page(margin: 0pt, header: none, footer: none, fill: rgb("#ffffff"))[
  #metadata("ceremonial-blank") <blank-page-marker>
]
#regulation-page(cfg, reg_name: "COMITÉ DE HONOR FAMILIAR")[
  #render-reglamento-comite()
]
