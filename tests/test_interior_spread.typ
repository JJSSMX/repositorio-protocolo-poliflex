// ==============================================================================
// TEST INTERIOR SPREAD — FASE 3.6.2: RETÍCULA HORIZONTAL ESPECULAR
// ==============================================================================
// Doble página enfrentada (Spread: 792 × 612 pt)
// Verso a la izquierda (0 a 396 pt) | Recto a la derecha (396 a 792 pt)
// Eje central del lomo en x = 396 pt
// ==============================================================================

#set page(
  width: 792pt,
  height: 612pt,
  margin: 0pt,
  fill: rgb("#ffffff")
)

// 1. Página Verso (Izquierda: corte en x=0, lomo en x=396)
#place(top + left, dx: 0pt, dy: 0pt, image("/dist/TEST_INTERIOR_PAGE_VERSO.pdf", width: 396pt, height: 612pt))

// 2. Página Recto (Derecha: lomo en x=396, corte en x=792)
#place(top + left, dx: 396pt, dy: 0pt, image("/dist/TEST_CHAPTER_FIRST_PAGE.pdf", width: 396pt, height: 612pt))
