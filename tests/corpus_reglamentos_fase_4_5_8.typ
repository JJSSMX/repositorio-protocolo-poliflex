// ==============================================================================
// CORPUS NORMATIVO CANÓNICO COMPLETO: FASE 4.5.8 [LOCKED]
// Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// Importa EXCLUSIVAMENTE templates/typst/componentes.typ
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let render-reglamento-asamblea(
  variant: "A8",
  article_above: 12.72949pt,
  article_below: 12.00pt,
  chapter_above: 18.00pt,
  chapter_below: 12.73pt,
  transitory_below: 12.00pt,
  list_intra_leading: 5.00pt,
  list_inter_below: 7.50pt,
  list_last_below: 14.00pt,
  list_justify: false
) = [
  // Línea 14: CAPÍTULO I - DE LAS DISPOSICIONES GENERALES
  #regulation-chapter("CAPÍTULO I", "DE LAS DISPOSICIONES GENERALES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 19: Artículo 1. Del Objeto y Alcance
  #regulation-article("Artículo 1.", "Del Objeto y Alcance", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El presente Reglamento tiene por objeto regular la integración, convocatoria, funcionamiento, desarrollo de sesiones, adopción de acuerdos y seguimiento de las actividades de la Asamblea de Familia prevista en el Protocolo Familiar.

  La Asamblea de Familia ejercerá sus funciones de conformidad con lo dispuesto en el Protocolo Familiar, el presente Reglamento y los acuerdos válidamente adoptados en el ámbito de su competencia.

  // Línea 26: Artículo 2. De la Prevalencia del Protocolo Familiar
  #regulation-article("Artículo 2.", "De la Prevalencia del Protocolo Familiar", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El presente Reglamento constituye un instrumento de desarrollo y ejecución del Protocolo Familiar, por lo que deberá interpretarse y aplicarse de manera consistente con sus principios, disposiciones y objetivos.

  En caso de discrepancia, contradicción, incompatibilidad o duda interpretativa entre lo previsto en este Reglamento y el Protocolo Familiar, prevalecerá en todo momento lo dispuesto en este último. En consecuencia, cualquier disposición, interpretación o aplicación del presente Reglamento que resulte contraria al Protocolo Familiar carecerá de efectos dentro del sistema familiar–empresarial.

  // Línea 33: CAPÍTULO II - DE LA INTEGRACIÓN Y PARTICIPACIÓN
  #regulation-chapter("CAPÍTULO II", "DE LA INTEGRACIÓN Y PARTICIPACIÓN", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 38: Artículo 3. De la Integración
  #regulation-article("Artículo 3.", "De la Integración", variant: variant, above_spacing: article_above, below_spacing: article_below)

  La Asamblea de Familia estará integrada por todos los miembros de la familia empresaria reconocidos conforme al Protocolo Familiar.

  Asimismo, formarán parte de la Asamblea de Familia los integrantes de la familia política cuya incorporación al sistema familiar–empresarial haya sido aprobada conforme a las disposiciones del Protocolo Familiar.

  La calidad de integrante de la Asamblea de Familia se adquirirá una vez cumplidos los requisitos, formalidades y procedimientos previstos en el Protocolo Familiar para la incorporación al sistema familiar–empresarial. En los casos en que resulte aplicable, dicha incorporación requerirá la aprobación expresa de la Asamblea de Familia y la suscripción de la correspondiente Carta de Adhesión.

  Los integrantes de la familia empresaria participarán con derecho de voz y voto. Los integrantes de la familia política incorporados al sistema familiar–empresarial ejercerán los derechos de participación que expresamente determine la Asamblea de Familia en el acuerdo de incorporación correspondiente, incluyendo, en su caso, derechos de voz, voto, restricciones específicas o cualquier otra condición que la propia Asamblea estime procedente.

  La Asamblea o, en su caso, quien emita la convocatoria, podrá autorizar la participación de invitados, asesores, especialistas o terceros cuya intervención resulte conveniente para el análisis de asuntos determinados, quienes participarán únicamente con derecho de voz.

  // Línea 51: CAPÍTULO III - DE LAS CONVOCATORIAS
  #regulation-chapter("CAPÍTULO III", "DE LAS CONVOCATORIAS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 56: Artículo 4. De las Convocatorias
  #regulation-article("Artículo 4.", "De las Convocatorias", variant: variant, above_spacing: article_above, below_spacing: article_below)

  La Asamblea de Familia celebrará sesiones ordinarias y extraordinarias. Las sesiones ordinarias tendrán por objeto atender los asuntos periódicos de la familia empresaria y dar seguimiento a los acuerdos previamente adoptados.

  Las sesiones extraordinarias podrán celebrarse cuando la naturaleza, urgencia o importancia de los asuntos así lo requiera.

  Las convocatorias deberán realizarse por cualquier medio que permita dejar constancia de su recepción, incluyendo medios físicos o electrónicos.

  La convocatoria deberá contener, al menos:

  #regulation-fraction("I.", [Fecha y hora de la sesión;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Lugar de celebración o medio de conexión correspondiente;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Tipo de sesión;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Orden del Día; y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("V.", [Información o documentación relevante para el análisis de los asuntos a tratar.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  La convocatoria y documentación soporte podrán remitirse conjuntamente o ponerse a disposición de los participantes por medios físicos o electrónicos.

  Salvo causa justificada, las convocatorias deberán realizarse con al menos cinco días naturales de anticipación.

  // Línea 76: CAPÍTULO IV - INSTALACIÓN Y DESARROLLO DE LAS SESIONES
  #regulation-chapter("CAPÍTULO IV", "INSTALACIÓN Y DESARROLLO DE LAS SESIONES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 81: Artículo 5. De la Instalación de la Asamblea
  #regulation-article("Artículo 5.", "De la Instalación de la Asamblea", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Las sesiones serán presididas por la persona que la propia Asamblea designe al inicio de cada reunión. Asimismo, se designará un Secretario de la sesión, quien será responsable de levantar el acta correspondiente y dar seguimiento a los acuerdos adoptados.

  Las reglas de instalación y votación previstas en el presente Reglamento se aplicarán sin perjuicio de aquellos asuntos para los cuales el Protocolo Familiar exija unanimidad de votos o una mayoría calificada para su aprobación. En tales casos, deberán respetarse los porcentajes, requisitos y mecanismos de votación específicamente previstos en el Protocolo Familiar.

  Fuera de los supuestos señalados en el párrafo anterior, la Asamblea se considerará válidamente instalada cuando se encuentren presentes o representadas al menos el setenta y cinco por ciento de las personas con derecho a voto.

  Si no se alcanzare el quórum previsto en el párrafo anterior, podrá celebrarse una segunda convocatoria, en cuyo caso la Asamblea se considerará válidamente instalada con la asistencia de al menos el cincuenta y cinco por ciento de las personas con derecho a voto.

  La instalación válida de la Asamblea no implicará, por sí misma, la posibilidad de resolver asuntos sujetos a regímenes especiales de aprobación. Tratándose de materias reservadas o de cualquier otro asunto sujeto a mayorías reforzadas conforme al Protocolo Familiar, únicamente podrán adoptarse acuerdos cuando concurran los requisitos de capital familiar, ramas familiares activas y demás condiciones expresamente previstas en dicho instrumento.

  // Línea 94: Artículo 6. Del Desarrollo de las Sesiones
  #regulation-article("Artículo 6.", "Del Desarrollo de las Sesiones", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Las sesiones se desarrollarán conforme al Orden del Día aprobado al inicio de la reunión. Las personas participantes tendrán derecho a expresar sus opiniones, formular propuestas y solicitar que sus manifestaciones relevantes queden asentadas en el acta correspondiente.

  La Presidencia de la sesión procurará que las deliberaciones se desarrollen de manera ordenada, respetuosa y alineada con los principios establecidos en el Protocolo Familiar. La Presidencia podrá ordenar recesos cuando la naturaleza de los asuntos sometidos a consideración así lo requiera.

  // Línea 101: CAPÍTULO V - DE LAS VOTACIONES Y ACUERDOS
  #regulation-chapter("CAPÍTULO V", "DE LAS VOTACIONES Y ACUERDOS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 106: Artículo 7. De las Votaciones
  #regulation-article("Artículo 7.", "De las Votaciones", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Los acuerdos se adoptarán por mayoría simple de los votos presentes, salvo que el Protocolo Familiar o el presente Reglamento establezcan una mayoría distinta.

  Requerirán el voto favorable de al menos las tres cuartas partes (75%) de las personas con derecho a voto presentes en la sesión:

  #regulation-fraction("I.", [Las reformas al Protocolo Familiar;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [La incorporación de integrantes de la familia política al sistema familiar–empresarial;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [La modificación de la estructura de los órganos de gobierno familiar, y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Cualquier supuestos expresamente señalado en el Protocolo Familiar.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  Tratándose de materias reservadas, serán aplicables exclusivamente las reglas de aprobación previstas en el Capítulo 2 del Protocolo Familiar, incluyendo la concurrencia simultánea de la mayoría calificada de capital familiar y de la mayoría por ramas familiares activas, según corresponda.

  Las votaciones podrán realizarse de manera económica, nominal o por cualquier otro mecanismo que determine la propia Asamblea.

  // Línea 121: CAPÍTULO VI - DE LAS FACULTADES
  #regulation-chapter("CAPÍTULO VI", "DE LAS FACULTADES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 126: Artículo 8. De las Facultades
  #regulation-article("Artículo 8.", "De las Facultades", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Corresponde a la Asamblea de Familia conocer, deliberar y resolver los asuntos que el Protocolo Familiar reserve expresamente a su competencia.

  Asimismo, podrá emitir directrices, recomendaciones y acuerdos orientados al fortalecimiento de la unidad familiar, la continuidad generacional, la preservación del patrimonio familiar y el adecuado funcionamiento del sistema de gobierno familiar.

  // Línea 133: CAPÍTULO VII - DE LAS ACTAS Y SEGUIMIENTO DE ACUERDOS
  #regulation-chapter("CAPÍTULO VII", "DE LAS ACTAS Y SEGUIMIENTO DE ACUERDOS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 138: Artículo 9. De las Actas y Seguimiento
  #regulation-article("Artículo 9.", "De las Actas y Seguimiento", variant: variant, above_spacing: article_above, below_spacing: article_below)

  De toda sesión deberá levantarse un acta que contenga, al menos:

  #regulation-fraction("I.", [Fecha, hora y lugar de celebración;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Lista de asistencia;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Verificación de quórum;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Orden del Día;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("V.", [Síntesis de las deliberaciones y, en su caso, de las posiciones relevantes expresamente solicitadas para constancia;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VI.", [Acuerdos adoptados; y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VII.", [Resultado de las votaciones correspondientes.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  Las actas deberán ser firmadas por quien haya presidido la sesión y por el Secretario designado para la misma.

  El Secretario llevará un registro de acuerdos en el que se identifiquen las acciones pendientes, responsables designados y fechas de cumplimiento, informando periódicamente a la Asamblea sobre su avance.

  // Línea 154: CAPÍTULO VIII - DE LAS SESIONES VIRTUALES
  #regulation-chapter("CAPÍTULO VIII", "DE LAS SESIONES VIRTUALES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 159: Artículo 10. De las Modalidades de Celebración
  #regulation-article("Artículo 10.", "De las Modalidades de Celebración", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Las sesiones de la Asamblea de Familia podrán celebrarse de manera presencial, virtual o híbrida, según se determine en la convocatoria correspondiente. Las sesiones celebradas mediante medios tecnológicos producirán los mismos efectos y tendrán la misma validez que aquellas celebradas de manera presencial.

  // Línea 164: Artículo 11. De la Identificación de los Participantes
  #regulation-article("Artículo 11.", "De la Identificación de los Participantes", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Corresponderá a quien presida la sesión verificar la identidad de las personas que participen mediante medios tecnológicos. Ninguna persona podrá intervenir o emitir su voto sin que previamente se haya verificado su identidad.

  Las personas que participen mediante medios tecnológicos se considerarán presentes para efectos de quórum, deliberación y votación. Su participación y sentido del voto producirán los mismos efectos que los de las personas asistentes de manera presencial.

  // Línea 171: Artículo 12. De la Constancia de la Sesión
  #regulation-article("Artículo 12.", "De la Constancia de la Sesión", variant: variant, above_spacing: article_above, below_spacing: article_below)

  En el acta correspondiente deberá dejarse constancia de la modalidad de celebración de la sesión, de las personas que participaron mediante medios tecnológicos y de cualquier incidencia relevante que hubiere afectado el desarrollo de la reunión.


  // Línea 175: TRANSITORIO ÚNICO
  #regulation-transitory(title: "TRANSITORIO ÚNICO", variant: variant, below_spacing: transitory_below)

  El presente Reglamento entrará en vigor en la misma fecha en que sea aprobado por la Asamblea de Familia y permanecerá vigente hasta en tanto no sea modificado o sustituido conforme a las disposiciones aplicables del Protocolo Familiar.

]

#let render-reglamento-consejo(
  variant: "A8",
  article_above: 12.72949pt,
  article_below: 12.00pt,
  chapter_above: 18.00pt,
  chapter_below: 12.73pt,
  transitory_below: 12.00pt,
  list_intra_leading: 5.00pt,
  list_inter_below: 7.50pt,
  list_last_below: 14.00pt,
  list_justify: false
) = [
  // Línea 14: CAPÍTULO I - DE LAS DISPOSICIONES GENERALES
  #regulation-chapter("CAPÍTULO I", "DE LAS DISPOSICIONES GENERALES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 19: Artículo 1. Del Objeto y Alcance
  #regulation-article("Artículo 1.", "Del Objeto y Alcance", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El presente Reglamento establece las reglas de integración, organización, funcionamiento, facultades y operación del Consejo de Familia previsto en el Protocolo Familiar. El Consejo de Familia ejercerá sus atribuciones de conformidad con el Protocolo Familiar, el presente Reglamento y los acuerdos válidamente adoptados por la Asamblea de Familia.

  // Línea 24: Artículo 2. De la Prevalencia del Protocolo Familiar
  #regulation-article("Artículo 2.", "De la Prevalencia del Protocolo Familiar", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El presente Reglamento constituye un instrumento de desarrollo y ejecución del Protocolo Familiar, por lo que deberá interpretarse y aplicarse de manera consistente con sus principios, disposiciones y objetivos.

  En caso de discrepancia, contradicción, incompatibilidad o duda interpretativa entre lo previsto en este Reglamento y el Protocolo Familiar, prevalecerá en todo momento lo dispuesto en este último. En consecuencia, ninguna disposición, interpretación o aplicación del presente Reglamento podrá contravenir, modificar, restringir o ampliar los derechos, principios, reglas de control, mecanismos de gobernanza o materias reservadas previstos en el Protocolo Familiar.

  // Línea 31: CAPÍTULO II - DE LA INTEGRACIÓN Y DESIGNACIÓN
  #regulation-chapter("CAPÍTULO II", "DE LA INTEGRACIÓN Y DESIGNACIÓN", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 36: Artículo 3. De la Integración
  #regulation-article("Artículo 3.", "De la Integración", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El Consejo de Familia se integrará por cinco miembros designados por la Asamblea de Familia, quienes desempeñarán los cargos de:

  #regulation-fraction("I.", [Presidente;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Secretario; y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Tres Vocales.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  Los integrantes del Consejo de Familia deberán ser miembros de la familia empresaria reconocidos conforme al Protocolo Familiar.

  Los integrantes de la familia política incorporados al sistema familiar–empresarial podrán ser designados como miembros del Consejo de Familia cuando así lo acuerde expresamente la Asamblea de Familia conforme a las reglas de votación aplicables.

  El Consejo de Familia deberá mantenerse integrado por cinco miembros durante toda la vigencia de los nombramientos correspondientes.

  // Línea 50: Artículo 4. De la Designación
  #regulation-article("Artículo 4.", "De la Designación", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Los integrantes del Consejo de Familia serán designados por la Asamblea de Familia por un periodo de tres años y podrán ser reelectos. La Asamblea de Familia podrá remover a cualquiera de los integrantes del Consejo mediante acuerdo adoptado conforme a las reglas de votación aplicables.

  Únicamente podrán ser designadas para integrar el Consejo de Familia aquellas personas que cumplan los requisitos de elegibilidad, profesionalización, experiencia y demás condiciones previstas en el Protocolo Familiar para el acceso a dicho órgano.

  // Línea 57: CAPÍTULO III - DE LAS SESIONES Y CONVOCATORIAS
  #regulation-chapter("CAPÍTULO III", "DE LAS SESIONES Y CONVOCATORIAS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 62: Artículo 5. De las Sesiones
  #regulation-article("Artículo 5.", "De las Sesiones", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El Consejo de Familia deberá celebrar por lo menos una sesión ordinaria cada año. Asimismo, podrá celebrar sesiones extraordinarias cuando la naturaleza, urgencia o importancia de los asuntos sometidos a su consideración así lo requiera.

  Las convocatorias deberán realizarse por cualquier medio que permita dejar constancia de su recepción y deberán contener, al menos:

  #regulation-fraction("I.", [Fecha y hora de la sesión;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Lugar de celebración o medio de conexión correspondiente;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Orden del Día; y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Información o documentación relevante para el análisis de los asuntos a tratar.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  Salvo causa justificada, las convocatorias deberán realizarse con al menos tres días naturales de anticipación.

  El Presidente deberá procurar que durante el primer trimestre de cada ejercicio se apruebe un calendario anual de sesiones ordinarias.

  Todo integrante del Consejo deberá informar oportunamente cualquier situación que pueda representar un conflicto de interés respecto de los asuntos sometidos a consideración del órgano.

  // Línea 79: CAPÍTULO IV - DEL QUÓRUM Y VOTACIONES
  #regulation-chapter("CAPÍTULO IV", "DEL QUÓRUM Y VOTACIONES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 84: Artículo 6. De la Instalación
  #regulation-article("Artículo 6.", "De la Instalación", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El Consejo de Familia sesionará válidamente cuando se encuentren presentes al menos tres de sus integrantes, entre los cuales deberá encontrarse el Presidente o quien éste designe de los mismos miembros del Consejo para que lo sustituya.

  // Línea 89: Artículo 7. De las Votaciones
  #regulation-article("Artículo 7.", "De las Votaciones", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Las reglas de votación previstas en el presente artículo se aplicarán sin perjuicio de aquellos asuntos para los cuales el Protocolo Familiar establezca requisitos, procedimientos o mayorías especiales de aprobación. En tales casos, deberán observarse estrictamente las disposiciones contenidas en dicho Protocolo.

  Los acuerdos se adoptarán por mayoría simple de los votos presentes. Las votaciones podrán realizarse de manera económica, nominal o mediante cualquier otro mecanismo que determine el propio Consejo.

  // Línea 96: CAPÍTULO V - DE LAS FACULTADES
  #regulation-chapter("CAPÍTULO V", "DE LAS FACULTADES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 101: Artículo 8. De las Facultades
  #regulation-article("Artículo 8.", "De las Facultades", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Serán atribuciones del Consejo de Familia, además de las señaladas en el Protocolo Familiar, las siguientes:

  #regulation-fraction("I.", [Vigilar y dar seguimiento al cumplimiento del Protocolo Familiar;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Ejecutar y dar seguimiento a los acuerdos adoptados por la Asamblea de Familia;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Preparar y presentar a la Asamblea de Familia los asuntos que deban ser sometidos a su consideración;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Promover la integración, comunicación, formación y desarrollo de los miembros de la familia empresaria;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("V.", [Dar seguimiento a los procesos de sucesión y continuidad generacional previstos en el Protocolo Familiar;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VI.", [Coordinar la interacción institucional entre los órganos de gobierno familiar para efectos de comunicación, seguimiento de acuerdos y adecuada articulación de sus funciones, sin intervenir en las facultades exclusivas de cada órgano ni en la gestión operativa, técnica o administrativa de la Empresa;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VII.", [Remitir al Comité de Honor Familiar aquellos asuntos que, por su naturaleza, deban ser conocidos por dicho órgano, y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VIII.", [Ejecutar y dar seguimiento a las determinaciones emitidas por el Comité de Honor Familiar cuando así lo disponga el Protocolo Familiar, sin que ello implique facultades para modificar, revisar o sustituir las resoluciones adoptadas por dicho órgano.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  // Línea 114: CAPÍTULO VI - DE LAS ACTAS Y REGISTRO DE ACUERDOS
  #regulation-chapter("CAPÍTULO VI", "DE LAS ACTAS Y REGISTRO DE ACUERDOS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 119: Artículo 9. De las Actas y Seguimiento
  #regulation-article("Artículo 9.", "De las Actas y Seguimiento", variant: variant, above_spacing: article_above, below_spacing: article_below)

  De toda sesión deberá levantarse un acta que contenga, al menos:

  #regulation-fraction("I.", [Fecha, hora y lugar de celebración;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Lista de asistencia;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Verificación de quórum;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Orden del Día;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("V.", [Síntesis de las deliberaciones;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VI.", [Acuerdos adoptados; y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VII.", [Resultado de las votaciones correspondientes.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  Las actas deberán ser firmadas por el Presidente y el Secretario del Consejo de Familia. El Secretario deberá mantener actualizado el Libro de Actas y el Registro de Acuerdos del Consejo de Familia.

  Asimismo, deberá identificar a los responsables de ejecución, los plazos de cumplimiento y el estado de avance de cada acuerdo adoptado.

  // Línea 135: CAPÍTULO VII - DE LAS VACANTES Y SUSTITUCIONES
  #regulation-chapter("CAPÍTULO VII", "DE LAS VACANTES Y SUSTITUCIONES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 140: Artículo 10. De las Vacantes
  #regulation-article("Artículo 10.", "De las Vacantes", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Toda vacante que se genere por renuncia, fallecimiento, remoción o cualquier otra causa deberá ser cubierta por la Asamblea de Familia en un plazo no mayor de quince días naturales contados a partir de la fecha en la que se produzca.

  La persona designada para ocupar una vacante concluirá únicamente el periodo pendiente correspondiente al integrante sustituido.

  // Línea 147: CAPÍTULO VIII - DE LAS MODALIDADES DE SESIONES
  #regulation-chapter("CAPÍTULO VIII", "DE LAS MODALIDADES DE SESIONES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 152: Artículo 11. De las Modalidades de Celebración
  #regulation-article("Artículo 11.", "De las Modalidades de Celebración", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Las sesiones del Consejo de Familia podrán celebrarse de manera presencial, virtual o híbrida. Las sesiones celebradas mediante medios tecnológicos producirán los mismos efectos que aquellas realizadas de manera presencial, siempre que exista posibilidad razonable de identificación, participación e interacción de los asistentes.

  // Línea 157: CAPÍTULO IX - DE LA INTERPRETACIÓN Y CASOS NO PREVISTOS
  #regulation-chapter("CAPÍTULO IX", "DE LA INTERPRETACIÓN Y CASOS NO PREVISTOS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 162: Artículo 12. De los Casos No Previstos
  #regulation-article("Artículo 12.", "De los Casos No Previstos", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Cualquier situación de carácter procedimental no prevista expresamente en el presente Reglamento podrá ser resuelta por el Consejo de Familia, siempre que dicha determinación resulte consistente con el Protocolo Familiar y no implique la modificación, interpretación extensiva o afectación de derechos, principios de control, reglas de gobernanza o materias reservadas previstas en dicho instrumento.

  No obstante lo anterior, cuando la situación de que se trate corresponda a materias reservadas a la Asamblea de Familia conforme al Protocolo Familiar o implique la modificación, interpretación o afectación de derechos cuya resolución corresponda a dicho órgano, el asunto deberá ser sometido a la consideración de la Asamblea de Familia para su determinación.


  // Línea 168: TRANSITORIO ÚNICO
  #regulation-transitory(title: "TRANSITORIO ÚNICO", variant: variant, below_spacing: transitory_below)

  El presente Reglamento entrará en vigor en la misma fecha en que sea aprobado por la Asamblea de Familia y permanecerá vigente hasta en tanto no sea modificado o sustituido conforme a las disposiciones aplicables del Protocolo Familiar.

]

#let render-reglamento-comite(
  variant: "A8",
  article_above: 12.72949pt,
  article_below: 12.00pt,
  chapter_above: 18.00pt,
  chapter_below: 12.73pt,
  transitory_below: 12.00pt,
  list_intra_leading: 5.00pt,
  list_inter_below: 7.50pt,
  list_last_below: 14.00pt,
  list_justify: false
) = [
  // Línea 14: CAPÍTULO I - DE LAS DISPOSICIONES GENERALES
  #regulation-chapter("CAPÍTULO I", "DE LAS DISPOSICIONES GENERALES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 19: Artículo 1. Del Objeto y Alcance
  #regulation-article("Artículo 1.", "Del Objeto y Alcance", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El presente Reglamento establece las reglas de integración, organización, funcionamiento y operación del Comité de Honor Familiar previsto en el Protocolo Familiar.

  El Comité de Honor Familiar ejercerá sus atribuciones de conformidad con las disposiciones contenidas en el Protocolo Familiar, el presente Reglamento y los acuerdos válidamente adoptados por la Asamblea de Familia.

  // Línea 26: Artículo 2. De la Prevalencia del Protocolo Familiar
  #regulation-article("Artículo 2.", "De la Prevalencia del Protocolo Familiar", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El presente Reglamento constituye un instrumento de desarrollo y ejecución del Protocolo Familiar, por lo que deberá interpretarse y aplicarse de manera consistente con sus principios, disposiciones y objetivos.

  En caso de discrepancia, contradicción, incompatibilidad o duda interpretativa entre lo previsto en este Reglamento y el Protocolo Familiar, prevalecerá en todo momento lo dispuesto en este último. En consecuencia, ninguna disposición, interpretación o aplicación del presente Reglamento podrá contravenir, modificar, restringir o ampliar los derechos, principios, reglas de control, mecanismos de gobernanza o materias reservadas previstos en el Protocolo Familiar.

  // Línea 33: CAPÍTULO II - DE LA INTEGRACIÓN Y DESIGNACIÓN
  #regulation-chapter("CAPÍTULO II", "DE LA INTEGRACIÓN Y DESIGNACIÓN", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 38: Artículo 3. De la Integración
  #regulation-article("Artículo 3.", "De la Integración", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El Comité de Honor Familiar es un órgano de carácter excepcional y no permanente, que se constituirá únicamente cuando, conforme al Protocolo Familiar, exista un asunto que deba ser sometido a su conocimiento y resolución.

  Para cada asunto que requiera su intervención, la Asamblea de Familia designará a tres integrantes que reunirán las condiciones de independencia, imparcialidad y elegibilidad previstas en el Protocolo Familiar.

  Una vez integrado, los miembros del Comité designarán de entre ellos a quien fungirá como Presidente y a quien desempeñará las funciones de Secretario durante la sustanciación y resolución del asunto correspondiente. Emitida la resolución definitiva y concluidas las actuaciones necesarias para su formalización, el Comité de Honor Familiar se tendrá por disuelto.

  En la integración del Comité de Honor Familiar, la Asamblea de Familia procurará de manera preferente la participación del señor Roberto Ledesma Cruz y del señor Justo Félix Fernández Chedraui, en atención a su trayectoria, calidad moral, independencia y reconocimiento dentro del sistema familiar–empresarial. La participación de dichas personas tendrá carácter preferente más no obligatorio, por lo que, en caso de impedimento, imposibilidad, excusa o negativa de cualquiera de ellas, la Asamblea podrá designar a cualquier otra persona que reúna los requisitos previstos en el Protocolo Familiar.

  // Línea 49: Artículo 4. De la Designación, Duración y Remoción
  #regulation-article("Artículo 4.", "De la Designación, Duración y Remoción", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Los integrantes del Comité de Honor Familiar serán designados por la Asamblea de Familia para conocer y resolver el asunto específico que motive su integración.

  Cuando alguno de los integrantes se encuentre impedido, tenga un conflicto de interés o no pueda continuar participando en el procedimiento correspondiente, la Asamblea de Familia designará a la persona que habrá de sustituirlo exclusivamente para la atención de dicho asunto.

  // Línea 56: CAPÍTULO III - DE LAS SESIONES Y CONVOCATORIAS
  #regulation-chapter("CAPÍTULO III", "DE LAS SESIONES Y CONVOCATORIAS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 61: Artículo 5. De las Sesiones y Convocatorias
  #regulation-article("Artículo 5.", "De las Sesiones y Convocatorias", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El Comité de Honor Familiar sesionará cuando existan asuntos de su competencia que deban ser atendidos conforme al Protocolo Familiar.

  Las convocatorias deberán realizarse por cualquier medio que permita dejar constancia de su recepción y deberán contener, al menos:

  #regulation-fraction("I.", [Fecha y hora de la sesión;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Lugar de celebración o medio de conexión correspondiente;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Asunto o asuntos a tratar; y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Información o documentación relevante para el análisis de los asuntos correspondientes.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  Salvo causa justificada, las convocatorias deberán realizarse con al menos tres días naturales de anticipación.

  // Línea 74: CAPÍTULO IV - DEL QUÓRUM Y LAS VOTACIONES
  #regulation-chapter("CAPÍTULO IV", "DEL QUÓRUM Y LAS VOTACIONES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 79: Artículo 6. De la Instalación del Comité
  #regulation-article("Artículo 6.", "De la Instalación del Comité", variant: variant, above_spacing: article_above, below_spacing: article_below)

  El Comité de Honor Familiar se considerará válidamente instalado cuando se encuentren presentes la totalidad de sus integrantes designados para conocer y resolver el asunto correspondiente.

  // Línea 84: Artículo 7. De la Adopción de Acuerdos
  #regulation-article("Artículo 7.", "De la Adopción de Acuerdos", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Los acuerdos, determinaciones y resoluciones del Comité de Honor Familiar se adoptarán por mayoría simple de votos, salvo que el Protocolo Familiar establezca expresamente un requisito distinto para el asunto de que se trate.

  Las votaciones podrán realizarse de manera económica, nominal o mediante cualquier otro mecanismo que determine el propio Comité, debiendo dejarse constancia de su resultado en el acta correspondiente.

  // Línea 91: CAPÍTULO V - DE LAS ATRIBUCIONES
  #regulation-chapter("CAPÍTULO V", "DE LAS ATRIBUCIONES", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 96: Artículo 8. De las Atribuciones
  #regulation-article("Artículo 8.", "De las Atribuciones", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Serán atribuciones del Comité de Honor Familiar, además de las señaladas en el Protocolo Familiar, las siguientes:

  #regulation-fraction("I.", [Conocer los asuntos que le sean sometidos conforme a las disposiciones del Protocolo Familiar;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Promover mecanismos de diálogo, conciliación y entendimiento entre los integrantes de la familia empresaria cuando ello resulte procedente;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Emitir las recomendaciones, opiniones, determinaciones y resoluciones que correspondan conforme al Protocolo Familiar, incluyendo aquellas que resulten necesarias para la aplicación del régimen disciplinario, sancionador o de exclusión previsto en dicho instrumento;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Dar seguimiento al cumplimiento de las medidas, acuerdos o determinaciones adoptadas conforme al Protocolo Familiar;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("V.", [Informar a la Asamblea de Familia o al Consejo de Familia sobre aquellos asuntos que deban ser de su conocimiento;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VI.", [Ejercer las demás atribuciones que le confieran el Protocolo Familiar y los acuerdos válidamente adoptados por los órganos de gobierno familiar;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VII.", [Interpretar las disposiciones del Protocolo Familiar dentro del ámbito de su competencia y para efectos de la atención de los asuntos sometidos a su conocimiento, y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VIII.", [Resolver los procedimientos cuya competencia le atribuya expresamente el Protocolo Familiar, incluyendo aquellos relacionados con la exclusión de integrantes del sistema familiar–empresarial, sin perjuicio de las facultades de ejecución que correspondan al Consejo de Familia conforme al propio Protocolo.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  // Línea 109: CAPÍTULO VI - DE LOS CONFLICTOS DE INTERÉS
  #regulation-chapter("CAPÍTULO VI", "DE LOS CONFLICTOS DE INTERÉS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 114: Artículo 9. De los Conflictos de Interés
  #regulation-article("Artículo 9.", "De los Conflictos de Interés", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Ningún integrante del Comité de Honor Familiar podrá participar en la atención, análisis, deliberación o resolución de asuntos respecto de los cuales tenga interés personal, familiar, económico o cualquier otra circunstancia que pueda comprometer o razonablemente generar dudas sobre su independencia, objetividad o imparcialidad.

  Cuando un integrante identifique la existencia de un conflicto de interés, deberá comunicarlo de inmediato y abstenerse de intervenir en cualquier etapa del asunto correspondiente.

  En tal supuesto, la Asamblea de Familia designará a la persona que habrá de sustituirlo exclusivamente para la atención y resolución del asunto de que se trate. Hasta en tanto se realice dicha designación, el procedimiento correspondiente quedará suspendido.

  // Línea 123: CAPÍTULO VII - DE LAS ACTAS Y DEL REGISTRO CONFIDENCIAL DE ASUNTOS
  #regulation-chapter("CAPÍTULO VII", "DE LAS ACTAS Y DEL REGISTRO CONFIDENCIAL DE ASUNTOS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 128: Artículo 10. De las Actas y del Registro
  #regulation-article("Artículo 10.", "De las Actas y del Registro", variant: variant, above_spacing: article_above, below_spacing: article_below)

  De toda sesión deberá levantarse un acta que contenga, al menos:

  #regulation-fraction("I.", [Fecha, hora y lugar de celebración;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("II.", [Lista de asistencia;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("III.", [Verificación de quórum;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("IV.", [Asuntos tratados;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("V.", [Síntesis de las deliberaciones;], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VI.", [Acuerdos, recomendaciones o determinaciones adoptadas; y], variant: variant, is_last: false, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if false and list_last_below != auto { list_last_below } else if not false and list_inter_below != auto { list_inter_below } else { auto })
  #regulation-fraction("VII.", [Resultado de las votaciones correspondientes.], variant: variant, is_last: true, justify: list_justify, intra_leading: list_intra_leading, below_spacing: if true and list_last_below != auto { list_last_below } else if not true and list_inter_below != auto { list_inter_below } else { auto })
  Las actas deberán ser firmadas por el Presidente y el Secretario del Comité. El Secretario deberá mantener actualizado el Libro de Actas y el Registro Confidencial de Asuntos del Comité de Honor Familiar.

  // Línea 142: CAPÍTULO VIII - DE LA CONFIDENCIALIDAD
  #regulation-chapter("CAPÍTULO VIII", "DE LA CONFIDENCIALIDAD", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 147: Artículo 11. De la Confidencialidad
  #regulation-article("Artículo 11.", "De la Confidencialidad", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Los integrantes del Comité de Honor Familiar deberán guardar estricta confidencialidad respecto de la información, documentación, deliberaciones y asuntos sometidos a su conocimiento, salvo autorización expresa de la Asamblea de Familia o disposición contenida en el Protocolo Familiar.

  La obligación de confidencialidad subsistirá aun después de haber concluido el cargo correspondiente.

  // Línea 154: CAPÍTULO IX - DE LOS CASOS NO PREVISTOS
  #regulation-chapter("CAPÍTULO IX", "DE LOS CASOS NO PREVISTOS", variant: variant, above_spacing: chapter_above, below_spacing: chapter_below)

  // Línea 159: Artículo 12. De los Casos No Previstos
  #regulation-article("Artículo 12.", "De los Casos No Previstos", variant: variant, above_spacing: article_above, below_spacing: article_below)

  Cualquier situación de carácter procedimental no prevista expresamente en el presente Reglamento podrá ser resuelta por el Comité de Honor Familiar, siempre que dicha determinación resulte consistente con el Protocolo Familiar y no implique la modificación, interpretación extensiva o afectación de derechos, principios rectores, reglas de control, mecanismos de gobernanza o materias reservadas previstas en dicho instrumento.

  En caso de duda interpretativa, contradicción normativa o afectación potencial a los principios fundamentales del sistema familiar–empresarial, prevalecerá lo dispuesto en el Protocolo Familiar y el asunto deberá ser sometido a la consideración de la Asamblea de Familia para su determinación.


  // Línea 165: TRANSITORIO ÚNICO
  #regulation-transitory(title: "TRANSITORIO ÚNICO", variant: variant, below_spacing: transitory_below)

  El presente Reglamento entrará en vigor en la misma fecha en que sea aprobado por la Asamblea de Familia y permanecerá vigente hasta en tanto no sea modificado o sustituido conforme a las disposiciones aplicables del Protocolo Familiar.

]

