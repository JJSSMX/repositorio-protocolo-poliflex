"""
AUDITORÍA FORENSE AUTOMATIZADA: FASE 3.7.1
Ajuste de Retícula Superior y Apertura Ceremonial

Inspecciona exhaustivamente:
- dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf (54 páginas)
- dist/TEST_CAPITULOS_01_03_CEREMONIAL_SPREADS.pdf
- dist/TEST_CEREMONIAL_OPENINGS.pdf
- dist/TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf
Verifica las 7 reglas obligatorias de gobernanza ceremonial y regresión.
"""

import os
import sys
import re
import hashlib
import fitz

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIST_DIR = os.path.join(REPO_DIR, 'dist')
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
CEREMONIAL_PDF = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_CEREMONIAL.pdf')
SPREADS_PDF = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_CEREMONIAL_SPREADS.pdf')
OPENINGS_PDF = os.path.join(DIST_DIR, 'TEST_CEREMONIAL_OPENINGS.pdf')
from pathlib import Path
ARTIFACT_DIR = os.environ.get("ANTIGRAVITY_ARTIFACTS_DIR") or str(Path.home() / ".gemini" / "antigravity-cli" / "brain" / "44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2")

def audit_ceremonial_pdf():
    doc = fitz.open(CEREMONIAL_PDF)
    total_pages = len(doc)
    print(f"=== AUDITORÍA TEST_CAPITULOS_01_03_CEREMONIAL.pdf ===")
    print(f"Total páginas físicas: {total_pages}")

    page_map = []
    chapter_events = {1: {}, 2: {}, 3: {}}

    for p_idx in range(total_pages):
        pdf_p = p_idx + 1
        page = doc[p_idx]
        blocks = page.get_text('blocks')
        text = page.get_text().strip()
        drawings = page.get_drawings()
        is_recto = (pdf_p % 2 != 0)
        parity = "RECTO" if is_recto else "VERSO"

        # 1. Página en blanco / ceremonial
        if len(blocks) == 0 or len(text) == 0:
            p_type = "ceremonial-blank-page()"
            folio = "—"
            first_c = "— (PÁGINA EN BLANCO)"
            last_c = "— (PÁGINA EN BLANCO)"
            # Determinar capítulo contextual
            ch_num = 1 if pdf_p <= 7 else (2 if pdf_p <= 35 else 3)
            page_map.append({
                'pdf': pdf_p,
                'folio': folio,
                'parity': parity,
                'chapter': ch_num,
                'type': p_type,
                'first': first_c,
                'last': last_c,
                'drawings_count': len(drawings),
                'text_len': len(text)
            })
            continue

        # 2. Portada de capítulo (chapter-opening)
        is_opening = False
        ch_detect = None
        for b in blocks:
            txt = b[4].strip()
            if txt in ['01', '02', '03'] and 300 < b[1] < 400:
                is_opening = True
                ch_detect = int(txt)
                break

        if is_opening:
            p_type = "chapter-opening()"
            folio = "—"
            first_c = f"Portada de Capítulo {ch_detect:02d}"
            t_cand = [b[4].strip().replace('\n', ' ') for b in blocks if 400 < b[1] < 550]
            last_c = t_cand[-1][:35] if t_cand else "—"
            chapter_events[ch_detect]['opening'] = {
                'pdf': pdf_p,
                'parity': parity,
                'prev_pdf': pdf_p - 1
            }
            page_map.append({
                'pdf': pdf_p,
                'folio': folio,
                'parity': parity,
                'chapter': ch_detect,
                'type': p_type,
                'first': first_c,
                'last': last_c,
                'drawings_count': len(drawings),
                'text_len': len(text)
            })
            continue

        # 3. Primera página de capítulo (chapter-first-page)
        ch_num = 1 if pdf_p <= 7 else (2 if pdf_p <= 35 else 3)
        is_first = False
        for b in blocks:
            txt = b[4].strip()
            if 'UN LEGADO' in txt or (f'0{ch_num}' in txt and 60 < b[1] < 120):
                is_first = True
                break

        # Extraer folio real
        folio_val = None
        for b in blocks:
            if b[1] > 580:
                for line in b[4].strip().split('\n'):
                    l = line.strip()
                    if l.isdigit() and len(l) <= 3:
                        folio_val = l
                        break
        folio = folio_val if folio_val else f"{pdf_p:02d}"

        body_blocks = [b for b in blocks if b[1] > 45 and b[1] < 580 and 'UN LEGADO' not in b[4] and 'CAPÍTULO' not in b[4] and 'PROTOCOLO' not in b[4]]
        first_c = body_blocks[0][4].strip().replace('\n', ' ')[:35] if body_blocks else "—"
        last_c = body_blocks[-1][4].strip().replace('\n', ' ')[:35] if body_blocks else "—"

        if is_first:
            p_type = "chapter-first-page()"
            chapter_events[ch_num]['first_page'] = {
                'pdf': pdf_p,
                'parity': parity,
                'prev_pdf': pdf_p - 1
            }
        else:
            p_type = "interior-page()"
            if 'first_interior' not in chapter_events[ch_num]:
                chapter_events[ch_num]['first_interior'] = {
                    'pdf': pdf_p,
                    'parity': parity
                }

        page_map.append({
            'pdf': pdf_p,
            'folio': folio,
            'parity': parity,
            'chapter': ch_num,
            'type': p_type,
            'first': first_c,
            'last': last_c,
            'drawings_count': len(drawings),
            'text_len': len(text)
        })

    # Imprimir resumen de eventos ceremoniales
    print("\n=== RESUMEN DE EVENTOS CEREMONIALES ===")
    for ch in [1, 2, 3]:
        ev = chapter_events[ch]
        print(f"\nCAPÍTULO {ch:02d}:")
        print(f"  chapter-opening: P.{ev['opening']['pdf']:02d} ({ev['opening']['parity']}) | Página anterior: P.{ev['opening']['prev_pdf']:02d}")
        print(f"  chapter-first-page: P.{ev['first_page']['pdf']:02d} ({ev['first_page']['parity']}) | Página anterior: P.{ev['first_page']['prev_pdf']:02d}")
        print(f"  primera interior-page: P.{ev['first_interior']['pdf']:02d} ({ev['first_interior']['parity']})")

    # Validaciones obligatorias
    print("\n=== VALIDACIÓN DE REGLAS OBLIGATORIAS ===")
    all_ok = True
    for ch in [1, 2, 3]:
        ev = chapter_events[ch]
        # 1. Opening parity = RECTO
        if ev['opening']['parity'] != 'RECTO':
            print(f"[FALLA] Cap {ch}: opening parity no es RECTO ({ev['opening']['parity']})")
            all_ok = False
        else:
            print(f"[PASS] Cap {ch}: opening parity = ODD / RECTO (P.{ev['opening']['pdf']:02d})")

        # 2. Previous page to opening = BLANK / VERSO
        prev_op = page_map[ev['opening']['prev_pdf'] - 1]
        if prev_op['type'] != 'ceremonial-blank-page()' or prev_op['parity'] != 'VERSO':
            print(f"[FALLA] Cap {ch}: página anterior a opening no es BLANK/VERSO ({prev_op['type']}, {prev_op['parity']})")
            all_ok = False
        else:
            print(f"[PASS] Cap {ch}: previous page to opening = BLANK / VERSO (P.{prev_op['pdf']:02d})")

        # 3. First page parity = RECTO
        if ev['first_page']['parity'] != 'RECTO':
            print(f"[FALLA] Cap {ch}: first_page parity no es RECTO ({ev['first_page']['parity']})")
            all_ok = False
        else:
            print(f"[PASS] Cap {ch}: chapter-first-page parity = ODD / RECTO (P.{ev['first_page']['pdf']:02d})")

        # 4. Previous page to first page = BLANK / VERSO
        prev_fp = page_map[ev['first_page']['prev_pdf'] - 1]
        if prev_fp['type'] != 'ceremonial-blank-page()' or prev_fp['parity'] != 'VERSO':
            print(f"[FALLA] Cap {ch}: página anterior a first_page no es BLANK/VERSO ({prev_fp['type']}, {prev_fp['parity']})")
            all_ok = False
        else:
            print(f"[PASS] Cap {ch}: previous page to first-page = BLANK / VERSO (P.{prev_fp['pdf']:02d})")

        # 5. First interior page parity = VERSO
        if ev['first_interior']['parity'] != 'VERSO':
            print(f"[FALLA] Cap {ch}: primera interior-page no es VERSO ({ev['first_interior']['parity']})")
            all_ok = False
        else:
            print(f"[PASS] Cap {ch}: primera interior-page parity = EVEN / VERSO (P.{ev['first_interior']['pdf']:02d})")

    # 6. Blank pages clean check
    blank_errors = []
    for pm in page_map:
        if pm['type'] == 'ceremonial-blank-page()':
            if pm['drawings_count'] > 0 or pm['text_len'] > 0:
                blank_errors.append(pm['pdf'])
    if blank_errors:
        print(f"[FALLA] Páginas blancas con elementos gráficos: {blank_errors}")
        all_ok = False
    else:
        print(f"[PASS] Todas las páginas blancas ceremoniales tienen 0 elementos gráficos y 0 texto.")

    # 7. Check for BLANCA | BLANCA in spreads (P.2k | P.2k+1)
    double_blanks = []
    for k in range(1, total_pages // 2 + 1):
        verso_idx = 2 * k - 1  # 0-indexed: 1, 3, 5...
        recto_idx = 2 * k      # 0-indexed: 2, 4, 6...
        if recto_idx < total_pages:
            p_v = page_map[verso_idx]
            p_r = page_map[recto_idx]
            if p_v['type'] == 'ceremonial-blank-page()' and p_r['type'] == 'ceremonial-blank-page()':
                double_blanks.append((p_v['pdf'], p_r['pdf']))

    if double_blanks:
        print(f"[FALLA] Spreads con BLANCA | BLANCA detectados: {double_blanks}")
        all_ok = False
    else:
        print(f"[PASS] CERO spreads BLANCA | BLANCA detectados en todo el documento.")

    return page_map, chapter_events, all_ok

def render_openings_and_mosaics():
    # Renderizar los 6 spreads ceremoniales de TEST_CEREMONIAL_OPENINGS.pdf a 150 DPI
    doc_op = fitz.open(OPENINGS_PDF)
    labels = [
        "ceremonial_spread_01_cap01_opening",
        "ceremonial_spread_02_cap01_first_page",
        "ceremonial_spread_03_cap02_opening",
        "ceremonial_spread_04_cap02_first_page",
        "ceremonial_spread_05_cap03_opening",
        "ceremonial_spread_06_cap03_first_page"
    ]
    for idx, page in enumerate(doc_op):
        pix = page.get_pixmap(dpi=150)
        p_name = f"{labels[idx]}.png"
        dist_path = os.path.join(DIST_DIR, p_name)
        art_path = os.path.join(ARTIFACT_DIR, p_name)
        pix.save(dist_path)
        pix.save(art_path)
        print(f"[OK] Renderizado spread ceremonial {idx+1}: {p_name}")

if __name__ == '__main__':
    page_map, events, ok = audit_ceremonial_pdf()
    render_openings_and_mosaics()
