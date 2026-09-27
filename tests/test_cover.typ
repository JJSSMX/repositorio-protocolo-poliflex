// ==============================================================================
// TEST COVER — FASE 3.2: DISEÑO VISUAL DEFINITIVO (PORTADA GENERAL)
// ==============================================================================
// Documento de prueba aislado que invoca cover-page(cfg) desde el sistema
// de componentes reutilizables (/templates/typst/componentes.typ) y la
// configuración centralizada (/config/editorial_config.yaml).
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#set page(
  width: to-len(cfg.cover.page.width),
  height: to-len(cfg.cover.page.height),
  margin: 0pt
)

#cover-page(cfg)
