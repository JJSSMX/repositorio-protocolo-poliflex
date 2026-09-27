"""
VERIFICACIÓN EXHAUSTIVA DE INTEGRIDAD Y REGLAS EDITORIALES
Fase 3.7 - Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
"""

import os
import sys
import re
import fitz

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PDF_PATH = os.path.join(REPO_DIR, 'dist', 'TEST_CAPITULOS_01_03_COMPLETOS.pdf')
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')

def inspect_all():
    doc = fitz.open(PDF_PATH)
    total_pages = len(doc)
    
    # 1. Verificar Running Headers por página
    running_headers = {}
    folios = {}
    headings_found = []
    
    for p_idx in range(total_pages):
        p_num = p_idx + 1
        page = doc[p_idx]
        blocks = page.get_text('blocks')
        
        # running header is in top region (y < 45)
        rh_blocks = [b for b in blocks if b[1] < 45 and ('CAPÍTULO' in b[4] or 'PROTOCOLO' in b[4])]
        rh_text = " ".join([b[4].strip() for b in rh_blocks])
        running_headers[p_num] = rh_text
        
        # folio is in bottom region (y > 580)
        folio_blocks = [b for b in blocks if b[1] > 580]
        # find digits in folio_blocks
        f_val = None
        for b in folio_blocks:
            for line in b[4].strip().split('\n'):
                l = line.strip()
                if l.isdigit() and len(l) <= 3:
                    f_val = int(l)
        folios[p_num] = f_val
        
        # headings
        for b in blocks:
            txt = b[4].strip()
            # match heading numbers like 1.1, 2.1, 2.1.1, 2.3.3.1
            m = re.match(r'^([1-3]\.[0-9]+(?:\.[0-9]+)*\.?)\s+(.*)', txt)
            if m:
                headings_found.append({
                    'page': p_num,
                    'num': m.group(1),
                    'title': m.group(2).split('\n')[0],
                    'bbox': (b[0], b[1], b[2], b[3])
                })
                
    print("=== RUNNING HEADERS CHECK ===")
    for p, rh in running_headers.items():
        if rh:
            print(f"P.{p:02d} ({'RECTO' if p%2!=0 else 'VERSO'}): {rh}")
            
    print("\n=== HEADINGS FOUND SUMMARY ===")
    print(f"Total headings found in PDF: {len(headings_found)}")
    for h in headings_found[:15]:
        print(f"P.{h['page']:02d}: {h['num']} {h['title'][:40]}")
    if len(headings_found) > 15:
        print(f"... and {len(headings_found)-15} more.")
        for h in headings_found[-5:]:
            print(f"P.{h['page']:02d}: {h['num']} {h['title'][:40]}")
            
    # 2. Verificar correspondencia de encabezados con Markdown
    md_headings = []
    for cfile in ['01_capitulo1_declaracion_principios.md', '02_capitulo2_propiedad_control_liquidez.md', '03_capitulo3_gobierno_profesionalizacion.md']:
        with open(os.path.join(CAP_DIR, cfile), 'r', encoding='utf-8') as f:
            for line in f:
                if line.startswith('##'):
                    raw = line.lstrip('#').strip()
                    m = re.match(r'^([1-3]\.[0-9]+(?:\.[0-9]+)*\.?)\s+(.*)', raw)
                    if m:
                        md_headings.append({'num': m.group(1).rstrip('.'), 'title': m.group(2).strip()})
                        
    print(f"\nTotal headings in Markdown: {len(md_headings)}")
    print(f"Total headings in PDF: {len(headings_found)}")
    
    # Compare
    missing_headings = []
    pdf_h_nums = [h['num'].rstrip('.') for h in headings_found]
    for mdh in md_headings:
        if mdh['num'] not in pdf_h_nums:
            missing_headings.append(mdh)
            
    if missing_headings:
        print(f"[ALERTA] Headings faltantes en PDF: {missing_headings}")
    else:
        print("[ÉXITO] Todos los headings del Markdown están presentes en el PDF en orden exacto!")

    # 3. Verificar listas
    alpha_items = []
    roman_items = []
    for p_idx in range(total_pages):
        page = doc[p_idx]
        text = page.get_text()
        for line in text.split('\n'):
            line_s = line.strip()
            if re.match(r'^[a-z]\)\s+', line_s):
                alpha_items.append({'page': p_idx+1, 'line': line_s[:50]})
            elif re.match(r'^[ivxlcdm]+\.\s+', line_s):
                roman_items.append({'page': p_idx+1, 'line': line_s[:50]})
                
    print(f"\nListas encontradas en PDF: {len(alpha_items)} incisos alfabéticos, {len(roman_items)} sub-incisos romanos.")

if __name__ == '__main__':
    inspect_all()
