"""
AUDITORÍA FORENSE AUTOMATIZADA: PRUEBA DE ESTRÉS CAPÍTULOS 01-03
Fase 3.7 - Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
Inspecciona exhaustivamente TEST_CAPITULOS_01_03_COMPLETOS.pdf y genera
el mapa de páginas y la evaluación de los 24 puntos de auditoría.
"""

import os
import sys
import re
import fitz  # PyMuPDF
import yaml

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PDF_PATH = os.path.join(REPO_DIR, 'dist', 'TEST_CAPITULOS_01_03_COMPLETOS.pdf')
REPORT_PATH = os.path.join(REPO_DIR, 'reportes', 'reporte_prueba_estres_capitulos_01_03.md')

def audit_document():
    doc = fitz.open(PDF_PATH)
    total_pages = len(doc)
    print(f"Total pages in PDF: {total_pages}")
    
    page_map = []
    
    chapter_openings = []
    chapter_first_pages = []
    continuation_pages = []
    courtesy_pages = []
    
    chapter_ranges = {1: [], 2: [], 3: []}
    current_chapter = 1
    
    for p_idx in range(total_pages):
        pdf_page_num = p_idx + 1
        page = doc[p_idx]
        text = page.get_text()
        blocks = page.get_text('blocks')
        is_recto = (pdf_page_num % 2 != 0)
        parity_str = "RECTO" if is_recto else "VERSO"
        
        # Clasificar tipo de página
        # 1. Página de cortesía (completamente vacía)
        if len(blocks) == 0 or len(text.strip()) == 0:
            p_type = "courtesy-page"
            courtesy_pages.append(pdf_page_num)
            folio_str = "—"
            first_c = "— (PÁGINA EN BLANCO)"
            last_c = "— (PÁGINA EN BLANCO)"
            page_map.append({
                'pdf': pdf_page_num,
                'folio': folio_str,
                'parity': parity_str,
                'chapter': current_chapter,
                'type': p_type,
                'first': first_c,
                'last': last_c,
                'text': text,
                'blocks': blocks
            })
            chapter_ranges[current_chapter].append(pdf_page_num)
            continue
            
        # 2. Portada de capítulo (chapter-opening)
        # Se identifica por tener el número display 01, 02 o 03 con y entre 330 y 380,
        # o texto de descripción de capítulo, o no tener running header ni filete vertical
        is_opening = False
        ch_detect = None
        for b in blocks:
            txt = b[4].strip()
            if txt in ['01', '02', '03'] and b[1] > 300 and b[1] < 400:
                is_opening = True
                ch_detect = int(txt)
                break
                
        if is_opening:
            p_type = "chapter-opening"
            current_chapter = ch_detect
            chapter_openings.append(pdf_page_num)
            chapter_ranges[current_chapter].append(pdf_page_num)
            folio_str = "—"
            first_c = f"Apertura Capítulo {current_chapter:02d}"
            # find title in blocks
            t_candidates = [b[4].strip() for b in blocks if b[1] > 400 and b[1] < 550]
            last_c = t_candidates[-1].replace('\n', ' ')[:40] if t_candidates else "—"
            page_map.append({
                'pdf': pdf_page_num,
                'folio': folio_str,
                'parity': parity_str,
                'chapter': current_chapter,
                'type': p_type,
                'first': first_c,
                'last': last_c,
                'text': text,
                'blocks': blocks
            })
            continue
            
        # 3. Primera página de capítulo (chapter-first-page)
        # Se identifica por tener el claim institucional superior y número display en y < 150
        is_first = False
        for b in blocks:
            txt = b[4].strip()
            if 'UN LEGADO' in txt or ('0' + str(current_chapter) in txt and b[1] < 120 and b[1] > 60):
                is_first = True
                break
                
        # Extraer folio real del pie de página (y > 580)
        folio_val = None
        for b in blocks:
            if b[1] > 580:
                lines = b[4].strip().split('\n')
                for l in lines:
                    l_s = l.strip()
                    if l_s.isdigit() and len(l_s) <= 3:
                        folio_val = l_s
                        break
        folio_str = folio_val if folio_val else f"{pdf_page_num:02d}"
        
        # Primer y último contenido del cuerpo (excluyendo cabecera y pie)
        body_blocks = [b for b in blocks if b[1] > 50 and b[1] < 580 and 'UN LEGADO' not in b[4] and 'CAPÍTULO' not in b[4] and 'PROTOCOLO FAMILIAR' not in b[4]]
        if body_blocks:
            first_c = body_blocks[0][4].strip().replace('\n', ' ')[:45]
            last_c = body_blocks[-1][4].strip().replace('\n', ' ')[:45]
        else:
            first_c = "—"
            last_c = "—"
            
        if is_first:
            p_type = "chapter-first-page"
            chapter_first_pages.append(pdf_page_num)
        else:
            p_type = "interior-page"
            continuation_pages.append(pdf_page_num)
            
        chapter_ranges[current_chapter].append(pdf_page_num)
        page_map.append({
            'pdf': pdf_page_num,
            'folio': folio_str,
            'parity': parity_str,
            'chapter': current_chapter,
            'type': p_type,
            'first': first_c,
            'last': last_c,
            'text': text,
            'blocks': blocks
        })
        
    return doc, page_map, chapter_openings, chapter_first_pages, continuation_pages, courtesy_pages, chapter_ranges

if __name__ == '__main__':
    doc, page_map, openings, first_pages, cont_pages, courtesy_pages, ch_ranges = audit_document()
    print(f"Openings: {openings}")
    print(f"First Pages: {first_pages}")
    print(f"Continuation Pages: {len(cont_pages)}")
    print(f"Courtesy Pages: {courtesy_pages}")
    print(f"Chapter Ranges: {ch_ranges}")
    print("\nSAMPLE PAGE MAP (first 10):")
    for pm in page_map[:10]:
        print(f"PDF {pm['pdf']:02d} | Folio {pm['folio']} | {pm['parity']} | Cap {pm['chapter']:02d} | {pm['type']} | {pm['first'][:30]} | {pm['last'][:30]}")
