// ==============================================================================
// TEST REGULATION PAGE FASE 4.5 — COMPARATIVO MULTIPÁGINA
// Comparación entre interior-page() LOCKED y Variantes A, B, C
// Protocolo Familiar POLIFLEX
// ==============================================================================

#import "/templates/typst/componentes_fase_4_experimental.typ": *
#import "/tests/corpus_fase_4_5.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

// ------------------------------------------------------------------------------
// SECCIÓN 1: VARIANTE A (Clásica Institucional)
// ------------------------------------------------------------------------------
#regulation-page(cfg, variant: "A", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "A")
]

#pagebreak()

// ------------------------------------------------------------------------------
// SECCIÓN 2: VARIANTE B (Diferenciación Jurídica Dinámica)
// ------------------------------------------------------------------------------
#regulation-page(cfg, variant: "B", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "B")
]

#pagebreak()

// ------------------------------------------------------------------------------
// SECCIÓN 3: VARIANTE C (Soberanía Normativa Compacta)
// ------------------------------------------------------------------------------
#regulation-page(cfg, variant: "C", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "C")
]
