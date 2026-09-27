"""
CALIBRACIÓN DE RESPIRACIÓN EN CHAPTER-FIRST-PAGE
Fase 3.7.2 - Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

Genera:
1. dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_CURRENT.pdf (1 página: Cap 01 actual)
2. dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_6MM.pdf (1 página: Cap 01 con +6 mm)
3. dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_COMPARISON.pdf (Spread 792x612 pt lado a lado: ACTUAL | +6 MM)
4. dist/TEST_CHAPTER_FIRST_PAGE_01_03_6MM.pdf (3 páginas: Cap 01, Cap 02, Cap 03 con +6 mm)
5. Renders a 150 DPI para inspección visual en artefactos.
"""

import os
import sys
import subprocess
import shutil
import fitz

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
SCRATCH_DIR = os.path.join(REPO_DIR, 'scratch')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
from pathlib import Path
ARTIFACT_DIR = os.environ.get("ANTIGRAVITY_ARTIFACTS_DIR") or str(Path.home() / ".gemini" / "antigravity-cli" / "brain" / "44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2")

os.makedirs(DIST_DIR, exist_ok=True)
os.makedirs(TESTS_DIR, exist_ok=True)
os.makedirs(SCRATCH_DIR, exist_ok=True)

DELTA_6MM_PT = 6.0 * (72.0 / 25.4) # 17.007874 pt ≈ 17.01 pt

def build_full_ceremonial_6mm_pdf():
    # Leer el archivo maestro ceremonial de Fase 3.7.1
    ceremonial_typ_path = os.path.join(TESTS_DIR, 'test_capitulos_01_03_ceremonial.typ')
    with open(ceremonial_typ_path, 'r', encoding='utf-8') as f:
        code = f.read()

    # Reemplazar las coordenadas del bloque de chapter-first-page por las desplazadas +17.0079 pt
    # Coordenadas base en test_capitulos_01_03_ceremonial.typ:
    # dy: 28pt -> dy: (28 + 17.0079)pt = 45.0079pt
    # dy: 74.95pt -> dy: (74.95 + 17.0079)pt = 91.9579pt
    # dy: 98.30pt -> dy: (98.30 + 17.0079)pt = 115.3079pt
    # v(177.80pt) -> v(194.8079pt)
    # v(225.81pt) -> v(242.8179pt)
    code_6mm = code.replace('dy: 28pt', f'dy: {28.00 + DELTA_6MM_PT:.4f}pt')
    code_6mm = code_6mm.replace('dy: 74.95pt', f'dy: {74.95 + DELTA_6MM_PT:.4f}pt')
    code_6mm = code_6mm.replace('dy: 98.30pt', f'dy: {98.30 + DELTA_6MM_PT:.4f}pt')
    code_6mm = code_6mm.replace('v(177.80pt)', f'v({177.80 + DELTA_6MM_PT:.4f}pt)')
    code_6mm = code_6mm.replace('v(225.81pt)', f'v({225.81 + DELTA_6MM_PT:.4f}pt)')

    temp_typ = os.path.join(SCRATCH_DIR, 'test_capitulos_01_03_ceremonial_6mm.typ')
    temp_pdf = os.path.join(SCRATCH_DIR, 'test_capitulos_01_03_ceremonial_6mm.pdf')
    with open(temp_typ, 'w', encoding='utf-8') as f:
        f.write(code_6mm)

    subprocess.run(["powershell", "-Command", "Stop-Process -Name Acrobat -Force -ErrorAction SilentlyContinue"], capture_output=True)
    cmd = ['typst', 'compile', '--root', REPO_DIR, '--font-path', FONTS_DIR, temp_typ, temp_pdf]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        print(f"[OK] Documento ceremonial +6mm compilado: {temp_pdf} ({len(fitz.open(temp_pdf))} páginas)")
        return temp_pdf
    else:
        print(f"[ERROR] Error al compilar documento ceremonial +6mm:\n{res.stderr}")
        return None

def generate_deliverables(pdf_6mm_full):
    pdf_curr_full = os.path.join(DIST_DIR, 'TEST_CAPITULOS_01_03_CEREMONIAL.pdf')
    doc_curr = fitz.open(pdf_curr_full)
    doc_6mm = fitz.open(pdf_6mm_full)

    # 1. TEST_CHAPTER_FIRST_PAGE_BREATHING_CURRENT.pdf (Página 5 de TEST_CAPITULOS_01_03_CEREMONIAL.pdf)
    p_curr = os.path.join(DIST_DIR, 'TEST_CHAPTER_FIRST_PAGE_BREATHING_CURRENT.pdf')
    doc_out_curr = fitz.open()
    doc_out_curr.insert_pdf(doc_curr, from_page=4, to_page=4)
    doc_out_curr.save(p_curr)
    print(f"[OK] Generado: {p_curr} ({len(doc_out_curr)} página)")

    # 2. TEST_CHAPTER_FIRST_PAGE_BREATHING_6MM.pdf (Página 5 de ceremonial +6mm)
    p_6mm = os.path.join(DIST_DIR, 'TEST_CHAPTER_FIRST_PAGE_BREATHING_6MM.pdf')
    doc_out_6mm = fitz.open()
    doc_out_6mm.insert_pdf(doc_6mm, from_page=4, to_page=4)
    doc_out_6mm.save(p_6mm)
    print(f"[OK] Generado: {p_6mm} ({len(doc_out_6mm)} página)")

    # 3. TEST_CHAPTER_FIRST_PAGE_BREATHING_COMPARISON.pdf (Spread 792 x 612 pt)
    p_comp = os.path.join(DIST_DIR, 'TEST_CHAPTER_FIRST_PAGE_BREATHING_COMPARISON.pdf')
    comp_typ = f'''
#set page(width: 792pt, height: 612pt, margin: 0pt, fill: rgb("#ffffff"))
#grid(
  columns: (396pt, 396pt),
  image("/dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_CURRENT.pdf", page: 1, width: 396pt, height: 612pt),
  image("/dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_6MM.pdf", page: 1, width: 396pt, height: 612pt)
)
'''
    temp_comp_typ = os.path.join(SCRATCH_DIR, 'test_first_page_comparison.typ')
    with open(temp_comp_typ, 'w', encoding='utf-8') as f:
        f.write(comp_typ)

    cmd = ['typst', 'compile', '--root', REPO_DIR, '--font-path', FONTS_DIR, temp_comp_typ, p_comp]
    subprocess.run(cmd, capture_output=True, text=True)
    print(f"[OK] Generado: {p_comp} ({os.path.getsize(p_comp)/1024:.1f} KB)")

    # 4. TEST_CHAPTER_FIRST_PAGE_01_03_6MM.pdf (3 páginas: Cap 01 P.5, Cap 02 P.11, Cap 03 P.39)
    p_01_03 = os.path.join(DIST_DIR, 'TEST_CHAPTER_FIRST_PAGE_01_03_6MM.pdf')
    doc_out_all = fitz.open()
    # Pág 5 (0-indexed 4), Pág 11 (0-indexed 10), Pág 39 (0-indexed 38)
    doc_out_all.insert_pdf(doc_6mm, from_page=4, to_page=4)
    doc_out_all.insert_pdf(doc_6mm, from_page=10, to_page=10)
    doc_out_all.insert_pdf(doc_6mm, from_page=38, to_page=38)
    doc_out_all.save(p_01_03)
    print(f"[OK] Generado: {p_01_03} ({len(doc_out_all)} páginas: Cap 01, Cap 02, Cap 03)")

    # 5. Renderizar PNGs a 150 DPI
    # a) Spread comparativo
    doc_cp = fitz.open(p_comp)
    pix_cp = doc_cp[0].get_pixmap(dpi=150)
    pix_cp.save(os.path.join(DIST_DIR, 'first_page_breathing_comparison.png'))
    pix_cp.save(os.path.join(ARTIFACT_DIR, 'first_page_breathing_comparison.png'))
    print(f"[OK] Renderizado spread comparativo PNG")

    # b) Páginas individuales de TEST_CHAPTER_FIRST_PAGE_01_03_6MM.pdf
    doc_all = fitz.open(p_01_03)
    labels = ['first_page_cap01_6mm.png', 'first_page_cap02_6mm.png', 'first_page_cap03_6mm.png']
    for p_idx, page in enumerate(doc_all):
        pix = page.get_pixmap(dpi=150)
        pix.save(os.path.join(DIST_DIR, labels[p_idx]))
        pix.save(os.path.join(ARTIFACT_DIR, labels[p_idx]))
        print(f"[OK] Renderizado {labels[p_idx]}")

    # c) Página actual Cap 01
    pix_curr = doc_curr[4].get_pixmap(dpi=150)
    pix_curr.save(os.path.join(DIST_DIR, 'first_page_cap01_current.png'))
    pix_curr.save(os.path.join(ARTIFACT_DIR, 'first_page_cap01_current.png'))
    print(f"[OK] Renderizado first_page_cap01_current.png")

if __name__ == '__main__':
    full_6mm = build_full_ceremonial_6mm_pdf()
    if full_6mm:
        generate_deliverables(full_6mm)
