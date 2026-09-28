// ==============================================================================
// CORPUS ESTRUCTURADO DERIVADO: FAMILIA DE ACTAS [FASE 4.6.5 — LOCK PARCIAL]
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// AVISO EDITORIAL:
// Este archivo es un artefacto técnico DERIVADO y sirve exclusivamente para
// la reproducción de pruebas de regresión automatizada y validación editorial.
// NO es una fuente editorial primaria ni debe modificarse de forma independiente.
// La única fuente canónica del contenido es:
//   capitulos/10_anexos_formatos_operativos.md
// ==============================================================================

#import "/templates/typst/componentes.typ": *

// Parámetros tipográficos y métricas canónicas locked de la familia de Actas
#let p-row-height = 22.0pt
#let p-line-spacing = 14.5pt
#let p-multiline-below = 6.0pt
#let p-section-above = 11.5pt
#let p-section-below = 5.0pt
#let p1-title-below = 8.0pt

// ------------------------------------------------------------------------------
// 1. RENDERER: ACTA DE ASAMBLEA GENERAL FAMILIAR (A2 APPROVED / LOCKED)
// ------------------------------------------------------------------------------
#let render-acta-asamblea(
  lines-exposicion: 2,
  lines-deliberacion: 3,
  lines-consideraciones: 3,
  lines-resolucion: 3
) = [
  // --- PÁGINA VERSO (Página 02) ---
  #form-title("ACTA DE ASAMBLEA GENERAL FAMILIAR", below: p1-title-below)

  #form-header-meta(label: "Número:", prefix: "AGF", suffix: "/20", below: 10pt)

  En #form-field-line(width: 52pt), siendo las #form-field-line(width: 24pt) horas del día #form-field-line(width: 18pt) de #form-field-line(width: 42pt) de 20#form-field-line(width: 18pt), se reunieron los integrantes de la Familia Velasco Chedraui con derecho de participación, previa convocatoria emitida conforme al Protocolo Familiar.

  La presente Asamblea se celebra como el órgano superior de participación familiar para la definición de asuntos estratégicos relacionados con la continuidad generacional, la preservación patrimonial y el fortalecimiento institucional de la familia empresaria.

  #form-section-title("1.", "Registro de Asistencia", above: p-section-above, below: p-section-below)

  #let headers-asistencia = (
    (body: "Nombre", align: left + horizon),
    (body: "Rama Familiar", align: left + horizon),
    (body: "Porcentaje de Capital", align: center + horizon),
    (body: "Acreditación", align: center + horizon),
    (body: "Firma", align: left + horizon)
  )

  #let rows-asistencia = (
    ([], [], align(right + horizon)[% #h(6pt)], align(center + horizon)[#form-checkbox(label: "Sí") #h(6pt) #form-checkbox(label: "No")], []),
    ([], [], align(right + horizon)[% #h(6pt)], align(center + horizon)[#form-checkbox(label: "Sí") #h(6pt) #form-checkbox(label: "No")], []),
    ([], [], align(right + horizon)[% #h(6pt)], align(center + horizon)[#form-checkbox(label: "Sí") #h(6pt) #form-checkbox(label: "No")], []),
    ([], [], align(right + horizon)[% #h(6pt)], align(center + horizon)[#form-checkbox(label: "Sí") #h(6pt) #form-checkbox(label: "No")], [])
  )

  #form-table(
    columns: (1.10fr, 0.95fr, 0.70fr, 1.15fr, 1.10fr),
    headers: headers-asistencia,
    rows_data: rows-asistencia,
    row_height: p-row-height
  )

  #form-section-title("2.", "Verificación de Quórum", above: p-section-above, below: p-section-below)

  Se hace constar que se encuentra representado el #form-field-line(width: 25pt) % del capital familiar y presentes #form-field-line(width: 22pt) ramas familiares activas, por lo que existe quórum suficiente para sesionar válidamente.

  // Salto de página hacia la página RECTO del pliego enfrentado
  #pagebreak()

  // --- PÁGINA RECTO (Página 03) ---
  #form-section-title("3.", "Desarrollo de la Asamblea", above: 0pt, below: p-section-below)

  #text(font: font-neuzeit, size: 7.5pt, weight: "medium", fill: col-text)[Punto 1.]
  #v(3pt)

  #form-multiline-field("Exposición del asunto:", num_lines: lines-exposicion, line_spacing: p-line-spacing, below: p-multiline-below)

  #form-multiline-field("Deliberación:", num_lines: lines-deliberacion, line_spacing: p-line-spacing, below: p-multiline-below)

  #form-multiline-field("Consideraciones relevantes:", num_lines: lines-consideraciones, line_spacing: p-line-spacing, below: p-multiline-below)

  #form-multiline-field("Resolución:", num_lines: lines-resolucion, line_spacing: p-line-spacing, below: p-multiline-below)

  #v(2pt)
  #text(font: font-neuzeit, size: 7.5pt, weight: "medium", fill: col-text)[Punto 2. Resultado de la votación.]
  #v(3pt)

  #block(width: 100%, breakable: false)[
    #grid(
      columns: (auto, auto, auto),
      column-gutter: 8pt,
      form-checkbox(label: "Aprobada sin modificaciones"),
      form-checkbox(label: "Aprobada con modificaciones"),
      form-checkbox(label: "Diferida.")
    )

    #v(5pt)

    #grid(
      columns: (auto, auto, auto),
      column-gutter: (8pt, 12pt),
      row-gutter: 4.5pt,
      align: (left + horizon, left + horizon, left + horizon),
      [A favor:], [#form-field-line(width: 25pt) % del capital familiar], [| #h(6pt) #form-field-line(width: 20pt) ramas],
      [En contra:], [#form-field-line(width: 25pt) % del capital familiar], [| #h(6pt) #form-field-line(width: 20pt) ramas],
      [Abstenciones:], [#form-field-line(width: 25pt) % del capital familiar], [| #h(6pt) #form-field-line(width: 20pt) ramas]
    )

    #v(4pt)
    #text(font: font-neuzeit, size: 7.5pt, weight: "medium", fill: col-text)[Resultado:]#h(8pt)
    #form-checkbox(label: "Aprobado")#h(12pt)#form-checkbox(label: "No aprobado")
  ]

  // Bloque indivisible de Clausura y Mesa de Firmas (Keep-Together)
  #form-signature-block(above: p-section-above)[
    #form-section-title("4.", "Clausura", above: 0pt, below: p-section-below)

    No existiendo más asuntos que tratar, se declaró formalmente clausurada la Asamblea, ordenándose la elaboración y conservación de la presente acta como parte del archivo institucional de la Familia:

    #v(4pt)

    #let headers-mesa = (
      (body: "Nombre", align: left + horizon),
      (body: "Rama", align: left + horizon),
      (body: "Cargo / Calidad", align: left + horizon),
      (body: "Firma", align: left + horizon)
    )

    #let rows-mesa = (
      ([], [], [Presidente de Mesa], []),
      ([], [], [Secretario de Mesa], []),
      ([], [], [Escrutador], [])
    )

    #form-table(
      columns: (1.15fr, 0.85fr, 1.10fr, 0.90fr),
      headers: headers-mesa,
      rows_data: rows-mesa,
      row_height: p-row-height
    )
  ]
]

// ------------------------------------------------------------------------------
// 2. RENDERER: ACTA DE SESIÓN DEL CONSEJO DE FAMILIA (APPROVED / LOCKED)
// ------------------------------------------------------------------------------
#let render-acta-consejo(
  lines-antecedentes: 2,
  lines-deliberacion: 3,
  lines-consideraciones: 3,
  lines-resolucion: 3
) = [
  // --- PÁGINA VERSO (Página 02) ---
  #form-title("ACTA DE SESIÓN DEL CONSEJO DE FAMILIA", below: p1-title-below)

  #form-header-meta(
    label: "Número de Sesión:",
    prefix: "CF",
    suffix: "/20",
    below: 10pt
  )

  En #form-field-line(width: 52pt), siendo las #form-field-line(width: 24pt) horas del día #form-field-line(width: 18pt) de #form-field-line(width: 42pt) de 20#form-field-line(width: 18pt), se reunieron los integrantes del Consejo de Familia, previa convocatoria emitida conforme al Protocolo Familiar.

  La presente sesión forma parte de los mecanismos institucionales de gobierno familiar establecidos para promover la unidad familiar, fortalecer la comunicación entre sus integrantes, preservar el patrimonio familiar y contribuir a la continuidad generacional del proyecto empresarial.

  #form-section-title("1.", "Lista De Asistencia", above: p-section-above, below: p-section-below)

  #let headers-asistencia = (
    (body: "Nombre", align: left + horizon),
    (body: "Rama Familiar", align: left + horizon),
    (body: "Cargo en el Consejo", align: left + horizon),
    (body: "Firma", align: left + horizon)
  )

  #let rows-asistencia = (
    ([], [], [], []),
    ([], [], [], []),
    ([], [], [], [])
  )

  #form-table(
    columns: (1.10fr, 0.95fr, 1.05fr, 0.90fr),
    headers: headers-asistencia,
    rows_data: rows-asistencia,
    row_height: p-row-height
  )

  #v(3pt)
  Una vez realizado el pase de lista, se hizo constar la asistencia de #form-field-line(width: 20pt) integrantes de un total de #form-field-line(width: 20pt), por lo que existe quórum suficiente para sesionar válidamente.

  #form-section-title("2.", "Declaración de Instalación", above: p-section-above, below: p-section-below)

  En virtud de la existencia de quórum, el Presidente declaró formalmente instalada la sesión y válidos los acuerdos que en ella se adopten.

  #form-section-title("3.", "Declaración de Conflictos de Interés", above: p-section-above, below: p-section-below)

  Los integrantes manifestaron si existe algún conflicto de interés relacionado con los asuntos sometidos a consideración, quedando asentadas las declaraciones correspondientes.

  // Salto de página natural hacia la página RECTO del pliego enfrentado
  #pagebreak()

  // --- PÁGINA RECTO (Página 03) ---
  #form-section-title("4.", "Desarrollo de la Sesión", above: 0pt, below: p-section-below)

  #form-multiline-field("Antecedentes:", num_lines: lines-antecedentes, line_spacing: p-line-spacing, below: p-multiline-below)

  #form-multiline-field("Deliberación:", num_lines: lines-deliberacion, line_spacing: p-line-spacing, below: p-multiline-below)

  #form-multiline-field("Consideraciones:", num_lines: lines-consideraciones, line_spacing: p-line-spacing, below: p-multiline-below)

  #form-multiline-field("Resolución:", num_lines: lines-resolucion, line_spacing: p-line-spacing, below: p-multiline-below)

  #v(2pt)
  #text(font: font-neuzeit, size: 7.5pt, weight: "medium", fill: col-text)[Votación:]
  #v(3pt)

  #block(width: 100%, breakable: false)[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      row-gutter: 4.5pt,
      align: (left + horizon, left + horizon),
      [A favor:], [#form-field-line(width: 100%)],
      [En contra:], [#form-field-line(width: 100%)],
      [Abstenciones:], [#form-field-line(width: 100%)]
    )
  ]

  // Bloque indivisible de Clausura y Mesa de Firmas (Keep-Together)
  #form-signature-block(above: p-section-above)[
    #form-section-title("5.", "Clausura", above: 0pt, below: p-section-below)

    Agotados los asuntos comprendidos en el Orden del Día y no existiendo otros temas que tratar, se declaró formalmente concluida la sesión, instruyéndose la elaboración y resguardo de la presente acta para su incorporación al archivo institucional correspondiente.

    #v(4pt)

    #let headers-firmas = (
      (body: "Nombre", align: left + horizon),
      (body: "Cargo", align: left + horizon),
      (body: "Firma", align: left + horizon)
    )

    #let rows-firmas = (
      ([], [Presidente], []),
      ([], [Secretario], []),
      ([], [Vocal], []),
      ([], [Vocal], [])
    )

    #form-table(
      columns: (1.30fr, 1.00fr, 1.10fr),
      headers: headers-firmas,
      rows_data: rows-firmas,
      row_height: p-row-height
    )
  ]
]

// ------------------------------------------------------------------------------
// 3. RENDERER: ACTA DE SESIÓN DEL COMITÉ DE HONOR FAMILIAR (APPROVED / LOCKED)
// ------------------------------------------------------------------------------
#let render-acta-comite(
  lines-descripcion: 3,
  lines-resolucion: 3
) = [
  // --- PÁGINA VERSO (Página 02) ---
  #form-title("ACTA DE CONSTITUCIÓN Y SESIÓN DEL COMITÉ DE HONOR FAMILIAR", below: p1-title-below)

  #form-header-meta(
    label: "Expediente Número:",
    prefix: "CHF-",
    suffix: "/202",
    num_width: 35pt,
    year_width: 15pt,
    show_type: false,
    below: 10pt
  )

  En #form-field-line(width: 52pt), siendo las #form-field-line(width: 24pt) horas del día #form-field-line(width: 18pt) de #form-field-line(width: 42pt) de 20#form-field-line(width: 18pt), y en cumplimiento de la resolución emitida por el Consejo de Familia, se constituye formalmente el Comité de Honor Familiar para conocer y resolver el expediente identificado al rubro.

  #form-section-title("1.", "Integrantes Designados del Comité", above: p-section-above, below: p-section-below)

  #let headers-integrantes = (
    (body: "Nombre", align: left + horizon),
    (body: "Carácter", align: left + horizon),
    (body: "Firma de Aceptación", align: left + horizon)
  )

  #let rows-integrantes = (
    ([], [Presidente del Comité], []),
    ([], [Integrante], []),
    ([], [Integrante], [])
  )

  #form-table(
    columns: (1.20fr, 1.10fr, 1.00fr),
    headers: headers-integrantes,
    rows_data: rows-integrantes,
    row_height: p-row-height
  )

  #form-section-title("2.", "Objeto del Procedimiento", above: p-section-above, below: p-section-below)

  El Comité de Honor Familiar tiene por objeto analizar los hechos sometidos a su consideración y emitir una determinación institucional conforme a los principios, valores y disposiciones contenidas en el Protocolo Familiar.

  #form-section-title("3.", "Descripción del Asunto", above: p-section-above, below: p-section-below)

  #form-multiline-field("(Naturaleza del conflicto o conducta a calificar)", num_lines: lines-descripcion, line_spacing: p-line-spacing, below: p-multiline-below)

  #form-section-title("4.", "Documentación Recibida del Consejo de Familia:", above: p-section-above, below: p-section-below)

  #block(width: 100%, breakable: false)[
    #set text(font: font-neuzeit, size: 7.5pt, fill: col-text)
    #grid(
      columns: (1fr,),
      row-gutter: 5.5pt,
      form-checkbox(label: "Expediente institucional completo."),
      form-checkbox(label: "Relación de hechos."),
      form-checkbox(label: "Evidencia documental."),
      form-checkbox(label: "Manifestaciones de las partes involucradas."),
      [#form-checkbox(label: "Otros:") #h(4pt) #form-field-line(width: 160pt)]
    )
  ]

  // Salto de página deliberado hacia la página RECTO del pliego enfrentado
  #pagebreak()

  // --- PÁGINA RECTO (Página 03) ---
  #form-section-title("5.", "Desarrollo de la Sesión", above: 0pt, below: p-section-below)

  #block(width: 100%, breakable: false)[
    #set text(font: font-neuzeit, size: 7.5pt, fill: col-text)
    #grid(
      columns: (auto, 1fr),
      column-gutter: 6pt,
      row-gutter: 4pt,
      [1.], [Análisis del expediente.],
      [2.], [Valoración de los antecedentes y elementos aportados.],
      [3.], [Deliberación de los integrantes del Comité.],
      [4.], [Determinación institucional.]
    )
  ]

  #form-section-title("6.", "Consideraciones", above: p-section-above, below: p-section-below)

  El Comité tomó en cuenta los principios de respeto familiar, responsabilidad, integridad, preservación de la armonía familiar y cumplimiento de las obligaciones previstas en el Protocolo Familiar.

  #form-section-title("7.", "Resolución", above: p-section-above, below: p-section-below)

  #form-multiline-field("Después de analizar integralmente el expediente, el Comité determina:", num_lines: lines-resolucion, line_spacing: p-line-spacing, below: p-multiline-below)

  #form-section-title("8.", "Efectos de la Resolución", above: p-section-above, below: p-section-below)

  La presente determinación constituye una resolución institucional dentro del sistema de gobierno familiar y servirá de base para la adopción de las medidas o acciones que correspondan por parte de los órganos competentes.

  // Bloque indivisible de Clausura y Mesa de Firmas (Keep-Together)
  #form-signature-block(above: p-section-above)[
    #form-section-title("9.", "Clausura", above: 0pt, below: p-section-below)

    Concluidos los trabajos del Comité y no existiendo más asuntos que tratar, se dio por terminada la sesión, levantándose la presente acta para constancia.

    #v(4pt)

    #let headers-firmas = (
      (body: "Nombre", align: left + horizon),
      (body: "Cargo en el Comité", align: left + horizon),
      (body: "Firma", align: left + horizon)
    )

    #let rows-firmas = (
      ([], [Presidente], []),
      ([], [Integrante], []),
      ([], [Integrante], [])
    )

    #form-table(
      columns: (1.20fr, 1.10fr, 1.00fr),
      headers: headers-firmas,
      rows_data: rows-firmas,
      row_height: p-row-height
    )

    #v(6pt)
    #text(font: font-neuzeit, size: 7.5pt, fill: col-text)[
      Lugar y fecha de cierre de sesión: #form-field-line(width: 85pt), a #form-field-line(width: 18pt) de #form-field-line(width: 45pt) de 20#form-field-line(width: 18pt).
    ]
  ]
]
