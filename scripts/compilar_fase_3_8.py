"""
COMPILADOR MAESTRO Y AUDITOR FORENSE: CAPÍTULOS 01–03
Fase 3.8 — Saneamiento del Parser y Jerarquía Editorial
Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

Genera:
1. dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8.pdf
2. dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8_SPREADS.pdf
3. dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8_CONTACT_SHEET.pdf
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
os.makedirs(TESTS_DIR, exist_ok=True)
os.makedirs(SCRATCH_DIR, exist_ok=True)
os.makedirs(REPORTES_DIR, exist_ok=True)

OUTPUT_TYP = os.path.join(TESTS_DIR, 'stress_test_capitulos_01_03_fase_3_8.typ')
OUTPUT_PDF = os.path.join(DIST_DIR, 'STRESS_TEST_CAPITULOS_01_03_FASE_3_8.pdf')
SPREADS_TYP = os.path.join(TESTS_DIR, 'stress_test_capitulos_01_03_fase_3_8_spreads.typ')
SPREADS_PDF = os.path.join(DIST_DIR, 'STRESS_TEST_CAPITULOS_01_03_FASE_3_8_SPREADS.pdf')
CONTACT_SHEET_TYP = os.path.join(TESTS_DIR, 'stress_test_capitulos_01_03_fase_3_8_contact_sheet.typ')
CONTACT_SHEET_PDF = os.path.join(DIST_DIR, 'STRESS_TEST_CAPITULOS_01_03_FASE_3_8_CONTACT_SHEET.pdf')

DELTA_6MM_PT = 6.0 * (72.0 / 25.4) # 17.007874 pt ≈ 17.01 pt

CANONICAL_CHAPTERS = [
    '01_capitulo1_declaracion_principios.md',
    '02_capitulo2_propiedad_control_liquidez.md',
    '03_capitulo3_gobierno_profesionalizacion.md'
]

def compute_sha256(filepath):
    h = hashlib.sha256()
    with open(filepath, 'rb') as f:
        while chunk := f.read(65536):
            h.update(chunk)
    return h.hexdigest().upper()

def to_roman(n):
    """Convierte un entero positivo a número romano minúsculo."""
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

def build_master_typst(transition_blanks):
    with open(CONFIG_FILE, 'r', encoding='utf-8') as f:
        cfg = yaml.safe_load(f)

    typ = []
    typ.append('// ==============================================================================')
    typ.append('// STRESS TEST CAPÍTULOS 01–03 — FASE 3.8: SANEAMIENTO DEL PARSER Y JERARQUÍA')
    typ.append('// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)')
    typ.append('// Generado automáticamente por scripts/compilar_fase_3_8.py')
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
    typ.append('      #v(20pt)')
    typ.append('      #if is_first [')
    typ.append('        // Footer institucional en primera página de capítulo')
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
    typ.append('        // Páginas de continuación: SOLO folio en corte exterior')
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
    typ.append('      // Filete vertical pegado al lomo (30.13pt en recto, 365.87pt en verso)')
    typ.append('      #let rule_x = if is_recto { 30.13pt } else { 365.87pt }')
    typ.append('      #place(top + left, dx: rule_x, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + rgb("#f15d22")))')
    typ.append('')
    typ.append('      // Arcos concéntricos exclusivos de la primera página de capítulo')
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
    typ.append('// Reglas de numeración y estilos de títulos (H2, H3, H4)')
    typ.append('#set heading(numbering: "1.1")')
    typ.append('')
    typ.append('// H2: Sección principal (Minion Pro Medium Display 10pt, tracking +0.019em, número naranja con trazo)')
    typ.append('#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 18.35pt, below: 15.42pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[')
    typ.append('    #text(font: minion, size: 10pt, fill: rgb("#f15d22"), stroke: 0.4pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]')
    typ.append('  ]#h(5.5pt)#text(font: minion, size: 10pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('')
    typ.append('// H3: Subsección (Minion Pro Medium Display 9.5pt, tracking +0.019em, número naranja con trazo)')
    typ.append('#show heading.where(level: 3): it => block(width: 100%, breakable: false, sticky: true, above: 14.00pt, below: 10.00pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[')
    typ.append('    #text(font: minion, size: 9.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]')
    typ.append('  ]#h(5.0pt)#text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('')
    typ.append('// H4: Sub-subsección (Minion Pro Medium Display 9pt, tracking +0.019em)')
    typ.append('#show heading.where(level: 4): it => block(width: 100%, breakable: false, sticky: true, above: 10.00pt, below: 8.00pt)[')
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

    for cidx, cfile in enumerate(CANONICAL_CHAPTERS):
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

        # 2. SPREAD A (RECTO): Chapter Opening (SERIALIZADO COMO TUPLA/ARRAY TYPST DE STRINGS SIN COMILLAS)
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

        # 4. SPREAD B (RECTO): Chapter First Page (Estado A) con retícula calibrada
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
                # Parser robusto para artefactos de listas OpenXML/Word (e.g., %2.)
                m = re.match(r'^%(\d+)\.\s+(.*)', line)
                lvl = int(m.group(1))
                # Nivel 2 en OpenXML corresponde a lowerRoman en este esquema documental
                sublist_roman_counter += 1
                roman_marker = f"{to_roman(sublist_roman_counter)}."
                content = clean_inline_text(m.group(2))
                typ.append(f'#legal-roman("{roman_marker}", [{content}])')
            elif re.match(r'^[ivxlcdm]+\.\s+', line):
                # Numerales romanos ya explícitos en el texto
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

def compile_master_pdf():
    # Paridad ceremonial idéntica a Fase 3.7.3:
    # Cap 1: 1 blanca previa (P.2) -> Opening en P.3 (Recto)
    # Cap 2: 1 blanca previa (P.8) -> Opening en P.9 (Recto)
    # Cap 3: 2 blancas previas (P.37 y P.38) tras terminar Cap 2 en P.36 (Verso) -> Opening en P.39 (Recto)
    transition_blanks = {1: 1, 2: 1, 3: 2}
    code = build_master_typst(transition_blanks)

    with open(OUTPUT_TYP, 'w', encoding='utf-8') as f:
        f.write(code)
    print(f"[OK] Archivo Typst maestro generado: {OUTPUT_TYP}")

    subprocess.run(["powershell", "-Command", "Stop-Process -Name Acrobat -Force -ErrorAction SilentlyContinue"], capture_output=True)
    typst_path = shutil.which("typst") or "typst"
    cmd = [
        typst_path,
        "compile",
        "--root", REPO_DIR,
        "--font-path", FONTS_DIR,
        OUTPUT_TYP,
        OUTPUT_PDF
    ]
    print(f"[INFO] Compilando {OUTPUT_PDF} ...")
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(OUTPUT_PDF)
        size_kb = os.path.getsize(OUTPUT_PDF) / 1024
        print(f"[ÉXITO] PDF maestro compilado: {OUTPUT_PDF} ({len(doc)} páginas, {size_kb:.1f} KB)")
        return len(doc)
    else:
        print(f"[ERROR] Typst falló:\n{res.stderr}")
        return None

def generate_spreads(num_pages):
    print(f"[INFO] Generando pliegos (Spreads) para {num_pages} páginas...")
    spreads_typ = [
        '// ==============================================================================',
        '// STRESS TEST CAPÍTULOS 01–03 FASE 3.8 SPREADS',
        '// Dobles páginas enfrentadas (Verso | Recto) a tamaño 792 × 612 pt',
        '// ==============================================================================',
        '',
        '#set page(width: 792pt, height: 612pt, margin: 0pt)',
        '',
        '#let master_pdf = "/dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8.pdf"',
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

    # Pliegos enfrentados: P.2|P.3, P.4|P.5, ..., P.56|none
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

    with open(SPREADS_TYP, 'w', encoding='utf-8') as f:
        f.write("\n".join(spreads_typ))

    typst_path = shutil.which("typst") or "typst"
    cmd = [
        typst_path,
        "compile",
        "--root", REPO_DIR,
        "--font-path", FONTS_DIR,
        SPREADS_TYP,
        SPREADS_PDF
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(SPREADS_PDF)
        print(f"[ÉXITO] Spreads PDF generado: {SPREADS_PDF} ({len(doc)} pliegos)")
    else:
        print(f"[ERROR] Generación de Spreads falló:\n{res.stderr}")

def generate_contact_sheet(num_pages):
    print(f"[INFO] Generando Hoja de Contactos (Contact Sheet 3x4)...")
    cs_typ = [
        '// ==============================================================================',
        '// CONTACT SHEET 3x4: CAPÍTULOS 01–03 FASE 3.8',
        '// Miniaturas a escala de todas las páginas para auditoría visual global',
        '// ==============================================================================',
        '',
        '#set page(paper: "a3", flipped: true, margin: (x: 1.5cm, y: 1.5cm))',
        '#set text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt, fill: rgb("#2e2f31"))',
        '',
        '#let master_pdf = "/dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8.pdf"',
        '',
        '#let thumb(p) = [',
        '  #align(center)[',
        '    #box(stroke: 0.5pt + rgb("#cccccc"), inset: 0pt)[',
        '      #image(master_pdf, page: p, width: 85pt, height: 131.36pt)',
        '    ]',
        '    #v(3pt)',
        '    #let p_str = if p < 10 { "0" + str(p) } else { str(p) }',
        '    #text(size: 7pt, fill: rgb("#6c6b67"))[Pág. #p_str]',
        '  ]',
        ']',
        ''
    ]

    pages_per_sheet = 12
    for sheet_start in range(1, num_pages + 1, pages_per_sheet):
        sheet_end = min(sheet_start + pages_per_sheet - 1, num_pages)
        sheet_num = sheet_start // pages_per_sheet + 1
        cs_typ.append(f'// Hoja {sheet_num}: Páginas {sheet_start} a {sheet_end}')
        cs_typ.append('#align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#f15d22"))[PROTOCOLO FAMILIAR · CONTACT SHEET FASE 3.8 (PÁGINAS ' + f'{sheet_start:02d}–{sheet_end:02d})]]')
        cs_typ.append('#v(10pt)')
        cs_typ.append('#grid(')
        cs_typ.append('  columns: (1fr, 1fr, 1fr, 1fr),')
        cs_typ.append('  row-gutter: 14pt,')
        cs_typ.append('  column-gutter: 10pt,')

        items = []
        for p in range(sheet_start, sheet_end + 1):
            items.append(f'  thumb({p})')
        cs_typ.append(",\n".join(items))
        cs_typ.append(')')
        cs_typ.append('#pagebreak()')
        cs_typ.append('')

    with open(CONTACT_SHEET_TYP, 'w', encoding='utf-8') as f:
        f.write("\n".join(cs_typ))

    typst_path = shutil.which("typst") or "typst"
    cmd = [
        typst_path,
        "compile",
        "--root", REPO_DIR,
        "--font-path", FONTS_DIR,
        CONTACT_SHEET_TYP,
        CONTACT_SHEET_PDF
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(CONTACT_SHEET_PDF)
        print(f"[ÉXITO] Contact Sheet PDF generado: {CONTACT_SHEET_PDF} ({len(doc)} hojas)")
    else:
        print(f"[ERROR] Generación de Contact Sheet falló:\n{res.stderr}")

def export_audit_renders():
    """Genera renders PNG en alta resolución de páginas clave para la auditoría visual."""
    print("[INFO] Exportando renders diagnósticos de alta resolución (200 DPI)...")
    doc = pymupdf.open(OUTPUT_PDF)
    brain_dir = os.environ.get("GEMINI_BRAIN_DIR", SCRATCH_DIR)
    # También asegurar directorio de artefactos si se puede determinar
    target_dirs = [SCRATCH_DIR]
    # Si hay una carpeta brain conocida:
    known_brain = os.environ.get("ANTIGRAVITY_ARTIFACTS_DIR") or str(Path.home() / ".gemini" / "antigravity-cli" / "brain" / "44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2")
    if os.path.exists(known_brain):
        target_dirs.append(known_brain)

    pages_to_render = [
        (3, "opening_cap01_no_quotes.png"),
        (9, "opening_cap02_no_quotes.png"),
        (32, "page_32_roman_numerals.png"),
        (39, "opening_cap03_no_quotes.png")
    ]

    mat = pymupdf.Matrix(200 / 72.0, 200 / 72.0)
    for pno, fname in pages_to_render:
        if pno <= len(doc):
            pix = doc[pno - 1].get_pixmap(matrix=mat, alpha=False)
            for d in target_dirs:
                out_path = os.path.join(d, fname)
                pix.save(out_path)
            print(f"  [RENDER] P.{pno:02d} -> {fname}")

    # Renderizar también pliego 16 (P.32 | P.33)
    if os.path.exists(SPREADS_PDF):
        sdoc = pymupdf.open(SPREADS_PDF)
        # Pliego 1: P.1
        # Pliego 16: P.32 | P.33 -> índice 16
        if len(sdoc) >= 17:
            pix = sdoc[16].get_pixmap(matrix=mat, alpha=False)
            for d in target_dirs:
                pix.save(os.path.join(d, "spread_17_page_32_33.png"))
            print("  [RENDER] Spread 17 (P.32|33) exportado.")

def run_forensic_audits():
    """Ejecuta todos los barridos forenses y retorna datos para el reporte."""
    print("\n" + "="*70)
    print("INICIANDO AUDITORÍA FORENSE AUTOMATIZADA DE FASE 3.8")
    print("="*70)

    # 1. Hashes de archivos canónicos
    hashes = {}
    for cf in CANONICAL_CHAPTERS:
        cpath = os.path.join(CAP_DIR, cf)
        h = compute_sha256(cpath)
        hashes[cf] = h
        print(f"[HASH] {cf}: {h}")

    # 2. Verificación de artefactos %2. en el PDF resultante
    doc = pymupdf.open(OUTPUT_PDF)
    pct2_found = []
    roman_on_32 = []
    for pno in range(len(doc)):
        text = doc[pno].get_text()
        if '%2.' in text:
            pct2_found.append(pno + 1)
        if pno + 1 == 32:
            for line in text.splitlines():
                if any(k in line for k in ['deuda financiera', 'efectivo no operativo', 'partida relevante', 'Enterprise Value']):
                    roman_on_32.append(line.strip())

    print(f"\n[AUDITORÍA %2.] Páginas con %2.: {pct2_found} (Esperado: [])")
    print("[AUDITORÍA P.32] Texto extraído en P.32:")
    for l in roman_on_32:
        print(f"  {l}")

    # 3. Verificación de comillas en portadas de capítulo (P.3, P.9, P.39)
    quote_audit = {}
    for pno, ch_name in [(3, "Capítulo 01"), (9, "Capítulo 02"), (39, "Capítulo 03")]:
        text = doc[pno - 1].get_text()
        quotes = [c for c in text if c in ['‘', '’', '“', '”', "'", '"']]
        quote_audit[pno] = {
            'chapter': ch_name,
            'quotes_count': len(quotes),
            'quotes': quotes,
            'lines': [l.strip() for l in text.splitlines() if l.strip()]
        }
        print(f"\n[AUDITORÍA COMILLAS P.{pno:02d} ({ch_name})]: Encontradas: {len(quotes)} comillas {quotes}")
        for l in quote_audit[pno]['lines'][:5]:
            print(f"  {l}")

    # 4. Auditoría de headings
    pdf_headings = []
    for pno in range(len(doc)):
        text = doc[pno].get_text()
        for line in text.splitlines():
            line = line.strip()
            m = re.match(r'^([1-3]\.[0-9]+(?:\.[0-9]+)*)\.?\s+(.*)', line)
            if m:
                pdf_headings.append((pno + 1, m.group(1), m.group(2)))

    print(f"\n[AUDITORÍA HEADINGS] Total headings en PDF: {len(pdf_headings)} (Esperado: 90)")

    # 5. Inventario de caracteres en capítulos canónicos
    char_inventory = {
        'hyphen_std': 0,      # - (U+002D)
        'en_dash': 0,         # – (U+2013)
        'em_dash': 0,         # — (U+2014)
        'quote_straight_dbl': 0, # " (U+0022)
        'quote_straight_sgl': 0, # ' (U+0027)
        'quote_curly_dbl_o': 0,  # “ (U+201C)
        'quote_curly_dbl_c': 0,  # ” (U+201D)
        'quote_curly_sgl_o': 0,  # ‘ (U+2018)
        'quote_curly_sgl_c': 0,  # ’ (U+2019)
        'nbsp': 0,            # \u00a0
        'soft_hyphen': 0,     # \u00ad
        'zero_width': 0,      # \u200b
        'percent_signs': 0    # %
    }

    percent_details = []
    for cf in CANONICAL_CHAPTERS:
        cpath = os.path.join(CAP_DIR, cf)
        with open(cpath, 'r', encoding='utf-8') as f:
            for lno, line in enumerate(f, 1):
                char_inventory['hyphen_std'] += line.count('-')
                char_inventory['en_dash'] += line.count('–')
                char_inventory['em_dash'] += line.count('—')
                char_inventory['quote_straight_dbl'] += line.count('"')
                char_inventory['quote_straight_sgl'] += line.count("'")
                char_inventory['quote_curly_dbl_o'] += line.count('“')
                char_inventory['quote_curly_dbl_c'] += line.count('”')
                char_inventory['quote_curly_sgl_o'] += line.count('‘')
                char_inventory['quote_curly_sgl_c'] += line.count('’')
                char_inventory['nbsp'] += line.count('\u00a0')
                char_inventory['soft_hyphen'] += line.count('\u00ad')
                char_inventory['zero_width'] += line.count('\u200b')
                if '%' in line:
                    char_inventory['percent_signs'] += line.count('%')
                    percent_details.append((cf, lno, line.strip()))

    print("\n[INVENTARIO CARACTERES CANÓNICOS]:")
    for k, v in char_inventory.items():
        print(f"  {k}: {v}")

    # 6. Tabla de asignación física de páginas
    page_allocation = []
    for pno in range(1, len(doc) + 1):
        is_recto = (pno % 2 != 0)
        side = "Recto" if is_recto else "Verso"
        text = doc[pno - 1].get_text()
        
        # Categorizar contenido de página
        ptype = "Desconocido"
        pdetail = ""
        if pno == 1:
            ptype = "Cortesía Inicial"
            pdetail = "Blanca protocolaria inicial"
        elif pno in [2, 4, 8, 10, 37, 38, 40]:
            ptype = "Blanca Ceremonial"
            pdetail = f"Transición o guarda ceremonial"
        elif pno in [3, 9, 39]:
            ptype = "Chapter Opening"
            ch = "01" if pno == 3 else ("02" if pno == 9 else "03")
            pdetail = f"Portada de Capítulo {ch} (fondo vectorial crema, logo POLIFLEX)"
        elif pno in [5, 11, 41]:
            ptype = "Chapter First Page"
            ch = "01" if pno == 5 else ("02" if pno == 11 else "03")
            pdetail = f"Primera página Cap {ch} (claim + arcos 50% + display {ch} + footer)"
        else:
            ptype = "Interior Page"
            # Determinar capítulo
            ch = "01" if pno <= 7 else ("02" if pno <= 36 else "03")
            # Buscar headings en la página
            h_on_page = [h[1] for h in pdf_headings if h[0] == pno]
            if h_on_page:
                pdetail = f"Cap {ch} · Headings: {', '.join(h_on_page)}"
            else:
                pdetail = f"Cap {ch} · Continuación de texto"

        page_allocation.append((pno, side, ptype, pdetail))

    return {
        'hashes': hashes,
        'pct2_found': pct2_found,
        'roman_on_32': roman_on_32,
        'quote_audit': quote_audit,
        'pdf_headings': pdf_headings,
        'char_inventory': char_inventory,
        'percent_details': percent_details,
        'page_allocation': page_allocation,
        'total_pages': len(doc)
    }

if __name__ == '__main__':
    print("[INICIO] Compilación y auditoría de Fase 3.8...")
    num_p = compile_master_pdf()
    if num_p:
        generate_spreads(num_p)
        generate_contact_sheet(num_p)
        export_audit_renders()
        audit_results = run_forensic_audits()
        print("\n[COMPLETADO] Fase 3.8 compilada y auditada con éxito.")
