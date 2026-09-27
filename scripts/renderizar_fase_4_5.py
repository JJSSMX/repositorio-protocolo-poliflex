import os
import shutil
import pymupdf
from PIL import Image, ImageDraw, ImageFont

from pathlib import Path
WORKSPACE_ROOT = str(Path(__file__).resolve().parent.parent)
ARTIFACT_DIR = os.environ.get("ANTIGRAVITY_ARTIFACTS_DIR") or str(Path.home() / ".gemini" / "antigravity-cli" / "brain" / "44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2")
DIST_DIR = os.path.join(WORKSPACE_ROOT, "dist")

os.makedirs(DIST_DIR, exist_ok=True)
os.makedirs(ARTIFACT_DIR, exist_ok=True)

font_title = ImageFont.truetype(os.path.join(WORKSPACE_ROOT, "assets/fonts/NeuzeitGro-Reg.ttf"), 28)
font_subtitle = ImageFont.truetype(os.path.join(WORKSPACE_ROOT, "assets/fonts/NeuzeitGro-Reg.ttf"), 18)
font_col = ImageFont.truetype(os.path.join(WORKSPACE_ROOT, "assets/fonts/NeuzeitGro-Reg.ttf"), 20)
font_spread = ImageFont.truetype(os.path.join(WORKSPACE_ROOT, "assets/fonts/NeuzeitGro-Reg.ttf"), 22)

# 1. Renderizar páginas individuales de Variante A, B, C a 300 DPI
variants = ["A", "B", "C"]
rendered_images = {}

zoom = 300 / 72 # 300 DPI
mat = pymupdf.Matrix(zoom, zoom)

for v in variants:
    pdf_path = os.path.join(DIST_DIR, f"TEST_REGULATION_PAGE_FASE_4_5_{v}.pdf")
    doc = pymupdf.open(pdf_path)
    rendered_images[v] = []
    for p_idx in range(len(doc)):
        page = doc[p_idx]
        pix = page.get_pixmap(matrix=mat, alpha=False)
        img_name = f"regulation_page_var_{v.lower()}_p{p_idx+1}.png"
        img_dist = os.path.join(DIST_DIR, img_name)
        img_art = os.path.join(ARTIFACT_DIR, img_name)
        pix.save(img_dist)
        shutil.copy2(img_dist, img_art)
        rendered_images[v].append(img_dist)
        print(f"Renderizado: {img_name} ({pix.width}x{pix.height})")

# 2. Renderizar interior-page() LOCKED (Página 7 de Capítulos 01-09)
master_pdf = os.path.join(DIST_DIR, "TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_3.pdf")
doc_master = pymupdf.open(master_pdf)
pix_master = doc_master[6].get_pixmap(matrix=mat, alpha=False) # Página 7 (índice 6)
locked_dist = os.path.join(DIST_DIR, "interior_page_locked_ref.png")
locked_art = os.path.join(ARTIFACT_DIR, "interior_page_locked_ref.png")
pix_master.save(locked_dist)
shutil.copy2(locked_dist, locked_art)
print("Renderizado: interior_page_locked_ref.png")

# 3. Generar Spreads (P2 Verso + P3 Recto) a 180 DPI
spread_zoom = 180 / 72
spread_mat = pymupdf.Matrix(spread_zoom, spread_zoom)

spread_titles = {
    "A": "FASE 4.5 · VARIANTE A (CLÁSICA INSTITUCIONAL) — SPREAD PÁGINAS 02 (VERSO) Y 03 (RECTO)",
    "B": "FASE 4.5 · VARIANTE B (DIFERENCIACIÓN JURÍDICA DINÁMICA) — SPREAD PÁGINAS 02 (VERSO) Y 03 (RECTO)",
    "C": "FASE 4.5 · VARIANTE C (SOBERANÍA NORMATIVA COMPACTA) — SPREAD PÁGINAS 02 (VERSO) Y 03 (RECTO)"
}

for v in variants:
    pdf_path = os.path.join(DIST_DIR, f"TEST_REGULATION_PAGE_FASE_4_5_{v}.pdf")
    doc = pymupdf.open(pdf_path)
    pix_p2 = doc[1].get_pixmap(matrix=spread_mat, alpha=False)
    pix_p3 = doc[2].get_pixmap(matrix=spread_mat, alpha=False)
    
    img_p2 = Image.frombytes("RGB", [pix_p2.width, pix_p2.height], pix_p2.samples)
    img_p3 = Image.frombytes("RGB", [pix_p3.width, pix_p3.height], pix_p3.samples)
    
    gutter = 24
    header_h = 70
    w = img_p2.width + gutter + img_p3.width + 50
    h = img_p2.height + header_h + 40
    
    spread = Image.new("RGB", (w, h), (245, 245, 245))
    draw = ImageDraw.Draw(spread)
    
    # Título del spread
    draw.text((25, 25), spread_titles[v], fill=(46, 47, 49), font=font_spread)
    
    # Pegar páginas
    spread.paste(img_p2, (25, header_h + 15))
    spread.paste(img_p3, (25 + img_p2.width + gutter, header_h + 15))
    
    # Bordes sutiles
    draw.rectangle([24, header_h + 14, 25 + img_p2.width, header_h + 15 + img_p2.height], outline=(200, 200, 200), width=1)
    draw.rectangle([25 + img_p2.width + gutter - 1, header_h + 14, 25 + img_p2.width + gutter + img_p3.width, header_h + 15 + img_p3.height], outline=(200, 200, 200), width=1)
    
    spread_name = f"spread_fase_4_5_var_{v.lower()}.png"
    spread_dist = os.path.join(DIST_DIR, spread_name)
    spread_art = os.path.join(ARTIFACT_DIR, spread_name)
    spread.save(spread_dist)
    shutil.copy2(spread_dist, spread_art)
    print(f"Spread generado: {spread_name}")

# 4. Generar Lámina Comparativa 4-Way a 150 DPI
# interior-page() LOCKED vs Variante A vs Variante B vs Variante C
comp_zoom = 150 / 72
comp_mat = pymupdf.Matrix(comp_zoom, comp_zoom)

pix_l = doc_master[6].get_pixmap(matrix=comp_mat, alpha=False)
doc_a = pymupdf.open(os.path.join(DIST_DIR, "TEST_REGULATION_PAGE_FASE_4_5_A.pdf"))
doc_b = pymupdf.open(os.path.join(DIST_DIR, "TEST_REGULATION_PAGE_FASE_4_5_B.pdf"))
doc_c = pymupdf.open(os.path.join(DIST_DIR, "TEST_REGULATION_PAGE_FASE_4_5_C.pdf"))

pix_a = doc_a[0].get_pixmap(matrix=comp_mat, alpha=False)
pix_b = doc_b[0].get_pixmap(matrix=comp_mat, alpha=False)
pix_c = doc_c[0].get_pixmap(matrix=comp_mat, alpha=False)

img_l = Image.frombytes("RGB", [pix_l.width, pix_l.height], pix_l.samples)
img_a = Image.frombytes("RGB", [pix_a.width, pix_a.height], pix_a.samples)
img_b = Image.frombytes("RGB", [pix_b.width, pix_b.height], pix_b.samples)
img_c = Image.frombytes("RGB", [pix_c.width, pix_c.height], pix_c.samples)

gap = 35
margin_top = 110
margin_side = 35
total_w = margin_side * 2 + img_l.width * 4 + gap * 3
total_h = margin_top + img_l.height + 40

canvas = Image.new("RGB", (total_w, total_h), (248, 248, 248))
draw_c = ImageDraw.Draw(canvas)

# Encabezado principal de la lámina
draw_c.text((margin_side, 25), "PROTOCOLO FAMILIAR POLIFLEX — EVALUACIÓN EDITORIAL COMPARATIVA (FASE 4.5)", fill=(46, 47, 49), font=font_title)
draw_c.text((margin_side, 65), "interior-page() LOCKED vs. regulation-page() Variantes A, B y C (Escala 1:1 · Muestra Página 1 Recto)", fill=(108, 107, 103), font=font_subtitle)

pages = [
    (img_l, "1. INTERIOR-PAGE() LOCKED (CAPÍTULO 01)", (15, 23, 42)),
    (img_a, "2. VARIANTE A (CLÁSICA INSTITUCIONAL)", (241, 93, 34)),
    (img_b, "3. VARIANTE B (DIFERENCIACIÓN JURÍDICA)", (46, 47, 49)),
    (img_c, "4. VARIANTE C (SOBERANÍA COMPACTA)", (108, 107, 103))
]

for idx, (img, label, color) in enumerate(pages):
    x = margin_side + idx * (img.width + gap)
    y = margin_top
    
    # Etiqueta de columna
    draw_c.text((x, y - 28), label, fill=color, font=font_col)
    
    # Imagen de página
    canvas.paste(img, (x, y))
    draw_c.rectangle([x - 1, y - 1, x + img.width, y + img.height], outline=(210, 210, 210), width=1)

lamina_name = "lamina_comparativa_fase_4_5_4way.png"
lamina_dist = os.path.join(DIST_DIR, lamina_name)
lamina_art = os.path.join(ARTIFACT_DIR, lamina_name)
canvas.save(lamina_dist)
shutil.copy2(lamina_dist, lamina_art)
print(f"Lámina 4-Way generada: {lamina_name} ({total_w}x{total_h})")

print("Todos los renders completados exitosamente.")
