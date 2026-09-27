# ==============================================================================
# SCRIPT DE GENERACIÓN Y EVALUACIÓN FORENSE — FASE 4.5
# Protocolo Familiar POLIFLEX — Prototipo de Sistema Normativo Interior
# ==============================================================================

import os
import re
import json
import hashlib
import subprocess
import pymupdf

WORKSPACE_ROOT = "C:/Users/JJSS/Desktop/ABC/repositorio_protocolo"
CANONICAL_MD = os.path.join(WORKSPACE_ROOT, "capitulos/11_reglamento_asamblea_familia.md")
ARTIFACT_DIR = "C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2"

def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while chunk := f.read(8192):
            h.update(chunk)
    return h.hexdigest().upper()

# 1. Leer y estructurar el fragmento canónico exacto (Líneas 76 a 178)
with open(CANONICAL_MD, "r", encoding="utf-8") as f:
    all_lines = f.readlines()

# Líneas 76 a 178 (índice 75 a 177)
chunk_lines = all_lines[75:178]

# Estructurar elementos
elements = []
i = 0
while i < len(chunk_lines):
    line = chunk_lines[i].strip()
    orig_line_num = 76 + i
    if line.startswith("## "):
        ch_num = line[3:].strip()
        # siguiente línea no vacía es el subtítulo
        j = i + 1
        while j < len(chunk_lines) and not chunk_lines[j].strip():
            j += 1
        ch_title = chunk_lines[j].strip().strip("*")
        elements.append(("CHAPTER", orig_line_num, ch_num, ch_title))
        i = j + 1
        continue
    elif line.startswith("### "):
        m = re.match(r"###\s+(Artículo\s+\d+\.)\s+(.*)", line)
        if m:
            elements.append(("ARTICLE", orig_line_num, m.group(1), m.group(2)))
        else:
            elements.append(("ARTICLE", orig_line_num, line[4:], ""))
        i += 1
        continue
    elif any(line.startswith(x) for x in ["I.", "II.", "III.", "IV.", "V.", "VI.", "VII.", "VIII."]):
        m = re.match(r"^([I|V|X]+\.)\s+(.*)", line)
        if m:
            elements.append(("FRACTION", orig_line_num, m.group(1), m.group(2)))
        i += 1
        continue
    elif line == "**TRANSITORIO ÚNICO**":
        elements.append(("TRANSITORY", orig_line_num, "TRANSITORIO ÚNICO"))
        i += 1
        continue
    elif line:
        elements.append(("PARAGRAPH", orig_line_num, line))
        i += 1
        continue
    else:
        i += 1

print(f"Total elementos procesados: {len(elements)}")

# 2. Generar archivo Typst con la función render-corpus(variant: "A")
corpus_typ = """// ==============================================================================
// CORPUS CANÓNICO DE PRUEBA FASE 4.5
// Fuente: capitulos/11_reglamento_asamblea_familia.md (Líneas 76 a 178)
// Generado automáticamente por scripts/generar_fase_4_5.py
// ==============================================================================

#import "/templates/typst/componentes_fase_4_experimental.typ": *

#let render-corpus(variant: "A") = [
"""

for elem in elements:
    e_type = elem[0]
    line_num = elem[1]
    if e_type == "CHAPTER":
        ch_num = elem[2]
        ch_title = elem[3]
        corpus_typ += f'  // Línea {line_num}: {ch_num} - {ch_title}\n'
        corpus_typ += f'  #regulation-chapter("{ch_num}", "{ch_title}", variant: variant)\n\n'
    elif e_type == "ARTICLE":
        art_num = elem[2]
        art_name = elem[3]
        corpus_typ += f'  // Línea {line_num}: {art_num} {art_name}\n'
        corpus_typ += f'  #regulation-article("{art_num}", "{art_name}", variant: variant)\n\n'
    elif e_type == "FRACTION":
        marker = elem[2]
        body = elem[3]
        # Escapar corchetes o comillas Typst en body si es necesario
        corpus_typ += f'  #regulation-fraction("{marker}", [{body}], variant: variant)\n'
    elif e_type == "TRANSITORY":
        title = elem[2]
        corpus_typ += f'\n  // Línea {line_num}: {title}\n'
        corpus_typ += f'  #regulation-transitory(title: "{title}", variant: variant)\n\n'
    elif e_type == "PARAGRAPH":
        text_p = elem[2]
        corpus_typ += f'  {text_p}\n\n'

corpus_typ += "]\n"

corpus_path = os.path.join(WORKSPACE_ROOT, "tests/corpus_fase_4_5.typ")
with open(corpus_path, "w", encoding="utf-8") as f:
    f.write(corpus_typ)
print("Archivo tests/corpus_fase_4_5.typ generado exitosamente.")

# 3. Generar archivos de prueba individuales para Variante A, B, C
def make_test_file(variant_letter):
    return f"""// ==============================================================================
// TEST REGULATION PAGE FASE 4.5 — VARIANTE {variant_letter}
// Protocolo Familiar POLIFLEX
// ==============================================================================

#import "/templates/typst/componentes_fase_4_experimental.typ": *
#import "/tests/corpus_fase_4_5.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#show: body => regulation-page(
  cfg,
  variant: "{variant_letter}",
  reg_name: "ASAMBLEA DE FAMILIA",
  body
)

#render-corpus(variant: "{variant_letter}")
"""

variants = ["A", "B", "C"]
for v in variants:
    path = os.path.join(WORKSPACE_ROOT, f"tests/test_regulation_page_fase_4_5_{v.lower()}.typ")
    with open(path, "w", encoding="utf-8") as f:
        f.write(make_test_file(v))
    print(f"Archivo tests/test_regulation_page_fase_4_5_{v.lower()}.typ generado.")

# 4. Generar archivo comparativo multipágina
comparativo_typ = """// ==============================================================================
// TEST REGULATION PAGE FASE 4.5 — COMPARATIVO MULTIPÁGINA
// Comparación entre interior-page() LOCKED y Variantes A, B, C
// Protocolo Familiar POLIFLEX
// ==============================================================================

#import "/templates/typst/componentes_fase_4_experimental.typ": *
#import "/tests/corpus_fase_4_5.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

// ------------------------------------------------------------------------------
// SECCIÓN 1: VARIANTE A (Clásica Institucional)
// ------------------------------------------------------------------------------
#regulation-page(cfg, variant: "A", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "A")
]

#pagebreak()

// ------------------------------------------------------------------------------
// SECCIÓN 2: VARIANTE B (Diferenciación Jurídica Dinámica)
// ------------------------------------------------------------------------------
#regulation-page(cfg, variant: "B", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "B")
]

#pagebreak()

// ------------------------------------------------------------------------------
// SECCIÓN 3: VARIANTE C (Soberanía Normativa Compacta)
// ------------------------------------------------------------------------------
#regulation-page(cfg, variant: "C", reg_name: "ASAMBLEA DE FAMILIA")[
  #render-corpus(variant: "C")
]
"""

with open(os.path.join(WORKSPACE_ROOT, "tests/test_regulation_page_fase_4_5_comparativo.typ"), "w", encoding="utf-8") as f:
    f.write(comparativo_typ)
print("Archivo tests/test_regulation_page_fase_4_5_comparativo.typ generado.")

# 5. Compilar los PDFs
os.makedirs(os.path.join(WORKSPACE_ROOT, "dist"), exist_ok=True)
pdf_results = {}

for v in variants:
    typ_file = os.path.join(WORKSPACE_ROOT, f"tests/test_regulation_page_fase_4_5_{v.lower()}.typ")
    pdf_file = os.path.join(WORKSPACE_ROOT, f"dist/TEST_REGULATION_PAGE_FASE_4_5_{v}.pdf")
    res = subprocess.run(["typst", "compile", "--root", WORKSPACE_ROOT, "--font-path", "assets/fonts", typ_file, pdf_file], capture_output=True, text=True)
    if res.returncode != 0:
        print(f"Error compilando Variante {v}: {res.stderr}")
    else:
        doc = pymupdf.open(pdf_file)
        pdf_results[v] = {
            "path": pdf_file,
            "pages": len(doc),
            "size": os.path.getsize(pdf_file)
        }
        print(f"Variante {v} compilada exitosamente: {len(doc)} páginas ({os.path.getsize(pdf_file)} bytes).")

comp_typ = os.path.join(WORKSPACE_ROOT, "tests/test_regulation_page_fase_4_5_comparativo.typ")
comp_pdf = os.path.join(WORKSPACE_ROOT, "dist/TEST_REGULATION_PAGE_FASE_4_5_COMPARATIVO.pdf")
res_comp = subprocess.run(["typst", "compile", "--root", WORKSPACE_ROOT, "--font-path", "assets/fonts", comp_typ, comp_pdf], capture_output=True, text=True)
if res_comp.returncode != 0:
    print(f"Error compilando Comparativo: {res_comp.stderr}")
else:
    doc_comp = pymupdf.open(comp_pdf)
    print(f"Comparativo compilado exitosamente: {len(doc_comp)} páginas ({os.path.getsize(comp_pdf)} bytes).")

print("Generación completada. Procediendo a análisis métrico y renders...")
