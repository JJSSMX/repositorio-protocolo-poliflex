// ==============================================================================
// TEST REGULATION PAGE FASE 4.5.1 — MICROVARIANTE A4
// Spacing R4 -> R5: 4.00 pt
// Protocolo Familiar POLIFLEX
// ==============================================================================

#import "/templates/typst/componentes_fase_4_experimental.typ": *
#import "/tests/corpus_fase_4_5.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#show: body => regulation-page(
  cfg,
  variant: "A4",
  reg_name: "ASAMBLEA DE FAMILIA",
  body
)

#render-corpus(variant: "A4")
