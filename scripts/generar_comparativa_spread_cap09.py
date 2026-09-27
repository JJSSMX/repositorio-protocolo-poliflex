#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
GENERADOR DE COMPARATIVA DE SPREADS DE CAPÍTULO 09 — FASE 3.9A
Criterio Visual Adicional:
Comparación obligatoria del spread que contiene:
- 9.7 Nulidad de Pactos Paralelos y Actos de Elusión
- 9.8 Interpretación y Cierre Normativo

Compara los 3 Estados:
  A. Paginación original (Base Nominal)
  B. Redistribución Fase 3.9 (Desplazamiento Semántico)
  C. x.1 +18 pt con flujo natural (Simulación Fase 3.9A)

Genera:
  dist/TEST_COMPARATIVA_SPREAD_CAPITULO_09.pdf
  y renders PNG en el directorio de artefactos:
  comparativa_spread_cap09_lamina_01.png
  comparativa_spread_cap09_lamina_02.png
  comparativa_spread_cap09_lamina_03.png
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

# Archivos fuente
SPREAD_A = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf"
SPREAD_B = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1_SPREADS.pdf"
SPREAD_C = "/dist/TEST_PAGINATION_X1_PLUS18_SPREADS.pdf"

PAGE_A = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09.pdf"
PAGE_B = "/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1.pdf"
PAGE_C = "/dist/TEST_PAGINATION_X1_PLUS18.pdf"

OUT_TYP = os.path.join(TESTS_DIR, 'test_comparativa_spread_capitulo_09.typ')
OUT_PDF = os.path.join(DIST_DIR, 'TEST_COMPARATIVA_SPREAD_CAPITULO_09.pdf')

def build_typst():
    typ = [
        '// ==============================================================================',
        '// COMPARATIVA DE SPREADS DEL CAPÍTULO 09 — FASE 3.9A',
        '// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)',
        '// Criterio Visual Adicional: Secciones 9.7 y 9.8 en Pliegos 63 y 64',
        '// Formato: A3 Apaisado (1190.55 × 841.89 pt)',
        '// ==============================================================================',
        '',
        '#set page(',
        '  paper: "a3",',
        '  flipped: true,',
        '  margin: (x: 2.0cm, top: 1.6cm, bottom: 1.4cm),',
        '  header: context [',
        '    #grid(',
        '      columns: (1fr, auto),',
        '      align: (left, right),',
        '      [',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, weight: "bold", fill: rgb("#d35400"))[',
        '          PROTOCOLO FAMILIAR POLIFLEX · COMPARATIVA FORENSE DE SPREADS (CAPÍTULO 09)',
        '        ]',
        '        #h(8pt)',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '          | EVALUACIÓN TRIPARTITA: ESTADO A vs ESTADO B vs ESTADO C',
        '        ]',
        '      ],',
        '      [',
        '        #let p = counter(page).get().first()',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, weight: "medium", fill: rgb("#2e2f31"))[',
        '          Lámina #p de 3',
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
        '          Fase 3.9A · Criterio Visual Adicional · Evaluación de Flujo Natural vs Redistribución Semántica',
        '        ]',
        '      ],',
        '      [',
        '        #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[',
        '          126 Páginas Físicas · Retícula +6 mm · Fuentes Canónicas `/capitulos/*.md` Read-Only',
        '        ]',
        '      ]',
        '    )',
        '  ]',
        ')',
        '',
        f'#let sp_a = "{SPREAD_A}"',
        f'#let sp_b = "{SPREAD_B}"',
        f'#let sp_c = "{SPREAD_C}"',
        f'#let pg_a = "{PAGE_A}"',
        f'#let pg_b = "{PAGE_B}"',
        f'#let pg_c = "{PAGE_C}"',
        '',
        '#let spread-card(pdf-path, p-num, badge-text, badge-fill, subtext) = [',
        '  #block(width: 355pt)[',
        '    #align(center)[',
        '      #box(',
        '        fill: badge-fill,',
        '        radius: 2pt,',
        '        inset: (x: 8pt, y: 4pt),',
        '        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold", fill: white)[#badge-text]',
        '      )',
        '      #v(2pt)',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#6c6b67"))[#subtext]',
        '    ]',
        '    #v(5pt)',
        '    #box(',
        '      stroke: 0.75pt + rgb("#cccccc"),',
        '      radius: 1pt,',
        '      fill: white,',
        '      width: 355pt,',
        '      height: 274.2pt,',
        '      clip: true,',
        '      image(pdf-path, page: p-num, width: 355pt, height: 274.2pt)',
        '    )',
        '  ]',
        ']',
        '',
        '#let page-card(pdf-path, p-num, badge-text, badge-fill) = [',
        '  #block(width: 355pt)[',
        '    #align(center)[',
        '      #box(',
        '        fill: badge-fill,',
        '        radius: 2pt,',
        '        inset: (x: 8pt, y: 4pt),',
        '        text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, weight: "bold", fill: white)[#badge-text]',
        '      )',
        '    ]',
        '    #v(4pt)',
        '    #box(',
        '      stroke: 0.75pt + rgb("#cccccc"),',
        '      radius: 1pt,',
        '      fill: white,',
        '      width: 355pt,',
        '      height: 548.7pt,',
        '      clip: true,',
        '      image(pdf-path, page: p-num, width: 355pt, height: 548.7pt)',
        '    )',
        '  ]',
        ']',
        '',
        '#let meta-table(items) = [',
        '  #table(',
        '    columns: (auto, 1fr),',
        '    stroke: (x, y) => if y == 0 { (bottom: 0.5pt + rgb("#dcdcdc")) } else { (bottom: 0.3pt + rgb("#eeeeee")) },',
        '    fill: (col, row) => if calc.even(row) { rgb("#fbfbfb") } else { white },',
        '    inset: (x: 5pt, y: 3.5pt),',
        '    ..items.map(it => (',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, weight: "bold", fill: rgb("#444444"))[#it.at(0)],',
        '      text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#2e2f31"))[#it.at(1)]',
        '    )).flatten()',
        '  )',
        ']',
        '',
        '// ==============================================================================',
        '// LÁMINA 01: PLIEGO 63 [P.124 VERSO | P.125 RECTO] — COMPARATIVA TRIPARTITA',
        '// ==============================================================================',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[',
        '  LÁMINA 01 / 03: PLIEGO 63 [P.124 VERSO | P.125 RECTO] — ANÁLISIS DE SECCIONES 9.7 Y 9.8',
        ']',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '  Comparación directa del pliego donde conviven la Sección 9.7 (Nulidad de Pactos) y el inicio de la Sección 9.8 (Interpretación y Cierre Normativo)',
        ']',
        '#v(8pt)',
        '',
        '#grid(',
        '  columns: (355pt, 355pt, 355pt),',
        '  align: (top + left, top + center, top + right),',
        '  gutter: 14pt,',
        '  spread-card(sp_a, 63, "ESTADO A: PAGINACIÓN ORIGINAL", rgb("#2980b9"), "Flujo base nominal (Fase 3.7 / 3.8)"),',
        '  spread-card(sp_b, 63, "ESTADO B: FASE 3.9 REDISTRIBUIDA", rgb("#27ae60"), "Redistribución semántica (Sección 9.8 trasladada)"),',
        '  spread-card(sp_c, 63, "ESTADO C: x.1 +18 pt FLUJO NATURAL", rgb("#d35400"), "Desfase inicial en 9.1 con flujo continuo")',
        ')',
        '#v(10pt)',
        '',
        '#grid(',
        '  columns: (355pt, 355pt, 355pt),',
        '  align: (top + left, top + center, top + right),',
        '  gutter: 14pt,',
        '  [',
        '    #meta-table((',
        '      ("Página Verso (P.124)", "Secciones 9.3, 9.4 y 9.5 · 98.4% ocupación"),',
        '      ("Página Recto (P.125)", "Secciones 9.6, 9.7 e INICIO de 9.8"),',
        '      ("Ocupación P.125", "94.7% de caja útil (450.56 pt ocupados)"),',
        '      ("Espacio residual P.125", "26.02 pt libres al pie (~2 líneas)"),',
        '      ("Situación Sección 9.8", "FRAGMENTADA: H2 + 2 párrafos en P.125; párrafo 3 expulsado"),',
        '      ("Continuidad visual", "Muy alta en P.125, pero corta la cláusula"),',
        '      ("Diagnóstico", "Apiñamiento de 9.8 al pie; genera remanente débil en P.126")',
        '    ))',
        '  ],',
        '  [',
        '    #meta-table((',
        '      ("Página Verso (P.124)", "Secciones 9.3, 9.4 y 9.5 · 98.4% ocupación"),',
        '      ("Página Recto (P.125)", "Secciones 9.6 y 9.7 COMPLETAS"),',
        '      ("Ocupación P.125", "66.2% de caja útil (315.01 pt ocupados)"),',
        '      ("Espacio residual P.125", "161.57 pt libres al pie (~12.7 líneas)"),',
        '      ("Situación Sección 9.8", "PRESERVADA ÍNTEGRA: Trasladada a P.126"),',
        '      ("Continuidad visual", "Pausa natural al pie tras agotar 9.7"),',
        '      ("Diagnóstico", "Respira al pie de P.125; dignifica el cierre del libro en P.126")',
        '    ))',
        '  ],',
        '  [',
        '    #meta-table((',
        '      ("Página Verso (P.124)", "Secciones 9.3, 9.4 y 9.5 · 98.4% ocupación"),',
        '      ("Página Recto (P.125)", "Secciones 9.6, 9.7 e INICIO de 9.8"),',
        '      ("Ocupación P.125", "94.7% de caja útil (450.56 pt ocupados)"),',
        '      ("Espacio residual P.125", "26.02 pt libres al pie (~2 líneas)"),',
        '      ("Situación Sección 9.8", "FRAGMENTADA: Idéntica a Estado A"),',
        '      ("Continuidad visual", "Idéntica a Estado A (flujo no alterado)"),',
        '      ("Diagnóstico", "INALTERADO: +18 pt en 9.1 fue absorbido; cero efecto en P.125")',
        '    ))',
        '  ]',
        ')',
        '',
        '#pagebreak()',
        '',
        '// ==============================================================================',
        '// LÁMINA 02: PLIEGO 64 [P.126 VERSO | VACÍO RECTO] — CLAUSURA DEL PROTOCOLO',
        '// ==============================================================================',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[',
        '  LÁMINA 02 / 03: PLIEGO 64 [P.126 VERSO | VACÍO RECTO] — CIERRE SOLEMNE DE LA OBRA',
        ']',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '  Comparación del pliego final del libro donde se manifiesta el destino de la Sección 9.8 (Interpretación y Cierre Normativo)',
        ']',
        '#v(8pt)',
        '',
        '#grid(',
        '  columns: (355pt, 355pt, 355pt),',
        '  align: (top + left, top + center, top + right),',
        '  gutter: 14pt,',
        '  spread-card(sp_a, 64, "ESTADO A: RESIDUO DÉBIL DE 2 LÍNEAS", rgb("#c0392b"), "Página terminal accidental y desolada"),',
        '  spread-card(sp_b, 64, "ESTADO B: CLAUSURA COMPLETA CON H2", rgb("#27ae60"), "Sección 9.8 íntegra como cierre formal"),',
        '  spread-card(sp_c, 64, "ESTADO C: RESIDUO DE 2 LÍNEAS PERSISTE", rgb("#c0392b"), "Hipótesis refutada; idéntico a Estado A")',
        ')',
        '#v(10pt)',
        '',
        '#grid(',
        '  columns: (355pt, 355pt, 355pt),',
        '  align: (top + left, top + center, top + right),',
        '  gutter: 14pt,',
        '  [',
        '    #meta-table((',
        '      ("Contenido P.126 (Verso)", "Solo 2 líneas del párrafo final de 9.8"),',
        '      ("Encabezado H2 9.8", "AUSENTE (quedó atrapado al fondo de P.125)"),',
        '      ("Ocupación P.126", "5.4% de caja útil (25.91 pt ocupados)"),',
        '      ("Espacio residual P.126", "450.67 pt libres (94.6% de la página vacía)"),',
        '      ("Densidad del Pliego 64", "Ínfima (sensación de error de maquetación)"),',
        '      ("Impacto editorial", "DEFICIENTE: Clausura del libro fragmentada") ',
        '    ))',
        '  ],',
        '  [',
        '    #meta-table((',
        '      ("Contenido P.126 (Verso)", "Encabezado H2 9.8 + 3 párrafos completos"),',
        '      ("Encabezado H2 9.8", "PRESENTE con dignidad al tope de página"),',
        '      ("Ocupación P.126", "29.0% de caja útil (138.01 pt ocupados)"),',
        '      ("Espacio residual P.126", "338.74 pt libres (composición balanceada)"),',
        '      ("Densidad del Pliego 64", "Moderada y solemne; página autosuficiente"),',
        '      ("Impacto editorial", "ÓPTIMO: Clausura jurídica formal y solemne") ',
        '    ))',
        '  ],',
        '  [',
        '    #meta-table((',
        '      ("Contenido P.126 (Verso)", "Solo 2 líneas del párrafo final de 9.8"),',
        '      ("Encabezado H2 9.8", "AUSENTE (quedó atrapado al fondo de P.125)"),',
        '      ("Ocupación P.126", "5.4% de caja útil (25.91 pt ocupados)"),',
        '      ("Espacio residual P.126", "450.67 pt libres (idéntico a Estado A)"),',
        '      ("Densidad del Pliego 64", "Ínfima (sensación de error de maquetación)"),',
        '      ("Impacto editorial", "FRACASO: El desfase en 9.1 no evitó el residuo") ',
        '    ))',
        '  ]',
        ')',
        '',
        '#pagebreak()',
        '',
        '// ==============================================================================',
        '// LÁMINA 03: COMPARATIVA A ESCALA 1:1 DE LAS PÁGINAS CRÍTICAS P.125 Y P.126',
        '// ==============================================================================',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 12pt, weight: "bold", fill: rgb("#2e2f31"))[',
        '  LÁMINA 03 / 03: ENFOQUE DIRECTO EN PÁGINA 125 Y PÁGINA 126 — COMPARACIÓN FORENSE',
        ']',
        '#v(2pt)',
        '#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#6c6b67"))[',
        '  Contraste directo entre el modelo de Flujo Natural (Estados A y C) vs Redistribución Semántica (Estado B)',
        ']',
        '#v(8pt)',
        '',
        '#grid(',
        '  columns: (355pt, 355pt, 355pt),',
        '  align: (top + left, top + center, top + right),',
        '  gutter: 14pt,',
        '  page-card(pg_a, 125, "ESTADOS A y C: P.125 (FLUJO NATURAL)", rgb("#2980b9")),',
        '  page-card(pg_b, 125, "ESTADO B: P.125 (REDISTRIBUIDA)", rgb("#27ae60")),',
        '  page-card(pg_b, 126, "ESTADO B: P.126 (CIERRE SOLEMNE)", rgb("#8e44ad"))',
        ')',
        '#v(10pt)',
        '',
        '#grid(',
        '  columns: (355pt, 355pt, 355pt),',
        '  align: (top + left, top + center, top + right),',
        '  gutter: 14pt,',
        '  [',
        '    #box(fill: rgb("#f4f9fd"), stroke: 0.5pt + rgb("#2980b9"), inset: 6pt, radius: 2pt, width: 100%)[',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#2980b9"))[MECÁNICA EN ESTADOS A Y C (P.125):]',
        '      #v(3pt)',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#2e2f31"))[',
        '        La página aloja la Sección 9.6 completa, la Sección 9.7 completa, y el encabezado 9.8 con sus párrafos 1 y 2. Ocupación vertical: 94.7%. Al pie solo restan 26 pt libres. El párrafo 3 no cabe y se expulsa a P.126, rompiendo la unidad normativa final.',
        '      ]',
        '    ]',
        '  ],',
        '  [',
        '    #box(fill: rgb("#f4fdf6"), stroke: 0.5pt + rgb("#27ae60"), inset: 6pt, radius: 2pt, width: 100%)[',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#27ae60"))[MECÁNICA EN ESTADO B (P.125):]',
        '      #v(3pt)',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#2e2f31"))[',
        '        Al detectar que la Sección 9.8 no puede completarse en P.125, la regla semántica traslada la sección completa a P.126. P.125 concluye limpiamente con la Sección 9.7, dejando 161.57 pt de respiración inferior sin forzar una rotura intra-sección.',
        '      ]',
        '    ]',
        '  ],',
        '  [',
        '    #box(fill: rgb("#faf4fd"), stroke: 0.5pt + rgb("#8e44ad"), inset: 6pt, radius: 2pt, width: 100%)[',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.2pt, weight: "bold", fill: rgb("#8e44ad"))[RESULTADO EN ESTADO B (P.126):]',
        '      #v(3pt)',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.8pt, fill: rgb("#2e2f31"))[',
        '        La última página física de la obra aloja la Sección 9.8 completa: su título formal en Minion Pro y los 3 párrafos normativos (29.0% ocupación, 138 pt de masa tipográfica). El Protocolo Familiar culmina con solemnidad institucional y 0% de fragmentación.',
        '      ]',
        '    ]',
        '  ]',
        ')'
    ]
    return "\n".join(typ)

def render_png_artifacts(pdf_path):
    print(f"\n[INFO] Renderizando láminas PNG de comparativa de spreads...")
    doc = pymupdf.open(pdf_path)
    rendered_paths = []
    
    for idx, page in enumerate(doc, 1):
        pix = page.get_pixmap(dpi=150)
        artifact_filename = f"comparativa_spread_cap09_lamina_{idx:02d}.png"
        artifact_path = os.path.join(ARTIFACTS_DIR, artifact_filename)
        pix.save(artifact_path)
        rendered_paths.append((idx, artifact_path))
        print(f"  [OK] Lámina {idx:02d} guardada en: {artifact_path}")
        
    return rendered_paths

def main():
    print("[INICIO] GENERACIÓN DE COMPARATIVA DE SPREADS (CAPÍTULO 09)")
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
        print(f"[ERROR] Error al compilar documento de spreads:\n{err}")
        sys.exit(1)
        
    doc = pymupdf.open(OUT_PDF)
    sz = os.path.getsize(OUT_PDF)
    print(f"[ÉXITO] Documento compilado: {OUT_PDF} ({len(doc)} láminas, {sz:,} bytes)")
    assert len(doc) == 3, f"Error: Se esperaban 3 láminas, se obtuvieron {len(doc)}"
    
    rendered = render_png_artifacts(OUT_PDF)
    print("\n" + "="*80)
    print(f"COMPILACIÓN Y EXPORTACIÓN EXITOSA: {len(rendered)} renders PNG creados.")
    print("="*80)

if __name__ == '__main__':
    main()
