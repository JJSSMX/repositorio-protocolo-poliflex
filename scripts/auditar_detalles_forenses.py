"""
AUDITORÍA DE DETALLES FORENSES: WIDOWS, ORPHANS, HEADINGS, COLISIONES Y OVERFLOWS
Fase 3.7 - Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
"""

import os
import sys
import re
import fitz

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PDF_PATH = os.path.join(REPO_DIR, 'dist', 'TEST_CAPITULOS_01_03_COMPLETOS.pdf')
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')

def audit_details():
    doc = fitz.open(PDF_PATH)
    total_pages = len(doc)
    
    # 1. Inspeccionar Headings Huérfanos
    # Un heading está huérfano si es el último bloque de texto o si b[3] > 540
    orphan_headings = []
    headings = []
    
    for p_idx in range(total_pages):
        p_num = p_idx + 1
        page = doc[p_idx]
        blocks = page.get_text('blocks')
        
        # Filtramos bloques de cabecera y pie
        content_blocks = [b for b in blocks if b[1] >= 50 and b[1] <= 575 and 'UN LEGADO' not in b[4] and 'CAPÍTULO' not in b[4]]
        
        for i, b in enumerate(content_blocks):
            txt = b[4].strip()
            m = re.match(r'^([1-3]\.[0-9]+(?:\.[0-9]+)*\.?)\s+(.*)', txt)
            if m:
                h_info = {
                    'page': p_num,
                    'num': m.group(1),
                    'title': m.group(2).split('\n')[0],
                    'y0': b[1],
                    'y1': b[3],
                    'is_last': (i == len(content_blocks) - 1),
                    'following_blocks': len(content_blocks) - 1 - i
                }
                headings.append(h_info)
                
                # Criterio de orfandad: es el último bloque en la página o no tiene al menos 2 líneas de texto después
                if h_info['is_last'] or b[3] > 545:
                    orphan_headings.append(h_info)
                    
    print(f"Total headings evaluados: {len(headings)}")
    print(f"Headings huérfanos detectados: {len(orphan_headings)}")
    for oh in orphan_headings:
        print(f"  [ALERTA HUÉRFANO] P.{oh['page']:02d}: {oh['num']} {oh['title']} (y1={oh['y1']:.2f}, following={oh['following_blocks']})")
        
    # 2. Overflows y Colisiones
    # Colisión ocurre si el último bloque de contenido supera y=575 (colisiona con footer)
    # Overflow ocurre si hay texto fuera del MediaBox (y > 612)
    overflows = []
    footer_collisions = []
    
    for p_idx in range(total_pages):
        p_num = p_idx + 1
        page = doc[p_idx]
        blocks = page.get_text('blocks')
        
        for b in blocks:
            if b[3] > 612:
                overflows.append({'page': p_num, 'block': b[4][:40], 'y1': b[3]})
            # Si un bloque de contenido general (no footer) pasa de 575
            if b[1] < 575 and b[3] > 575 and 'PROTOCOLO' not in b[4] and not b[4].strip().isdigit():
                footer_collisions.append({'page': p_num, 'block': b[4][:40], 'y1': b[3]})
                
    print(f"\nOverflows detectados (y > 612): {len(overflows)}")
    print(f"Colisiones con footer detectadas (y > 575): {len(footer_collisions)}")
    for fc in footer_collisions:
        print(f"  [ALERTA COLISIÓN] P.{fc['page']:02d}: {fc['block']} (y1={fc['y1']:.2f})")
        
    # 3. Detección de Líneas Aisladas (Widows / Orphans)
    # Analizamos párrafos que comienzan o terminan en cada página
    widows_orphans = []
    for p_idx in range(total_pages):
        p_num = p_idx + 1
        page = doc[p_idx]
        blocks = page.get_text('blocks')
        # Content blocks
        cb = [b for b in blocks if b[1] >= 50 and b[1] <= 575 and 'UN LEGADO' not in b[4] and 'CAPÍTULO' not in b[4]]
        if not cb:
            continue
            
        # Revisar primer bloque de la página
        first_b = cb[0]
        f_lines = [l for l in first_b[4].strip().split('\n') if l.strip()]
        # Si el primer bloque tiene solo 1 línea y no es un heading ni lista
        if len(f_lines) == 1 and not re.match(r'^[1-3]\.[0-9]+', f_lines[0]) and not re.match(r'^[a-z]\)', f_lines[0]):
            widows_orphans.append({'page': p_num, 'type': 'widow_candidate', 'line': f_lines[0][:60]})
            
        # Revisar último bloque de la página
        last_b = cb[-1]
        l_lines = [l for l in last_b[4].strip().split('\n') if l.strip()]
        if len(l_lines) == 1 and not re.match(r'^[1-3]\.[0-9]+', l_lines[0]) and not re.match(r'^[a-z]\)', l_lines[0]):
            widows_orphans.append({'page': p_num, 'type': 'orphan_candidate', 'line': l_lines[0][:60]})
            
    print(f"\nCandidatos a Widow / Orphan detectados: {len(widows_orphans)}")
    for wo in widows_orphans:
        print(f"  P.{wo['page']:02d} [{wo['type']}]: {wo['line']}")
        
    # 4. Auditoría de Fuentes Embebidas
    fonts = set()
    for p_idx in range(total_pages):
        page = doc[p_idx]
        for f in page.get_fonts():
            fonts.add((f[3], f[4]))  # (font name, font type)
            
    print(f"\nFuentes embebidas detectadas ({len(fonts)}):")
    for f in sorted(fonts):
        print(f"  {f[0]} ({f[1]})")

if __name__ == '__main__':
    audit_details()
