"""
MOTOR EDITORIAL PRINCIPAL: TYPST
Compilador reproducible que toma la fuente canónica /capitulos/*.md,
aplica la configuración central de config/editorial_config.yaml,
utiliza el sistema de componentes reutilizables /templates/typst/componentes.typ,
genera el documento Typst maestro y compila el PDF de alta fidelidad.
"""

import os
import sys
import re
import yaml
import subprocess
import shutil

sys.stdout.reconfigure(encoding='utf-8')

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
CONFIG_FILE = os.path.join(REPO_DIR, 'config', 'editorial_config.yaml')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
TYPST_OUT = os.path.join(REPO_DIR, 'templates', 'typst', 'protocolo_generado.typ')
DIST_PDF = os.path.join(REPO_DIR, 'dist', 'PROTOCOLO_FAMILIAR_POLIFLEX_TYPST.pdf')

def find_typst():
    typst_path = shutil.which("typst")
    if typst_path:
        return typst_path
        
    winget_paths = [
        os.path.expandvars(r"%LOCALAPPDATA%\Microsoft\WinGet\Packages\Typst.Typst_Microsoft.Winget.Source_8wekyb3d8bbwe\typst-x86_64-pc-windows-msvc\typst.exe"),
        os.path.expandvars(r"%LOCALAPPDATA%\Microsoft\WinGet\Links\typst.exe")
    ]
    for p in winget_paths:
        if os.path.exists(p):
            return p
            
    return None

def md_inline_to_typst(text):
    text = text.replace('$', '\\$').replace('@', '\\@')
    text = text.replace('☐', '#sym.square ')
    
    # Use #strong and #emph to completely eliminate underscore / asterisk collisions
    text = re.sub(r'\*\*\*(.*?)\*\*\*', r'#strong[#emph[\1]]', text)
    text = re.sub(r'\*\*(.*?)\*\*', r'#strong[\1]', text)
    text = re.sub(r'(?<!\*)\*(?!\*)(.*?)(?<!\*)\*(?!\*)', r'#emph[\1]', text)
    
    # Escape literal underscores from fill-in blanks
    text = text.replace('_', '\\_')
    return text

def parse_markdown_table_to_typst(md_lines):
    rows = []
    for line in md_lines:
        line_clean = line.strip()
        if not line_clean.startswith('|'):
            continue
        cells = [c.strip() for c in line_clean.split('|')[1:-1]]
        if all(re.match(r'^:?-+:?$', c) for c in cells):
            continue
        rows.append(cells)
        
    if not rows:
        return ""
        
    num_cols = len(rows[0])
    col_spec = ", ".join(["1fr"] * num_cols)
    
    typst_lines = [
        "#align(center)[",
        f"#table(",
        f"  columns: ({col_spec}),",
        f"  fill: (col, row) => if row == 0 {{ rgb(\"f1f5f9\") }} else if calc.even(row) {{ rgb(\"f8fafc\") }} else {{ none }},",
        f"  stroke: (x, y) => if y == 0 {{ (bottom: 1.2pt + rgb(\"0284c7\"), rest: 0.5pt + rgb(\"cbd5e1\")) }} else {{ 0.5pt + rgb(\"cbd5e1\") }},",
        f"  align: (col, row) => if row == 0 {{ center + horizon }} else {{ left + horizon }},",
        "  table.header("
    ]
    header_cells = [f"    [#strong[{md_inline_to_typst(c)}]]" for c in rows[0]]
    typst_lines.append(",\n".join(header_cells))
    typst_lines.append("  ),")
    
    body_cells = []
    for r in rows[1:]:
        padded = r + [""] * (num_cols - len(r))
        for c in padded[:num_cols]:
            c_typst = md_inline_to_typst(c).replace('<br>', ' \\ ')
            body_cells.append(f"  [{c_typst}]")
            
    typst_lines.append(",\n".join(body_cells))
    typst_lines.append(")")
    typst_lines.append("]\n")
    return "\n".join(typst_lines)

def build_typst_document():
    with open(CONFIG_FILE, 'r', encoding='utf-8') as f:
        cfg = yaml.safe_load(f)
        
    typst_src = [
        "// ==============================================================================",
        "// DOCUMENTO MAESTRO GENERADO POR EL MOTOR EDITORIAL TYPST",
        "// FUENTE CANÓNICA: /capitulos/*.md",
        "// ==============================================================================",
        "",
        "#import \"/templates/typst/componentes.typ\": *",
        "",
        "#let cfg = yaml(\"/config/editorial_config.yaml\")",
        "",
        "#show: doc => setup-protocolo(cfg, doc)",
        "",
        "// PORTADA GENERAL",
        "#cover-page(cfg)",
        ""
    ]
    
    chapter_files = sorted([f for f in os.listdir(CAP_DIR) if f.endswith('.md')])
    
    for cfile in chapter_files:
        cpath = os.path.join(CAP_DIR, cfile)
        with open(cpath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            
        fm_lines = []
        in_frontmatter = False
        content_lines = []
        for line in lines:
            if line.strip() == '---':
                in_frontmatter = not in_frontmatter
                continue
            if in_frontmatter:
                fm_lines.append(line)
            else:
                content_lines.append(line)
                
        fm = yaml.safe_load("".join(fm_lines)) if fm_lines else {}
                
        if cfile == '00_portada_e_indice.md':
            typst_src.append("#table-of-contents(cfg)")
            continue

        idx = 0
        while idx < len(content_lines):
            line = content_lines[idx].strip()
            if not line:
                idx += 1
                continue
                
            if line.startswith('|'):
                tbl_lines = []
                while idx < len(content_lines) and content_lines[idx].strip().startswith('|'):
                    tbl_lines.append(content_lines[idx])
                    idx += 1
                typst_src.append(parse_markdown_table_to_typst(tbl_lines))
                continue
                
            if line.startswith('#### '):
                title = line[5:].strip()
                typst_src.append(f"#subsubsection-heading([{md_inline_to_typst(title)}])")
            elif line.startswith('### '):
                title = line[4:].strip()
                typst_src.append(f"#subsection-heading([{md_inline_to_typst(title)}])")
            elif line.startswith('## '):
                title = line[3:].strip()
                typst_src.append(f"#section-heading([{md_inline_to_typst(title)}])")
            elif line.startswith('# '):
                title = line[2:].strip()
                if 'Anexo' in title or 'Reglamento' in title:
                    typst_src.append(f"#annex-opening(\"ANEXO / REGLAMENTO\", [{md_inline_to_typst(title)}])")
                else:
                    ch_num = fm.get('chapter_number', '01')
                    ch_title = fm.get('title', title)
                    ch_opening = fm.get('opening_title', None)
                    ch_desc = fm.get('description', '')
                    if ch_opening:
                        opening_code = f"eval(\"[\" + {repr(ch_opening)}.join(\" \\\\ \") + \"]\")"
                        desc_code = f"eval(\"[\" + {repr(ch_desc)} + \"]\")"
                        typst_src.append(f"#chapter-opening(cfg, number: \"{ch_num}\", title: [{md_inline_to_typst(ch_title)}], opening_title: {opening_code}, description: {desc_code}, is_recto: true)")
                    else:
                        typst_src.append(f"#chapter-opening(cfg, number: \"{ch_num}\", title: [{md_inline_to_typst(ch_title)}], is_recto: true)")
            # Legal Numbering: a), b), c)
            elif re.match(r'^[a-z]\)\s+', line):
                m = re.match(r'^([a-z]\))\s+(.*)', line)
                prefix = m.group(1)
                body_txt = m.group(2)
                typst_src.append(f"#legal-item(\"{prefix}\", [{md_inline_to_typst(body_txt)}], kind: \"alpha\")")
            # Legal Sub-incisos: i., ii., iii.
            elif re.match(r'^[ivxlcdm]+\.\s+', line):
                m = re.match(r'^([ivxlcdm]+\.)\s+(.*)', line)
                prefix = m.group(1)
                body_txt = m.group(2)
                typst_src.append(f"#legal-item(\"{prefix}\", [{md_inline_to_typst(body_txt)}], kind: \"roman-lower\")")
            # Legal Fractions: I., II., III.
            elif re.match(r'^[IVXLCDM]+\.\s+', line):
                m = re.match(r'^([IVXLCDM]+\.)\s+(.*)', line)
                prefix = m.group(1)
                body_txt = m.group(2)
                typst_src.append(f"#legal-item(\"{prefix}\", [{md_inline_to_typst(body_txt)}], kind: \"roman-upper\")")
            # Decimal procedural: 1., 2., 3.
            elif re.match(r'^\d+\.\s+[A-ZÁÉÍÓÚ]', line) and not re.match(r'^\d+\.\d+', line):
                m = re.match(r'^(\d+\.)\s+(.*)', line)
                prefix = m.group(1)
                body_txt = m.group(2)
                typst_src.append(f"#legal-item(\"{prefix}\", [{md_inline_to_typst(body_txt)}], kind: \"decimal\")")
            # Standard bullet list
            elif line.startswith('- '):
                body_txt = line[2:].strip()
                typst_src.append(f"- {md_inline_to_typst(body_txt)}")
            # Ordinary paragraph
            else:
                typst_src.append(f"{md_inline_to_typst(line)}\n")
                
            idx += 1
            
    with open(TYPST_OUT, 'w', encoding='utf-8') as f:
        f.write("\n".join(typst_src))
        
    print(f"[OK] Archivo Typst generado: {TYPST_OUT}")
    return TYPST_OUT

def compile_typst():
    typst_exe = find_typst()
    if not typst_exe:
        print("[ERROR] Typst CLI no encontrado en PATH ni en AppData.")
        return False
        
    print(f"[INFO] Compilador Typst: {typst_exe}")
    build_typst_document()
    
    os.makedirs(os.path.dirname(DIST_PDF), exist_ok=True)
    cmd = [
        typst_exe,
        "compile",
        "--root", REPO_DIR,
        "--font-path", FONTS_DIR,
        TYPST_OUT,
        DIST_PDF
    ]
    
    print(f"[INFO] Compilando PDF: {DIST_PDF} ...")
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        size_kb = os.path.getsize(DIST_PDF) / 1024
        print(f"[ÉXITO] PDF compilado con Typst: {DIST_PDF} ({size_kb:.1f} KB)")
        return True
    else:
        print(f"[ERROR] Typst falló:\n{res.stderr}")
        return False

if __name__ == "__main__":
    compile_typst()
