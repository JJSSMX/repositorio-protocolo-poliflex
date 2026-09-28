// ==============================================================================
// TEST OFICIAL PERMANENTE [LOCKED]: FASE 4.6.5 — FAMILIA DE ACTAS
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Importa EXCLUSIVAMENTE templates/typst/componentes.typ (Sección 18)
// y el corpus estructurado derivado tests/corpus_actas_fase_4_6_5.typ
// NO importa componentes_anexos_experimental.typ
// ==============================================================================

#import "/templates/typst/componentes.typ": *
#import "/tests/corpus_actas_fase_4_6_5.typ": *

// 1. ACTA DE ASAMBLEA GENERAL FAMILIAR (Páginas 1–2 / Folios 02–03)
#annex-page(
  form_title: "ACTA DE ASAMBLEA GENERAL FAMILIAR",
  short_header_title: "ACTA DE ASAMBLEA",
  start_page: 2
)[
  #render-acta-asamblea()
]

// 2. ACTA DE SESIÓN DEL CONSEJO DE FAMILIA (Páginas 3–4 / Folios 02–03)
#annex-page(
  form_title: "ACTA DE SESIÓN DEL CONSEJO DE FAMILIA",
  short_header_title: "ACTA DEL CONSEJO DE FAMILIA",
  start_page: 2
)[
  #render-acta-consejo()
]

// 3. ACTA DE CONSTITUCIÓN Y SESIÓN DEL COMITÉ DE HONOR FAMILIAR (Páginas 5–6 / Folios 02–03)
#annex-page(
  form_title: "ACTA DE CONSTITUCIÓN Y SESIÓN DEL COMITÉ DE HONOR FAMILIAR",
  short_header_title: "ACTA DEL COMITÉ DE HONOR",
  start_page: 2
)[
  #render-acta-comite()
]
