// ==============================================================================
// DOCUMENTO DE PRUEBA EDITORIAL: EDITORIAL SHOWCASE
// Proyecto: Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
// ==============================================================================
// Documento de validación técnica independiente para la FASE 3.1.
// Utiliza LOS MISMOS componentes (/templates/typst/componentes.typ) y la
// MISMA configuración central (/config/editorial_config.yaml) del documento final.
// ==============================================================================

#import "/templates/typst/componentes.typ": *

#let cfg = yaml("/config/editorial_config.yaml")

#show: doc => setup-protocolo(cfg, doc)

// ------------------------------------------------------------------------------
// 1. PORTADA GENERAL
// ------------------------------------------------------------------------------
#cover-page(cfg)

// ------------------------------------------------------------------------------
// 2. ÍNDICE GENERAL (Muestra técnica de navegación y folios)
// ------------------------------------------------------------------------------
#table-of-contents(cfg)

// ------------------------------------------------------------------------------
// 3. APERTURA DE CAPÍTULO (RECTO / PÁGINA IMPAR GARANTIZADA)
// ------------------------------------------------------------------------------
#chapter-opening(
  "Capítulo 1. Declaración de Principios y Marco de Convivencia Familiar–Empresarial",
  label: "CAPÍTULO 1",
  subtitle: "Fundamentos, Misión Compartida y Compromiso Institucional",
  cfg: cfg
)

// ------------------------------------------------------------------------------
// 4. PRIMERA PÁGINA DE CONTENIDO DE CAPÍTULO (Sin running header, folio al exterior)
// ------------------------------------------------------------------------------
#section-heading("1.1 Principios Fundamentales del Sistema Familiar–Empresarial")

#body-text[
El presente Protocolo Familiar rige las relaciones entre los integrantes de la #strong[Familia Velasco Chedraui] y la empresa #strong[Poliductos Flexibles, S.A. de C.V. (POLIFLEX)], teniendo como finalidad primordial asegurar la continuidad institucional, la armonía en la convivencia intergeneracional y el crecimiento sostenible del patrimonio común.
]

#body-text[
El Protocolo constituye un marco de autorregulación vinculante, fundamentado en el principio de que los intereses legítimos de la empresa, como fuente de bienestar colectivo, deben salvaguardarse frente a contingencias particulares o aspiraciones individuales no alineadas con la visión estratégica familiar. La condición de miembro de la familia no confiere por sí misma derechos ejecutivos ni preeminencias dentro de la estructura corporativa, debiendo prevalecer en todo momento el principio del mérito, la preparación técnica y la vocación de servicio.
]

#subsection-heading("1.1.1 Valores Rectores y Compromiso Ético")

#body-text[
Los integrantes de la familia asumen el compromiso expreso de regir su conducta bajo los valores de rectitud, lealtad institucional, transparencia y respeto mutuo. La preservación de la confianza intergeneracional es un deber permanente que condiciona la participación en cualquiera de los órganos de gobierno familiar o societario.
]

#subsubsection-heading("Regla de Primacía Institucional")

#body-text[
Toda decisión de trascendencia patrimonial, corporativa o de sucesión deberá subordinarse al principio de preservación del valor económico y social de la empresa, evitando cualquier conducta susceptible de debilitar su posición de mercado o comprometer su liquidez financiera.
]

// ------------------------------------------------------------------------------
// 5 & 6. PÁGINAS INTERIORES ENFRENTADAS (VERSO PAR / RECTO IMPAR)
// Y MUESTRA COMPLETA DE LISTAS JURÍDICAS ESTRUCTURADAS
// ------------------------------------------------------------------------------
#section-heading("1.2 Metodología de Valuación y Reglas de Transmisión (Muestra de Listas)")

#body-text[
Para efectos de la presente cláusula, la valuación del capital social y la determinación de las transferencias patrimoniales se sujetará a las siguientes reglas objetivas:
]

// LISTA JURÍDICA a), b), c) — Incisos alfabéticos de primer nivel
#legal-item("a)", [
  #strong[Horizonte de proyección:] El EBITDA se proyectará por un periodo de seis ejercicios fiscales completos y consecutivos posteriores a la fecha de valuación, tomando como base la información financiera histórica disponible y las condiciones reales del negocio. Las proyecciones deberán sustentarse en criterios razonables, consistentes y verificables, quedando prohibida la incorporación de supuestos discrecionales, escenarios extraordinarios o expectativas no sustentadas.
], kind: "alpha")

#legal-item("b)", [
  #strong[Determinación del EBITDA:] El EBITDA deberá reflejar la operación real del negocio y será ajustado por el valuador conforme a criterios financieros generalmente aceptados, debiendo en todo caso cumplir con las directrices específicas que se detallan a continuación:
], kind: "alpha")

// LISTA JURÍDICA i., ii., iii. — Sub-incisos romanos minúsculos con sangría jurídica
#legal-item("i.", [Excluir ingresos o gastos extraordinarios, no recurrentes o ajenos a la operación normal;], kind: "roman-lower")
#legal-item("ii.", [Ajustar operaciones entre partes relacionadas a estricto valor de mercado;], kind: "roman-lower")
#legal-item("iii.", [Eliminar efectos contables compensatorios que no representen flujo económico real; y], kind: "roman-lower")
#legal-item("iv.", [Considerar únicamente conceptos recurrentes y propios de la actividad ordinaria de la Sociedad.], kind: "roman-lower")

#legal-item("c)", [
  #strong[Determinación del valor de la empresa:] El valor de la empresa se determinará con base en el EBITDA proyectado, aplicando un múltiplo razonable consistente con el sector, tamaño, perfil de riesgo y condiciones de mercado en que opere la Sociedad.
], kind: "alpha")

#legal-item("d)", [
  #strong[Determinación del valor del capital accionario:] Al valor de la empresa deberán realizarse los ajustes necesarios para determinar el valor del capital accionario, incluyendo la deducción de la deuda financiera neta y la adición de efectivo no operativo.
], kind: "alpha")

// LISTA JURÍDICA I., II., III. — Fracciones en números romanos mayúsculos
#subsection-heading("1.2.1 Materias de Aprobación Calificada (Muestra de Fracciones)")

#body-text[
De conformidad con los acuerdos de gobernanza, requerirán el voto favorable de al menos las tres cuartas partes (75%) de los votos presentes en la sesión:
]

#legal-item("I.", [#strong[Las reformas al Protocolo Familiar y a sus anexos reglamentarios;]], kind: "roman-upper")
#legal-item("II.", [#strong[La incorporación de integrantes de la familia política al sistema familiar–empresarial;]], kind: "roman-upper")
#legal-item("III.", [#strong[La modificación sustantiva de la estructura de los órganos de gobierno familiar, y]], kind: "roman-upper")
#legal-item("IV.", [#strong[Cualquier supuesto expresamente calificado como materia reservada en el Capítulo 2.]], kind: "roman-upper")

// LISTA JURÍDICA 1., 2., 3. — Pasos procedimentales decimales
#subsection-heading("1.2.2 Procedimiento de Desahogo de Sesiones (Muestra Decimal)")

#body-text[
El desahogo formal de las sesiones de los comités se desarrollará conforme a las etapas sucesivas siguientes:
]

#legal-item("1.", [Análisis del expediente y verificación de antecedentes documentales aportados;], kind: "decimal")
#legal-item("2.", [Valoración probatoria de los hechos y desahogo de testimonios de las partes;], kind: "decimal")
#legal-item("3.", [Deliberación reservada de los integrantes con derecho a voto; y], kind: "decimal")
#legal-item("4.", [Emisión de la determinación institucional vinculante debidamente fundada.], kind: "decimal")

// ------------------------------------------------------------------------------
// 13. TABLA EDITORIAL ESTILIZADA
// ------------------------------------------------------------------------------
#subsection-heading("1.2.3 Estructura Accionaria y Cuórum (Muestra de Tabla)")

#body-text[
La siguiente tabla ilustra la distribución del capital social y los porcentajes representativos aplicables a la acreditación de asistencia y ejercicio del derecho de voto:
]

#table-style(
  columns: (2.2fr, 1.8fr, 1.2fr, 1.6fr),
  caption: "Cuadro 1.1 — Representación Accionaria por Rama Familiar",
  headers: ("Accionista / Rama", "Calidad Jurídica", "Capital", "Acreditación"),
  rows: (
    (
      [Rama 1 — Don Jesús Velasco Chedraui],
      [Accionista Fundador],
      [#align(center)[40.00%]],
      [Título Accionario 001]
    ),
    (
      [Rama 2 — Descendencia Línea A],
      [Accionistas Clase "A"],
      [#align(center)[20.00%]],
      [Títulos Accionarios 002–005]
    ),
    (
      [Rama 3 — Descendencia Línea B],
      [Accionistas Clase "A"],
      [#align(center)[20.00%]],
      [Títulos Accionarios 006–009]
    ),
    (
      [Rama 4 — Descendencia Línea C],
      [Accionistas Clase "A"],
      [#align(center)[20.00%]],
      [Títulos Accionarios 010–013]
    ),
    (
      [#strong[Total Capital Social]],
      [#strong[Votante Pleno]],
      [#align(center)[#strong[100.00%]]],
      [#strong[Quórum Legal 100%]]
    )
  )
)

// ------------------------------------------------------------------------------
// 16. PÁGINA DE APERTURA DE ANEXOS / REGLAMENTOS
// ------------------------------------------------------------------------------
#annex-opening(
  "ANEXO 1",
  "Carta de Aceptación y Adhesión al Protocolo Familiar",
  subtitle: "Instrumento Jurídico de Suscripción Vinculante para Miembros de la Familia"
)

#body-text[
Por medio de la presente, el suscrito manifiesta libre y expresamente su voluntad de adherirse de manera plena e incondicional a todas y cada una de las disposiciones, obligaciones, derechos y restricciones contenidos en el #strong[Protocolo Familiar] de #strong[Poliductos Flexibles, S.A. de C.V. (POLIFLEX)], así como a sus respectivos anexos y reglamentos vigentes.
]

#body-text[
Reconozco expresamente que el Protocolo constituye una norma de convivencia y gobernanza jurídicamente exigible en el ámbito interno, y que su cumplimiento constituye condición indispensable para el ejercicio de cualquier derecho político o patrimonial en el sistema familiar–empresarial.
]

// ------------------------------------------------------------------------------
// 10. BLOQUE DE FIRMAS INDIVISIBLE (signature-block)
// Control editorial: breakable: false asegura que las firmas no se dividan entre páginas
// ------------------------------------------------------------------------------
#signature-block(
  note: "Leído que fue el presente instrumento y enteradas las partes de su fuerza obligatoria, se suscribe en la Ciudad de Coatepec, Veracruz.",
  signers: (
    (
      name: "C. Jesús Velasco Chedraui",
      role: "Presidente de la Asamblea de Familia",
      rep: "Accionista Fundador"
    ),
    (
      name: "C. Representante Rama 1",
      role: "Consejero Titular",
      rep: "Rama Familiar Velasco"
    ),
    (
      name: "C. Representante Rama 2",
      role: "Consejero Titular",
      rep: "Rama Familiar Velasco"
    ),
    (
      name: "C.P. Roberto Ledesma Cruz",
      role: "Asesor Técnico y Testigo Institucional",
      rep: "Acompañamiento Metodológico"
    )
  ),
  date-text: "Suscrito y ratificado el día 15 de agosto de 2026."
)
