// ==============================================================================
// TEST REGULATION OPENING (UPPERCASE) — FASE 4.4
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Suite comparativa complementaria con títulos en mayúsculas sostenidas (ALL CAPS)
// para evaluación editorial directa frente al estándar display de chapter-opening().
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

// Pág. 1 (Recto): Capítulo 01 de referencia locked
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

// BLOQUE 1: VARIANTE A (ALL CAPS)
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "asamblea", casing: "upper")

#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "consejo", casing: "upper")

#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "A", reg_key: "comite", casing: "upper")

// BLOQUE 2: VARIANTE B (ALL CAPS)
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "B", reg_key: "asamblea", casing: "upper")

#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "B", reg_key: "consejo", casing: "upper")

#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "B", reg_key: "comite", casing: "upper")

// BLOQUE 3: VARIANTE C (ALL CAPS)
#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "C", reg_key: "asamblea", casing: "upper")

#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "C", reg_key: "consejo", casing: "upper")

#ceremonial-blank-verso()
#pagebreak()
#regulation-opening(cfg, variant: "C", reg_key: "comite", casing: "upper")
