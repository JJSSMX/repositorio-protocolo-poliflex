// ==============================================================================
// TEST CHAPTER OPENING — FASE 3.4: DISEÑO VISUAL DEFINITIVO (APERTURA DE CAPÍTULO)
// ==============================================================================
// Documento de prueba aislado que invoca chapter-opening(cfg) obteniendo los datos
// directamente desde la fuente canónica /capitulos/01_capitulo1_declaracion_principios.md
// y la configuración centralizada (/config/editorial_config.yaml).
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#set page(
  width: to-len(cfg.chapter_opening.page.width),
  height: to-len(cfg.chapter_opening.page.height),
  margin: 0pt,
  fill: rgb("#fffdf0")
)

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

#let ch = extract-frontmatter(read("/capitulos/01_capitulo1_declaracion_principios.md"))

#chapter-opening(
  cfg,
  number: ch.chapter_number,
  title: ch.title,
  opening_title: ch.opening_title,
  description: ch.description,
  is_recto: false
)
