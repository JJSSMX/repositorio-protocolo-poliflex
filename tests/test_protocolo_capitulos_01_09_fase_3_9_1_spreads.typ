// ==============================================================================
// SPREADS: Dobles páginas enfrentadas (Verso | Recto) a tamaño 792 × 612 pt
// FASE 3.9.1 — CONSOLIDACIÓN DEL CONTROL EDITORIAL DE PAGINACIÓN
// ==============================================================================

#set page(width: 792pt, height: 612pt, margin: 0pt)

#let master_pdf = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1.pdf"

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

// Pliego 29: [P.56 Verso | P.57 Recto]
#render-spread(56, 57)

// Pliego 30: [P.58 Verso | P.59 Recto]
#render-spread(58, 59)

// Pliego 31: [P.60 Verso | P.61 Recto]
#render-spread(60, 61)

// Pliego 32: [P.62 Verso | P.63 Recto]
#render-spread(62, 63)

// Pliego 33: [P.64 Verso | P.65 Recto]
#render-spread(64, 65)

// Pliego 34: [P.66 Verso | P.67 Recto]
#render-spread(66, 67)

// Pliego 35: [P.68 Verso | P.69 Recto]
#render-spread(68, 69)

// Pliego 36: [P.70 Verso | P.71 Recto]
#render-spread(70, 71)

// Pliego 37: [P.72 Verso | P.73 Recto]
#render-spread(72, 73)

// Pliego 38: [P.74 Verso | P.75 Recto]
#render-spread(74, 75)

// Pliego 39: [P.76 Verso | P.77 Recto]
#render-spread(76, 77)

// Pliego 40: [P.78 Verso | P.79 Recto]
#render-spread(78, 79)

// Pliego 41: [P.80 Verso | P.81 Recto]
#render-spread(80, 81)

// Pliego 42: [P.82 Verso | P.83 Recto]
#render-spread(82, 83)

// Pliego 43: [P.84 Verso | P.85 Recto]
#render-spread(84, 85)

// Pliego 44: [P.86 Verso | P.87 Recto]
#render-spread(86, 87)

// Pliego 45: [P.88 Verso | P.89 Recto]
#render-spread(88, 89)

// Pliego 46: [P.90 Verso | P.91 Recto]
#render-spread(90, 91)

// Pliego 47: [P.92 Verso | P.93 Recto]
#render-spread(92, 93)

// Pliego 48: [P.94 Verso | P.95 Recto]
#render-spread(94, 95)

// Pliego 49: [P.96 Verso | P.97 Recto]
#render-spread(96, 97)

// Pliego 50: [P.98 Verso | P.99 Recto]
#render-spread(98, 99)

// Pliego 51: [P.100 Verso | P.101 Recto]
#render-spread(100, 101)

// Pliego 52: [P.102 Verso | P.103 Recto]
#render-spread(102, 103)

// Pliego 53: [P.104 Verso | P.105 Recto]
#render-spread(104, 105)

// Pliego 54: [P.106 Verso | P.107 Recto]
#render-spread(106, 107)

// Pliego 55: [P.108 Verso | P.109 Recto]
#render-spread(108, 109)

// Pliego 56: [P.110 Verso | P.111 Recto]
#render-spread(110, 111)

// Pliego 57: [P.112 Verso | P.113 Recto]
#render-spread(112, 113)

// Pliego 58: [P.114 Verso | P.115 Recto]
#render-spread(114, 115)

// Pliego 59: [P.116 Verso | P.117 Recto]
#render-spread(116, 117)

// Pliego 60: [P.118 Verso | P.119 Recto]
#render-spread(118, 119)

// Pliego 61: [P.120 Verso | P.121 Recto]
#render-spread(120, 121)

// Pliego 62: [P.122 Verso | P.123 Recto]
#render-spread(122, 123)

// Pliego 63: [P.124 Verso | P.125 Recto]
#render-spread(124, 125)

// Pliego 64: [P.126 Verso | VACÍO Recto]
#render-spread(126, none)
