// ==============================================================================
// TEST REGULATION OPENING — FASE 4.4.2: CIERRE Y LOCK DEFINITIVO
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Documento oficial de validación de regulation-opening() [APPROVED / LOCKED].
// Importa exclusivamente desde /templates/typst/componentes.typ (núcleo oficial).
//
// Estructura:
// - Pág. 1 (Recto): REGLAMENTO DE LA ASAMBLEA DE FAMILIA
// - Pág. 2 (Verso): Blanco ceremonial
// - Pág. 3 (Recto): REGLAMENTO DEL CONSEJO DE FAMILIA
// - Pág. 4 (Verso): Blanco ceremonial
// - Pág. 5 (Recto): REGLAMENTO DEL COMITÉ DE HONOR FAMILIAR
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#set page(
  width: to-len(cfg.chapter_opening.page.width),
  height: to-len(cfg.chapter_opening.page.height),
  margin: 0pt,
  fill: rgb("#ffffff")
)

#let ceremonial-blank-verso() = {
  pagebreak()
}

// ------------------------------------------------------------------------------
// 1. REGLAMENTO DE LA ASAMBLEA DE FAMILIA (RECTO NOBLE, PÁG. 1)
// ------------------------------------------------------------------------------
#regulation-opening(cfg, reg_key: "asamblea")

// ------------------------------------------------------------------------------
// 2. REGLAMENTO DEL CONSEJO DE FAMILIA (RECTO NOBLE, PÁG. 3)
// ------------------------------------------------------------------------------
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, reg_key: "consejo")

// ------------------------------------------------------------------------------
// 3. REGLAMENTO DEL COMITÉ DE HONOR FAMILIAR (RECTO NOBLE, PÁG. 5)
// ------------------------------------------------------------------------------
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, reg_key: "comite")
