# INFORME FORENSE: REGLAMENTOS INTERNOS (ARCHIVOS 11, 12 Y 13)
**FASE 4.1 — AUDITORÍA DE ANOMALÍAS DE FUENTE Y VALIDACIÓN SEMÁNTICA**  
**Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)**  
**Fecha:** 26 de Septiembre de 2026  
**Carácter:** AUDITORÍA FORENSE Y VALIDACIÓN SEMÁNTICA (READ-ONLY)

---

## 1. INVESTIGACIÓN DE TÍTULOS AGLUTINADOS EN REGLAMENTO 12

### A. Casos Identificados en `12_reglamento_consejo_familia.md`

#### Caso 1: Línea 114
- **Texto Exacto Actual:** `## CAPÍTULO VIDE LAS ACTAS Y REGISTRO DE ACUERDOS`
- **Markdown Circundante:** Precedido por el fin del Artículo 8 (`...por dicho órgano.`) y seguido de dos saltos de línea y `### Artículo 9. De las Actas y Seguimiento`.
- **Estructura Forense:**
  - Numeral Romano: `CAPÍTULO VI` (termina en `VI`).
  - Título Material: `DE LAS ACTAS Y REGISTRO DE ACUERDOS` (inicia en `DE`).
  - Elemento Faltante: Salto de párrafo (`\n\n`) y formato de subtítulo `**...**`.
- **Comparación con Capítulos I a V del mismo archivo:**
  - L14: `## CAPÍTULO I` $\rightarrow$ L16: `**DE LAS DISPOSICIONES GENERALES**`
  - L31: `## CAPÍTULO II` $\rightarrow$ L33: `**DE LA INTEGRACIÓN Y DESIGNACIÓN**`
  - L57: `## CAPÍTULO III` $\rightarrow$ L59: `**DE LAS SESIONES Y CONVOCATORIAS**`
  - L79: `## CAPÍTULO IV` $\rightarrow$ L81: `**DEL QUÓRUM Y VOTACIONES**`
  - L97: `## CAPÍTULO V` $\rightarrow$ L99: `**DE LAS FACULTADES**`
- **Evidencia OpenXML en DOCX:** El párrafo original de Word contenía `<w:t>CAPÍTULO VI</w:t><w:br/><w:t>DE LAS </w:t>`. El conversor unió la última letra del numeral con el inicio del texto por omisión del `<w:br/>`.
- **Clasificación:** **ERROR TÉCNICO CONFIRMADO (DOCX_CONVERSION_ARTIFACT)**.

#### Caso 2: Línea 133
- **Texto Exacto Actual:** `## CAPÍTULO VIIDE LAS VACANTES Y SUSTITUCIONES`
- **Estructura Forense:** Numeral `CAPÍTULO VII` + Título `DE LAS VACANTES Y SUSTITUCIONES`.
- **Evidencia OpenXML:** Contenía `<w:t>CAPÍTULO VII</w:t><w:br/><w:t>DE LAS </w:t>`.
- **Clasificación:** **ERROR TÉCNICO CONFIRMADO (DOCX_CONVERSION_ARTIFACT)**.

#### Caso 3: Línea 143
- **Texto Exacto Actual:** `## CAPÍTULO VIIIDE LAS MODALIDADES DE SESIONES`
- **Estructura Forense:** Numeral `CAPÍTULO VIII` + Título `DE LAS MODALIDADES DE SESIONES`.
- **Evidencia OpenXML:** Contenía `<w:t>CAPÍTULO VIII</w:t><w:br/><w:t>DE LAS MODALIDADES DE </w:t>`.
- **Clasificación:** **ERROR TÉCNICO CONFIRMADO (DOCX_CONVERSION_ARTIFACT)**.

#### Caso 4: Línea 151
- **Texto Exacto Actual:** `## CAPÍTULO IXDE LA INTERPRETACIÓN Y CASOS NO PREVISTOS`
- **Estructura Forense:** Numeral `CAPÍTULO IX` + Título `DE LA INTERPRETACIÓN Y CASOS NO PREVISTOS`.
- **Evidencia OpenXML:** Contenía `<w:t>CAPÍTULO IX</w:t><w:br/><w:t>DE LA </w:t>`.
- **Clasificación:** **ERROR TÉCNICO CONFIRMADO (DOCX_CONVERSION_ARTIFACT)**.

---

## 2. INVESTIGACIÓN DE NEGRITAS MASIVAS EN REGLAMENTOS 11 Y 13

### A. Diagnóstico Cuantitativo y Porcentaje Afectado
- **Reglamento 11 (Asamblea de Familia):**
  - Total párrafos de cuerpo subordinado a artículos: **35 de 35 (100.0%)** están envueltos individualmente entre `**` y `**`.
  - Fracciones legislativas (I, II, III): **16 de 16 (100.0%)** envueltas en `**...**`.
- **Reglamento 13 (Comité de Honor Familiar):**
  - Total párrafos de cuerpo subordinado a artículos: **27 de 27 (100.0%)** envueltos individualmente entre `**` y `**`.
  - Fracciones legislativas (I, II, III): **19 de 19 (100.0%)** envueltas en `**...**`.
- **Reglamento 12 (Consejo de Familia):**
  - Total párrafos de cuerpo subordinado a artículos: **0 de 38 (0.0%)** en negrita. Se encuentran en texto regular limpio.

### B. Análisis Comparativo de Textos Homólogos
Al comparar artículos idénticos o paralelos entre los reglamentos, se evidencia que expresan la misma jerarquía normativa:

| ARTÍCULO | REGLAMENTO 11 (ASAMBLEA) | REGLAMENTO 12 (CONSEJO) | REGLAMENTO 13 (COMITÉ) |
|:---|:---|:---|:---|
| **Art. 1 (Objeto)** | `**El presente Reglamento tiene por objeto regular la integración...**` | `El presente Reglamento establece las reglas de integración...` | `**El presente Reglamento establece las reglas de integración...**` |
| **Art. 2 (Prevalencia)** | `**El presente Reglamento constituye un instrumento de desarrollo...**` | `El presente Reglamento constituye un instrumento de desarrollo...` | `**El presente Reglamento constituye un instrumento de desarrollo...**` |
| **Disposición Transitoria** | `**El presente Reglamento entrará en vigor en la misma fecha...**` | `El presente Reglamento entrará en vigor en la misma fecha...` | `**El presente Reglamento entrará en vigor en la misma fecha...**` |

### C. Descubrimiento Forense en OpenXML
1. En el archivo `word/document.xml` del DOCX original, **los tres reglamentos comparten exactamente la misma tipografía (`Inter 8 pt`) y el mismo peso regular** para el cuerpo de los artículos.
2. En las secciones 11 y 13, los estilos de párrafo heredaron la propiedad `<w:bCs/>` (*Bold Complex Script*), reservada para alfabetos arábigos o hebreos. Para el idioma español (alfabeto latino), Microsoft Word **desactiva dicha negrita y muestra texto regular**.
3. El conversor a Markdown interpretó erróneamente `<w:bCs/>` como una etiqueta de negrita activa e insertó asteriscos dobles `**` al inicio y final de cada párrafo.
4. En la sección 12, esa etiqueta no figuraba en el estilo y por ello se convirtió a texto plano regular.

**Dictamen Concluyente:**  
La negrita en el cuerpo de los Reglamentos 11 y 13 es un **DOCX_CONVERSION_ARTIFACT**. En el diseño editorial Typst, el cuerpo de los artículos de los tres reglamentos debe componerse con **Neuzeit Grotesk Regular ($7.9077\text{ pt}$)**, reservando el peso Bold/Medium exclusivamente para los títulos display (`Artículo 1.`, `CAPÍTULO I`).

---

## 3. TABLA COMPARATIVA DE NUMERACIÓN NORMATIVA

| NIVEL NORMATIVO | REG 11 (ASAMBLEA) | REG 12 (CONSEJO) | REG 13 (COMITÉ) | REPRESENTACIÓN ACTUAL EN MARKDOWN | CONSISTENCIA | RIESGO COMPOSITIVO |
|:---|:---:|:---:|:---:|:---|:---:|:---|
| **Capítulo Romano** | 8 Capítulos (`CAPÍTULO I` a `VIII`) | 9 Capítulos (`CAPÍTULO I` a `IX`) | 9 Capítulos (`CAPÍTULO I` a `IX`) | Encabezado H2 (`## CAPÍTULO X`) | Media (Reg 12 aglutinado) | Alto si se aplica numeración decimal automática. |
| **Subtítulo de Capítulo** | Párrafo en negrita inmediato | Párrafo en negrita (I-V); en misma línea (VI-IX) | Párrafo en negrita inmediato | `**DE LAS...**` | Media | Pérdida de jerarquía de título. |
| **Artículo Legal** | 12 Artículos (`Artículo 1.` a `12.`) | 12 Artículos (`Artículo 1.` a `12.`) | 12 Artículos (`Artículo 1.` a `12.`) | Encabezado H3 (`### Artículo #. Nombre`) | Alta (100% homogéneo) | Medio si colisiona con H3 decimal. |
| **Fracciones Normativas** | 16 fracciones | 22 fracciones | 19 fracciones | Romano mayúsculo (`I.`, `II.`, `III.`) | Alta | Bajo (requiere sangría de bloque). |
| **Transitorios** | 1 Transitorio Único | 1 Transitorio Único | 1 Transitorio Único | Párrafo en negrita (`**TRANSITORIO ÚNICO**`) | Alta | Bajo (requiere protección de anclaje). |
