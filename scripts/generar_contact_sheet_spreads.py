import os
import subprocess
import shutil
import pymupdf

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')

SPREADS_PDF = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf')
CS_TYP = os.path.join(TESTS_DIR, 'test_protocolo_capitulos_01_09_contact_sheet.typ')
CS_PDF = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09_CONTACT_SHEET.pdf')

doc_sp = pymupdf.open(SPREADS_PDF)
num_spreads = len(doc_sp)
print(f"Generando Contact Sheet organizado por Spreads (Verso | Recto) para {num_spreads} pliegos...")

# We will use an A3 landscape format: 1190.55 pt x 841.89 pt
# Layout: 3 columns x 4 rows = 12 spreads per A3 sheet
# Width of card ~ 340 pt, aspect ratio 792/612 = 1.294 -> Height ~ 260 pt.
# Margins: x: 1.5cm, y: 1.2cm.

# Descriptions for each spread
spread_desc = {}
# Range data:
chapter_ranges = [
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

def describe_page(pno):
    if pno is None:
        return "VACÍO"
    if pno == 1:
        return "P.01 Cortesía"
    for ch, op, fp, end in chapter_ranges:
        if pno == op:
            return f"P.{pno:02d} Opening {ch:02d}"
        if pno == fp:
            return f"P.{pno:02d} First Page {ch:02d}"
        if fp < pno <= end:
            return f"P.{pno:02d} Cap {ch:02d}"
        # blanks
        if pno == op - 1:
            return f"P.{pno:02d} Blanca Op {ch:02d}"
        if pno == fp - 1:
            return f"P.{pno:02d} Blanca FP {ch:02d}"
        if pno in [9, 41, 95, 103]:
            return f"P.{pno:02d} Blanca Transición"
    return f"P.{pno:02d}"

rel_spreads_pdf = "/" + os.path.relpath(SPREADS_PDF, REPO_DIR).replace('\\', '/')

typ = [
    '// ============================================================================== ',
    '// CONTACT SHEET — PROTOCOLO CAPÍTULOS 01–09 (ORGANIZADO POR SPREADS VERSO | RECTO)',
    '// ============================================================================== ',
    '',
    '#set page(',
    '  paper: "a3",',
    '  flipped: true,',
    '  margin: (x: 1.2cm, y: 1.0cm),',
    '  header: [',
    '    #align(center)[',
    '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8.5pt, weight: "bold", fill: rgb("#f15d22"))[',
    '        PROTOCOLO FAMILIAR POLIFLEX · CONTACT SHEET DE PLIEGOS (VERSO | RECTO)',
    '      ]',
    '      #h(12pt)',
    '      #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.0pt, fill: rgb("#6c6b67"))[',
    '        (Inspección de Ritmo, Densidad, Simetría y Aperturas · 64 Pliegos / 126 Páginas)',
    '      ]',
    '    ]',
    '  ],',
    '  footer: context [',
    '    #let p = counter(page).get().first()',
    '    #align(center)[#text(size: 7pt, fill: rgb("#6c6b67"))[Hoja #p]]',
    '  ]',
    ')',
    '',
    f'#let spreads_pdf = "{rel_spreads_pdf}"',
    '',
    '#let spread-card(s_num, v_desc, r_desc) = [',
    '  #align(center)[',
    '    #box(',
    '      stroke: 0.5pt + rgb("#cccccc"),',
    '      radius: 1pt,',
    '      fill: rgb("#ffffff"),',
    '      clip: true,',
    '      width: 172pt,',
    '      height: 132.8pt,',
    '      image(spreads_pdf, page: s_num, width: 172pt, height: 132.8pt)',
    '    )',
    '    #v(2.5pt)',
    '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 6pt, weight: "bold", fill: rgb("#f15d22"))[',
    '      Pliego #if s_num < 10 { "0" + str(s_num) } else { str(s_num) }',
    '    ]',
    '    #h(4pt)',
    '    #text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 5.5pt, fill: rgb("#2e2f31"))[',
    '      [#v_desc | #r_desc]',
    '    ]',
    '  ]',
    ']',
    ''
]

spreads_per_sheet = 8 # 4 cols x 2 rows
total_sheets = (num_spreads + spreads_per_sheet - 1) // spreads_per_sheet

for s in range(total_sheets):
    start_s = s * spreads_per_sheet + 1
    end_s = min((s + 1) * spreads_per_sheet, num_spreads)
    
    typ.append(f'// HOJA {s+1:02d}: Pliegos {start_s:02d} a {end_s:02d}')
    typ.append('#grid(')
    typ.append('  columns: (1fr, 1fr, 1fr, 1fr),')
    typ.append('  rows: (auto, auto),')
    typ.append('  row-gutter: 14pt,')
    typ.append('  column-gutter: 10pt,')
    
    for s_idx in range(start_s, end_s + 1):
        if s_idx == 1:
            v_desc = "VACÍO"
            r_desc = "P.01 Cortesía"
        else:
            verso_p = (s_idx - 1) * 2
            recto_p = verso_p + 1 if verso_p + 1 <= 126 else None
            v_desc = describe_page(verso_p)
            r_desc = describe_page(recto_p)
            
        typ.append(f'  spread-card({s_idx}, "{v_desc}", "{r_desc}"),')
        
    remaining = spreads_per_sheet - (end_s - start_s + 1)
    for _ in range(remaining):
        typ.append('  [],')
        
    typ.append(')')
    if s < total_sheets - 1:
        typ.append('#pagebreak()')
        typ.append('')

with open(CS_TYP, 'w', encoding='utf-8') as f:
    f.write("\n".join(typ))

typst_path = shutil.which("typst") or "typst"
cmd = [typst_path, "compile", "--root", REPO_DIR, "--font-path", FONTS_DIR, CS_TYP, CS_PDF]
res = subprocess.run(cmd, capture_output=True, text=True)
if res.returncode == 0:
    doc = pymupdf.open(CS_PDF)
    print(f"[ÉXITO] Contact Sheet de Spreads generado: {CS_PDF} ({len(doc)} hojas A3, {os.path.getsize(CS_PDF)} bytes)")
else:
    print(f"[ERROR] Typst falló:\n{res.stderr}")
