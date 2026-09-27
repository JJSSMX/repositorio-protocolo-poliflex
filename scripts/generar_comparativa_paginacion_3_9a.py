#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
GENERADOR DE COMPARATIVA ANTES | DESPUÉS — FASE 3.9A
Simulación de Desfase Global Mediante Respiración en x.1 (+18 pt)
Genera:
  dist/TEST_PAGINATION_X1_PLUS18_BEFORE_AFTER.pdf
  y renders PNG en el directorio de artefactos.

Formato: Láminas A3 apaisadas (1190.55 × 841.89 pt).
Páginas comparadas a ESCALA REAL 100% (396 × 612 pt) sin distorsión geométrica.

Casos requeridos por Fase 3.9A:
1. Chapter-First-Page (Pág. 05 / Cap 01): Desfase vertical de +18 pt en x.1
2. Caso de viuda P.66 (Capítulo 04): Persistencia de viuda de 1 línea
3. Caso de viuda P.68 (Capítulo 04): Persistencia de viuda de 1 línea
4. Cierre Capítulo 04 (Pág. 87): Persistencia de residuo de 2 líneas
5. Cierre Capítulo 08 (Pág. 119): Persistencia de remanente de 1 sola línea
6. Cierre Capítulo 09 (Pág. 126): Persistencia de remanente de 2 líneas en clausura del Protocolo
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

from pathlib import Path
REPO_DIR = str(Path(__file__).resolve().parent.parent)
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
ARTIFACTS_DIR = os.environ.get("ANTIGRAVITY_ARTIFACTS_DIR") or str(Path.home() / ".gemini" / "antigravity-cli" / "brain" / "44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2")

ORIG_PDF = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09.pdf')
SIM_PDF = os.path.join(DIST_DIR, 'TEST_PAGINATION_X1_PLUS18.pdf')

OUT_TYP = os.path.join(TESTS_DIR, 'test_pagination_x1_plus18_before_after.typ')
OUT_PDF = os.path.join(DIST_DIR, 'TEST_PAGINATION_X1_PLUS18_BEFORE_AFTER.pdf')

rel_orig = "/" + os.path.relpath(ORIG_PDF, REPO_DIR).replace('\\', '/')
rel_sim = "/" + os.path.relpath(SIM_PDF, REPO_DIR).replace('\\', '/')

cases_meta = [
    {
        'id': 1,
        'title': "LÁMINA 01 / 06: DESFASE VERTICAL EN CHAPTER-FIRST-PAGE — CAPÍTULO 01 (PÁGINA 05)",
        'orig_page': 5,
        'sim_page': 5,
        'tag_orig': "ESTADO A: RESPIRACIÓN BASE NOMINAL (y = 248.05 pt)",
        'tag_sim': "ESTADO C: RESPIRACIÓN +18 pt EN x.1 (y = 266.05 pt)",
        'orig_badge_color': 'rgb("#2980b9")',
        'sim_badge_color': 'rgb("#d35400")',
        'orig_desc': [
            ("Folio y paridad", "Pág. 05 · Recto (impar) · Chapter First Page"),
            ("Posición Y0 de 1.1", "y0 = 248.05 pt (coordenada nominal base)"),
            ("Líneas de cuerpo", "18 líneas de texto útil en página"),
            ("Línea final de página", "«...naturaleza corporativa, patrimonial y familiar...»"),
            ("Comportamiento", "Ritmo vertical estándar sin desplazamiento previo"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 05 · Recto (impar) — Paridad y folios idénticos"),
            ("Posición Y0 de 1.1", "y0 = 266.05 pt (+18.00 pt de respiración adicional)"),
            ("Líneas de cuerpo", "18 líneas de texto útil (idéntico número de líneas)"),
            ("Línea final de página", "«...naturaleza corporativa, patrimonial y familiar...»"),
            ("Hallazgo diagnóstico", "El espacio +18 pt fue absorbido por la holgura inferior; no expulsó ninguna línea"),
        ],
        'verdict_title': "DIAGNÓSTICO: DESFASE EFECTIVO PERO ABSORBIDO",
        'summary': "Se constata que el desplazamiento vertical de +18 pt se aplica matemáticamente antes del encabezado 1.1 (Y0 pasa de 248.05 pt a 266.05 pt). No obstante, debido a la holgura natural de la caja tipográfica en P.05, el contenido no desborda hacia la página siguiente y el desfase no se transmite al flujo posterior.",
        'metrics_box': [
            ("Desfase vertical en x.1", "+18.00 pt exactos"),
            ("Líneas desplazadas a P.06", "0 líneas (absorbido por holgura)"),
            ("Impacto en páginas siguientes", "NULO (flujo idéntico en P.06 a P.08)")
        ]
    },
    {
        'id': 2,
        'title': "LÁMINA 02 / 06: IMPACTO EN LÍNEA VIUDA AISLADA — CAPÍTULO 04 (PÁGINA 66)",
        'orig_page': 66,
        'sim_page': 66,
        'tag_orig': "ESTADO A: VIUDA AISLADA (1 LÍNEA ANTES DE H3 4.1.2)",
        'tag_sim': "ESTADO C (+18 pt): VIUDA PERSISTE IDÉNTICA (FRACASO DE HIPÓTESIS)",
        'orig_badge_color': 'rgb("#c0392b")',
        'sim_badge_color': 'rgb("#c0392b")',
        'orig_desc': [
            ("Folio y paridad", "Pág. 66 · Verso (par)"),
            ("Contenido al tope", "1 sola línea de remanente de Subsección 4.1.1 (y=70.4 pt)"),
            ("Texto de la viuda", "«inmediatos a favor de los sucesores, condicionando cualquier...»"),
            ("Contexto siguiente", "Encabezado H3 4.1.2 inmediatamente debajo"),
            ("Causa en Estado A", "P.65 alojó 6 líneas de 4.1.1 y expulsó 1 línea por fin de caja"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 66 · Verso (par)"),
            ("Contenido al tope", "1 sola línea de remanente de Subsección 4.1.1 (y=70.4 pt)"),
            ("Texto de la viuda", "«inmediatos a favor de los sucesores, condicionando cualquier...»"),
            ("Contexto siguiente", "Encabezado H3 4.1.2 inmediatamente debajo"),
            ("Resultado en Estado C", "IDÉNTICO: El desfase de +18 pt en P.65 no alteró el quiebre de 4.1.1"),
        ],
        'verdict_title': "EVALUACIÓN: HIPÓTESIS REFUTADA EN P.66",
        'summary': "En el Capítulo 04, el encabezado 4.1 se desplazó +18 pt (Y0 pasó de 224.04 pt a 242.04 pt en P.65). Sin embargo, P.65 tenía holgura vertical suficiente para albergar exactamente las mismas 20 líneas. En consecuencia, el párrafo 4.1.1 se cortó en el mismo carácter y expulsó la misma línea viuda a P.66.",
        'metrics_box': [
            ("Estado de la viuda", "PERSISTE (1 línea al tope)"),
            ("Comparación vs Fase 3.9", "Fase 3.9 eliminó la viuda con párrafo atómico"),
            ("Efectividad de +18 pt", "0% de resolución")
        ]
    },
    {
        'id': 3,
        'title': "LÁMINA 03 / 06: IMPACTO EN LÍNEA VIUDA EN FLUJO — CAPÍTULO 04 (PÁGINA 68)",
        'orig_page': 68,
        'sim_page': 68,
        'tag_orig': "ESTADO A: REMANENTE DÉBIL DE 1 LÍNEA ANTES DE H3 4.2.2",
        'tag_sim': "ESTADO C (+18 pt): VIUDA PERSISTE IDÉNTICA (FRACASO DE HIPÓTESIS)",
        'orig_badge_color': 'rgb("#c0392b")',
        'sim_badge_color': 'rgb("#c0392b")',
        'orig_desc': [
            ("Folio y paridad", "Pág. 68 · Verso (par)"),
            ("Contenido al tope", "1 sola línea de remanente de Subsección 4.2.1"),
            ("Texto de la viuda", "«al régimen de separación de derechos, al congelamiento accio...»"),
            ("Contexto siguiente", "Encabezado H3 4.2.2 en línea 2 de página"),
            ("Causa en Estado A", "Quiebre defectuoso 4+1 acumulado desde P.67"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 68 · Verso (par)"),
            ("Contenido al tope", "1 sola línea de remanente de Subsección 4.2.1"),
            ("Texto de la viuda", "«al régimen de separación de derechos, al congelamiento accio...»"),
            ("Contexto siguiente", "Encabezado H3 4.2.2 en línea 2 de página"),
            ("Resultado en Estado C", "IDÉNTICO: La viuda en P.68 reaparece exactamente sin variación"),
        ],
        'verdict_title': "EVALUACIÓN: HIPÓTESIS REFUTADA EN P.68",
        'summary': "Al no haberse corregido el quiebre de P.65-P.66, el flujo tipográfico en P.67 y P.68 permanece inalterado. La línea viuda de la Subsección 4.2.1 se mantiene en la cabeza de P.68 precediendo al encabezado 4.2.2, confirmando que la respiración en x.1 no resuelve el problema.",
        'metrics_box': [
            ("Estado de la viuda", "PERSISTE (1 línea al tope)"),
            ("Comparación vs Fase 3.9", "Fase 3.9 logró quiebre balanceado 2+2"),
            ("Efectividad de +18 pt", "0% de resolución")
        ]
    },
    {
        'id': 4,
        'title': "LÁMINA 04 / 06: IMPACTO EN CIERRE DE CAPÍTULO — CAPÍTULO 04 (PÁGINA 87)",
        'orig_page': 87,
        'sim_page': 87,
        'tag_orig': "ESTADO A: RESIDUO DÉBIL DE 2 LÍNEAS (4.2% DE CAJA)",
        'tag_sim': "ESTADO C (+18 pt): RESIDUO DE 2 LÍNEAS PERSISTE (SIN MEJORA)",
        'orig_badge_color': 'rgb("#c0392b")',
        'sim_badge_color': 'rgb("#c0392b")',
        'orig_desc': [
            ("Folio y paridad", "Pág. 87 · Recto (impar) · Cierre de Cap 04"),
            ("Contenido útil", "Únicamente 2 líneas terminales (y=70.4 a 88.4 pt)"),
            ("Texto terminal", "«momento, el cuadro accionario se considerará regularizado y...»"),
            ("Ocupación vertical", "4.2% de caja útil (25.9 pt de texto)"),
            ("Página anterior (P.86)", "P.86 alojó 3 líneas de 4.9.4 y expulsó 2 líneas"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 87 · Recto (impar) · Cierre de Cap 04"),
            ("Contenido útil", "Únicamente 2 líneas terminales (y=70.4 a 88.4 pt)"),
            ("Texto terminal", "«momento, el cuadro accionario se considerará regularizado y...»"),
            ("Ocupación vertical", "4.2% de caja útil (25.9 pt de texto)"),
            ("Resultado en Estado C", "CERO MEJORA: El remanente débil de 2 líneas se mantiene idéntico"),
        ],
        'verdict_title': "EVALUACIÓN: RESIDUO PERSISTE EN CAPÍTULO 04",
        'summary': "El desfase de +18 pt en 4.1 (P.65) se disipó completamente a lo largo de las 22 páginas intermedias del capítulo. Al llegar a P.86 y P.87, la distribución de líneas es exactamente la misma que en el Estado A, dejando a P.87 con solo 2 líneas descontextualizadas.",
        'metrics_box': [
            ("Líneas en P.87", "2 líneas (idéntico a Estado A)"),
            ("Comparación vs Fase 3.9", "Fase 3.9 pobló P.87 con 5 líneas completas (24% caja)"),
            ("Efectividad de +18 pt", "0% de resolución")
        ]
    },
    {
        'id': 5,
        'title': "LÁMINA 05 / 06: IMPACTO EN CIERRE DE CAPÍTULO — CAPÍTULO 08 (PÁGINA 119)",
        'orig_page': 119,
        'sim_page': 119,
        'tag_orig': "ESTADO A: RESIDUO DÉBIL DE 1 LÍNEA (4.2% DE CAJA)",
        'tag_sim': "ESTADO C (+18 pt): 1 SOLA LÍNEA SOLITARIA (PÁGINA DEFICIENTE)",
        'orig_badge_color': 'rgb("#c0392b")',
        'sim_badge_color': 'rgb("#c0392b")',
        'orig_desc': [
            ("Folio y paridad", "Pág. 119 · Recto (impar) · Cierre de Cap 08"),
            ("Contenido útil", "Únicamente 1 línea terminal (y=70.4 pt)"),
            ("Texto terminal", "«régimen disciplinario, reforzando la eficacia y coherencia...»"),
            ("Ocupación vertical", "1.6% de caja útil (7.9 pt de texto)"),
            ("Página anterior (P.118)", "P.118 alojó H2 8.9 + párrafos 1 y 2, expulsando el párrafo 3"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 119 · Recto (impar) · Cierre de Cap 08"),
            ("Contenido útil", "Únicamente 1 línea terminal (y=70.4 pt)"),
            ("Texto terminal", "«régimen disciplinario, reforzando la eficacia y coherencia d...»"),
            ("Ocupación vertical", "1.6% de caja útil (7.9 pt de texto)"),
            ("Resultado en Estado C", "EMPEORA O PERSISTE: Sigue siendo una página con 1 sola línea"),
        ],
        'verdict_title': "EVALUACIÓN: RESIDUO PERSISTE EN CAPÍTULO 08",
        'summary': "En el Capítulo 08, el desfase de +18 pt en 8.1 (P.115) no evitó que la Sección 8.9 comenzara al fondo de P.118, expulsando una única línea solitaria a P.119. La página terminal queda degradada a un residuo accidental del 1.6% de ocupación vertical.",
        'metrics_box': [
            ("Líneas en P.119", "1 línea solitaria (página casi vacía)"),
            ("Comparación vs Fase 3.9", "Fase 3.9 trasladó Sección 8.9 completa (7 lín. con H2)"),
            ("Efectividad de +18 pt", "0% de resolución")
        ]
    },
    {
        'id': 6,
        'title': "LÁMINA 06 / 06: IMPACTO EN CIERRE DEL PROTOCOLO — CAPÍTULO 09 (PÁGINA 126)",
        'orig_page': 126,
        'sim_page': 126,
        'tag_orig': "ESTADO A: RESIDUO DÉBIL DE 2 LÍNEAS EN CLAUSURA DEL LIBRO",
        'tag_sim': "ESTADO C (+18 pt): RESIDUO DE 2 LÍNEAS PERSISTE EN CLAUSURA",
        'orig_badge_color': 'rgb("#c0392b")',
        'sim_badge_color': 'rgb("#c0392b")',
        'orig_desc': [
            ("Folio y paridad", "Pág. 126 · Verso (par) · Cierre Definitivo del Protocolo"),
            ("Contenido útil", "Únicamente 2 líneas terminales (y=70.4 a 88.4 pt)"),
            ("Texto terminal", "«El Protocolo constituye un sistema normativo cerrado, no sus...»"),
            ("Ocupación vertical", "4.2% de caja útil (25.9 pt de texto)"),
            ("Página anterior (P.125)", "P.125 alojó H2 9.8 + párrafos 1 y 2, expulsando el párrafo final"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 126 · Verso (par) · Cierre Definitivo del Protocolo"),
            ("Contenido útil", "Únicamente 2 líneas terminales (y=70.4 a 88.4 pt)"),
            ("Texto terminal", "«El Protocolo constituye un sistema normativo cerrado, no sus...»"),
            ("Ocupación vertical", "4.2% de caja útil (25.9 pt de texto)"),
            ("Resultado en Estado C", "FRACASO EDITORIAL: La clausura solemne de la obra termina en 2 lín."),
        ],
        'verdict_title': "EVALUACIÓN: RESIDUO PERSISTE EN CLAUSURA FINAL",
        'summary': "El desfase de +18 pt en 9.1 (P.123) no alteró la partición de la Sección 9.8 en P.125. La última página de todo el Protocolo Familiar continúa cerrando con solo 2 líneas al tope, privando a la obra de la solemnidad que sí proporciona la redistribución semántica de la Fase 3.9.",
        'metrics_box': [
            ("Líneas en P.126", "2 líneas terminales"),
            ("Comparación vs Fase 3.9", "Fase 3.9 trasladó Sección 9.8 completa (8 lín. con H2)"),
            ("Efectividad de +18 pt", "0% de resolución")
        ]
    }
]

def build_comparativa_typst():
    typ = [
        '// ==============================================================================',
        '// COMPARATIVA FORENSE DE SIMULACIÓN — FASE 3.9A',
        '// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)',
        '// Hipótesis: Desfase Global Mediante Respiración en x.1 (+18 pt)',
        '// Formato: A3 Apaisado (1190.55 × 841.89 pt) · Escala Real 1:1 (396 × 612 pt)',
        '// ==============================================================================',
        '',
        '#set page(',
        '  paper: "a3",',
        '  flipped: true,',
        '  margin: (x: 2.2cm, top: 1.8cm, bottom: 1.6cm),',
        '  header: context [',
        '    #grid(',
        '      columns: (1fr, auto),',
        '      align: (left, right),',
        '      [',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, weight: "bold", fill: rgb("#d35400"))[',
        '          PROTOCOLO FAMILIAR POLIFLEX · SIMULACIÓN DIAGNÓSTICA FASE 3.9A',
        '        ]',
        '        #h(8pt)',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '          | EVALUACIÓN DE HIPÓTESIS: DESFASE VERTICAL EN x.1 (+18 pt) A ESCALA 1:1',
        '        ]',
        '      ],',
        '      [',
        '        #let p = counter(page).get().first()',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "medium", fill: rgb("#2e2f31"))[',
        '          Lámina #p de 6',
        '        ]',
        '      ]',
        '    )',
        '    #v(4pt)',
        '    #line(length: 100%, stroke: 0.5pt + rgb("#e2e2e2"))',
        '  ],',
        '  footer: [',
        '    #line(length: 100%, stroke: 0.5pt + rgb("#e2e2e2"))',
        '    #v(4pt)',
        '    #grid(',
        '      columns: (1fr, 1fr),',
        '      align: (left, right),',
        '      [',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[',
        '          Fase 3.9A (Diagnóstica) · Retícula +6 mm · Fuentes Canónicas Read-Only · Cero Modificación de Producción',
        '        ]',
        '      ],',
        '      [',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[',
        '          Páginas renderizadas a escala real 100% (396 × 612 pt) · Cero distorsión geométrica',
        '        ]',
        '      ]',
        '    )',
        '  ]',
        ')',
        '',
        f'#let orig_pdf = "{rel_orig}"',
        f'#let sim_pdf = "{rel_sim}"',
        '',
        '#let page-card(pdf-path, p-num, badge-text, badge-fill) = [',
        '  #block(width: 396pt)[',
        '    #align(center)[',
        '      #box(',
        '        fill: badge-fill,',
        '        radius: 2pt,',
        '        inset: (x: 8pt, y: 4pt),',
        '        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold", fill: white)[#badge-text]',
        '      )',
        '    ]',
        '    #v(6pt)',
        '    #box(',
        '      stroke: 0.75pt + rgb("#cccccc"),',
        '      radius: 1pt,',
        '      fill: white,',
        '      width: 396pt,',
        '      height: 612pt,',
        '      clip: true,',
        '      image(pdf-path, page: p-num, width: 396pt, height: 612pt)',
        '    )',
        '  ]',
        ']',
        '',
        '#let data-table(items) = [',
        '  #table(',
        '    columns: (auto, 1fr),',
        '    stroke: (x, y) => if y == 0 { (bottom: 0.5pt + rgb("#dcdcdc")) } else { (bottom: 0.3pt + rgb("#eeeeee")) },',
        '    fill: (col, row) => if calc.even(row) { rgb("#fbfbfb") } else { white },',
        '    inset: (x: 6pt, y: 4pt),',
        '    ..items.map(it => (',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#444444"))[#it.at(0)],',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, fill: rgb("#2e2f31"))[#it.at(1)]',
        '    )).flatten()',
        '  )',
        ']',
        ''
    ]

    for cidx, c in enumerate(cases_meta):
        typ.append(f'// ==============================================================================')
        typ.append(f'// {c["title"]}')
        typ.append(f'// ==============================================================================')
        typ.append('#v(2pt)')
        typ.append(f'#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[')
        typ.append(f'  {c["title"]}')
        typ.append(']')
        typ.append('#v(10pt)')
        typ.append('')
        typ.append('#grid(')
        typ.append('  columns: (396pt, 1fr, 396pt),')
        typ.append('  align: (top + left, top + center, top + right),')
        typ.append('  gutter: 14pt,')
        typ.append(f'  page-card(orig_pdf, {c["orig_page"]}, "{c["tag_orig"]}", {c["orig_badge_color"]}),')
        typ.append('  [')
        typ.append('    #v(15pt)')
        typ.append('    #align(center)[')
        typ.append(f'      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 9.5pt, weight: "bold", fill: rgb("#d35400"))[')
        typ.append(f'        {c["verdict_title"]}')
        typ.append('      ]')
        typ.append('    ]')
        typ.append('    #v(6pt)')
        typ.append('    #block(')
        typ.append('      fill: rgb("#fffaf7"),')
        typ.append('      stroke: 0.5pt + rgb("#d35400"),')
        typ.append('      radius: 3pt,')
        typ.append('      inset: 8pt,')
        typ.append('      [')
        typ.append(f'        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.4pt, fill: rgb("#2e2f31"))[')
        typ.append(f'          {c["summary"]}')
        typ.append('        ]')
        typ.append('      ]')
        typ.append('    )')
        typ.append('    #v(8pt)')
        typ.append('    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#2980b9"))[ESTADO A (Base Nominal):]]')
        typ.append('    #v(2pt)')
        
        orig_items = [f'("{k}", "{v}")' for k, v in c["orig_desc"]]
        typ.append(f'    #data-table(({", ".join(orig_items)}))')
        
        typ.append('    #v(6pt)')
        typ.append('    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.8pt, weight: "bold", fill: rgb("#d35400"))[ESTADO C (Simulación x.1 +18 pt):]]')
        typ.append('    #v(2pt)')
        
        sim_items = [f'("{k}", "{v}")' for k, v in c["sim_desc"]]
        typ.append(f'    #data-table(({", ".join(sim_items)}))')
        
        typ.append('    #v(10pt)')
        typ.append('    #align(center)[')
        typ.append('      #box(')
        typ.append('        fill: rgb("#fef9e7"),')
        typ.append('        stroke: 0.5pt + rgb("#f39c12"),')
        typ.append('        radius: 2pt,')
        typ.append('        inset: (x: 8pt, y: 5pt),')
        
        m_lines = "\\\n".join([f"• *{k}:* {v}" for k, v in c["metrics_box"]])
        typ.append(f'        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#7f4f00"))[')
        typ.append(f'          {m_lines}')
        typ.append('        ]')
        typ.append('      )')
        typ.append('    ]')
        typ.append('  ],')
        typ.append(f'  page-card(sim_pdf, {c["sim_page"]}, "{c["tag_sim"]}", {c["sim_badge_color"]}),')
        typ.append(')')
        
        if cidx < len(cases_meta) - 1:
            typ.append('')
            typ.append('#pagebreak()')
            typ.append('')

    return "\n".join(typ)

def render_png_artifacts(pdf_path):
    print(f"\n[INFO] Renderizando láminas PNG de Fase 3.9A para artefactos...")
    doc = pymupdf.open(pdf_path)
    rendered_paths = []
    
    for idx, page in enumerate(doc, 1):
        pix = page.get_pixmap(dpi=150)
        artifact_filename = f"simulacion_3_9a_lamina_{idx:02d}.png"
        artifact_path = os.path.join(ARTIFACTS_DIR, artifact_filename)
        pix.save(artifact_path)
        rendered_paths.append((idx, artifact_path))
        print(f"  [OK] Lámina {idx:02d} guardada en: {artifact_path}")
        
    return rendered_paths

def main():
    print("[INICIO] GENERACIÓN DE COMPARATIVA FORENSE — FASE 3.9A")
    print("="*80)

    typ_content = build_comparativa_typst()
    with open(OUT_TYP, 'w', encoding='utf-8') as f:
        f.write(typ_content)

    print(f"[INFO] Compilando con Typst a {OUT_PDF}...")
    typst_path = shutil.which("typst") or "typst"
    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, OUT_TYP, OUT_PDF]
    res = subprocess.run(cmd, capture_output=True, text=False)
    if res.returncode != 0:
        err_msg = res.stderr.decode('utf-8', errors='replace')
        print(f"[ERROR] Error al compilar documento comparativo:\n{err_msg}")
        sys.exit(1)

    doc = pymupdf.open(OUT_PDF)
    size_bytes = os.path.getsize(OUT_PDF)
    print(f"[ÉXITO] Documento comparativo compilado: {OUT_PDF}")
    print(f"  Láminas A3 totales: {len(doc)} (Esperado: 6)")
    print(f"  Tamaño: {size_bytes:,} bytes")
    assert len(doc) == 6, f"ERROR: Se esperaban 6 láminas, se obtuvieron {len(doc)}"

    # Renderizar PNGs para vista previa
    rendered = render_png_artifacts(OUT_PDF)

    print("\n" + "="*80)
    print("COMPARATIVA FASE 3.9A CONCLUIDA CON ÉXITO")
    print(f"  PDF: {OUT_PDF} (6 láminas A3 apaisadas a escala 1:1)")
    print(f"  Renders PNG: {len(rendered)} láminas exportadas")
    print("="*80)

if __name__ == '__main__':
    main()
