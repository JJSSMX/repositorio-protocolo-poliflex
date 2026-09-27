"""
GENERADOR DE COMPARATIVA DE MARGEN SUPERIOR / RESPIRACIÓN
Fase 3.7.1 - Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

Genera:
1. dist/TEST_INTERIOR_TOP_MARGIN_4MM.pdf
2. dist/TEST_INTERIOR_TOP_MARGIN_6MM.pdf
3. dist/TEST_INTERIOR_TOP_MARGIN_8MM.pdf
4. dist/TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf
5. dist/TEST_INTERIOR_TOP_MARGIN_PANEL.pdf
6. Renders a 150 DPI para inspección visual.
"""

import os
import sys
import subprocess
import shutil
import fitz

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
SCRATCH_DIR = os.path.join(REPO_DIR, 'scratch')
os.makedirs(DIST_DIR, exist_ok=True)
os.makedirs(TESTS_DIR, exist_ok=True)
os.makedirs(SCRATCH_DIR, exist_ok=True)

# 1 mm = 2.83464567 pt
# Base: 54.00 pt
# +4 mm: 54.00 + 11.3386 = 65.3386 pt
# +6 mm: 54.00 + 17.0079 = 71.0079 pt
# +8 mm: 54.00 + 22.6772 = 76.6772 pt

def get_page_content_typst():
    return '''
== Valores Comunes y Principios Rectores
La actuación de los miembros de la familia en relación con la empresa deberá regirse por principios de integridad, lealtad, responsabilidad y respeto, así como por criterios de institucionalidad, transparencia y profesionalización.

Son principios rectores del sistema familiar–empresarial:

#legal-alpha("a)", [Continuidad institucional: Los cargos pertenecen a la organización y no a las personas, por lo que cualquier relevo deberá garantizar estabilidad y orden.])
#legal-alpha("b)", [Formalidad en los procesos de sustitución: Toda designación deberá realizarse mediante los mecanismos previstos, quedando excluidas las intervenciones informales.])
#legal-alpha("c)", [Mérito y capacidad: El acceso a funciones de dirección o gobierno requerirá preparación, experiencia y alineación con el proyecto común.])
#legal-alpha("d)", [Preservación del control familiar: Las decisiones deberán orientarse a mantener la dirección y propiedad dentro del ámbito familiar.])
#legal-alpha("e)", [Respeto a las decisiones institucionales: Las resoluciones adoptadas por los órganos competentes deberán ser acatadas por todos los integrantes.])

== Unidad Familiar como Activo Estratégico
La cohesión entre los miembros de la familia constituye un elemento esencial para la estabilidad de la empresa. En consecuencia, las diferencias deberán canalizarse a través de los mecanismos previstos en este Protocolo, evitando que los conflictos personales impacten en la operación o en la toma de decisiones.

== Legitimidad del Protocolo y Adhesión Voluntaria
El presente Protocolo adquiere fuerza vinculante para quienes lo suscriben, en la medida en que refleja la voluntad común de establecer reglas claras para la relación entre familia y empresa.
'''

def build_single_variant_typ(delta_mm, variant_label, is_comparison=False):
    delta_pt = delta_mm * (72.0 / 25.4)
    top_margin_pt = 54.00 + delta_pt
    air_height_pt = top_margin_pt - 35.00

    banner = ""
    if is_comparison:
        banner = f'''
#place(top + left, dx: 0pt, dy: -{delta_pt:.2f}pt - 18pt)[
  #rect(width: 314.56pt, height: 14pt, fill: rgb("#fff8ed"), stroke: 0.5pt + rgb("#f15d22"), radius: 2pt)[
    #align(center + horizon)[
      #text(font: "Segoe UI", size: 6.5pt, weight: "bold", fill: rgb("#f15d22"))[
        {variant_label}: +{delta_mm} mm (+{delta_pt:.2f} pt) | Límite superior: {top_margin_pt:.2f} pt | Respiración: {air_height_pt:.2f} pt
      ]
    ]
  ]
]
'''

    typ = f'''
#import "/templates/typst/componentes.typ": interior-isotype

#set page(
  width: 396pt,
  height: 612pt,
  margin: (
    inside: 58.74pt,
    outside: 22.70pt,
    top: {top_margin_pt:.4f}pt,
    bottom: 65.00pt
  ),
  header: context [
    // El running header permanece en su posición absoluta exacta calibrada
    #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
    #let rh_text(t, col) = text(font: neuzeit, size: 5.5pt, fill: rgb(col), tracking: 0.200em)[#t]
    #let inst_unit = [#rh_text("PROTOCOLO FAMILIAR", "#6c6b67")#h(8pt)#rh_text("VERSION 1.0", "#f15d22")]
    #let ch_unit = [#rh_text("CAPÍTULO 01", "#6c6b67")]
    #let iso = interior-isotype(width: 7.1186pt, height: 7.0000pt, opacity: 50%)

    #place(top + left, dx: 0pt, dy: 25.5pt)[
      #grid(
        columns: (1fr, 1fr),
        align: (left + horizon, right + horizon),
        inst_unit,
        [#ch_unit#h(5pt)#box(baseline: 15%)[#iso]]
      )
    ]
  ],
  footer: context [
    #let minion = ("Minion Pro", "Georgia")
    #place(top + right, dx: 0pt, dy: 30pt)[
      #text(font: minion, size: 8pt, fill: rgb("#f15d22"), weight: "medium")[03]
    ]
  ],
  background: [
    // Filete vertical en lomo (30.13pt en recto)
    #place(top + left, dx: 30.13pt, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + rgb("#f15d22")))
  ]
)

#set text(
  font: ("Neuzeit Grotesk", "Segoe UI"),
  size: 7.9077pt,
  fill: rgb("#2e2f31"),
  tracking: 0em,
  hyphenate: false
)
#set par(
  leading: 12.72949pt,
  justify: true,
  spacing: 12.72949pt,
  linebreaks: "simple"
)

#set heading(numbering: "1.1")
#counter(heading).update((1, 2, 0, 0))

#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 18.35pt, below: 15.42pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 10pt, fill: rgb("#f15d22"), stroke: 0.4pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(5.5pt)#text(font: minion, size: 10pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

#let legal-alpha(marker, content) = block(width: 100%, inset: (left: 20pt), breakable: true, below: 12.73pt)[
  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content
]

{banner}
{get_page_content_typst()}
'''
    return typ

def compile_typ(typ_content, output_pdf):
    subprocess.run(["powershell", "-Command", "Stop-Process -Name Acrobat -Force -ErrorAction SilentlyContinue"], capture_output=True)
    temp_typ = os.path.join(SCRATCH_DIR, os.path.basename(output_pdf).replace('.pdf', '.typ'))
    with open(temp_typ, 'w', encoding='utf-8') as f:
        f.write(typ_content)

    cmd = ['typst', 'compile', '--root', REPO_DIR, '--font-path', FONTS_DIR, temp_typ, output_pdf]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode == 0:
        print(f"[OK] Generado: {output_pdf} ({os.path.getsize(output_pdf)/1024:.1f} KB)")
        return True
    else:
        print(f"[ERROR] Typst error al compilar {output_pdf}:\n{res.stderr}")
        return False

def generate_all_variants():
    variants = [
        (4, "VARIANTE A", "TEST_INTERIOR_TOP_MARGIN_4MM.pdf"),
        (6, "VARIANTE B", "TEST_INTERIOR_TOP_MARGIN_6MM.pdf"),
        (8, "VARIANTE C", "TEST_INTERIOR_TOP_MARGIN_8MM.pdf")
    ]

    for delta_mm, label, pdf_name in variants:
        pdf_path = os.path.join(DIST_DIR, pdf_name)
        typ_code = build_single_variant_typ(delta_mm, label, is_comparison=False)
        compile_typ(typ_code, pdf_path)

    # Documento de comparación: 3 páginas con banner diagnóstico
    comp_typ = []
    for delta_mm, label, _ in variants:
        comp_typ.append(build_single_variant_typ(delta_mm, label, is_comparison=True))
        comp_typ.append('#pagebreak()')

    comp_pdf = os.path.join(DIST_DIR, "TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf")
    compile_typ("\n".join(comp_typ[:-1]), comp_pdf)

    # Panel horizontal lado a lado de las 3 variantes (1188 x 612 pt)
    panel_typ = f'''
#set page(width: 1188pt, height: 612pt, margin: 0pt, fill: rgb("#ffffff"))
#grid(
  columns: (396pt, 396pt, 396pt),
  image("/dist/TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf", page: 1, width: 396pt, height: 612pt),
  image("/dist/TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf", page: 2, width: 396pt, height: 612pt),
  image("/dist/TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf", page: 3, width: 396pt, height: 612pt)
)
'''
    panel_pdf = os.path.join(DIST_DIR, "TEST_INTERIOR_TOP_MARGIN_PANEL.pdf")
    compile_typ(panel_typ, panel_pdf)

    # Renderizar PNGs a 150 DPI para inspección visual
    doc_comp = fitz.open(comp_pdf)
    for p_idx, page in enumerate(doc_comp):
        pix = page.get_pixmap(dpi=150)
        png_path = os.path.join(DIST_DIR, f"top_margin_{variants[p_idx][0]}mm.png")
        pix.save(png_path)
        print(f"[OK] Renderizado: {png_path}")

    doc_panel = fitz.open(panel_pdf)
    pix_panel = doc_panel[0].get_pixmap(dpi=150)
    panel_png = os.path.join(DIST_DIR, "top_margin_comparison_panel.png")
    pix_panel.save(panel_png)
    print(f"[OK] Renderizado panel: {panel_png}")

if __name__ == '__main__':
    generate_all_variants()
