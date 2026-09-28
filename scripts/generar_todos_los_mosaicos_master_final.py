#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
GENERADOR COMPLETO DE MOSAICOS Y LÁMINAS DE CASOS CRÍTICOS [FASE 4.8]
Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
Genera:
1. dist/mosaico_master_174_paginas.png (Todo el libro)
2. dist/mosaico_seccion_front_matter_6_paginas.png
3. dist/mosaico_seccion_capitulos_124_paginas.png
4. dist/mosaico_seccion_reglamentos_master_24_paginas.png
5. dist/mosaico_seccion_anexos_16_paginas.png
6. dist/mosaico_seccion_indice_analitico_4_paginas.png
7. dist/lamina_casos_criticos.png (12 casos clave)
"""

import os
from pathlib import Path
import pymupdf
from PIL import Image, ImageDraw, ImageFont

REPO_ROOT = Path(__file__).resolve().parent.parent
DIST_DIR = REPO_ROOT / "dist"
PDF_PATH = DIST_DIR / "PROTOCOLO_FAMILIAR_POLIFLEX_MASTER_FINAL_CANDIDATO.pdf"

doc = pymupdf.open(str(PDF_PATH))
total_pages = len(doc)
print(f"Cargado PDF: {PDF_PATH.name} ({total_pages} páginas)")

try:
    font_title = ImageFont.truetype(str(REPO_ROOT / "assets/fonts/Minion Pro Medium Display.otf"), 24)
    font_sub = ImageFont.truetype(str(REPO_ROOT / "assets/fonts/NeuzeitGro-Reg.ttf"), 12)
    font_lbl = ImageFont.truetype(str(REPO_ROOT / "assets/fonts/NeuzeitGro-Reg.ttf"), 9)
    font_crit_title = ImageFont.truetype(str(REPO_ROOT / "assets/fonts/Minion Pro Medium Display.otf"), 26)
    font_crit_sub = ImageFont.truetype(str(REPO_ROOT / "assets/fonts/NeuzeitGro-Reg.ttf"), 13)
    font_crit_lbl = ImageFont.truetype(str(REPO_ROOT / "assets/fonts/NeuzeitGro-Reg.ttf"), 10)
except Exception:
    font_title = ImageFont.load_default()
    font_sub = ImageFont.load_default()
    font_lbl = ImageFont.load_default()
    font_crit_title = font_title
    font_crit_sub = font_sub
    font_crit_lbl = font_lbl

def get_page_image(p_idx, dpi=120):
    pix = doc[p_idx].get_pixmap(dpi=dpi)
    return Image.frombytes("RGB", [pix.width, pix.height], pix.samples)

# ------------------------------------------------------------------------------
# 1. MOSAICO FRONT MATTER (6 PÁGS: 3 cols x 2 rows)
# ------------------------------------------------------------------------------
def generar_front_matter():
    print("-> Generando Mosaico Front Matter (Págs 01–06)...")
    pages = list(range(0, 6))
    cols, rows = 3, 2
    scale = 0.40
    pad_x, pad_y = 30, 40
    margin_top, margin_bottom, margin_side = 90, 40, 40

    sample_img = get_page_image(0, dpi=140)
    pw, ph = sample_img.size
    tw, th = int(pw * scale), int(ph * scale)

    cw = margin_side * 2 + cols * tw + (cols - 1) * pad_x
    ch = margin_top + rows * th + (rows - 1) * pad_y + margin_bottom

    canvas = Image.new("RGB", (cw, ch), color="#0f172a")
    draw = ImageDraw.Draw(canvas)

    draw.text((margin_side, 24), "PROTOCOLO FAMILIAR POLIFLEX — FRONT MATTER INSTITUCIONAL", fill="#f15d22", font=font_title)
    draw.text((margin_side, 58), "PÁGINAS 01 A 06 · PORTADA, TABLA DE CONTENIDO DINÁMICA E INTRODUCCIÓN INSTITUCIONAL", fill="#94a3b8", font=font_sub)

    labels = [
        "P.01 · Portada Institucional (Recto)",
        "P.02 · Blanco Ceremonial (Verso)",
        "P.03 · Tabla de Contenido Dinámica (Recto)",
        "P.04 · Blanco Ceremonial (Verso)",
        "P.05 · Introducción Institucional (Recto)",
        "P.06 · Blanco Ceremonial Pre-Capítulos (Verso)"
    ]

    for i, p_idx in enumerate(pages):
        img = get_page_image(p_idx, dpi=140)
        c, r = i % cols, i // cols
        x = margin_side + c * (tw + pad_x)
        y = margin_top + r * (th + pad_y)

        thumb = img.resize((tw, th), Image.Resampling.LANCZOS)
        draw.rectangle([x - 1, y - 1, x + tw, y + th], outline="#334155", width=1)
        canvas.paste(thumb, (x, y))
        draw.text((x, y + th + 6), labels[i], fill="#e2e8f0", font=font_lbl)

    out = DIST_DIR / "mosaico_seccion_front_matter_6_paginas.png"
    canvas.save(str(out), quality=95)
    print(f"   Guardado: {out.name}")

# ------------------------------------------------------------------------------
# 2. MOSAICO CAPÍTULOS (124 PÁGS: 16 cols x 8 rows)
# ------------------------------------------------------------------------------
def generar_capitulos():
    print("-> Generando Mosaico Capítulos 01–09 (Págs 07–130, 124 págs)...")
    pages = list(range(6, 130))
    cols, rows = 16, 8
    scale = 0.15
    pad_x, pad_y = 10, 18
    margin_top, margin_bottom, margin_side = 80, 30, 30

    sample_img = get_page_image(6, dpi=100)
    pw, ph = sample_img.size
    tw, th = int(pw * scale), int(ph * scale)

    cw = margin_side * 2 + cols * tw + (cols - 1) * pad_x
    ch = margin_top + rows * th + (rows - 1) * pad_y + margin_bottom

    canvas = Image.new("RGB", (cw, ch), color="#0f172a")
    draw = ImageDraw.Draw(canvas)

    draw.text((margin_side, 20), "PROTOCOLO FAMILIAR POLIFLEX — CAPÍTULOS SUSTANTIVOS 01 A 09", fill="#f15d22", font=font_title)
    draw.text((margin_side, 50), "PÁGINAS 07 A 130 · 124 PÁGINAS NORMATIVAS (BASE OFICIAL LOCKED FASE 3.9.3)", fill="#94a3b8", font=font_sub)

    for i, p_idx in enumerate(pages):
        img = get_page_image(p_idx, dpi=80)
        c, r = i % cols, i // cols
        x = margin_side + c * (tw + pad_x)
        y = margin_top + r * (th + pad_y)

        thumb = img.resize((tw, th), Image.Resampling.BILINEAR)
        draw.rectangle([x - 1, y - 1, x + tw, y + th], outline="#1e293b", width=1)
        canvas.paste(thumb, (x, y))
        draw.text((x, y + th + 3), f"P.{p_idx+1:02d}", fill="#64748b", font=font_lbl)

    out = DIST_DIR / "mosaico_seccion_capitulos_124_paginas.png"
    canvas.save(str(out), quality=95)
    print(f"   Guardado: {out.name}")

# ------------------------------------------------------------------------------
# 3. MOSAICO REGLAMENTOS (24 PÁGS: 6 cols x 4 rows)
# ------------------------------------------------------------------------------
def generar_reglamentos():
    print("-> Generando Mosaico Reglamentos (Págs 131–154, 24 págs)...")
    pages = list(range(130, 154))
    cols, rows = 6, 4
    scale = 0.28
    pad_x, pad_y = 18, 28
    margin_top, margin_bottom, margin_side = 85, 35, 35

    sample_img = get_page_image(130, dpi=130)
    pw, ph = sample_img.size
    tw, th = int(pw * scale), int(ph * scale)

    cw = margin_side * 2 + cols * tw + (cols - 1) * pad_x
    ch = margin_top + rows * th + (rows - 1) * pad_y + margin_bottom

    canvas = Image.new("RGB", (cw, ch), color="#0f172a")
    draw = ImageDraw.Draw(canvas)

    draw.text((margin_side, 22), "PROTOCOLO FAMILIAR POLIFLEX — REGLAMENTOS DE ÓRGANOS DE GOBIERNO", fill="#f15d22", font=font_title)
    draw.text((margin_side, 54), "PÁGINAS 131 A 154 · 24 PÁGINAS NORMATIVAS (ASAMBLEA, CONSEJO Y COMITÉ · LOCKED FASE 4.5.8)", fill="#94a3b8", font=font_sub)

    for i, p_idx in enumerate(pages):
        img = get_page_image(p_idx, dpi=120)
        c, r = i % cols, i // cols
        x = margin_side + c * (tw + pad_x)
        y = margin_top + r * (th + pad_y)

        thumb = img.resize((tw, th), Image.Resampling.LANCZOS)
        draw.rectangle([x - 1, y - 1, x + tw, y + th], outline="#334155", width=1)
        canvas.paste(thumb, (x, y))
        draw.text((x, y + th + 4), f"P.{p_idx+1:02d}", fill="#94a3b8", font=font_lbl)

    out = DIST_DIR / "mosaico_seccion_reglamentos_master_24_paginas.png"
    canvas.save(str(out), quality=95)
    print(f"   Guardado: {out.name}")

# ------------------------------------------------------------------------------
# 4. MOSAICO ANEXOS (16 PÁGS: 4 cols x 4 rows)
# ------------------------------------------------------------------------------
def generar_anexos():
    print("-> Generando Mosaico Anexos y Formatos Operativos (Págs 155–170, 16 págs)...")
    pages = list(range(154, 170))
    cols, rows = 4, 4
    scale = 0.32
    pad_x, pad_y = 22, 32
    margin_top, margin_bottom, margin_side = 85, 35, 35

    sample_img = get_page_image(154, dpi=130)
    pw, ph = sample_img.size
    tw, th = int(pw * scale), int(ph * scale)

    cw = margin_side * 2 + cols * tw + (cols - 1) * pad_x
    ch = margin_top + rows * th + (rows - 1) * pad_y + margin_bottom

    canvas = Image.new("RGB", (cw, ch), color="#0f172a")
    draw = ImageDraw.Draw(canvas)

    draw.text((margin_side, 22), "PROTOCOLO FAMILIAR POLIFLEX — ANEXOS Y FORMATOS OPERATIVOS", fill="#f15d22", font=font_title)
    draw.text((margin_side, 54), "PÁGINAS 155 A 170 · 16 PÁGINAS (PORTADILLA, AVISO, CARTA, CONVOCATORIAS Y ACTAS · LOCKED FASE 4.8)", fill="#94a3b8", font=font_sub)

    anx_labels = [
        "P.155 · Portadilla Anexos",
        "P.156 · Blanco Ceremonial",
        "P.157 · Aviso Exclusividad (01)",
        "P.158 · Carta Adhesión P1 (02)",
        "P.159 · Carta Adhesión P2 (03)",
        "P.160 · Blanco Ceremonial",
        "P.161 · Convocatoria Asamb (01)",
        "P.162 · Acta Asamblea P1 (02)",
        "P.163 · Acta Asamblea P2 (03)",
        "P.164 · Blanco Ceremonial",
        "P.165 · Convocatoria Cons (01)",
        "P.166 · Acta Consejo P1 (02)",
        "P.167 · Acta Consejo P2 (03)",
        "P.168 · Acta Comité P1 (02)",
        "P.169 · Acta Comité P2 (03)",
        "P.170 · Blanco Ceremonial"
    ]

    for i, p_idx in enumerate(pages):
        img = get_page_image(p_idx, dpi=130)
        c, r = i % cols, i // cols
        x = margin_side + c * (tw + pad_x)
        y = margin_top + r * (th + pad_y)

        thumb = img.resize((tw, th), Image.Resampling.LANCZOS)
        draw.rectangle([x - 1, y - 1, x + tw, y + th], outline="#334155", width=1)
        canvas.paste(thumb, (x, y))
        draw.text((x, y + th + 4), anx_labels[i], fill="#cbd5e1", font=font_lbl)

    out = DIST_DIR / "mosaico_seccion_anexos_16_paginas.png"
    canvas.save(str(out), quality=95)
    print(f"   Guardado: {out.name}")

# ------------------------------------------------------------------------------
# 5. MOSAICO ÍNDICE DE TEMAS Y ANEXOS (4 PÁGS: 4 cols x 1 row)
# ------------------------------------------------------------------------------
def generar_indice_temas_y_anexos():
    print("-> Generando Mosaico Índice de Temas y Anexos (Págs 171–174, 4 págs)...")
    pages = list(range(170, 174))
    cols, rows = 4, 1
    scale = 0.38
    pad_x, pad_y = 25, 30
    margin_top, margin_bottom, margin_side = 85, 40, 40

    sample_img = get_page_image(170, dpi=140)
    pw, ph = sample_img.size
    tw, th = int(pw * scale), int(ph * scale)

    cw = margin_side * 2 + cols * tw + (cols - 1) * pad_x
    ch = margin_top + rows * th + margin_bottom

    canvas = Image.new("RGB", (cw, ch), color="#0f172a")
    draw = ImageDraw.Draw(canvas)

    draw.text((margin_side, 22), "PROTOCOLO FAMILIAR POLIFLEX — ÍNDICE DE TEMAS Y ANEXOS", fill="#f15d22", font=font_title)
    draw.text((margin_side, 54), "PÁGINAS 171 A 174 · 4 PÁGINAS (ESTRUCTURA JERÁRQUICA CANÓNICA COMPLETA · CAPÍTULOS, REGLAMENTOS Y ANEXOS)", fill="#94a3b8", font=font_sub)

    idx_labels = [
        "P.171 (Recto) · Apertura y Capítulos 01–02",
        "P.172 (Verso) · Capítulos 02–04",
        "P.173 (Recto) · Capítulos 04–09 y Reglamentos",
        "P.174 (Verso) · Reglamentos y Anexos (Cierre)"
    ]

    for i, p_idx in enumerate(pages):
        img = get_page_image(p_idx, dpi=140)
        x = margin_side + i * (tw + pad_x)
        y = margin_top

        thumb = img.resize((tw, th), Image.Resampling.LANCZOS)
        draw.rectangle([x - 1, y - 1, x + tw, y + th], outline="#334155", width=1)
        canvas.paste(thumb, (x, y))
        draw.text((x, y + th + 6), idx_labels[i], fill="#cbd5e1", font=font_lbl)

    out = DIST_DIR / "mosaico_seccion_indice_temas_y_anexos_4_paginas.png"
    canvas.save(str(out), quality=95)
    # Also save with legacy name for compatibility
    canvas.save(str(DIST_DIR / "mosaico_seccion_indice_analitico_4_paginas.png"), quality=95)
    print(f"   Guardado: {out.name}")

# ------------------------------------------------------------------------------
# 6. MOSAICO COMPLETO DEL LIBRO (174 PÁGS: 18 cols x 10 rows)
# ------------------------------------------------------------------------------
def generar_todo_el_libro():
    print("-> Generando Mosaico de TODO el Libro (Págs 01–174)...")
    cols, rows = 18, 10
    scale = 0.12
    pad_x, pad_y = 6, 12
    margin_top, margin_bottom, margin_side = 70, 25, 25

    sample_img = get_page_image(0, dpi=70)
    pw, ph = sample_img.size
    tw, th = int(pw * scale), int(ph * scale)

    cw = margin_side * 2 + cols * tw + (cols - 1) * pad_x
    ch = margin_top + rows * th + (rows - 1) * pad_y + margin_bottom

    canvas = Image.new("RGB", (cw, ch), color="#090d16")
    draw = ImageDraw.Draw(canvas)

    draw.text((margin_side, 18), "PROTOCOLO FAMILIAR POLIFLEX — OBRA COMPLETA (174 PÁGINAS · 87 PLIEGOS)", fill="#f15d22", font=font_title)
    draw.text((margin_side, 45), "FRONT MATTER (01–06) · CAPÍTULOS (07–130) · REGLAMENTOS (131–154) · ANEXOS (155–170) · ÍNDICE DE TEMAS Y ANEXOS (171–174)", fill="#94a3b8", font=font_sub)

    for p_idx in range(total_pages):
        img = get_page_image(p_idx, dpi=60)
        c, r = p_idx % cols, p_idx // cols
        x = margin_side + c * (tw + pad_x)
        y = margin_top + r * (th + pad_y)

        thumb = img.resize((tw, th), Image.Resampling.BILINEAR)
        draw.rectangle([x - 1, y - 1, x + tw, y + th], outline="#1e293b", width=1)
        canvas.paste(thumb, (x, y))

    out = DIST_DIR / "mosaico_master_174_paginas.png"
    canvas.save(str(out), quality=92)
    print(f"   Guardado: {out.name}")

# ------------------------------------------------------------------------------
# 7. LÁMINA DE CASOS CRÍTICOS (12 CASOS: 4 cols x 3 rows)
# ------------------------------------------------------------------------------
def generar_casos_criticos():
    print("-> Generando Lámina de Casos Críticos (12 casos clave)...")
    casos = [
        (3, "01. Tabla de Contenido Dinámica (Pág. 03)", "Navegación general de bloques"),
        (7, "02. Primera Apertura Doctrinal (Pág. 07)", "Capítulo 01 · Principios y Visión"),
        (35, "03. Página de Capítulo Más Densa (Pág. 35)", "Capítulo 02 · 363 palabras, justify"),
        (152, "04. Página de Reglamento Más Densa (Pág. 152)", "Reglamento Comité · 338 palabras"),
        (138, "05. Transitorios y Cierre Normativo (Pág. 138)", "Reglamento Asamblea · Art. Transitorio"),
        (155, "06. Portadilla General de Anexos (Pág. 155)", "Arco institucional y pliego unifoliar"),
        (157, "07. Aviso de Exclusividad (Pág. 157)", "Variante B Locked · Folio 01"),
        (159, "08. Carta de Adhesión (Pág. 159)", "Pliego Verso-Recto · Bloque de Firma"),
        (161, "09. Convocatoria de Asamblea (Pág. 161)", "Orden del día calibrado · Folio 01"),
        (163, "10. Acta de Asamblea General (Pág. 163)", "Pliego Verso-Recto · Cierre y Firmas"),
        (171, "11. Apertura Índice de Temas y Anexos (Pág. 171)", "Puntos guía, 1 columna · Folio 171"),
        (174, "12. Cierre Índice de Temas y Anexos (Pág. 174)", "Cierre natural en Verso · Pliego 87"),
    ]

    cols, rows = 4, 3
    scale = 0.36
    pad_x, pad_y = 25, 45
    margin_top, margin_bottom, margin_side = 95, 40, 40

    sample_img = get_page_image(2, dpi=140)
    pw, ph = sample_img.size
    tw, th = int(pw * scale), int(ph * scale)

    cw = margin_side * 2 + cols * tw + (cols - 1) * pad_x
    ch = margin_top + rows * th + (rows - 1) * pad_y + margin_bottom

    canvas = Image.new("RGB", (cw, ch), color="#0b1120")
    draw = ImageDraw.Draw(canvas)

    draw.text((margin_side, 24), "PROTOCOLO FAMILIAR POLIFLEX — LÁMINA DE CASOS CRÍTICOS Y PUNTOS DE CONTROL", fill="#f15d22", font=font_crit_title)
    draw.text((margin_side, 58), "INSPECCIÓN FORENSE DE 12 PUNTOS DE INFLEXIÓN EDITORIAL · DENSIDAD, APERTURAS, FIRMAS Y CIERRE", fill="#94a3b8", font=font_crit_sub)

    for i, (p_num, tit, subtit) in enumerate(casos):
        img = get_page_image(p_num - 1, dpi=140)
        c, r = i % cols, i // cols
        x = margin_side + c * (tw + pad_x)
        y = margin_top + r * (th + pad_y)

        thumb = img.resize((tw, th), Image.Resampling.LANCZOS)
        draw.rectangle([x - 1, y - 1, x + tw, y + th], outline="#38bdf8", width=1)
        canvas.paste(thumb, (x, y))
        draw.text((x, y + th + 6), tit, fill="#f8fafc", font=font_crit_lbl)
        draw.text((x, y + th + 20), subtit, fill="#94a3b8", font=font_lbl)

    out = DIST_DIR / "lamina_casos_criticos.png"
    canvas.save(str(out), quality=95)
    print(f"   Guardado: {out.name}")

def main():
    generar_front_matter()
    generar_capitulos()
    generar_reglamentos()
    generar_anexos()
    generar_indice_temas_y_anexos()
    generar_todo_el_libro()
    generar_casos_criticos()
    print("=== TODOS LOS MOSAICOS Y LÁMINAS GENERADOS EXITOSAMENTE ===")

if __name__ == "__main__":
    main()
