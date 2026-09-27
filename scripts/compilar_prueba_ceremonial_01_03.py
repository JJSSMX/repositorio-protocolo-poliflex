"""
COMPILADOR DE PRUEBA EDITORIAL CEREMONIAL: CAPÍTULOS 01-03
Fase 3.7.1 - Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

Genera:
1. dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf
2. dist/TEST_CAPITULOS_01_03_CEREMONIAL_SPREADS.pdf
3. dist/TEST_CEREMONIAL_OPENINGS.pdf
"""

import os
import sys
import re
import yaml
import subprocess
import shutil

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
CONFIG_FILE = os.path.join(REPO_DIR, 'config', 'editorial_config.yaml')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
SCRATCH_DIR = os.path.join(REPO_DIR, 'scratch')
os.makedirs(DIST_DIR, exist_ok=True)
os.makedirs(TESTS_DIR, exist_ok=True)
os.makedirs(SCRATCH_DIR, exist_ok=True)

OUTPUT_TYP = os.path.join(TESTS_DIR, 'test_capitulos_01_03_ceremonial.typ')
OUTPUT_PDF = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_CEREMONIAL.pdf')
SPREADS_TYP = os.path.join(TESTS_DIR, 'test_capitulos_01_03_ceremonial_spreads.typ')
SPREADS_PDF = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_CEREMONIAL_SPREADS.pdf')
CEREMONIAL_OPENINGS_TYP = os.path.join(TESTS_DIR, 'test_ceremonial_openings.typ')
CEREMONIAL_OPENINGS_PDF = os.path.join(DIST_DIR, 'TEST_CEREMONIAL_OPENINGS.pdf')

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

def generate_ceremonial_typst():
    with open(CONFIG_FILE, 'r', encoding='utf-8') as f:
        cfg = yaml.safe_load(f)

    chapters = [
        '01_capitulo1_declaracion_principios.md',
        '02_capitulo2_propiedad_control_liquidez.md',
        '03_capitulo3_gobierno_profesionalizacion.md'
    ]

    typ = []
    typ.append('// ==============================================================================')
    typ.append('// TEST CAPÍTULOS 01–03 CEREMONIAL — FASE 3.7.1: DOBLE APERTURA CEREMONIAL')
    typ.append('// Documento maestro continuo generado automáticamente desde /capitulos/*.md')
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
    typ.append('// Configuración de página maestra con paridad dinámica')
    typ.append('#set page(')
    typ.append('  width: 396pt,')
    typ.append('  height: 612pt,')
    typ.append('  margin: (')
    typ.append('    inside: 58.74pt,   // Lomo: 58.74pt (izq en impar, der en par)')
    typ.append('    outside: 22.70pt,  // Corte: 22.70pt (der en impar, izq en par)')
    typ.append('    top: 54.00pt,      // Conservado provisionalmente para decisión visual 4/6/8 mm')
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

    for cidx, cfile in enumerate(chapters):
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

        # 1. BLANCA CEREMONIAL antes de Chapter Opening (Verso)
        typ.append(f'// SPREAD A (VERSO): Página blanca ceremonial previa a Chapter Opening {ch_str}')
        typ.append('#ceremonial-blank-page()')
        typ.append('')

        # 2. SPREAD A (RECTO): Chapter Opening
        opening_array_str = str(ch_opening)
        typ.append(f'// SPREAD A (RECTO): Portada de capítulo {ch_str}')
        typ.append('#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[')
        typ.append(f'  #metadata("opening-{ch_str}") <chapter-opening-marker>')
        typ.append(f'  #chapter-opening(')
        typ.append(f'    cfg,')
        typ.append(f'    number: "{ch_str}",')
        typ.append(f'    title: [{clean_inline_text(ch_title)}],')
        typ.append(f'    opening_title: {opening_array_str},')
        typ.append(f'    description: [{ch_desc}],')
        typ.append(f'    is_recto: false')
        typ.append(f'  )')
        typ.append(']')
        typ.append('')

        # 3. BLANCA CEREMONIAL antes de Chapter First Page (Verso)
        typ.append(f'// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página {ch_str}')
        typ.append('#ceremonial-blank-page()')
        typ.append('')

        # 4. SPREAD B (RECTO): Chapter First Page (Estado A)
        typ.append(f'// SPREAD B (RECTO): Primera página de contenido Capítulo {ch_str}')
        typ.append(f'#metadata({ch_num}) <chapter-marker>')
        typ.append(f'#metadata("first-{ch_str}") <chapter-first-marker>')
        typ.append(f'#counter(heading).update(({ch_num}, 0, 0, 0))')
        typ.append('')

        title_display_lines = " \\ \n      ".join([clean_inline_text(tl) for tl in ch_opening])
        typ.append('#context {')
        typ.append('  let p = counter(page).get().first()')
        typ.append('  let is_recto = calc.odd(p)')
        typ.append('  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")')
        typ.append('  let minion = ("Minion Pro", "Georgia")')
        typ.append('')
        typ.append('  // 1. Claim institucional superior')
        typ.append('  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[')
        typ.append('    UN LEGADO \\ QUE TRASCIENDE, \\ UN FUTURO QUE \\ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]')
        typ.append('  ]')
        typ.append('  if is_recto {')
        typ.append('    place(top + left, dx: 0pt, dy: -25pt)[#clm_content]')
        typ.append('  } else {')
        typ.append('    place(top + right, dx: 0pt, dy: -25pt)[#align(right)[#clm_content]]')
        typ.append('  }')
        typ.append('')
        typ.append(f'  // 2. Número display grande "{ch_str}"')
        typ.append(f'  place(top + left, dx: 0pt, dy: 28pt)[')
        typ.append(f'    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[{ch_str}]')
        typ.append(f'  ]')
        typ.append('')
        typ.append('  // 3. Regla horizontal naranja')
        typ.append('  place(top + left, dx: 1.36pt, dy: 74.95pt)[')
        typ.append('    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)')
        typ.append('  ]')
        typ.append('')
        typ.append('  // 4. Título completo de capítulo')
        typ.append('  place(top + left, dx: 0pt, dy: 98.30pt)[')
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

        # Procesar líneas de contenido
        lines = body.split('\n')
        idx = 0
        while idx < len(lines):
            line = lines[idx].strip()
            if not line:
                idx += 1
                continue

            if line.startswith('# '):
                idx += 1
                continue
            elif line.startswith('#### '):
                raw = line[5:].strip()
                clean_title = re.sub(r'^[0-9]+(?:\.[0-9]+)*\.?\s*', '', raw)
                typ.append(f'==== {clean_inline_text(clean_title)}')
            elif line.startswith('### '):
                raw = line[4:].strip()
                clean_title = re.sub(r'^[0-9]+(?:\.[0-9]+)*\.?\s*', '', raw)
                typ.append(f'=== {clean_inline_text(clean_title)}')
            elif line.startswith('## '):
                raw = line[3:].strip()
                clean_title = re.sub(r'^[0-9]+(?:\.[0-9]+)*\.?\s*', '', raw)
                typ.append(f'== {clean_inline_text(clean_title)}')
            elif re.match(r'^[a-z]\)\s+', line):
                m = re.match(r'^([a-z]\))\s+(.*)', line)
                marker = m.group(1)
                content = clean_inline_text(m.group(2))
                typ.append(f'#legal-alpha("{marker}", [{content}])')
            elif re.match(r'^[ivxlcdm]+\.\s+', line):
                m = re.match(r'^([ivxlcdm]+\.)\s+(.*)', line)
                marker = m.group(1)
                content = clean_inline_text(m.group(2))
                typ.append(f'#legal-roman("{marker}", [{content}])')
            else:
                p_text = clean_inline_text(line)
                typ.append(f'{p_text}\n')

            idx += 1

        typ.append('')

    with open(OUTPUT_TYP, 'w', encoding='utf-8') as f:
        f.write("\n".join(typ))

    print(f"[OK] Archivo maestro ceremonial generado: {OUTPUT_TYP}")
    return OUTPUT_TYP

def compile_pdf():
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
        size_kb = os.path.getsize(OUTPUT_PDF) / 1024
        print(f"[ÉXITO] PDF ceremonial compilado: {OUTPUT_PDF} ({size_kb:.1f} KB)")
        return True
    else:
        print(f"[ERROR] Typst falló:\n{res.stderr}")
        return False

def generate_ceremonial_spreads():
    import fitz
    doc = fitz.open(OUTPUT_PDF)
    num_pages = len(doc)
    print(f"[INFO] Generando pliegos ceremoniales para {num_pages} páginas...")

    spreads_typ = [
        '// ==============================================================================',
        '// TEST CAPÍTULOS 01–03 CEREMONIAL SPREADS — FASE 3.7.1',
        '// Dobles páginas enfrentadas (Verso | Recto) a tamaño 792 × 612 pt',
        '// ==============================================================================',
        '',
        '#set page(width: 792pt, height: 612pt, margin: 0pt, fill: rgb("#ffffff"))',
        ''
    ]

    # Pliego 1: Página 1 (Recto) mostrada a la derecha del pliego inicial (izquierda vacía)
    spreads_typ.append('// Pliego 1: Página 1 de Cortesía (Recto)')
    spreads_typ.append('#grid(')
    spreads_typ.append('  columns: (396pt, 396pt),')
    spreads_typ.append('  rect(width: 396pt, height: 612pt, fill: rgb("#ffffff"), stroke: none),')
    spreads_typ.append('  image("/dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf", page: 1, width: 396pt, height: 612pt)')
    spreads_typ.append(')')
    spreads_typ.append('#pagebreak()')

    # Pliegos subsiguientes: (2 | 3), (4 | 5), etc.
    p = 2
    spread_idx = 2
    while p <= num_pages:
        verso_p = p
        recto_p = p + 1
        spreads_typ.append(f'// Pliego {spread_idx}: Pág {verso_p} (Verso) | Pág {recto_p if recto_p <= num_pages else "—"} (Recto)')

        recto_content = f'image("/dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf", page: {recto_p}, width: 396pt, height: 612pt)' if recto_p <= num_pages else 'rect(width: 396pt, height: 612pt, fill: rgb("#ffffff"), stroke: none)'

        spreads_typ.append('#grid(')
        spreads_typ.append('  columns: (396pt, 396pt),')
        spreads_typ.append(f'  image("/dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf", page: {verso_p}, width: 396pt, height: 612pt),')
        spreads_typ.append(f'  {recto_content}')
        spreads_typ.append(')')

        if p + 2 <= num_pages:
            spreads_typ.append('#pagebreak()')

        p += 2
        spread_idx += 1

    with open(SPREADS_TYP, 'w', encoding='utf-8') as f:
        f.write("\n".join(spreads_typ))

    print(f"[OK] Archivo Typst de pliegos ceremoniales generado: {SPREADS_TYP}")

    typst_path = shutil.which("typst") or "typst"
    cmd = [
        typst_path,
        "compile",
        "--root", REPO_DIR,
        "--font-path", FONTS_DIR,
        SPREADS_TYP,
        SPREADS_PDF
    ]
    print(f"[INFO] Compilando pliegos {SPREADS_PDF} ...")
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        size_kb = os.path.getsize(SPREADS_PDF) / 1024
        print(f"[ÉXITO] PDF de pliegos ceremoniales compilado: {SPREADS_PDF} ({size_kb:.1f} KB)")
        return True
    else:
        print(f"[ERROR] Typst falló en pliegos ceremoniales:\n{res.stderr}")
        return False

def generate_specific_ceremonial_openings():
    """
    Genera dist/TEST_CEREMONIAL_OPENINGS.pdf
    Muestra únicamente los 6 spreads ceremoniales:
    CAPÍTULO 01: [BLANCA | CHAPTER OPENING 01], [BLANCA | CHAPTER FIRST PAGE 01]
    CAPÍTULO 02: [BLANCA | CHAPTER OPENING 02], [BLANCA | CHAPTER FIRST PAGE 02]
    CAPÍTULO 03: [BLANCA | CHAPTER OPENING 03], [BLANCA | CHAPTER FIRST PAGE 03]
    """
    import fitz
    doc = fitz.open(OUTPUT_PDF)

    # Identificar páginas físicas de cada apertura y primera página
    # En nuestra secuencia:
    # Cap 1: Opening = P.3, First = P.5 (Blancas en P.2 y P.4)
    # Cap 2: Opening = P.9, First = P.11 (Blancas en P.8 y P.10)
    # Cap 3: Opening = P.37, First = P.39 (Blancas en P.36 y P.38)
    spread_pairs = [
        (2, 3, "CAPÍTULO 01: SPREAD A [BLANCA | CHAPTER OPENING 01]"),
        (4, 5, "CAPÍTULO 01: SPREAD B [BLANCA | CHAPTER FIRST PAGE 01]"),
        (8, 9, "CAPÍTULO 02: SPREAD A [BLANCA | CHAPTER OPENING 02]"),
        (10, 11, "CAPÍTULO 02: SPREAD B [BLANCA | CHAPTER FIRST PAGE 02]"),
        (36, 37, "CAPÍTULO 03: SPREAD A [BLANCA | CHAPTER OPENING 03]"),
        (38, 39, "CAPÍTULO 03: SPREAD B [BLANCA | CHAPTER FIRST PAGE 03]")
    ]

    typ = [
        '// ==============================================================================',
        '// TEST CEREMONIAL OPENINGS — FASE 3.7.1: REVISIÓN DE APERTURAS CEREMONIALES',
        '// Muestra exclusivamente los 6 spreads ceremoniales de los Capítulos 01–03',
        '// ==============================================================================',
        '',
        '#set page(width: 792pt, height: 612pt, margin: 0pt, fill: rgb("#ffffff"))',
        ''
    ]

    for idx, (verso_p, recto_p, label) in enumerate(spread_pairs):
        typ.append(f'// Spread {idx+1}: {label}')
        typ.append('#grid(')
        typ.append('  columns: (396pt, 396pt),')
        typ.append(f'  image("/dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf", page: {verso_p}, width: 396pt, height: 612pt),')
        typ.append(f'  image("/dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf", page: {recto_p}, width: 396pt, height: 612pt)')
        typ.append(')')
        if idx < len(spread_pairs) - 1:
            typ.append('#pagebreak()')

    with open(CEREMONIAL_OPENINGS_TYP, 'w', encoding='utf-8') as f:
        f.write("\n".join(typ))

    print(f"[OK] Archivo Typst de aperturas ceremoniales generado: {CEREMONIAL_OPENINGS_TYP}")

    typst_path = shutil.which("typst") or "typst"
    cmd = [
        typst_path,
        "compile",
        "--root", REPO_DIR,
        "--font-path", FONTS_DIR,
        CEREMONIAL_OPENINGS_TYP,
        CEREMONIAL_OPENINGS_PDF
    ]
    print(f"[INFO] Compilando {CEREMONIAL_OPENINGS_PDF} ...")
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        size_kb = os.path.getsize(CEREMONIAL_OPENINGS_PDF) / 1024
        print(f"[ÉXITO] PDF de aperturas ceremoniales compilado: {CEREMONIAL_OPENINGS_PDF} ({size_kb:.1f} KB)")
        return True
    else:
        print(f"[ERROR] Typst falló en aperturas ceremoniales:\n{res.stderr}")
        return False

if __name__ == '__main__':
    generate_ceremonial_typst()
    if compile_pdf():
        generate_ceremonial_spreads()
        generate_specific_ceremonial_openings()
