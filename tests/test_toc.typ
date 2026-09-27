// ==============================================================================
// TEST TOC — FASE 3.3: DISEÑO VISUAL DEFINITIVO (TABLA DE CONTENIDOS)
// ==============================================================================
// Documento de prueba aislado que invoca table-of-contents(cfg) desde el sistema
// de componentes reutilizables (/templates/typst/componentes.typ) y la
// configuración centralizada (/config/editorial_config.yaml).
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#set page(
  width: to-len(cfg.toc.page.width),
  height: to-len(cfg.toc.page.height),
  margin: 0pt,
  fill: rgb("#ffffff")
)

#table-of-contents(cfg)
