# REPORTE DE PROPUESTAS DE NORMALIZACIÓN CANÓNICA
**FASE 4.1 — AUDITORÍA DE ANOMALÍAS DE FUENTE Y VALIDACIÓN SEMÁNTICA**  
**Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)**  
**Fecha:** 26 de Septiembre de 2026  
**Carácter:** PROPUESTA FORMAL PARA REVISIÓN Y AUTORIZACIÓN (READ-ONLY)

---

## 1. INTRODUCCIÓN Y POLÍTICA DE SEGURIDAD EDITORIAL

En estricto apego al mandato de la **FASE 4.1**, **NO SE HA MODIFICADO NINGÚN ARCHIVO MARKDOWN**.

Este documento presenta el paquete formal de propuestas de normalización para que el usuario pueda evaluar, autorizar o rechazar cada intervención de forma controlada y transparente, exactamente igual al procedimiento llevado a cabo con el residuo `%2.` en la Fase 3.9.3.

---

## 2. PAQUETE A: PROPUESTAS DE NORMALIZACIÓN ESTRUCTURAL (IMPACTO SEMÁNTICO = NONE)

Estas correcciones resuelven defectos técnicos de conversión DOCX (omisión de saltos `<w:br/>` y puntuación redundante en títulos), restaurando la armonía con el resto del documento sin cambiar una sola palabra de contenido normativo:

### Propuesta 1 (H-01): Título de Capítulo VI en Consejo de Familia
- **Archivo:** `capitulos/12_reglamento_consejo_familia.md`
- **Línea:** 114
- **Texto Actual:**
  ```markdown
  ## CAPÍTULO VIDE LAS ACTAS Y REGISTRO DE ACUERDOS
  ```
- **Texto Propuesto:**
  ```markdown
  ## CAPÍTULO VI

  **DE LAS ACTAS Y REGISTRO DE ACUERDOS**
  ```
- **Tipo de Cambio:** Corrección de artefacto de conversión DOCX (separación de numeral romano y subtítulo).
- **Justificación:** Restaura la consistencia idéntica con los Capítulos I a V del mismo reglamento.
- **Impacto Semántico:** **NONE**.

---

### Propuesta 2 (H-02): Título de Capítulo VII en Consejo de Familia
- **Archivo:** `capitulos/12_reglamento_consejo_familia.md`
- **Línea:** 133
- **Texto Actual:**
  ```markdown
  ## CAPÍTULO VIIDE LAS VACANTES Y SUSTITUCIONES
  ```
- **Texto Propuesto:**
  ```markdown
  ## CAPÍTULO VII

  **DE LAS VACANTES Y SUSTITUCIONES**
  ```
- **Tipo de Cambio:** Corrección de artefacto de conversión DOCX.
- **Justificación:** Restaura la consistencia idéntica con los Capítulos I a V del mismo reglamento.
- **Impacto Semántico:** **NONE**.

---

### Propuesta 3 (H-03): Título de Capítulo VIII en Consejo de Familia
- **Archivo:** `capitulos/12_reglamento_consejo_familia.md`
- **Línea:** 143
- **Texto Actual:**
  ```markdown
  ## CAPÍTULO VIIIDE LAS MODALIDADES DE SESIONES
  ```
- **Texto Propuesto:**
  ```markdown
  ## CAPÍTULO VIII

  **DE LAS MODALIDADES DE SESIONES**
  ```
- **Tipo de Cambio:** Corrección de artefacto de conversión DOCX.
- **Justificación:** Restaura la consistencia idéntica con los Capítulos I a V del mismo reglamento.
- **Impacto Semántico:** **NONE**.

---

### Propuesta 4 (H-04): Título de Capítulo IX en Consejo de Familia
- **Archivo:** `capitulos/12_reglamento_consejo_familia.md`
- **Línea:** 151
- **Texto Actual:**
  ```markdown
  ## CAPÍTULO IXDE LA INTERPRETACIÓN Y CASOS NO PREVISTOS
  ```
- **Texto Propuesto:**
  ```markdown
  ## CAPÍTULO IX

  **DE LA INTERPRETACIÓN Y CASOS NO PREVISTOS**
  ```
- **Tipo de Cambio:** Corrección de artefacto de conversión DOCX.
- **Justificación:** Restaura la consistencia idéntica con los Capítulos I a V del mismo reglamento.
- **Impacto Semántico:** **NONE**.

---

### Propuesta 5 (H-12): Supresión de Punto Final Redundante en Artículo 12
- **Archivo:** `capitulos/12_reglamento_consejo_familia.md`
- **Línea:** 154
- **Texto Actual:**
  ```markdown
  ### Artículo 12. De los Casos No Previstos.
  ```
- **Texto Propuesto:**
  ```markdown
  ### Artículo 12. De los Casos No Previstos
  ```
- **Tipo de Cambio:** Normalización de puntuación en encabezado Markdown.
- **Justificación:** Elimina el punto final redundante tras el título para uniformar con los 35 artículos restantes de la obra.
- **Impacto Semántico:** **NONE**.

---

## 3. PAQUETE B: PROPUESTAS DE CORRECCIÓN ORTOGRÁFICA / LÉXICA (REQUIEREN REVISIÓN)

Estas dos propuestas corrigen erratas materiales heredadas de la fuente original DOCX:

### Propuesta 6 (H-10): Errata Léxica en Checklist de Comité de Honor
- **Archivo:** `capitulos/10_anexos_formatos_operativos.md`
- **Línea:** 291
- **Texto Actual:**
  ```markdown
  ☐ Expediente institucional complete.
  ```
- **Texto Propuesto:**
  ```markdown
  ☐ Expediente institucional completo.
  ```
- **Tipo de Cambio:** Corrección léxica/mecanográfica (`complete.` $\rightarrow$ `completo.`).
- **Justificación:** La palabra `complete` en español jurídico carece de sentido gramatical en ese contexto; se trata de una errata evidente del redactor original en Word.
- **Impacto Semántico:** **REQUIRES_LEGAL_CONTENT_REVIEW**.

---

### Propuesta 7 (H-11): Errata Acentual en Tabla de Integrantes
- **Archivo:** `capitulos/10_anexos_formatos_operativos.md`
- **Línea:** 275
- **Texto Actual:**
  ```markdown
  |  | Presidente del Cómite |  |
  ```
- **Texto Propuesto:**
  ```markdown
  |  | Presidente del Comité |  |
  ```
- **Tipo de Cambio:** Corrección ortográfica de tilde esdrújula errónea (`Cómite` $\rightarrow$ `Comité`).
- **Justificación:** La palabra normativa es aguda (`Comité`). En la línea 281 y en todo el resto de la obra aparece correctamente como `Comité`.
- **Impacto Semántico:** **REQUIRES_LEGAL_CONTENT_REVIEW**.

---

## 4. PAQUETE C: RECURSOS RESUELTOS EN MOTOR EDITORIAL (SIN TOCAR MARKDOWN)

Se determina que las siguientes anomalías **NO REQUIEREN MODIFICAR MARKDOWN**, ya que se resolverán directamente en el motor tipográfico Typst:

1. **Negritas Masivas en Reglamentos 11 y 13 (H-05, H-06):** El compilador interpretará los párrafos del cuerpo con su peso tipográfico regular (`Neuzeit Grotesk Regular`), ignorando la envoltura `**...**` generada por el artefacto `<w:bCs/>` de Word.
2. **Líneas de Guiones Bajos `_____` (H-07):** El compilador mapeará las cadenas de guiones a componentes vectoriales `#legal-field()` y `#legal-line()`.
3. **Casillas `☐` (H-08):** El compilador las renderizará como cajas vectoriales `#box(stroke: 0.5pt, width: 6pt)`.
4. **Tablas Markdown (H-09):** El compilador asignará anchos de grilla proporcionales adaptados al ancho neto de Media Carta ($314.56\text{ pt}$).
5. **Transitorios y Proemio (H-13, H-14):** Se compondrán mediante reglas de flujo y anclaje tipográfico.

---

## 5. TABLA RESUMEN PARA AUTORIZACIÓN

| ID | ARCHIVO | LÍNEA | TEXTO ACTUAL | TEXTO PROPUESTO | IMPACTO SEMÁNTICO | ESTADO ACTUAL |
|:---:|:---|:---:|:---|:---|:---:|:---:|
| **H-01** | `12_reglamento_consejo` | 114 | `## CAPÍTULO VIDE LAS ACTAS...` | `## CAPÍTULO VI\n\n**DE LAS ACTAS...**` | NONE | En espera de autorización |
| **H-02** | `12_reglamento_consejo` | 133 | `## CAPÍTULO VIIDE LAS VACANTES...` | `## CAPÍTULO VII\n\n**DE LAS VACANTES...**` | NONE | En espera de autorización |
| **H-03** | `12_reglamento_consejo` | 143 | `## CAPÍTULO VIIIDE LAS MODALIDADES...` | `## CAPÍTULO VIII\n\n**DE LAS MODALIDADES...**` | NONE | En espera de autorización |
| **H-04** | `12_reglamento_consejo` | 151 | `## CAPÍTULO IXDE LA INTERPRETACIÓN...` | `## CAPÍTULO IX\n\n**DE LA INTERPRETACIÓN...**` | NONE | En espera de autorización |
| **H-12** | `12_reglamento_consejo` | 154 | `### Artículo 12... Previstos.` | `### Artículo 12... Previstos` | NONE | En espera de autorización |
| **H-10** | `10_anexos` | 291 | `☐ Expediente... complete.` | `☐ Expediente... completo.` | REQUIRES_REVIEW | En espera de autorización |
| **H-11** | `10_anexos` | 275 | `Presidente del Cómite` | `Presidente del Comité` | REQUIRES_REVIEW | En espera de autorización |
