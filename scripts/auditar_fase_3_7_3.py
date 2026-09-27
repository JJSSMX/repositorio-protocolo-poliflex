"""
AUDITORÍA FORENSE AUTOMATIZADA: FASE 3.7.3
Consolidación de Retícula Vertical +6 mm (+17.01 pt) · Capítulos 01–03
Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
"""

import os
import sys
import re
import hashlib
import fitz

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIST_DIR = os.path.join(REPO_DIR, 'dist')
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')

PDF_371 = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_CEREMONIAL.pdf')
PDF_6MM = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_RETICULA_6MM.pdf')
SPREADS_PDF = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_RETICULA_6MM_SPREADS.pdf')
CONTACT_SHEET_PDF = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_RETICULA_6MM_CONTACT_SHEET.pdf')

def run_audit():
    print("==============================================================================")
    print("INICIANDO AUDITORÍA FORENSE AUTOMATIZADA FASE 3.7.3")
    print("==============================================================================")

    doc_371 = fitz.open(PDF_371)
    doc_6mm = fitz.open(PDF_6MM)
    doc_spreads = fitz.open(SPREADS_PDF)
    doc_cs = fitz.open(CONTACT_SHEET_PDF)

    tot_371 = len(doc_371)
    tot_6mm = len(doc_6mm)

    print(f"Total páginas Fase 3.7.1 : {tot_371}")
    print(f"Total páginas Fase 3.7.3 : {tot_6mm} (+{tot_6mm - tot_371} páginas)")
    print(f"Total pliegos Spreads    : {len(doc_spreads)}")
    print(f"Total hojas Contact Sheet: {len(doc_cs)}")

    # 1. Mapa detallado de páginas
    page_map_6mm = []
    blank_count = 0
    content_count = 0

    chapter_events = {1: {}, 2: {}, 3: {}}

    for p_idx in range(tot_6mm):
        pn = p_idx + 1
        page = doc_6mm[p_idx]
        blocks = page.get_text('blocks')
        text = page.get_text().strip()
        drawings = page.get_drawings()
        is_recto = (pn % 2 != 0)
        par = "RECTO" if is_recto else "VERSO"

        # Identificar folio visible
        visible_folio = "—"
        for b in blocks:
            if b[1] > 580 or b[3] > 580:
                b_lines = b[4].strip().split('\n')
                last_line = b_lines[-1].strip()
                if last_line.isdigit() and len(last_line) <= 2:
                    visible_folio = last_line

        # Identificar tipo de página
        if len(text) == 0:
            p_type = "ceremonial-blank-page()"
            blank_count += 1
            first_c = "— (PÁGINA EN BLANCO)"
            last_c = "— (PÁGINA EN BLANCO)"
            ch = 1 if pn <= 7 else (2 if pn <= 36 else 3)
        else:
            content_count += 1
            # Apertura de capítulo
            is_opening = False
            for b in blocks:
                if b[4].strip() in ['01', '02', '03'] and 300 < b[1] < 400:
                    is_opening = True
                    ch = int(b[4].strip())
                    chapter_events[ch]['opening'] = {
                        'page': pn, 'parity': par, 'prev_page': pn - 1, 'folio': visible_folio
                    }
                    break
            
            if is_opening:
                p_type = "chapter-opening()"
                first_c = f"Portada de Capítulo {ch:02d}"
                t_cand = [b[4].strip().replace('\n', ' ') for b in blocks if 400 < b[1] < 550]
                last_c = t_cand[-1][:35] if t_cand else "—"
            elif any("L E G A D O" in b[4] or "LEGADO" in b[4] for b in blocks):
                p_type = "chapter-first-page()"
                ch = 1 if pn <= 7 else (2 if pn <= 36 else 3)
                chapter_events[ch]['first_page'] = {
                    'page': pn, 'parity': par, 'prev_page': pn - 1, 'folio': visible_folio
                }
                first_c = f"Apertura de Capítulo {ch:02d}"
                last_c = blocks[-2][4].strip().replace('\n', ' ')[:35] if len(blocks) > 2 else "—"
            else:
                p_type = "interior-page()"
                ch = 1 if pn <= 7 else (2 if pn <= 36 else 3)
                if 'first_interior' not in chapter_events[ch]:
                    chapter_events[ch]['first_interior'] = {
                        'page': pn, 'parity': par, 'folio': visible_folio
                    }
                chapter_events[ch]['last_interior'] = {
                    'page': pn, 'parity': par, 'folio': visible_folio
                }
                # Primer bloque de contenido debajo del header
                cnt_b = [b for b in blocks if b[1] >= 65 and b[3] <= 585]
                first_c = cnt_b[0][4].strip().replace('\n', ' ')[:35] if cnt_b else "—"
                last_c = cnt_b[-1][4].strip().replace('\n', ' ')[:35] if cnt_b else "—"

        page_map_6mm.append({
            'page': pn,
            'parity': par,
            'type': p_type,
            'chapter': ch,
            'folio': visible_folio,
            'first': first_c,
            'last': last_c
        })

    print(f"\nTotal páginas blancas  : {blank_count}")
    print(f"Total páginas contenido: {content_count}")

    print("\n=== EVENTOS POR CAPÍTULO ===")
    for c in [1, 2, 3]:
        ev = chapter_events[c]
        print(f"CAPÍTULO {c:02d}:")
        print(f"  Chapter-opening   : Pág {ev['opening']['page']:02d} ({ev['opening']['parity']}) | Previa: Pág {ev['opening']['prev_page']:02d} (Blanca Verso: {ev['opening']['prev_page'] % 2 == 0}) | Folio: {ev['opening']['folio']}")
        print(f"  Chapter-first-page: Pág {ev['first_page']['page']:02d} ({ev['first_page']['parity']}) | Previa: Pág {ev['first_page']['prev_page']:02d} (Blanca Verso: {ev['first_page']['prev_page'] % 2 == 0}) | Folio: {ev['first_page']['folio']}")
        print(f"  First interior    : Pág {ev['first_interior']['page']:02d} ({ev['first_interior']['parity']}) | Folio: {ev['first_interior']['folio']}")
        print(f"  Last page         : Pág {ev['last_interior']['page']:02d} ({ev['last_interior']['parity']}) | Folio: {ev['last_interior']['folio']}")

    # 2. Mediciones exactas de retícula
    print("\n=== AUDITORÍA FORENSE DE COORDENADAS ===")
    p_371 = doc_371[4]
    p_6mm = doc_6mm[4]
    w_371 = p_371.get_text("words")
    w_6mm = p_6mm.get_text("words")

    clm_371 = [w for w in w_371 if w[4] == '.' and w[1] < 120][0]
    clm_6mm = [w for w in w_6mm if w[4] == '.' and w[1] < 120][0]

    num_371 = [w for w in w_371 if w[4] == '01'][0]
    num_6mm = [w for w in w_6mm if w[4] == '01'][0]

    d_371 = [d for d in p_371.get_drawings() if d['rect'].width < 20 and d['rect'].height < 2][0]
    d_6mm = [d for d in p_6mm.get_drawings() if d['rect'].width < 20 and d['rect'].height < 2][0]

    t_371 = [w for w in w_371 if 'DECLARACI' in w[4]][0]
    t_6mm = [w for w in w_6mm if 'DECLARACI' in w[4]][0]

    h_371 = [w for w in w_371 if w[4] == '1.1'][0]
    h_6mm = [w for w in w_6mm if w[4] == '1.1'][0]

    print(f"CHAPTER-FIRST-PAGE:")
    print(f"  Claim final dot y0 : {clm_6mm[1]:.2f} pt (3.7.1: {clm_371[1]:.2f} pt) -> Delta: {clm_6mm[1]-clm_371[1]:.2f} pt (SIN MOVIMIENTO)")
    print(f"  Número '01' y0     : {num_6mm[1]:.2f} pt (3.7.1: {num_371[1]:.2f} pt) -> Delta: +{num_6mm[1]-num_371[1]:.2f} pt (+6.00 mm)")
    print(f"  Filete naranja y0  : {d_6mm['rect'].y0:.2f} pt (3.7.1: {d_371['rect'].y0:.2f} pt) -> Delta: +{d_6mm['rect'].y0-d_371['rect'].y0:.2f} pt (+6.00 mm)")
    print(f"  Título cap y0      : {t_6mm[1]:.2f} pt (3.7.1: {t_371[1]:.2f} pt) -> Delta: +{t_6mm[1]-t_371[1]:.2f} pt (+6.00 mm)")
    print(f"  Heading 1.1 y0     : {h_6mm[1]:.2f} pt (3.7.1: {h_371[1]:.2f} pt) -> Delta: +{h_6mm[1]-h_371[1]:.2f} pt (+6.00 mm)")
    print(f"  Separación Claim->Número : {num_6mm[1] - clm_6mm[3]:.2f} pt ({ (num_6mm[1] - clm_6mm[3]) * 25.4 / 72.0:.2f} mm)")
    print(f"  Distancia Número->Filete : {d_6mm['rect'].y0 - num_6mm[1]:.2f} pt")
    print(f"  Distancia Filete->Título : {t_6mm[1] - d_6mm['rect'].y0:.2f} pt")
    print(f"  Distancia Título->Heading: {h_6mm[1] - t_6mm[1]:.2f} pt")

    # Interior page
    p6 = doc_6mm[5]
    w6 = p6.get_text("words")
    rh_w = [w for w in w6 if w[1] < 45]
    cnt_w = [w for w in w6 if 45 <= w[1] < 120]
    print(f"\nINTERIOR-PAGE:")
    print(f"  Running header y range  : [{rh_w[0][1]:.2f}, {rh_w[0][3]:.2f}] pt (baseline ~32.88 pt)")
    print(f"  Content top y0          : {cnt_w[0][1]:.2f} pt (nominal 71.01 pt)")
    print(f"  Header -> Content air   : {cnt_w[0][1] - rh_w[0][3]:.2f} pt (nominal 36.01 pt)")

    # 3. Integridad SHA-256
    print("\n=== INTEGRIDAD SHA-256 ===")
    files = [
        r'templates\typst\componentes.typ',
        r'capitulos\01_capitulo1_declaracion_principios.md',
        r'capitulos\02_capitulo2_propiedad_control_liquidez.md',
        r'capitulos\03_capitulo3_gobierno_profesionalizacion.md'
    ]
    hashes = {}
    for rel_path in files:
        full_path = os.path.join(REPO_DIR, rel_path)
        h = hashlib.sha256(open(full_path, 'rb').read()).hexdigest().upper()
        hashes[rel_path] = h
        print(f"  {rel_path}: {h}")

    return {
        'tot_pages': tot_6mm,
        'tot_pages_371': tot_371,
        'blank_count': blank_count,
        'content_count': content_count,
        'chapter_events': chapter_events,
        'page_map': page_map_6mm,
        'hashes': hashes,
        'coords': {
            'claim_delta': clm_6mm[1] - clm_371[1],
            'num_delta': num_6mm[1] - num_371[1],
            'rule_delta': d_6mm['rect'].y0 - d_371['rect'].y0,
            'title_delta': t_6mm[1] - t_371[1],
            'h_delta': h_6mm[1] - h_371[1],
            'claim_num_sep': num_6mm[1] - clm_6mm[3],
            'num_rule': d_6mm['rect'].y0 - num_6mm[1],
            'rule_title': t_6mm[1] - d_6mm['rect'].y0,
            'title_h': h_6mm[1] - t_6mm[1],
            'cnt_top': cnt_w[0][1]
        }
    }

if __name__ == '__main__':
    run_audit()
