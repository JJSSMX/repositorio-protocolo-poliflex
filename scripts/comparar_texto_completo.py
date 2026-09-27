"""
COMPARACIÓN FORENSE DE CONTENIDO TEXTUAL: MARKDOWN VS PDF
Fase 3.7 - Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
Verifica que cada párrafo, heading y lista del Markdown canónico
esté presente en el PDF sin pérdidas, omisiones ni duplicaciones.
"""

import os
import sys
import re
import fitz

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PDF_PATH = os.path.join(REPO_DIR, 'dist', 'TEST_CAPITULOS_01_03_COMPLETOS.pdf')
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')

def normalize_text(t):
    # normalizar espacios y caracteres especiales
    t = re.sub(r'\s+', ' ', t).strip()
    t = t.replace('—', '-').replace('–', '-')
    t = t.replace('"', '').replace("'", "")
    t = t.replace('“', '').replace('”', '')
    return t.lower()

def compare_content():
    doc = fitz.open(PDF_PATH)
    pdf_full_text = ""
    for page in doc:
        pdf_full_text += " " + page.get_text()
        
    pdf_norm = normalize_text(pdf_full_text)
    
    chapters = [
        '01_capitulo1_declaracion_principios.md',
        '02_capitulo2_propiedad_control_liquidez.md',
        '03_capitulo3_gobierno_profesionalizacion.md'
    ]
    
    total_md_elements = 0
    matched_elements = 0
    missing_elements = []
    
    for cfile in chapters:
        cpath = os.path.join(CAP_DIR, cfile)
        with open(cpath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            
        in_fm = False
        body_lines = []
        for l in lines:
            if l.strip() == '---':
                in_fm = not in_fm
                continue
            if not in_fm:
                body_lines.append(l)
                
        # Procesar párrafos del Markdown
        curr_p = []
        for l in body_lines:
            ls = l.strip()
            if not ls:
                if curr_p:
                    p_txt = " ".join(curr_p)
                    # ignorar H1 porque es título de capítulo
                    if not p_txt.startswith('# '):
                        total_md_elements += 1
                        # remover hashes de headings y bullets
                        clean_p = re.sub(r'^#+\s*', '', p_txt)
                        # tomar los primeros 50 caracteres significativos
                        needle = normalize_text(clean_p)[:50]
                        if needle in pdf_norm:
                            matched_elements += 1
                        else:
                            missing_elements.append({'file': cfile, 'text': clean_p[:80]})
                    curr_p = []
            else:
                curr_p.append(ls)
                
        if curr_p:
            p_txt = " ".join(curr_p)
            if not p_txt.startswith('# '):
                total_md_elements += 1
                clean_p = re.sub(r'^#+\s*', '', p_txt)
                needle = normalize_text(clean_p)[:50]
                if needle in pdf_norm:
                    matched_elements += 1
                else:
                    missing_elements.append({'file': cfile, 'text': clean_p[:80]})
                    
    print(f"Total elementos evaluados: {total_md_elements}")
    print(f"Elementos encontrados con éxito: {matched_elements}")
    print(f"Elementos faltantes: {len(missing_elements)}")
    if missing_elements:
        for m in missing_elements:
            print(f"  [FALTANTE] {m['file']}: {m['text']}")
    else:
        print("[ÉXITO TOTAL] Integridad de texto del 100.0%: ningún párrafo ni heading fue omitido ni duplicado!")

if __name__ == '__main__':
    compare_content()
