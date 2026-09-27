// ==============================================================================
// TEST INTERIOR CONTINUATION SPREAD — FASE 3.6.3: SPREAD DE CONTINUACIÓN
// ==============================================================================
// Doble página enfrentada de continuación (Spread: 792 × 612 pt)
// Verso de continuación a la izquierda (0 a 396 pt)
// Recto de continuación a la derecha (396 a 792 pt)
// Permite evaluar visual y matemáticamente que ambas páginas son
// verdaderamente especulares.
// ==============================================================================

#set page(
  width: 792pt,
  height: 612pt,
  margin: 0pt,
  fill: rgb("#ffffff")
)

// 1. Verso de Continuación (Izquierda: corte en x=0, lomo en x=396)
#place(top + left, dx: 0pt, dy: 0pt, image("/dist/TEST_INTERIOR_PAGE_VERSO.pdf", width: 396pt, height: 612pt))

// 2. Recto de Continuación (Derecha: lomo en x=396, corte en x=792)
#place(top + left, dx: 396pt, dy: 0pt, image("/dist/TEST_INTERIOR_PAGE_RECTO.pdf", width: 396pt, height: 612pt))
