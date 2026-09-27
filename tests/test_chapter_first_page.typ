// ==============================================================================
// TEST CHAPTER FIRST PAGE — FASE 3.6.3: REFINAMIENTO EDITORIAL
// ==============================================================================
// Documento de prueba aislado que reproduce la primera página interior de capítulo
// a tamaño maestro 396 × 612 pt (Media Carta / 5.5 × 8.5 in).
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#chapter-first-page(
  cfg,
  number: "01",
  title: [
    DECLARACIÓN DE \
    PRINCIPIOS FAMILIARES Y \
    VISIÓN INTERGENERACIONAL
  ],
  is_recto: true,
  page_num: 8,
  arcs_opacity: 50%,
)[
  #interior-heading("MISIÓN Y PROPÓSITO FAMILIAR EMPRESARIAL")

  La familia empresaria reconoce a la empresa como un proyecto común de carácter patrimonial y estratégico, cuya finalidad principal es generar valor sostenible y asegurar su continuidad en el tiempo.

  En este sentido, los intereses individuales quedan subordinados al interés colectivo, privilegiando en todo momento la estabilidad institucional, la permanencia del proyecto y la conservación del control en el ámbito familiar.

  #interior-heading("VISIÓN INTERGENERACIONAL Y PROYECTO DE LARGO PLAZO", space_before: 18.3483pt)

  La propiedad y conducción de la empresa se conciben como un legado que debe transmitirse de manera ordenada entre generaciones. Cada generación asume la responsabilidad de preparar a la siguiente, no solo en la transferencia del patrimonio, sino en la formación de criterios, capacidades y valores necesarios para su adecuada gestión y preservación.
]
