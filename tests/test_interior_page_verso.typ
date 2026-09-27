// ==============================================================================
// TEST INTERIOR PAGE VERSO — FASE 3.6.3: REFINAMIENTO EDITORIAL
// ==============================================================================
// Documento de prueba aislado que reproduce la página interior vuelta (verso)
// a tamaño maestro 396 × 612 pt (Media Carta / 5.5 × 8.5 in).
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#interior-page(
  cfg,
  is_recto: false,
  page_num: 9,
  content_dy: 123.6900pt,
  chapter: 1,
  section_reset: true,
)[
  #interior-heading("VALORES COMUNES Y PRINCIPIOS RECTORES", space_before: 0pt)

  La actuación de los miembros de la familia en relación con la empresa deberá regirse por principios de integridad, lealtad, responsabilidad y respeto, así como por criterios de institucionalidad, transparencia y profesionalización.

  Son principios rectores del sistema familiar–empresarial:

  #interior-list((
    [a) Continuidad institucional: Los cargos pertenecen a la organización y no a las personas, por lo que cualquier relevo deberá garantizar estabilidad y orden.],
    [b) Formalidad en los procesos de sustitución: Toda designación deberá realizarse mediante los mecanismos previstos, quedando excluidas las intervenciones informales.],
    [c) Mérito y capacidad: El acceso a funciones de dirección o gobierno requerirá preparación, experiencia y alineación con el proyecto común.],
    [d) Preservación del control familiar: Las decisiones deberán orientarse a mantener la dirección y propiedad dentro del ámbito familiar.],
    [e) Respeto a las decisiones institucionales: Las resoluciones adoptadas por los órganos competentes deberán ser acatadas por todos los integrantes.],
  ))

  #interior-heading("VISIÓN INTERGENERACIONAL Y PROYECTO DE LARGO PLAZO", space_before: 25.50pt)

  La cohesión entre los miembros de la familia constituye un elemento esencial para la estabilidad de la empresa. En consecuencia, las diferencias deberán canalizarse a través de los mecanismos previstos en este Protocolo, evitando que los conflictos personales impacten en la operación o en la toma de decisiones.
]
