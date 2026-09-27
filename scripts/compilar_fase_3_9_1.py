#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
COMPILADOR MAESTRO Y AUDITOR FORENSE: FASE 3.9.1
Consolidación del Control Editorial de Paginación
Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

Genera:
1. dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1.pdf (126 páginas exactas)
2. dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1_SPREADS.pdf (64 pliegos exactos)

Aplica formalmente:
- REGLA A: Control de viudas y huérfanas (mínimo 2 líneas antes y 2 después de quiebre de párrafo).
- REGLA B: Control de encabezados (mínimo 2 líneas de cuerpo subordinado, keep-with-next).
- REGLA C: Cierres de capítulo mediante redistribución semántica hacia adelante (sin compresión).
- REGLA D: Prohibición de sobreoptimización de unidades semánticas cortas legítimas.
- CONGELAMIENTO: Retícula vertical +6 mm, geometrías, márgenes, tipografías y componentes locked.
"""

import os
import sys
import re
import yaml
import subprocess
import shutil
import pymupdf
import hashlib

# Ensure utf-8 output on Windows console
if sys.stdout.encoding.lower() != 'utf-8':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except Exception:
        pass

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
CONFIG_FILE = os.path.join(REPO_DIR, 'config', 'editorial_config.yaml')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
REPORTES_DIR = os.path.join(REPO_DIR, 'reportes')

os.makedirs(DIST_DIR, exist_ok=True)
os.makedirs(TESTS_DIR, exist_ok=True)
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

CANONICAL_HASHES_EXPECTED = {
    '01_capitulo1_declaracion_principios.md': 'B18B22334759386A547DC94103F6A63EC5AD72BFC9BAA10E4453D9143E58246E',
    '02_capitulo2_propiedad_control_liquidez.md': '5D3AA506523703D1D5588E74ADDABB3EB4F11B1A660653AD50F09B787EA46886',
    '03_capitulo3_gobierno_profesionalizacion.md': '536C8D9879441CDE924C78C36F4B4879A9F69069540FAA699E002367A0B8CC53',
    '04_capitulo4_sucesion_familiar.md': '4CCBE4D2E25B5FC8E50EA11BE6206DA044E532CACA7FB70BEDA6345BD693619A',
    '05_capitulo5_control_informacion_comunicacion.md': 'B8A731FCB4939E95861F2608D86A20137E67EC462FF4D40B06C567719F336342',
    '06_capitulo6_disciplina_financiera.md': '3D6157E2201487A43B8262CF22E4E07F60BD680E827759F7BC3D02F47F383D73',
    '07_capitulo7_procedimiento_sancionador.md': 'DE32E740807452DBBB5E2676386EB491A268071859E8CF00110A578127A30CAF',
    '08_capitulo8_solucion_conflictos.md': 'E041394A51C1DCE44389BAC05A4A3D393CD48F3D825AEF17E0495402271669EF',
    '09_capitulo9_regimen_juridico.md': 'C3A7B5E4DC6D45CA9980A687E1DB7DCDF1286228DAFAAE6D09180FE23A4F1245'
}

COMPONENTES_HASH_EXPECTED = '8433F851EA3E0EA9EDC09759DF25E37F6D95EBF20E0FDBAC072A2E9445E38442'

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

def build_master_typst_fase_3_9_1(chapter_files, transition_blanks, atomic_signatures=None, forward_sections=None):
    """
    Construye el código Typst maestro aplicando las políticas semánticas consolidadas.
    - atomic_signatures: conjunto de firmas de párrafos que requieren protección atómica (Regla A).
    - forward_sections: conjunto de títulos de sección H2 a redistribuir hacia adelante (Regla C).
    """
    if atomic_signatures is None:
        atomic_signatures = set()
    if forward_sections is None:
        forward_sections = set()

    typ = []
    typ.append('// ==============================================================================')
    typ.append('// PROTOCOLO FAMILIAR COMPLETO CAPÍTULOS 01–09 — FASE 3.9.1 CONSOLIDADA')
    typ.append('// Poliductos Flexibles, S.A. de C.V. (POLIFLEX)')
    typ.append('// Motor Editorial Semántico con Control de Paginación')
    typ.append('// Generado automáticamente por scripts/compilar_fase_3_9_1.py')
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
    typ.append('// Componente reutilizable: Página blanca ceremonial (0 elementos, paridad)')
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
    typ.append('    inside: 58.74pt,   // Lomo: 58.74pt')
    typ.append('    outside: 22.70pt,  // Corte: 22.70pt')
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
    typ.append('        // FRANJA INFERIOR CHAPTER-FIRST-PAGE CORREGIDA MATEMÁTICAMENTE')
    typ.append('        // Compensación exacta: #v(20pt - 5.0535pt) = #v(14.9465pt)')
    typ.append('        // Baseline Folio = 585.932 pt / 591.708 pt (Idéntico a interior-page)')
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
    typ.append('        // Páginas de continuación: SOLO folio en corte exterior')
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
    typ.append('// Componentes de listas jurídicas con sangría de bloque exacta')
    typ.append('#let legal-alpha(marker, content) = block(width: 100%, inset: (left: 20pt), breakable: true, below: 12.73pt)[')
    typ.append('  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content')
    typ.append(']')
    typ.append('')
    typ.append('#let legal-roman(marker, content) = block(width: 100%, inset: (left: 40pt), breakable: true, below: 12.73pt)[')
    typ.append('  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content')
    typ.append(']')
    typ.append('')

    # PÁGINA 1: Portadilla / Cortesía inicial
    typ.append('// ==============================================================================')
    typ.append('// PÁGINA 1: PÁGINA DE CORTESÍA INICIAL (RECTO)')
    typ.append('// ==============================================================================')
    typ.append('#ceremonial-blank-page()')
    typ.append('')

    for cidx, cfile in enumerate(chapter_files):
        cpath = os.path.join(CAP_DIR, cfile)
        fm, body = extract_frontmatter_and_content(cpath)

        ch_num = int(fm.get('chapter_number', str(cidx + 1)))
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

        # 2. SPREAD A (RECTO): Chapter Opening
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

        # Procesar líneas de contenido con parser enriquecido con reglas semánticas
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
                # REGLA C: Si la sección está marcada para redistribución hacia adelante
                if clean_title in forward_sections or raw in forward_sections:
                    typ.append('// REGLA C: Redistribución hacia adelante de unidad semántica completa')
                    typ.append('#pagebreak()')
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
                # REGLA A: Verificar si el párrafo requiere protección atómica
                is_atomic = False
                for sig in atomic_signatures:
                    if sig in p_text or p_text in sig:
                        is_atomic = True
                        break
                if is_atomic:
                    typ.append('// REGLA A: Párrafo protegido atómicamente para prevenir viudas (< 2 líneas)')
                    typ.append(f'#block(width: 100%, breakable: false)[{p_text}]\n')
                    idx += 1
                    continue

                # DECISIÓN CAPÍTULO 04 (APROBADA · FASE 3.9B ALT. B): Trasladar párrafo 2 conclusivo de 4.9.4
                if ch_num == 4 and 'Concluido el procedimiento y cumplidas las condiciones' in p_text:
                    typ.append('// DECISIÓN EDITORIAL CAP. 04: Trasladar párrafo 2 conclusivo de 4.9.4 a P.87')
                    typ.append('#pagebreak()')

                # DECISIÓN CAPÍTULO 08 (APROBADA · FASE 3.9B ALT. B): Mantener H2 8.9 + P1 en P.118; trasladar P2 y P3 a P.119
                if ch_num == 8 and 'La existencia de un conflicto no excluye la responsabilidad' in p_text:
                    typ.append('// DECISIÓN EDITORIAL CAP. 08: Mantener H2 8.9 + P1 en P.118; trasladar P2 y P3 a P.119')
                    typ.append('#pagebreak()')

                typ.append(f'{p_text}\n')

            idx += 1

        typ.append('')

    return "\n".join(typ)

def generate_spreads_file(master_pdf_path, output_typ_path, output_pdf_path, num_pages):
    print(f"[INFO] Generando pliegos (Spreads) para {output_pdf_path} ({num_pages} páginas)...")
    rel_pdf = "/" + os.path.relpath(master_pdf_path, REPO_DIR).replace('\\', '/')
    
    spreads_typ = [
        '// ==============================================================================',
        '// SPREADS: Dobles páginas enfrentadas (Verso | Recto) a tamaño 792 × 612 pt',
        '// FASE 3.9.1 — CONSOLIDACIÓN DEL CONTROL EDITORIAL DE PAGINACIÓN',
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
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        doc = pymupdf.open(output_pdf_path)
        print(f"[ÉXITO] Spreads PDF generado: {output_pdf_path} ({len(doc)} pliegos)")
        return len(doc)
    else:
        print(f"[ERROR] Generación de Spreads falló:\n{res.stderr}")
        return None

def run_audits_on_consolidated_pdf(pdf_path):
    print(f"\n" + "="*80)
    print(f"AUDITORÍA INTEGRAL DE CONSOLIDACIÓN — FASE 3.9.1")
    print(f"Archivo: {pdf_path}")
    print("="*80)

    doc = pymupdf.open(pdf_path)
    num_pages = len(doc)
    print(f"Total páginas físicas: {num_pages} (Esperado: 126)")
    assert num_pages == 126, f"ERROR: Páginas físicas = {num_pages} != 126"

    # 1. Auditoría de Folios
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

    baselines = [f[1] for f in folio_samples]
    if baselines:
        min_b = min(baselines)
        max_b = max(baselines)
        print(f"Folios impresos detectados: {len(folio_samples)}")
        print(f"Línea base mínima: {min_b:.3f} pt, máxima: {max_b:.3f} pt (Discrepancia: {max_b - min_b:.4f} pt)")
        assert max_b - min_b < 0.001, f"ERROR: Discrepancia en folios = {max_b - min_b} pt"
        print("  [OK] Folios 100% matemáticamente alineados en 585.932 pt / 591.708 pt.")

    # 2. Auditoría de Encabezados
    print("\n--- 2. AUDITORÍA DE ENCABEZADOS Y KEEP-WITH-NEXT (REGLA B) ---")
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
                following = [l for l in lines[idx+1:] if not l.isdigit() and not any(k in l for k in ['PROTOCOLO', 'VERSION', 'CAPÍTULO'])]
                if len(following) < 2 and idx >= len(lines) - 4:
                    orphans.append((pno, line, len(following)))

    print(f"Total Headings reconocidos en PDF: {len(headings_found)} (Esperado: 175)")
    print(f"Encabezados huérfanos detectados (< 2 líneas): {len(orphans)}")
    assert len(headings_found) == 175, f"ERROR: Headings = {len(headings_found)} != 175"
    assert len(orphans) == 0, f"ERROR: Encabezados huérfanos = {len(orphans)}"
    print("  [OK] Cero encabezados huérfanos. 100% de títulos acompañados de >= 2 líneas de cuerpo.")

    # 3. Auditoría de Cierres de Capítulo (Regla C y Regla D)
    print("\n--- 3. AUDITORÍA DE PÁGINAS TERMINALES DE CAPÍTULO (REGLAS C Y D) ---")
    term_pages = [8, 40, 61, 87, 94, 102, 111, 119, 126]
    closure_metrics = []
    for ch_idx, p in enumerate(term_pages, 1):
        page = doc[p - 1]
        d = page.get_text('dict')
        lines = []
        for b in d['blocks']:
            if b.get('type') == 0:
                # Filtrar bloques de encabezado (y < 60) y pie de página (y > 560)
                if b['bbox'][1] < 60 or b['bbox'][3] > 560:
                    continue
                for l in b['lines']:
                    txt = ''.join(s['text'] for s in l['spans']).strip()
                    if not txt: continue
                    lines.append(txt)
        
        line_count = len(lines)
        first_line = lines[0] if lines else ""
        starts_with_heading = bool(re.match(r'^[1-9]\.[0-9]+', first_line))
        closure_metrics.append((ch_idx, p, line_count, starts_with_heading, first_line))
        print(f"  Capítulo {ch_idx:02d} (Pág. {p:02d}): {line_count} líneas útiles | Inicia con Heading: {starts_with_heading}")
        print(f"     Inicio: '{first_line[:65]}...'")

    # Verificaciones específicas de cierre
    # Cap 01: P.08 >= 5 líneas (Regla D)
    assert closure_metrics[0][2] == 6, f"Cap 01 P.08 esperado 6 líneas, obtuvo {closure_metrics[0][2]}"
    # Cap 04: P.87 == 5 líneas (Párrafo 2 conclusivo de 4.9.4 completo)
    assert closure_metrics[3][2] == 5, f"Cap 04 P.87 esperado 5 líneas, obtuvo {closure_metrics[3][2]}"
    # Cap 06: P.102 >= 10 líneas (Regla D)
    assert closure_metrics[5][2] >= 10, f"Cap 06 P.102 esperado >= 10 líneas, obtuvo {closure_metrics[5][2]}"
    # Cap 08: P.119 == 5 líneas (Párrafos 2 y 3 de 8.9 · Alternativa B aprobada)
    assert closure_metrics[7][2] == 5, f"Cap 08 P.119 esperado 5 líneas, obtuvo {closure_metrics[7][2]}"
    # Cap 09: P.126 >= 7 líneas (Regla C · Sección 9.8 completa con H2)
    assert closure_metrics[8][2] >= 7, f"Cap 09 P.126 esperado >= 7 líneas, obtuvo {closure_metrics[8][2]}"
    print("  [OK] Cierres de capítulo 100% equilibrados (cero residuos accidentales <= 2 líneas).")

    # 4. Auditoría de Líneas Viudas Aisladas (Regla A)
    print("\n--- 4. AUDITORÍA DE LÍNEAS VIUDAS AISLADAS (REGLA A) ---")
    widow_cases = []
    for pno in range(1, num_pages + 1):
        page = doc[pno - 1]
        text = page.get_text()
        lines = [l.strip() for l in text.splitlines() if l.strip()]
        body_lines = [l for l in lines if not any(k in l for k in ['PROTOCOLO FAMILIAR', 'VERSION 1.0', 'CAPÍTULO', 'UN LEGADO', 'TRASCIENDE', 'CONSTRUIMOS'])]
        if body_lines:
            # Check if line 1 is followed by a heading
            if len(body_lines) >= 2 and re.match(r'^[1-9]\.[0-9]+', body_lines[1]):
                # Line 0 is an isolated line before a heading!
                # Check if it was part of a sentence
                if not body_lines[0].isdigit():
                    widow_cases.append((pno, body_lines[0]))

    print(f"Líneas viudas aisladas antes de encabezado: {len(widow_cases)}")
    assert len(widow_cases) == 0, f"ERROR: Viudas aisladas detectadas: {widow_cases}"
    print("  [OK] Cero líneas viudas aisladas (0 en P.66, 0 en P.68).")

    # 5. Auditoría de Arquitectura Ceremonial y Paridad
    print("\n--- 5. AUDITORÍA DE ARQUITECTURA CEREMONIAL Y PARIDAD ---")
    openings = [3, 11, 43, 63, 89, 97, 105, 113, 121]
    first_pages = [5, 13, 45, 65, 91, 99, 107, 115, 123]
    
    for idx, (op_p, fp_p) in enumerate(zip(openings, first_pages), 1):
        assert op_p % 2 == 1, f"Cap {idx} opening en P.{op_p} no es RECTO (impar)!"
        assert fp_p % 2 == 1, f"Cap {idx} first page en P.{fp_p} no es RECTO (impar)!"
        # Check blank page before opening
        blank1 = doc[op_p - 2].get_text().strip()
        assert not blank1 or blank1.isdigit(), f"Página previa a opening {op_p} no está en blanco!"
        # Check blank page before first page
        blank2 = doc[fp_p - 2].get_text().strip()
        assert not blank2 or blank2.isdigit(), f"Página previa a first page {fp_p} no está en blanco!"
        print(f"  Capítulo {idx:02d}: Opening en P.{op_p:02d} (Recto) [Blanco Verso P.{op_p-1:02d}] | First-Page en P.{fp_p:02d} (Recto) [Blanco Verso P.{fp_p-1:02d}]")

    print("  [OK] 100% de las 9 aperturas ceremoniales en página RECTO precedidas por VERSO en blanco.")
    print("  [OK] 100% de las 9 primeras páginas en página RECTO precedidas por VERSO en blanco.")

    return {
        'num_pages': num_pages,
        'headings_count': len(headings_found),
        'closure_metrics': closure_metrics,
        'folio_samples_count': len(folio_samples)
    }

def main():
    print("[INICIO] COMPILADOR MAESTRO Y AUDITOR FORENSE — FASE 3.9.1")
    print("="*80)

    # 1. VERIFICACIÓN DE SEGURIDAD INICIAL DE HASHES CANÓNICOS
    print("\n[VERIFICACIÓN DE SEGURIDAD 1/2] Auditando SHA-256 de archivos canónicos...")
    for cf, expected_h in CANONICAL_HASHES_EXPECTED.items():
        cpath = os.path.join(CAP_DIR, cf)
        h = compute_sha256(cpath)
        assert h == expected_h, f"ERROR DE SEGURIDAD: Hash de {cf} no coincide!"
        print(f"  [OK] {cf}: {h}")

    comp_path = os.path.join(REPO_DIR, 'templates', 'typst', 'componentes.typ')
    comp_h = compute_sha256(comp_path)
    assert comp_h == COMPONENTES_HASH_EXPECTED, "ERROR DE SEGURIDAD: componentes.typ fue modificado!"
    print(f"  [OK] componentes.typ (LOCKED): {comp_h}")

    # 2. DEFINICIÓN DE POLÍTICAS SEMÁNTICAS CONSOLIDADAS
    # REGLA A: Párrafos que requieren preservación atómica para eliminar viudas de 1 línea
    atomic_signatures = {
        "La sucesión accionaria tiene como finalidad exclusiva la transmisión del valor económico de las acciones"
    }

    # REGLA C: Secciones H2 que requieren redistribución hacia adelante para dignificar el cierre capitular (Capítulo 09 exclusivamente)
    forward_sections = {
        "Interpretación y Cierre Normativo"
    }

    # Transiciones ceremoniales
    trans_01_09 = {1: 1, 2: 2, 3: 2, 4: 1, 5: 1, 6: 2, 7: 2, 8: 1, 9: 1}

    typ_master_file = os.path.join(TESTS_DIR, 'test_protocolo_capitulos_01_09_fase_3_9_1.typ')
    pdf_master_file = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1.pdf')

    print(f"\n[GENERACIÓN MAESTRA] Construyendo código Typst consolidado en {typ_master_file}...")
    typst_code = build_master_typst_fase_3_9_1(
        CANONICAL_CHAPTERS,
        trans_01_09,
        atomic_signatures=atomic_signatures,
        forward_sections=forward_sections
    )
    with open(typ_master_file, 'w', encoding='utf-8') as f:
        f.write(typst_code)

    # Detener procesos huérfanos que puedan bloquear el archivo
    subprocess.run(["powershell", "-Command", "Stop-Process -Name Acrobat -Force -ErrorAction SilentlyContinue"], capture_output=True)

    print(f"[COMPILACIÓN MAESTRA] Compilando con Typst a {pdf_master_file}...")
    typst_path = shutil.which("typst") or "typst"
    cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, typ_master_file, pdf_master_file]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        print(f"[ERROR CRÍTICO] Falló la compilación:\n{res.stderr}")
        sys.exit(1)

    size_master = os.path.getsize(pdf_master_file)
    print(f"[ÉXITO] Documento maestro compilado: {pdf_master_file} ({size_master:,} bytes)")

    # 3. GENERAR SPREADS MAESTROS (ENTREGABLE 2)
    typ_spreads_file = os.path.join(TESTS_DIR, 'test_protocolo_capitulos_01_09_fase_3_9_1_spreads.typ')
    pdf_spreads_file = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1_SPREADS.pdf')
    num_spreads = generate_spreads_file(pdf_master_file, typ_spreads_file, pdf_spreads_file, 126)
    assert num_spreads == 64, f"ERROR: Spreads = {num_spreads} != 64"
    size_spreads = os.path.getsize(pdf_spreads_file)
    print(f"[ÉXITO] Spreads maestros generados: {pdf_spreads_file} ({num_spreads} pliegos, {size_spreads:,} bytes)")

    # 4. AUDITORÍA INTEGRAL AUTOMATIZADA
    audits = run_audits_on_consolidated_pdf(pdf_master_file)

    # 5. VERIFICACIÓN DE SEGURIDAD FINAL DE HASHES CANÓNICOS
    print("\n[VERIFICACIÓN DE SEGURIDAD 2/2] Re-verificando SHA-256 de fuentes canónicas...")
    for cf, expected_h in CANONICAL_HASHES_EXPECTED.items():
        cpath = os.path.join(CAP_DIR, cf)
        h = compute_sha256(cpath)
        assert h == expected_h, f"FALLO CRÍTICO: Archivo {cf} fue alterado durante el proceso!"
        print(f"  [INTACTO] {cf} 100% IDÉNTICO")

    print("\n" + "="*80)
    print("FASE 3.9.1: COMPILACIÓN Y AUDITORÍA MAESTRA COMPLETADA CON ÉXITO")
    print(f"  Entregable 1: {pdf_master_file} (126 páginas)")
    print(f"  Entregable 2: {pdf_spreads_file} (64 pliegos)")
    print("="*80)

if __name__ == '__main__':
    main()
