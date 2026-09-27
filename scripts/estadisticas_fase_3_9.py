import os
import pymupdf
import re
import yaml
import hashlib

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
DIST_DIR = os.path.join(REPO_DIR, 'dist')

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

print(f"Total páginas doc maestro: {len(doc)}")

# Gather stats per chapter
stats = []

# Transitions:
# Cap 1: Opening P.3, First P.5, Ends P.8
# Cap 2: Opening P.11, First P.13, Ends P.40
# Cap 3: Opening P.43, First P.45, Ends P.61
# Cap 4: Opening P.63, First P.65, Ends P.87
# Cap 5: Opening P.89, First P.91, Ends P.94
# Cap 6: Opening P.97, First P.99, Ends P.102
# Cap 7: Opening P.105, First P.107, Ends P.111
# Cap 8: Opening P.113, First P.115, Ends P.119
# Cap 9: Opening P.121, First P.123, Ends P.126

ranges = [
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

for ch_num, op_p, fp_p, end_p in ranges:
    cfile = all_chapters[ch_num - 1]
    cpath = os.path.join(CAP_DIR, cfile)
    with open(cpath, 'rb') as f:
        h = hashlib.sha256(f.read()).hexdigest().upper()
    with open(cpath, 'r', encoding='utf-8') as f:
        txt = f.read()
    if txt.startswith('---'):
        parts = txt.split('---', 2)
        fm = yaml.safe_load(parts[1])
        body = parts[2]
    else:
        fm = {}
        body = txt

    h2 = len(re.findall(r'^## ', body, re.M))
    h3 = len(re.findall(r'^### ', body, re.M))
    h4 = len(re.findall(r'^#### ', body, re.M))
    total_headings = h2 + h3 + h4
    max_depth = "H4 (sub-subsección)" if h4 > 0 else ("H3 (subsección)" if h3 > 0 else "H2 (sección)")
    
    alphas = len(re.findall(r'^[a-z]\)\s+', body, re.M))
    romans = len(re.findall(r'^[ivxlcdm]+\.\s+', body, re.M)) + len(re.findall(r'^%(\d+)\.\s+', body, re.M))
    
    content_pages = end_p - fp_p + 1
    interior_pages = content_pages - 1 # excluding first page
    
    # Check blank before opening
    blank_before_op = op_p - 1
    # Check blank before first
    blank_before_fp = fp_p - 1
    # First interior
    first_interior = fp_p + 1 if interior_pages > 0 else None
    
    stats.append({
        'chapter': ch_num,
        'file': cfile,
        'hash': h,
        'title': fm.get('title'),
        'opening_page': op_p,
        'blank_before_opening': blank_before_op,
        'first_page': fp_p,
        'blank_before_first': blank_before_fp,
        'first_interior': first_interior,
        'last_page': end_p,
        'content_pages': content_pages,
        'interior_pages': interior_pages,
        'headings': total_headings,
        'h2': h2, 'h3': h3, 'h4': h4,
        'max_depth': max_depth,
        'alphas': alphas,
        'romans': romans
    })

print("ESTADÍSTICAS POR CAPÍTULO:")
for s in stats:
    print(f"Cap {s['chapter']:02d}: Opening={s['opening_page']} (Blanca previa={s['blank_before_opening']}), First={s['first_page']} (Blanca previa={s['blank_before_first']}), 1st Interior={s['first_interior']}, Last={s['last_page']} | Interior={s['interior_pages']} págs, Total Content={s['content_pages']} págs | Headings={s['headings']} (H2={s['h2']}, H3={s['h3']}, H4={s['h4']}, Max={s['max_depth']}) | Listas: Alpha={s['alphas']}, Roman={s['romans']}")

total_headings_sum = sum(s['headings'] for s in stats)
total_content_pages = sum(s['content_pages'] for s in stats)
print(f"\nSuma total headings: {total_headings_sum}")
print(f"Suma total páginas de contenido (incluyendo first-pages): {total_content_pages}")
print(f"Total aperturas: {len(stats)}")
print(f"Total páginas blancas ceremoniales: {len(doc) - total_content_pages - len(stats)}")
