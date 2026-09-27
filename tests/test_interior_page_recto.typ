// ==============================================================================
// TEST INTERIOR PAGE RECTO — FASE 3.6.3: REFINAMIENTO EDITORIAL
// ==============================================================================
// Documento de prueba aislado que reproduce la página interior de continuación (recto / impar)
// a tamaño maestro 396 × 612 pt (Media Carta / 5.5 × 8.5 in).
// Muestra la cabecera funcional especular:
//   Lomo (izq): PROTOCOLO FAMILIAR  VERSION 1.0
//   Corte (der): CAPÍTULO 01  [ISOTIPO 50%]
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#interior-page(
  cfg,
  is_recto: true,
  page_num: 10,
  content_dy: 123.6900pt,
  chapter: 1,
  section_reset: false,
)[
  #interior-heading("LEGITIMIDAD DEL PROTOCOLO Y ADHESIÓN VOLUNTARIA", space_before: 0pt)

  El presente Protocolo adquiere fuerza vinculante para quienes lo suscriben, en la medida en que refleja la voluntad común de establecer reglas claras para la relación entre familia y empresa.

  Su cumplimiento constituye un compromiso institucional orientado a preservar la continuidad y el orden del sistema.

  #interior-heading("REVISIÓN GENERACIONAL DEL PROTOCOLO", space_before: 25.50pt)

  El presente Protocolo deberá ser objeto de revisión periódica por los órganos familiares competentes, con el fin de asegurar su vigencia, funcionalidad y alineación con la evolución de la familia y de la empresa.

  Dicha revisión permitirá incorporar ajustes derivados de cambios generacionales, nuevas estructuras patrimoniales o transformaciones en el entorno empresarial, sin alterar los principios esenciales que lo rigen.

  Las modificaciones deberán realizarse de manera ordenada, formal y conforme a los mecanismos previstos en este instrumento, garantizando en todo momento la continuidad institucional del sistema familiar–empresarial.
]
