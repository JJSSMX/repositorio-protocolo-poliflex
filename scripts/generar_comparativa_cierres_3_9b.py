#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
GENERADOR DE COMPARATIVA DE CIERRES EDITORIALES — FASE 3.9B
Capítulos 04 / 08 / 09
Genera:
  dist/TEST_CIERRES_04_08_09_COMPARATIVA.pdf (4 láminas A3 apaisadas)
  y renders PNG en artefactos:
  cierre_comparativa_lamina_01.png
  cierre_comparativa_lamina_02.png
  cierre_comparativa_lamina_03.png
  cierre_comparativa_lamina_04.png
"""

import os
import sys
import subprocess
import shutil
import pymupdf

if sys.stdout.encoding.lower() != 'utf-8':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except Exception:
        pass

REPO_DIR = r'C:\Users\JJSS\Desktop\ABC\repositorio_protocolo'
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
ARTIFACTS_DIR = r'C:\Users\JJSS\.gemini\antigravity-cli\brain\44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2'

# Rutas de Spreads
SP_BASE = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf"
SP_CAP04_B = "/dist/TEST_CAP04_B_SPREADS.pdf"
SP_CAP08_B = "/dist/TEST_CAP08_B_SPREADS.pdf"
SP_CAP08_C = "/dist/TEST_CAP08_C_SPREADS.pdf"
SP_PHASE39 = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1_SPREADS.pdf"

# Rutas de Páginas Individuales
PG_BASE = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09.pdf"
PG_CAP04_B = "/dist/TEST_CAP04_B.pdf"
PG_CAP08_B = "/dist/TEST_CAP08_B.pdf"
PG_CAP08_C = "/dist/TEST_CAP08_C.pdf"
PG_PHASE39 = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1.pdf"

OUT_TYP = os.path.join(TESTS_DIR, 'test_cierres_04_08_09_comparativa.typ')
OUT_PDF = os.path.join(DIST_DIR, 'TEST_CIERRES_04_08_09_COMPARATIVA.pdf')

def build_typst():
    typ = [
        '// ==============================================================================',
        '// COMPARATIVA DE CIERRES EDITORIALES — FASE 3.9B',
        '// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)',
        '// Evaluación Compositiva y Visual: Capítulos 04, 08 y 09',
        '// Formato: A3 Apaisado (1190.55 × 841.89 pt)',
        '// ==============================================================================',
        '',
        '#set page(',
        '  paper: "a3",',
        '  flipped: true,',
        '  margin: (x: 1.8cm, top: 1.5cm, bottom: 1.3cm),',
        '  header: context [',
        '    #grid(',
        '      columns: (1fr, auto),',
        '      align: (left, right),',
        '      [',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, weight: "bold", fill: rgb("#d35400"))[',
        '          PROTOCOLO FAMILIAR POLIFLEX · FASE 3.9B: MICROPRUEBA FINAL DE CIERRES EDITORIALES',
        '        ]',
        '        #h(8pt)',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '          | EVALUACIÓN DE REDISTRIBUCIÓN MÍNIMA (CAPÍTULOS 04 / 08 / 09)',
        '        ]',
        '      ],',
        '      [',
        '        #let p = counter(page).get().first()',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "medium", fill: rgb("#2e2f31"))[',
        '          Lámina #p de 4',
        '        ]',
        '      ]',
        '    )',
        '    #v(3pt)',
        '    #line(length: 100%, stroke: 0.5pt + rgb("#e2e2e2"))',
        '  ],',
        '  footer: [',
        '    #line(length: 100%, stroke: 0.5pt + rgb("#e2e2e2"))',
        '    #v(3pt)',
        '    #grid(',
        '      columns: (1fr, 1fr),',
        '      align: (left, right),',
        '      [',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[',
        '          Fase 3.9B · Cierres 04 / 08 / 09 · Retícula +6 mm · Fuentes Canónicas `/capitulos/*.md` Read-Only',
        '        ]',
        '      ],',
        '      [',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[',
        '          126 Páginas Físicas · Paridad Preservada · Cero Modificación en Producción',
        '        ]',
        '      ]',
        '    )',
        '  ]',
        ')',
        '',
        f'#let sp_base = "{SP_BASE}"',
        f'#let sp_cap04_b = "{SP_CAP04_B}"',
        f'#let sp_cap08_b = "{SP_CAP08_B}"',
        f'#let sp_cap08_c = "{SP_CAP08_C}"',
        f'#let sp_phase39 = "{SP_PHASE39}"',
        '',
        f'#let pg_base = "{PG_BASE}"',
        f'#let pg_cap04_b = "{PG_CAP04_B}"',
        f'#let pg_cap08_b = "{PG_CAP08_B}"',
        f'#let pg_cap08_c = "{PG_CAP08_C}"',
        f'#let pg_phase39 = "{PG_PHASE39}"',
        '',
        '#let spread-box(pdf-path, p-num, w: 520pt, h: 401.8pt) = [',
        '  #box(',
        '    stroke: 0.75pt + rgb("#cccccc"),',
        '    radius: 1pt,',
        '    fill: white,',
        '    width: w,',
        '    height: h,',
        '    clip: true,',
        '    image(pdf-path, page: p-num, width: w, height: h)',
        '  )',
        ']',
        '',
        '#let meta-table(items) = [',
        '  #table(',
        '    columns: (auto, 1fr),',
        '    stroke: (x, y) => if y == 0 { (bottom: 0.5pt + rgb("#dcdcdc")) } else { (bottom: 0.3pt + rgb("#eeeeee")) },',
        '    fill: (col, row) => if calc.even(row) { rgb("#fbfbfb") } else { white },',
        '    inset: (x: 6pt, y: 3.5pt),',
        '    ..items.map(it => (',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#444444"))[#it.at(0)],',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, fill: rgb("#2e2f31"))[#it.at(1)]',
        '    )).flatten()',
        '  )',
        ']',
        '',
        '// ==============================================================================',
        '// LÁMINA 01: CAPÍTULO 04 — CIERRE PLIEGO 44 [P.86 | P.87]',
        '// ==============================================================================',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[',
        '  LÁMINA 01 / 04: CAPÍTULO 04 — CIERRE PLIEGO 44 [P.86 VERSO | P.87 RECTO]',
        ']',
        '#v(1pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '  Comparativa: Alternativa A (Flujo Natural · Residuo de 2 líneas) vs Alternativa B (Redistribución Mínima · Párrafo 2 completo en P.87)',
        ']',
        '#v(8pt)',
        '',
        '#grid(',
        '  columns: (1fr, 1fr),',
        '  gutter: 20pt,',
        '  [',
        '    #align(center)[',
        '      #box(fill: rgb("#c0392b"), radius: 2pt, inset: (x: 10pt, y: 4pt))[',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: white)[ALTERNATIVA A: FLUJO NATURAL (Residuo de 2 líneas)]',
        '      ]',
        '    ]',
        '    #v(4pt)',
        '    #align(center)[#spread-box(sp_base, 44, w: 520pt, h: 401.8pt)]',
        '    #v(6pt)',
        '    #meta-table((',
        '      ("Página Verso (P.86)", "4.9.2 (4 lín.) + 4.9.3 (H3 + 10 lín.) + 4.9.4 (H3 + P1 [5 lín.] + P2 [3 lín.]) · 27 lín."),',
        '      ("Cota y Ocupación P.86", "y = 70.42 a 527.24 pt · Ocupación: 96.0% (456.82 pt útiles)"),',
        '      ("Blanco residual P.86", "19.76 pt libres al pie (~1.5 líneas)"),',
        '      ("Página Recto (P.87)", "Solo 2 líneas del párrafo 2 de 4.9.4 («momento, el cuadro accionario...»)"),',
        '      ("Cota y Ocupación P.87", "y = 70.42 a 96.33 pt · Ocupación: 5.4% (25.91 pt útiles)"),',
        '      ("Blanco residual P.87", "450.67 pt libres (94.6% de la página totalmente vacía)"),',
        '      ("Unidad trasladada", "NINGUNA (quiebre accidental forzado por fin de caja)"),',
        '      ("Diagnóstico", "DEFICIENTE: Clausura de capítulo accidental con 2 líneas huérfanas")',
        '    ))',
        '  ],',
        '  [',
        '    #align(center)[',
        '      #box(fill: rgb("#27ae60"), radius: 2pt, inset: (x: 10pt, y: 4pt))[',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: white)[ALTERNATIVA B: REDISTRIBUCIÓN MÍNIMA (5 líneas completas)]',
        '      ]',
        '    ]',
        '    #v(4pt)',
        '    #align(center)[#spread-box(sp_cap04_b, 44, w: 520pt, h: 401.8pt)]',
        '    #v(6pt)',
        '    #meta-table((',
        '      ("Página Verso (P.86)", "4.9.2 (4 lín.) + 4.9.3 (H3 + 10 lín.) + 4.9.4 (H3 + P1 completo [5 lín.]) · 24 lín."),',
        '      ("Cota y Ocupación P.86", "y = 70.42 a 473.24 pt · Ocupación: 84.6% (402.82 pt útiles)"),',
        '      ("Blanco residual P.86", "73.76 pt libres al pie (~5.8 líneas · respiración noble, NO hueco)"),',
        '      ("Página Recto (P.87)", "Párrafo conclusivo de 4.9.4 ÍNTEGRO (5 líneas con sentido normativo pleno)"),',
        '      ("Cota y Ocupación P.87", "y = 70.42 a 150.33 pt · Ocupación: 16.8% (79.91 pt útiles)"),',
        '      ("Blanco residual P.87", "396.67 pt libres"),',
        '      ("Unidad trasladada", "Párrafo 2 de 4.9.4 completo («Concluido el procedimiento y cumplidas...»)"),',
        '      ("Diagnóstico", "ÓPTIMO: P.86 cierra con solidez (84.6%) y P.87 gana dignidad (5 líneas)")',
        '    ))',
        '  ]',
        ')',
        '',
        '#pagebreak()',
        '',
        '// ==============================================================================',
        '// LÁMINA 02: CAPÍTULO 08 (PRIORITARIO) — CUADRÍPTICA A / B / C / D',
        '// ==============================================================================',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[',
        '  LÁMINA 02 / 04: CAPÍTULO 08 — PLIEGO 60 [P.118 VERSO | P.119 RECTO] — CUADRÍPTICA A / B / C / D',
        ']',
        '#v(1pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '  Comparativa visual simultánea de las cuatro alternativas de partición para la Sección 8.9 (Coordinación con el Régimen Sancionador)',
        ']',
        '#v(6pt)',
        '',
        '#grid(',
        '  columns: (1fr, 1fr),',
        '  rows: (auto, auto),',
        '  gutter: 14pt,',
        '  [',
        '    #grid(',
        '      columns: (auto, 1fr),',
        '      align: (left, right),',
        '      box(fill: rgb("#c0392b"), radius: 2pt, inset: (x: 8pt, y: 3pt))[',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: white)[A. FLUJO NATURAL (P.119: 2 lín.)]',
        '      ],',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, fill: rgb("#6c6b67"))[P.118: 93.5% | P.119: 5.4%]',
        '    )',
        '    #v(3pt)',
        '    #spread-box(sp_base, 60, w: 480pt, h: 240pt)',
        '    #v(3pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#444444"))[',
        '      • *P.118:* 8.7 + 8.8 + 8.9 (H2 + P1 + P2) = 25 lín. (31 pt blanco) \\\n',
        '      • *P.119:* 8.9 P3 (2 lín., 450 pt blanco) · *Defecto:* Residuo terminal extremo.',
        '    ]',
        '  ],',
        '  [',
        '    #grid(',
        '      columns: (auto, 1fr),',
        '      align: (left, right),',
        '      box(fill: rgb("#d35400"), radius: 2pt, inset: (x: 8pt, y: 3pt))[',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: white)[B. PÁRRAFO 1 CON HEADING (P.119: 5 lín.)]',
        '      ],',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, fill: rgb("#6c6b67"))[P.118: 82.2% | P.119: 16.8%]',
        '    )',
        '    #v(3pt)',
        '    #spread-box(sp_cap08_b, 60, w: 480pt, h: 240pt)',
        '    #v(3pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#444444"))[',
        '      • *P.118:* 8.7 + 8.8 + 8.9 (H2 + P1) = 22 lín. (85 pt blanco) \\\n',
        '      • *P.119:* 8.9 P2 + P3 (5 lín., 396 pt blanco) · *Defecto:* H2 en P.118; P.119 sin título.',
        '    ]',
        '  ],',
        '  [',
        '    #grid(',
        '      columns: (auto, 1fr),',
        '      align: (left, right),',
        '      box(fill: rgb("#7f8c8d"), radius: 2pt, inset: (x: 8pt, y: 3pt))[',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: white)[C. REDISTRIBUCIÓN INTERMEDIA (8.8 P3 a P.119)]',
        '      ],',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, fill: rgb("#6c6b67"))[P.118: 57.5% | P.119: 41.5%]',
        '    )',
        '    #v(3pt)',
        '    #spread-box(sp_cap08_c, 60, w: 480pt, h: 240pt)',
        '    #v(3pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#444444"))[',
        '      • *P.118:* 8.7 + 8.8 (P1+P2) = 17 lín. (203 pt blanco) \\\n',
        '      • *P.119:* 8.8 P3 (2 lín.) + 8.9 completo (11 lín.) = 13 lín. · *Defecto:* Fragmenta 8.8.',
        '    ]',
        '  ],',
        '  [',
        '    #grid(',
        '      columns: (auto, 1fr),',
        '      align: (left, right),',
        '      box(fill: rgb("#27ae60"), radius: 2pt, inset: (x: 8pt, y: 3pt))[',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: white)[D. SECCIÓN 8.9 COMPLETA (Fase 3.9)]',
        '      ],',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, fill: rgb("#6c6b67"))[P.118: 65.0% | P.119: 29.0%]',
        '    )',
        '    #v(3pt)',
        '    #spread-box(sp_phase39, 60, w: 480pt, h: 240pt)',
        '    #v(3pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#444444"))[',
        '      • *P.118:* 8.7 + 8.8 completos = 19 lín. (167 pt blanco · respiración lógica de sección) \\\n',
        '      • *P.119:* 8.9 completo (H2 + 3 párrafos = 11 lín., 29.0% ocupación) · *0% Fragmentación*.',
        '    ]',
        '  ]',
        ')',
        '',
        '#pagebreak()',
        '',
        '// ==============================================================================',
        '// LÁMINA 03: CAPÍTULO 08 — MATRIZ FORENSE Y DICTAMEN TÉCNICO',
        '// ==============================================================================',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[',
        '  LÁMINA 03 / 04: CAPÍTULO 08 — MATRIZ FORENSE COMPARATIVA Y EVALUACIÓN EDITORIAL',
        ']',
        '#v(1pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '  Ponderación de criterios: Equilibrio P.118 | P.119, Blanco Residual, Fragmentación, Continuidad y Naturalidad del Salto',
        ']',
        '#v(8pt)',
        '',
        '#table(',
        '  columns: (1.5fr, 1.2fr, 1.2fr, 1.3fr, 1.3fr),',
        '  stroke: 0.4pt + rgb("#dcdcdc"),',
        '  fill: (col, row) => if row == 0 { rgb("#f4f4f4") } else if calc.even(row) { rgb("#fafafa") } else { white },',
        '  inset: (x: 8pt, y: 5pt),',
        '  text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold")[CRITERIO EDITORIAL],',
        '  text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold")[A. FLUJO NATURAL],',
        '  text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold")[B. P1 CON HEADING],',
        '  text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold")[C. REDISTRIB. INTERMEDIA],',
        '  text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold")[D. SECCIÓN COMPLETA],',
        '',
        '  [Líneas en P.118 (Verso)], [25 líneas (3 H2 + 19 lín.)], [22 líneas (3 H2 + 16 lín.)], [17 líneas (2 H2 + 12 lín.)], [*19 líneas (2 H2 + 14 lín.)*],',
        '  [Líneas en P.119 (Recto)], [2 líneas (solo P3)], [5 líneas (P2 + P3)], [13 líneas (8.8 P3 + 8.9)], [*11 líneas (H2 + 7 lín.)*],',
        '  [Ocupación vertical P.118], [93.5% (445.11 pt)], [82.2% (391.11 pt)], [57.5% (273.56 pt)], [*65.0% (309.56 pt)*],',
        '  [Ocupación vertical P.119], [5.4% (25.91 pt)], [16.8% (79.91 pt)], [41.5% (197.46 pt)], [*29.0% (138.01 pt)*],',
        '  [Blanco residual P.118], [31.64 pt libres], [85.64 pt libres], [203.19 pt libres], [*167.19 pt libres*],',
        '  [Blanco residual P.119], [450.67 pt (94.6% vacía)], [396.67 pt (83.2% vacía)], [279.12 pt (58.5% vacía)], [*338.74 pt (71.0% vacía)*],',
        '  [Fragmentación de Sección], [*FRACTURADA:* 8.9 partida], [*FRACTURADA:* 8.9 partida], [*FRACTURADA:* 8.8 partida], [*0% FRAGMENTACIÓN*],',
        '  [Continuidad de Lectura], [Corta antes de última línea], [Corta tras primer párrafo], [Corta 8.8 al final], [*Óptima:* Corte inter-sección],',
        '  [Presencia de H2 en P.119], [AUSENTE (en P.118)], [AUSENTE (en P.118)], [PRESENTE (tras 8.8 P3)], [*PRESENTE al tope*],',
        '  [Naturalidad del Salto], [Mecánica pero accidentada], [Artificial intra-sección], [Incoherente (rompe 8.8)], [*Editorial:* Pausa formal],',
        '  [Total Páginas Físicas], [126 páginas], [126 páginas], [126 páginas], [*126 páginas*],',
        '  [Dictamen Forense], [RECHAZADA (residuo débil)], [VIABLE pero mutila H2], [RECHAZADA (rompe 8.8)], [*RECOMENDADA (nobleza y orden)*]',
        ')',
        '#v(10pt)',
        '',
        '#grid(',
        '  columns: (1fr, 1fr),',
        '  gutter: 14pt,',
        '  [',
        '    #box(fill: rgb("#fffbf7"), stroke: 0.5pt + rgb("#d35400"), inset: 8pt, radius: 2pt, width: 100%)[',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: rgb("#d35400"))[EVALUACIÓN DE ALTERNATIVA B (Párrafo 1 con Heading):]',
        '      #v(3pt)',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[',
        '        La Alternativa B tiene la virtud de poblar P.119 con 5 líneas (P2 y P3 juntos), evitando el residuo de 2 líneas sin forzar a P.118 a un blanco excesivo (conserva 82.2% de ocupación). Sin embargo, su debilidad estructural radica en que el encabezado «8.9 Coordinación con el Régimen Sancionador» queda alojado al fondo de P.118 y solo gobierna a un párrafo de 2 líneas, mientras que P.119 arranca directamente con un párrafo huérfano de título normativo.',
        '      ]',
        '    ]',
        '  ],',
        '  [',
        '    #box(fill: rgb("#f4fdf6"), stroke: 0.5pt + rgb("#27ae60"), inset: 8pt, radius: 2pt, width: 100%)[',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: rgb("#27ae60"))[EVALUACIÓN DE ALTERNATIVA D (Sección 8.9 Completa):]',
        '      #v(3pt)',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[',
        '        La Alternativa D traslada la Sección 8.9 completa hacia P.119. Esto deja a P.118 con 167 pt de espacio libre al fondo (65.0% de ocupación), lo cual constituye una pausa visual perfectamente lógica porque concluye con la Sección 8.8 completa. A cambio, P.119 recibe el encabezado formal H2 y los 3 párrafos normativos (29.0% de ocupación), culminando el capítulo con una arquitectura jurídica impecable, autosuficiente y de cero fragmentación.',
        '      ]',
        '    ]',
        '  ]',
        ')',
        '',
        '#pagebreak()',
        '',
        '// ==============================================================================',
        '// LÁMINA 04: CAPÍTULO 09 — CIERRE PLIEGOS 63 Y 64',
        '// ==============================================================================',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[',
        '  LÁMINA 04 / 04: CAPÍTULO 09 — CIERRE DEL PROTOCOLO (PLIEGOS 63 Y 64)',
        ']',
        '#v(1pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '  Comparativa: Alternativa A (Flujo Natural · 9.8 fragmentada) vs Alternativa B (Sección 9.8 Completa en Pliego 64)',
        ']',
        '#v(8pt)',
        '',
        '#grid(',
        '  columns: (1fr, 1fr),',
        '  gutter: 20pt,',
        '  [',
        '    #align(center)[',
        '      #box(fill: rgb("#c0392b"), radius: 2pt, inset: (x: 10pt, y: 4pt))[',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: white)[ALTERNATIVA A: FLUJO NATURAL (9.8 Fragmentada)]',
        '      ]',
        '    ]',
        '    #v(4pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#2980b9"))[PLIEGO 63 [P.124 Verso | P.125 Recto]:]',
        '    #v(2pt)',
        '    #spread-box(sp_base, 63, w: 520pt, h: 185pt)',
        '    #v(4pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#c0392b"))[PLIEGO 64 [P.126 Verso | VACÍO Recto] — CLAUSURA FINAL:]',
        '    #v(2pt)',
        '    #spread-box(sp_base, 64, w: 520pt, h: 185pt)',
        '    #v(6pt)',
        '    #meta-table((',
        '      ("P.125 (Recto)", "Secciones 9.6, 9.7 e inicio de 9.8 (H2 + P1 + P2) · 94.7% ocupación"),',
        '      ("Blanco residual P.125", "26.02 pt libres al pie (~2 líneas)"),',
        '      ("P.126 (Verso - Cierre)", "Solo 2 líneas del párrafo 3 de 9.8 · Ocupación: 5.4% (25.91 pt)"),',
        '      ("Blanco residual P.126", "450.67 pt libres (94.6% de la página final totalmente vacía)"),',
        '      ("Fragmentación 9.8", "GRAVE: Sección de clausura mutilada entre dos pliegos"),',
        '      ("Diagnóstico", "DEFICIENTE: Cierre accidental desprovisto de solemnidad legal")',
        '    ))',
        '  ],',
        '  [',
        '    #align(center)[',
        '      #box(fill: rgb("#27ae60"), radius: 2pt, inset: (x: 10pt, y: 4pt))[',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: white)[ALTERNATIVA B: SECCIÓN 9.8 COMPLETA (Fase 3.9)]',
        '      ]',
        '    ]',
        '    #v(4pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#2980b9"))[PLIEGO 63 [P.124 Verso | P.125 Recto]:]',
        '    #v(2pt)',
        '    #spread-box(sp_phase39, 63, w: 520pt, h: 185pt)',
        '    #v(4pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#27ae60"))[PLIEGO 64 [P.126 Verso | VACÍO Recto] — CLAUSURA FINAL:]',
        '    #v(2pt)',
        '    #spread-box(sp_phase39, 64, w: 520pt, h: 185pt)',
        '    #v(6pt)',
        '    #meta-table((',
        '      ("P.125 (Recto)", "Secciones 9.6 y 9.7 COMPLETAS · Ocupación: 66.2% (315.01 pt)"),',
        '      ("Blanco residual P.125", "161.57 pt libres al pie (~12.7 líneas · respiración lógica de sección)"),',
        '      ("P.126 (Verso - Cierre)", "Sección 9.8 ÍNTEGRA (H2 + 3 párrafos = 8 lín.) · Ocupación: 29.0%"),',
        '      ("Blanco residual P.126", "338.74 pt libres (composición balanceada de página final)"),',
        '      ("Fragmentación 9.8", "0% FRAGMENTACIÓN: Bloque normativo de clausura íntegro"),',
        '      ("Diagnóstico", "ÓPTIMO: Clausura solemne, institucional y jurídicamente impecable")',
        '    ))',
        '  ]',
        ')'
    ]
    return "\n".join(typ)

def render_png_artifacts(pdf_path):
    print(f"\n[INFO] Renderizando láminas PNG de comparativa de cierres...")
    doc = pymupdf.open(pdf_path)
    rendered_paths = []
    
    for idx, page in enumerate(doc, 1):
        pix = page.get_pixmap(dpi=150)
        artifact_filename = f"cierre_comparativa_lamina_{idx:02d}.png"
        artifact_path = os.path.join(ARTIFACTS_DIR, artifact_filename)
        pix.save(artifact_path)
        rendered_paths.append((idx, artifact_path))
        print(f"  [OK] Lámina {idx:02d} guardada en: {artifact_path}")
        
    return rendered_paths

def main():
    print("[INICIO] GENERACIÓN DE COMPARATIVA DE CIERRES EDITORIALES — FASE 3.9B")
    print("="*80)
    
    typ_code = build_typst()
    with open(OUT_TYP, 'w', encoding='utf-8') as f:
        f.write(typ_code)
        
    print(f"[INFO] Compilando con Typst a {OUT_PDF}...")
    typst_path = shutil.which("typst") or "typst"
    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, OUT_TYP, OUT_PDF]
    res = subprocess.run(cmd, capture_output=True, text=False)
    if res.returncode != 0:
        err = res.stderr.decode('utf-8', errors='replace')
        print(f"[ERROR] Error al compilar documento de cierres:\n{err}")
        sys.exit(1)
        
    doc = pymupdf.open(OUT_PDF)
    sz = os.path.getsize(OUT_PDF)
    print(f"[ÉXITO] Documento compilado: {OUT_PDF} ({len(doc)} láminas, {sz:,} bytes)")
    assert len(doc) == 4, f"Error: Se esperaban 4 láminas, se obtuvieron {len(doc)}"
    
    rendered = render_png_artifacts(OUT_PDF)
    print("\n" + "="*80)
    print(f"COMPILACIÓN Y EXPORTACIÓN EXITOSA: {len(rendered)} renders PNG creados.")
    print("="*80)

if __name__ == '__main__':
    main()
