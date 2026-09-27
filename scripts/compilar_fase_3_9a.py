#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
COMPILADOR DE SIMULACIÓN DIAGNÓSTICA — FASE 3.9A
Hipótesis: Desfase global mediante respiración +18 pt exclusivamente en x.1
Genera:
1. dist/TEST_PAGINATION_X1_PLUS18.pdf (126 páginas)
2. dist/TEST_PAGINATION_X1_PLUS18_SPREADS.pdf (64 pliegos)
"""

import os
import sys
import re
import yaml
import subprocess
import shutil
import pymupdf

if sys.stdout.encoding.lower() != 'utf-8':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except Exception:
        pass

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')

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

def build_typst_code_fase_3_9a():
    transition_blanks = {1: 1, 2: 2, 3: 2, 4: 1, 5: 1, 6: 2, 7: 2, 8: 1, 9: 1}

    typ = []
    typ.append('// ==============================================================================')
    typ.append('// FASE 3.9A — SIMULACIÓN DE DESFASE GLOBAL MEDIANTE RESPIRACIÓN EN x.1')
    typ.append('// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)')
    typ.append('// HIPÓTESIS: +18 pt exclusivamente antes de x.1 de cada capítulo')
    typ.append('// ==============================================================================')
    typ.append('')
    typ.append('#import "/templates/typst/componentes.typ": *')
    typ.append('')
    typ.append('#let cfg = yaml("/config/editorial_config.yaml")')
    typ.append('')
    typ.append('// Marcadores semánticos de página y contenido')
    typ.append('#show par: it => [')
    typ.append('  #it')
    typ.append('  #metadata("par") <content-marker>')
    typ.append(']')
    typ.append('')
    typ.append('// Componente reutilizable: Página blanca ceremonial')
    typ.append('#let ceremonial-blank-page() = [')
    typ.append('  #page(margin: 0pt, header: none, footer: none)[')
    typ.append('    #metadata("ceremonial-blank") <blank-page-marker>')
    typ.append('  ]')
    typ.append(']')
    typ.append('')
    typ.append('// Configuración de página maestra con paridad dinámica y retícula vertical +6 mm')
    typ.append('#set page(')
    typ.append('  width: 396pt,')
    typ.append('  height: 612pt,')
    typ.append('  margin: (')
    typ.append('    inside: 58.74pt,')
    typ.append('    outside: 22.70pt,')
    typ.append(f'    top: {54.00 + DELTA_6MM_PT:.4f}pt,')
    typ.append('    bottom: 65.00pt')
    typ.append('  ),')
    typ.append('  header: context [')
    typ.append('    #let p = counter(page).get().first()')
    typ.append('    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)')
    typ.append('')
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
    typ.append('// H2: Sección principal (+18 pt adicional antes de nueva sección, sticky: true)')
    typ.append('#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 18.35pt + 18.00pt, below: 15.42pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[')
    typ.append('    #text(font: minion, size: 10pt, fill: rgb("#f15d22"), stroke: 0.4pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]')
    typ.append('  ]#h(5.5pt)#text(font: minion, size: 10pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('')
    typ.append('// H3: Subsección (+18 pt adicional antes de nueva subsección, sticky: true)')
    typ.append('#show heading.where(level: 3): it => block(width: 100%, breakable: false, sticky: true, above: 14.00pt + 18.00pt, below: 10.00pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[')
    typ.append('    #text(font: minion, size: 9.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]')
    typ.append('  ]#h(5.0pt)#text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('')
    typ.append('// H4: Sub-subsección (+18 pt adicional antes de nueva sub-subsección, sticky: true)')
    typ.append('#show heading.where(level: 4): it => block(width: 100%, breakable: false, sticky: true, above: 10.00pt + 18.00pt, below: 8.00pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[')
    typ.append('    #text(font: minion, size: 9pt, fill: rgb("#f15d22"), stroke: 0.2pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]')
    typ.append('  ]#h(4.5pt)#text(font: minion, size: 9pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('')
    typ.append('// Listas jurídicas')
    typ.append('#let legal-alpha(marker, content) = block(width: 100%, inset: (left: 20pt), breakable: true, below: 12.73pt)[')
    typ.append('  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content')
    typ.append(']')
    typ.append('')
    typ.append('#let legal-roman(marker, content) = block(width: 100%, inset: (left: 40pt), breakable: true, below: 12.73pt)[')
    typ.append('  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content')
    typ.append(']')
    typ.append('')

    # PÁGINA 1: Cortesía inicial
    typ.append('// PÁGINA 1: CORTESÍA INICIAL (RECTO)')
    typ.append('#ceremonial-blank-page()')
    typ.append('')

    for cidx, cfile in enumerate(CANONICAL_CHAPTERS):
        cpath = os.path.join(CAP_DIR, cfile)
        fm, body = extract_frontmatter_and_content(cpath)

        ch_num = int(fm.get('chapter_number', str(cidx + 1)))
        ch_str = f"{ch_num:02d}"
        ch_title = fm.get('title', '')
        ch_opening = fm.get('opening_title', [])
        ch_desc = fm.get('description', '')

        typ.append(f'// CAPÍTULO {ch_str}: {ch_title}')
        n_blanks = transition_blanks.get(ch_num, 1)
        for b_i in range(n_blanks):
            typ.append('#ceremonial-blank-page()')
        typ.append('')

        # Opening
        opening_items = [f'"{clean_inline_text(tl)}"' for tl in ch_opening]
        opening_tuple_str = "(" + ", ".join(opening_items) + ("," if len(opening_items) == 1 else "") + ")"
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

        # Blank before first page
        typ.append('#ceremonial-blank-page()')
        typ.append('')

        # First page
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
        typ.append('  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[')
        typ.append('    UN LEGADO \\ QUE TRASCIENDE, \\ UN FUTURO QUE \\ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]')
        typ.append('  ]')
        typ.append('  if is_recto {')
        typ.append(f'    place(top + left, dx: 0pt, dy: {clm_dy_str})[#clm_content]')
        typ.append('  } else {')
        typ.append(f'    place(top + right, dx: 0pt, dy: {clm_dy_str})[#align(right)[#clm_content]]')
        typ.append('  }')
        typ.append(f'  place(top + left, dx: 0pt, dy: 28pt)[')
        typ.append(f'    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[{ch_str}]')
        typ.append(f'  ]')
        typ.append(f'  place(top + left, dx: 1.36pt, dy: 74.95pt)[')
        typ.append('    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)')
        typ.append(f'  ]')
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

        # Lines of body
        lines = body.split('\n')
        idx = 0
        sublist_roman_counter = 0
        is_first_h2 = True

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
                
                # FASE 3.9A: Añadir exactamente +18 pt exclusivamente antes de x.1
                if is_first_h2:
                    typ.append('// FASE 3.9A: +18 pt de respiración adicional exclusivamente antes de x.1')
                    typ.append('#v(18pt)')
                    is_first_h2 = False
                
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

def generate_spreads(master_pdf_path, output_typ_path, output_pdf_path, num_pages):
    print(f"[INFO] Generando pliegos (Spreads) para {output_pdf_path} ({num_pages} páginas)...")
    rel_pdf = "/" + os.path.relpath(master_pdf_path, REPO_DIR).replace('\\', '/')
    
    spreads_typ = [
        '// ==============================================================================',
        '// SPREADS: FASE 3.9A — SIMULACIÓN DE DESFASE GLOBAL MEDIANTE RESPIRACIÓN EN x.1',
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
        '',
        '// Pliego 01: [VACÍO | P.01 Cortesía Recto]',
        '#render-spread(none, 1)',
        ''
    ]

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
    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, output_typ_path, output_pdf_path]
    res = subprocess.run(cmd, capture_output=True, text=False)
    if res.returncode == 0:
        doc = pymupdf.open(output_pdf_path)
        print(f"[ÉXITO] Spreads PDF generado: {output_pdf_path} ({len(doc)} pliegos)")
        return len(doc)
    else:
        err_msg = res.stderr.decode('utf-8', errors='replace')
        print(f"[ERROR] Generación de Spreads falló:\n{err_msg}")
        return None

def main():
    print("[INICIO] COMPILACIÓN DE FASE 3.9A — SIMULACIÓN x.1 +18 pt")
    print("="*80)

    typ_file = os.path.join(TESTS_DIR, 'test_pagination_x1_plus18.typ')
    pdf_file = os.path.join(DIST_DIR, 'TEST_PAGINATION_X1_PLUS18.pdf')

    typ_code = build_typst_code_fase_3_9a()
    with open(typ_file, 'w', encoding='utf-8') as f:
        f.write(typ_code)

    subprocess.run(["powershell", "-Command", "Stop-Process -Name Acrobat -Force -ErrorAction SilentlyContinue"], capture_output=True)

    print(f"[INFO] Compilando con Typst a {pdf_file}...")
    typst_path = shutil.which("typst") or "typst"
    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, typ_file, pdf_file]
    res = subprocess.run(cmd, capture_output=True, text=False)
    if res.returncode != 0:
        err = res.stderr.decode('utf-8', errors='replace')
        print(f"[ERROR] Error al compilar documento maestro:\n{err}")
        sys.exit(1)

    doc = pymupdf.open(pdf_file)
    sz = os.path.getsize(pdf_file)
    print(f"[ÉXITO] Documento Estado C generado: {pdf_file} ({len(doc)} páginas, {sz:,} bytes)")
    assert len(doc) == 126, f"Error: Se esperaban 126 páginas, se obtuvieron {len(doc)}"

    # Generar pliegos enfrentados (Spreads)
    typ_spreads = os.path.join(TESTS_DIR, 'test_pagination_x1_plus18_spreads.typ')
    pdf_spreads = os.path.join(DIST_DIR, 'TEST_PAGINATION_X1_PLUS18_SPREADS.pdf')
    num_sp = generate_spreads(pdf_file, typ_spreads, pdf_spreads, len(doc))
    assert num_sp == 64, f"Error: Se esperaban 64 pliegos, se obtuvieron {num_sp}"
    print(f"[ÉXITO] Spreads generados exitosamente: {pdf_spreads} ({num_sp} pliegos)")

if __name__ == '__main__':
    main()
