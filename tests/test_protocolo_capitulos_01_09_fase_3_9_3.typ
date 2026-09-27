// ==============================================================================
// PROTOCOLO FAMILIAR COMPLETO CAPÍTULOS 01–09 — FASE 3.9.3 — NORMALIZACIÓN CANÓNICA Y CIERRE DEFINITIVO
// Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// Motor Editorial Semántico con Control de Paginación
// Generado automáticamente por scripts/compilar_fase_3_9_1.py
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

// Marcadores semánticos de página y contenido
#show par: it => [
  #it
  #metadata("par") <content-marker>
]

// Componente reutilizable: Página blanca ceremonial (0 elementos, paridad)
#let ceremonial-blank-page() = [
  #page(margin: 0pt, header: none, footer: none)[
    #metadata("ceremonial-blank") <blank-page-marker>
  ]
]

// Configuración de página maestra con paridad dinámica y retícula vertical +6 mm consolidada
#set page(
  width: 396pt,
  height: 612pt,
  margin: (
    inside: 58.74pt,   // Lomo: 58.74pt
    outside: 22.70pt,  // Corte: 22.70pt
    top: 71.0079pt,      // Consolidado +6 mm (+17.0079 pt = 71.0079 pt)
    bottom: 65.00pt
  ),
  header: context [
    #let p = counter(page).get().first()
    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)
    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)
    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)
    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)

    // En apertura, primera página, páginas blancas o páginas sin contenido: SIN running header
    #if not is_opening and not is_first and not is_blank and has_content [
      #let ch_meta = query(selector(<chapter-marker>)).filter(m => m.location().page() <= p)
      #let ch_num = if ch_meta.len() > 0 { ch_meta.last().value } else { 1 }
      #let ch_str = if ch_num < 10 { "0" + str(ch_num) } else { str(ch_num) }
      #let is_recto = calc.odd(p)

      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
      #let rh_text(t, col) = text(font: neuzeit, size: 5.5pt, fill: rgb(col), tracking: 0.200em)[#t]
      #let inst_unit = [#rh_text("PROTOCOLO FAMILIAR", "#6c6b67")#h(8pt)#rh_text("VERSION 1.0", "#f15d22")]
      #let ch_unit = [#rh_text("CAPÍTULO " + ch_str, "#6c6b67")]
      #let iso = interior-isotype(width: 7.1186pt, height: 7.0000pt, opacity: 50%)

      #place(top + left, dx: 0pt, dy: 25.5pt)[
        #if is_recto [
          #grid(
            columns: (1fr, 1fr),
            align: (left + horizon, right + horizon),
            inst_unit,
            [#ch_unit#h(5pt)#box(baseline: 15%)[#iso]]
          )
        ] else [
          #grid(
            columns: (1fr, 1fr),
            align: (left + horizon, right + horizon),
            [#box(baseline: 15%)[#iso]#h(5pt)#ch_unit],
            inst_unit
          )
        ]
      ]
    ]
  ],
  footer: context [
    #let p = counter(page).get().first()
    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)
    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)
    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)
    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)

    #if not is_opening and not is_blank and has_content [
      #let is_recto = calc.odd(p)
      #let minion = ("Minion Pro", "Georgia")
      #let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
      #let p_str = if p < 10 { "0" + str(p) } else { str(p) }
      #let folio_txt = text(font: minion, size: 8pt, fill: rgb("#f15d22"), weight: "medium")[#p_str]

      #if is_first [
        // FRANJA INFERIOR CHAPTER-FIRST-PAGE CORREGIDA MATEMÁTICAMENTE
        // Compensación exacta: #v(20pt - 5.0535pt) = #v(14.9465pt)
        // Baseline Folio = 585.932 pt / 591.708 pt (Idéntico a interior-page)
        #v(20pt - 5.0535pt)
        #let ftr_phrase = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[PROTOCOLO FAMILIAR]
        #let ftr_ver = text(font: neuzeit, size: 4.8234pt, fill: rgb("#f15e22"), tracking: 0.371em)[VERSION 1.0]
        #let iso_ftr = interior-isotype(width: 15.5740pt, height: 15.3150pt, opacity: 50%)

        #if is_recto [
          #grid(
            columns: (1fr, 1fr),
            align: (left + horizon, right + horizon),
            [#box(baseline: 20%)[#iso_ftr]#h(4pt)#ftr_phrase#h(6pt)#ftr_ver],
            folio_txt
          )
        ] else [
          #grid(
            columns: (1fr, 1fr),
            align: (left + horizon, right + horizon),
            folio_txt,
            [#ftr_phrase#h(6pt)#ftr_ver#h(4pt)#box(baseline: 20%)[#iso_ftr]]
          )
        ]
      ] else [
        // Páginas de continuación: SOLO folio en corte exterior
        #v(20pt)
        #if is_recto [
          #align(right)[#folio_txt]
        ] else [
          #align(left)[#folio_txt]
        ]
      ]
    ]
  ],
  background: context [
    #let p = counter(page).get().first()
    #let is_opening = query(selector(<chapter-opening-marker>)).any(m => m.location().page() == p)
    #let is_first = query(selector(<chapter-first-marker>)).any(m => m.location().page() == p)
    #let is_blank = query(selector(<blank-page-marker>)).any(m => m.location().page() == p)
    #let has_content = query(selector.or(<content-marker>, heading)).any(it => it.location().page() == p)

    #if not is_opening and not is_blank and has_content [
      #let is_recto = calc.odd(p)
      #let rule_x = if is_recto { 30.13pt } else { 365.87pt }
      #place(top + left, dx: rule_x, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 612pt), stroke: 0.5pt + rgb("#f15d22")))

      #if is_first [
        #interior-arcs(cfg, opacity: 50%)
      ]
    ]
  ]
)

// Configuración tipográfica calibrada del cuerpo
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

// Reglas de numeración y estilos de títulos (H2, H3, H4) con respiración temática +18 pt
#set heading(numbering: "1.1")

// H2: Sección principal (+18 pt adicional antes de nueva sección, sticky: true)
#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 18.35pt + 18.00pt, below: 15.42pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 10pt, fill: rgb("#f15d22"), stroke: 0.4pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(5.5pt)#text(font: minion, size: 10pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

// H3: Subsección (+18 pt adicional antes de nueva subsección, sticky: true)
#show heading.where(level: 3): it => block(width: 100%, breakable: false, sticky: true, above: 14.00pt + 18.00pt, below: 10.00pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 9.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(5.0pt)#text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

// H4: Sub-subsección (+18 pt adicional antes de nueva sub-subsección, sticky: true)
#show heading.where(level: 4): it => block(width: 100%, breakable: false, sticky: true, above: 10.00pt + 18.00pt, below: 8.00pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 9pt, fill: rgb("#f15d22"), stroke: 0.2pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(4.5pt)#text(font: minion, size: 9pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

// Componentes de listas jurídicas con sangría de bloque exacta
#let legal-alpha(marker, content) = block(width: 100%, inset: (left: 20pt), breakable: true, below: 12.73pt)[
  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content
]

#let legal-roman(marker, content) = block(width: 100%, inset: (left: 40pt), breakable: true, below: 12.73pt)[
  #box(width: auto)[#text(font: ("Neuzeit Grotesk", "Segoe UI"), size: 7.9077pt, fill: rgb("#2e2f31"))[#marker]] #content
]

// ==============================================================================
// PÁGINA 1: PÁGINA DE CORTESÍA INICIAL (RECTO)
// ==============================================================================
#ceremonial-blank-page()

// ==============================================================================
// CAPÍTULO 01: Declaración de Principios Familiares y Visión Intergeneracional
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (1) previas a Chapter Opening 01
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 01
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-01") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "01",
    title: [Declaración de Principios Familiares y Visión Intergeneracional],
    opening_title: ("DECLARACIÓN DE", "PRINCIPIOS FAMILIARES Y", "VISIÓN INTERGENERACIONAL"),
    description: [Los principios que nos guían como familia empresaria \ y la visión que orienta nuestro camino hacia el futuro.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 01
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 01
#metadata(1) <chapter-marker>
#metadata("first-01") <chapter-first-marker>
#counter(heading).update((1, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "01" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[01]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      DECLARACIÓN DE \ 
      PRINCIPIOS FAMILIARES Y \ 
      VISIÓN INTERGENERACIONAL
    ]
  ]
}

#v(177.80pt)

== Misión y Propósito Familiar Empresarial
La familia empresaria reconoce a la empresa como un proyecto común de carácter patrimonial y estratégico, cuya finalidad principal es generar valor sostenible y asegurar su continuidad en el tiempo.

En este sentido, los intereses individuales quedan subordinados al interés colectivo, privilegiando en todo momento la estabilidad institucional, la permanencia del proyecto y la conservación del control en el ámbito familiar.

== Visión Intergeneracional y Proyecto de Largo Plazo
La propiedad y conducción de la empresa se conciben como un legado que debe transmitirse de manera ordenada entre generaciones. Cada generación asume la responsabilidad de preparar a la siguiente, no solo en la transferencia del patrimonio, sino en la formación de criterios, capacidades y valores necesarios para su adecuada gestión y preservación.

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

Su cumplimiento constituye un compromiso institucional orientado a preservar la continuidad y el orden del sistema.

== Revisión Generacional del Protocolo
El presente Protocolo deberá ser objeto de revisión periódica por los órganos familiares competentes, con el fin de asegurar su vigencia, funcionalidad y alineación con la evolución de la familia y de la empresa.

Dicha revisión permitirá incorporar ajustes derivados de cambios generacionales, nuevas estructuras patrimoniales o transformaciones en el entorno empresarial, sin alterar los principios esenciales que lo rigen.

Las modificaciones deberán realizarse de manera ordenada, formal y conforme a los mecanismos previstos en este instrumento, garantizando en todo momento la continuidad institucional del sistema familiar–empresarial.

== Naturaleza Jurídica y Coordinación Normativa
El Protocolo constituye un instrumento interno de organización familiar que complementa los Estatutos Sociales y demás actos jurídicos aplicables. En caso de contradicción, prevalecerán los instrumentos jurídicos formalmente válidos, sin perjuicio de las responsabilidades internas derivadas de su incumplimiento.

== Criterio de Interpretación del Protocolo
Las disposiciones del presente Protocolo deberán interpretarse de manera integral, privilegiando la continuidad institucional, la preservación del control familiar y la profesionalización de la empresa.

Ante cualquier duda, deberá adoptarse la interpretación que favorezca la estabilidad del sistema familiar–empresarial.


// ==============================================================================
// CAPÍTULO 02: Propiedad Accionaria, Control Familiar y Liquidez Patrimonial
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (2) previas a Chapter Opening 02
#ceremonial-blank-page()
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 02
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-02") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "02",
    title: [Propiedad Accionaria, Control Familiar y Liquidez Patrimonial],
    opening_title: ("PROPIEDAD ACCIONARIA,", "CONTROL FAMILIAR Y", "LIQUIDEZ PATRIMONIAL"),
    description: [Estructura accionaria, reglas de transmisión y mecanismos de liquidez \ para preservar la propiedad en la familia.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 02
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 02
#metadata(2) <chapter-marker>
#metadata("first-02") <chapter-first-marker>
#counter(heading).update((2, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "02" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[02]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      PROPIEDAD ACCIONARIA, \ 
      CONTROL FAMILIAR Y \ 
      LIQUIDEZ PATRIMONIAL
    ]
  ]
}

#v(177.80pt)

== Naturaleza del Patrimonio Accionario Familiar
Las acciones representativas del capital social constituyen patrimonio heterónomo del sistema familiar y se sujetan a un régimen accionario colectivo, institucional y multigeneracional, orientado a la continuidad empresarial, la estabilidad institucional y el control familiar efectivo.

En consecuencia, su transmisión, gravamen, afectación, ejercicio de derechos corporativos y activación de mecanismos de salida quedarán subordinados al interés patrimonial común, conforme a este Protocolo, a los Estatutos Sociales y a las determinaciones de los órganos de gobernanza familiar competentes.

=== Reconocimiento del Carácter Institucional de las Acciones
La adhesión al presente Protocolo implica el reconocimiento expreso de que las acciones se encuentran sujetas a un régimen institucional que limita su ejercicio en función del interés colectivo, quedando vinculadas a las disposiciones aquí previstas y a los mecanismos de control familiar establecidos.

=== Alcance de las Restricciones sobre la Titularidad Accionaria
El ejercicio de cualquier facultad derivada de la titularidad accionaria, incluyendo transmisión, gravamen, uso como garantía, acceso a información, ejercicio de derechos corporativos o activación de mecanismos de salida, deberá realizarse exclusivamente conforme a las reglas, procedimientos y autorizaciones establecidos en este Protocolo.

=== Prevalencia del Interés Patrimonial Común
En caso de conflicto entre el interés individual del accionista y el interés del sistema familiar, prevalecerá este último como criterio rector, sin que ello implique desconocimiento de los derechos económicos inherentes a la titularidad accionaria, los cuales deberán ser respetados conforme a los mecanismos previstos en este instrumento.

== Distinción Estructural de Derechos sobre las Acciones
Para efectos del presente Protocolo, la titularidad accionaria se integra por tres ámbitos jurídicos diferenciados:

#legal-alpha("a)", [derechos económicos,])
#legal-alpha("b)", [derechos corporativos y de control, y])
#legal-alpha("c)", [derecho de liquidez o salida.])
Estos ámbitos no son automáticos ni inseparables, ni constituyen facultades de libre ejercicio individual, sino que se encuentran sujetos a las reglas del presente Protocolo y podrán ejercerse de manera independiente o condicionada, atendiendo a la preservación del interés patrimonial común, la continuidad del sistema y el control familiar efectivo.

=== Derechos Económicos
La titularidad de acciones confiere a su tenedor derechos económicos plenos sobre el capital social, los cuales serán reconocidos en todo momento con independencia del acceso o limitación a derechos corporativos o de control.

Dichos derechos comprenden, de manera enunciativa:

#legal-alpha("a)", [La participación proporcional en los beneficios y rendimientos que determinen los órganos competentes conforme al marco aplicable;])
#legal-alpha("b)", [El reconocimiento del valor patrimonial de las acciones; y])
#legal-alpha("c)", [El derecho a que dicho valor sea determinado mediante mecanismos de valuación objetivos, independientes y vinculantes en los supuestos previstos en este Protocolo.])
La limitación, suspensión o ausencia de derechos corporativos no afectará en ningún caso la subsistencia de los derechos económicos inherentes a la titularidad accionaria.

=== Derechos Corporativos y de Control
Los derechos corporativos y de control no derivan automáticamente de la titularidad accionaria ni constituyen facultades irrestrictas, sino que su ejercicio se encuentra condicionado al cumplimiento de los criterios de elegibilidad, alineación institucional y participación definidos en este Protocolo.

En particular, el ejercicio del derecho de voto, la participación en órganos de decisión, el acceso a información sensible y la intervención en decisiones estratégicas podrán ser diferenciados, limitados o reservados en función de:

#legal-alpha("a)", [La posición del accionista dentro del sistema familiar;])
#legal-alpha("b)", [Su grado de alineación con los principios rectores del Protocolo;])
#legal-alpha("c)", [Su pertenencia a estructuras activas o pasivas dentro del sistema; y])
#legal-alpha("d)", [Las necesidades de preservación del control familiar efectivo.])
En consecuencia, los derechos corporativos se configuran como facultades habilitadas y no como prerrogativas automáticas, subordinadas en todo momento a la continuidad empresarial y a la estabilidad institucional.

=== Derecho de Liquidez o Salida
El derecho de liquidez asociado a la titularidad accionaria se reconoce como una facultad de carácter regulado, cuyo ejercicio no es libre ni inmediato, sino que deberá sujetarse a los mecanismos institucionales previstos en este Protocolo.

Ningún accionista podrá exigir la libre transmisión de sus acciones ni imponer condiciones de salida que comprometan el equilibrio del sistema, la estabilidad institucional o el control familiar.

La materialización de la salida deberá realizarse exclusivamente a través de procedimientos internos, incluyendo mecanismos de adquisición entre accionistas, estructuras patrimoniales familiares o esquemas de pago diferido, conforme a valuaciones vinculantes y bajo criterios de equidad patrimonial y preservación del sistema.

=== Principio de Separación Funcional de Derechos
Para todos los efectos del presente Protocolo, se reconoce que los derechos económicos, los derechos corporativos y de control, y el derecho de liquidez constituyen esferas jurídicas autónomas que pueden coexistir, limitarse o ejercerse de manera independiente.

La restricción o suspensión de alguno de estos derechos no implicará la pérdida de los demás, salvo disposición expresa en contrario.

Este principio tiene por objeto evitar conflictos estructurales, impedir la subordinación del interés colectivo a intereses individuales y asegurar un modelo de propiedad ordenado, disciplinado y compatible con la continuidad del sistema familiar–empresarial.

== Definición Normativa de la Familia Empresaria
Para efectos exclusivos del presente Protocolo y de los instrumentos que de él deriven, la “familia empresaria” se define conforme a criterios funcionales que permiten organizar la relación entre propiedad, control y participación en la empresa.

Estas definiciones tienen un alcance estrictamente interno y no modifican, amplían ni restringen derechos de naturaleza civil, sucesoria o personal reconocidos por la legislación aplicable, limitándose a establecer un marco ordenado para la interacción entre familia y empresa.

La integración al sistema familiar–empresarial podrá, de manera excepcional, incluir a personas no consanguíneas conforme a lo dispuesto en el apartado 2.3.3.1. del presente Protocolo.

=== Familia Consanguínea en Línea Directa
Se reconoce que el sistema familiar se estructura a partir de ramas familiares, cada una derivada de una línea directa de ascendencia y descendencia, sobre la cual se articula la continuidad patrimonial y de control.

Para estos efectos, se considerará familia consanguínea en línea directa a los ascendientes y descendientes vinculados a cada rama, incluyendo generaciones subsecuentes.

Con el objeto de preservar claridad en la estructura patrimonial, evitar la dispersión del capital y mantener la coherencia del modelo de control, quedan excluidos los parientes colaterales que no formen parte de dicha línea directa.

=== Accionistas Familiares
Se considerarán accionistas familiares aquellas personas físicas que, siendo titulares de acciones, se ubiquen dentro de alguna de las categorías reconocidas en este Protocolo.

Esta calidad implica el reconocimiento de derechos económicos conforme a lo previsto en este instrumento, pero no conlleva, por sí misma, el acceso automático a derechos corporativos, de control o de participación en la gestión.

El ejercicio de dichos derechos quedará sujeto, en todo caso, a los criterios de elegibilidad, alineación institucional y participación dentro del sistema familiar, así como a la pertenencia a estructuras activas o pasivas conforme a lo dispuesto en este Capítulo.

=== Familia Política
Se entenderá por familia política a las personas vinculadas con miembros de la familia consanguínea en línea directa por matrimonio, concubinato u otras figuras legalmente reconocidas análogas.

Para efectos exclusivos del presente Protocolo, la familia política no formará parte del sistema familiar–empresarial por el solo hecho del matrimonio, concubinato u otra figura legalmente reconocida análoga. No obstante, sus integrantes podrán ser incorporados a dicho sistema conforme al procedimiento previsto en el apartado 2.3.3.1. del presente Protocolo, sin que dicha incorporación implique, por sí misma, adquisición de acciones, derechos corporativos, facultades de control o intervención directa en la gestión de la empresa.

En consecuencia, la pertenencia a esta categoría no confiere, en ningún caso, derechos originarios sobre las acciones ni acceso automático a derechos corporativos, de control, de información o de intervención en la gestión.

Como medida de protección patrimonial y preservación del control familiar, los miembros de la familia consanguínea en línea directa que contraigan matrimonio deberán hacerlo bajo el régimen de separación de bienes, o mediante mecanismos jurídicos equivalentes que aseguren la no comunicabilidad del patrimonio accionario.

No obstante lo anterior, cuando conforme a la legislación aplicable exista un derecho económico exigible vinculado al valor de las acciones, como la disolución del vínculo o del régimen patrimonial, dicho derecho será reconocido exclusivamente en su dimensión económica y deberá satisfacerse mediante los mecanismos de valuación y salida previstos en este Protocolo, sin perjuicio de la posibilidad de incorporación al sistema familiar-empresarial conforme al procedimiento previsto en el apartado 2.3.3.1.

==== Régimen de Incorporación de la Familia Política
La familia política podrá incorporarse al sistema familiar–empresarial mediante acuerdo expreso de la Asamblea de Familia adoptado conforme a las mayorías previstas en el presente Protocolo.

La incorporación deberá sustentarse en la alineación de la persona candidata con los principios, valores, visión de largo plazo y objetivos de continuidad del proyecto familiar–empresarial, así como en su disposición para asumir las obligaciones derivadas del presente Protocolo y de los reglamentos que de él emanen.

La incorporación deberá formalizarse mediante la suscripción de la Carta de Adhesión correspondiente, momento a partir del cual la persona incorporada quedará sujeta a los derechos, obligaciones, restricciones y mecanismos institucionales previstos en este instrumento.

No obstante lo anterior, se reconoce que las cónyuges de los accionistas fundadores, señores José Antonio Velasco Chedraui, David Velasco Chedraui y Jorge Velasco Chedraui, forman parte del núcleo familiar originario que ha acompañado la creación, desarrollo y consolidación del proyecto empresarial, por lo que su incorporación al sistema familiar–empresarial se tendrá por aprobada desde la entrada en vigor del presente Protocolo, bastando para ello la suscripción de la Carta de Adhesión correspondiente.

La incorporación al sistema familiar–empresarial no implicará por sí misma la adquisición o transmisión de acciones, derechos corporativos societarios, facultades de control, administración o representación de la sociedad, ni otorgará acceso automático a órganos de gobierno familiar o corporativo, salvo disposición expresa en contrario prevista en el presente Protocolo o acordada por los órganos competentes.

Las personas incorporadas conforme al presente apartado podrán participar en la Asamblea de Familia con los derechos y alcances que determine expresamente la propia Asamblea al momento de resolver su incorporación, los cuales deberán constar en el acuerdo correspondiente.

La Asamblea de Familia podrá determinar las condiciones, alcances y límites de participación aplicables a las personas incorporadas conforme al presente apartado.

La incorporación tendrá carácter personalísimo, no será transmisible por causa alguna y se extinguirá en los supuestos previstos en el presente Protocolo o por resolución adoptada conforme a los procedimientos institucionales correspondientes.

=== Descendencia No Tradicional
Se considerará dentro de esta categoría a aquellas personas que, conforme a la legislación aplicable, tengan reconocido un vínculo filial, incluyendo supuestos de reconocimiento posterior, adopción u otras figuras equivalentes.

==== Reconocimiento de Derechos Económicos
La descendencia no tradicional tendrá pleno reconocimiento de los derechos económicos que correspondan al valor patrimonial de las acciones, en condiciones de igualdad respecto de cualquier otro heredero.

Este reconocimiento se limitará al ámbito económico y se hará efectivo mediante los mecanismos de valuación y liquidez previstos en este Protocolo.

==== Régimen de Derechos Corporativos
El reconocimiento de derechos económicos no implica, por sí mismo, el acceso a derechos corporativos, de control o de participación en la gestión.

Dichos derechos solo podrán ejercerse cuando exista una habilitación expresa otorgada por el órgano familiar competente, mediante resolución formal, fundada y adoptada conforme a las mayorías requeridas.

Esta habilitación tendrá carácter excepcional, personal y no automático, no derivará del parentesco ni de la sucesión, y no generará precedente alguno, debiendo mantenerse siempre subordinada a la preservación del sistema y del control familiar.

=== Principio de Diferenciación Funcional
Las categorías previstas en el presente artículo tienen como finalidad establecer una distinción clara entre la titularidad económica y el ejercicio de derechos de control, permitiendo una organización coherente del sistema familiar.

Esta diferenciación responde a criterios institucionales y patrimoniales, y no tiene carácter discriminatorio, sino que busca evitar conflictos estructurales, delimitar ámbitos de participación y garantizar la continuidad del modelo de gobernanza familiar.

== Ramas Familiares Activas y Pasivas
Para efectos del presente Protocolo, se reconoce la distinción entre ramas familiares activas y pasivas como un criterio funcional orientado a preservar la eficiencia operativa, la estabilidad institucional y el control familiar efectivo.

Dicha clasificación atiende al grado de participación real de los accionistas en la gestión, dirección o conducción estratégica, y constituye una base legítima para diferenciar el ejercicio de derechos corporativos y de control, sin afectar en ningún caso los derechos económicos inherentes a la titularidad accionaria.

=== Ramas Familiares Activas
Se considerarán ramas familiares activas aquellas que, además de la titularidad accionaria, mantengan una participación efectiva, continua y verificable en funciones de dirección, gestión o toma de decisiones estratégicas.

La calificación como rama activa requerirá, de manera concurrente:

#legal-alpha("a)", [La participación directa de al menos uno de sus integrantes en funciones relevantes dentro de la organización;])
#legal-alpha("b)", [El cumplimiento de estándares de profesionalización y alineación con los principios del Protocolo; y])
#legal-alpha("c)", [El reconocimiento formal por parte del órgano familiar competente mediante resolución adoptada conforme a las reglas internas.])
Esta condición no deriva del parentesco, la antigüedad o la mera titularidad accionaria, y deberá mantenerse mediante el cumplimiento permanente de los criterios que la justifican.

=== Ramas Familiares Pasivas
Se considerarán ramas familiares pasivas aquellas que, aun siendo titulares de acciones y conservando plenamente sus derechos económicos, no participen de manera directa en la gestión o conducción estratégica.

Esta condición no tendrá carácter sancionatorio ni implicará limitación alguna en el ámbito económico. Sin embargo, no generará por sí misma acceso automático a derechos corporativos o de control.

De manera excepcional, podrá autorizarse la participación de integrantes de ramas pasivas en determinados derechos corporativos, siempre que dicha habilitación:

#legal-alpha("a)", [Sea expresa, fundada y aprobada conforme a las reglas internas;])
#legal-alpha("b)", [Responda a necesidades del sistema;])
#legal-alpha("c)", [Tenga carácter personal, temporal y revocable; y])
#legal-alpha("d)", [No genere precedentes ni derechos permanentes.])
=== Diferenciación en el Ejercicio de Derechos
La pertenencia a una rama activa o pasiva constituirá un criterio determinante para el ejercicio de derechos corporativos y políticos.

En particular, podrán reservarse total o parcialmente a integrantes de ramas activas:

#legal-alpha("a)", [El derecho de voto en decisiones estratégicas;])
#legal-alpha("b)", [La participación en órganos de decisión;])
#legal-alpha("c)", [La designación o remoción de cargos relevantes; y])
#legal-alpha("d)", [La intervención en mecanismos de supervisión o control.])
Fuera de estos supuestos, las ramas pasivas no ejercerán derechos adicionales de carácter político o de control, sin perjuicio del pleno reconocimiento de sus derechos económicos.

=== Protección Patrimonial y No Interferencia
Las ramas familiares pasivas conservarán en todo momento la protección íntegra de los derechos económicos de las acciones de las que sean titulares, sin que la limitación de derechos corporativos pueda interpretarse como afectación patrimonial.

La finalidad de esta diferenciación es evitar interferencias operativas, preservar la eficiencia en la toma de decisiones y prevenir conflictos derivados de la intervención de intereses no vinculados a la gestión activa del negocio.

=== Transición entre Ramas Activas y Pasivas
La condición de rama activa no es permanente y subsistirá únicamente mientras se mantengan los supuestos que la justifican.

Una rama perderá dicha condición cuando deje de contar, de forma efectiva y continua, con participación directa en la gestión conforme a los criterios establecidos, ya sea por desvinculación, retiro o cualquier otra circunstancia equivalente.

Esta transición producirá efectos en el ámbito interno y deberá formalizarse para efectos de registro y certeza, sin que afecte los derechos económicos de sus integrantes.

De manera excepcional, una rama pasiva podrá adquirir o recuperar la condición de activa cuando se acrediten nuevamente los requisitos correspondientes, previa validación conforme a los mecanismos internos aplicables.

En todos los casos, la transición entre categorías afectará exclusivamente el ejercicio de derechos corporativos y de control, sin incidir en la titularidad económica de las acciones.

== Permanencia Familiar y Restricciones a la Transmisión
La permanencia del capital en el ámbito familiar constituye un principio estructural del sistema de gobernanza y una condición indispensable para la preservación del control, la continuidad del proyecto empresarial y la estabilidad institucional.

En consecuencia, la transmisión de acciones se sujeta a un régimen restrictivo, ordenado y cerrado, en el que el interés patrimonial común prevalece sobre la liquidez individual del accionista.

=== Regla General de Permanencia en Manos Familiares
Como regla general, las acciones deberán mantenerse dentro del ámbito de accionistas familiares conforme a las categorías previstas en este Protocolo.

En ningún caso podrá disponerse de ellas de manera libre o discrecional, ya sea a título oneroso o gratuito, fuera de los supuestos expresamente autorizados.

Como principio estructural del modelo de control, al menos el cincuenta y uno por ciento (51%) del capital social deberá permanecer, en todo momento, bajo la titularidad directa o indirecta de miembros de la familia consanguínea en línea directa, asegurando la conservación del control familiar efectivo.

=== Restricción a la Transmisión a Terceros
Se prohíbe la transmisión de acciones a favor de terceros ajenos al sistema familiar, salvo autorización excepcional otorgada por el Consejo de Familia competente mediante resolución formal y adoptada conforme a las mayorías aplicables.

Dicha autorización tendrá carácter restrictivo y solo podrá concederse cuando se acrediten de manera conjunta los siguientes criterios:

#legal-alpha("a)", [Neutralidad de control: La operación no deberá implicar, directa o indirectamente, pérdida, dilución o alteración del control familiar, ni generar derechos de influencia estratégica, veto o bloqueo a favor del tercero.])
#legal-alpha("b)", [Neutralidad de participación: El tercero no adquirirá derechos corporativos, políticos ni de intervención en la gestión, limitándose su posición, en su caso, a una dimensión estrictamente económica.])
#legal-alpha("c)", [Salida obligatoria estructurada: La operación deberá prever mecanismos de salida que permitan la recomposición del capital en manos familiares, mediante valuación vinculante y sujeción a los derechos de adquisición interna previstos en este Protocolo, excluyendo cualquier permanencia indefinida del tercero.])
La ausencia de cualquiera de estos elementos impedirá la autorización.

En ningún caso la necesidad de liquidez individual, ni condiciones económicas favorables, justificarán la incorporación de terceros.

=== Derecho de Tanto Inter-Familiar
Toda transmisión de acciones, cualquiera que sea su origen, deberá sujetarse de manera obligatoria al derecho de adquisición preferente entre accionistas familiares.

Las acciones deberán ofrecerse en primer término a los integrantes del sistema, procurando mantener el equilibrio estructural entre ramas y evitando concentraciones incompatibles con el modelo definido en este Protocolo.

El ejercicio de este derecho se realizará, como regla general, de manera proporcional, sin que pueda generar:

#legal-alpha("a)", [Desplazamiento del control entre ramas,])
#legal-alpha("b)", [Concentración indebida, o])
#legal-alpha("c)", [Alteraciones en la arquitectura de propiedad.])
Cuando no sea posible ejercer este derecho en condiciones proporcionales, deberán privilegiarse soluciones institucionales que mantengan dicho equilibrio, tales como adquisiciones conjuntas, estructuras compartidas o vehículos patrimoniales.

Solo en casos excepcionales podrá suspenderse temporalmente la transmisión, cuando se acredite que no existe una alternativa viable que preserve el control y el equilibrio del sistema, debiendo documentarse dicha situación y explorarse previamente soluciones razonables.

Las transmisiones realizadas en contravención a este régimen carecerán de efectos internos, no podrán inscribirse y deberán ser rechazadas por los órganos competentes.

=== Derecho de Preferencia en Nuevas Emisiones
En cualquier aumento de capital o emisión de nuevas acciones, los accionistas familiares tendrán derecho preferente para suscribirlas en proporción a su participación, con el objeto de preservar el equilibrio de control entre ramas.

Este derecho constituye una condición esencial de validez de la emisión y deberá ejercerse de manera que no genere concentración, dilución o alteración en la estructura existente.

Cuando existan limitaciones de liquidez para ejercer dicho derecho, deberán explorarse mecanismos que permitan mantener la proporcionalidad sin afectar el control.

En caso de no ser posible garantizar dicho equilibrio, la emisión no deberá llevarse a cabo, salvo consentimiento expreso y unánime de los accionistas familiares. Las emisiones que contravengan estas disposiciones carecerán de efectos internos.

=== Supremacía del Control Familiar sobre la Liquidez Individual
El derecho de liquidez del accionista se encuentra subordinado, en todo momento, a la preservación del control familiar y al interés patrimonial común.

En consecuencia, ningún accionista podrá imponer decisiones que impliquen transmisión, dilución o alteración del control, aun cuando existan beneficios económicos individuales.

Esta limitación no afecta el reconocimiento de los derechos económicos de las acciones de las que sean titulares, los cuales deberán satisfacerse conforme a lo establecido en el apartado 2.2.1. del presente Protocolo.

== Prohibición de Gravámenes, Garantías y Uso Instrumental de las Acciones
Las acciones constituyen un activo estratégico vinculado al control y a la continuidad del sistema familiar, cuya titularidad se encuentra sujeta a un régimen institucional de carácter heterónomo, en el que su uso, disposición y afectación quedan subordinados a la preservación del proyecto empresarial y del control familiar.

En consecuencia, no podrán ser utilizadas como instrumento de garantía, respaldo crediticio o mecanismo de aseguramiento de obligaciones ajenas a la operación del negocio, ni ser objeto de actos que comprometan directa o indirectamente la estabilidad del sistema.

Las acciones quedan sujetas a un régimen de indisponibilidad frente a terceros, orientado a evitar su ejecución forzada, la introducción de riesgos externos y cualquier afectación —directa o indirecta— al control familiar, prevaleciendo en todo momento el interés del sistema sobre cualquier disposición individual.

=== Prohibición de Gravámenes y Garantías
Queda prohibida, de manera absoluta, la constitución de cualquier tipo de gravamen o garantía sobre las acciones, incluyendo su uso como prenda, colateral, aval, fianza o cualquier mecanismo equivalente.

Esta prohibición comprende toda forma directa o indirecta de afectación mediante la cual las acciones sean utilizadas como respaldo de obligaciones personales, familiares o empresariales ajenas al sistema.

=== Ineficacia de Actos Contrarios
Todo acto celebrado en contravención a lo dispuesto en este Capítulo carecerá de efectos internos, no podrá ser reconocido por la organización ni inscrito en los registros correspondientes.

Los órganos de administración tendrán la obligación de rechazar cualquier intento de inscripción o reconocimiento y de adoptar las medidas necesarias para salvaguardar la integridad del capital y el control familiar, garantizando en todo momento que al menos el cincuenta y uno por ciento (51%) del capital social permanezca bajo la titularidad directa o indirecta de la familia consanguínea en línea directa.

=== Protección frente a Acreedores Personales
Las obligaciones personales asumidas por los accionistas forman parte de su esfera patrimonial individual y no deberán comprometer, directa ni indirectamente, el patrimonio representado por las acciones.

Todo accionista estará obligado, de manera inexcusable, continua y oportuna, a informar al Consejo de Familia cualquier compromiso financiero relevante que pretenda asumir, así como toda circunstancia sobreviniente que pueda afectar su solvencia, su capacidad de cumplimiento o comprometer, directa o indirectamente, la integridad del patrimonio accionario. Dicha obligación comprende, de manera enunciativa, la existencia o inicio de procesos judiciales, administrativos o actos de autoridad que puedan derivar en medidas de ejecución o en riesgos de afectación patrimonial.

Cuando exista un riesgo razonable de ejecución o insolvencia, podrán implementarse medidas preventivas orientadas a separar el patrimonio personal del accionista del patrimonio accionario, incluyendo la utilización de vehículos patrimoniales que aseguren la integridad del sistema, sin afectar derechos de terceros ni incurrir en simulación.

En caso de embargo, adjudicación o intento de transmisión forzada derivado de obligaciones personales:

#legal-alpha("a)", [La afectación se limitará exclusivamente al valor económico de las acciones;])
#legal-alpha("b)", [No se reconocerán derechos corporativos, de control o de participación a favor de terceros;])
#legal-alpha("c)", [Y la situación deberá sujetarse a los mecanismos internos de valuación y recomposición patrimonial previstos en este Protocolo.])
El incumplimiento del deber de notificación o la ocultación de riesgos relevantes podrá dar lugar a la activación de mecanismos correctivos, incluyendo la salida del accionista conforme a lo dispuesto en este instrumento.

=== Vinculación con el Régimen de Operaciones entre Familiares
Las disposiciones del presente Capítulo se vinculan con el régimen aplicable a préstamos, apoyos financieros y relaciones económicas entre miembros de la familia.

En ningún caso dichas operaciones podrán garantizarse con acciones ni generar derechos de control, voto, ejecución o apropiación sobre las mismas.

== Liquidez Patrimonial y Mecanismos de Salida
La liquidez del accionista no constituye un derecho de ejercicio libre ni inmediato, sino una facultad patrimonial de carácter ordenado que deberá ejercerse exclusivamente a través de los mecanismos institucionales previstos en este Protocolo, con el objeto de preservar la estabilidad del sistema, la continuidad del proyecto empresarial y el control familiar efectivo. En ningún caso la salida de un accionista podrá implicar la incorporación de terceros no autorizados, la alteración de la estructura de control o la generación de disrupciones operativas o patrimoniales al interior del sistema familiar.

=== Salida Voluntaria
La salida voluntaria es el mecanismo mediante el cual un accionista decide desvincularse patrimonialmente sin que exista incumplimiento o causa imputable al sistema. Para su ejercicio, el accionista deberá presentar solicitud formal al órgano familiar competente, manifestando su intención de transmitir la totalidad de sus acciones y sujetándose íntegramente a las disposiciones del presente Protocolo, sin que dicha solicitud le confiera facultad alguna para negociar con terceros ni para imponer condiciones distintas a las aquí previstas.

Recibida la solicitud, se activará el procedimiento de valuación conforme a los mecanismos establecidos en este Protocolo, el cual deberá realizarse mediante un tercero independiente bajo metodologías objetivas y cuyo resultado tendrá carácter definitivo, vinculante y obligatorio para todas las partes. Determinado el valor, la transmisión de las acciones quedará sujeta de manera obligatoria al derecho de adquisición preferente entre accionistas familiares, debiendo ofrecerse en primer término dentro del sistema y respetando el equilibrio estructural de propiedad y control, sin que en ningún caso la organización pueda adquirir directamente dichas acciones.

El pago del valor correspondiente se realizará, como regla general, mediante un esquema diferido que permita preservar la liquidez del sistema y evitar afectaciones operativas o patrimoniales. Salvo acuerdo distinto, se contemplará un pago inicial y un esquema de pagos periódicos dentro de un plazo determinado, con devengo de intereses sobre saldos insolutos conforme a una tasa de referencia objetiva más un margen adicional. Durante dicho periodo, el accionista saliente conservará exclusivamente un derecho de crédito de naturaleza económica frente a los adquirentes, quedando privado de manera inmediata y definitiva de todo derecho corporativo, político o de control. El eventual incumplimiento en los pagos dará lugar únicamente a las acciones de cobro correspondientes, sin que en ningún caso implique la restitución de derechos corporativos ni la reversión de la transmisión.

=== Salida Forzada
La salida forzada constituye un mecanismo excepcional de protección del sistema familiar y empresarial, mediante el cual se impone la desvinculación patrimonial de un accionista cuya permanencia resulte incompatible con la estabilidad, la alineación institucional o la integridad del modelo de gobernanza. Su procedencia se limita a supuestos objetivos y verificables, tales como el incumplimiento grave de las disposiciones del Protocolo, la pérdida de alineación con los principios estructurales del sistema o la generación de riesgos o afectaciones relevantes para la continuidad, operación o control del proyecto empresarial.

La determinación de la salida forzada deberá realizarse mediante un procedimiento interno que garantice, como mínimo, la notificación clara de los hechos imputados, el derecho de audiencia del accionista involucrado y la emisión de una resolución fundada por el Consejo de Familia, conforme a las mayorías establecidas. Dicha resolución tendrá efectos inmediatos en el ámbito interno y no se suspenderá por la existencia de controversias, sin perjuicio de la subsistencia íntegra de los derechos económicos del accionista afectado.

Una vez determinada la procedencia de la salida forzada, los accionistas familiares estarán obligados a adquirir la totalidad de las acciones del accionista excluido, conforme a los mecanismos de valuación, adquisición y pago previstos para la salida voluntaria, sin que ello implique en ningún caso la incorporación de terceros ni la adquisición por parte de la organización. La naturaleza forzada de la salida no dará lugar a penalización alguna sobre el valor económico de las acciones, el cual deberá respetarse íntegramente conforme a la valuación correspondiente.

Desde la emisión de la resolución, el accionista afectado quedará privado de manera inmediata, definitiva e irrevocable de todo derecho corporativo, político o de control, incluyendo voto, acceso a órganos de decisión o cualquier forma de intervención en la gestión, conservando únicamente un derecho económico de crédito hasta la liquidación total de su participación. En ningún caso la existencia de pagos diferidos, controversias o acciones de cobro podrá dar lugar a la restitución, suspensión o reactivación de dichos derechos.

== Principios Rectores de la Sucesión Accionaria
La sucesión accionaria se regirá por el principio de continuidad patrimonial sin disrupción del control, reconociendo a los herederos el derecho al valor económico de las acciones, sin que ello implique la transmisión automática de la condición de socio ni de derechos corporativos. En consecuencia, la sucesión deberá ejecutarse de manera ordenada, previsible y plenamente compatible con la arquitectura de propiedad, control y liquidez definida en este Protocolo, preservando en todo momento la estabilidad institucional y la libertad de asociación del sistema familiar.

=== Transmisión del Valor Patrimonial por Sucesión
La transmisión de acciones por causa de muerte dará lugar, en todo caso, al reconocimiento del valor patrimonial íntegro de las acciones a favor de los herederos o legatarios, conforme a los mecanismos de valuación previstos en este Protocolo. Este reconocimiento se circunscribe, por principio, al ámbito económico, sin que la sucesión implique por sí misma la incorporación automática del heredero como accionista con derechos corporativos o de control.

=== No Transmisión Automática de Derechos Corporativos
La adquisición de acciones por sucesión no confiere, de manera automática, derechos de voto, acceso a órganos de decisión, participación en la gestión ni prerrogativas de control. El ejercicio de dichos derechos quedará sujeto al cumplimiento de los criterios de elegibilidad, alineación institucional y pertenencia al sistema familiar previstos en este Protocolo, sin que el parentesco, la vocación hereditaria o la titularidad económica constituyan por sí mismos fundamento suficiente para el acceso al control o a la asociación activa.

=== Derecho de Asociación y Control de Integración
El sistema familiar se reserva la facultad de determinar la integración de la estructura accionaria y de sus órganos de decisión, pudiendo limitar o negar el acceso corporativo a herederos cuando su incorporación resulte incompatible con la estabilidad, la gobernanza o la continuidad del proyecto. En estos supuestos, deberá garantizarse en todo momento el reconocimiento y pago íntegro de los derechos económicos del heredero mediante los mecanismos de valuación, adquisición inter-familiar o salida institucional previstos en este Protocolo, sin que ello implique afectación alguna a su patrimonio.

=== Remisión al Régimen Específico de Ejecución
La ejecución operativa de la sucesión accionaria, incluyendo procedimientos, plazos, administración transitoria, valuación y, en su caso, mecanismos de adquisición o salida, se regirá por las disposiciones específicas contenidas en el Capítulo correspondiente del presente Protocolo. Las reglas aquí previstas tendrán carácter rector para la interpretación del régimen sucesorio accionarial, en coordinación con los Estatutos Sociales y la legislación aplicable.

== Valuación del Capital Accionario
La valuación del capital accionario constituye un mecanismo técnico, objetivo y de carácter vinculante destinado a determinar el valor económico de las acciones en los supuestos previstos en este Protocolo, con independencia de intereses individuales, discrepancias entre accionistas o controversias internas. Su finalidad se limita exclusivamente a la cuantificación del valor patrimonial, sin implicar en ningún caso reconocimiento de derechos corporativos, políticos o de control.

=== Supuestos de Activación Obligatoria
La valuación se activará de pleno derecho, sin necesidad de acuerdo adicional, cuando se actualice cualquiera de los supuestos previstos en este Protocolo, incluyendo la salida voluntaria o forzada de un accionista, la transmisión de valor derivada de procesos sucesorios o la adquisición inter-familiar de acciones. La simple actualización objetiva del supuesto correspondiente será suficiente para detonar el procedimiento, sin que pueda condicionarse a autorizaciones discrecionales ni a decisiones de órganos sociales.

=== Metodología de Cálculo
La valuación del capital accionario de la Sociedad se realizará mediante una metodología financiera objetiva, consistente y verificable, basada en la proyección del EBITDA (Earnings Before Interest, Taxes, Depreciation and Amortization).

Dicha valuación será obligatoria en todos los supuestos que impliquen la determinación del valor de las acciones y estará a cargo de un contador público independiente con experiencia en valuación de negocios, quien actuará como valuador.

Para efectos de la presente cláusula, la valuación se sujetará a las siguientes reglas:

#legal-alpha("a)", [Horizonte de proyección: El EBITDA se proyectará por un periodo de seis ejercicios fiscales completos y consecutivos posteriores a la fecha de valuación, tomando como base la información financiera histórica disponible y las condiciones reales del negocio. Las proyecciones deberán sustentarse en criterios razonables, consistentes y verificables, quedando prohibida la incorporación de supuestos discrecionales, escenarios extraordinarios o expectativas no sustentadas.])
#legal-alpha("b)", [Determinación del EBITDA: El EBITDA deberá reflejar la operación real del negocio y será ajustado por el valuador conforme a criterios financieros generalmente aceptados, debiendo en todo caso:])
#legal-roman("i.", [Excluir ingresos o gastos extraordinarios, no recurrentes o ajenos a la operación normal;])
#legal-roman("ii.", [Ajustar operaciones entre partes relacionadas a valor de mercado;])
#legal-roman("iii.", [Eliminar efectos contables que no representen flujo económico real; y])
#legal-roman("iv.", [Considerar únicamente conceptos recurrentes y propios de la actividad ordinaria de la Sociedad.])
#legal-alpha("c)", [Determinación del valor de la empresa: El valor de la empresa se determinará con base en el EBITDA proyectado, aplicando un múltiplo razonable consistente con el sector, tamaño, perfil de riesgo y condiciones de mercado en que opere la Sociedad. El múltiplo deberá sustentarse en información objetiva, comparables de mercado y criterios financieros generalmente aceptados, debiendo el valuador justificar su selección en el dictamen correspondiente.])
#legal-alpha("d)", [Determinación del valor del capital accionario: Al valor de la empresa deberán realizarse los ajustes necesarios para determinar el valor del capital accionario, incluyendo, en su caso:])
#legal-roman("i.", [La deducción de la deuda financiera neta;])
#legal-roman("ii.", [La adición de efectivo no operativo; y])
#legal-roman("iii.", [Cualquier otra partida relevante que impacte materialmente el valor económico de la Sociedad.])
El valor por acción se determinará dividiendo el valor del capital accionario entre el número total de acciones en circulación al momento de la valuación, considerando, en su caso, la existencia de series accionarias con derechos diferenciados.

#legal-alpha("e)", [Intervención del valuador y acompañamiento técnico: La valuación deberá ser realizada por un contador público independiente con experiencia en valuación de negocios. Adicionalmente, el proceso de valuación deberá ser acompañado y supervisado en su desarrollo por el C.P. Roberto Ledesma Cruz, quien fungirá como asesor técnico de la familia, participando en la revisión de información, validación de supuestos y seguimiento metodológico del proceso, sin sustituir en ningún caso la función del valuador independiente. En caso de que el C.P. Roberto Ledesma Cruz no pueda o no desee participar en el proceso de valuación, o exista cualquier impedimento para ello, la familia deberá designar por unanimidad a una persona con perfil técnico equivalente que asuma dicha función de acompañamiento. La ausencia de designación sustituta no suspenderá el proceso de valuación, siempre que el valuador independiente cuente con la información suficiente para llevarlo a cabo.])
#legal-alpha("f)", [Metodologías auxiliares: El valuador podrá emplear metodologías adicionales únicamente como referencia de contraste, sin que en ningún caso puedan sustituir o modificar el resultado obtenido conforme a la metodología principal aquí establecida.])
#legal-alpha("g)", [Carácter vinculante del resultado: La metodología de valuación, su ejecución por el valuador independiente y el resultado que de ella derive tendrán carácter obligatorio y vinculante para todas las partes, siempre que no adolezcan de error material evidente o desviación metodológica relevante. El resultado no estará sujeto a renegociación por mera inconformidad con el valor determinado.])
=== Carácter Vinculante del Resultado
El resultado de la valuación tendrá carácter definitivo, obligatorio y vinculante para todas las partes involucradas, incluyendo accionistas, herederos y cualquier tercero con derecho económico. No será susceptible de renegociación, revisión discrecional ni repetición del procedimiento por inconformidad con el valor obtenido, quedando expresamente excluida cualquier segunda valuación o ajuste posterior, salvo la corrección de errores materiales evidentes.

La existencia de controversias, mecanismos de solución alternativa o acciones de cobro no suspenderá la eficacia del resultado ni la ejecución de los efectos económicos derivados del mismo, los cuales deberán cumplirse conforme a lo previsto en este Protocolo.

=== Canalización de Controversias
Cualquier controversia relacionada con la aplicación del procedimiento de valuación o con la ejecución de sus efectos económicos deberá canalizarse, de manera obligatoria y previa a cualquier instancia externa, a los mecanismos internos de solución de conflictos previstos en este Protocolo.

En ningún caso la existencia de una controversia podrá suspender, retrasar o condicionar la aplicación del resultado de la valuación ni la ejecución de los mecanismos de adquisición, salida o pago correspondientes.

== Control Familiar Efectivo
El presente Capítulo tiene por objeto asegurar y preservar el control efectivo en manos de la familia como un elemento estructural indispensable para la continuidad del proyecto empresarial, la estabilidad institucional y la coherencia del modelo de gobierno. Sus disposiciones no regulan la operación cotidiana, sino que establecen los principios, límites y mecanismos que garantizan que las decisiones estratégicas y de poder permanezcan bajo dominio familiar, con independencia de la distribución económica del capital o de circunstancias coyunturales.

=== Principio de Control Mayoritario Familiar
El control efectivo deberá permanecer en todo momento, directa o indirectamente, en manos de los accionistas familiares como principio permanente y no negociable. Se entenderá por control efectivo la capacidad real y operativa de determinar decisiones estratégicas, estructurales y de gobierno, con independencia de la titularidad formal del capital.

Como manifestación mínima de dicho control, al menos el cincuenta y uno por ciento (51%) del capital social deberá permanecer, en todo momento, bajo la titularidad directa o indirecta de los accionistas familiares, sin que pueda configurarse estructura, acto u operación alguna que tenga como efecto su reducción, dilución o neutralización.

En consecuencia, ningún acto, operación, estructura o acuerdo, aun cuando sea jurídicamente válido, podrá tener como efecto la pérdida, afectación o desplazamiento del control familiar. Cualquier decisión que comprometa este principio se considerará contraria al Protocolo y deberá ser rechazada, revertida o ajustada por los órganos competentes, aun cuando hubiese sido formalmente aprobada conforme a otros instrumentos.

=== Materias Reservadas
Se considerarán materias reservadas aquellas decisiones que, por su naturaleza o impacto, incidan en la estructura de control, en la estabilidad patrimonial o en la continuidad del proyecto empresarial, quedando sujetas a un régimen reforzado de aprobación.

Tendrán este carácter, entre otras, las decisiones relativas a modificaciones de capital o derechos accionarios, transmisiones que alteren el control, reformas estatutarias en aspectos estructurales, reestructuras corporativas, disposición de activos estratégicos, contratación de financiamiento relevante, celebración de acuerdos que incidan en el poder corporativo y la designación o modificación de órganos de gobierno, así como la incorporación de integrantes de la familia política al sistema familiar–empresarial. Asimismo, se incluirá cualquier decisión que, aun no prevista expresamente, tenga como efecto directo comprometer el control familiar efectivo.

Estas materias no podrán aprobarse mediante mayorías simples ni por mecanismos implícitos, debiendo sujetarse estrictamente a los requisitos reforzados previstos en este Capítulo.

=== Régimen de Mayorías Reforzadas
Las materias reservadas únicamente podrán adoptarse cuando cuenten con autorización previa de la Asamblea de Familia mediante resolución formal, la cual constituirá un requisito indispensable para su validez. Sin dicha autorización, la decisión no podrá someterse a aprobación de órganos societarios ni ejecutarse bajo ninguna circunstancia.

La aprobación requerirá la concurrencia simultánea de una mayoría calificada de capital familiar y de una mayoría por ramas familiares activas, con el objeto de evitar concentraciones de poder o desplazamientos estructurales entre ramas. Una vez obtenida la autorización, la decisión podrá formalizarse en los órganos correspondientes, reproduciendo en lo conducente las mayorías previstas en este Protocolo.

En caso de que no se alcancen las mayorías requeridas en intentos sucesivos, la materia deberá canalizarse a mecanismos internos de solución de controversias, sin que proceda su judicialización directa ni su imposición por vías alternas.

=== Derecho de Veto Familiar
El derecho de veto tiene por objeto impedir la ejecución de decisiones que, aun cumpliendo formalmente con las mayorías requeridas, resulten incompatibles con la preservación del control, el equilibrio entre ramas o la continuidad del sistema.

Este derecho solo podrá ejercerse respecto de materias reservadas y por integrantes legitimados del sistema familiar, mediante manifestación fundada cuando la decisión genere riesgos de pérdida de control, alteración estructural, afectación grave a la estabilidad o compromisos irreversibles para el proyecto.

El ejercicio válido del veto suspenderá de manera definitiva la decisión en su versión aprobada, la cual únicamente podrá modificarse para eliminar las causas que lo originaron o, en su defecto, archivarse. Su uso deberá limitarse a la protección del sistema, quedando prohibido su ejercicio abusivo o con fines obstructivos.

=== Designación y Control de Órganos Sociales
La integración, designación, remoción y control de los órganos sociales se regirá por el principio de control familiar efectivo, debiendo sujetarse a las reglas de materias reservadas cuando incidan en la estructura de poder.

La Asamblea de Familia tendrá la facultad de establecer criterios de elegibilidad, alineación y confianza para quienes integren dichos órganos, así como de autorizar o vetar su designación, sin intervenir en la gestión operativa cotidiana.

Los órganos sociales deberán ejercer sus funciones dentro del marco de control familiar definido en este Protocolo, quedando prohibida cualquier práctica que implique su desplazamiento o neutralización. Las designaciones o decisiones adoptadas en contravención a estas reglas carecerán de validez interna y deberán ser corregidas conforme a los mecanismos previstos.


// ==============================================================================
// CAPÍTULO 03: Gobierno Corporativo Familiar, Institucionalización y Régimen de Profesionalización
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (2) previas a Chapter Opening 03
#ceremonial-blank-page()
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 03
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-03") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "03",
    title: [Gobierno Corporativo Familiar, Institucionalización y Régimen de Profesionalización],
    opening_title: ("GOBIERNO CORPORATIVO", "FAMILIAR,", "INSTITUCIONALIZACIÓN Y", "RÉGIMEN DE", "PROFESIONALIZACIÓN"),
    description: [Órganos de gobierno, roles familiares, incorporación laboral y \ profesionalización de la gestión empresarial.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 03
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 03
#metadata(3) <chapter-marker>
#metadata("first-03") <chapter-first-marker>
#counter(heading).update((3, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "03" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[03]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      GOBIERNO CORPORATIVO \ 
      FAMILIAR, \ 
      INSTITUCIONALIZACIÓN Y \ 
      RÉGIMEN DE \ 
      PROFESIONALIZACIÓN
    ]
  ]
}

#v(225.81pt)

== Principio de Institucionalización y Jerarquía Normativa Interna
El presente Capítulo establece el régimen de gobierno corporativo familiar bajo un principio de institucionalización plena, conforme al cual el ejercicio del poder familiar, la adopción de decisiones estratégicas y el acceso a posiciones de gobierno o ejecución se sujetan exclusivamente a un marco normativo interno expreso, jerarquizado y vinculante. En consecuencia, queda excluida cualquier forma de ejercicio personal, informal o discrecional del poder, sustituyéndose por un sistema estructurado de normas, órganos, competencias y procedimientos cuya observancia resulta obligatoria para todos los integrantes del sistema familiar–empresarial, con independencia de su participación accionaria, antigüedad o posición patrimonial.

Este régimen no regula derechos económicos, corporativos ni mecanismos de control o liquidez —los cuales se rigen por el Capítulo 2— sino que tiene por objeto ordenar el ejercicio del poder familiar, definir la arquitectura institucional del gobierno corporativo y establecer las barreras de acceso a posiciones de decisión, evitando la captura informal de la organización y preservando la estabilidad y continuidad del sistema.

=== Principio de Institucionalización del Sistema Familiar–Empresarial
El sistema familiar–empresarial se rige por un principio de institucionalización estricta, en virtud del cual la empresa deja de operar como una extensión natural de la familia y se consolida como una organización jurídicamente estructurada, gobernada por reglas impersonales, órganos definidos y competencias delimitadas. En este contexto, toda decisión con impacto estratégico, patrimonial o de control deberá adoptarse exclusivamente a través de los órganos competentes y conforme a los procedimientos previstos en este Protocolo, quedando excluidas las decisiones informales, personales o consuetudinarias, aun cuando provengan de personas con influencia histórica o patrimonial.

La institucionalización implica además la separación objetiva entre vínculo familiar y ejercicio del poder, de modo que el parentesco, la antigüedad o la titularidad accionaria no constituyen fuente de autoridad ni habilitación decisoria fuera de los cauces normativos establecidos. Cualquier desviación de este principio se considerará una afectación directa al sistema de gobernanza y dará lugar a la activación de los mecanismos internos de control y consecuencias previstos en este Protocolo.

=== Jerarquía Normativa Interna y Regla de Especialidad
El sistema de gobernanza familiar se rige por una jerarquía normativa interna obligatoria que asegura coherencia, evita conflictos de interpretación y delimita claramente las esferas de regulación. En este orden, el Protocolo Familiar prevalece en todo lo relativo a la relación familia–empresa y al control familiar; los Estatutos Sociales regulan el ámbito societario conforme a la legislación aplicable; el Protocolo General de Gobierno y Cumplimiento organiza la función ejecutiva y operativa; y los reglamentos internos y demás instrumentos complementarios operan de manera subordinada dentro de su ámbito específico.

En caso de conflicto entre normas, se aplicará la regla de especialidad funcional, conforme a la cual prevalecerá la disposición que regule de manera directa la materia involucrada, quedando prohibida cualquier interpretación que permita la invasión de una esfera por otra. Ningún instrumento de rango inferior podrá modificar, neutralizar o eludir las disposiciones del presente Protocolo, ni directa ni indirectamente.

La jerarquía normativa y la delimitación competencial tienen carácter vinculante y autoaplicativo, por lo que cualquier acto, decisión o instrucción emitida por persona u órgano distinto al competente, o fuera de su ámbito de atribuciones, carecerá de efectos internos y no generará obligación de cumplimiento dentro del sistema familiar–empresarial.

== Régimen de Separación Funcional entre Propiedad, Gobierno y Operación
El sistema de gobierno corporativo familiar se sustenta en un régimen de separación funcional estricta, objetiva y no negociable entre las esferas de propiedad accionaria, gobierno corporativo familiar y operación empresarial, como condición indispensable para la institucionalización del poder, la profesionalización de la organización y la preservación del control familiar efectivo. Esta separación tiene carácter estructural y vinculante, y tiene por objeto evitar la confusión de roles, la concentración informal de poder, la captura operativa por intereses familiares y la desnaturalización de las funciones propias de cada ámbito. En consecuencia, ninguna persona, órgano o grupo podrá ejercer funciones correspondientes a una esfera distinta de aquella a la que pertenece, bajo ningún título o circunstancia, salvo en los supuestos excepcionales expresamente previstos en este Protocolo.

=== Propiedad Accionaria como Esfera Patrimonial sin Atribuciones de Gobierno ni de Ejecución
La propiedad accionaria se configura como una esfera de naturaleza exclusivamente patrimonial, sujeta al régimen disciplinado y funcionalmente separado establecido en el Capítulo 2 del presente Protocolo, el cual se tiene por reproducido en lo conducente. La titularidad de acciones no constituye fuente de autoridad institucional ni habilita por sí misma el ejercicio de funciones de gobierno, decisión estratégica o intervención en la operación del negocio.

El ejercicio de los derechos derivados de la propiedad deberá realizarse únicamente a través de los mecanismos y órganos competentes, dentro de los límites establecidos, sin que sea jurídicamente admisible su utilización como medio de presión, influencia informal o instrucción operativa. Cualquier conducta que pretenda extender la propiedad accionaria más allá de su ámbito patrimonial carecerá de efectos internos y no generará obligación alguna para los órganos de gobierno ni para la esfera ejecutiva.

=== Gobierno Corporativo Familiar como Esfera de Decisión Estratégica y Control Institucional
El gobierno corporativo familiar constituye una esfera autónoma de naturaleza estratégica, normativa y de control institucional, orientada a definir principios, políticas, decisiones estructurales y mecanismos de preservación del sistema familiar–empresarial. Su función se limita a la conducción institucional del proyecto y al resguardo del control familiar, quedando excluida cualquier forma de ejecución operativa, administración cotidiana o intervención directa en la gestión.

El ejercicio de estas facultades deberá realizarse exclusivamente a través de los órganos previstos en este Protocolo y dentro de sus límites competenciales, quedando prohibido cualquier ejercicio informal, personalista o extrainstitucional. Toda intervención que pretenda sustituir, condicionar o invadir la esfera operativa carecerá de eficacia interna y no generará efecto vinculante alguno.

=== Operación Empresarial como Esfera Ejecutiva Autónoma
La operación empresarial constituye una esfera ejecutiva autónoma, profesional y técnicamente especializada, responsable de la gestión ordinaria, la administración de recursos y la ejecución de la estrategia aprobada por los órganos competentes. Su ejercicio corresponde exclusivamente a la dirección general y al equipo directivo, conforme a los marcos normativos aplicables y bajo los mecanismos formales de supervisión establecidos.

Las decisiones técnicas, comerciales, administrativas, financieras y de recursos humanos forman parte de esta esfera y deberán adoptarse sin interferencia de la propiedad accionaria ni del gobierno corporativo familiar, salvo en los supuestos expresamente previstos. En ningún caso la operación quedará sujeta a instrucciones informales, presiones familiares o acuerdos no institucionales, los cuales carecerán de toda eficacia dentro del sistema.

=== Prohibición de Intervención Cruzada y Supuestos Excepcionales
Se prohíbe de manera absoluta toda intervención cruzada entre las esferas de propiedad, gobierno y operación, entendiéndose por tal cualquier actuación mediante la cual una persona u órgano ejerza funciones o influya en decisiones propias de una esfera distinta a la que pertenece. Esta prohibición tiene carácter estructural y solo admite excepción en los supuestos expresamente previstos en este Protocolo, los cuales deberán interpretarse de forma estricta y no extensiva.

No constituirá intervención indebida la adopción de decisiones estratégicas por los órganos de gobierno dentro de su competencia, la formalización de dichas decisiones por los órganos societarios correspondientes ni la supervisión institucional ejercida sin sustitución operativa. Fuera de estos supuestos, cualquier intervención cruzada será considerada infracción al régimen de separación funcional y deberá calificarse conforme a las disposiciones aplicables.

=== Coordinación y Límites de los Órganos Societarios
El presente Protocolo reconoce a los órganos societarios como instancias regidas por la legislación aplicable y por los Estatutos Sociales, cuyas competencias no se ven sustituidas por las decisiones del gobierno corporativo familiar. Dichas decisiones constituyen el marco institucional dentro del cual los accionistas deberán ejercer sus derechos societarios, actuando de manera coherente con el presente Protocolo y absteniéndose de promover acuerdos que lo contravengan o que impliquen invasión de esferas funcionales.

La relación entre órganos familiares y societarios se rige por un principio de coherencia institucional y no de subordinación operativa, de modo que el Protocolo no impone obligaciones a terceros no adheridos ni modifica el régimen legal aplicable, pero sí vincula plenamente a quienes forman parte del sistema familiar–empresarial.

== Órganos de Gobierno Corporativo Familiar
El gobierno corporativo familiar se ejercerá exclusivamente a través de los órganos previstos en el presente Protocolo, los cuales constituyen los únicos canales institucionales válidos para la deliberación, adopción y conducción de decisiones familiares con impacto estratégico, patrimonial o de control. Este esquema responde al principio de institucionalización del sistema familiar–empresarial y tiene por objeto eliminar la personalización del poder, evitar la informalidad decisoria y prevenir conflictos derivados de la confusión entre familia, propiedad y empresa. En consecuencia, fuera de dichos órganos no existirá autoridad familiar con capacidad decisoria vinculante, careciendo de efectos internos cualquier manifestación de voluntad emitida de manera individual, informal o al margen de los cauces institucionales previstos.

La integración, funcionamiento y reglas orgánico–procedimentales de estos órganos se regirán por sus respectivos reglamentos internos, los cuales tendrán carácter obligatorio en el ámbito interno, sin que puedan ampliar competencias, modificar la distribución funcional del poder ni contravenir las disposiciones del presente Protocolo.

=== Asamblea de Familia
La Asamblea de Familia constituye el órgano supremo del sistema de gobierno corporativo familiar y es el espacio institucional a través del cual se expresa la voluntad colectiva de la familia empresaria en materias estratégicas, estructurales y de control. Su función se limita a la definición de decisiones de alto nivel que incidan en la arquitectura patrimonial, el control familiar efectivo y la continuidad del proyecto empresarial, incluyendo aquellas calificadas como materias reservadas en este Protocolo.

La Asamblea no tiene carácter operativo ni ejecutivo y no ejercerá funciones de administración, gestión cotidiana ni dirección técnica, quedando dichas funciones reservadas a los órganos societarios y a la esfera operativa. Sus decisiones tendrán carácter vinculante en el ámbito interno y constituirán el marco institucional dentro del cual los accionistas deberán ejercer sus derechos societarios y los órganos competentes formalizar o ejecutar lo conducente conforme a la legislación aplicable.

El ejercicio de sus atribuciones deberá realizarse exclusivamente mediante convocatorias formales, deliberación colegiada y resoluciones debidamente documentadas, quedando excluido cualquier ejercicio informal, personalista o implícito de su autoridad. Toda manifestación de voluntad emitida fuera de este órgano carecerá de eficacia institucional y no producirá efecto alguno dentro del sistema.

=== Consejo de Familia
El Consejo de Familia constituye el órgano permanente de gobierno corporativo familiar y tiene como función central asegurar la aplicación continua, coherente y efectiva del presente Protocolo, así como preservar el control familiar y la estabilidad institucional del sistema. Su ámbito de actuación es estratégico y de control, comprendiendo la interpretación del Protocolo, la verificación de su cumplimiento, la activación de mecanismos previstos y la resolución de materias que le sean expresamente atribuidas.

El Consejo no tiene carácter operativo ni ejecutivo, por lo que no podrá intervenir en la gestión cotidiana ni sustituir a la dirección empresarial. Sus decisiones deberán adoptarse de manera colegiada, formal y documentada, dentro de los límites competenciales establecidos, quedando prohibido cualquier ejercicio individual, informal o extrainstitucional de sus funciones.

Toda actuación que pretenda atribuir efectos de gobierno familiar a decisiones no adoptadas conforme a este órgano y a los procedimientos previstos carecerá de eficacia interna, sin perjuicio de su eventual calificación conforme a los mecanismos de control establecidos en el Protocolo.

=== Comité de Honor Familiar
El Comité de Honor Familiar es un órgano excepcional, de carácter no permanente, cuya función se limita a conocer y calificar conflictos de naturaleza institucional que comprometan o puedan comprometer la integridad, estabilidad o coherencia del sistema familiar–empresarial. Su actuación no sustituye a los órganos ordinarios de gobierno ni implica ejercicio de funciones operativas o de administración, circunscribiéndose estrictamente a los supuestos de habilitación previstos en este Protocolo.

Corresponde a este Comité analizar conductas, controversias o situaciones que afecten los principios rectores del sistema, emitiendo determinaciones de carácter institucional que servirán como base para la activación de los mecanismos y consecuencias previstos, sin que ello implique por sí mismo la imposición directa de sanciones. Su actuación deberá estar formalmente habilitada y sujeta a los procedimientos establecidos, careciendo de toda eficacia cualquier intervención realizada fuera de dichos supuestos.

En la integración del Comité de Honor Familiar deberá procurarse, de manera preferente, la participación del señor Roberto Ledesma Cruz y del señor Justo Félix Fernández Chedraui, en reconocimiento a su trayectoria, calidad moral, independencia de criterio y contribución al fortalecimiento institucional de la Familia y de la Empresa, siempre que acepten desempeñar dicha función y no exista impedimento que afecte su adecuada actuación. La imposibilidad, negativa o falta de disponibilidad de cualquiera de ellos no impedirá la válida integración y funcionamiento del Comité, pudiendo designarse a otras personas que reúnan las cualidades necesarias para el adecuado cumplimiento de sus funciones.

=== Principio de Vocería Única Familiar
El sistema de gobierno corporativo familiar se rige por el principio de vocería única, conforme al cual toda manifestación válida de voluntad familiar con impacto estratégico, patrimonial o de control deberá emanar exclusivamente de los órganos previstos en este Protocolo, actuando dentro de sus respectivas competencias y conforme a los procedimientos establecidos.

Este principio constituye el único canal legítimo para la comunicación institucional de decisiones hacia los órganos societarios, la dirección y cualquier tercero, quedando excluida toda forma de vocería individual, informal o paralela. Ninguna persona, independientemente de su posición, participación o influencia, podrá emitir instrucciones o posicionamientos con efectos vinculantes fuera de los órganos competentes.

Los órganos societarios y la estructura ejecutiva deberán reconocer y atender únicamente aquellas decisiones que emanen de la vocería institucional, debiendo desatender cualquier instrucción emitida al margen de este principio, sin que ello genere responsabilidad alguna. Su incumplimiento constituirá una infracción grave al régimen de gobierno corporativo familiar conforme a lo previsto en este Protocolo.

== Régimen de Profesionalización
El sistema de gobierno corporativo familiar se rige por el principio de profesionalización como condición estructural, objetiva e indeclinable para el acceso, permanencia y ejercicio de posiciones de poder, influencia o decisión dentro del ámbito familiar–empresarial. Este principio tiene por objeto asegurar que la asignación del poder familiar responda a criterios de mérito, capacidad y alineación institucional, y no a factores como parentesco, titularidad accionaria, antigüedad o vínculos personales.

La profesionalización regula exclusivamente el acceso y desempeño dentro de los órganos de gobierno corporativo familiar, así como las condiciones bajo las cuales un miembro de la familia podrá, de manera excepcional, desempeñar funciones ejecutivas en la empresa, sin intervenir en la regulación de la operación ni sustituir los regímenes aplicables a la función directiva. En consecuencia, el acceso a posiciones de gobierno se sujetará a criterios objetivos de elegibilidad, requisitos verificables e incompatibilidades expresas, mientras que el eventual desempeño de funciones ejecutivas por familiares quedará condicionado al cumplimiento previo de dichos estándares y a lo previsto en los instrumentos corporativos aplicables.

=== Profesionalización como Condición de Acceso al Poder Familiar
El ejercicio de cualquier forma de poder o influencia dentro del sistema familiar–empresarial estará sujeto, de manera obligatoria, al cumplimiento del principio de profesionalización, entendido como la concurrencia verificable de capacidades técnicas, experiencia relevante, criterios objetivos de mérito y alineación con el presente Protocolo y del Protocolo de Gobierno y Cumplimiento Empresarial.

La pertenencia a la familia, la titularidad accionaria, la sucesión hereditaria, la antigüedad o la participación histórica en el proyecto empresarial no constituyen, por sí mismas, fuente legítima de autoridad ni habilitación para integrar órganos de gobierno o participar en decisiones estratégicas. Este principio opera como requisito previo, necesario e independiente para el acceso, permanencia y continuidad en cargos familiares con impacto institucional, y deberá aplicarse de manera uniforme, estricta y no discrecional.

En este contexto, cualquier designación o ejercicio de funciones que prescinda del cumplimiento efectivo de estos estándares se considerará contrario al sistema de gobernanza y carecerá de legitimidad institucional, sin generar derecho alguno a su permanencia.

=== Régimen de Elegibilidad para Órganos de Gobierno Corporativo Familiar
La integración y permanencia en los órganos de gobierno corporativo familiar se sujetará a un régimen de elegibilidad objetiva, previa y verificable, cuyo cumplimiento constituye condición indispensable para la validez de cualquier designación. La elegibilidad no se presume ni deriva de la sola condición familiar o patrimonial, sino del cumplimiento efectivo de los criterios establecidos en este Protocolo y en los reglamentos internos de cada órgano.

Dichos criterios deberán considerar, al menos, la alineación con el sistema de gobernanza, la solvencia ética, la comprensión del modelo de separación funcional, la capacidad de deliberación institucional y el compromiso expreso de sujeción al Protocolo, quedando excluidas designaciones fundadas en conveniencias personales, equilibrios informales o acuerdos extrainstitucionales.

La acreditación de estos requisitos deberá realizarse previamente a la integración del órgano correspondiente, conforme a mecanismos verificables, sin que pueda producirse incorporación válida en ausencia de dicha acreditación. Cualquier designación que incumpla este régimen carecerá de efectos internos y no producirá legitimidad institucional dentro del sistema.

=== Elegibilidad para el Desempeño de Funciones Ejecutivas por Familiares
El desempeño de funciones ejecutivas por miembros de la familia tendrá carácter excepcional y estará sujeto a un régimen reforzado de elegibilidad, profesionalización y control institucional. La designación de un familiar en posiciones directivas requerirá el cumplimiento íntegro de los estándares profesionales aplicables, la inexistencia de conflictos de interés estructurales y la acreditación de alineación con los principios del presente Protocolo.

La condición de accionista, heredero, integrante de una rama activa o miembro de órganos de gobierno no confiere derecho alguno a ocupar cargos ejecutivos ni genera expectativa legítima de acceso. En todos los casos, el directivo familiar deberá actuar exclusivamente en su calidad profesional, sujeto al mismo régimen de evaluación, desempeño, responsabilidad y remoción que cualquier directivo no familiar, sin prerrogativas derivadas de su condición personal.

Asimismo, queda prohibido que un directivo familiar utilice su posición patrimonial o institucional para influir en su propia designación, evaluación, permanencia o remuneración, o para intervenir en decisiones operativas fuera de los canales formales. El incumplimiento de estos requisitos dará lugar a la invalidez interna de la designación y a la activación de los mecanismos correspondientes conforme a este Protocolo.

=== Incompatibilidades y Nulidad de Designaciones Contrarias al Protocolo
Será incompatible, inelegible y, en consecuencia, inválida para efectos internos cualquier designación, integración o permanencia en órganos de gobierno corporativo familiar que contravenga los principios de profesionalización, elegibilidad objetiva, separación funcional o vocería única establecidos en este Protocolo.

Se considerarán supuestos de incompatibilidad, entre otros, el incumplimiento de los requisitos de elegibilidad, la existencia de conflictos de interés que comprometan la independencia o el control familiar, la utilización de la condición familiar o accionaria para influir en procesos de designación, el ejercicio simultáneo de roles incompatibles o la existencia de designaciones fundadas en acuerdos informales o presiones personales.

Toda designación realizada en contravención a estas disposiciones será nula para efectos internos desde su origen, no producirá efectos dentro del sistema ni generará derechos adquiridos o situaciones consolidadas. Dicha nulidad tendrá carácter institucional y preventivo, y no implicará por sí misma la imposición de sanciones personales, sin perjuicio de las responsabilidades que pudieran derivarse conforme a otros instrumentos aplicables.

== Régimen de Función Ejecutiva en la Empresa Familiar
La función ejecutiva en la empresa constituye una esfera profesional autónoma, técnica y operativamente independiente de la propiedad accionaria y del gobierno corporativo familiar, cuyo ejercicio se rige por criterios de desempeño, responsabilidad institucional y rendición de cuentas. Este régimen tiene por objeto garantizar la neutralidad operativa de la gestión, evitar la captura del poder por vías informales o paralelas y asegurar que no exista superposición entre autoridad ejecutiva y autoridad familiar, particularmente cuando dicha función sea desempeñada por integrantes de la familia empresaria.

Las disposiciones del presente apartado no regulan la gestión operativa en sí misma ni sustituyen los instrumentos corporativos aplicables, sino que establecen límites institucionales inderogables destinados a preservar la separación funcional entre propiedad, gobierno y operación, así como a proteger el control familiar dentro de un esquema profesionalizado de ejecución.

=== Naturaleza y Límites de la Función Ejecutiva
La función ejecutiva se limita exclusivamente a la conducción operativa, administrativa y técnica del negocio, conforme a las facultades conferidas por los órganos societarios competentes y dentro de los marcos normativos aplicables. Su ejercicio no confiere, por sí mismo, facultades de gobierno corporativo familiar ni derechos de control institucional, aun cuando sea desempeñada por miembros de la familia.

Toda actuación ejecutiva deberá sujetarse a los límites materiales, funcionales y jerárquicos establecidos, quedando prohibida cualquier ampliación de facultades derivada de la condición familiar, patrimonial o accionaria del directivo. En este sentido, la gestión deberá desarrollarse bajo criterios de profesionalismo, subordinación institucional y neutralidad operativa, sin que resulte admisible la existencia de canales paralelos de autoridad o influencia al margen de la estructura ejecutiva formal.

=== Régimen Aplicable a Directivos Familiares
Cuando la función ejecutiva sea desempeñada por miembros de la familia empresaria, su actuación quedará sujeta a un régimen reforzado de separación de roles, neutralidad y prohibición de doble vía de poder. El directivo familiar deberá actuar exclusivamente en su calidad profesional, sin invocar ni utilizar su condición familiar o patrimonial para influir en decisiones operativas, procesos de evaluación, determinaciones de permanencia o cualquier otro aspecto de la gestión.

Asimismo, deberá abstenerse de participar en decisiones de gobierno familiar que incidan en su propia situación, incluyendo su designación, evaluación o remuneración, debiendo excusarse formalmente en dichos supuestos. Queda igualmente prohibido el uso de canales informales, acuerdos familiares o intermediaciones para instruir o modificar decisiones operativas, así como cualquier conducta que implique la superposición entre autoridad ejecutiva y autoridad familiar, la cual se considerará contraria al presente Protocolo y carente de eficacia interna.

=== Neutralidad, Lealtad Institucional y Rendición de Cuentas
El directivo familiar estará sujeto a un deber reforzado de neutralidad operativa, lealtad institucional y rendición de cuentas, el cual prevalecerá sobre cualquier vínculo personal o patrimonial. La neutralidad implica conducir la gestión con criterios técnicos y objetivos, sin favorecer intereses individuales o familiares, mientras que la lealtad institucional exige anteponer el interés de la organización y del sistema de gobernanza sobre cualquier interés particular.

La rendición de cuentas deberá realizarse exclusivamente a través de los canales formales y ante los órganos competentes, quedando prohibida cualquier forma de reporte informal o paralelo ante familiares o accionistas no facultados. El incumplimiento de estos deberes constituirá una infracción al sistema de gobernanza y dará lugar a la activación de los mecanismos internos correspondientes, sin perjuicio de las responsabilidades que pudieran derivarse conforme a los instrumentos aplicables.

== Régimen de Tipificación de Infracciones al Gobierno Corporativo Familiar
El presente numeral tiene por objeto definir y delimitar las conductas que constituyen infracciones al sistema de gobierno corporativo familiar establecido en este Protocolo, bajo un enfoque institucional, objetivo y normativo. Las infracciones se configuran por la sola actualización de los supuestos aquí previstos, con independencia de la intención del sujeto, la existencia de beneficio económico, la producción de daño o la ausencia de efectos inmediatos, constituyendo un presupuesto habilitante para la activación del régimen de consecuencias y del procedimiento correspondiente conforme a las disposiciones aplicables.

=== Invasión Competencial y Actuación Extrainstitucional
Constituye infracción toda actuación mediante la cual una persona u órgano ejerza, intente ejercer o influya, directa o indirectamente, en funciones o decisiones que no le corresponden conforme al régimen de separación funcional previsto en este Protocolo. Esta conducta se actualiza tanto en intervenciones formales como informales, expresas o implícitas, incluyendo aquellas que se apoyen en prácticas toleradas, costumbres, jerarquías implícitas o precedentes no institucionalizados.

En particular, se considera invasión competencial cualquier intervención de la propiedad accionaria en decisiones estratégicas u operativas fuera de los mecanismos previstos, la emisión de instrucciones ejecutivas por parte de órganos de gobierno familiar, la participación de personas sin competencia formal en procesos decisorios o la asunción de funciones por vías informales. La infracción subsiste aun cuando la conducta se funde en la condición familiar, patrimonial, histórica o en situaciones de urgencia no contempladas en este Protocolo.

=== Abuso de Posición Familiar, Patrimonial o Institucional
Se configura infracción cuando se utilice una posición familiar, patrimonial o institucional de manera indebida para influir en decisiones, condicionar procesos o alterar el funcionamiento regular del sistema de gobernanza. Este abuso comprende el uso del parentesco, la jerarquía familiar o la trayectoria histórica para presionar órganos o personas, así como la utilización de la titularidad accionaria como mecanismo de coerción, bloqueo o negociación al margen de los canales institucionales.

Asimismo, se considera abuso la utilización de cargos o atribuciones institucionales con fines personales o ajenos al interés común, o como medio de control informal. Esta infracción se actualiza por la desviación objetiva de la finalidad institucional del cargo o posición, sin que sea necesario acreditar beneficio, daño o impacto económico inmediato.

=== Desconocimiento de la Institucionalidad Decisoria y de la Vocería Única
Constituye infracción el desconocimiento, incumplimiento o elusión de los canales institucionales de deliberación, decisión y comunicación previstos en este Protocolo. En este sentido, se considera infractora la adopción de decisiones fuera de los órganos competentes, la emisión de posturas o instrucciones en nombre del sistema sin habilitación, la generación de mensajes paralelos o contradictorios y la omisión de someter asuntos relevantes a los canales formales correspondientes.

La infracción se actualiza aun cuando la conducta se realice con fines conciliatorios, de buena fe o bajo la intención de agilizar decisiones, siempre que implique sustituir o debilitar la institucionalidad decisoria o el principio de vocería única.

=== Calificación de la Infracción y Activación del Régimen de Consecuencias
La actualización de cualquiera de los supuestos previstos en este numeral constituirá, por sí misma, una infracción al sistema de gobierno corporativo familiar, cuya calificación tendrá carácter objetivo y no requerirá valoración adicional sobre intencionalidad, reiteración o impacto económico.

La existencia de la infracción habilita de pleno derecho la activación del procedimiento correspondiente y del régimen de consecuencias institucionales previstos en este Protocolo, los cuales deberán aplicarse conforme a los principios de legalidad interna, proporcionalidad y debido proceso.

Las disposiciones del presente numeral tendrán carácter vinculante para todos los integrantes del sistema familiar–empresarial y para quienes se encuentren sujetos a este Protocolo, constituyendo el parámetro obligatorio de referencia para la calificación de conductas y la preservación del orden institucional.


// ==============================================================================
// CAPÍTULO 04: Régimen de Sucesión Familiar Empresarial
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (1) previas a Chapter Opening 04
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 04
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-04") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "04",
    title: [Régimen de Sucesión Familiar Empresarial],
    opening_title: ("RÉGIMEN DE SUCESIÓN", "FAMILIAR EMPRESARIAL"),
    description: [Mecanismos y protocolos de relevo generacional en el liderazgo \ directivo, de propiedad y de gobernanza.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 04
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 04
#metadata(4) <chapter-marker>
#metadata("first-04") <chapter-first-marker>
#counter(heading).update((4, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "04" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[04]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      RÉGIMEN DE SUCESIÓN \ 
      FAMILIAR EMPRESARIAL
    ]
  ]
}

#v(153.79pt)

== Principio de Sucesión Empresarial Ordenada y Continuidad Societaria
La sucesión en el ámbito familiar–empresarial se configura como un régimen jurídico especial, autónomo y de aplicación obligatoria, cuyo objeto es garantizar la continuidad de la sociedad, la estabilidad del control familiar y la preservación de la empresa como unidad económica organizada. En este sentido, la sucesión accionaria no se sujeta, en lo relativo a la organización, gobierno y control societario, a las reglas generales del derecho sucesorio civil, sino a las disposiciones específicas previstas en este Protocolo, las cuales tendrán carácter preferente y excluyente frente a cualquier interpretación supletoria o extensiva de naturaleza civil.

=== Finalidad Empresarial de la Sucesión Accionaria
// REGLA A: Párrafo protegido atómicamente para prevenir viudas (< 2 líneas)
#block(width: 100%, breakable: false)[La sucesión accionaria tiene como finalidad exclusiva la transmisión del valor económico de las acciones y la preservación del control familiar y de la continuidad funcional de la sociedad, quedando expresamente excluida cualquier interpretación que implique la transmisión automática de la condición de accionista pleno o del ejercicio de derechos corporativos. En consecuencia, la sucesión no constituye un mecanismo de acceso directo a la estructura societaria, sino un proceso institucional que produce efectos económicos inmediatos a favor de los sucesores, condicionando cualquier efecto de naturaleza societaria al cumplimiento del régimen previsto en este Capítulo.]

=== Exclusión de la Transmisión Automática de Derechos Societarios
La apertura de la sucesión, la declaratoria de herederos o la designación de legatarios producirá, de pleno derecho, la transmisión de los derechos económicos asociados a las acciones, entendidos exclusivamente como el derecho al valor patrimonial y a los beneficios que correspondan. Sin embargo, dicha transmisión no implica, en ningún caso, el reconocimiento ni el ejercicio automático de derechos corporativos, políticos o de control, los cuales se encuentran jurídicamente desvinculados del ámbito sucesorio común.

En consecuencia, el heredero o legatario adquiere únicamente una posición económica respecto de las acciones, sin acceder a la calidad de accionista pleno ni a la participación en la estructura de gobierno, quedando cualquier incorporación al sistema societario sujeta a los mecanismos de habilitación, reconocimiento e inscripción previstos en este Protocolo.

=== Prevalencia del Interés Social y del Control Familiar
En todo proceso sucesorio, el interés de la sociedad y la preservación del control familiar institucional prevalecerán sobre cualquier interés individual o expectativa hereditaria. En consecuencia, ninguna interpretación o ejecución de la sucesión podrá afectar la estabilidad societaria, alterar el equilibrio de control ni modificar la estructura de gobierno definida en este Protocolo.

Cualquier acto, acuerdo o pretensión que contravenga estos principios se considerará ineficaz para efectos internos, sin que pueda generar reconocimiento, validación o efecto alguno dentro del sistema familiar–empresarial.

== Supuestos Jurídicos de Activación del Régimen Sucesorio
El régimen de sucesión familiar empresarial previsto en el presente Capítulo se activará de pleno derecho, de manera automática, obligatoria e inmediata, cuando se acredite la actualización de cualquiera de los supuestos jurídicos expresamente previstos en este apartado, sin que dicha activación requiera acuerdo, autorización o validación discrecional por parte de órgano alguno. La sola verificación objetiva del supuesto correspondiente será suficiente para detonar la aplicación íntegra del régimen sucesorio, incluyendo las disposiciones contenidas en los apartados 4.1 a 4.9, así como los regímenes de derechos accionarios y de gobierno corporativo establecidos en los Capítulos Segundo y Tercero.

Asimismo, cualquier situación que, conforme a la legislación aplicable, produzca efectos sucesorios por ministerio de ley, se entenderá automáticamente comprendida dentro del presente régimen, sin necesidad de regulación adicional, interpretación extensiva o acto de reconocimiento expreso.

=== Fallecimiento del Accionista Familiar
El régimen sucesorio se activa ipso iure desde el momento del fallecimiento de un Accionista Familiar, el cual deberá acreditarse mediante el acta de defunción correspondiente. La obligación de presentar dicho documento para efectos internos podrá ser cumplida indistintamente por el albacea, cualquier heredero o legatario, o cualquier Accionista Familiar que tenga conocimiento fehaciente del fallecimiento, debiendo entregarse ante el órgano responsable de la administración societaria y de la custodia del Libro de Registro de Acciones, a fin de ejecutar las actuaciones previstas en este Protocolo.

No obstante, la activación del régimen no se encuentra condicionada a la presentación del acta de defunción, a la apertura del procedimiento sucesorio ni a la existencia de testamento, produciendo efectos obligatorios desde el momento mismo del fallecimiento. A partir de dicho evento, las acciones del titular fallecido quedarán automáticamente sujetas al régimen de separación de derechos, al congelamiento accionario y al procedimiento sucesorio interno previstos en este Capítulo, sin excepción ni posibilidad de diferimiento.

=== Incapacidad Total y Permanente del Accionista Familiar
El régimen sucesorio se activará cuando un Accionista Familiar se encuentre en una situación de incapacidad total y permanente que le impida ejercer de manera consciente los derechos derivados de sus acciones. La acreditación definitiva de dicha incapacidad deberá realizarse mediante resolución judicial firme, la cual producirá efectos plenos para la activación del régimen.

En tanto no exista resolución judicial, la incapacidad podrá reconocerse de manera provisional únicamente para efectos precautorios, siempre que exista un dictamen médico especializado, independiente y sin conflicto de interés, emitido por institución de alta especialidad, y que dicho dictamen sea aprobado de manera unánime, expresa y documentada por la totalidad de las ramas familiares y de los accionistas con derechos corporativos vigentes, reconociéndose en todo caso su carácter estrictamente provisional.

En este supuesto, se activarán de inmediato el régimen de separación de derechos, el congelamiento accionario y el procedimiento sucesorio interno, quedando prohibido cualquier acto definitivo de adjudicación o ejercicio de derechos de control hasta en tanto exista resolución judicial firme. En ausencia de unanimidad o en caso de dictámenes contradictorios, no se tendrá por acreditada la incapacidad, operando de pleno derecho un congelamiento accionario precautorio hasta la determinación judicial correspondiente.

La obligación de presentar la documentación necesaria recaerá indistintamente en el propio accionista, su representante legal, tutor o curador, cualquier heredero o cualquier accionista con conocimiento de la situación, debiendo realizarse ante el órgano encargado de la administración societaria.

=== Activación Anticipada por Retiro o Planeación Patrimonial Inter Vivos
El régimen sucesorio podrá activarse de manera anticipada cuando un Accionista Familiar, de forma expresa, consciente y documentada, decida desvincularse de manera definitiva del ejercicio personal de los derechos derivados de sus acciones, aun sin actualizarse un supuesto de sucesión mortis causa.

Dicha activación deberá instrumentarse mediante actos jurídicos válidos conforme al derecho aplicable, tales como la constitución de fideicomisos patrimoniales sobre acciones, la donación de acciones a sujetos admitidos por este Protocolo o la renuncia definitiva al ejercicio de derechos corporativos y de control. La celebración de cualquiera de estos actos producirá de manera automática la activación del régimen sucesorio respecto de las acciones involucradas, incluyendo la aplicación del régimen de separación de derechos, el congelamiento accionario y la sujeción al procedimiento sucesorio interno.

La activación anticipada no sustituye ni altera los efectos de la sucesión hereditaria ni del testamento, los cuales se producirán conforme a la legislación aplicable, limitándose a organizar de manera institucional la transición patrimonial y de control dentro del sistema familiar–empresarial.

== Régimen de Transmisión del Valor Económico Accionario en la Sucesión
El presente apartado regula de manera integral y excluyente el contenido, alcance, determinación, exigibilidad y forma de satisfacción del derecho económico derivado de la sucesión accionaria, conforme al principio de separación funcional de derechos previsto en el Capítulo Segundo y al régimen de sucesión empresarial establecido en este Capítulo. Para estos efectos, el derecho económico sucesorio se entiende como un derecho de naturaleza estrictamente patrimonial, consistente en el valor económico de las acciones y, en su caso, en los rendimientos consolidados que correspondan, sin que su reconocimiento implique acceso, siquiera provisional, a derechos corporativos, políticos o de control, los cuales se rigen por disposiciones independientes.

=== Reconocimiento del Derecho Sucesorio como Derecho Económico
La actualización de cualquiera de los supuestos de activación previstos en el apartado 4.2 produce, de pleno derecho, la transmisión del derecho económico sucesorio a favor del heredero o legatario correspondiente, limitado exclusivamente al valor económico de las acciones conforme al régimen establecido en este Protocolo. Este reconocimiento opera sin necesidad de acto societario, inscripción o validación adicional, pero no implica exigibilidad inmediata ni forma de pago automática, quedando su ejercicio sujeto al desarrollo del procedimiento sucesorio interno y a las condiciones previstas en los apartados aplicables.

En consecuencia, el derecho económico no confiere facultad alguna para exigir la incorporación como accionista pleno, intervenir en la administración o participar en el gobierno de la sociedad, manteniéndose dichas materias fuera del ámbito sucesorio y subordinadas a los mecanismos institucionales correspondientes.

=== Determinación del Valor conforme al Mecanismo de Valuación Vinculante
El valor económico de las acciones para efectos sucesorios se determinará única y exclusivamente conforme al mecanismo de valuación vinculante previsto en el Capítulo Segundo, el cual se tendrá por reproducido en este apartado para todos los efectos legales internos. Dicho mecanismo constituye el único método válido dentro del sistema regulado por este Protocolo, quedando expresamente excluida la utilización de avalúos civiles, dictámenes periciales de parte, valoraciones contables externas o cualquier procedimiento distinto.

El resultado de la valuación tendrá carácter definitivo, obligatorio y no negociable para todas las partes involucradas, sin que pueda ser sustituido, modificado o cuestionado por vías alternas dentro del ámbito interno del sistema familiar–empresarial.

=== Exigibilidad y Modalidades de Satisfacción
El derecho económico sucesorio no será exigible de manera inmediata, sino hasta la conclusión del procedimiento sucesorio interno y la determinación del esquema de ejecución conforme al presente Capítulo. En ningún caso generará una obligación directa de pago a cargo de la sociedad, debiendo satisfacerse exclusivamente mediante los mecanismos inter-familiares de adquisición, salida ordenada y pago previstos en este Protocolo.

La satisfacción del derecho económico se realizará conforme a las modalidades, plazos y condiciones previstas en el Capítulo Segundo y en las disposiciones aplicables de este Capítulo, pudiendo incluir esquemas de pago diferido, parcialidades, condiciones operativas y mecanismos de garantía, siempre bajo criterios de estabilidad del sistema y preservación del control familiar.

=== Alcance del Derecho Económico y Exclusión de Pretensiones Adicionales
El derecho económico sucesorio comprende exclusivamente el valor de las acciones determinado conforme al mecanismo de valuación aplicable y, en su caso, los dividendos decretados y no pagados con anterioridad al evento sucesorio. Quedan expresamente excluidos cualquier expectativa de utilidades futuras, beneficios no decretados o derechos patrimoniales no consolidados al momento de la activación del régimen sucesorio.

Asimismo, se excluye de manera absoluta cualquier pretensión de liquidez, rescate, reembolso, reducción de capital, retiro o mecanismo equivalente que no se encuentre expresamente previsto en este Protocolo. El ejercicio del derecho económico se encuentra, en todo momento, sujeto al régimen de congelamiento accionario y a los mecanismos de salida ordenada aplicables, quedando prohibida cualquier interpretación que pretenda ampliar su alcance más allá de lo aquí establecido.

== Régimen de Ejercicio y Limitación de Derechos Corporativos en Contextos Sucesorios
El presente apartado regula de manera integral, expresa y vinculante el régimen aplicable al ejercicio, suspensión, limitación y eventual habilitación de los derechos corporativos, políticos y de control asociados a las acciones cuando se actualice un supuesto sucesorio. Dicho régimen se interpreta sistemáticamente con el principio de separación funcional de derechos previsto en el Capítulo Segundo y con la estructura de gobierno corporativo establecida en el Capítulo Tercero, bajo el entendido de que los derechos corporativos constituyen una esfera jurídica autónoma, no transmisible por ministerio de ley y sujeta, en todo caso, a habilitación institucional expresa.

=== Inexistencia de Transmisión Automática de Derechos Corporativos
La apertura de la sucesión, la designación de herederos o legatarios, la adquisición civil de acciones o la transmisión del derecho económico sucesorio no producen, en ningún caso, la transmisión, reconocimiento ni ejercicio automático de derechos corporativos, políticos o de control. En consecuencia, ninguna persona podrá intervenir en la vida societaria —incluyendo asistencia a asambleas, emisión de voto, designación de órganos o acceso a decisiones estratégicas— con base exclusiva en su calidad de heredero, legatario o titular económico, mientras no se cumplan íntegramente los requisitos de habilitación previstos en este Protocolo.

=== Suspensión Automática de Derechos Corporativos durante el Proceso Sucesorio
Desde la actualización del supuesto sucesorio y durante todo el periodo en que subsista el régimen de congelamiento accionario, el ejercicio de los derechos corporativos asociados a las acciones afectadas quedará suspendido de pleno derecho, sin necesidad de acuerdo adicional. Esta suspensión se extiende tanto al titular original como a cualquier heredero, legatario o tercero que pretenda ejercer derechos directa o indirectamente.

Durante este periodo, las acciones afectadas no serán computables para efectos de quórum, votación ni mayorías, sin que ello afecte la operatividad de los órganos societarios respecto del capital restante. La suspensión subsistirá hasta que se cumplan de manera concurrente el levantamiento del congelamiento accionario y los requisitos de habilitación previstos en este Capítulo, sin que el simple levantamiento del congelamiento implique la reactivación automática de derechos corporativos.

=== Condicionamiento del Ejercicio de Derechos Corporativos
Concluido el procedimiento sucesorio interno, el ejercicio de derechos corporativos únicamente podrá reconocerse a favor de quienes cumplan, de manera simultánea, con los requisitos de elegibilidad, pertenencia al sistema familiar, alineación con el régimen de gobierno corporativo y reconocimiento formal mediante inscripción en el Libro de Registro de Acciones.

La ausencia de cualquiera de estos elementos impedirá, de pleno derecho, el ejercicio de derechos corporativos, aun cuando exista transmisión civil de acciones o titularidad económica reconocida. En este sentido, el acceso al ámbito corporativo no deriva del fenómeno sucesorio, sino de un proceso institucional de validación y habilitación conforme a este Protocolo.

=== Habilitación Excepcional para el Ejercicio de Control
La habilitación para el ejercicio de derechos de control constituye una excepción estricta al régimen general y solo podrá otorgarse de manera expresa, individualizada, temporal y documentada, conforme a las reglas y mayorías calificadas previstas en el sistema de gobierno corporativo familiar.

Dicha habilitación deberá constar tanto en resolución del órgano familiar competente como en el acto societario correspondiente, precisando de forma nominativa el alcance, límites, plazo y condiciones de revocación de los derechos autorizados. En ningún caso podrá presumirse, inferirse por conducta ni extenderse por analogía a sujetos o situaciones no expresamente autorizadas, manteniéndose siempre subordinada a la preservación del control familiar efectivo.

=== Ineficacia de Actos Corporativos Ejercidos sin Habilitación
Todo acto corporativo o ejercicio de derechos políticos realizado en contravención a lo dispuesto en este apartado será ineficaz para efectos internos y no producirá consecuencia alguna frente a la sociedad, los accionistas familiares ni los órganos de gobierno.

Queda prohibida cualquier interpretación que pretenda reconocer, anticipar o simular el ejercicio de derechos corporativos fuera de los supuestos y procedimientos expresamente previstos en este Protocolo, reafirmándose el carácter cerrado, restrictivo y no extensivo del régimen de habilitación aquí establecido.

== Tratamiento Sucesorio Diferenciado por Categoría de Vínculo Familiar
El tratamiento sucesorio de las acciones y de los derechos derivados de las mismas se determinará exclusivamente con base en la categoría de vínculo familiar del sucesor o beneficiario, conforme a las definiciones establecidas en el Capítulo Segundo. En consecuencia, queda prohibido reconocer categorías intermedias, realizar equiparaciones fácticas o aplicar interpretaciones extensivas o analógicas que alteren el sistema de clasificación previsto en este Protocolo.

Bajo este esquema, el régimen sucesorio se rige por reglas estrictas y cerradas: los derechos económicos se transmiten por ministerio de ley; los derechos corporativos y de control no se transmiten automáticamente y permanecen excluidos salvo habilitación expresa; y la titularidad accionaria formal, así como su inscripción definitiva, solo podrá actualizarse conforme al procedimiento institucional previsto, bajo el régimen de congelamiento accionario aplicable.

=== Sucesión en Línea Consanguínea Directa
Cuando el sucesor pertenezca a la línea consanguínea directa, la transmisión producirá de pleno derecho la adquisición de los derechos económicos conforme a este Protocolo, sin que ello implique acceso automático al ejercicio de derechos corporativos o de control. Dicho acceso quedará condicionado al cumplimiento concurrente de los requisitos de elegibilidad, alineación institucional y habilitación previstos en los Capítulos Segundo y Tercero, así como a la conclusión del procedimiento sucesorio correspondiente.

En ausencia de dichos requisitos, el consanguíneo conservará exclusivamente una posición económica respecto de las acciones, sin derecho de voto, sin acceso a órganos de decisión y sin intervención en la gestión o control de la sociedad. En todos los casos, la regularización accionaria deberá realizarse mediante el procedimiento institucional previsto, quedando excluida cualquier forma de reconocimiento automático o directo de derechos corporativos.

=== Régimen Aplicable a la Familia Política
En congruencia con lo dispuesto en el apartado 2.3.3. del presente Protocolo, y salvo por la excepción expresa, nominativa y personalísima prevista en el apartado 2.3.3.1., los integrantes de la familia política no forman parte de la familia empresaria ni podrán, en ningún caso, integrarse al sistema de propiedad, gobierno o control de forma automática, con independencia del título jurídico mediante el cual pretendan adquirir derechos sobre las acciones.

En consecuencia, cualquier derecho que pudiera derivar a su favor conforme a la legislación aplicable, incluyendo, de manera enunciativa, supuestos de sucesión, liquidación de sociedad conyugal u otras relaciones patrimoniales, se limitará exclusivamente a sus derechos económicos, sin que en ningún caso implique la adquisición de la calidad de accionista con derechos corporativos, ni su inscripción como titular en el Libro de Registro de Acciones.

Dichos derechos económicos deberán satisfacerse mediante los mecanismos de valuación y salida previstos en el presente Protocolo, garantizando en todo momento la no alteración de la estructura accionaria, la preservación del control familiar efectivo y la permanencia del capital en manos de la familia consanguínea en línea directa.

=== Régimen Aplicable a la Descendencia no Tradicional
Cuando el sucesor corresponda a la categoría de descendencia no tradicional, la sucesión producirá de pleno derecho la adquisición de derechos económicos en los términos previstos en este Protocolo, sin que ello implique acceso automático a derechos corporativos o de control.

El ejercicio de dichos derechos corporativos solo podrá habilitarse de manera expresa, individualizada y documentada, conforme a los mecanismos y mayorías calificadas previstas en este Protocolo, dentro del procedimiento sucesorio correspondiente. En ausencia de dicha habilitación, la persona conservará exclusivamente derechos económicos, sin voto, sin participación en órganos de decisión ni facultades de control.

=== Exclusión de Terceros Ajenos al Sistema Familiar
Queda prohibido reconocer como titulares de derechos corporativos, políticos o de control a personas ajenas al sistema familiar–empresarial. Los terceros únicamente podrán, en su caso, acceder a derechos económicos derivados de mecanismos de liquidación patrimonial, sin que ello implique su incorporación como accionistas plenos ni su inscripción con derechos corporativos.

Cualquier acto, adjudicación o intento de reconocimiento que contravenga esta prohibición será ineficaz para efectos internos, sin perjuicio de las consecuencias previstas en este Protocolo, debiendo canalizarse cualquier efecto patrimonial conforme a los mecanismos de valuación, adquisición o salida aplicables.

== Testamento Empresarial, Legados Accionarios y Albacea Especial Empresarial
El presente apartado regula el instrumento sucesorio preferente para la transmisión accionaria, la técnica de legados especiales y la figura del albacea especial empresarial, como mecanismos destinados a asegurar la continuidad de la sociedad, la estabilidad del control familiar y la ejecución ordenada del régimen sucesorio. Estas disposiciones tendrán carácter vinculante para efectos internos del sistema familiar–empresarial y prevalecerán sobre cualquier interpretación civil que no distinga entre sucesión patrimonial ordinaria y sucesión accionaria empresarial.

=== Testamento Empresarial como Instrumento Preferente
Se reconoce el testamento empresarial como el instrumento idóneo y preferente para ordenar la transmisión de acciones, en atención a su naturaleza estratégica y a la necesidad de separar el tratamiento accionario del resto del patrimonio hereditario. Dicho instrumento deberá contener disposiciones claras, específicas y nominativas respecto de las acciones, evitando su inclusión genérica dentro de la masa hereditaria, y deberá articularse de manera consistente con el régimen de separación de derechos, categorías familiares y control institucional previstos en este Protocolo.

La inexistencia de testamento empresarial no impide la aplicación del régimen sucesorio, pero limita la posibilidad de una ejecución ordenada, previsible y alineada al sistema familiar–empresarial.

=== Legados Especiales de Acciones
Las acciones podrán ser objeto de legados especiales, con el fin de garantizar su tratamiento diferenciado dentro del proceso sucesorio y su separación respecto de la partición patrimonial ordinaria. Estos legados producirán efectos civiles directos en favor del legatario, sin perjuicio de la aplicación obligatoria del régimen de separación de derechos, congelamiento accionario, salida ordenada y procedimiento sucesorio interno previstos en este Protocolo.

En consecuencia, el legado especial no confiere por sí mismo acceso automático a derechos corporativos ni a control societario, manteniéndose dichos efectos sujetos a los mecanismos de habilitación, elegibilidad y regularización previstos en los apartados correspondientes.

=== Albacea Especial Empresarial
El testamento empresarial deberá prever la designación de un albacea especial empresarial, cuya función se limita exclusivamente a la ejecución del régimen sucesorio accionario. Este cargo tiene naturaleza técnica y no implica administración patrimonial general, debiendo ejercerse bajo criterios de lealtad, diligencia y neutralidad frente a las distintas ramas familiares.

Corresponde a dicho albacea, como funciones mínimas, identificar a los beneficiarios conforme a su categoría, coordinar la activación de los mecanismos sucesorios previstos, promover la inscripción provisional de los legatarios, supervisar el desarrollo del procedimiento interno y conducir el proceso hasta su conclusión. En ningún caso tendrá facultades para alterar la estructura accionaria, autorizar transmisiones, levantar restricciones o reconocer derechos corporativos fuera de los supuestos expresamente previstos en este Protocolo.

=== Inscripción Provisional de Legatarios
Acreditada la existencia de un legado especial, el órgano encargado de la administración societaria deberá practicar la inscripción provisional del legatario en el Libro de Registro de Acciones, con carácter meramente administrativo y con anotación expresa de su condición de titular en proceso sucesorio sin derechos corporativos.

Dicha inscripción tiene como única finalidad reconocer la expectativa sucesoria y permitir la ejecución ordenada del procedimiento interno, sin conferir facultades de voto, participación en asambleas, acceso a información estratégica ni intervención en la gestión o control de la sociedad.

=== Adjudicación Definitiva y Regularización Societaria
Concluido el procedimiento sucesorio interno, el albacea especial empresarial promoverá la adjudicación definitiva de las acciones y la inscripción formal del nuevo titular, la cual quedará condicionada a la determinación del tratamiento sucesorio aplicable, al cumplimiento de los mecanismos de salida o reconfiguración patrimonial que correspondan y al levantamiento del régimen de congelamiento accionario.

Una vez realizadas las inscripciones definitivas y cumplidas las condiciones establecidas, el proceso sucesorio accionario se tendrá por concluido para efectos internos del sistema familiar–empresarial, sin perjuicio de los efectos civiles que correspondan conforme a la legislación aplicable.

== Régimen de Salida Ordenada de Titulares Económicos no Integrados
El presente apartado regula, de manera obligatoria y autoejecutable, el régimen de salida aplicable a quienes, conforme a este Protocolo, ostenten exclusivamente derechos económicos sobre acciones sin integración al sistema familiar–empresarial ni habilitación para el ejercicio de derechos corporativos o de control. Este régimen se activa de pleno derecho como consecuencia directa del reconocimiento de dicha calidad, sin requerir acuerdo adicional, manifestación de voluntad ni validación posterior, y tiene por objeto asegurar la recomposición del capital dentro del sistema y evitar la permanencia de posiciones patrimoniales pasivas incompatibles con la estructura de control definida.

=== Naturaleza Transitoria de la Titularidad Económica no Integrada
La titularidad de derechos económicos sin integración al sistema tiene carácter estrictamente transitorio y no podrá subsistir de manera indefinida bajo ninguna circunstancia. En consecuencia, toda persona que se ubique en esta categoría queda obligada a ejecutar su salida patrimonial conforme a los mecanismos previstos en este apartado, sin que pueda exigir permanencia, conservación pasiva de derechos o participación prolongada en el capital social al margen del sistema familiar–empresarial.

=== Oferta Obligatoria y Derecho de Preferencia Interno
Como condición indispensable para el reconocimiento de sus derechos económicos y su regularización dentro del sistema, el titular económico no integrado deberá ofrecer en venta la totalidad de su participación conforme a un orden interno obligatorio, privilegiando en primer término a los accionistas familiares consanguíneos por ramas, posteriormente al resto de accionistas familiares y, en su caso, a los vehículos patrimoniales autorizados.

Dicha oferta se sujetará de manera estricta al régimen de derecho de preferencia, a la metodología de valuación vinculante y a las condiciones de pago previstas en este Protocolo, sin que sea admisible modificar el orden, alterar las condiciones o introducir mecanismos alternos de disposición.

=== Prohibición de Disposición a Favor de Terceros
Hasta en tanto no se haya agotado íntegramente el procedimiento de oferta interna, queda prohibida cualquier forma de transmisión, cesión, gravamen o disposición de las acciones o de los derechos económicos a favor de terceros ajenos al sistema familiar–empresarial.

Todo acto realizado en contravención a esta prohibición será ineficaz para efectos internos, sin que pueda producir reconocimiento dentro del sistema ni alterar la estructura de control, sin perjuicio de las consecuencias que correspondan conforme a otros instrumentos aplicables.

=== Convenio de Salida Ordenada como Condición de Reconocimiento
El reconocimiento interno de los derechos económicos, la inscripción correspondiente y cualquier efecto patrimonial derivado quedarán condicionados a la suscripción previa de un convenio de salida ordenada con los accionistas familiares, cuyo objeto será regular la ejecución de la salida, el ejercicio del derecho de preferencia, la determinación del valor, las condiciones de pago y las consecuencias del incumplimiento.

La suscripción de dicho convenio no implica integración al sistema ni adhesión al Protocolo, sino únicamente la aceptación del mecanismo institucional de salida. La negativa a suscribirlo producirá la suspensión del reconocimiento interno de derechos económicos y habilitará la activación de mecanismos de salida forzosa.

=== Mecanismo de Salida Forzosa
En caso de negativa, incumplimiento o realización de actos que obstaculicen el proceso de salida o generen disrupción en el sistema, se activará de pleno derecho la salida forzosa, la cual se ejecutará mediante la enajenación obligatoria de la participación conforme al régimen de valuación y preferencia previstos en este Protocolo.

La ejecución podrá instrumentarse mediante esquemas de pago diferido, parcialidades o mecanismos de garantía, sin que la oposición del titular económico pueda impedir o suspender la operación, ni dar lugar a la conservación de su posición dentro del capital social.

=== Exclusión de Derechos de Liquidez no Previstos
El titular económico no integrado no podrá invocar derecho alguno a liquidación inmediata, rescate unilateral, separación societaria ni cualquier otro mecanismo distinto de los expresamente previstos en este apartado y en el régimen general del Protocolo.

Queda prohibida cualquier interpretación que pretenda ampliar, modificar o desnaturalizar el régimen de salida ordenada, el cual tiene carácter cerrado, obligatorio y no extensivo, constituyendo el único medio válido para la desvinculación patrimonial en estos supuestos.

== Régimen de Congelamiento Accionario Durante el Proceso Sucesorio
El presente apartado establece un régimen obligatorio, automático y de aplicación inmediata de congelamiento accionario, cuyo objeto es preservar la estabilidad del control societario, impedir alteraciones del cuadro accionario y asegurar la correcta ejecución del régimen sucesorio. El congelamiento constituye una medida estructural de protección del sistema familiar–empresarial, de eficacia interna directa y no sujeta a declaración judicial ni a aprobación de órgano alguno.

=== Activación Automática del Congelamiento
El congelamiento accionario se activa de pleno derecho, de manera inmediata, desde la actualización de cualquiera de los supuestos sucesorios previstos en este Protocolo, operando con independencia de la apertura formal del procedimiento, de la existencia de testamento o del estado procesal de la sucesión.

Para efectos de control interno, la acreditación del evento sucesorio ante el órgano encargado de la administración societaria dará lugar a la anotación preventiva correspondiente en el Libro de Registro de Acciones dentro de un plazo breve, sin que dicha formalidad condicione la existencia ni los efectos del congelamiento, los cuales surten desde el momento mismo del evento que lo origina.

=== Prohibición de Actos de Disposición o Afectación
Durante la vigencia del congelamiento queda prohibida cualquier forma de disposición, transmisión, gravamen o modificación jurídica o económica de las acciones afectadas, ya sea directa o indirecta, incluyendo actos preparatorios, condicionados o simulados que tengan por objeto alterar o anticipar los efectos del régimen sucesorio.

Esta prohibición tiene carácter absoluto y se extiende a cualquier esquema que implique transferencia, división, afectación o estructuración patrimonial sobre las acciones, independientemente de su denominación o forma jurídica.

=== Ineficacia de Actos Contrarios al Congelamiento
Todo acto realizado en contravención al congelamiento accionario será ineficaz para efectos internos y no producirá consecuencia alguna frente a la sociedad, los accionistas familiares ni los órganos de gobierno.

Dicha ineficacia opera de manera automática y no requiere declaración adicional, debiendo restituirse el estado accionario previo en caso de intento de alteración, sin perjuicio de la aplicación de las medidas y consecuencias previstas en este Protocolo.

=== Coordinación Institucional y Registro
Una vez activado el congelamiento, el órgano responsable del Libro de Registro de Acciones deberá practicar la anotación preventiva correspondiente, quedando suspendida cualquier inscripción, modificación o cancelación relacionada con las acciones afectadas, salvo aquellas expresamente permitidas en este Capítulo.

El albacea especial empresarial y los órganos sociales deberán coordinarse para asegurar el cumplimiento estricto del congelamiento, absteniéndose de promover, consentir o ejecutar actos que alteren el cuadro accionario. Durante este periodo únicamente serán admisibles anotaciones de carácter provisional o restrictivo que no confieran derechos corporativos, así como las inscripciones definitivas derivadas de la conclusión del procedimiento sucesorio.

=== Levantamiento del Congelamiento y Regularización
El congelamiento accionario solo podrá levantarse una vez concluido el procedimiento sucesorio interno y regularizada la titularidad conforme a este Protocolo, debiendo constar de manera expresa en los registros correspondientes.

Queda prohibido cualquier levantamiento parcial, tácito o anticipado. Una vez levantado, el cuadro accionario se tendrá por definitivo y no podrá ser cuestionado, reabierto o modificado dentro del sistema por hechos vinculados al proceso sucesorio concluido.

=== Tratamiento de Dividendos y Beneficios Durante el Congelamiento
Durante la vigencia del congelamiento, los dividendos, utilidades o beneficios patrimoniales correspondientes a las acciones afectadas no serán entregados a herederos, legatarios o titulares económicos, sino que deberán mantenerse en un mecanismo de resguardo neutral hasta la conclusión del procedimiento sucesorio.

Dicho resguardo no implica reconocimiento de derechos corporativos ni habilitación alguna, limitándose a preservar el valor económico hasta la determinación definitiva del régimen aplicable conforme a este Protocolo.

== Procedimiento Sucesorio Interno y Formalización Societaria
El presente apartado establece el procedimiento interno, obligatorio y secuencial mediante el cual se gestiona el evento sucesorio, se determina el tratamiento aplicable a las acciones y derechos derivados, y se formaliza la regularización societaria correspondiente. Este procedimiento tiene carácter autoejecutable, no discrecional y de aplicación inmediata, generando documentación suficiente para acreditar, dentro del sistema familiar–empresarial, la correcta aplicación del régimen sucesorio y la validez de las determinaciones adoptadas.

=== Notificación del Evento Sucesorio
El procedimiento inicia con la notificación formal del evento sucesorio por cualquiera de los sujetos legitimados, mediante la presentación del documento que acredite dicho evento ante el órgano encargado de la administración societaria. Recibida la notificación, este deberá acusar recibo, dejar constancia del congelamiento accionario y remitir la documentación al órgano de gobierno familiar competente, dentro de un plazo breve, para efectos de la conducción del proceso.

La omisión o retraso en la notificación no suspende la activación del régimen sucesorio ni del congelamiento accionario, los cuales operan desde la actualización del supuesto correspondiente, sin perjuicio de las responsabilidades internas que pudieran derivarse por incumplimiento de las obligaciones formales.

=== Intervención del Órgano Rector del Proceso
El órgano de gobierno familiar actúa como instancia rectora, coordinadora y calificadora del procedimiento sucesorio, con facultades estrictamente delimitadas a la aplicación de las disposiciones previstas en este Protocolo. Dentro de un plazo razonable a partir de la recepción de la notificación, deberá analizar el caso, verificar la categoría de los sucesores y determinar el régimen aplicable conforme a las reglas de separación de derechos, congelamiento accionario y, en su caso, salida ordenada.

Sus resoluciones deberán adoptarse conforme a las mayorías previstas, constar por escrito y limitarse a la aplicación estricta del Protocolo, quedando excluida cualquier discrecionalidad no prevista. En caso de inacción, operará de pleno derecho el régimen más restrictivo, consistente en el reconocimiento exclusivo de derechos económicos, la continuidad del congelamiento accionario y la sujeción a los mecanismos de salida correspondientes, sin que ello suspenda el procedimiento ni habilite el ejercicio de derechos corporativos.

=== Determinación del Régimen Aplicable
Con base en la resolución emitida, se establecerá de manera expresa el tratamiento patrimonial, corporativo y operativo correspondiente, incluyendo el alcance de los derechos económicos, la exclusión o eventual habilitación de derechos corporativos y la procedencia de mecanismos de salida ordenada.

Dicha determinación deberá identificar la categoría del sucesor, el régimen aplicable, las obligaciones de transmisión, valuación y pago, así como las restricciones operativas y de información que resulten pertinentes. Esta resolución tendrá carácter vinculante para los accionistas familiares y constituirá el marco interno para la actuación de los órganos societarios, sin implicar por sí misma adjudicación definitiva ni modificación formal de la titularidad accionaria.

=== Documentación y Formalización del Proceso
El procedimiento sucesorio deberá documentarse íntegramente mediante la integración de un expediente interno que incluya la notificación del evento, las constancias de recepción, las resoluciones adoptadas y las anotaciones realizadas en el Libro de Registro de Acciones. Esta documentación constituirá prueba suficiente para efectos internos respecto de la correcta aplicación del régimen sucesorio y la validez de la regularización accionaria.

// DECISIÓN EDITORIAL CAP. 04: Trasladar párrafo 2 conclusivo de 4.9.4 a P.87
#pagebreak()
Concluido el procedimiento y cumplidas las condiciones previstas en este Capítulo, el órgano de administración societaria procederá a la formalización definitiva, levantando el congelamiento accionario y practicando las inscripciones correspondientes. A partir de dicho momento, el cuadro accionario se considerará regularizado y el proceso sucesorio se tendrá por cerrado para todos los efectos internos del sistema familiar–empresarial.


// ==============================================================================
// CAPÍTULO 05: Control Institucional de la Información y Comunicación Familiar–Empresarial
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (1) previas a Chapter Opening 05
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 05
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-05") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "05",
    title: [Control Institucional de la Información y Comunicación Familiar–Empresarial],
    opening_title: ("CONTROL INSTITUCIONAL", "DE LA INFORMACIÓN", "Y COMUNICACIÓN", "FAMILIAR–EMPRESARIAL"),
    description: [Transparencia, flujos informativos, canales institucionales y \ confidencialidad en el ámbito familiar y corporativo.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 05
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 05
#metadata(5) <chapter-marker>
#metadata("first-05") <chapter-first-marker>
#counter(heading).update((5, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "05" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[05]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      CONTROL INSTITUCIONAL \ 
      DE LA INFORMACIÓN \ 
      Y COMUNICACIÓN \ 
      FAMILIAR–EMPRESARIAL
    ]
  ]
}

#v(201.81pt)

== Principio de Control Institucional de la Información
La información vinculada al sistema familiar–empresarial constituye un activo institucional estratégico sujeto a un régimen de control estricto, cuyo acceso, uso y circulación no derivan de la condición personal, familiar o patrimonial de los individuos, sino exclusivamente de habilitaciones funcionales previstas en este Protocolo. En consecuencia, la información no es un derecho inherente a la calidad de accionista, familiar o titular económico, sino una facultad condicionada al ejercicio de funciones institucionales y al cumplimiento de finalidades legítimas dentro del sistema de gobernanza.

Este régimen tiene por objeto preservar el control familiar efectivo, la estabilidad patrimonial, la coherencia en la toma de decisiones y la neutralidad operativa, reconociendo que la información constituye un vehículo indirecto de poder cuya posesión o divulgación puede alterar la dinámica institucional. Por ello, su acceso se rige por criterios de necesidad funcional, competencia institucional y canalización exclusiva a través de mecanismos formales, quedando prohibido cualquier uso, circulación o comunicación al margen de dichos parámetros.

== Clasificación de la Información Familiar–Empresarial
La información regulada en este Capítulo se limita exclusivamente a aquella vinculada a la relación familia–empresa y al ejercicio del control familiar, clasificándose en tres categorías: patrimonial, societaria–de gobernanza y estratégica–reservada, sin que este régimen resulte aplicable a la información operativa, comercial, financiera o técnica del negocio, la cual se rige por instrumentos independientes.

La información patrimonial comprende la estructura accionaria, valuaciones, mecanismos de transmisión, sucesión y salida, y se limita a lo necesario para la determinación y ejecución de derechos económicos. La información societaria y de gobernanza se refiere a decisiones, resoluciones y funcionamiento de los órganos familiares, mientras que la información estratégica o reservada abarca aquella directamente vinculada a la preservación del control, la continuidad del sistema y la gestión de decisiones estructurales.

El acceso a cada categoría se encuentra estrictamente delimitado y no admite interpretaciones extensivas ni equiparaciones automáticas entre niveles de información.

== Régimen de Acceso a la Información
El acceso a la información se encuentra sujeto a un principio de habilitación institucional, conforme al cual únicamente podrán acceder quienes desempeñen funciones vigentes dentro de órganos competentes y requieran la información de manera necesaria, proporcional y directamente vinculada a una decisión concreta. Dicho acceso no se ejerce mediante solicitudes personales ni por iniciativa individual, sino como consecuencia del ejercicio legítimo de funciones institucionales.

La pertenencia a una rama familiar activa no genera por sí misma derecho de acceso, el cual se limita estrictamente al ámbito de las funciones desempeñadas, mientras que los integrantes de ramas pasivas o titulares exclusivamente económicos únicamente podrán acceder a información patrimonial en la medida necesaria para la ejecución de sus derechos económicos, quedando excluidos de cualquier información de gobernanza o estratégica.

Salvo por las personas expresamente incorporadas al sistema familiar–empresarial conforme al apartado 2.3.3.1., la familia política y cualquier persona no habilitada carecen de todo derecho de acceso, quedando prohibida la comunicación directa o indirecta de información a su favor, sin que ello afecte el reconocimiento de derechos económicos que, en su caso, correspondan conforme a otros apartados del Protocolo.

== Régimen de Confidencialidad y Deber de Reserva
Toda la información regulada en este Capítulo tiene carácter confidencial y se encuentra sujeta a un deber de reserva reforzado, de naturaleza institucional, obligatorio y permanente para toda persona que acceda a ella por cualquier causa legítima. Este deber no depende de acuerdos contractuales ni de la permanencia en un cargo, subsistiendo de manera indefinida aun después de la terminación de la relación con el sistema familiar–empresarial.

El deber de confidencialidad implica la prohibición de divulgar, utilizar o conservar información fuera de los fines autorizados, así como la obligación de evitar su acceso por terceros no habilitados y de abstenerse de cualquier forma de comunicación indirecta, insinuación o uso indebido. Este régimen es autónomo y prevalece frente a cualquier otro esquema de confidencialidad aplicable dentro de la organización.

== Régimen de Vocería Institucional
La comunicación del sistema familiar–empresarial frente a terceros se rige por el principio de vocería única institucional, conforme al cual únicamente las personas expresamente designadas podrán emitir declaraciones, posicionamientos o comunicaciones con efectos vinculantes. Dicha vocería deberá ser definida de manera formal, delimitando su alcance, temporalidad y límites, sin que implique facultades de administración ni representación legal de la sociedad.

El vocero se limita a comunicar decisiones previamente adoptadas por los órganos competentes, quedando prohibido asumir compromisos, anticipar decisiones o interpretar discrecionalmente la voluntad institucional. Fuera de este esquema, cualquier forma de comunicación individual, informal o paralela carece de efectos internos y no genera obligación alguna para el sistema familiar–empresarial.

== Ineficacia de Actos y Remisión al Régimen Sancionador
Toda conducta que implique acceso indebido a información, divulgación no autorizada, vocería informal o emisión de declaraciones sin habilitación constituirá una infracción al Protocolo, siempre que exista evidencia objetiva que permita su acreditación.

Los actos realizados en contravención a este Capítulo serán ineficaces para efectos internos y no generarán obligación, expectativa ni responsabilidad para el sistema familiar–empresarial, sin perjuicio de la aplicación de las medidas y consecuencias previstas en el régimen sancionador correspondiente.


// ==============================================================================
// CAPÍTULO 06: Régimen de Disciplina Financiera Familiar–Empresarial
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (2) previas a Chapter Opening 06
#ceremonial-blank-page()
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 06
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-06") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "06",
    title: [Régimen de Disciplina Financiera Familiar–Empresarial],
    opening_title: ("RÉGIMEN DE", "DISCIPLINA FINANCIERA", "FAMILIAR–EMPRESARIAL"),
    description: [Criterios de endeudamiento, política de dividendos, inversiones y \ salvaguarda del patrimonio familiar.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 06
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 06
#metadata(6) <chapter-marker>
#metadata("first-06") <chapter-first-marker>
#counter(heading).update((6, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "06" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[06]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      RÉGIMEN DE \ 
      DISCIPLINA FINANCIERA \ 
      FAMILIAR–EMPRESARIAL
    ]
  ]
}

#v(177.80pt)

== Principio de Disciplina Financiera y Neutralidad Patrimonial
La empresa se reconoce como un patrimonio institucional autónomo, destinado exclusivamente a la operación, sostenibilidad y desarrollo del negocio, por lo que queda prohibido considerarla como fuente de liquidez familiar, mecanismo de compensación interna o extensión patrimonial de sus accionistas. En consecuencia, la disposición de recursos empresariales no constituye un derecho derivado de la calidad familiar o accionaria, sino una facultad estrictamente institucional, sujeta a autorización expresa, finalidad legítima y trazabilidad verificable.

Este principio tiene por objeto preservar la continuidad empresarial, la integridad del capital de trabajo y la neutralidad operativa, evitando que decisiones patrimoniales individuales comprometan la estabilidad del sistema. Toda asignación o uso de recursos deberá responder a criterios de competencia institucional y quedar debidamente documentado, quedando excluidas prácticas basadas en costumbre, tolerancia o acuerdos informales.

== Prohibición de Apropiación Informal de Recursos
Se prohíbe de manera absoluta cualquier uso, disposición o aprovechamiento de recursos de la empresa que no derive de un acto corporativo válido o de una decisión operativa legítima. Se entenderá como apropiación informal toda extracción o utilización realizada por iniciativa personal o familiar, o al margen de los canales institucionales, aun cuando exista tolerancia, expectativa de restitución o ausencia de perjuicio inmediato.

Dicha prohibición aplica a toda persona vinculada al sistema, sin excepción, y cualquier acto en contravención será ineficaz para efectos internos, no susceptible de regularización y generará responsabilidad patrimonial individual.

== Prohibición de Préstamos, Anticipos o Beneficios no Autorizados
Queda prohibido otorgar o recibir préstamos, anticipos, apoyos financieros o cualquier beneficio económico con recursos de la empresa fuera del régimen excepcional previsto en este Capítulo. Ninguna disposición financiera será válida si no cuenta con autorización previa del órgano competente, condiciones definidas ex ante y documentación completa e independiente.

Se excluyen expresamente esquemas sustentados en confianza familiar, prácticas previas, acuerdos verbales o compensaciones informales, los cuales carecerán de validez y no generarán derecho de crédito ni expectativa alguna frente a la empresa.

== Régimen Excepcional de Disposiciones Financieras Permitidas
El otorgamiento de apoyos financieros a accionistas constituye una excepción estricta y no un derecho. Como regla general, se prohíbe cualquier forma de financiamiento con recursos sociales, incluyendo préstamos, garantías o utilización de capacidad financiera de la empresa.

Solo podrá considerarse excepcionalmente cuando exista una contingencia personal grave o un proyecto estratégicamente justificado para el sistema, siempre que no se comprometa la estabilidad financiera ni se utilicen las acciones como garantía. Aun en estos casos, no se genera derecho alguno al otorgamiento del apoyo, sino únicamente la posibilidad de someter el caso a evaluación institucional.

La solicitud deberá seguir un proceso en dos niveles: una calificación previa por el órgano familiar, de carácter no vinculante, y una decisión autónoma por los órganos societarios competentes, quienes resolverán con base en criterios estrictamente empresariales. Cualquier disposición fuera de este esquema será ineficaz dentro del sistema.

== Prohibición de Afectación del Patrimonio Accionario frente a Terceros
Las acciones constituyen un activo estratégico cuya titularidad se encuentra sujeta a un régimen institucional de carácter heterónomo, en el que su uso, disposición y afectación quedan subordinados a la preservación del control familiar y a la integridad del sistema familiar–empresarial.

En consecuencia, se prohíbe de manera absoluta utilizarlas como garantía, respaldo o instrumento de cumplimiento frente a terceros, bajo cualquier modalidad. Esta prohibición tiene carácter estructural y permanente, y no admite excepción, autorización ni convalidación posterior, aun cuando exista conocimiento o notificación previa al órgano familiar competente.

Lo anterior es independiente de la obligación del accionista de informar oportunamente cualquier compromiso financiero o circunstancia que pueda generar riesgos para su patrimonio o solvencia, la cual en ningún caso podrá interpretarse como autorización para afectar, directa o indirectamente, el capital accionario.

Cualquier acto que implique la exposición del capital accionario a riesgos de ejecución, afectación o pérdida de control será ineficaz para efectos internos y no generará reconocimiento dentro del sistema, sin perjuicio de la responsabilidad personal del accionista que lo realice.

== Responsabilidad Patrimonial e Ineficacia Institucional
Todo incumplimiento a las disposiciones del presente Capítulo será imputable de manera exclusiva al accionista infractor, quien asumirá íntegramente las consecuencias derivadas, sin que exista obligación de rescate, compensación o cobertura por parte de la empresa o de los demás integrantes del sistema.

Los actos realizados en contravención carecerán de eficacia interna, no generarán derechos ni obligaciones exigibles y no podrán ser validados, regularizados ni utilizados como precedente. Su actualización constituirá una infracción al sistema de gobernanza y habilitará la aplicación del régimen sancionador correspondiente.


// ==============================================================================
// CAPÍTULO 07: Procedimiento Sancionador y Régimen de Sanciones Internas
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (2) previas a Chapter Opening 07
#ceremonial-blank-page()
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 07
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-07") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "07",
    title: [Procedimiento Sancionador y Régimen de Sanciones Internas],
    opening_title: ("PROCEDIMIENTO", "SANCIONADOR Y", "RÉGIMEN DE SANCIONES", "INTERNAS"),
    description: [Faltas, medidas disciplinarias y procedimientos formales ante el \ incumplimiento de los acuerdos del protocolo.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 07
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 07
#metadata(7) <chapter-marker>
#metadata("first-07") <chapter-first-marker>
#counter(heading).update((7, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "07" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[07]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      PROCEDIMIENTO \ 
      SANCIONADOR Y \ 
      RÉGIMEN DE SANCIONES \ 
      INTERNAS
    ]
  ]
}

#v(201.81pt)

== Principios Rectores del Régimen Sancionador
El presente Capítulo establece el régimen interno de consecuencias aplicable a las infracciones del Protocolo, con el objeto de asegurar su cumplimiento efectivo, uniforme y vinculante dentro del sistema familiar–empresarial. Dicho régimen no crea obligaciones nuevas, sino que articula y hace exigibles las consecuencias previstas en los Capítulos anteriores.

El ejercicio del poder sancionador se rige por los principios de legalidad, tipicidad, proporcionalidad y debido proceso interno, garantizando el derecho de audiencia, defensa y resolución fundada, y excluyendo cualquier forma de sanción informal, discrecional o extraprocedimental. Su naturaleza es interna, autónoma y compatible con las acciones legales que pudieran corresponder conforme a la legislación aplicable.

== Sujetos Obligados y Alcance del Régimen
El régimen sancionador es obligatorio para todos los sujetos que intervienen en el sistema familiar–empresarial, incluyendo accionistas, miembros de la familia empresaria, titulares económicos, integrantes de órganos de gobierno y cualquier persona que actúe directa o indirectamente bajo su influencia.

Será aplicable a toda conducta que contravenga el Protocolo, aun cuando se realice fuera del ámbito societario formal, mediante prácticas informales o sin que exista daño efectivo. La sujeción al régimen deriva de la participación en el sistema y no requiere reconocimiento expreso, quedando excluida cualquier pretensión de excepción basada en jerarquía, antigüedad o vínculo familiar.

== Clasificación de Infracciones
Las infracciones se clasifican en leves, graves y muy graves, atendiendo a su impacto institucional, afectación patrimonial o riesgo para el sistema. Su determinación se realiza exclusivamente conforme al Protocolo, sin interpretaciones extensivas.

Se consideran infracciones leves aquellas desviaciones aisladas de carácter formal o procedimental sin impacto relevante. Las infracciones graves comprenden conductas que alteran la gobernanza, el manejo de información, la disciplina patrimonial o el ejercicio indebido de derechos. Las infracciones muy graves incluyen actos que comprometen estructuralmente el sistema, tales como simulación, apropiación de recursos, violación del régimen sucesorio, abuso de poder o conductas que pongan en riesgo la continuidad empresarial.

La configuración de la infracción no depende de la existencia de daño, bastando la vulneración objetiva del orden institucional.

== Procedimiento Sancionador Interno
El procedimiento sancionador tiene carácter escrito, institucional y no discrecional, y se desarrolla en tres etapas: inicio, instrucción y resolución.

El procedimiento se inicia por acuerdo del órgano familiar competente, previa valoración preliminar de los hechos. A partir de su apertura, se integra un expediente único que concentrará todas las actuaciones, garantizando trazabilidad y formalidad del proceso.

El presunto infractor tendrá derecho pleno de audiencia y defensa, incluyendo acceso al expediente, presentación de argumentos y ofrecimiento de pruebas dentro de plazos definidos. El órgano instructor deberá admitir únicamente aquellas pruebas pertinentes y conducir el procedimiento de manera ágil, evitando dilaciones indebidas.

Concluida la etapa de instrucción, el expediente será remitido al órgano resolutor competente, el cual analizará los hechos acreditados, calificará la infracción y determinará, en su caso, la sanción aplicable mediante resolución fundada y motivada.

La resolución será definitiva dentro del sistema, obligatoria y vinculante, y su ejecución corresponderá al órgano que haya instruido el procedimiento, sin posibilidad de revisión interna adicional.

== Órganos Competentes
La instrucción del procedimiento corresponde al órgano familiar designado, mientras que la calificación de la infracción y la imposición de sanciones corresponden de manera exclusiva al órgano resolutor previsto en este Protocolo.

Ningún otro órgano o persona podrá imponer sanciones ni adoptar medidas disciplinarias fuera del procedimiento formal, quedando prohibida cualquier forma de sanción paralela, informal o indirecta. Cuando la sanción tenga efectos societarios, su ejecución se canalizará a los órganos correspondientes sin que estos puedan modificar la resolución.

== Catálogo de Sanciones
Las sanciones previstas en el presente numeral constituyen las únicas consecuencias disciplinarias internas aplicables por la comisión de infracciones conforme al numeral 7.3, y deberán imponerse con base en los principios de legalidad, tipicidad, proporcionalidad, razonabilidad y afectación institucional. En ningún caso podrán aplicarse sanciones no previstas expresamente en este Capítulo.

Las sanciones aplicables son la siguientes:

#legal-alpha("a)", [#strong[Amonestación Formal]: Consiste en un apercibimiento institucional por escrito en el que se deja constancia de la infracción, la desaprobación de la conducta y la obligación de no reincidir. Será aplicable a infracciones leves y, excepcionalmente, a infracciones graves cuando existan atenuantes y no se genere afectación institucional relevante. Se registrará en el expediente correspondiente y podrá considerarse como antecedente para efectos de reincidencia.])
#legal-alpha("b)", [#strong[Suspensión de Derechos Corporativos]: Consiste en la privación temporal del ejercicio de derechos de carácter político o de control, incluyendo voz, voto, participación en órganos y acceso a información estratégica. Será aplicable a infracciones graves o muy graves, por un plazo no menor a seis meses ni mayor a tres años, atendiendo a la gravedad, reiteración e impacto de la conducta. Durante este periodo, el sujeto conservará sus derechos económicos, salvo disposición expresa en contrario.])
#legal-alpha("c)", [#strong[Exclusión del Sistema Familiar–Empresarial]: Consiste en la pérdida definitiva de la condición de integrante del sistema familiar–empresarial y de los derechos de participación, control e intervención derivados del mismo. Procederá únicamente en casos de infracciones muy graves de especial trascendencia, reincidencia reiterada o incompatibilidad del sujeto con la estabilidad del sistema. No implicará, por sí misma, la pérdida de derechos económicos, los cuales se regirán conforme a los mecanismos patrimoniales aplicables. La exclusión deberá ser resuelta por el Comité de Honor Familiar y ejecutada por el Consejo de Familia.])
Las sanciones temporales deberán imponerse por plazo determinado, con indicación expresa de su inicio y conclusión. La amonestación formal tendrá carácter definitivo y la exclusión será permanente.

La suspensión de derechos corporativos deberá sujetarse estrictamente a los plazos establecidos anteriormente y no podrá prorrogarse automáticamente.

De manera excepcional, la amonestación podrá acumularse con la suspensión de derechos corporativos cuando la naturaleza de la infracción lo justifique. En ningún caso podrán imponerse sanciones de la misma naturaleza de forma simultánea ni combinaciones que resulten contrarias a la legislación aplicable o a los principios del presente Protocolo.

== Reincidencia y Efectos Acumulativos
La reincidencia en conductas infractoras será considerada como agravante para efectos de la imposición de sanciones, permitiendo escalar la respuesta disciplinaria conforme a la gravedad y persistencia del incumplimiento.

Los antecedentes sancionatorios deberán registrarse de manera institucional y podrán ser considerados para la individualización de sanciones futuras, sin que generen por sí mismos derechos adquiridos ni limitaciones al ejercicio del régimen disciplinario.


// ==============================================================================
// CAPÍTULO 08: Medios Alternativos de Solución de Conflictos Familiares–Empresariales
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (1) previas a Chapter Opening 08
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 08
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-08") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "08",
    title: [Medios Alternativos de Solución de Conflictos Familiares–Empresariales],
    opening_title: ("MEDIOS ALTERNATIVOS DE", "SOLUCIÓN DE CONFLICTOS", "FAMILIARES–EMPRESARIALES"),
    description: [Procedimientos de mediación, conciliación y arbitraje para la resolución \ pacífica de controversias internas.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 08
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 08
#metadata(8) <chapter-marker>
#metadata("first-08") <chapter-first-marker>
#counter(heading).update((8, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "08" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[08]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      MEDIOS ALTERNATIVOS DE \ 
      SOLUCIÓN DE CONFLICTOS \ 
      FAMILIARES–EMPRESARIALES
    ]
  ]
}

#v(177.80pt)

== Principio de Solución Institucional y Escalonada de Conflictos
Los conflictos dentro del sistema familiar–empresarial deberán resolverse de manera institucional, ordenada y no judicial, mediante mecanismos internos y alternativos estructurados, excluyendo cualquier aproximación informal, reactiva o basada en estrategias individuales.

La gestión del conflicto constituye una función del sistema y no de las partes, orientada a preservar la continuidad empresarial, el control familiar y la coherencia del modelo de gobernanza. En consecuencia, toda controversia deberá canalizarse mediante un esquema escalonado obligatorio que prioriza la resolución interna, posteriormente la mediación y, en última instancia, el arbitraje como mecanismo definitivo.

La jurisdicción judicial queda limitada a funciones de apoyo y ejecución, sin intervención en la decisión de fondo, reforzando el carácter autónomo del sistema de solución de conflictos.

== Obligatoriedad del Agotamiento Previo
Todo conflicto deberá someterse de manera previa, obligatoria y secuencial a los mecanismos previstos en este Capítulo, quedando prohibido acudir directamente a instancias judiciales o externas sin haber agotado íntegramente el procedimiento interno.

El régimen opera bajo un orden excluyente: primero la instancia institucional interna, luego la mediación cuando proceda, y finalmente el arbitraje como vía definitiva.

El incumplimiento de este orden constituye una infracción al Protocolo y no produce efectos dentro del sistema, con independencia de la naturaleza o urgencia del conflicto.

== Ámbito de Aplicación del Régimen de Conflictos
Quedan sujetos a este régimen todos los conflictos que deriven directa o indirectamente de la relación familiar–empresarial, incluyendo aquellos relacionados con derechos accionarios, gobierno corporativo, sucesión, información, disciplina financiera y sanciones internas.

También se incluyen controversias entre accionistas, ramas familiares o sujetos vinculados, así como conflictos que, aun presentándose como reclamaciones individuales, tengan impacto en el sistema institucional.

Únicamente se excluyen aquellos asuntos que, por disposición legal, no sean susceptibles de mediación o arbitraje.

== Instancia Interna: Comité de Honor Familiar
El Comité de Honor Familiar constituye la instancia obligatoria, previa y excluyente para el conocimiento inicial de cualquier conflicto, actuando como órgano institucional de análisis y encauzamiento.

Su intervención es necesaria antes de acudir a cualquier mecanismo alternativo y tiene por objeto restablecer el orden institucional, emitir criterios interpretativos y, en su caso, canalizar el conflicto hacia mediación o arbitraje.

Las partes están obligadas a comparecer, actuar de buena fe y sujetarse a sus determinaciones. Su incumplimiento constituye infracción al Protocolo.

== Mediación Familiar–Empresarial
La mediación es un mecanismo institucional asistido por un tercero neutral, orientado a facilitar acuerdos entre las partes, sin alterar el marco normativo del Protocolo ni permitir la negociación de elementos estructurales del sistema.

Solo procede cuando el conflicto no se haya resuelto internamente y exista remisión expresa del órgano competente. No puede activarse unilateralmente ni exceder los límites establecidos en dicha remisión.

El procedimiento será confidencial, de duración limitada y con suspensión de plazos internos. En caso de no alcanzarse acuerdo, el conflicto deberá remitirse a arbitraje.

== Arbitraje Familiar–Empresarial
El arbitraje constituye el mecanismo definitivo, obligatorio y exclusivo para la resolución del fondo de los conflictos arbitrables. Su activación requiere haber agotado previamente la instancia interna y, en su caso, la mediación.

El arbitraje sustituye a la jurisdicción judicial ordinaria para la decisión del fondo del conflicto, siendo vinculante por el solo hecho de la adhesión al Protocolo. El tribunal arbitral tendrá competencia plena para resolver la controversia, incluyendo su propia competencia.

Serán arbitrables todas las controversias de naturaleza patrimonial, corporativa o institucional derivadas del Protocolo, con excepción de aquellas que por ley no puedan someterse a arbitraje.

== Efectos de la Mediación y del Arbitraje
Los acuerdos alcanzados en mediación serán vinculantes para las partes y obligatorios dentro del sistema, mientras que los laudos arbitrales tendrán carácter definitivo, inapelable y plenamente ejecutable.

El incumplimiento de dichos acuerdos o laudos constituirá infracción grave al Protocolo y dará lugar a la aplicación del régimen sancionador, sin perjuicio de su ejecución legal correspondiente.

== Prohibición de Judicialización Prematura
Se prohíbe promover acciones judiciales sin haber agotado el régimen escalonado previsto, considerándose dicha conducta como judicialización prematura e infracción grave al Protocolo.

Los sujetos obligados renuncian expresamente a la jurisdicción judicial ordinaria para la resolución del fondo de los conflictos arbitrables, limitando su intervención a funciones de apoyo, medidas cautelares y ejecución de laudos.

Los costos derivados de la judicialización indebida deberán ser restituidos por el infractor, sin perjuicio de las sanciones internas correspondientes.

== Coordinación con el Régimen Sancionador
El régimen de solución de conflictos opera de manera complementaria al procedimiento sancionador interno, sin sustituirlo ni suspenderlo.

// DECISIÓN EDITORIAL CAP. 08: Mantener H2 8.9 + P1 en P.118; trasladar P2 y P3 a P.119
#pagebreak()
La existencia de un conflicto no excluye la responsabilidad por infracciones al Protocolo, ni la mediación o el arbitraje tienen por efecto extinguir dichas responsabilidades, salvo disposición expresa del órgano competente.

El incumplimiento de las reglas previstas en este Capítulo será sancionado conforme al régimen disciplinario, reforzando la eficacia y coherencia del sistema.


// ==============================================================================
// CAPÍTULO 09: Régimen Jurídico del Protocolo Familiar
// SECUENCIA CEREMONIAL: [BLANCA VERSO | OPENING RECTO] -> [BLANCA VERSO | FIRST-PAGE RECTO]
// ==============================================================================

// SPREAD A: Páginas blancas ceremoniales (1) previas a Chapter Opening 09
#ceremonial-blank-page()

// SPREAD A (RECTO): Portada de capítulo 09
#page(margin: 0pt, header: none, footer: none, fill: rgb("#fffdf0"))[
  #metadata("opening-09") <chapter-opening-marker>
  #chapter-opening(
    cfg,
    number: "09",
    title: [Régimen Jurídico del Protocolo Familiar],
    opening_title: ("RÉGIMEN JURÍDICO DEL", "PROTOCOLO FAMILIAR"),
    description: [Naturaleza vinculante, mecanismos de adopción estatutaria y \ formalización contractual de los acuerdos.],
    is_recto: false
  )
]

// SPREAD B (VERSO): Página blanca ceremonial previa a Primera Página 09
#ceremonial-blank-page()

// SPREAD B (RECTO): Primera página de contenido Capítulo 09
#metadata(9) <chapter-marker>
#metadata("first-09") <chapter-first-marker>
#counter(heading).update((9, 0, 0, 0))

#context {
  let p = counter(page).get().first()
  let is_recto = calc.odd(p)
  let neuzeit = ("Neuzeit Grotesk", "Segoe UI")
  let minion = ("Minion Pro", "Georgia")

  // 1. Claim institucional superior (FIJO en coordenada absoluta y = 29.00pt)
  let clm_content = text(font: neuzeit, size: 4.8234pt, fill: rgb("#6c6b67"), tracking: 0.371em)[
    UN LEGADO \ QUE TRASCIENDE, \ UN FUTURO QUE \ CONSTRUIMOS #text(fill: rgb("#f15e22"))[JUNTOS.]
  ]
  if is_recto {
    place(top + left, dx: 0pt, dy: -42.0079pt)[#clm_content]
  } else {
    place(top + right, dx: 0pt, dy: -42.0079pt)[#align(right)[#clm_content]]
  }

  // 2. Número display grande "09" (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 28pt)[
    #text(font: minion, size: 39.3657pt, fill: rgb("#f15d22"), tracking: -0.050em, weight: "medium")[09]
  ]

  // 3. Regla horizontal naranja (desplazada +17.0079pt)
  place(top + left, dx: 1.36pt, dy: 74.95pt)[
    #rect(width: 14.19pt, height: 0.91pt, fill: rgb("#f15d22"), stroke: none)
  ]

  // 4. Título completo de capítulo (desplazado +17.0079pt)
  place(top + left, dx: 0pt, dy: 98.30pt)[
    #block(width: 280pt)[
      #set text(font: minion, size: 15.9929pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")
      #set par(leading: 13.5939pt, justify: false)
      RÉGIMEN JURÍDICO DEL \ 
      PROTOCOLO FAMILIAR
    ]
  ]
}

#v(153.79pt)

== Naturaleza Jurídica y Carácter Vinculante
El Protocolo constituye un instrumento normativo interno de carácter vinculante, obligatorio y autoaplicativo, destinado a regular de manera integral la relación entre la familia empresaria y la empresa, así como la estructura de propiedad, control, gobernanza, sucesión, disciplina patrimonial, información, solución de conflictos y régimen de consecuencias.

No tiene naturaleza declarativa ni programática, sino que establece reglas exigibles cuya fuerza deriva de la adhesión de los sujetos obligados, su integración con los Estatutos Sociales y su función como marco rector del sistema familiar–empresarial. Su incumplimiento no afecta su validez, sino que activa las consecuencias previstas en el propio instrumento.

== Sujetos Obligados y Alcance
Quedan obligados todos aquellos que participen o incidan en el sistema familiar–empresarial, incluyendo accionistas familiares, miembros de la familia, herederos, beneficiarios económicos, integrantes de órganos de gobierno, directivos y cualquier persona que actúe por instrucción o influencia de un sujeto obligado.

La sujeción deriva de la adhesión expresa o de la participación efectiva en el sistema, sin que pueda invocarse condición personal, jerárquica o patrimonial para excluir su aplicación. El Protocolo será oponible desde su entrada en vigor y su incumplimiento dará lugar a consecuencias internas.

== Jerarquía Normativa Interna
El Protocolo forma parte de una jerarquía normativa interna obligatoria que rige el sistema familiar–empresarial. En las materias que regula, prevalece sobre los demás instrumentos, seguido de los Estatutos Sociales, acuerdos societarios y prácticas reconocidas.

En caso de contradicción, prevalecerá la norma de mayor jerarquía, quedando sin efecto interno cualquier disposición incompatible. Ningún órgano podrá modificar el Protocolo fuera del procedimiento formal previsto, ni justificarse en prácticas informales o acuerdos paralelos.

== Vigencia y Efectos
El Protocolo entra en vigor con su aprobación y ratificación formal, siendo obligatorio desde ese momento. Sus disposiciones tienen efectos inmediatos sobre situaciones en curso, sin perjuicio de los derechos adquiridos conforme a la ley.

Las estructuras, prácticas o acuerdos incompatibles deberán ajustarse al Protocolo, el cual tendrá vigencia indefinida hasta su modificación formal.

== Procedimiento de Reforma
El Protocolo solo podrá modificarse mediante un procedimiento formal, fundado y con mayoría calificada, quedando prohibidas modificaciones implícitas, prácticas reiteradas o acuerdos informales.

La iniciativa corresponde al órgano familiar competente o a una minoría relevante del capital, debiendo presentarse por escrito con justificación clara.

La aprobación requiere mayoría calificada y su ausencia implica el rechazo definitivo. La revisión periódica es obligatoria, pero no implica modificación automática.

== Adhesión y Ratificación
La adhesión al Protocolo deberá realizarse mediante suscripción expresa; sin embargo, la participación efectiva en el sistema genera sujeción tácita.

La ratificación será requisito para el ejercicio de derechos dentro del sistema, y su negativa impedirá la participación institucional. La adhesión no modifica la titularidad patrimonial, pero sí condiciona el ejercicio de derechos al cumplimiento del régimen establecido.

== Nulidad de Pactos Paralelos y Actos de Elusión
Quedan prohibidos y carecerán de efectos internos todos los acuerdos, prácticas o estructuras que contravengan o pretendan eludir el Protocolo.

Cualquier mecanismo que, bajo apariencia de legalidad, busque alterar su aplicación será nulo internamente y constituirá infracción grave, sin necesidad de declaración adicional.

// REGLA C: Redistribución hacia adelante de unidad semántica completa
#pagebreak()
== Interpretación y Cierre Normativo
El Protocolo deberá interpretarse de manera sistemática y conforme a su finalidad institucional, privilegiando la continuidad empresarial, el control familiar y la coherencia del sistema.

La interpretación corresponde a los órganos internos competentes, sin perjuicio del arbitraje para la resolución de controversias.

El Protocolo constituye un sistema normativo cerrado, no susceptible de integración mediante prácticas externas, y la invalidez de alguna disposición no afectará la eficacia del resto.

