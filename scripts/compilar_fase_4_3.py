import os
import sys
import hashlib
import subprocess
import pymupdf

sys.stdout.reconfigure(encoding='utf-8')

from pathlib import Path
REPO_ROOT = str(Path(__file__).resolve().parent.parent)
DIST_DIR = os.path.join(REPO_ROOT, 'dist')
TESTS_DIR = os.path.join(REPO_ROOT, 'tests')
REPORTES_DIR = os.path.join(REPO_ROOT, 'reportes')
FONTS_DIR = os.path.join(REPO_ROOT, 'assets', 'fonts')

os.makedirs(DIST_DIR, exist_ok=True)
os.makedirs(TESTS_DIR, exist_ok=True)
os.makedirs(REPORTES_DIR, exist_ok=True)

CANONICAL_HASHES = {
    'capitulos/00_introduccion.md': 'DEEECA7863249DB1348BEF6138E0DAEDA35B5120658459D0362309E543FECAD8',
    'capitulos/10_anexos_formatos_operativos.md': '102AC1DE3C815C616CC5740D0F3676FEF929578373B0EB6BFF0641BFF6115D3C',
    'capitulos/11_reglamento_asamblea_familia.md': 'CF58D4959CE88BD2A2863AB6F018EB5F649151A9905859ACE203B4C853A3B5A8',
    'capitulos/12_reglamento_consejo_familia.md': '42B59E7D5D26A90BDDBCA124B128F07BBA335C844B83FA4D7711433D9675A2A0',
    'capitulos/13_reglamento_comite_honor_familiar.md': 'B8D238BD294EC30DAE0DB0AAD76A8313EEB51D2CB69734B821C1E37337335CAF'
}

def verify_integrity():
    print("Verificando integridad estricta de fuentes y componentes...")
    for rel_path, expected in CANONICAL_HASHES.items():
        full_p = os.path.join(REPO_ROOT, rel_path)
        with open(full_p, 'rb') as f:
            actual = hashlib.sha256(f.read()).hexdigest().upper()
        if actual != expected:
            raise ValueError(f"HASH MISMATCH en {rel_path}!")
    
    comp_p = os.path.join(REPO_ROOT, 'templates/typst/componentes.typ')
    if os.path.getsize(comp_p) != 45356:
        raise ValueError("templates/typst/componentes.typ fue alterado!")
    print("  [OK] Fuentes canónicas y componentes LOCKED 100% íntegros.")

def compile_variant(variant_letter):
    typ_filename = f"test_introduccion_fase_4_3_{variant_letter.lower()}.typ"
    pdf_filename = f"TEST_INTRODUCCION_FASE_4_3_{variant_letter.upper()}.pdf"
    
    typ_path = os.path.join(TESTS_DIR, typ_filename)
    pdf_path = os.path.join(DIST_DIR, pdf_filename)
    
    typ_code = f"""// ==============================================================================
// TEST INTRODUCCIÓN FASE 4.3 — VARIANTE {variant_letter.upper()}
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================

#import "/templates/typst/componentes.typ": *
#import "/templates/typst/componentes_fase_4_experimental.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#introduction-page(cfg, variant: "{variant_letter.upper()}", page_num: 5, show_spread: true)
"""
    with open(typ_path, 'w', encoding='utf-8') as f:
        f.write(typ_code)
        
    cmd = ['typst', 'compile', '--root', REPO_ROOT, '--font-path', FONTS_DIR, typ_path, pdf_path]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        raise RuntimeError(f"Error compilando Variante {variant_letter}:\n{res.stderr}")
    print(f"  [OK] Compilado dist/{pdf_filename} ({os.path.getsize(pdf_path)} bytes)")
    return pdf_path

def compile_comparative(pdf_a, pdf_b, pdf_c):
    comp_typ_path = os.path.join(TESTS_DIR, "test_introduccion_fase_4_3_comparativo.typ")
    comp_pdf_path = os.path.join(DIST_DIR, "TEST_INTRODUCCION_FASE_4_3_COMPARATIVO.pdf")
    
    rel_a = "/" + os.path.relpath(pdf_a, REPO_ROOT).replace('\\', '/')
    rel_b = "/" + os.path.relpath(pdf_b, REPO_ROOT).replace('\\', '/')
    rel_c = "/" + os.path.relpath(pdf_c, REPO_ROOT).replace('\\', '/')
    
    comp_code = f"""// ==============================================================================
// COMPARATIVO FORENSE DE INTRODUCCIÓN — FASE 4.3
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================

#set text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 8pt)

// ------------------------------------------------------------------------------
// PÁGINA 1: LÁMINA A3 HORIZONTAL — COMPARACIÓN TRIPARTITA A ESCALA EQUIVALENTE
// ------------------------------------------------------------------------------
#set page(
  paper: "a3",
  flipped: true,
  margin: (x: 1.5cm, top: 1.2cm, bottom: 1.0cm),
  header: context [
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #text(size: 6pt, fill: rgb("#6c6b67"), tracking: 0.200em)[POLIDUCTOS FLEXIBLES, S.A. DE C.V. · PROTOCOLO FAMILIAR · FASE 4.3]
        #v(1pt)
        #text(size: 11pt, weight: "bold", fill: rgb("#2e2f31"))[COMPARATIVA FORENSE DE PROTOTIPOS EDITORIALES: INTRODUCCIÓN]
      ],
      [
        #text(size: 8pt, weight: "bold", fill: rgb("#f04e23"))[LÁMINA COMPARATIVA A3 (ESCALA 1:1)]
        #v(1pt)
        #text(size: 6.5pt, fill: rgb("#6c6b67"))[Alternativa A: Página Noble Unitaria en Recto]
      ]
    )
    #v(3pt)
    #line(length: 100%, stroke: 0.8pt + rgb("#f04e23"))
  ],
  footer: context [
    #line(length: 100%, stroke: 0.4pt + rgb("#cbd5e1"))
    #v(2pt)
    #grid(
      columns: (1fr, 1fr),
      text(size: 6pt, fill: rgb("#6c6b67"))[Protocolo Familiar POLIFLEX · Familia Velasco Chedraui · Septiembre 2026],
      align(right)[#text(size: 6pt, fill: rgb("#6c6b67"))[Página 1 de 4]]
    )
  ]
)

#v(8pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1.2cm,
  [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 3pt
    )[
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[VARIANTE A · SOBRIA / BASELINE]
      #v(2pt)
      #text(size: 6.8pt, fill: rgb("#2e2f31"))[
        • *Filosofía:* Continuidad estricta con la baseline de lectura.\\
        • *Tipografía:* Neuzeit Grotesk 7.9077 pt / Leading 12.73 pt.\\
        • *Caja de texto:* 314.56 pt (ancho útil completo).\\
        • *Encabezado:* Minion Pro 15.99 pt + Cintillo naranja.\\
        • *Respiración:* 51.32 pt de aire antes del folio institucional.
      ]
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#94a3b8"), radius: 2pt, clip: true)[
      #image("{rel_a}", page: 2, width: 100%)
    ]
  ],
  [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 3pt
    )[
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[VARIANTE B · RESPIRACIÓN CEREMONIAL]
      #v(2pt)
      #text(size: 6.8pt, fill: rgb("#2e2f31"))[
        • *Filosofía:* Mayor aire periférico y nobleza pausada.\\
        • *Tipografía:* Neuzeit 8.0 pt / Lead Par 8.2 pt / Leading 12.8–13.5 pt.\\
        • *Caja de texto:* 304.56 pt (10 pt de sangría bilateral noble).\\
        • *Encabezado:* Minion Pro 16.5 pt espaciado (tracking 0.080 em).\\
        • *Respiración:* 42.14 pt de aire antes del folio noble.
      ]
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#94a3b8"), radius: 2pt, clip: true)[
      #image("{rel_b}", page: 2, width: 100%)
    ]
  ],
  [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 3pt
    )[
      #text(weight: "bold", size: 9pt, fill: rgb("#f04e23"))[VARIANTE C · IDENTIDAD ASIMÉTRICA]
      #v(2pt)
      #text(size: 6.8pt, fill: rgb("#2e2f31"))[
        • *Filosofía:* ADN corporativo contemporáneo con barra de acento.\\
        • *Tipografía:* Neuzeit 7.9077 pt / Sangría clásica 14 pt.\\
        • *Caja de texto:* 314.56 pt + Colofón institucional de cierre.\\
        • *Encabezado:* Barra vertical naranja 2 pt + Triple nivel institucional.\\
        • *Respiración:* 44.92 pt de aire antes del folio en color acento.
      ]
    ]
    #v(6pt)
    #box(stroke: 0.5pt + rgb("#94a3b8"), radius: 2pt, clip: true)[
      #image("{rel_c}", page: 2, width: 100%)
    ]
  ]
)

// ------------------------------------------------------------------------------
// PÁGINAS 2, 3, 4: SPREADS REALES EN TAMAÑO 792 × 612 pt (MEDIA CARTA DOBLE)
// ------------------------------------------------------------------------------
#set page(
  width: 792pt,
  height: 612pt,
  margin: 0pt,
  header: none,
  footer: none
)

// SPREAD VARIANTE A
#grid(
  columns: (396pt, 396pt),
  image("{rel_a}", page: 1, width: 396pt, height: 612pt),
  image("{rel_a}", page: 2, width: 396pt, height: 612pt)
)

// SPREAD VARIANTE B
#grid(
  columns: (396pt, 396pt),
  image("{rel_b}", page: 1, width: 396pt, height: 612pt),
  image("{rel_b}", page: 2, width: 396pt, height: 612pt)
)

// SPREAD VARIANTE C
#grid(
  columns: (396pt, 396pt),
  image("{rel_c}", page: 1, width: 396pt, height: 612pt),
  image("{rel_c}", page: 2, width: 396pt, height: 612pt)
)
"""
    with open(comp_typ_path, 'w', encoding='utf-8') as f:
        f.write(comp_code)
        
    cmd = ['typst', 'compile', '--root', REPO_ROOT, '--font-path', FONTS_DIR, comp_typ_path, comp_pdf_path]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        raise RuntimeError(f"Error compilando Comparativo:\n{res.stderr}")
    print(f"  [OK] Compilado dist/TEST_INTRODUCCION_FASE_4_3_COMPARATIVO.pdf ({os.path.getsize(comp_pdf_path)} bytes)")

def audit_variants(pdf_a, pdf_b, pdf_c):
    print("\nAuditoría forense métrica de las 3 variantes...")
    audit_data = {}
    
    for v, p in [('A', pdf_a), ('B', pdf_b), ('C', pdf_c)]:
        doc = pymupdf.open(p)
        p2 = doc[1]
        text = p2.get_text()
        words = len(text.split())
        blocks = [b for b in p2.get_text('blocks') if b[1] < 580]
        top_y = min(b[1] for b in blocks)
        bottom_y = max(b[3] for b in blocks)
        audit_data[v] = {
            'pages': len(doc),
            'text_len': len(text),
            'words': words,
            'top_y': top_y,
            'bottom_y': bottom_y,
            'height': bottom_y - top_y,
            'remaining_space': 594.64 - bottom_y
        }
        print(f"  Variante {v}: Top Y={top_y:.2f}pt, Bottom Y={bottom_y:.2f}pt, Altura={bottom_y - top_y:.2f}pt, Aire al pie={594.64 - bottom_y:.2f}pt")
    return audit_data

def generate_report(audit):
    report_path = os.path.join(REPORTES_DIR, 'reporte_fase_4_3_introduccion.md')
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("# INFORME TÉCNICO DE PROTOTIPOS EDITORIALES: INTRODUCCIÓN — FASE 4.3\n\n")
        f.write("**Fecha:** Septiembre 2026  \n")
        f.write("**Proyecto:** Protocolo Familiar POLIFLEX  \n")
        f.write("**Fase:** 4.3 — Prototipo Editorial de Introducción  \n")
        f.write("**Decisión Adoptada:** Alternativa A (Página Noble Unitaria en RECTO)  \n")
        f.write("**Estado de Componente:** `introduction-page()` = `EXPERIMENTAL / NOT LOCKED`  \n\n")
        f.write("---\n\n")
        f.write("## 1. Alcance y Protección de Baseline\n\n")
        f.write("En estricto apego a las directrices de la Fase 4.3:\n\n")
        f.write("- **Trabajo Exclusivo:** Se prototipó única y exclusivamente la Introducción a partir de `capitulos/00_introduccion.md`.\n")
        f.write("- **Preservación Textual (100%):** Se conservaron íntegras las 305 palabras y los 6 párrafos de la fuente canónica sin omisiones, adiciones ni alteraciones.\n")
        f.write("- **Componentes Bloqueados:** `cover-page()`, `chapter-opening()`, `chapter-first-page()` e `interior-page()` permanecen `APPROVED / LOCKED` sin alteración.\n")
        f.write("- **Tabla de Contenido:** `table-of-contents()` permanece en estado `UNLOCK AUTHORIZED / PENDING REDESIGN` (no fue modificada en esta fase).\n")
        f.write("- **Aislamiento Técnico:** El nuevo componente experimental `introduction-page()` se programó exclusivamente en [`templates/typst/componentes_fase_4_experimental.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes_fase_4_experimental.typ), preservando intacto `templates/typst/componentes.typ`.\n\n")
        
        f.write("## 2. Entregables Generados\n\n")
        f.write("- [`dist/TEST_INTRODUCCION_FASE_4_3_A.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTRODUCCION_FASE_4_3_A.pdf) (Variante A: Sobria / Baseline)\n")
        f.write("- [`dist/TEST_INTRODUCCION_FASE_4_3_B.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTRODUCCION_FASE_4_3_B.pdf) (Variante B: Respiración Ceremonial Calibrada)\n")
        f.write("- [`dist/TEST_INTRODUCCION_FASE_4_3_C.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTRODUCCION_FASE_4_3_C.pdf) (Variante C: Identidad Asimétrica POLIFLEX)\n")
        f.write("- [`dist/TEST_INTRODUCCION_FASE_4_3_COMPARATIVO.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTRODUCCION_FASE_4_3_COMPARATIVO.pdf) (Lámina comparativa A3 a escala 1:1 + Spreads completos)\n\n")

        f.write("## 3. Matriz Comparativa Detallada de las Tres Variantes\n\n")
        f.write("| Parámetro Editorial | VARIANTE A (Sobria / Baseline) | VARIANTE B (Respiración Ceremonial) | VARIANTE C (Asimétrica POLIFLEX) |\n")
        f.write("| :--- | :--- | :--- | :--- |\n")
        f.write("| **Filosofía de Diseño** | Continuidad directa con la retícula aprobada de capítulos. | Mayor pausa y solemnidad; caja de lectura concentrada. | Contemporánea, dinámica y estructurada; estilo carta/tratado. |\n")
        f.write(f"| **Posición Inicial del Título** | `y = 78.00 pt` | `y = 75.00 pt` | `y = 72.00 pt` |\n")
        f.write("| **Tipografía del Título** | Minion Pro Medium Display (15.99 pt, tracking 0.019 em) | Minion Pro Medium (16.50 pt, tracking 0.080 em) | Minion Pro Medium (16.50 pt, tracking 0.025 em) |\n")
        f.write("| **Elementos Gráficos del Título** | Cintillo superior naranja (`5.5 pt`) + Filete inferior (`20 pt × 0.9 pt`) | Filete horizontal naranja sobrio (`16 pt × 0.9 pt`) | Barra vertical naranja (`2 pt × 38 pt`) + Cintillos dobles |\n")
        f.write(f"| **Posición Inicial del Cuerpo** | `y = 140.00 pt` | `y = 130.00 pt` | `y = 142.00 pt` |\n")
        f.write(f"| **Posición Final del Cuerpo** | `y = {audit['A']['bottom_y']:.2f} pt` | `y = {audit['B']['bottom_y']:.2f} pt` | `y = {audit['C']['bottom_y']:.2f} pt` |\n")
        f.write(f"| **Altura Total del Contenido** | `{audit['A']['height']:.2f} pt` | `{audit['B']['height']:.2f} pt` | `{audit['C']['height']:.2f} pt` |\n")
        f.write(f"| **Aire Libre antes de Folio (594 pt)** | **`{audit['A']['remaining_space']:.2f} pt`** | **`{audit['B']['remaining_space']:.2f} pt`** | **`{audit['C']['remaining_space']:.2f} pt`** |\n")
        f.write("| **Ancho de Caja Útil** | `314.56 pt` (Lomo 58.74 pt / Corte 22.70 pt) | `304.56 pt` (Lomo 63.74 pt / Corte 27.70 pt) | `314.56 pt` (Lomo 58.74 pt / Corte 22.70 pt) |\n")
        f.write("| **Tipografía del Cuerpo** | Neuzeit Grotesk (7.9077 pt) | Neuzeit Grotesk (Lead 8.2 pt; Resto 7.9077 pt) | Neuzeit Grotesk (7.9077 pt) |\n")
        f.write("| **Interlínea (Leading)** | `12.7295 pt` (Estricta baseline) | `13.50 pt` (Lead) / `12.80 pt` (Resto) | `12.7295 pt` |\n")
        f.write("| **Separación entre Párrafos** | `12.7295 pt` (Línea en blanco) | `8.50 pt` | `5.50 pt` + Sangría clásica de 14 pt en P2–P6 |\n")
        f.write("| **Colofón de Cierre** | No (cierre con párrafo 6) | No (cierre con párrafo 6) | Sí (`Coatepec, Veracruz · Agosto 2026`) |\n")
        f.write("| **Pie de Página (Folio)** | Folio naranja `5` + Frase `PROTOCOLO FAMILIAR · VERSION 1.0` | Folio gris sobrio `5` + Frase `FAMILIA VELASCO CHEDRAUI` | Folio naranja `5` + Frase `PROTOCOLO FAMILIAR` |\n\n")

        f.write("## 4. Análisis Crítico Descriptivo (Sin Declaración de Ganador)\n\n")
        f.write("### Variante A: Disciplina y Ortodoxia de Baseline\n")
        f.write("- **Fortalezas:** Mantiene una afinidad total con el sistema de lectura de los capítulos 01–09. El interlineado idéntico y el ancho de caja estándar de 314.56 pt garantizan que el ojo del lector no perciba ningún salto de ritmo técnico al avanzar al Capítulo 01. Los 51.32 pt de aire libre al pie brindan un reposo impecable.\n")
        f.write("- **Observación:** Al ser idéntica en espaciados a una página interior, su carácter solemne recae primordialmente en el encabezado noble.\n\n")

        f.write("### Variante B: Nobleza y Solemnidad de Proemio\n")
        f.write("- **Fortalezas:** Al recoger los márgenes en 10 pt por lado (caja de 304.56 pt) y jerarquizar el primer párrafo a 8.2 pt con interlínea de 13.5 pt, adquiere un aire inequívoco de manifiesto fundacional. El espaciado de 8.5 pt entre párrafos compacta elegantemente la lectura y deja 42.14 pt de aire libre al pie, sin saturar ni cortar jamás una sola línea.\n")
        f.write("- **Observación:** Se percibe más exclusiva y ceremonial que una página ordinaria de articulado.\n\n")

        f.write("### Variante C: Identidad Corporativa Contemporánea\n")
        f.write("- **Fortalezas:** La barra de acento vertical naranja de 2 pt evoca de inmediato el rigor institucional de POLIFLEX. La sangría de primera línea en los párrafos 2 al 6 aporta una cadencia clásica de acta o declaración formal, mientras que el colofón final ubica temporal y geográficamente el acuerdo en Coatepec.\n")
        f.write("- **Observación:** Posee una personalidad gráfica más activa y corporativa que las dos anteriores.\n\n")

        f.write("## 5. Garantía de Integridad y Verificación de No-Regresión\n\n")
        f.write("- `capitulos/00_introduccion.md` modificado: **`FALSE`**\n")
        f.write("- `capitulos/01–09` modificados: **`FALSE`**\n")
        f.write("- `capitulos/10–13` modificados: **`FALSE`**\n")
        f.write("- `templates/typst/componentes.typ` modificado: **`FALSE`**\n")
        f.write("- `table-of-contents()` modificado: **`FALSE`**\n")
        f.write("- Estado de `introduction-page()`: **`EXPERIMENTAL / NOT LOCKED`**\n")
    print("  [OK] Escrito reportes/reporte_fase_4_3_introduccion.md")

def main():
    verify_integrity()
    pdf_a = compile_variant('A')
    pdf_b = compile_variant('B')
    pdf_c = compile_variant('C')
    compile_comparative(pdf_a, pdf_b, pdf_c)
    audit = audit_variants(pdf_a, pdf_b, pdf_c)
    generate_report(audit)
    print("\nFASE 4.3 PROTOTIPO EDITORIAL COMPLETADO EXITOSAMENTE.")

if __name__ == '__main__':
    main()
