// ==============================================================================
// TEST CHAPTER OPENINGS ALL — FASE 3.4: COMPOSICIÓN EDITORIAL MULTI-CAPÍTULO
// ==============================================================================
// Validación de las 9 portadas de capítulo obtenidas directamente desde la
// fuente canónica /capitulos/*.md (frontmatter YAML) con saltos editoriales
// controlados (opening_title) y espaciado dinámico vertical.
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
      if in-fm {
        break
      } else {
        in-fm = true
        continue
      }
    }
    if in-fm {
      fm-lines.push(line)
    }
  }
  yaml(bytes(fm-lines.join("\n")))
}

#let chapter-files = (
  "/capitulos/01_capitulo1_declaracion_principios.md",
  "/capitulos/02_capitulo2_propiedad_control_liquidez.md",
  "/capitulos/03_capitulo3_gobierno_profesionalizacion.md",
  "/capitulos/04_capitulo4_sucesion_familiar.md",
  "/capitulos/05_capitulo5_control_informacion_comunicacion.md",
  "/capitulos/06_capitulo6_disciplina_financiera.md",
  "/capitulos/07_capitulo7_procedimiento_sancionador.md",
  "/capitulos/08_capitulo8_solucion_conflictos.md",
  "/capitulos/09_capitulo9_regimen_juridico.md",
)

#for (i, fpath) in chapter-files.enumerate() {
  if i > 0 {
    pagebreak()
  }
  let fm = extract-frontmatter(read(fpath))
  chapter-opening(
    cfg,
    number: fm.chapter_number,
    title: fm.title,
    opening_title: fm.opening_title,
    description: fm.description,
    is_recto: false
  )
}
