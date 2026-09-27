import os
import re
import yaml
import hashlib
import pymupdf

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
CONFIG_FILE = os.path.join(REPO_DIR, 'config', 'editorial_config.yaml')
TEMPLATES_DIR = os.path.join(REPO_DIR, 'templates', 'typst')

all_chapters = [
    '01_capitulo1_declaracion_principios.md',
    '02_capitulo2_propiedad_control_liquidez.md',
    '03_capitulo3_gobierno_profesionalizacion.md',
    '04_capitulo4_sucesion_familiar.md',
    '05_capitulo5_control_informacion_comunicacion.md',
    '06_capitulo6_disciplina_financiera.md',
    '07_capitulo7_procedimiento_sancionador.md',
    '08_capitulo8_solucion_conflictos.md',
    '09_capitulo9_regimen_juridico.md'
]

master_pdf = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09.pdf')
doc = pymupdf.open(master_pdf)

print(f"================================================================================")
print(f"AUDITOR FORENSE INTEGRAL: PRUEBA DE ESTRÉS CAPÍTULOS 01–09")
print(f"Documento analizado: {master_pdf} ({len(doc)} páginas)")
print(f"================================================================================\n")

# 1. HASHES CANÓNICOS
print("--- 1. VERIFICACIÓN DE HASHES CANÓNICOS ---")
canonical_hashes = {}
for cf in all_chapters:
    cpath = os.path.join(CAP_DIR, cf)
    with open(cpath, 'rb') as f:
        h = hashlib.sha256(f.read()).hexdigest().upper()
    canonical_hashes[cf] = h
    print(f"  {cf}: {h}")

comp_typ = os.path.join(TEMPLATES_DIR, 'componentes.typ')
with open(comp_typ, 'rb') as f:
    comp_hash = hashlib.sha256(f.read()).hexdigest().upper()
print(f"  componentes.typ: {comp_hash}\n")

# 2. ANÁLISIS DE PÁGINAS Y CLASIFICACIÓN
page_data = []

chapter_ranges = [
    (1, 3, 5, 8),
    (2, 11, 13, 40),
    (3, 43, 45, 61),
    (4, 63, 65, 87),
    (5, 89, 91, 94),
    (6, 97, 99, 102),
    (7, 105, 107, 111),
    (8, 113, 115, 119),
    (9, 121, 123, 126)
]

def get_chapter_for_page(pno):
    for ch, op, fp, end in chapter_ranges:
        if fp <= pno <= end:
            return ch
        if pno == op:
            return ch
        # check preceding blanks
        if ch == 1 and pno in [1, 2, 4]:
            return ch
        if ch == 2 and pno in [9, 10, 12]:
            return ch
        if ch == 3 and pno in [41, 42, 44]:
            return ch
        if ch == 4 and pno in [62, 64]:
            return ch
        if ch == 5 and pno in [88, 90]:
            return ch
        if ch == 6 and pno in [95, 96, 98]:
            return ch
        if ch == 7 and pno in [103, 104, 106]:
            return ch
        if ch == 8 and pno in [112, 114]:
            return ch
        if ch == 9 and pno in [120, 122]:
            return ch
    return None

for pno in range(1, len(doc) + 1):
    page = doc[pno - 1]
    is_recto = (pno % 2 != 0)
    d = page.get_text('dict')
    raw_text = page.get_text()
    lines_text = [l.strip() for l in raw_text.splitlines() if l.strip()]
    
    # Classify page type
    is_blank = (len(d['blocks']) == 0 or len(lines_text) == 0)
    is_opening = any(pno == op for _, op, _, _ in chapter_ranges)
    is_first = any(pno == fp for _, _, fp, _ in chapter_ranges)
    is_interior = not is_blank and not is_opening and not is_first
    
    ch = get_chapter_for_page(pno)
    
    # Extract blocks & spans
    text_blocks = []
    body_lines = []
    headings_on_page = []
    folios = []
    rh_texts = []
    
    for b in d['blocks']:
        if b.get('type') == 0:
            for l in b['lines']:
                line_str = "".join([s['text'] for s in l['spans']]).strip()
                bbox = l['bbox']
                baseline = l['spans'][0]['origin'][1] if l['spans'] else bbox[3]
                
                # Check folio
                if bbox[1] > 500 and (line_str == f"{pno:02d}" or line_str == f"{pno}"):
                    folios.append({'text': line_str, 'bbox': bbox, 'baseline': baseline})
                elif bbox[1] < 50:
                    rh_texts.append({'text': line_str, 'bbox': bbox, 'baseline': baseline})
                else:
                    # check if heading
                    m = re.match(r'^([1-9]\.[0-9]+(?:\.[0-9]+)*)\.?\s+(.*)', line_str)
                    if m:
                        headings_on_page.append({'num': m.group(1), 'title': m.group(2), 'bbox': bbox, 'baseline': baseline, 'line': line_str})
                    elif not any(k in line_str for k in ['UN LEGADO', 'TRASCIENDE', 'CONSTRUIMOS JUNTOS']) and not line_str.isdigit():
                        body_lines.append({'text': line_str, 'bbox': bbox, 'baseline': baseline})
            text_blocks.append(b)
            
    page_data.append({
        'pno': pno,
        'is_recto': is_recto,
        'is_blank': is_blank,
        'is_opening': is_opening,
        'is_first': is_first,
        'is_interior': is_interior,
        'chapter': ch,
        'raw_text': raw_text,
        'lines_text': lines_text,
        'body_lines': body_lines,
        'headings': headings_on_page,
        'folios': folios,
        'rh_texts': rh_texts,
        'blocks': text_blocks
    })

print(f"Total páginas clasificadas:")
print(f"  Páginas de cortesía / blancas ceremoniales: {sum(1 for p in page_data if p['is_blank'])}")
print(f"  Páginas de Chapter-Opening: {sum(1 for p in page_data if p['is_opening'])}")
print(f"  Páginas de Chapter-First-Page: {sum(1 for p in page_data if p['is_first'])}")
print(f"  Páginas de Interior-Page (continuación): {sum(1 for p in page_data if p['is_interior'])}")
print(f"  TOTAL: {len(page_data)} páginas\n")

# 3. DETECCIÓN DE ENCABEZADOS HUÉRFANOS (< 2 líneas posteriores)
print("--- 2. DETECCIÓN DE ENCABEZADOS HUÉRFANOS ---")
orphan_headings = []
for p in page_data:
    if p['headings']:
        for h in p['headings']:
            # Find body lines below this heading on this page
            h_y = h['bbox'][3]
            lines_below = [bl for bl in p['body_lines'] if bl['bbox'][1] >= h_y - 2.0]
            if len(lines_below) < 2:
                orphan_headings.append({
                    'page': p['pno'],
                    'chapter': p['chapter'],
                    'heading': h['line'],
                    'lines_below': len(lines_below),
                    'h_y': h_y
                })

print(f"Encabezados huérfanos detectados: {len(orphan_headings)}")
for oh in orphan_headings:
    print(f"  [ORFANATO] Pág {oh['page']:02d} (Cap {oh['chapter']:02d}): '{oh['heading']}' (solo {oh['lines_below']} líneas posteriores)")

# 4. DETECCIÓN DE VIUDAS Y HUÉRFANAS DE PÁRRAFO
print("\n--- 3. DETECCIÓN DE LÍNEAS VIUDAS Y HUÉRFANAS ---")
widow_lines = []
short_top_lines = []
for p in page_data:
    if p['is_interior'] and p['body_lines']:
        first_line = p['body_lines'][0]['text']
        words = first_line.split()
        if len(words) == 1 and not first_line.isdigit() and not first_line.endswith(':'):
            widow_lines.append({
                'page': p['pno'],
                'chapter': p['chapter'],
                'text': first_line
            })

print(f"Líneas viudas de 1 sola palabra al inicio de página: {len(widow_lines)}")
for w in widow_lines:
    print(f"  [VIUDA] Pág {w['page']:02d}: '{w['text']}'")

# 5. DETECCIÓN DE LISTAS QUE CRUZAN PÁGINA
print("\n--- 4. DETECCIÓN DE LISTAS QUE CRUZAN PÁGINA ---")
list_page_splits = []
for idx in range(len(page_data) - 1):
    p_curr = page_data[idx]
    p_next = page_data[idx + 1]
    if p_curr['chapter'] == p_next['chapter'] and (p_curr['is_first'] or p_curr['is_interior']) and p_next['is_interior']:
        curr_lines = [bl['text'] for bl in p_curr['body_lines']]
        next_lines = [bl['text'] for bl in p_next['body_lines']]
        if curr_lines and next_lines:
            last_c = curr_lines[-1]
            first_n = next_lines[0]
            # Check if last line looks like a list item or incomplete sentence
            is_list_item_c = bool(re.match(r'^[a-z]\)\s+', last_c) or re.match(r'^[ivxlcdm]+\.\s+', last_c))
            is_list_item_n = bool(re.match(r'^[a-z]\)\s+', first_n) or re.match(r'^[ivxlcdm]+\.\s+', first_n))
            if is_list_item_c and not last_c.endswith('.'):
                list_page_splits.append({
                    'from_page': p_curr['pno'],
                    'to_page': p_next['pno'],
                    'chapter': p_curr['chapter'],
                    'type': 'Ítem de lista partido a la mitad',
                    'end_text': last_c[:50],
                    'start_text': first_n[:50]
                })
            elif is_list_item_c and is_list_item_n:
                list_page_splits.append({
                    'from_page': p_curr['pno'],
                    'to_page': p_next['pno'],
                    'chapter': p_curr['chapter'],
                    'type': 'Transición secuencial entre ítems de lista',
                    'end_text': last_c[:50],
                    'start_text': first_n[:50]
                })

print(f"Listas que cruzan cambio de página detectadas: {len(list_page_splits)}")
for ls in list_page_splits:
    print(f"  [LISTA EN SALTO] Pág {ls['from_page']:02d} -> Pág {ls['to_page']:02d} (Cap {ls['chapter']:02d}): {ls['type']} ('{ls['end_text']}...' -> '{ls['start_text']}...')")

# 6. DETECCIÓN DE PÁGINAS CON BAJA DENSIDAD (< 10 líneas de cuerpo)
print("\n--- 5. DETECCIÓN DE PÁGINAS CON BAJA DENSIDAD ---")
low_density_pages = []
for p in page_data:
    if p['is_interior'] or p['is_first']:
        # Terminal page check
        is_terminal = any(p['pno'] == end for _, _, _, end in chapter_ranges)
        num_body = len(p['body_lines'])
        if num_body <= 10:
            low_density_pages.append({
                'page': p['pno'],
                'chapter': p['chapter'],
                'lines_count': num_body,
                'is_terminal': is_terminal,
                'is_first': p['is_first'],
                'first_line': p['body_lines'][0]['text'][:50] if p['body_lines'] else "VACÍO",
                'last_line': p['body_lines'][-1]['text'][:50] if p['body_lines'] else "VACÍO"
            })

print(f"Páginas con <= 10 líneas de cuerpo: {len(low_density_pages)}")
for ldp in low_density_pages:
    term_str = "TERMINAL DE CAPÍTULO" if ldp['is_terminal'] else "INTERMEDIA"
    print(f"  Pág {ldp['page']:02d} (Cap {ldp['chapter']:02d}) [{term_str}]: {ldp['lines_count']} líneas de texto.")

# 7. AUDITORÍA DE DESBORDAMIENTOS Y COLISIONES
print("\n--- 6. AUDITORÍA DE DESBORDAMIENTOS Y COLISIONES ---")
overflows = []
collisions = []
for p in page_data:
    pno = p['pno']
    is_recto = p['is_recto']
    # Safe bounds:
    # Recto: x in [58.74, 373.30], y in [71.01, 547.00] for body
    # Verso: x in [22.70, 337.26], y in [71.01, 547.00] for body
    safe_x_min = 55.0 if is_recto else 20.0
    safe_x_max = 375.0 if is_recto else 340.0
    safe_y_min = 69.0
    safe_y_max = 550.0
    
    for bl in p['body_lines']:
        b = bl['bbox']
        # Check y overflow (below bottom margin)
        if b[3] > safe_y_max:
            overflows.append({
                'page': pno,
                'chapter': p['chapter'],
                'type': 'Desbordamiento inferior',
                'bbox': b,
                'text': bl['text'][:50]
            })
        # Check y collision with header
        if b[1] < safe_y_min and not p['is_first']:
            collisions.append({
                'page': pno,
                'chapter': p['chapter'],
                'type': 'Colisión con running header',
                'bbox': b,
                'text': bl['text'][:50]
            })

print(f"Desbordamientos fuera del área segura detectados: {len(overflows)}")
print(f"Colisiones de texto detectadas: {len(collisions)}")

# 8. AUDITORÍA DE BLANCAS CEREMONIALES
print("\n--- 7. INVENTARIO COMPLETO DE PÁGINAS BLANCAS CEREMONIALES ---")
blank_pages = [p for p in page_data if p['is_blank']]
print(f"Total páginas blancas: {len(blank_pages)}")
for bp in blank_pages:
    pno = bp['pno']
    side = "RECTO" if bp['is_recto'] else "VERSO"
    reason = "Desconocida"
    if pno == 1:
        reason = "Página de cortesía inicial (Recto)"
    elif pno in [2, 10, 42, 62, 88, 96, 104, 112, 120]:
        reason = f"Fondo ceremonial Verso previo a Chapter-Opening {bp['chapter']:02d}"
    elif pno in [4, 12, 44, 64, 90, 98, 106, 114, 122]:
        reason = f"Fondo ceremonial Verso previo a Chapter-First-Page {bp['chapter']:02d}"
    elif pno in [9, 41, 95, 103]:
        reason = f"Página de transición de paridad Recto tras cierre en Verso de Cap {bp['chapter']-1:02d}"
    print(f"  Pág {pno:02d} ({side}): {reason}")

# 9. VERIFICACIÓN DE FOLIACIÓN Y LÍNEA BASE
print("\n--- 8. AUDITORÍA DE FOLIACIÓN Y LÍNEA BASE ---")
all_folios = []
for p in page_data:
    for f in p['folios']:
        all_folios.append((p['pno'], f['text'], f['baseline'], f['bbox']))

print(f"Total folios detectados: {len(all_folios)} (en 94 páginas de contenido)")
folio_baselines = [f[2] for f in all_folios]
min_base = min(folio_baselines)
max_base = max(folio_baselines)
print(f"Línea base mínima: {min_base:.4f} pt, máxima: {max_base:.4f} pt | Discrepancia: {max_base - min_base:.6f} pt")
assert abs(max_base - min_base) < 0.001, "ERROR CRÍTICO: Discrepancia en baseline de folios!"
print(f"[OK] Alineación de folios 100% matemática exacta en y = {min_base:.3f} pt")

# 10. RUNNING HEADER VALIDATION
print("\n--- 9. AUDITORÍA DE RUNNING HEADERS ---")
rh_found = {}
for p in page_data:
    txt = p['raw_text']
    norm = re.sub(r'(\w)\s+(\w)', r'\1\2', txt)
    norm = re.sub(r'(\w)\s+(\w)', r'\1\2', norm)
    m = re.search(r'CAP[ÍI]TULO\s*([0-9]{2})', norm)
    if m:
        rh_found[p['pno']] = int(m.group(1))

print(f"Páginas con running header activo: {len(rh_found)} (Esperado: 85)")
# Check consistency
rh_errors = []
for pno, ch_val in rh_found.items():
    expected_ch = get_chapter_for_page(pno)
    if ch_val != expected_ch:
        rh_errors.append((pno, ch_val, expected_ch))

print(f"Errores de número de capítulo en running headers: {len(rh_errors)}")
assert len(rh_errors) == 0, f"ERROR CRÍTICO: Running headers inconsistentes: {rh_errors}"
print("[OK] Todos los running headers coinciden exactamente con el capítulo activo.")
