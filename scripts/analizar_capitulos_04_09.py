import os
import hashlib
import yaml
import re

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')

chapters = [f'{i:02d}' for i in range(1, 10)]
files = [f for f in sorted(os.listdir(CAP_DIR)) if any(f.startswith(c) for c in chapters)]

print(f"Total capítulos a auditar: {len(files)}")
print("="*80)

initial_hashes = {}

for f in files:
    path = os.path.join(CAP_DIR, f)
    with open(path, 'rb') as fp:
        h = hashlib.sha256(fp.read()).hexdigest().upper()
    initial_hashes[f] = h
    
    with open(path, 'r', encoding='utf-8') as fp:
        txt = fp.read()
    fm = {}
    if txt.startswith('---'):
        parts = txt.split('---', 2)
        fm = yaml.safe_load(parts[1])
        body = parts[2]
    else:
        body = txt
    
    # Check for artifacts
    pct_matches = re.findall(r'%[0-9]+\.', body)
    h2 = len(re.findall(r'^## ', body, re.M))
    h3 = len(re.findall(r'^### ', body, re.M))
    h4 = len(re.findall(r'^#### ', body, re.M))
    
    # Check for lists
    alphas = len(re.findall(r'^[a-z]\)\s+', body, re.M))
    romans = len(re.findall(r'^[ivxlcdm]+\.\s+', body, re.M))
    solemn = len(re.findall(r'^(?:PRIMERO|SEGUNDO|TERCERO|CUARTO|QUINTO|SEXTO|SÉPTIMO|SEPTIMO|OCTAVO|NOVENO|DÉCIMO|DECIMO)\.\s*', body, re.M))
    
    title = fm.get('title', '')
    opening_title = fm.get('opening_title', [])
    ch_num = fm.get('chapter_number', '')
    
    print(f"Capítulo {ch_num} ({f}):")
    print(f"  SHA-256: {h}")
    print(f"  Título: {title}")
    print(f"  Opening Title ({len(opening_title)} líneas): {opening_title}")
    print(f"  Headings: H2={h2}, H3={h3}, H4={h4} | Total={h2+h3+h4}")
    print(f"  Listas: Alpha={alphas}, Roman={romans}, Solemn={solemn}, % Markers={len(pct_matches)}")
    if pct_matches:
        print(f"  [AVISO] Artefactos % encontrados: {set(pct_matches)}")
    print("-"*80)
