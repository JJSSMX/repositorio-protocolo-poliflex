// ==============================================================================
// TEST CAPÍTULOS 04–09 — SISTEMA EDITORIAL LOCKED
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// Generado automáticamente por scripts/compilar_fase_3_9.py
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
        // FRANJA INFERIOR CHAPTER-FIRST-PAGE CORREGIDA MATEMÁTICAMENTE (FASE 3.8.1 / 3.9)
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
La sucesión accionaria tiene como finalidad exclusiva la transmisión del valor económico de las acciones y la preservación del control familiar y de la continuidad funcional de la sociedad, quedando expresamente excluida cualquier interpretación que implique la transmisión automática de la condición de accionista pleno o del ejercicio de derechos corporativos. En consecuencia, la sucesión no constituye un mecanismo de acceso directo a la estructura societaria, sino un proceso institucional que produce efectos económicos inmediatos a favor de los sucesores, condicionando cualquier efecto de naturaleza societaria al cumplimiento del régimen previsto en este Capítulo.

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

== Interpretación y Cierre Normativo
El Protocolo deberá interpretarse de manera sistemática y conforme a su finalidad institucional, privilegiando la continuidad empresarial, el control familiar y la coherencia del sistema.

La interpretación corresponde a los órganos internos competentes, sin perjuicio del arbitraje para la resolución de controversias.

El Protocolo constituye un sistema normativo cerrado, no susceptible de integración mediante prácticas externas, y la invalidez de alguna disposición no afectará la eficacia del resto.

