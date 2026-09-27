// ==============================================================================
// TEST REGULATION OPENING — FASE 4.4.1: MICROAJUSTE FORENSE
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Evaluación de microcalibración vertical de Variante A (ALL CAPS):
// - A0: Baseline Fase 4.4 (dy = 352.00 pt)
// - A-: Desplazamiento -4.00 pt (dy = 348.00 pt)
// - A+: Desplazamiento +4.00 pt (dy = 356.00 pt)
//
// Referencia locked: chapter-opening() del CAPÍTULO 01.
// Paridad estricta: cada apertura en RECTO precedida por VERSO BLANCO ceremonial.
// ==============================================================================

#import "/templates/typst/componentes.typ": *
#import "/templates/typst/componentes_fase_4_experimental.typ": *

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
// PÁGINA 1 (RECTO): REFERENCIA VISUAL LOCKED — CAPÍTULO 01
// ------------------------------------------------------------------------------
#let extract-frontmatter(md-text) = {
  let lines = md-text.split("\n")
  let fm-lines = ()
  let in-fm = false
  for line in lines {
    if line.trim() == "---" {
      if in-fm { break } else { in-fm = true; continue }
    }
    if in-fm { fm-lines.push(line) }
  }
  yaml(bytes(fm-lines.join("\n")))
}

#let ch01 = extract-frontmatter(read("/capitulos/01_capitulo1_declaracion_principios.md"))

#chapter-opening(
  cfg,
  number: ch01.chapter_number,
  title: ch01.title,
  opening_title: ch01.opening_title,
  description: ch01.description,
  is_recto: false
)

// ==============================================================================
// BLOQUE I: CASO CRÍTICO PRINCIPAL — REGLAMENTO DEL COMITÉ DE HONOR FAMILIAR
// Título más largo: "DEL COMITÉ DE / HONOR FAMILIAR"
// ==============================================================================

// --- PÁGINA 3 (RECTO): A0 (BASELINE FASE 4.4, dy = 352.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "comite", upper_dy_offset: 0pt, casing: "upper")

// --- PÁGINA 5 (RECTO): A- (MICROAJUSTE -4.00 pt, dy = 348.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "comite", upper_dy_offset: -4pt, casing: "upper")

// --- PÁGINA 7 (RECTO): A+ (MICROAJUSTE +4.00 pt, dy = 356.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "comite", upper_dy_offset: 4pt, casing: "upper")

// ==============================================================================
// BLOQUE II: MULTI-REGLAMENTO EN CONDICIÓN A0 (BASELINE FASE 4.4)
// Comprobación de equilibrio con los otros dos reglamentos.
// ==============================================================================

// --- PÁGINA 9 (RECTO): A0 — ASAMBLEA DE FAMILIA (dy = 352.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "asamblea", upper_dy_offset: 0pt, casing: "upper")

// --- PÁGINA 11 (RECTO): A0 — CONSEJO DE FAMILIA (dy = 352.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "consejo", upper_dy_offset: 0pt, casing: "upper")

// ==============================================================================
// BLOQUE III: COMPARATIVA COMPLEMENTARIA A- Y A+ EN ASAMBLEA Y CONSEJO
// ==============================================================================

// --- PÁGINA 13 (RECTO): A- — ASAMBLEA DE FAMILIA (-4.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "asamblea", upper_dy_offset: -4pt, casing: "upper")

// --- PÁGINA 15 (RECTO): A- — CONSEJO DE FAMILIA (-4.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "consejo", upper_dy_offset: -4pt, casing: "upper")

// --- PÁGINA 17 (RECTO): A+ — ASAMBLEA DE FAMILIA (+4.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "asamblea", upper_dy_offset: 4pt, casing: "upper")

// --- PÁGINA 19 (RECTO): A+ — CONSEJO DE FAMILIA (+4.00 pt) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "consejo", upper_dy_offset: 4pt, casing: "upper")
