// ==============================================================================
// TEST REGRESIÓN LOCKED: ÍNDICE DE TEMAS Y ANEXOS [FASE 4.8 · LOCKED]
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Parámetros LOCKED:
// - Composición de 4 páginas (Págs. 171 a 174 en pliego simétrico 87)
// - Apertura en Recto (Pág. 171) y cierre natural en Verso (Pág. 174)
// - 2 columnas balanceadas, column-gutter 14 pt
// - Sangrías jerárquicas: N1 (0 pt), N2 (10 pt), N3 (20 pt), N4 (30 pt)
// - Líderes de puntos `#repeat` espaciados con folio alineado a la derecha
// - Paginación 100% dinámica (0 números hardcodeados)
// - Cobertura: 220 referencias canónicas + 5 secciones estructurales
// ==============================================================================

#import "/templates/typst/componentes.typ": *
#import "/templates/typst/indice_temas_y_anexos.typ": render-indice-temas-y-anexos

#let cfg = yaml("/config/editorial_config.yaml")

#set document(title: "Índice de Temas y Anexos - Lock Fase 4.8")

#set page(
  width: 396pt,
  height: 612pt,
  margin: (
    top: 48pt,
    bottom: 42pt,
    inside: 48pt,
    outside: 33.44pt
  ),
  header: context [
    #let p = here().position().page
    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)
    #if not is_blank [
      #let is_recto = calc.odd(p)
      #let p_str = if p < 10 { "0" + str(p) } else { str(p) }
      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
      #let minion = ("Minion Pro", "Georgia")
      
      #let hdr_text = if is_recto { "ÍNDICE DE TEMAS Y ANEXOS" } else { "POLIDUCTOS FLEXIBLES, S.A. DE C.V. · PROTOCOLO FAMILIAR" }
      
      #if is_recto [
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          text(font: neuzeit, size: 5.2pt, fill: rgb("#6c6b67"), tracking: 0.140em)[#hdr_text],
          text(font: minion, size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[#p_str]
        )
      ] else [
        #grid(
          columns: (auto, 1fr),
          align: (left, right),
          text(font: minion, size: 7.5pt, fill: rgb("#f15d22"), weight: "bold")[#p_str],
          text(font: neuzeit, size: 5.2pt, fill: rgb("#6c6b67"), tracking: 0.140em)[#hdr_text]
        )
      ]
      #v(3pt)
      #line(length: 100%, stroke: 0.6pt + rgb("#f15d22"))
    ]
  ],
  footer: none
)

#render-indice-temas-y-anexos(cfg)
