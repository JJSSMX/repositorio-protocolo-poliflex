"""
GENERADOR DE COMPARATIVAS VISUALES DE RESPIRACIÓN TEMÁTICA
Genera dist/TEST_TOPIC_SPACING_BEFORE_AFTER.pdf
Demuestra ANTES (+0 pt) vs DESPUÉS (+18 pt) en 4 casos canónicos reales.
"""

import os
import subprocess
import pymupdf

from pathlib import Path
REPO_DIR = str(Path(__file__).resolve().parent.parent)
FONTS_DIR = os.path.join(REPO_DIR, 'assets', 'fonts')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
TESTS_DIR = os.path.join(REPO_DIR, 'tests')

OUTPUT_TYP = os.path.join(TESTS_DIR, 'test_topic_spacing_before_after.typ')
OUTPUT_PDF = os.path.join(DIST_DIR, 'TEST_TOPIC_SPACING_BEFORE_AFTER.pdf')

typ = """
#set page(
  paper: "a3",
  flipped: true,
  margin: (x: 2cm, y: 1.5cm)
)

#set text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))
#set par(leading: 12.72949pt, justify: true, spacing: 12.72949pt)

#let minion = ("Minion Pro", "Georgia")

// Componente para renderizar encabezados en estilo ANTES (+0 pt)
#let heading-before(level, num, title) = {
  let (sz, abv, blw, stk) = if level == 2 {
    (10pt, 18.35pt, 15.42pt, 0.4pt)
  } else if level == 3 {
    (9.5pt, 14.00pt, 10.00pt, 0.3pt)
  } else {
    (9pt, 10.00pt, 8.00pt, 0.2pt)
  }
  block(width: 100%, breakable: false, above: abv, below: blw)[
    #box[#text(font: minion, size: sz, fill: rgb("#f15d22"), stroke: stk + rgb("#f15d22"), weight: "medium")[#num]]#h(5pt)#text(font: minion, size: sz, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#title]
  ]
}

// Componente para renderizar encabezados en estilo DESPUÉS (+18 pt)
#let heading-after(level, num, title) = {
  let (sz, abv, blw, stk) = if level == 2 {
    (10pt, 18.35pt + 18.00pt, 15.42pt, 0.4pt)
  } else if level == 3 {
    (9.5pt, 14.00pt + 18.00pt, 10.00pt, 0.3pt)
  } else {
    (9pt, 10.00pt + 18.00pt, 8.00pt, 0.2pt)
  }
  block(width: 100%, breakable: false, above: abv, below: blw)[
    #box[#text(font: minion, size: sz, fill: rgb("#f15d22"), stroke: stk + rgb("#f15d22"), weight: "medium")[#num]]#h(5pt)#text(font: minion, size: sz, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#title]
  ]
}

#let comparison-card(title-badge, case-name, level-name, prev-text, heading-num, heading-title, heading-level, next-text, space-before-orig, space-before-new) = [
  #align(center)[
    #text(size: 15pt, weight: "bold", fill: rgb("#f15d22"))[COMPARATIVA DE RESPIRACIÓN VERTICAL — #case-name] \\
    #v(3pt)
    #text(size: 10pt, fill: rgb("#6c6b67"))[Validación Editorial: #level-name | Regla Space-Before: +18.00 pt (1 línea de ritmo vertical)]
  ]

  #v(14pt)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 25pt,
    [
      #align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#c62828"))[ESTADO ANTERIOR: FASE 3.8 (+0 pt)]]
      #v(6pt)
      #block(width: 100%, stroke: 0.5pt + rgb("#cccccc"), fill: rgb("#ffffff"), inset: 16pt)[
        #prev-text
        #heading-before(heading-level, heading-num, heading-title)
        #next-text
      ]
      #v(8pt)
      #rect(width: 100%, stroke: 0.5pt + rgb("#ffcdd2"), fill: rgb("#ffebee"), inset: 10pt)[
        *Medición Anterior:*
        - Espacio Preceding Body $->$ Heading: *#space-before-orig*
        - Espacio Heading $->$ Next Body Line: *#if heading-level == 2 [15.42 pt] else if heading-level == 3 [10.00 pt] else [8.00 pt]*
        - Diagnóstico: Proximidad excesiva entre el final de la unidad anterior y el nuevo título.
      ]
    ],
    [
      #align(center)[#text(size: 11pt, weight: "bold", fill: rgb("#2e7d32"))[ESTADO CORREGIDO: FASE 3.8.1 (+18.00 pt)]]
      #v(6pt)
      #block(width: 100%, stroke: 0.5pt + rgb("#a5d6a7"), fill: rgb("#ffffff"), inset: 16pt)[
        #prev-text
        #heading-after(heading-level, heading-num, heading-title)
        #next-text
      ]
      #v(8pt)
      #rect(width: 100%, stroke: 0.5pt + rgb("#c8e6c9"), fill: rgb("#e8f5e9"), inset: 10pt)[
        *Medición Corregida:*
        - Espacio Preceding Body $->$ Heading: *#space-before-new* (Incremento exacto: *+18.00 pt*)
        - Espacio Heading $->$ Next Body Line: *#if heading-level == 2 [15.42 pt] else if heading-level == 3 [10.00 pt] else [8.00 pt]* (Intacto)
        - Resultado: Clara respiración visual y desvinculación óptica entre unidades temáticas.
      ]
    ]
  )
]

// ==============================================================================
// HOJA 1: CASO A — SECCIÓN -> SECCIÓN (H2 -> H2)
// ==============================================================================
#let p_c1_prev = [En este sentido, los intereses individuales quedan subordinados al interés colectivo, privilegiando en todo momento la estabilidad institucional, la permanencia del proyecto y la conservación del control en el ámbito familiar.]
#let p_c1_next = [La propiedad y conducción de la empresa se conciben como un legado que debe transmitirse de manera ordenada entre generaciones. Cada generación asume la responsabilidad de preparar a la siguiente, no solo en la transferencia del patrimonio, sino en la formación de criterios, capacidades y valores necesarios para su adecuada gestión y preservación.]

#comparison-card(
  "CASO A",
  "SECCIÓN A SECCIÓN (H2)",
  "Capítulo 01 · Transición de Sección 1.1 a 1.2",
  p_c1_prev,
  "1.2",
  "Visión Intergeneracional y Proyecto de Largo Plazo",
  2,
  p_c1_next,
  "18.35 pt",
  "36.35 pt (+18.00 pt)"
)

#pagebreak()

// ==============================================================================
// HOJA 2: CASO B — SUBSECCIÓN -> SUBSECCIÓN (H3 -> H3)
// ==============================================================================
#let p_c2_prev = [La adhesión al presente Protocolo implica el reconocimiento expreso de que las acciones se encuentran sujetas a un régimen institucional que limita su ejercicio en función del interés colectivo, quedando vinculadas a las disposiciones aquí previstas y a los mecanismos de control familiar establecidos.]
#let p_c2_next = [El ejercicio de cualquier facultad derivada de la titularidad accionaria, incluyendo transmisión, gravamen, uso como garantía, acceso a información, ejercicio de derechos corporativos o activación de mecanismos de salida, deberá realizarse exclusivamente conforme a las reglas, procedimientos y autorizaciones establecidos en este Protocolo.]

#comparison-card(
  "CASO B",
  "SUBSECCIÓN A SUBSECCIÓN (H3)",
  "Capítulo 02 · Transición de Subsección 2.1.1 a 2.1.2",
  p_c2_prev,
  "2.1.2",
  "Alcance de las Restricciones sobre la Titularidad Accionaria",
  3,
  p_c2_next,
  "14.00 pt",
  "32.00 pt (+18.00 pt)"
)

#pagebreak()

// ==============================================================================
// HOJA 3: CASO C — SUBSUBSECCIÓN -> SUBSUBSECCIÓN (H4 -> H4)
// ==============================================================================
#let p_c3_prev = [Este reconocimiento se limitará al ámbito económico y se hará efectivo mediante los mecanismos de valuación y liquidez previstos en este Protocolo.]
#let p_c3_next = [El reconocimiento de derechos económicos no implica, por sí mismo, el acceso a derechos corporativos, de control o de participación en la gestión.]

#comparison-card(
  "CASO C",
  "SUBSUBSECCIÓN A SUBSUBSECCIÓN (H4)",
  "Capítulo 02 · Transición de Subsubsección 2.3.4.1 a 2.3.4.2",
  p_c3_prev,
  "2.3.4.2",
  "Régimen de Derechos Corporativos",
  4,
  p_c3_next,
  "10.00 pt",
  "28.00 pt (+18.00 pt)"
)

#pagebreak()

// ==============================================================================
// HOJA 4: CASO D — EJEMPLO ESPECÍFICO 3.1.1 -> 3.1.2 (H3 -> H3)
// ==============================================================================
#let p_c4_prev = [La institucionalización implica además la separación objetiva entre vínculo familiar y ejercicio del poder, de modo que el parentesco, la antigüedad o la titularidad accionaria no constituyen fuente de autoridad ni habilitación decisoria fuera de los cauces normativos establecidos. Cualquier desviación de este principio se considerará una afectación directa al sistema de gobernanza y dará lugar a la activación de los mecanismos internos de control y consecuencias previstos en este Protocolo.]
#let p_c4_next = [El sistema de gobernanza familiar se rige por una jerarquía normativa interna obligatoria que asegura coherencia, evita conflictos de interpretación y delimita claramente las esferas de regulación. En este orden, el Protocolo Familiar prevalece en todo lo relativo a la relación familia–empresa y al control familiar; los Estatutos Sociales regulan el ámbito societario conforme a la legislación aplicable; el Protocolo General de Gobierno y Cumplimiento organiza la función ejecutiva y operativa; y los reglamentos internos y demás instrumentos complementarios operan de manera subordinada dentro de su ámbito específico.]

#comparison-card(
  "CASO D",
  "EJEMPLO AUDITADO 3.1.1 A 3.1.2 (H3)",
  "Capítulo 03 · Transición de Subsección 3.1.1 a 3.1.2",
  p_c4_prev,
  "3.1.2",
  "Jerarquía Normativa Interna y Regla de Especialidad",
  3,
  p_c4_next,
  "14.00 pt",
  "32.00 pt (+18.00 pt)"
)
"""

with open(OUTPUT_TYP, 'w', encoding='utf-8') as f:
    f.write(typ)

print(f"[OK] Archivo Typst de topic spacing generado: {OUTPUT_TYP}")
res = subprocess.run(['typst', 'compile', '--root', REPO_DIR, '--font-path', FONTS_DIR, OUTPUT_TYP, OUTPUT_PDF], capture_output=True, text=True)
if res.returncode == 0:
    doc = pymupdf.open(OUTPUT_PDF)
    print(f"[ÉXITO] PDF compilado: {OUTPUT_PDF} ({len(doc)} hojas A3, {os.path.getsize(OUTPUT_PDF)/1024:.1f} KB)")
else:
    print("[ERROR] Typst falló:\n", res.stderr)
