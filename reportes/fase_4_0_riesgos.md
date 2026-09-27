# MATRIZ DE RIESGOS EDITORIALES Y DE MAQUETACIÓN
**FASE 4.0 — INVENTARIO Y MAPEO DE COMPONENTES**  
**Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)**  
**Fecha:** 26 de Septiembre de 2026  
**Carácter:** LECTURA, ANÁLISIS, CLASIFICACIÓN Y MAPEO (READ-ONLY)

---

## 1. RESUMEN DE RIESGOS IDENTIFICADOS

El análisis forense de los módulos `00_introduccion.md`, `10_anexos_formatos_operativos.md`, `11_reglamento_asamblea_familia.md`, `12_reglamento_consejo_familia.md` y `13_reglamento_comite_honor_familiar.md` ha permitido anticipar **10 riesgos editoriales y compositivos**, clasificados según su severidad:

- **Riesgos de Severidad ALTA:** 4
- **Riesgos de Severidad MEDIA:** 4
- **Riesgos de Severidad BAJA:** 2

---

## 2. MATRIZ DETALLADA DE RIESGOS

| # | RIESGO IDENTIFICADO | ARCHIVO AFECTADO | UBICACIÓN ESPECÍFICA | SEVERIDAD | POSIBLE ESTRATEGIA POSTERIOR (DIAGNÓSTICO) |
|:---:|:---|:---|:---|:---:|:---|
| **R-01** | **Desbordamiento horizontal por líneas continuas de guion bajo (`_____`)** | `10_anexos_formatos_operativos.md` | Líneas 141, 143, 145, 147, 237, 239, 241, 243, 287, 313 | **ALTA** | En Markdown existen cadenas de `_` de más de 100 caracteres continuos. En Typst, una palabra sin espacios no se corta y desborda la caja de $314.56\text{ pt}$. *Estrategia posterior:* Convertir mediante parser a `#line(length: 100%, stroke: 0.5pt)` o cajas de entrada fija. |
| **R-02** | **Compresión crítica en tabla de 5 columnas en formato Media Carta** | `10_anexos_formatos_operativos.md` | Tabla de Registro de Asistencia (Líneas 126–131) | **ALTA** | Disponer 5 columnas (`Nombre`, `Rama`, `% Capital`, `Acreditación`, `Firma`) en $314.56\text{ pt}$ asigna un promedio de apenas $62\text{ pt}$ por columna. *Estrategia posterior:* Asignar anchos proporcionales explícitos en Typst (`(2fr, 1.5fr, 1fr, 1.2fr, 1.5fr)`) y cuerpo $6.5\text{ pt}$. |
| **R-03** | **Encabezados fusionados por defecto de Markdown (`CAPÍTULO VIDE...`)** | `12_reglamento_consejo_familia.md` | Líneas 114, 133, 143, 151 | **ALTA** | La ausencia de espacio o salto de línea (`CAPÍTULO VIDE`, `CAPÍTULO VIIDE`, etc.) provocará que Typst renderice títulos aglutinados o falle el reconocimiento de capítulo. *Estrategia posterior:* El parser del compilador deberá desambiguar con regex `^##\s+CAPÍTULO\s+([IVXLCDM]+)(DE.*)` o reportarse como corrección canónica formal. |
| **R-04** | **Párrafos de cuerpo 100% en negrita (`**...**`)** | `11_reglamento_asamblea_familia.md` y `13_reglamento_comite_honor_familiar.md` | Todo el articulado (35 párrafos en 11; 27 párrafos en 13) | **ALTA** | Todo el cuerpo legal de ambos reglamentos está envuelto en negritas. En Neuzeit Grotesk, páginas completas en bold generan una mancha tipográfica negra excesiva, ilegibilidad y distorsión del ritmo de interlínea. *Estrategia posterior:* Analizar si el parser debe neutralizar la negrita global conservándola solo en términos clave o en títulos de artículos. |
| **R-05** | **Colisión de numeración decimal prefijada en articulado de Reglamentos** | `11`, `12`, `13` | Todos los encabezados H2 y H3 | **MEDIA** | La regla de los Capítulos 01–09 (`heading(numbering: "1.1")`) generaría títulos espurios como `11.1 CAPÍTULO I` y `11.1.1 Artículo 1.`. *Estrategia posterior:* Crear contexto tipográfico sin numbering automático para reglamentos, permitiendo que el número provenga de la fuente literal. |
| **R-06** | **Fraccionamiento de bloques de firma y rúbricas (Huérfanas de firma)** | `10_anexos_formatos_operativos.md` | Líneas 76–81, 107–114, 163–170, 200–206, 255–263, 321–328 | **MEDIA** | Tablas de cierre o líneas de firma que quedan aisladas en el tope de una página sin texto precedente. *Estrategia posterior:* Encapsular tablas de cierre y cláusulas finales en bloques indivisibles (`block(breakable: false)`). |
| **R-07** | **Párrafos de desarrollo de actas partidos en posiciones críticas** | `10_anexos_formatos_operativos.md` | Puntos de votación (Líneas 149–160, 245–252) | **MEDIA** | El bloque de votación (a favor, en contra, abstenciones, resultado) puede partirse a la mitad de una página a otra. *Estrategia posterior:* Proteger el bloque de votación como unidad semántica. |
| **R-08** | **Casillas de verificación (`☐` U+2610) y soporte tipográfico** | `10_anexos_formatos_operativos.md` | Líneas 128–131, 151, 159, 291–299 | **MEDIA** | El glifo `☐` en algunas fuentes puede tener desfase vertical de baseline o no existir en fuentes secundarias. *Estrategia posterior:* Mapeo sistemático en el parser hacia `#box(stroke: 0.5pt, width: 6pt, height: 6pt)`. |
| **R-09** | **Disposiciones Transitorias sin categoría de heading formal** | `11`, `12`, `13` | Líneas 175 (11), 160 (12), 165 (13) | **BAJA** | `TRANSITORIO ÚNICO` está redactado como párrafo de texto en lugar de un H3 formal, lo que puede provocar que pierda propiedades de anclaje (sticky) y quede huérfano al pie de página. *Estrategia posterior:* Tratamiento como encabezado especial o bloque no divisible con su cuerpo. |
| **R-10** | **Inconsistencia tipográfica en título de Artículo 12 de Reglamento 12** | `12_reglamento_consejo_familia.md` | Línea 154 (`### Artículo 12. De los Casos No Previstos.`) | **BAJA** | Presenta un punto final redundante tras el título, a diferencia de los otros 35 artículos del corpus. *Estrategia posterior:* Limpieza de puntuación final en el parser de títulos. |

---

## 3. RESUMEN DE SEVERIDAD Y ACCIONES FUTURAS

```text
==================================================================================================
NIVEL DE SEVERIDAD        CANTIDAD      IMPACTO EDITORIAL               ACCIÓN EN FASE POSTERIOR
==================================================================================================
ALTA                      4             Riesgo de overflow o defecto    Tratamiento estructural
                                        crítico de legibilidad          obligatorio en parser
MEDIA                     4             Riesgo de partición visual      Reglas de empaquetado y
                                        o colisión tipográfica          encapsulamiento en bloques
BAJA                      2             Detalle menor de marcado        Normalización pasiva en
                                        o puntuación                    motor de renderizado
==================================================================================================
```
