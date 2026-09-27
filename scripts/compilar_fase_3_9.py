"""
COMPILADOR MAESTRO Y AUDITOR FORENSE: FASE 3.9
Cierre del Sistema Interior y Expansión a Capítulos 04–09
Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

Genera:
1. dist/TEST_CAPITULOS_04_09_SISTEMA_LOCKED.pdf
2. dist/TEST_CAPITULOS_04_09_SISTEMA_LOCKED_SPREADS.pdf
3. dist/TEST_PROTOCOLO_CAPITULOS_01_09.pdf
4. dist/TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf
5. dist/TEST_PROTOCOLO_CAPITULOS_01_09_CONTACT_SHEET.pdf
"""

import os
import sys
import re
import hashlib
import yaml
import subprocess
import shutil
import pymupdf

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
CONFIG_FILE = os.path.join(REPO_DIR, 'config', 'editorial_config.yaml')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
SCRATCH_DIR = os.path.join(REPO_DIR, 'scratch')
REPORTES_DIR = os.path.join(REPO_DIR, 'reportes')

os.makedirs(DIST_DIR, exist_ok=True)
TESTS_DIR_EXISTS = os.path.exists(TESTS_DIR)
os.makedirs(TESTS_DIR, exist_ok=True)
os.makedirs(SCRATCH_DIR, exist_ok=True)
os.makedirs(REPORTES_DIR, exist_ok=True)

DELTA_6MM_PT = 6.0 * (72.0 / 25.4) # 17.007874 pt ≈ 17.01 pt

CANONICAL_CHAPTERS = [
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

def compute_sha256(filepath):
    h = hashlib.sha256()
    with open(filepath, 'rb') as f:
        while chunk := f.read(65536):
            h.update(chunk)
    return h.hexdigest().upper()

def to_roman(n):
    val = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    syb = ['m', 'cm', 'd', 'cd', 'c', 'xc', 'l', 'xl', 'x', 'ix', 'v', 'iv', 'i']
    roman_num = ''
    i = 0
    while n > 0:
        for _ in range(n // val[i]):
            roman_num += syb[i]
            n -= val[i]
        i += 1
    return roman_num

def extract_frontmatter_and_content(md_path):
    with open(md_path, 'r', encoding='utf-8') as f:
        text = f.read()
    if text.startswith('---'):
        parts = text.split('---', 2)
        fm = yaml.safe_load(parts[1])
        body = parts[2]
    else:
        fm = {}
        body = text
    return fm, body

def clean_inline_text(text):
    text = text.replace('$', '\\$').replace('@', '\\@')
    text = text.replace('☐', '#sym.square ')
    text = re.sub(r'\*\*\*(.*?)\*\*\*', r'#strong[#emph[\1]]', text)
    text = re.sub(r'\*\*(.*?)\*\*', r'#strong[\1]', text)
    text = re.sub(r'(?<!\*)\*(?!\*)(.*?)(?<!\*)\*(?!\*)', r'#emph[\1]', text)
    return text.strip()

def build_master_typst(chapter_files, transition_blanks, doc_title="TEST PROTOCOLO"):
    typ = []
    typ.append('// ==============================================================================')
    typ.append(f'// {doc_title} — SISTEMA EDITORIAL LOCKED')
    typ.append('// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)')
    typ.append('// Generado automáticamente por scripts/compilar_fase_3_9.py')
    typ.append('// ==============================================================================')
    typ.append('')
    typ.append('#import "/templates/typst/componentes.typ": *')
    typ.append('')
    typ.append('#let cfg = yaml("/config/editorial_config.yaml")')
    typ.append('')
    typ.append('// Marcadores de página y contenido')
    typ.append('#show par: it => [')
    typ.append('  #it')
    typ.append('  #metadata("par") <content-marker>')
    typ.append(']')
    typ.append('')
    typ.append('// Componente reutilizable: Página blanca ceremonial (0 elementos, cuenta para paridad)')
    typ.append('#let ceremonial-blank-page() = [')
    typ.append('  #page(margin: 0pt, header: none, footer: none)[')
    typ.append('    #metadata("ceremonial-blank") <blank-page-marker>')
    typ.append('  ]')
    typ.append(']')
    typ.append('')
    typ.append('// Configuración de página maestra con paridad dinámica y retícula vertical +6 mm consolidada')
    typ.append('#set page(')
    typ.append('  width: 396pt,')
    typ.append('  height: 612pt,')
    typ.append('  margin: (')
    typ.append('    inside: 58.74pt,   // Lomo: 58.74pt (izq en impar, der en par)')
    typ.append('    outside: 22.70pt,  // Corte: 22.70pt (der en impar, izq en par)')
    typ.append(f'    top: {54.00 + DELTA_6MM_PT:.4f}pt,      // Consolidado +6 mm (+17.0079 pt = 71.0079 pt)')
    typ.append('    bottom: 65.00pt')
    typ.append('  ),')
    typ.append('  header: context [')
    typ.append('    #let p = counter(page).get().first()')
    typ.append('    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)')
    typ.append('')
    typ.append('    // En apertura, primera página, páginas blancas o páginas sin contenido: SIN running header')
    typ.append('    #if not is_opening and not is_first and not is_blank and has_content [')
    typ.append('      #let ch_meta = query(selector(<chapter-marker>)).filter(m => m.location().page() <= p)')
    typ.append('      #let ch_num = if ch_meta.len() > 0 { ch_meta.last().value } else { 1 }')
    typ.append('      #let ch_str = if ch_num < 10 { "0" + str(ch_num) } else { str(ch_num) }')
    typ.append('      #let is_recto = calc.odd(p)')
    typ.append('')
    typ.append('      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")')
    typ.append('      #let rh_text(t, col) = text(font: neuzeit, size: 5.5pt, fill: rgb(col), tracking: 0.200em)[#t]')
    typ.append('      #let inst_unit = [#rh_text("PROTOCOLO FAMILIAR", "#6c6b67")#h(8pt)#rh_text("VERSION 1.0", "#f15d22")]')
    typ.append('      #let ch_unit = [#rh_text("CAPÍTULO " + ch_str, "#6c6b67")]')
    typ.append('      #let iso = interior-isotype(width: 7.1186pt, height: 7.0000pt, opacity: 50%)')
    typ.append('')
    typ.append('      #place(top + left, dx: 0pt, dy: 25.5pt)[')
    typ.append('        #if is_recto [')
    typ.append('          #grid(')
    typ.append('            columns: (1fr, 1fr),')
    typ.append('            align: (left + horizon, right + horizon),')
    typ.append('            inst_unit,')
    typ.append('            [#ch_unit#h(5pt)#box(baseline: 15%)[#iso]]')
    typ.append('          )')
    typ.append('        ] else [')
    typ.append('          #grid(')
    typ.append('            columns: (1fr, 1fr),')
    typ.append('            align: (left + horizon, right + horizon),')
    typ.append('            [#box(baseline: 15%)[#iso]#h(5pt)#ch_unit],')
    typ.append('            inst_unit')
    typ.append('          )')
    typ.append('        ]')
    typ.append('      ]')
    typ.append('    ]')
    typ.append('  ],')
    typ.append('  footer: context [')
    typ.append('    #let p = counter(page).get().first()')
    typ.append('    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)')
    typ.append('')
    typ.append('    #if not is_opening and not is_blank and has_content [')
    typ.append('      #let is_recto = calc.odd(p)')
    typ.append('      #let minion = ("Minion Pro", "Georgia")')
    typ.append('      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")')
    typ.append('      #let p_str = if p < 10 { "0" + str(p) } else { str(p) }')
    typ.append('      #let folio_txt = text(font: minion, size: 8pt, fill: rgb("#f15d22"), weight: "medium")[#p_str]')
    typ.append('')
    typ.append('      #if is_first [')
    typ.append('        // ==============================================================================')
    typ.append('        // FRANJA INFERIOR CHAPTER-FIRST-PAGE CORREGIDA MATEMÁTICAMENTE (FASE 3.8.1 / 3.9)')
    typ.append('        // Compensación exacta: #v(20pt - 5.0535pt) = #v(14.9465pt)')
    typ.append('        // Baseline Folio First Page = 591.708 pt (Idéntico a interior-page = 591.708 pt)')
    typ.append('        // ==============================================================================')
    typ.append('        #v(20pt - 5.0535pt)')
    typ.append('        #let ftr_phrase = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[PROTOCOLO FAMILIAR]')
    typ.append('        #let ftr_ver = text(font: neuzeit, size: 4.8234pt, fill: rgb("#f15e22"), tracking: 0.371em)[VERSION 1.0]')
    typ.append('        #let iso_ftr = interior-isotype(width: 15.5740pt, height: 15.3150pt, opacity: 50%)')
    typ.append('')
    typ.append('        #if is_recto [')
    typ.append('          #grid(')
    typ.append('            columns: (1fr, 1fr),')
    typ.append('            align: (left + horizon, right + horizon),')
    typ.append('            [#box(baseline: 20%)[#iso_ftr]#h(4pt)#ftr_phrase#h(6pt)#ftr_ver],')
    typ.append('            folio_txt')
    typ.append('          )')
    typ.append('        ] else [')
    typ.append('          #grid(')
    typ.append('            columns: (1fr, 1fr),')
    typ.append('            align: (left + horizon, right + horizon),')
    typ.append('            folio_txt,')
    typ.append('            [#ftr_phrase#h(6pt)#ftr_ver#h(4pt)#box(baseline: 20%)[#iso_ftr]]')
    typ.append('          )')
    typ.append('        ]')
    typ.append('      ] else [')
    typ.append('        // Páginas de continuación: SOLO folio en corte exterior (referencia estándar)')
    typ.append('        #v(20pt)')
    typ.append('        #if is_recto [')
    typ.append('          #align(right)[#folio_txt]')
    typ.append('        ] else [')
    typ.append('          #align(left)[#folio_txt]')
    typ.append('        ]')
    typ.append('      ]')
    typ.append('    ]')
    typ.append('  ],')
    typ.append('  background: context [')
    typ.append('    #let p = counter(page).get().first()')
    typ.append('    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)')
    typ.append('')
    typ.append('    #if not is_opening and not is_blank and has_content [')
    typ.append('      #let is_recto = calc.odd(p)')
    typ.append('      #let rule_x = if is_recto { 30.13pt } else { 365.87pt }')
    typ.append('      #place(top + left, dx: rule_x, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + rgb("#f15d22")))')
    typ.append('')
    typ.append('      #if is_first [')
    typ.append('        #interior-arcs(cfg, opacity: 50%)')
    typ.append('      ]')
    typ.append('    ]')
    typ.append('  ]')
    typ.append(')')
    typ.append('')
    typ.append('// Configuración tipográfica calibrada del cuerpo')
    typ.append('#set text(')
    typ.append('  font: ("Neuzeit Grotesk", "Segoe UI"),')
    typ.append('  size: 7.9077pt,')
    typ.append('  fill: rgb("#2e2f31"),')
    typ.append('  tracking: 0em,')
    typ.append('  hyphenate: false')
    typ.append(')')
    typ.append('#set par(')
    typ.append('  leading: 12.72949pt,')
    typ.append('  justify: true,')
    typ.append('  spacing: 12.72949pt,')
    typ.append('  linebreaks: "simple"')
    typ.append(')')
    typ.append('')
    typ.append('// Reglas de numeración y estilos de títulos (H2, H3, H4) con respiración temática +18 pt')
    typ.append('#set heading(numbering: "1.1")')
    typ.append('')
    typ.append('// H2: Sección principal (+18 pt adicional antes de nueva sección)')
    typ.append('#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 18.35pt + 18.00pt, below: 15.42pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[')
    typ.append('    #text(font: minion, size: 10pt, fill: rgb("#f15d22"), stroke: 0.4pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]')
    typ.append('  ]#h(5.5pt)#text(font: minion, size: 10pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('')
    typ.append('// H3: Subsección (+18 pt adicional antes de nueva subsección)')
    typ.append('#show heading.where(level: 3): it => block(width: 100%, breakable: false, sticky: true, above: 14.00pt + 18.00pt, below: 10.00pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[')
    typ.append('    #text(font: minion, size: 9.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]')
    typ.append('  ]#h(5.0pt)#text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('')
    typ.append('// H4: Sub-subsección (+18 pt adicional antes de nueva sub-subsección)')
    typ.append('#show heading.where(level: 4): it => block(width: 100%, breakable: false, sticky: true, above: 10.00pt + 18.00pt, below: 8.00pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[')
    typ.append('    #text(font: minion, size: 9pt, fill: rgb("#f15d22"), stroke: 0.2pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]')
    typ.append('  ]#h(4.5pt)#text(font: minion, size: 9pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('')
    typ.append('// Componentes de listas jurídicas con sangría de bloque exacta y prevención de orfandad')
    typ.append('#let legal-alpha(marker, content) = block(width: 100%, inset: (left: 20pt), breakable: true, below: 12.73pt)[')
    typ.append('  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content')
    typ.append(']')
    typ.append('')
    typ.append('#let legal-roman(marker, content) = block(width: 100%, inset: (left: 40pt), breakable: true, below: 12.73pt)[')
    typ.append('  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content')
    typ.append(']')
    typ.append('')

    # PÁGINA 1: Portadilla / Cortesía inicial (Página 1 Recto en blanco)
    typ.append('// ==============================================================================')
    typ.append('// PÁGINA 1: PÁGINA DE CORTESÍA INICIAL (RECTO)')
    typ.append('// ==============================================================================')
    typ.append('#ceremonial-blank-page()')
    typ.append('')

    for cidx, cfile in enumerate(chapter_files):
        cpath = os.path.join(CAP_DIR, cfile)
        fm, body = extract_frontmatter_and_content(cpath)

        ch_num_raw = fm.get('chapter_number', str(cidx + 1))
        ch_num = int(ch_num_raw)
        ch_str = f"{ch_num:02d}"
        ch_title = fm.get('title', '')
        ch_opening = fm.get('opening_title', [])
        ch_desc = fm.get('description', '')

        typ.append(f'// ==============================================================================')
        typ.append(f'// CAPÍTULO {ch_str}: {ch_title}')
        typ.append(f'// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]')
        typ.append(f'// ==============================================================================')
        typ.append('')

        # 1. BLANCAS CEREMONIALES antes de Chapter Opening
        n_blanks = transition_blanks.get(ch_num, 1)
        typ.append(f'// SPREAD A: Páginas blancas ceremoniales ({n_blanks}) previas a Chapter Opening {ch_str}')
        for b_i in range(n_blanks):
            typ.append('#ceremonial-blank-page()')
        typ.append('')

        # 2. SPREAD A (RECTO): Chapter Opening (Tupla nativa limpia de comillas espurias)
        opening_items = [f'"{clean_inline_text(tl)}"' for tl in ch_opening]
        opening_tuple_str = "(" + ", ".join(opening_items) + ("," if len(opening_items) == 1 else "") + ")"
        typ.append(f'// SPREAD A (RECTO): Portada de capítulo {ch_str}')
        typ.append('#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[')
        typ.append(f'  #metadata("opening-{ch_str}") <chapter-opening-marker>')
        typ.append(f'  #chapter-opening(')
        typ.append(f'    cfg,')
        typ.append(f'    number: "{ch_str}",')
        typ.append(f'    title: [{clean_inline_text(ch_title)}],')
        typ.append(f'    opening_title: {opening_tuple_str},')
        typ.append(f'    description: [{ch_desc}],')
        typ.append(f'    is_recto: false')
        typ.append(f'  )')
        typ.append(']')
        typ.append('')

        # 3. BLANCA CEREMONIAL antes de Chapter First Page (Verso)
        typ.append(f'// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página {ch_str}')
        typ.append('#ceremonial-blank-page()')
        typ.append('')

        # 4. SPREAD B (RECTO): Chapter First Page (Estado A) con retícula calibrada +6 mm
        typ.append(f'// SPREAD B (RECTO): Primera página de contenido Capítulo {ch_str}')
        typ.append(f'#metadata({ch_num}) <chapter-marker>')
        typ.append(f'#metadata("first-{ch_str}") <chapter-first-marker>')
        typ.append(f'#counter(heading).update(({ch_num}, 0, 0, 0))')
        typ.append('')

        title_display_lines = " \\ \n      ".join([clean_inline_text(tl) for tl in ch_opening])
        clm_dy_str = f"{-25.00 - DELTA_6MM_PT:.4f}pt"
        typ.append('#context {')
        typ.append('  let p = counter(page).get().first()')
        typ.append('  let is_recto = calc.odd(p)')
        typ.append('  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")')
        typ.append('  let minion = ("Minion Pro", "Georgia")')
        typ.append('')
        typ.append('  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)')
        typ.append('  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[')
        typ.append('    UN LEGADO \\ QUE TRASCIENDE, \\ UN FUTURO QUE \\ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]')
        typ.append('  ]')
        typ.append('  if is_recto {')
        typ.append(f'    place(top + left, dx: 0pt, dy: {clm_dy_str})[#clm_content]')
        typ.append('  } else {')
        typ.append(f'    place(top + right, dx: 0pt, dy: {clm_dy_str})[#align(right)[#clm_content]]')
        typ.append('  }')
        typ.append('')
        typ.append(f'  // 2. Número display grande "{ch_str}" (desplazado +17.0079pt)')
        typ.append(f'  place(top + left, dx: 0pt, dy: 28pt)[')
        typ.append(f'    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[{ch_str}]')
        typ.append(f'  ]')
        typ.append('')
        typ.append(f'  // 3. Regla horizontal naranja (desplazada +17.0079pt)')
        typ.append(f'  place(top + left, dx: 1.36pt, dy: 74.95pt)[')
        typ.append('    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)')
        typ.append('  ]')
        typ.append('')
        typ.append(f'  // 4. Título completo de capítulo (desplazado +17.0079pt)')
        typ.append(f'  place(top + left, dx: 0pt, dy: 98.30pt)[')
        typ.append('    #block(width: 280pt)[')
        typ.append('      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")')
        typ.append('      #set par(leading: 13.5939pt, justify: false)')
        typ.append(f'      {title_display_lines}')
        typ.append('    ]')
        typ.append('  ]')
        typ.append('}')
        typ.append('')

        num_title_lines = len(ch_opening)
        v_spacing = 177.80 + (num_title_lines - 3) * 24.0053
        typ.append(f'#v({v_spacing:.2f}pt)')
        typ.append('')

        # Procesar líneas de contenido con parser saneado
        lines = body.split('\n')
        idx = 0
        sublist_roman_counter = 0

        while idx < len(lines):
            line = lines[idx].strip()
            if not line:
                idx += 1
                continue

            if line.startswith('# '):
                idx += 1
                continue
            elif line.startswith('#### '):
                sublist_roman_counter = 0
                raw = line[5:].strip()
                clean_title = re.sub(r'^[0-9]+(?:\.[0-9]+)*\.?\s*', '', raw)
                typ.append(f'==== {clean_inline_text(clean_title)}')
            elif line.startswith('### '):
                sublist_roman_counter = 0
                raw = line[4:].strip()
                clean_title = re.sub(r'^[0-9]+(?:\.[0-9]+)*\.?\s*', '', raw)
                typ.append(f'=== {clean_inline_text(clean_title)}')
            elif line.startswith('## '):
                sublist_roman_counter = 0
                raw = line[3:].strip()
                clean_title = re.sub(r'^[0-9]+(?:\.[0-9]+)*\.?\s*', '', raw)
                typ.append(f'== {clean_inline_text(clean_title)}')
            elif re.match(r'^[a-z]\)\s+', line):
                sublist_roman_counter = 0
                m = re.match(r'^([a-z]\))\s+(.*)', line)
                marker = m.group(1)
                content = clean_inline_text(m.group(2))
                typ.append(f'#legal-alpha("{marker}", [{content}])')
            elif re.match(r'^%(\d+)\.\s+(.*)', line):
                m = re.match(r'^%(\d+)\.\s+(.*)', line)
                lvl = int(m.group(1))
                sublist_roman_counter += 1
                roman_marker = f"{to_roman(sublist_roman_counter)}."
                content = clean_inline_text(m.group(2))
                typ.append(f'#legal-roman("{roman_marker}", [{content}])')
            elif re.match(r'^[ivxlcdm]+\.\s+', line):
                m = re.match(r'^([ivxlcdm]+\.)\s+(.*)', line)
                marker = m.group(1)
                content = clean_inline_text(m.group(2))
                typ.append(f'#legal-roman("{marker}", [{content}])')
            else:
                sublist_roman_counter = 0
                p_text = clean_inline_text(line)
                typ.append(f'{p_text}\n')

            idx += 1

        typ.append('')

    return "\n".join(typ)

def generate_spreads_file(master_pdf_path, output_typ_path, output_pdf_path, num_pages):
    print(f"[INFO] Generando pliegos (Spreads) para {output_pdf_path} ({num_pages} páginas)...")
    # master_pdf path relative to repo or absolute in typst style
    rel_pdf = "/" + os.path.relpath(master_pdf_path, REPO_DIR).replace('\\', '/')
    
    spreads_typ = [
        '// ==============================================================================',
        '// SPREADS: Dobles páginas enfrentadas (Verso | Recto) a tamaño 792 × 612 pt',
        '// ==============================================================================',
        '',
        '#set page(width: 792pt, height: 612pt, margin: 0pt)',
        '',
        f'#let master_pdf = "{rel_pdf}"',
        '',
        '#let render-spread(verso-p, recto-p) = [',
        '  #grid(',
        '    columns: (396pt, 396pt),',
        '    rows: (612pt),',
        '    gutter: 0pt,',
        '    if verso-p != none {',
        '      image(master_pdf, page: verso-p, width: 396pt, height: 612pt)',
        '    } else {',
        '      rect(width: 396pt, height: 612pt, fill: rgb("#ffffff"))[]',
        '    },',
        '    if recto-p != none {',
        '      image(master_pdf, page: recto-p, width: 396pt, height: 612pt)',
        '    } else {',
        '      rect(width: 396pt, height: 612pt, fill: rgb("#ffffff"))[]',
        '    }',
        '  )',
        ']',
        ''
    ]

    # Pliego 1: Cortesía P.1 solo en Recto (Verso es tapa/blanco)
    spreads_typ.append('// Pliego 01: [VACÍO | P.01 Cortesía Recto]')
    spreads_typ.append('#render-spread(none, 1)')
    spreads_typ.append('')

    # Pliegos enfrentados: P.2|P.3, P.4|P.5, ..., P.(N-1)|P.N
    for p in range(2, num_pages + 1, 2):
        verso = p
        recto = p + 1 if p + 1 <= num_pages else None
        spread_idx = p // 2 + 1
        recto_str = f"P.{recto:02d}" if recto else "VACÍO"
        spreads_typ.append(f'// Pliego {spread_idx:02d}: [P.{verso:02d} Verso | {recto_str} Recto]')
        if recto:
            spreads_typ.append(f'#render-spread({verso}, {recto})')
        else:
            spreads_typ.append(f'#render-spread({verso}, none)')
        spreads_typ.append('')

    with open(output_typ_path, 'w', encoding='utf-8') as f:
        f.write("\n".join(spreads_typ))

    typst_path = shutil.which("typst") or "typst"
    cmd = [
        typst_path,
        "compile",
        "--root", REPO_DIR,
        "--font-path", FONTS_DIR,
        output_typ_path,
        output_pdf_path
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(output_pdf_path)
        print(f"[ÉXITO] Spreads PDF generado: {output_pdf_path} ({len(doc)} pliegos)")
        return len(doc)
    else:
        print(f"[ERROR] Generación de Spreads falló:\n{res.stderr}")
        return None

def generate_contact_sheet(master_pdf_path, output_typ_path, output_pdf_path, num_pages):
    print(f"[INFO] Generando Contact Sheet para {output_pdf_path} ({num_pages} páginas)...")
    rel_pdf = "/" + os.path.relpath(master_pdf_path, REPO_DIR).replace('\\', '/')
    
    # 5 columnas x 4 filas = 20 miniaturas por lámina A3 horizontal (841.89 x 595.28 pt o similar)
    # Tamaño A3 apaisado: 1190.55 pt x 841.89 pt (o A3 en Typst: "a3", flipped: true -> 1190.55 x 841.89)
    # En A3 flipped con margen 20pt: ancho util = 1150 pt, alto util = 800 pt
    # Ancho celda = 220 pt, alto celda = 190 pt.
    # Miniatura: ratio 396/612 = 0.647. Ancho = 100 pt, alto = 154.5 pt.
    
    typ = [
        '// ==============================================================================',
        '// CONTACT SHEET — PROTOCOLO CAPÍTULOS 01–09',
        '// Vista miniatura integral de todas las páginas para auditoría de ritmo y vacíos',
        '// ==============================================================================',
        '',
        '#set page(',
        '  paper: "a3",',
        '  flipped: true,',
        '  margin: (x: 1.5cm, y: 1.2cm),',
        '  header: [',
        '    #align(center)[',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 9pt, weight: "bold", fill: rgb("#f15d22"))[',
        '        PROTOCOLO FAMILIAR POLIFLEX · CONTACT SHEET COMPLETO CAPÍTULOS 01–09',
        '      ]',
        '      #h(15pt)',
        '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.5pt, fill: rgb("#6c6b67"))[',
        '        (Sistema Editorial LOCKED · 126 Páginas Físicas Reales)',
        '      ]',
        '    ]',
        '  ],',
        '  footer: context [',
        '    #let p = counter(page).get().first()',
        '    #align(center)[#text(size: 7.5pt, fill: rgb("#6c6b67"))[Hoja de Contacto #p]]',
        '  ]',
        ')',
        '',
        f'#let master_pdf = "{rel_pdf}"',
        '',
        '#let thumb-card(p) = [',
        '  #let is_recto = calc.odd(p)',
        '  #align(center)[',
        '    #box(',
        '      stroke: 0.5pt + rgb("#cccccc"),',
        '      radius: 1pt,',
        '      fill: rgb("#ffffff"),',
        '      clip: true,',
        '      width: 95pt,',
        '      height: 146.8pt,',
        '      image(master_pdf, page: p, width: 95pt, height: 146.8pt)',
        '    )',
        '    #v(3pt)',
        '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6.5pt, fill: if is_recto { rgb("#f15d22") } else { rgb("#2e2f31") }, weight: "medium")[',
        '      Pág. #if p < 10 { "0" + str(p) } else { str(p) } (#if is_recto { "Recto" } else { "Verso" })',
        '    ]',
        '  ]',
        ']',
        ''
    ]
    
    pages_per_sheet = 20 # 5 cols x 4 rows
    total_sheets = (num_pages + pages_per_sheet - 1) // pages_per_sheet
    
    for s in range(total_sheets):
        start_p = s * pages_per_sheet + 1
        end_p = min((s + 1) * pages_per_sheet, num_pages)
        
        typ.append(f'// HOJA DE CONTACTO {s+1:02d} (Páginas {start_p:02d} a {end_p:02d})')
        typ.append('#grid(')
        typ.append('  columns: (1fr, 1fr, 1fr, 1fr, 1fr),')
        typ.append('  rows: (auto, auto, auto, auto),')
        typ.append('  row-gutter: 12pt,')
        typ.append('  column-gutter: 10pt,')
        
        for p in range(start_p, end_p + 1):
            typ.append(f'  thumb-card({p}),')
        
        # fill remaining cells in row
        remaining = pages_per_sheet - (end_p - start_p + 1)
        for _ in range(remaining):
            typ.append('  [],')
            
        typ.append(')')
        if s < total_sheets - 1:
            typ.append('#pagebreak()')
            typ.append('')

    with open(output_typ_path, 'w', encoding='utf-8') as f:
        f.write("\n".join(typ))

    typst_path = shutil.which("typst") or "typst"
    cmd = [
        typst_path,
        "compile",
        "--root", REPO_DIR,
        "--font-path", FONTS_DIR,
        output_typ_path,
        output_pdf_path
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(output_pdf_path)
        print(f"[ÉXITO] Contact Sheet PDF generado: {output_pdf_path} ({len(doc)} hojas A3)")
        return len(doc)
    else:
        print(f"[ERROR] Generación de Contact Sheet falló:\n{res.stderr}")
        return None

def run_audits_on_pdf(pdf_path, doc_label, expected_headings_count=None):
    print(f"\n" + "="*80)
    print(f"AUDITORÍA AUTOMATIZADA: {doc_label}")
    print(f"Archivo: {pdf_path}")
    print("="*80)

    doc = pymupdf.open(pdf_path)
    num_pages = len(doc)
    print(f"Total páginas físicas: {num_pages}")

    # 1. Folio coordinates audit (sample across all chapters)
    print("\n--- 1. AUDITORÍA DE ALINEACIÓN DE FOLIOS ---")
    folio_samples = []
    for pno in range(1, num_pages + 1):
        page = doc[pno - 1]
        d = page.get_text('dict')
        for b in d['blocks']:
            if b.get('type') == 0 and b['bbox'][1] > 500:
                for l in b['lines']:
                    for s in l['spans']:
                        txt = s['text'].strip()
                        if txt == f"{pno:02d}" or (pno >= 100 and txt == f"{pno}"):
                            folio_samples.append((pno, s['origin'][1], s['bbox']))

    # Print summary
    baselines = [f[1] for f in folio_samples]
    if baselines:
        min_b = min(baselines)
        max_b = max(baselines)
        print(f"Folios impresos detectados: {len(folio_samples)}")
        print(f"Línea base mínima: {min_b:.3f} pt, máxima: {max_b:.3f} pt (Discrepancia: {max_b - min_b:.4f} pt)")
        for p, orig_y, bbox in folio_samples[:10]:
            print(f"  Pág {p:02d}: Folio Baseline Y = {orig_y:.3f} pt, Bbox Y = ({bbox[1]:.2f}, {bbox[3]:.2f}) pt")
        if len(folio_samples) > 10:
            print(f"  ... y {len(folio_samples)-10} folios adicionales verificados.")

    # 2. Heading audit
    print("\n--- 2. AUDITORÍA DE ENCABEZADOS Y KEEP-WITH-NEXT ---")
    headings_found = []
    orphans = []
    for pno in range(1, num_pages + 1):
        page = doc[pno - 1]
        text = page.get_text()
        lines = [l.strip() for l in text.splitlines() if l.strip()]
        for idx, line in enumerate(lines):
            m = re.match(r'^([1-9]\.[0-9]+(?:\.[0-9]+)*)\.?\s+(.*)', line)
            if m:
                num = m.group(1)
                title = m.group(2)
                headings_found.append((pno, num, title))
                # Check keep-with-next
                following = [l for l in lines[idx+1:] if not l.isdigit() and not any(k in l for k in ['PROTOCOLO', 'VERSION', 'CAPÍTULO'])]
                if len(following) < 2 and idx >= len(lines) - 4:
                    orphans.append((pno, line, len(following)))

    print(f"Total Headings reconocidos en PDF: {len(headings_found)} (Esperado: {expected_headings_count or 'N/A'})")
    print(f"Encabezados huérfanos detectados (< 2 líneas): {len(orphans)}")
    if orphans:
        for o in orphans:
            print(f"  [ALERTA ORFANATO] Pág {o[0]}: '{o[1]}' (solo {o[2]} líneas siguientes)")

    # 3. Widows audit
    print("\n--- 3. AUDITORÍA DE LÍNEAS VIUDAS ---")
    widows = []
    for pno in range(1, num_pages + 1):
        text = doc[pno - 1].get_text()
        lines = [l.strip() for l in text.splitlines() if l.strip()]
        body_lines = [l for l in lines if not any(k in l for k in ['PROTOCOLO FAMILIAR', 'VERSION 1.0', 'CAPÍTULO'])]
        if body_lines:
            first = body_lines[0]
            words = first.split()
            if len(words) == 1 and not first.isdigit() and not first.endswith(':'):
                widows.append((pno, first))

    print(f"Líneas viudas de 1 sola palabra al inicio de página: {len(widows)}")

    # 4. Spurious artifacts audit (%2., quotes)
    print("\n--- 4. AUDITORÍA DE ARTEFACTOS ESPURIOS Y COMILLAS ---")
    pct_matches = []
    curly_quotes = []
    for pno in range(1, num_pages + 1):
        text = doc[pno - 1].get_text()
        if '%2.' in text:
            pct_matches.append(pno)
        # Check chapter opening for curly quotes ‘ or ’
        if '‘' in text or '’' in text:
            curly_quotes.append(pno)

    print(f"Ocurrencias de artefacto '%2.': {len(pct_matches)}")
    print(f"Páginas con comillas tipográficas simples curvadas espurias (‘ ’): {len(curly_quotes)}")

    # 5. Running Header Chapter numbers
    print("\n--- 5. AUDITORÍA DE RUNNING HEADERS ---")
    ch_headers = {}
    for pno in range(1, num_pages + 1):
        text = doc[pno - 1].get_text()
        m = re.search(r'CAPÍTULO\s+([0-9]{2})', text)
        if m:
            ch_headers[pno] = m.group(1)

    print(f"Páginas con running header de capítulo activo: {len(ch_headers)}")
    ch_distrib = {}
    for p, ch in ch_headers.items():
        ch_distrib.setdefault(ch, []).append(p)
    for ch, p_list in sorted(ch_distrib.items()):
        print(f"  CAPÍTULO {ch}: Páginas {min(p_list):02d} a {max(p_list):02d} ({len(p_list)} páginas de texto)")

    return {
        'num_pages': num_pages,
        'headings_count': len(headings_found),
        'orphans': orphans,
        'widows': widows,
        'pct_matches': pct_matches,
        'curly_quotes': curly_quotes,
        'folio_samples': folio_samples,
        'ch_headers': ch_headers
    }

def main():
    print("[INICIO] COMPILACIÓN MAESTRA Y AUDITORÍA — FASE 3.9")
    print("="*80)

    # 1. HASHES CANÓNICOS INICIALES
    print("\n[VERIFICACIÓN DE SEGURIDAD] Comprobando hashes SHA-256 iniciales...")
    initial_hashes = {}
    for cf in CANONICAL_CHAPTERS:
        cpath = os.path.join(CAP_DIR, cf)
        h = compute_sha256(cpath)
        initial_hashes[cf] = h
        print(f"  {cf}: {h}")

    # ==============================================================================
    # PARTE 1: TEST CAPÍTULOS 04–09 (SISTEMA LOCKED)
    # ==============================================================================
    print("\n" + "="*80)
    print("GENERANDO: TEST_CAPITULOS_04_09_SISTEMA_LOCKED.pdf")
    print("="*80)

    ch_04_09 = CANONICAL_CHAPTERS[3:] # chapters 04 to 09
    # Transition blanks for standalone 04-09 starting at P.01:
    # Cap 4: 1 blank (P.2) -> Opening P.3 -> First Page P.5 -> ends P.27 (Recto)
    # Cap 5: 1 blank (P.28) -> Opening P.29 -> First Page P.31 -> ends P.34 (Verso)
    # Cap 6: 2 blanks (P.35, P.36) -> Opening P.37 -> First Page P.39 -> ends P.42 (Verso)
    # Cap 7: 2 blanks (P.43, P.44) -> Opening P.45 -> First Page P.47 -> ends P.51 (Recto)
    # Cap 8: 1 blank (P.52) -> Opening P.53 -> First Page P.55 -> ends P.59 (Recto)
    # Cap 9: 1 blank (P.60) -> Opening P.61 -> First Page P.63 -> ends P.66 (Verso)
    trans_04_09 = {4: 1, 5: 1, 6: 2, 7: 2, 8: 1, 9: 1}

    typ_04_09_file = os.path.join(TESTS_DIR, 'test_capitulos_04_09_sistema_locked.typ')
    pdf_04_09_file = os.path.join(DIST_DIR, 'TEST_CAPITULOS_04_09_SISTEMA_LOCKED.pdf')

    code_04_09 = build_master_typst(ch_04_09, trans_04_09, doc_title="TEST CAPÍTULOS 04–09")
    with open(typ_04_09_file, 'w', encoding='utf-8') as f:
        f.write(code_04_09)

    subprocess.run(["powershell", "-Command", "Stop-Process -Name Acrobat -Force -ErrorAction SilentlyContinue"], capture_output=True)
    typst_path = shutil.which("typst") or "typst"
    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, typ_04_09_file, pdf_04_09_file]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(pdf_04_09_file)
        size_04_09 = os.path.getsize(pdf_04_09_file)
        print(f"[ÉXITO] PDF 04–09 compilado: {pdf_04_09_file} ({len(doc)} páginas, {size_04_09} bytes)")
        
        # Generate Spreads 04-09
        typ_spreads_04_09 = os.path.join(TESTS_DIR, 'test_capitulos_04_09_spreads.typ')
        pdf_spreads_04_09 = os.path.join(DIST_DIR, 'TEST_CAPITULOS_04_09_SISTEMA_LOCKED_SPREADS.pdf')
        generate_spreads_file(pdf_04_09_file, typ_spreads_04_09, pdf_spreads_04_09, len(doc))
        
        # Audit 04-09
        audit_04_09 = run_audits_on_pdf(pdf_04_09_file, "CAPÍTULOS 04–09 STANDALONE", expected_headings_count=85)
    else:
        print(f"[ERROR] Typst 04–09 falló:\n{res.stderr}")
        return

    # ==============================================================================
    # PARTE 2: TEST PROTOCOLO COMPLETO 01–09 (DOCUMENTO MAESTRO CONTINUO)
    # ==============================================================================
    print("\n" + "="*80)
    print("GENERANDO: TEST_PROTOCOLO_CAPITULOS_01_09.pdf")
    print("="*80)

    # Transition blanks for full 01-09:
    # Cap 1: 1 blank (P.2) -> Opening P.3 -> First Page P.5 -> ends P.8 (Verso)
    # Cap 2: 2 blanks (P.9, P.10) -> Opening P.11 -> First Page P.13 -> ends P.40 (Verso)
    # Cap 3: 2 blanks (P.41, P.42) -> Opening P.43 -> First Page P.45 -> ends P.61 (Recto)
    # Cap 4: 1 blank (P.62) -> Opening P.63 -> First Page P.65 -> ends P.87 (Recto)
    # Cap 5: 1 blank (P.88) -> Opening P.89 -> First Page P.91 -> ends P.94 (Verso)
    # Cap 6: 2 blanks (P.95, P.96) -> Opening P.97 -> First Page P.99 -> ends P.102 (Verso)
    # Cap 7: 2 blanks (P.103, P.104) -> Opening P.105 -> First Page P.107 -> ends P.111 (Recto)
    # Cap 8: 1 blank (P.112) -> Opening P.113 -> First Page P.115 -> ends P.119 (Recto)
    # Cap 9: 1 blank (P.120) -> Opening P.121 -> First Page P.123 -> ends P.126 (Verso)
    trans_01_09 = {1: 1, 2: 2, 3: 2, 4: 1, 5: 1, 6: 2, 7: 2, 8: 1, 9: 1}

    typ_01_09_file = os.path.join(TESTS_DIR, 'test_protocolo_capitulos_01_09.typ')
    pdf_01_09_file = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09.pdf')

    code_01_09 = build_master_typst(CANONICAL_CHAPTERS, trans_01_09, doc_title="PROTOCOLO FAMILIAR COMPLETO CAPÍTULOS 01–09")
    with open(typ_01_09_file, 'w', encoding='utf-8') as f:
        f.write(code_01_09)

    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, typ_01_09_file, pdf_01_09_file]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc_01_09 = pymupdf.open(pdf_01_09_file)
        size_01_09 = os.path.getsize(pdf_01_09_file)
        num_p_01_09 = len(doc_01_09)
        print(f"[ÉXITO] PDF 01–09 compilado: {pdf_01_09_file} ({num_p_01_09} páginas, {size_01_09} bytes)")

        # Generate Spreads 01-09
        typ_spreads_01_09 = os.path.join(TESTS_DIR, 'test_protocolo_capitulos_01_09_spreads.typ')
        pdf_spreads_01_09 = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf')
        generate_spreads_file(pdf_01_09_file, typ_spreads_01_09, pdf_spreads_01_09, num_p_01_09)

        # Generate Contact Sheet 01-09
        typ_contact_01_09 = os.path.join(TESTS_DIR, 'test_protocolo_capitulos_01_09_contact_sheet.typ')
        pdf_contact_01_09 = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09_CONTACT_SHEET.pdf')
        generate_contact_sheet(pdf_01_09_file, typ_contact_01_09, pdf_contact_01_09, num_p_01_09)

        # Audit 01-09
        audit_01_09 = run_audits_on_pdf(pdf_01_09_file, "PROTOCOLO COMPLETO CAPÍTULOS 01–09", expected_headings_count=175)
    else:
        print(f"[ERROR] Typst 01–09 falló:\n{res.stderr}")
        return

    # 3. VERIFICACIÓN DE HASHES POSTERIOR
    print("\n[VERIFICACIÓN DE SEGURIDAD FINAL] Verificando inalterabilidad de fuentes canónicas...")
    for cf in CANONICAL_CHAPTERS:
        cpath = os.path.join(CAP_DIR, cf)
        h_after = compute_sha256(cpath)
        assert h_after == initial_hashes[cf], f"FALLO CRÍTICO DE SEGURIDAD: Hash de {cf} fue modificado!"
        print(f"  [OK] {cf} 100% INTACTO")

    print("\n" + "="*80)
    print("PROCESO DE COMPILACIÓN Y AUDITORÍA DE FASE 3.9 CONCLUIDO CON ÉXITO")
    print("="*80)

if __name__ == '__main__':
    main()
