# INFORME DE REFERENCIAS CRUZADAS Y MAPA DE DEPENDENCIAS
**FASE 4.0 — INVENTARIO Y MAPEO DE COMPONENTES**  
**Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)**  
**Fecha:** 26 de Septiembre de 2026  
**Carácter:** LECTURA, ANÁLISIS, CLASIFICACIÓN Y MAPEO (READ-ONLY)

---

## 1. MAPA DE REFERENCIAS CRUZADAS INTERDOCUMENTALES

Se identificaron **más de 260 menciones referenciales** distribuidas en los 5 módulos, articuladas en torno al Protocolo Familiar y sus órganos de gobierno:

| MÓDULO ORIGEN | REFERENCIA EXACTA / TÉRMINO | DESTINO APARENTE | ¿RESOLUBLE AUTOMÁTICAMENTE? | OBSERVACIÓN DOCUMENTAL |
|:---|:---|:---|:---:|:---|
| `00_introduccion.md` | "Estatutos Sociales" (L18) | Documento societario externo | NO | Mencionado como instrumento rector complementario. |
| `00_introduccion.md` | "órganos de gobierno" (L18) | Capítulos 03 y Reglamentos 11, 12, 13 | SÍ (Semántico) | Alusión genérica a la estructura de gobernanza. |
| `10_anexos` (Carta Adhesión) | "Protocolo Familiar" (L40, 47, 49) | Capítulos 01–09 | SÍ | Objeto central de la declaración de voluntad y sujeción. |
| `10_anexos` (Carta Adhesión) | "órganos de gobierno" (L47, 64) | Asamblea, Consejo y Comité | SÍ | Compromiso de acatamiento de resoluciones institucionales. |
| `10_anexos` (Convocatoria Asam.) | "Asamblea de Familia" (L89, 91, 96) | Capítulo 03 y Reglamento 11 | SÍ | Instrumento operativo de ejecución del órgano supremo. |
| `10_anexos` (Acta Asam.) | "Protocolo Familiar" (L120) | Capítulos 01–09 | SÍ | Fundamento estatutario de la validez de la sesión. |
| `10_anexos` (Convocatoria Cons.) | "Consejo de Familia" (L178, 182, 185) | Capítulo 03 y Reglamento 12 | SÍ | Convocatoria operativa del órgano colegiado de seguimiento. |
| `10_anexos` (Acta Consejo) | "Comité de Honor Familiar" | Capítulo 07, 08 y Reg. 13 | SÍ | Remisión eventual de conflictos éticos o disciplinarios. |
| `10_anexos` (Acta Comité) | "Consejo de Familia" (L269, 289) | Reglamento 12 | SÍ | El Consejo es el órgano remitente del expediente de honor. |
| `10_anexos` (Acta Comité) | "Roberto Ledesma Cruz" (Reg. 13 L46) | Persona física designada | NO (Nominal) | Asesor técnico y miembro preferente del Comité. |
| `11_reglamento_asamblea` | "Protocolo Familiar" (L21, 28, 30, 40) | Capítulos 01–09 | SÍ | Prevalencia normativa absoluta del Protocolo (Art. 2). |
| `11_reglamento_asamblea` | "Carta de Adhesión" (L44) | Anexo 10 (Sección 2) | SÍ | Requisito formal para la integración de familia política. |
| `11_reglamento_asamblea` | "Capítulo 2 del Protocolo" (L116) | Capítulo 02 | SÍ | **Cita cruzada explícita** a las reglas de materias reservadas. |
| `12_reglamento_consejo` | "Protocolo Familiar" (L21, 26, 28, 43) | Capítulos 01–09 | SÍ | Prevalencia normativa del Protocolo (Art. 2). |
| `12_reglamento_consejo` | "Asamblea de Familia" (L21, 38, 45, 52) | Reglamento 11 | SÍ | La Asamblea designa y remueve a los 5 miembros del Consejo. |
| `12_reglamento_consejo` | "Comité de Honor Familiar" (L111, 112) | Reglamento 13 | SÍ | El Consejo remite asuntos y ejecuta resoluciones del Comité. |
| `13_reglamento_comite` | "Protocolo Familiar" (L21, 28, 30, 40) | Capítulos 01–09 | SÍ | Prevalencia normativa del Protocolo (Art. 2). |
| `13_reglamento_comite` | "Asamblea de Familia" (L23, 42, 51, 104) | Reglamento 11 | SÍ | La Asamblea designa a los 3 integrantes específicos por caso. |
| `13_reglamento_comite` | "Consejo de Familia" (L104, 108) | Reglamento 12 | SÍ | El Consejo ejecuta las resoluciones disciplinarias del Comité. |
| `13_reglamento_comite` | "Justo Félix Fernández Chedraui" (L46) | Persona física designada | NO (Nominal) | Miembro preferente con Don Roberto Ledesma Cruz. |

---

## 2. MAPA DE DEPENDENCIAS Y RELACIÓN JERÁRQUICA

A partir de las remisiones expresas encontradas en los textos, se desprende la siguiente arquitectura de relaciones:

```text
                                  +---------------------------------------+
                                  |         00_INTRODUCCIÓN               |
                                  |  (Proemio Institucional de la Obra)   |
                                  +---------------------------------------+
                                                      |
                                                      v
                                  +---------------------------------------+
                                  |      PROTOCOLO FAMILIAR 01–09         |
                                  |    (Norma Suprema del Sistema)        |
                                  |  • Capítulo 02: Materias Reservadas   |
                                  |  • Capítulo 03: Gobierno Familiar     |
                                  |  • Capítulos 07-08: Sanciones/Conflictos
                                  +---------------------------------------+
                                           |                     |
                  +------------------------+                     +------------------------+
                  |                                                                       |
                  v                                                                       v
+-----------------------------------+                                   +-----------------------------------+
|     CUERPO REGLAMENTARIO          |                                   |       ANEXOS Y FORMATOS           |
| (Instrumentos Subordinados        |                                   | (Herramientas Operativas          |
|  de Ejecución y Desarrollo)       |                                   |  de Cumplimiento y Constancia)    |
|                                   |                                   |                                   |
| • 11: Reglamento Asamblea Familia |<=== Carta de Adhesión (Req.) =====| • 10.2: Carta de Adhesión         |
|         |           ^             |                                   | • 10.3/10.4: Convocatoria y Acta  |
|      Designa     Rinde cuentas    |                                   |              de Asamblea          |
|         v           |             |                                   | • 10.5/10.6: Convocatoria y Acta  |
| • 12: Reglamento Consejo Familia  |<=== Minutas y Convocatorias ======|              de Consejo           |
|         |           ^             |                                   | • 10.7: Acta de Instalación       |
|      Remite      Ejecuta          |                                   |         y Resolución de Comité    |
|         v           |             |                                   |                                   |
| • 13: Reglamento Comité Honor     |<=== Expedientes y Resoluciones ===| • 10.1: Aviso de Exclusividad     |
+-----------------------------------+                                   +-----------------------------------+
```

---

## 3. STATUS DOCUMENTAL DE LOS REGLAMENTOS Y ANEXOS

Basado estrictamente en lo que el texto declara de forma positiva:

1. **Principio de Prevalencia Absoluta:** Tanto el Artículo 2 del Reglamento 11, como el Artículo 2 del Reglamento 12 y el Artículo 2 del Reglamento 13 declaran de forma idéntica e inequívoca:
   > *"En caso de discrepancia, contradicción, incompatibilidad o duda interpretativa entre lo previsto en este Reglamento y el Protocolo Familiar, prevalecerá en todo momento lo dispuesto en este último."*
2. **Subordinación Funcional:** Los reglamentos no son tratados paralelos independientes, sino **instrumentos de ejecución subordinada**. Desarrollan los procedimientos operativos de los órganos creados en el Capítulo 03 del Protocolo.
3. **Naturaleza de los Anexos:** El archivo 10 contiene los formatos que permiten materializar las actas, convocatorias y adhesiones ordenadas por los Reglamentos y el Protocolo. Es un módulo aplicativo e instrumental.
