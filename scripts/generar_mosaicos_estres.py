"""
GENERADOR DE MOSAICOS Y HOJAS DE CONTACTO DE DIAGNÓSTICO
Fase 3.7 - Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
Renderiza todas las páginas a 150 DPI y compone hojas de contacto
para inspección editorial visual.
"""

import os
import sys
import fitz
from PIL import Image, ImageDraw, ImageFont
import shutil

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PDF_PATH = os.path.join(REPO_DIR, 'dist', 'TEST_CAPITULOS_01_03_COMPLETOS.pdf')
SPREADS_PDF = os.path.join(REPO_DIR, 'dist', 'TEST_CAPITULOS_01_03_SPREADS.pdf')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
SCRATCH_DIR = os.path.join(REPO_DIR, 'scratch', 'pages_150dpi')
from pathlib import Path
ARTIFACT_DIR = os.environ.get("ANTIGRAVITY_ARTIFACTS_DIR") or str(Path.home() / ".gemini" / "antigravity-cli" / "brain" / "44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2")

os.makedirs(SCRATCH_DIR, exist_ok=True)
os.makedirs(DIST_DIR, exist_ok=True)

def render_pages():
    doc = fitz.open(PDF_PATH)
    total_pages = len(doc)
    print(f"[INFO] Renderizando {total_pages} páginas a 150 DPI...")
    
    page_images = []
    for p in range(total_pages):
        page = doc[p]
        pix = page.get_pixmap(dpi=150)
        img_path = os.path.join(SCRATCH_DIR, f"page_{p+1:02d}.png")
        pix.save(img_path)
        page_images.append(img_path)
        
    print(f"[OK] {total_pages} páginas renderizadas.")
    return page_images

def create_mosaics(page_images):
    # Agrupación en mosaicos de 8 páginas (2 filas de 4 columnas)
    groups = [
        ("mosaico_paginas_01_08", 0, 8),
        ("mosaico_paginas_09_16", 8, 16),
        ("mosaico_paginas_17_24", 16, 24),
        ("mosaico_paginas_25_32", 24, 32),
        ("mosaico_paginas_33_40", 32, 40),
        ("mosaico_paginas_41_47", 40, len(page_images))
    ]
    
    # Cada página a 150 DPI es approx: 396 * (150/72) = 825 px ancho, 612 * (150/72) = 1275 px alto
    # En el mosaico podemos reescalar cada miniatura a ancho 412 px, alto 637 px
    thumb_w = 412
    thumb_h = 637
    margin = 30
    header_h = 60
    
    for name, start_idx, end_idx in groups:
        sub_imgs = page_images[start_idx:end_idx]
        cols = min(4, len(sub_imgs))
        rows = (len(sub_imgs) + cols - 1) // cols
        
        mos_w = cols * thumb_w + (cols + 1) * margin
        mos_h = rows * thumb_h + (rows + 1) * margin + header_h
        
        mosaic = Image.new("RGB", (mos_w, mos_h), "#f1f5f9")
        draw = ImageDraw.Draw(mosaic)
        
        title_text = f"PRUEBA DE ESTRÉS EDITORIAL CAPÍTULOS 01–03 · PÁGINAS {start_idx+1:02d}–{end_idx:02d}"
        draw.text((margin, 20), title_text, fill="#0f172a")
        
        for idx, img_p in enumerate(sub_imgs):
            r = idx // cols
            c = idx % cols
            x = margin + c * (thumb_w + margin)
            y = header_h + margin + r * (thumb_h + margin)
            
            p_img = Image.open(img_p).resize((thumb_w, thumb_h), Image.Resampling.LANCZOS)
            mosaic.paste(p_img, (x, y))
            
            # Dibujar borde y etiqueta de página
            draw.rectangle([x, y, x + thumb_w, y + thumb_h], outline="#cbd5e1", width=1)
            p_label = f"PÁG {start_idx + idx + 1:02d} ({'RECTO' if (start_idx+idx+1)%2!=0 else 'VERSO'})"
            draw.text((x + 10, y + 10), p_label, fill="#f15d22")
            
        out_dist = os.path.join(DIST_DIR, f"{name}.png")
        mosaic.save(out_dist, quality=92)
        print(f"[OK] Mosaico guardado: {out_dist}")
        
        # Copiar al directorio de artefactos
        out_art = os.path.join(ARTIFACT_DIR, f"{name}.png")
        shutil.copy(out_dist, out_art)
        
def render_key_spreads():
    doc = fitz.open(SPREADS_PDF)
    key_spreads = [1, 2, 3, 4, 16, 17]
    for s_idx in key_spreads:
        if s_idx <= len(doc):
            page = doc[s_idx - 1]
            pix = page.get_pixmap(dpi=150)
            out_p = os.path.join(DIST_DIR, f"spread_{s_idx:02d}.png")
            pix.save(out_p)
            print(f"[OK] Pliego renderizado: {out_p}")
            out_art = os.path.join(ARTIFACT_DIR, f"spread_{s_idx:02d}.png")
            shutil.copy(out_p, out_art)

if __name__ == '__main__':
    imgs = render_pages()
    create_mosaics(imgs)
    render_key_spreads()
