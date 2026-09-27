# INFORME FORENSE: ANEXOS Y FORMATOS OPERATIVOS (10_anexos_formatos_operativos.md)
**FASE 4.1 — AUDITORÍA DE ANOMALÍAS DE FUENTE Y VALIDACIÓN SEMÁNTICA**  
**Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)**  
**Fecha:** 26 de Septiembre de 2026  
**Carácter:** AUDITORÍA FORENSE Y VALIDACIÓN SEMÁNTICA (READ-ONLY)

---

## 1. DISTINCIÓN FORENSE: CONTENIDO SEMÁNTICO vs RECURSOS DE MAQUETACIÓN

En el archivo `10_anexos_formatos_operativos.md`, conviven elementos de contenido normativo y de voluntad legal con recursos gráficos primitivos empleados en Word para simular formatos impresos de llenado manual.

```text
==================================================================================================
ELEMENTO EN MARKDOWN        NATURALEZA ACTUAL       CONTENIDO SEMÁNTICO         TRATAMIENTO TYPST RECOMENDADO
==================================================================================================
Cadenas de guiones bajos    Recurso tipográfico     Campo de captura manual     #legal-field(width) o
'_____' (34 instancias)     analógico (Word)        o espacio reservado         #legal-line() vectoriales
--------------------------------------------------------------------------------------------------
Casillas cuadradas          Glifo Unicode           Opción de selección,        #box(stroke: 0.5pt, width: 6pt)
'☐' (U+2610 - 18 inst.)     legítimo                acreditación o checklist    o #sym.square vectorial
--------------------------------------------------------------------------------------------------
Tablas Markdown             Estructura matricial    Listas de asistencia,       #legal-table() con anchos
(6 tablas de 3 a 5 cols)    nativa                  escrutinio y rúbricas       calibrados para Media Carta
--------------------------------------------------------------------------------------------------
Bloques 'Atentamente'       Texto centrado /        Manifestación de voluntad   #signature-block() con
y líneas de firma (7 inst.) guiones de firma        y suscripción formal        protección contra viudas
==================================================================================================
```

---

## 2. MODELADO CONCEPTUAL DE COMPONENTES DE FORMULARIO

Para independizar el contenido semántico del diseño visual sin alterar el archivo Markdown, se establece el siguiente modelo de abstracción:

### A. Tipos de Campos de Captura (`FIELD` / `TEXTAREA`)
1. **`FIELD_DATE` (Fecha y Lugar):** `Lugar y fecha de emisión: ____________________________, a ___ de __________ de ______`.
   - Semántica: Captura de municipio, día, mes y año.
2. **`FIELD_NAME` (Identificación Personal):** `Yo, _______________________________________________, por mi propio derecho...`.
   - Semántica: Nombre y apellidos del firmante o adherente.
3. **`FIELD_PERCENT` (Porcentajes y Quórum):** `Se hace constar que se encuentra representado el __ % del capital...`.
   - Semántica: Registro de cuota patrimonial y asistencia numérica.
4. **`TEXTAREA` (Desarrollo y Resolutivos):** `Deliberación: ________________________________________________________________...`.
   - Semántica: Espacio libre para asentar acuerdos tomados en la asamblea o determinaciones del comité.

### B. Casillas de Verificación y Opciones (`CHECKBOX`)
1. **`CHECKBOX_ACCREDITATION` (Acreditación):** `☐ Sí ☐ No` en la tabla de asistencia (Líneas 128–131). Permite al Secretario consignar si el miembro familiar exhibió su acreditación formal.
2. **`CHECKBOX_VOTE_OPTION` (Sentido de Acuerdo):** `☐ Aprobada sin modificaciones ☐ Aprobada con modificaciones ☐ Diferida` (Línea 151).
3. **`CHECKBOX_DECISION` (Resultado Final):** `Resultado: ☐ Aprobado ☐ No aprobado` (Línea 159).
4. **`CHECKBOX_CHECKLIST` (Recepción de Evidencia):** Checklist de 5 casillas en el Comité de Honor (Líneas 291–299) para cotejo documental de expedientes.

### C. Tablas Operativas y de Escrutinio (`TABLE` / `SIGNATURE_TABLE`)
1. **Tabla 1 (Asistencia Asamblea - L126):** 5 columnas (`Nombre | Rama Familiar | Porcentaje de Capital | Acreditación | Firma`). Requiere calibración milimétrica para evitar compresión en caja de $314.56\text{ pt}$.
2. **Tabla 2 (Clausura Asamblea - L165):** 4 columnas (`Nombre | Rama | Cargo / Calidad | Firma`) para Presidente, Secretario y Escrutador.
3. **Tabla 3 (Asistencia Consejo - L219):** 4 columnas (`Nombre | Rama Familiar | Cargo en el Consejo | Firma`).
4. **Tabla 4 (Clausura Consejo - L257):** 3 columnas (`Nombre | Cargo | Firma`) para Presidente, Secretario y 2 Vocales.
5. **Tabla 5 (Instalación Comité Honor - L273):** 3 columnas (`Nombre | Carácter | Firma de Aceptación`) para 3 miembros.
6. **Tabla 6 (Clausura Comité Honor - L323):** 3 columnas (`Nombre | Cargo en el Comité | Firma`) para 3 miembros.

---

## 3. AUDITORÍA DE ANOMALÍAS LÉXICAS Y ORTOGRÁFICAS EN ANEXOS

Al cotejar el Markdown con el archivo DOCX original, se confirmaron dos erratas textuales provenientes del redactor original:

### A. Errata en Documentación Recibida (Línea 291)
- **Texto Actual:** `☐ Expediente institucional complete.`
- **Texto en DOCX Original:** `☐ Expediente institucional complete.`
- **Causa Forense:** Error mecanográfico del redactor original de Word (terminación inglesa o tecla errónea `e` por `o`).
- **Clasificación:** `AMBIGUOUS_REQUIRES_USER`.
- **Propuesta:** Cambiar por `☐ Expediente institucional completo.`.
- **Impacto Semántico:** `REQUIRES_LEGAL_CONTENT_REVIEW` (corrección gramatical sin cambio normativo).

### B. Acentuación en Tabla de Integrantes (Línea 275)
- **Texto Actual:** `|  | Presidente del Cómite |  |`
- **Texto en DOCX Original:** `Presidente del Cómite`
- **Causa Forense:** Tilde esdrújula errónea sobre la `ó` en lugar de la palabra aguda `Comité`.
- **Clasificación:** `AMBIGUOUS_REQUIRES_USER`.
- **Propuesta:** Cambiar por `|  | Presidente del Comité |  |`.
- **Impacto Semántico:** `REQUIRES_LEGAL_CONTENT_REVIEW` (corrección ortográfica).
