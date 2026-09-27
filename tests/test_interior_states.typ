// ==============================================================================
// TEST INTERIOR STATES — FASE 3.6.3: CATÁLOGO DE LOS ESTADOS EDITORIALES
// ==============================================================================
// Documento maestro de 3 páginas que compila de manera consecutiva:
//   Página 1: chapter-first-page()       (Estado A — Apertura de Capítulo)
//   Página 2: interior-page() Verso      (Estado B — Continuación Verso)
//   Página 3: interior-page() Recto      (Estado B — Continuación Recto)
// ==============================================================================

#set page(
  width: 396pt,
  height: 612pt,
  margin: 0pt,
  fill: rgb("#ffffff")
)

// 1. Estado A: Apertura interior de capítulo
#image("/dist/TEST_CHAPTER_FIRST_PAGE.pdf", width: 396pt, height: 612pt)

#pagebreak()

// 2. Estado B: Continuación Verso (Página Par)
#image("/dist/TEST_INTERIOR_PAGE_VERSO.pdf", width: 396pt, height: 612pt)

#pagebreak()

// 3. Estado B: Continuación Recto (Página Impar)
#image("/dist/TEST_INTERIOR_PAGE_RECTO.pdf", width: 396pt, height: 612pt)
