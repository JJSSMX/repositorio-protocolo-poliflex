// ==============================================================================
// TEST REGULATION OPENING — FASE 4.4: PROTOTIPO DE APERTURA DE REGLAMENTO
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Documento de prueba y evaluación visual comparativa de regulation-opening().
//
// Estructura ceremonial del documento:
// - Pág. 1 (Recto): chapter-opening() del CAPÍTULO 01 (Referencia locked del sistema).
// - Págs. 2–7: VARIANTE A (Asamblea, Consejo, Comité) con versos en blanco ceremoniales.
// - Págs. 8–13: VARIANTE B (Asamblea, Consejo, Comité) con versos en blanco ceremoniales.
// - Págs. 14–19: VARIANTE C (Asamblea, Consejo, Comité) con versos en blanco ceremoniales.
//
// Cada apertura inicia rigurosamente en RECTO (página impar) precedida por su
// respectivo VERSO ceremonial en blanco (página par).
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

// Helper para salto a página par (Verso en blanco)
#let ceremonial-blank-verso() = {
  pagebreak()
  // Página completamente blanca sin contenido alguno
}

// ------------------------------------------------------------------------------
// PÁGINA 1 (RECTO): REFERENCIA VISUAL DEL SISTEMA LOCKED — CAPÍTULO 01
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
// BLOQUE 1: VARIANTE A (DERIVACIÓN MÁS LITERAL DE CHAPTER-OPENING)
// Sustituye el gran número por "REGLAMENTO" en Minion Pro 20pt naranja.
// Debajo de la regla se despliega el complemento del órgano en Minion Pro 16pt.
// ==============================================================================

// --- REGLAMENTO 11: ASAMBLEA DE FAMILIA (VARIANTE A) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "asamblea", casing: "canonical")

// --- REGLAMENTO 12: CONSEJO DE FAMILIA (VARIANTE A) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "consejo", casing: "canonical")

// --- REGLAMENTO 13: COMITÉ DE HONOR FAMILIAR (VARIANTE A) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "comite", casing: "canonical")

// ==============================================================================
// BLOQUE 2: VARIANTE B (JERARQUÍA ESPECÍFICA CON ADN INSTITUCIONAL NEUZEIT)
// Supra-identificador institucional "REGLAMENTO" en Neuzeit Grotesk 8.5pt tracked naranja.
// Debajo de la regla se despliega el título canónico completo en Minion Pro 16pt.
// ==============================================================================

// --- REGLAMENTO 11: ASAMBLEA DE FAMILIA (VARIANTE B) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "B", reg_key: "asamblea", casing: "canonical")

// --- REGLAMENTO 12: CONSEJO DE FAMILIA (VARIANTE B) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "B", reg_key: "consejo", casing: "canonical")

// --- REGLAMENTO 13: COMITÉ DE HONOR FAMILIAR (VARIANTE B) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "B", reg_key: "comite", casing: "canonical")

// ==============================================================================
// BLOQUE 3: VARIANTE C (VERSIÓN MÁS SOBRIA / REDUCCIÓN CEREMONIAL)
// Sin texto sobre la regla naranja. Regla como umbral ceremonial puro.
// Debajo de la regla se despliega el título canónico completo en Minion Pro 16pt.
// ==============================================================================

// --- REGLAMENTO 11: ASAMBLEA DE FAMILIA (VARIANTE C) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "C", reg_key: "asamblea", casing: "canonical")

// --- REGLAMENTO 12: CONSEJO DE FAMILIA (VARIANTE C) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "C", reg_key: "consejo", casing: "canonical")

// --- REGLAMENTO 13: COMITÉ DE HONOR FAMILIAR (VARIANTE C) ---
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "C", reg_key: "comite", casing: "canonical")
