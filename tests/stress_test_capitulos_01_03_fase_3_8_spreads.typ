// ==============================================================================
// STRESS TEST CAPÍTULOS 01–03 FASE 3.8 SPREADS
// Dobles páginas enfrentadas (Verso | Recto) a tamaño 792 × 612 pt
// ==============================================================================

#set page(width: 792pt, height: 612pt, margin: 0pt)

#let master_pdf = "/dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8.pdf"

#let render-spread(verso-p, recto-p) = [
  #grid(
    columns: (396pt, 396pt),
    rows: (612pt),
    gutter: 0pt,
    if verso-p != none {
      image(master_pdf, page: verso-p, width: 396pt, height: 612pt)
    } else {
      rect(width: 396pt, height: 612pt, fill: rgb("#ffffff"))[]
    },
    if recto-p != none {
      image(master_pdf, page: recto-p, width: 396pt, height: 612pt)
    } else {
      rect(width: 396pt, height: 612pt, fill: rgb("#ffffff"))[]
    }
  )
]

// Pliego 01: [VACÍO | P.01 Cortesía Recto]
#render-spread(none, 1)

// Pliego 02: [P.02 Verso | P.03 Recto]
#render-spread(2, 3)

// Pliego 03: [P.04 Verso | P.05 Recto]
#render-spread(4, 5)

// Pliego 04: [P.06 Verso | P.07 Recto]
#render-spread(6, 7)

// Pliego 05: [P.08 Verso | P.09 Recto]
#render-spread(8, 9)

// Pliego 06: [P.10 Verso | P.11 Recto]
#render-spread(10, 11)

// Pliego 07: [P.12 Verso | P.13 Recto]
#render-spread(12, 13)

// Pliego 08: [P.14 Verso | P.15 Recto]
#render-spread(14, 15)

// Pliego 09: [P.16 Verso | P.17 Recto]
#render-spread(16, 17)

// Pliego 10: [P.18 Verso | P.19 Recto]
#render-spread(18, 19)

// Pliego 11: [P.20 Verso | P.21 Recto]
#render-spread(20, 21)

// Pliego 12: [P.22 Verso | P.23 Recto]
#render-spread(22, 23)

// Pliego 13: [P.24 Verso | P.25 Recto]
#render-spread(24, 25)

// Pliego 14: [P.26 Verso | P.27 Recto]
#render-spread(26, 27)

// Pliego 15: [P.28 Verso | P.29 Recto]
#render-spread(28, 29)

// Pliego 16: [P.30 Verso | P.31 Recto]
#render-spread(30, 31)

// Pliego 17: [P.32 Verso | P.33 Recto]
#render-spread(32, 33)

// Pliego 18: [P.34 Verso | P.35 Recto]
#render-spread(34, 35)

// Pliego 19: [P.36 Verso | P.37 Recto]
#render-spread(36, 37)

// Pliego 20: [P.38 Verso | P.39 Recto]
#render-spread(38, 39)

// Pliego 21: [P.40 Verso | P.41 Recto]
#render-spread(40, 41)

// Pliego 22: [P.42 Verso | P.43 Recto]
#render-spread(42, 43)

// Pliego 23: [P.44 Verso | P.45 Recto]
#render-spread(44, 45)

// Pliego 24: [P.46 Verso | P.47 Recto]
#render-spread(46, 47)

// Pliego 25: [P.48 Verso | P.49 Recto]
#render-spread(48, 49)

// Pliego 26: [P.50 Verso | P.51 Recto]
#render-spread(50, 51)

// Pliego 27: [P.52 Verso | P.53 Recto]
#render-spread(52, 53)

// Pliego 28: [P.54 Verso | P.55 Recto]
#render-spread(54, 55)

// Pliego 29: [P.56 Verso | VACÍO Recto]
#render-spread(56, none)
