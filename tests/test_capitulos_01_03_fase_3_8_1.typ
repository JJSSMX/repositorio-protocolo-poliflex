// ==============================================================================
// TEST CAPÍTULOS 01–03 — FASE 3.8.1: ALINEACIÓN INFERIOR Y RESPIRACIÓN TEMÁTICA
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// Generado automáticamente por scripts/compilar_fase_3_8_1.py
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

// Marcadores de página y contenido
#show par: it => [
  #it
  #metadata("par") <content-marker>
]

// Componente reutilizable: Página blanca ceremonial (0 elementos, cuenta para paridad)
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
    inside: 58.74pt,   // Lomo: 58.74pt (izq en impar, der en par)
    outside: 22.70pt,  // Corte: 22.70pt (der en impar, izq en par)
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
        // ==============================================================================
        // FRANJA INFERIOR CHAPTER-FIRST-PAGE CORREGIDA MATEMÁTICAMENTE (FASE 3.8.1)
        // Compensación exacta: #v(20pt - 5.0535pt) = #v(14.9465pt)
        // Baseline Folio First Page = 591.708 pt (Idéntico a interior-page = 591.708 pt)
        // ==============================================================================
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
        // Páginas de continuación: SOLO folio en corte exterior (referencia estándar)
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

// H2: Sección principal (+18 pt adicional antes de nueva sección)
#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 18.35pt + 18.00pt, below: 15.42pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 10pt, fill: rgb("#f15d22"), stroke: 0.4pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(5.5pt)#text(font: minion, size: 10pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

// H3: Subsección (+18 pt adicional antes de nueva subsección)
#show heading.where(level: 3): it => block(width: 100%, breakable: false, sticky: true, above: 14.00pt + 18.00pt, below: 10.00pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 9.5pt, fill: rgb("#f15d22"), stroke: 0.3pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(5.0pt)#text(font: minion, size: 9.5pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

// H4: Sub-subsección (+18 pt adicional antes de nueva sub-subsección)
#show heading.where(level: 4): it => block(width: 100%, breakable: false, sticky: true, above: 10.00pt + 18.00pt, below: 8.00pt)[
  #let minion = ("Minion Pro", "Georgia")
  #box[
    #text(font: minion, size: 9pt, fill: rgb("#f15d22"), stroke: 0.2pt + rgb("#f15d22"), weight: "medium")[#counter(heading).display()]
  ]#h(4.5pt)#text(font: minion, size: 9pt, fill: rgb("#2e2f31"), tracking: 0.019em, weight: "medium")[#it.body]
]

// Componentes de listas jurídicas con sangría de bloque exacta y prevención de orfandad
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

