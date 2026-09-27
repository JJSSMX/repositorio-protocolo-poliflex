import os
import re
import yaml

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')

chapters = [
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

def clean_inline_text(text):
    text = text.replace('$', '\\$').replace('@', '\\@')
    text = text.replace('☐', '#sym.square ')
    text = re.sub(r'\*\*\*(.*?)\*\*\*', r'#strong[#emph[\1]]', text)
    text = re.sub(r'\*\*(.*?)\*\*', r'#strong[\1]', text)
    text = re.sub(r'(?<!\*)\*(?!\*)(.*?)(?<!\*)\*(?!\*)', r'#emph[\1]', text)
    return text.strip()

for cfile in chapters:
    cpath = os.path.join(CAP_DIR, cfile)
    with open(cpath, 'r', encoding='utf-8') as f:
        text = f.read()
    if text.startswith('---'):
        parts = text.split('---', 2)
        fm = yaml.safe_load(parts[1])
        body = parts[2]
    else:
        fm = {}
        body = text

    lines = body.split('\n')
    ch_num = fm.get('chapter_number')
    print(f"\n=================== CAPÍTULO {ch_num}: {cfile} ===================")
    print(f"Título: {fm.get('title')}")
    print(f"Opening lines ({len(fm.get('opening_title', []))}): {fm.get('opening_title')}")
    
    unhandled = []
    headings = []
    alphas = []
    romans = []
    
    for idx, l in enumerate(lines):
        line = l.strip()
        if not line:
            continue
        if line.startswith('# '):
            continue
        elif line.startswith('#### '):
            headings.append(('H4', line))
        elif line.startswith('### '):
            headings.append(('H3', line))
        elif line.startswith('## '):
            headings.append(('H2', line))
        elif re.match(r'^[a-z]\)\s+', line):
            alphas.append(line[:10])
        elif re.match(r'^%(\d+)\.\s+(.*)', line):
            romans.append(line[:10])
        elif re.match(r'^[ivxlcdm]+\.\s+', line):
            romans.append(line[:10])
        else:
            # check if it looks like a list or header that we might have missed
            if re.match(r'^[0-9]+\.\s+', line):
                unhandled.append((idx+1, 'Numbered list?', line[:50]))
            elif re.match(r'^[A-Z]\)\s+', line):
                unhandled.append((idx+1, 'Uppercase alpha?', line[:50]))
            elif re.match(r'^[IVXLCDM]+\.\s+', line):
                unhandled.append((idx+1, 'Uppercase roman?', line[:50]))
            elif line.startswith('**') and line.endswith('**') and len(line) < 60:
                unhandled.append((idx+1, 'Bold line?', line[:50]))

    print(f"Total Headings: {len(headings)} (H2={sum(1 for h in headings if h[0]=='H2')}, H3={sum(1 for h in headings if h[0]=='H3')}, H4={sum(1 for h in headings if h[0]=='H4')})")
    print(f"Total Alphas: {len(alphas)}, Romans: {len(romans)}")
    if unhandled:
        print(f"Posibles elementos no estándar ({len(unhandled)}):")
        for u in unhandled[:10]:
            print(f"  Línea {u[0]}: {u[1]} -> {u[2]}")
    else:
        print("Estructura 100% estándar reconocida por el parser.")
