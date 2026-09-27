import os
import re
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

DELTA_6MM_PT = 6.0 * (72.0 / 25.4)

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

def clean_inline_text(text):
    text = text.replace('$', '\\$').replace('@', '\\@')
    text = text.replace('☐', '#sym.square ')
    text = re.sub(r'\*\*\*(.*?)\*\*\*', r'#strong[#emph[\1]]', text)
    text = re.sub(r'\*\*(.*?)\*\*', r'#strong[\1]', text)
    text = re.sub(r'(?<!\*)\*(?!\*)(.*?)(?<!\*)\*(?!\*)', r'#emph[\1]', text)
    return text.strip()

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

print("Calculando extensión de páginas para cada capítulo individual...")

for cidx, cfile in enumerate(all_chapters):
    cpath = os.path.join(CAP_DIR, cfile)
    fm, body = extract_frontmatter_and_content(cpath)
    ch_num = int(fm.get('chapter_number', cidx + 1))
    ch_str = f"{ch_num:02d}"
    ch_title = fm.get('title', '')
    ch_opening = fm.get('opening_title', [])
    
    # Generate standalone chapter typst file
    typ = []
    typ.append('#import "/templates/typst/componentes.typ": *')
    typ.append('#let cfg = yaml("/config/editorial_config.yaml")')
    typ.append('#show par: it => [#it #metadata("par") <content-marker>]')
    typ.append('#set page(')
    typ.append('  width: 396pt, height: 612pt,')
    typ.append(f'  margin: (inside: 58.74pt, outside: 22.70pt, top: {54.00 + DELTA_6MM_PT:.4f}pt, bottom: 65.00pt),')
    typ.append('  header: context [')
    typ.append('    #let p = counter(page).get().first()')
    typ.append('    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)')
    typ.append('    #if not is_first and has_content [')
    typ.append('      #let is_recto = calc.odd(p)')
    typ.append('      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")')
    typ.append('      #let rh_text(t, col) = text(font: neuzeit, size: 5.5pt, fill: rgb(col), tracking: 0.200em)[#t]')
    typ.append('      #let inst_unit = [#rh_text("PROTOCOLO FAMILIAR", "#6c6b67")#h(8pt)#rh_text("VERSION 1.0", "#f15d22")]')
    typ.append(f'      #let ch_unit = [#rh_text("CAPÍTULO {ch_str}", "#6c6b67")]')
    typ.append('      #let iso = interior-isotype(width: 7.1186pt, height: 7.0000pt, opacity: 50%)')
    typ.append('      #place(top + left, dx: 0pt, dy: 25.5pt)[')
    typ.append('        #if is_recto [')
    typ.append('          #grid(columns: (1fr, 1fr), align: (left + horizon, right + horizon), inst_unit, [#ch_unit#h(5pt)#box(baseline: 15%)[#iso]])')
    typ.append('        ] else [')
    typ.append('          #grid(columns: (1fr, 1fr), align: (left + horizon, right + horizon), [#box(baseline: 15%)[#iso]#h(5pt)#ch_unit], inst_unit)')
    typ.append('        ]')
    typ.append('      ]')
    typ.append('    ]')
    typ.append('  ],')
    typ.append('  footer: context [')
    typ.append('    #let p = counter(page).get().first()')
    typ.append('    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)')
    typ.append('    #if has_content [')
    typ.append('      #let is_recto = calc.odd(p)')
    typ.append('      #let minion = ("Minion Pro", "Georgia")')
    typ.append('      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")')
    typ.append('      #let p_str = if p < 10 { "0" + str(p) } else { str(p) }')
    typ.append('      #let folio_txt = text(font: minion, size: 8pt, fill: rgb("#f15d22"), weight: "medium")[#p_str]')
    typ.append('      #if is_first [')
    typ.append('        #v(20pt - 5.0535pt)')
    typ.append('        #let ftr_phrase = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[PROTOCOLO FAMILIAR]')
    typ.append('        #let ftr_ver = text(font: neuzeit, size: 4.8234pt, fill: rgb("#f15e22"), tracking: 0.371em)[VERSION 1.0]')
    typ.append('        #let iso_ftr = interior-isotype(width: 15.5740pt, height: 15.3150pt, opacity: 50%)')
    typ.append('        #if is_recto [')
    typ.append('          #grid(columns: (1fr, 1fr), align: (left + horizon, right + horizon), [#box(baseline: 20%)[#iso_ftr]#h(4pt)#ftr_phrase#h(6pt)#ftr_ver], folio_txt)')
    typ.append('        ] else [')
    typ.append('          #grid(columns: (1fr, 1fr), align: (left + horizon, right + horizon), folio_txt, [#ftr_phrase#h(6pt)#ftr_ver#h(4pt)#box(baseline: 20%)[#iso_ftr]])')
    typ.append('        ]')
    typ.append('      ] else [')
    typ.append('        #v(20pt)')
    typ.append('        #if is_recto [ #align(right)[#folio_txt] ] else [ #align(left)[#folio_txt] ]')
    typ.append('      ]')
    typ.append('    ]')
    typ.append('  ],')
    typ.append('  background: context [')
    typ.append('    #let p = counter(page).get().first()')
    typ.append('    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)')
    typ.append('    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)')
    typ.append('    #if has_content [')
    typ.append('      #let is_recto = calc.odd(p)')
    typ.append('      #let rule_x = if is_recto { 30.13pt } else { 365.87pt }')
    typ.append('      #place(top + left, dx: rule_x, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + rgb("#f15d22")))')
    typ.append('      #if is_first [ #interior-arcs(cfg, opacity: 50%) ]')
    typ.append('    ]')
    typ.append('  ]')
    typ.append(')')
    typ.append('#set text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"), tracking: 0em, hyphenate: false)')
    typ.append('#set par(leading: 12.72949pt, justify: true, spacing: 12.72949pt, linebreaks: "simple")')
    typ.append('#set heading(numbering: "1.1")')
    typ.append('#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 18.35pt + 18.00pt, below: 15.42pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[#text(font: minion, size: 10pt, fill: rgb("#f15d22"), stroke: 0.4pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]]#h(5.5pt)#text(font: minion, size: 10pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('#show heading.where(level: 3): it => block(width: 100%, breakable: false, sticky: true, above: 14.00pt + 18.00pt, below: 10.00pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[#text(font: minion, size: 9.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]]#h(5.0pt)#text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('#show heading.where(level: 4): it => block(width: 100%, breakable: false, sticky: true, above: 10.00pt + 18.00pt, below: 8.00pt)[')
    typ.append('  #let minion = ("Minion Pro", "Georgia")')
    typ.append('  #box[#text(font: minion, size: 9pt, fill: rgb("#f15d22"), stroke: 0.2pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]]#h(4.5pt)#text(font: minion, size: 9pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]')
    typ.append(']')
    typ.append('#let legal-alpha(marker, content) = block(width: 100%, inset: (left: 20pt), breakable: true, below: 12.73pt)[')
    typ.append('  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content')
    typ.append(']')
    typ.append('#let legal-roman(marker, content) = block(width: 100%, inset: (left: 40pt), breakable: true, below: 12.73pt)[')
    typ.append('  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content')
    typ.append(']')
    
    # First page begins on page 1 (Recto)
    typ.append(f'#metadata({ch_num}) <chapter-marker>')
    typ.append(f'#metadata("first-{ch_str}") <chapter-first-marker>')
    typ.append(f'#counter(heading).update(({ch_num}, 0, 0, 0))')
    
    title_display_lines = " \\ \n      ".join([clean_inline_text(tl) for tl in ch_opening])
    clm_dy_str = f"{-25.00 - DELTA_6MM_PT:.4f}pt"
    typ.append('#context {')
    typ.append('  let p = counter(page).get().first()')
    typ.append('  let is_recto = calc.odd(p)')
    typ.append('  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")')
    typ.append('  let minion = ("Minion Pro", "Georgia")')
    typ.append('  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[')
    typ.append('    UN LEGADO \\ QUE TRASCIENDE, \\ UN FUTURO QUE \\ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]')
    typ.append('  ]')
    typ.append(f'  if is_recto {{ place(top + left, dx: 0pt, dy: {clm_dy_str})[#clm_content] }} else {{ place(top + right, dx: 0pt, dy: {clm_dy_str})[#align(right)[#clm_content]] }}')
    typ.append(f'  place(top + left, dx: 0pt, dy: 28pt)[#text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[{ch_str}]]')
    typ.append('  place(top + left, dx: 1.36pt, dy: 74.95pt)[#rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)]')
    typ.append('  place(top + left, dx: 0pt, dy: 98.30pt)[')
    typ.append('    #block(width: 280pt)[')
    typ.append('      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")')
    typ.append('      #set par(leading: 13.5939pt, justify: false)')
    typ.append(f'      {title_display_lines}')
    typ.append('    ]')
    typ.append('  ]')
    typ.append('}')
    
    num_title_lines = len(ch_opening)
    v_spacing = 177.80 + (num_title_lines - 3) * 24.0053
    typ.append(f'#v({v_spacing:.2f}pt)')
    
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

    test_typ = os.path.join(SCRATCH_DIR, f'temp_ch{ch_str}.typ')
    test_pdf = os.path.join(SCRATCH_DIR, f'temp_ch{ch_str}.pdf')
    with open(test_typ, 'w', encoding='utf-8') as tf:
        tf.write("\n".join(typ))
    
    res = subprocess.run(['typst', 'compile', '--root', REPO_DIR, '--font-path', FONTS_DIR, test_typ, test_pdf], capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(test_pdf)
        n_pages = len(doc)
        last_is_odd = (n_pages % 2 != 0)
        print(f"Capítulo {ch_str}: {n_pages} páginas de contenido (P.1 a P.{n_pages}) -> Termina en {'RECTO (Impar)' if last_is_odd else 'VERSO (Par)'}")
    else:
        print(f"ERROR al compilar Cap {ch_str}:\n{res.stderr}")
