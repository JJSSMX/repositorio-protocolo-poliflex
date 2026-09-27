#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
INVENTARIO ESTRUCTURAL Y AUDITORÍA FORENSE: FASE 4.0
Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

Analiza exhaustivamente:
  - 00_introduccion.md
  - 10_anexos_formatos_operativos.md
  - 11_reglamento_asamblea_familia.md
  - 12_reglamento_consejo_familia.md
  - 13_reglamento_comite_honor_familiar.md

Genera:
  - datos/fase_4_0_inventario.json
"""

import os
import sys
import re
import json
import hashlib
import yaml

if sys.stdout.encoding.lower() != 'utf-8':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except Exception:
        pass

from pathlib import Path
REPO_DIR = str(Path(__file__).resolve().parent.parent)
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
DATOS_DIR = os.path.join(REPO_DIR, 'datos')
os.makedirs(DATOS_DIR, exist_ok=True)

FILES = [
    '00_introduccion.md',
    '10_anexos_formatos_operativos.md',
    '11_reglamento_asamblea_familia.md',
    '12_reglamento_consejo_familia.md',
    '13_reglamento_comite_honor_familiar.md'
]

INITIAL_HASHES = {
    '00_introduccion.md': 'DEEECA7863249DB1348BEF6138E0DAEDA35B5120658459D0362309E543FECAD8',
    '10_anexos_formatos_operativos.md': '588A64539A62B89BA25D31E54E504FB7A5EDF9698AC085B6250CC3F91B774826',
    '11_reglamento_asamblea_familia.md': '52034B382BA0F3137016F1F8BE8F20AB2C76D134E9DEEC1160BE55ABFAD724D3',
    '12_reglamento_consejo_familia.md': 'FDE5F0D62F99B198D4C238E36225AE62770C4C9255371715B0292DA12CB0EA18',
    '13_reglamento_comite_honor_familiar.md': '8662411CBAA2AAD718F4F48D0CE6083250D6935349530843966DC2A00140C23B'
}

def analyze_file(fname):
    fpath = os.path.join(CAP_DIR, fname)
    with open(fpath, 'rb') as f:
        raw_bytes = f.read()
    sha256 = hashlib.sha256(raw_bytes).hexdigest().upper()
    assert sha256 == INITIAL_HASHES[fname], f"Hash mismatch in {fname}!"
    
    text = raw_bytes.decode('utf-8')
    lines = text.splitlines()
    
    # Split frontmatter
    fm = {}
    body_lines = []
    if text.startswith('---'):
        parts = text.split('---', 2)
        if len(parts) >= 3:
            try:
                fm = yaml.safe_load(parts[1]) or {}
            except Exception:
                pass
            body_lines = parts[2].splitlines()
    else:
        body_lines = lines

    # Detailed counts
    char_count = len(text)
    word_count = len(text.split())
    
    # Headings
    h1_list = []
    h2_list = []
    h3_list = []
    h4_list = []
    
    # Tables
    table_blocks = []
    current_table = []
    
    # Fillable fields (underscores ________)
    fillable_fields = []
    
    # Checkboxes (☐)
    checkbox_count = text.count('☐')
    
    # Lists
    alpha_items = []
    roman_lower = []
    roman_upper = []
    decimal_items = []
    bullet_items = []
    
    # Articles & solemn clauses
    articles = []
    solemn_clauses = []
    transitorios = []
    
    # Signature blocks
    signature_blocks = []
    
    # Paragraphs
    paragraphs = []
    curr_p = []
    
    in_table = False
    
    for lno, line in enumerate(body_lines, 1):
        sline = line.strip()
        if not sline:
            if curr_p:
                paragraphs.append("\n".join(curr_p))
                curr_p = []
            if in_table and current_table:
                table_blocks.append(current_table)
                current_table = []
                in_table = False
            continue
            
        if sline.startswith('|') and sline.endswith('|'):
            if curr_p:
                paragraphs.append("\n".join(curr_p))
                curr_p = []
            in_table = True
            current_table.append((lno, sline))
            continue
        elif in_table:
            table_blocks.append(current_table)
            current_table = []
            in_table = False
            
        if sline.startswith('# '):
            h1_list.append((lno, sline[2:].strip()))
        elif sline.startswith('## '):
            h2_list.append((lno, sline[3:].strip()))
        elif sline.startswith('### '):
            h3_list.append((lno, sline[4:].strip()))
        elif sline.startswith('#### '):
            h4_list.append((lno, sline[5:].strip()))
        elif sline.startswith('**TRANSITORIO ÚNICO**') or sline.startswith('TRANSITORIO ÚNICO'):
            transitorios.append((lno, sline))
            curr_p.append(sline)
        else:
            # Check lists
            clean_sline = re.sub(r'^\*\*(.*?)\*\*$', r'\1', sline)
            if re.match(r'^[a-z]\)\s+', clean_sline):
                alpha_items.append((lno, sline))
            elif re.match(r'^[ivxlcdm]+\.\s+', clean_sline):
                roman_lower.append((lno, sline))
            elif re.match(r'^[IVXLCDM]+\.\s+', clean_sline):
                roman_upper.append((lno, sline))
            elif re.match(r'^\d+\.\s+', clean_sline):
                decimal_items.append((lno, sline))
            elif clean_sline.startswith('- ') or clean_sline.startswith('* '):
                bullet_items.append((lno, sline))
            else:
                curr_p.append(sline)
                
        # Check underscores for fillable fields
        if '_____' in sline:
            fillable_fields.append((lno, sline))
            
        # Check solemn clauses
        if re.match(r'###\s+(PRIMERO|SEGUNDO|TERCERO|CUARTO|QUINTO|SEXTO|SÉPTIMO|OCTAVO|NOVENO|DÉCIMO)\..*', sline):
            solemn_clauses.append((lno, sline))
            
        # Check articles
        if re.match(r'###\s+Artículo\s+\d+\..*', sline):
            articles.append((lno, sline))
            
        # Signature cues
        if 'Firma' in sline or 'Atentamente' in sline or 'C. ________' in sline:
            signature_blocks.append((lno, sline))
            
    if curr_p:
        paragraphs.append("\n".join(curr_p))
    if in_table and current_table:
        table_blocks.append(current_table)

    return {
        'file': fname,
        'sha256': sha256,
        'bytes': len(raw_bytes),
        'char_count': char_count,
        'word_count': word_count,
        'lines_total': len(lines),
        'frontmatter': fm,
        'headings': {
            'h1': h1_list,
            'h2': h2_list,
            'h3': h3_list,
            'h4': h4_list
        },
        'paragraphs_count': len(paragraphs),
        'tables': {
            'count': len(table_blocks),
            'blocks': [{'rows': len(tb), 'start_line': tb[0][0], 'headers': tb[0][1]} for tb in table_blocks]
        },
        'lists': {
            'alpha_count': len(alpha_items),
            'roman_lower_count': len(roman_lower),
            'roman_upper_count': len(roman_upper),
            'decimal_count': len(decimal_items),
            'bullet_count': len(bullet_items),
            'alpha_items': alpha_items,
            'roman_lower_items': roman_lower,
            'roman_upper_items': roman_upper,
            'decimal_items': decimal_items
        },
        'fillable_fields_count': len(fillable_fields),
        'checkbox_count': checkbox_count,
        'articles': articles,
        'solemn_clauses': solemn_clauses,
        'transitorios': transitorios,
        'signature_cues': signature_blocks
    }

results = {f: analyze_file(f) for f in FILES}

# Save structured inventory JSON
out_json = os.path.join(DATOS_DIR, 'fase_4_0_inventario.json')
with open(out_json, 'w', encoding='utf-8') as f:
    json.dump(results, f, indent=2, ensure_ascii=False)

print(f"[OK] Inventario estructurado guardado en: {out_json}")
for fname, d in results.items():
    print(f"\n--- {fname} ---")
    print(f"  SHA-256: {d['sha256']}")
    print(f"  Palabras: {d['word_count']}, Caracteres: {d['char_count']}")
    print(f"  H1: {len(d['headings']['h1'])}, H2: {len(d['headings']['h2'])}, H3: {len(d['headings']['h3'])}, H4: {len(d['headings']['h4'])}")
    print(f"  Artículos: {len(d['articles'])}, Cláusulas Solemnes: {len(d['solemn_clauses'])}, Tablas: {d['tables']['count']}")
    print(f"  Campos subrayados (fillable): {d['fillable_fields_count']}, Checkboxes (☐): {d['checkbox_count']}")
