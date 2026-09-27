#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
COMPILAR SIMULACIÓN DE CONTROL EDITORIAL DE PAGINACIÓN — FASE 3.9
Genera:
1. dist/TEST_PAGINATION_CONTROL_SIMULATION.pdf
2. dist/TEST_PAGINATION_CONTROL_SIMULATION_SPREADS.pdf

Aplica exclusivamente políticas editoriales semánticas de redistribución hacia adelante (Regla C)
y preservación atómica (Regla A) sin alterar la retícula ni el Markdown canónico.
"""

import os
import sys
import subprocess
import shutil
import pymupdf
import re

from pathlib import Path
REPO_DIR = str(Path(__file__).resolve().parent.parent)
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
BASE_TYP = os.path.join(TESTS_DIR, 'test_protocolo_capitulos_01_09.typ')

SIM_TYP = os.path.join(TESTS_DIR, 'test_pagination_control_simulation.typ')
SIM_PDF = os.path.join(DIST_DIR, 'TEST_PAGINATION_CONTROL_SIMULATION.pdf')

SPREADS_TYP = os.path.join(TESTS_DIR, 'test_pagination_control_simulation_spreads.typ')
SPREADS_PDF = os.path.join(DIST_DIR, 'TEST_PAGINATION_CONTROL_SIMULATION_SPREADS.pdf')

def generate_spreads(master_pdf_path, output_typ_path, output_pdf_path, num_pages):
    print(f"[INFO] Generando Spreads para {output_pdf_path} ({num_pages} páginas)...")
    rel_pdf = "/" + os.path.relpath(master_pdf_path, REPO_DIR).replace('\\', '/')
    
    spreads_typ = [
        '// ==============================================================================',
        '// SPREADS: Dobles páginas enfrentadas (Verso | Recto) a tamaño 792 × 612 pt',
        '// SIMULACIÓN DE CONTROL EDITORIAL DE PAGINACIÓN — FASE 3.9',
        '// ==============================================================================',
        '',
        '#set page(width: 792pt, height: 612pt, margin: 0pt)',
        '',
        f'#let master_pdf = "{rel_pdf}"',
        '',
        '#let render-spread(verso-p, recto-p) = [',
        '  #grid(',
        '    columns: (396pt, 396pt),',
        '    rows: (612pt),',
        '    gutter: 0pt,',
        '    if verso-p != none {',
        '      image(master_pdf, page: verso-p, width: 396pt, height: 612pt)',
        '    } else {',
        '      rect(width: 396pt, height: 612pt, fill: rgb("#ffffff"))[]',
        '    },',
        '    if recto-p != none {',
        '      image(master_pdf, page: recto-p, width: 396pt, height: 612pt)',
        '    } else {',
        '      rect(width: 396pt, height: 612pt, fill: rgb("#ffffff"))[]',
        '    }',
        '  )',
        ']',
        '',
        '// Pliego 01: [VACÍO | P.01 Cortesía Recto]',
        '#render-spread(none, 1)',
        ''
    ]

    for p in range(2, num_pages + 1, 2):
        verso = p
        recto = p + 1 if p + 1 <= num_pages else None
        spread_idx = p // 2 + 1
        recto_str = f"P.{recto:02d}" if recto else "VACÍO"
        spreads_typ.append(f'// Pliego {spread_idx:02d}: [P.{verso:02d} Verso | {recto_str} Recto]')
        if recto:
            spreads_typ.append(f'#render-spread({verso}, {recto})')
        else:
            spreads_typ.append(f'#render-spread({verso}, none)')
        spreads_typ.append('')

    with open(output_typ_path, 'w', encoding='utf-8') as f:
        f.write("\n".join(spreads_typ))

    typst_path = shutil.which("typst") or "typst"
    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, output_typ_path, output_pdf_path]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(output_pdf_path)
        print(f"[ÉXITO] Spreads generados: {output_pdf_path} ({len(doc)} pliegos)")
        return len(doc)
    else:
        print(f"[ERROR] Error al generar spreads:\n{res.stderr}")
        return None

def main():
    print("[INICIO] Generación de Simulación de Control Editorial de Paginación")
    with open(BASE_TYP, 'r', encoding='utf-8') as f:
        text = f.read()

    # 1. Cap 04: Redirigir el párrafo de 4.1.1 para preservar su integridad y balancear el capítulo
    p12 = "La sucesión accionaria tiene como finalidad exclusiva la transmisión del valor económico de las acciones y la preservación del control familiar y de la continuidad funcional de la sociedad, quedando expresamente excluida cualquier interpretación que implique la transmisión automática de la condición de accionista pleno o del ejercicio de derechos corporativos. En consecuencia, la sucesión no constituye un mecanismo de acceso directo a la estructura societaria, sino un proceso institucional que produce efectos económicos inmediatos a favor de los sucesores, condicionando cualquier efecto de naturaleza societaria al cumplimiento del régimen previsto en este Capítulo."
    assert p12 in text, "Párrafo 4.1.1 no encontrado en el Typst base"
    text_sim = text.replace(p12, f"#block(width: 100%, breakable: false)[{p12}]", 1)

    # 2. Cap 08: Balanceo de cierre mediante traslado hacia adelante de la Sección 8.9 (Regla C)
    sec_cap08_old = "== Coordinación con el Régimen Sancionador"
    assert sec_cap08_old in text_sim, "Sección 8.9 no encontrada en el Typst base"
    text_sim = text_sim.replace(sec_cap08_old, "#pagebreak()\n== Coordinación con el Régimen Sancionador", 1)

    # 3. Cap 09: Balanceo de cierre mediante traslado hacia adelante de la Sección 9.8 (Regla C)
    sec_cap09_old = "== Interpretación y Cierre Normativo"
    assert sec_cap09_old in text_sim, "Sección 9.8 no encontrada en el Typst base"
    text_sim = text_sim.replace(sec_cap09_old, "#pagebreak()\n== Interpretación y Cierre Normativo", 1)

    with open(SIM_TYP, 'w', encoding='utf-8') as f:
        f.write(text_sim)
    print(f"[INFO] Archivo Typst de simulación escrito en: {SIM_TYP}")

    typst_path = shutil.which("typst") or "typst"
    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, SIM_TYP, SIM_PDF]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        print(f"[ERROR] Error al compilar simulación:\n{res.stderr}")
        sys.exit(1)

    doc = pymupdf.open(SIM_PDF)
    num_pages = len(doc)
    size_bytes = os.path.getsize(SIM_PDF)
    print(f"[ÉXITO] Simulación compilada exitosamente: {SIM_PDF}")
    print(f"  Páginas totales: {num_pages} (Esperado: 126)")
    print(f"  Tamaño: {size_bytes:,} bytes")
    assert num_pages == 126, f"Error: La simulación tiene {num_pages} páginas, se esperaban 126."

    # Generar pliegos enfrentados
    spread_count = generate_spreads(SIM_PDF, SPREADS_TYP, SPREADS_PDF, num_pages)
    assert spread_count == 64, f"Error: Se esperaban 64 pliegos, se generaron {spread_count}."
    print("[FINALIZADO] Entregables 1 y 2 generados correctamente.")

if __name__ == '__main__':
    main()
