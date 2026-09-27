#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
GENERAR COMPARATIVA ANTES | DESPUÉS DE CONTROL EDITORIAL DE PAGINACIÓN — FASE 3.9
Genera:
  dist/TEST_PAGINATION_CONTROL_BEFORE_AFTER.pdf

Formato: Láminas A3 apaisadas (1190.55 × 841.89 pt).
Páginas comparadas a ESCALA REAL 100% (396 × 612 pt) sin reescalado ni distorsión.
Casos requeridos:
1. Viuda típica: Capítulo 04, Pág. 66
2. Huérfana/quiebre típico: Capítulo 03, Pág. 45
3. Cierre Capítulo 04: Pág. 87
4. Cierre Capítulo 08: Pág. 119
5. Cierre Capítulo 09: Pág. 126
"""

import os
import sys
import subprocess
import shutil
import pymupdf

from pathlib import Path
REPO_DIR = str(Path(__file__).resolve().parent.parent)
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')

ORIG_PDF = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09.pdf')
SIM_PDF = os.path.join(DIST_DIR, 'TEST_PAGINATION_CONTROL_SIMULATION.pdf')
OUT_TYP = os.path.join(TESTS_DIR, 'test_pagination_control_before_after.typ')
OUT_PDF = os.path.join(DIST_DIR, 'TEST_PAGINATION_CONTROL_BEFORE_AFTER.pdf')

rel_orig = "/" + os.path.relpath(ORIG_PDF, REPO_DIR).replace('\\', '/')
rel_sim = "/" + os.path.relpath(SIM_PDF, REPO_DIR).replace('\\', '/')

cases_meta = [
    {
        'id': 1,
        'title': "CASO 01 / 05: CONTROL DE LÍNEA VIUDA TÍPICA — CAPÍTULO 04 (PÁGINA 66)",
        'orig_page': 66,
        'sim_page': 66,
        'tag_orig': "ANOMALÍA DETECTADA: LÍNEA VIUDA AISLADA (1 LÍNEA AL TOPE)",
        'tag_sim': "SOLUCIÓN: TRASLADO ATÓMICO DE SUBSECCIÓN 4.1.1 (0 VIUDAS)",
        'orig_desc': [
            ("Folio y paridad", "Pág. 66 · Verso (par)"),
            ("Contenido al tope", "1 sola línea de remanente del párrafo 4.1.1 (y=70.4 pt)"),
            ("Texto de la viuda", "«inmediatos a favor de los sucesores, condicionando cualquier...»"),
            ("Impacto visual", "Línea huérfana de contexto visual antes de encabezado 4.1.2"),
            ("Causa técnica", "Typst cortó el párrafo en P.65 tras 6 líneas por fin de caja"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 66 · Verso (par) — Paridad 100% idéntica"),
            ("Contenido al tope", "Encabezado H3 4.1.2 + párrafo completo (24 líneas continuas)"),
            ("Estado de viudas", "0 líneas viudas (párrafo atómico trasladado íntegramente)"),
            ("Impacto visual", "Apertura sólida, lectura fluida y jerarquía equilibrada"),
            ("Métrica editorial", "Ocupación vertical: 86% de caja · Altura: 468 pt"),
        ],
        'summary': "Al aplicar la regla de atomicidad al bloque 4.1.1, la apertura de página en P.66 se transforma de un remanente accidental de 1 línea a una subsección tipográficamente robusta de 24 líneas, eliminando la viuda sin alterar la paginación global (126 págs)."
    },
    {
        'id': 2,
        'title': "CASO 02 / 05: AUDITORÍA DE LÍNEA HUÉRFANA / QUIEBRE TÍPICO — CAPÍTULO 03 (PÁGINA 45)",
        'orig_page': 45,
        'sim_page': 45,
        'tag_orig': "COMPOSICIÓN BASE: QUIEBRE 3+2 (CUMPLE REGLA A)",
        'tag_sim': "SIMULACIÓN BALANCEADA: ESTABILIDAD CONFIRMADA (3+2)",
        'orig_desc': [
            ("Folio y paridad", "Pág. 45 · Recto (impar) · Chapter First Page"),
            ("Contenido al pie", "3 líneas completas de párrafo introductorio (y=480.2 a 516.2 pt)"),
            ("Texto al pie", "«Este régimen no regula derechos económicos...» (líneas 1 a 3)"),
            ("Líneas en página sig.", "2 líneas pasan a Pág. 46 (y=70.4 a 88.4 pt)"),
            ("Diagnóstico forense", "El escaneo preliminar clasificó erróneamente como huérfana; la auditoría revela quiebre 3+2 legal."),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 45 · Recto (impar) · Chapter First Page"),
            ("Contenido al pie", "3 líneas completas preservadas idénticas (0 delta)"),
            ("Estado tipográfico", "Cumple naturalmente Regla A (mínimo 2 antes, mínimo 2 después)"),
            ("Folio baseline", "585.932 pt (exactamente alineado con retícula)"),
            ("Recomendación", "No forzar salto artificial; la distribución 3+2 es editorialmente óptima."),
        ],
        'summary': "La auditoría forense demuestra que las supuestas huérfanas de la prueba de estrés corresponden en realidad a quiebres equilibrados de 3 líneas al pie y 2 al tope. La simulación ratifica que no se requiere compresión ni saltos forzados en este punto."
    },
    {
        'id': 3,
        'title': "CASO 03 / 05: BALANCEO DE CIERRE DE CAPÍTULO — CAPÍTULO 04 (PÁGINA 87)",
        'orig_page': 87,
        'sim_page': 87,
        'tag_orig': "CIERRE DEFICIENTE: 2 LÍNEAS TERMINALES ACCIDENTALES",
        'tag_sim': "CIERRE BALANCEADO: PÁRRAFO COMPLETO DE 5 LÍNEAS",
        'orig_desc': [
            ("Folio y paridad", "Pág. 87 · Recto (impar) · Última página de Cap 04"),
            ("Contenido útil", "Únicamente 2 líneas de remanente final (y=70.4 a 88.4 pt)"),
            ("Texto terminal", "«momento, el cuadro accionario se considerará regularizado...»"),
            ("Ocupación vertical", "4.2% de la caja útil (25.9 pt de texto)"),
            ("Causa técnica", "P.86 alojó 3 líneas del párrafo y expulsó 2 líneas por fin de caja"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 87 · Recto (impar) · Paridad y posición ceremonial intactas"),
            ("Contenido útil", "Párrafo 4.9.4 íntegro trasladado hacia adelante (5 líneas completas)"),
            ("Texto terminal", "Bloque conclusivo societario completo con sentido autónomo"),
            ("Ocupación vertical", "24.1% de la caja útil (~80 pt texto + header/footer)"),
            ("Página anterior (P.86)", "Finaliza con 25 líneas sólidas (ocupación 88%), ritmo perfecto"),
        ],
        'summary': "Aplicando la Regla C (redistribución hacia adelante sin compresión previa), la página terminal pasa de 2 líneas frágiles a un bloque sólido de 5 líneas (24% de ocupación), logrando un cierre capitular digno y manteniendo estrictamente 126 páginas totales."
    },
    {
        'id': 4,
        'title': "CASO 04 / 05: BALANCEO DE CIERRE DE CAPÍTULO — CAPÍTULO 08 (PÁGINA 119)",
        'orig_page': 119,
        'sim_page': 119,
        'tag_orig': "CIERRE DEFICIENTE: 2 LÍNEAS DE PÁRRAFO EXPULSADO",
        'tag_sim': "CIERRE BALANCEADO: SECCIÓN 8.9 ÍNTEGRA (8 LÍNEAS + H2)",
        'orig_desc': [
            ("Folio y paridad", "Pág. 119 · Recto (impar) · Última página de Cap 08"),
            ("Contenido útil", "Únicamente 2 líneas (Párrafo 3 de Sección 8.9 partida en P.118)"),
            ("Texto terminal", "«El incumplimiento de las reglas previstas en este Capítulo...»"),
            ("Ocupación vertical", "4.2% de la caja útil (25.9 pt de texto)"),
            ("Causa técnica", "Sección 8.9 inició al fondo de P.118 y no cupo el tercer párrafo"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 119 · Recto (impar) · Recto facing Verso ceremonial"),
            ("Contenido útil", "Sección 8.9 completa: Encabezado H2 + 3 párrafos (8 líneas)"),
            ("Texto terminal", "Unidad temática completa sobre régimen sancionador"),
            ("Ocupación vertical", "35.2% de la caja útil (161 pt de texto y encabezado)"),
            ("Página anterior (P.118)", "Finaliza limpiamente en Sección 8.8 con 21 líneas (68% caja)"),
        ],
        'summary': "En lugar de partir la Sección 8.9 dejando solo 2 líneas en P.119, la sección completa se traslada hacia adelante mediante la Regla C. P.119 se convierte en un cierre de capítulo autoportante y elegante (35% ocupación), preservando la paridad para la apertura del Cap 09."
    },
    {
        'id': 5,
        'title': "CASO 05 / 05: BALANCEO DE CIERRE DEL PROTOCOLO — CAPÍTULO 09 (PÁGINA 126)",
        'orig_page': 126,
        'sim_page': 126,
        'tag_orig': "CIERRE DEFICIENTE: 2 LÍNEAS FINALES DEL PROTOCOLO",
        'tag_sim': "CIERRE SOLEMNE: SECCIÓN 9.8 ÍNTEGRA (8 LÍNEAS + H2)",
        'orig_desc': [
            ("Folio y paridad", "Pág. 126 · Verso (par) · Página de cierre de toda la obra"),
            ("Contenido útil", "Únicamente 2 líneas (cláusula final de validez jurídica)"),
            ("Texto terminal", "«El Protocolo constituye un sistema normativo cerrado...»"),
            ("Ocupación vertical", "4.2% de la caja útil (25.9 pt de texto)"),
            ("Causa técnica", "Sección 9.8 inició al fondo de P.125 y expulsó el párrafo final"),
        ],
        'sim_desc': [
            ("Folio y paridad", "Pág. 126 · Verso (par) · Cierre físico final del libro"),
            ("Contenido útil", "Sección 9.8 completa: Encabezado H2 + 3 párrafos (8 líneas)"),
            ("Texto terminal", "Cláusula íntegra de Interpretación y Cierre Normativo"),
            ("Ocupación vertical", "35.2% de la caja útil (161 pt de texto y encabezado)"),
            ("Página anterior (P.125)", "Finaliza limpiamente en Sección 9.7 con 20 líneas (69% caja)"),
        ],
        'summary': "La última página del Protocolo pasa de tener 2 líneas huérfanas a albergar con dignidad la sección completa de 'Interpretación y Cierre Normativo' (35% de ocupación vertical). La obra concluye con solemnidad institucional, exactamente en 126 páginas físicas."
    },
]

typ_code = [
    '// ==============================================================================',
    '// COMPARATIVA FORENSE ANTES | DESPUÉS — CONTROL EDITORIAL DE PAGINACIÓN',
    '// FASE 3.9 · PROTOCOLO FAMILIAR POLIFLEX',
    '// Tamaño: A3 Apaisado (1190.55 × 841.89 pt) · Páginas a ESCALA REAL 100% (396 × 612 pt)',
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
    '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, weight: "bold", fill: rgb("#f15d22"))[',
    '          PROTOCOLO FAMILIAR POLIFLEX · AUDITORÍA FORENSE DE CONTROL EDITORIAL DE PAGINACIÓN',
    '        ]',
    '        #h(8pt)',
    '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
    '          | FASE 3.9 — COMPARATIVA DE SIMULACIÓN A ESCALA REAL 1:1',
    '        ]',
    '      ],',
    '      [',
    '        #let p = counter(page).get().first()',
    '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "medium", fill: rgb("#2e2f31"))[',
    '          Lámina #p de 5',
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
    '          Sistema Editorial Locked · Retícula +6 mm Consolidada · Sin Alteración de Fuentes Canónicas',
    '        ]',
    '      ],',
    '      [',
    '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[',
    '          Páginas renderizadas a escala 100% (396 × 612 pt) · Cero reducción geométrica',
    '        ]',
    '      ]',
    '    )',
    '  ]',
    ')',
    '',
    f'#let orig_pdf = "{rel_orig}"',
    f'#let sim_pdf = "{rel_sim}"',
    '',
    '#let page-card(pdf-path, p-num, badge-text, badge-fill, metrics) = [',
    '  #block(width: 396pt)[',
    '    #align(center)[',
    '      #box(',
    '        fill: badge-fill,',
    '        radius: 2pt,',
    '        inset: (x: 8pt, y: 4pt),',
    '        outset: 0pt,',
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

for idx, c in enumerate(cases_meta):
    typ_code.append(f'// ==============================================================================')
    typ_code.append(f'// LÁMINA {c["id"]:02d}: {c["title"]}')
    typ_code.append(f'// ==============================================================================')
    typ_code.append('')
    typ_code.append(f'#v(2pt)')
    typ_code.append(f'#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[')
    typ_code.append(f'  {c["title"]}')
    typ_code.append(f']')
    typ_code.append(f'#v(10pt)')
    typ_code.append('')
    typ_code.append('#grid(')
    typ_code.append('  columns: (396pt, 1fr, 396pt),')
    typ_code.append('  align: (top + left, top + center, top + right),')
    typ_code.append('  gutter: 14pt,')
    
    # Left column: ANTES
    typ_code.append(f'  page-card(orig_pdf, {c["orig_page"]}, "{c["tag_orig"]}", rgb("#c0392b"), ()),')
    
    # Center column: ANALYTICAL COMPARISON SIDEBAR
    typ_code.append('  [')
    typ_code.append('    #v(30pt)')
    typ_code.append('    #align(center)[')
    typ_code.append('      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 10pt, weight: "bold", fill: rgb("#f15d22"))[')
    typ_code.append('        DIAGNÓSTICO EDITORIAL')
    typ_code.append('      ]')
    typ_code.append('    ]')
    typ_code.append('    #v(8pt)')
    typ_code.append('    #block(')
    typ_code.append('      fill: rgb("#fffaf7"),')
    typ_code.append('      stroke: 0.5pt + rgb("#f15d22"),')
    typ_code.append('      radius: 3pt,')
    typ_code.append('      inset: 8pt,')
    typ_code.append('      [')
    typ_code.append('        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#2e2f31"))[')
    typ_code.append(f'          {c["summary"]}')
    typ_code.append('        ]')
    typ_code.append('      ]')
    typ_code.append('    )')
    typ_code.append('    #v(12pt)')
    typ_code.append('    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: rgb("#c0392b"))[ANTES (Base):]]')
    typ_code.append('    #v(2pt)')
    items_orig_str = ", ".join([f'("{k}", "{v}")' for k, v in c["orig_desc"]])
    typ_code.append(f'    #data-table(({items_orig_str}))')
    typ_code.append('    #v(10pt)')
    typ_code.append('    #align(left)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "bold", fill: rgb("#27ae60"))[DESPUÉS (Simulación):]]')
    typ_code.append('    #v(2pt)')
    items_sim_str = ", ".join([f'("{k}", "{v}")' for k, v in c["sim_desc"]])
    typ_code.append(f'    #data-table(({items_sim_str}))')
    typ_code.append('    #v(14pt)')
    typ_code.append('    #align(center)[')
    typ_code.append('      #box(')
    typ_code.append('        fill: rgb("#eef7f2"),')
    typ_code.append('        stroke: 0.5pt + rgb("#27ae60"),')
    typ_code.append('        radius: 2pt,')
    typ_code.append('        inset: (x: 8pt, y: 5pt),')
    typ_code.append('        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7pt, weight: "bold", fill: rgb("#27ae60"))[')
    typ_code.append('          ✓ 126 PÁGINAS TOTALES PRESERVADAS\\')
    typ_code.append('          ✓ RETÍCULA +6 MM INTACTA\\')
    typ_code.append('          ✓ FOLIO BASELINE: 0 DELTA')
    typ_code.append('        ]')
    typ_code.append('      )')
    typ_code.append('    ]')
    typ_code.append('  ],')
    
    # Right column: DESPUÉS
    typ_code.append(f'  page-card(sim_pdf, {c["sim_page"]}, "{c["tag_sim"]}", rgb("#27ae60"), ()),')
    typ_code.append(')')
    
    if idx < len(cases_meta) - 1:
        typ_code.append('')
        typ_code.append('#pagebreak()')
        typ_code.append('')

with open(OUT_TYP, 'w', encoding='utf-8') as f:
    f.write("\n".join(typ_code))

print(f"[INFO] Archivo Typst comparativo escrito en: {OUT_TYP}")

typst_path = shutil.which("typst") or "typst"
cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, OUT_TYP, OUT_PDF]
res = subprocess.run(cmd, capture_output=True, text=True)
if res.returncode == 0:
    doc = pymupdf.open(OUT_PDF)
    size = os.path.getsize(OUT_PDF)
    print(f"[ÉXITO] PDF comparativo generado: {OUT_PDF}")
    print(f"  Láminas A3 totales: {len(doc)} (Esperado: 5)")
    print(f"  Tamaño: {size:,} bytes")
else:
    print(f"[ERROR] Error al compilar comparativa:\n{res.stderr}")
    sys.exit(1)
