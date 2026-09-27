// ==============================================================================
// TEST REGULATION PAGE FASE 4.5 — VARIANTE A
// Protocolo Familiar POLIFLEX
// ==============================================================================

#import "/templates/typst/componentes_fase_4_experimental.typ": *
#import "/tests/corpus_fase_4_5.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#show: body => regulation-page(
  cfg,
  variant: "A",
  reg_name: "ASAMBLEA DE FAMILIA",
  body
)

#render-corpus(variant: "A")
