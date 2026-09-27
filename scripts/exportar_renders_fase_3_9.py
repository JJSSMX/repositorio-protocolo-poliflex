import os
import pymupdf

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIST_DIR = os.path.join(REPO_DIR, 'dist')
SCRATCH_DIR = os.path.join(REPO_DIR, 'scratch')
BRAIN_DIR = r"C:\Users\JJSS\.gemini\antigravity-cli\brain\44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2"

target_dirs = [SCRATCH_DIR]
if os.path.exists(BRAIN_DIR):
    target_dirs.append(BRAIN_DIR)

# 1. Contact Sheet renders
cs_pdf = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09_CONTACT_SHEET.pdf')
if os.path.exists(cs_pdf):
    doc_cs = pymupdf.open(cs_pdf)
    mat_cs = pymupdf.Matrix(150 / 72.0, 150 / 72.0)
    for pno in [1, 4, 7]:
        if pno <= len(doc_cs):
            pix = doc_cs[pno - 1].get_pixmap(matrix=mat_cs, alpha=False)
            fname = f"contact_sheet_hoja_{pno:02d}.png"
            for d in target_dirs:
                pix.save(os.path.join(d, fname))
            print(f"[RENDER] Contact Sheet Hoja {pno:02d} -> {fname}")

# 2. Spreads renders
spreads_pdf = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf')
if os.path.exists(spreads_pdf):
    doc_sp = pymupdf.open(spreads_pdf)
    mat_sp = pymupdf.Matrix(150 / 72.0, 150 / 72.0)
    
    # Pliego indices (0-indexed):
    # Pliego 32 (idx 31): P.62|P.63 (Opening 04)
    # Pliego 33 (idx 32): P.64|P.65 (First Page 04)
    # Pliego 45 (idx 44): P.88|P.89 (Opening 05)
    # Pliego 46 (idx 45): P.90|P.91 (First Page 05)
    # Pliego 61 (idx 60): P.120|P.121 (Opening 09)
    # Pliego 62 (idx 61): P.122|P.123 (First Page 09)
    # Pliego 64 (idx 63): P.126|VACÍO (Cierre Protocolo)
    spread_renders = [
        (31, "spread_32_opening_cap04.png"),
        (32, "spread_33_firstpage_cap04.png"),
        (44, "spread_45_opening_cap05.png"),
        (45, "spread_46_firstpage_cap05.png"),
        (60, "spread_61_opening_cap09.png"),
        (61, "spread_62_firstpage_cap09.png"),
        (63, "spread_64_conclusion_protocolo.png")
    ]
    for s_idx, s_fname in spread_renders:
        if s_idx < len(doc_sp):
            pix = doc_sp[s_idx].get_pixmap(matrix=mat_sp, alpha=False)
            for d in target_dirs:
                pix.save(os.path.join(d, s_fname))
            print(f"[RENDER] Pliego {s_idx+1:02d} -> {s_fname}")

# 3. Individual Pages renders
master_pdf = os.path.join(DIST_DIR, 'TEST_PROTOCOLO_CAPITULOS_01_09.pdf')
if os.path.exists(master_pdf):
    doc_m = pymupdf.open(master_pdf)
    mat_m = pymupdf.Matrix(200 / 72.0, 200 / 72.0)
    page_renders = [
        (63, "page_63_opening_cap04.png"),
        (65, "page_65_firstpage_cap04.png"),
        (89, "page_89_opening_cap05.png"),
        (91, "page_91_firstpage_cap05.png"),
        (97, "page_97_opening_cap06.png"),
        (99, "page_99_firstpage_cap06.png"),
        (105, "page_105_opening_cap07.png"),
        (107, "page_107_firstpage_cap07.png"),
        (113, "page_113_opening_cap08.png"),
        (115, "page_115_firstpage_cap08.png"),
        (121, "page_121_opening_cap09.png"),
        (123, "page_123_firstpage_cap09.png")
    ]
    for pno, pfname in page_renders:
        if pno <= len(doc_m):
            pix = doc_m[pno - 1].get_pixmap(matrix=mat_m, alpha=False)
            for d in target_dirs:
                pix.save(os.path.join(d, pfname))
            print(f"[RENDER] Página {pno:02d} -> {pfname}")
