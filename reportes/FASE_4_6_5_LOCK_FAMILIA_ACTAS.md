# INFORME DE CONSOLIDACIÓN Y LOCK PARCIAL · FASE 4.6.5
## CONSOLIDACIÓN EDITORIAL Y LOCK PARCIAL DE LA FAMILIA DE ACTAS
### Integración Oficial de Componentes en `componentes.typ` y Generación del Golden Master

**Proyecto:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Fecha:** 27 de Septiembre de 2026  
**Módulo:** Anexos y Formatos Operativos (`capitulos/10_anexos_formatos_operativos.md`)  
**Subsistema:** Familia de Actas (Asamblea General Familiar · Consejo de Familia · Comité de Honor Familiar)  
**Archivo Oficial Integrado:** [`templates/typst/componentes.typ`](file:///home/jjss/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ) (Sección 18)  
**Estado:** **LOCK PARCIAL APROBADO / HARD STOP ACTIVO** (A espera de autorización humana)

---

## 1. RESUMEN EJECUTIVO Y DECISIÓN EDITORIAL HUMANA

Tras la revisión visual individual de los prototipos generados en la Fase 4.6.4, la dirección editorial humana aprobó formalmente la **familia de Actas** del Protocolo Familiar y la arquitectura técnica común que las sustenta:
1. **Acta de Asamblea General Familiar:** Aprobada en Microvariante A2 (2 / 3 / 3 / 3 líneas manuscritas en Sección 3, arquitectura de 2 páginas Verso–Recto).
2. **Acta de Sesión del Consejo de Familia:** Aprobada en configuración de Fase 4.6.4 (2 páginas Verso–Recto, mesa de 4 firmas en Pág 03).
3. **Acta de Constitución y Sesión del Comité de Honor Familiar:** Aprobada en configuración de Fase 4.6.4 (2 páginas Verso–Recto, 9 secciones canónicas, 5 checkboxes en Pág 02).

### Alcance del LOCK Parcial
Esta fase **bloquea exclusivamente la gramática y componentes de la familia de Actas**.  
Los restantes componentes del módulo de Anexos continúan **PENDIENTES y UNLOCKED**:
- Convocatorias (Asamblea y Consejo).
- Carta de Aceptación y Adhesión al Protocolo Familiar.
- Aviso de Exclusividad y Personalización (Aviso Jurídico).
- Portadilla / Apertura ceremonial de Anexos.

---

## 2. ESTADO DE LOS COMPONENTES DEL MÓDULO DE ANEXOS

| Componente / Formato | Estado Editorial | Estado Técnico | Ubicación de la Fuente |
| :--- | :---: | :---: | :--- |
| **Acta de Asamblea General Familiar** | **APROBADO** | **LOCKED** | `templates/typst/componentes.typ` (Sec. 18) |
| **Acta de Sesión del Consejo de Familia** | **APROBADO** | **LOCKED** | `templates/typst/componentes.typ` (Sec. 18) |
| **Acta de Constitución y Sesión del Comité de Honor**| **APROBADO** | **LOCKED** | `templates/typst/componentes.typ` (Sec. 18) |
| Convocatoria a Asamblea de Familia | Pendiente | UNLOCKED | Laboratorio experimental |
| Convocatoria a Sesión del Consejo de Familia | Pendiente | UNLOCKED | Laboratorio experimental |
| Carta de Aceptación y Adhesión | Pendiente | UNLOCKED | Laboratorio experimental |
| Aviso de Exclusividad y Personalización | Pendiente | UNLOCKED | Laboratorio experimental |
| Apertura General de Anexos (Portadilla) | Pendiente | UNLOCKED | Laboratorio experimental |

---

## 3. INVARIANTES GEOMÉTRICAS Y RETÍCULA CANÓNICA

Quedan formalmente establecidas y consolidadas las siguientes invariantes para la familia de Actas:

1. **Dimensiones de Página:** Media Carta ($396.00\text{ pt} \times 612.00\text{ pt}$, equivalente a $5.5 \times 8.5\text{ in}$).
2. **Márgenes Asimétricos Institucionales:**
   - Margen interior (`inside` / lomo): **$58.74\text{ pt}$**
   - Margen exterior (`outside` / corte): **$22.70\text{ pt}$**
   - Margen superior: **$71.0079\text{ pt}$** (Consolidado retícula $+6\text{ mm}$)
   - Margen inferior: **$65.00\text{ pt}$** (Límite inferior de caja útil en $Y = 547.00\text{ pt}$)
3. **Caja Útil Horizontal Canónica:**
   $$\text{Ancho real} = 396.00\text{ pt} - 58.74\text{ pt} - 22.70\text{ pt} = \mathbf{314.56\text{ pt}}$$
   *(Se descarta formalmente cualquier mención histórica a un ancho de $\sim 294\text{ pt}$; $314.56\text{ pt}$ es la cota matemática oficial).*
4. **Sincronización Dinámica de Binding y Paridad:**
   - Si `start_page` es par (ej. $2$ para pliegos Verso–Recto): `binding = right`.
   - Si `start_page` es impar o `none`: `binding = left`.
   - Correspondencia física garantizada:
     - **VERSO:** `outside` a la izquierda ($22.70\text{ pt}$), `inside` a la derecha ($58.74\text{ pt}$). Caja: $[22.70, 337.26]\text{ pt}$.
     - **RECTO:** `inside` a la izquierda ($58.74\text{ pt}$), `outside` a la derecha ($22.70\text{ pt}$). Caja: $[58.74, 373.30]\text{ pt}$.
5. **Filete Vertical de Lomo:** Línea de $0.5\text{ pt}$ en color naranja institucional (`#f15d22`), ubicada a $30.13\text{ pt}$ del lomo ($X = 365.87\text{ pt}$ en Verso, $X = 30.13\text{ pt}$ en Recto).
6. **Canal de Seguridad al Filete:** Holgura mínima $\ge +28.36\text{ pt}$ (casi $10\text{ mm}$). Invariante: **ningún trazo vectorial ni texto funcional puede atravesar ni tocar el filete**.
7. **Estándares de Tablas y Rayado:**
   - Altura de filas en tablas: `row_height: 22.0pt` fija.
   - Rayado manuscrito: `line_spacing: 14.5pt` ($5.11\text{ mm}$ estándar de escritura manual), aislado con `set par(spacing: 0pt)`.
   - Bloque de firmas: `breakable: false` (*keep-together* indivisible que prohíbe firmas huérfanas).

---

## 4. COMPONENTES INTEGRADOS EN `componentes.typ` (SECCIÓN 18)

Se integró en [`templates/typst/componentes.typ`](file:///home/jjss/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ) el código mínimo y definitivo para reproducir la familia aprobada, sin scaffolding ni código diagnóstico:

1. **`annex-page(cfg, form_title, short_header_title, full_header_title, start_page, body)`:** Entorno base con cálculo dinámico de `pg-binding`, márgenes institucionales, encabezado, pie y filete.
2. **`form-title(title, above, below)`:** Título principal en Minion Pro Medium Display $13.5\text{ pt}$ con tracking $+0.020\text{em}$.
3. **`form-header-meta(...)`:** Metadatos configurables con prefijos, sufijos, etiquetas y visibilidad condicional de checkboxes de tipo ordinaria/extraordinaria.
4. **`form-section-title(num_str, title, above, below)`:** Encabezado de sección con numeral naranja institucional y `sticky: true`.
5. **`form-field-line(width, min_width, stroke, baseline, content)`:** Trazo vectorial continuo alineado a la línea base tipográfica.
6. **`form-checkbox(label, checked, size, stroke, radius)`:** Caja geométrica de $7.0\text{ pt}$ con radio de $1.2\text{ pt}$.
7. **`form-table(columns, headers, rows_data, row_height, stroke)`:** Tablas con altura de $22.0\text{ pt}$ y cabeceras en sombreado `#f8fafc`.
8. **`form-multiline-field(label, num_lines, line_spacing, below, stroke)`:** Renglones vectoriales para escritura con protección `par(spacing: 0pt)`.
9. **`form-signature-block(above, content)`:** Envoltorio `breakable: false` para vinculación de clausura y mesa de firmas.
10. **`annex-running-header()`**, **`annex-footer()`**, **`annex-spine-rule()`:** Sistema periférico coordinado de página.

*Preservación del laboratorio:* El archivo [`templates/typst/componentes_anexos_experimental.typ`](file:///home/jjss/Desktop/ABC/repositorio_protocolo/templates/typst/componentes_anexos_experimental.typ) se conserva intacto para el desarrollo posterior de Convocatorias, Carta de Adhesión y Aviso Jurídico.

---

## 5. CORPUS PERMANENTE Y ARQUITECTURA DEL TEST OFICIAL

Para evitar la duplicación de contenido y garantizar que los tests sean mantenibles:
1. Se creó el corpus estructurado derivado [`tests/corpus_actas_fase_4_6_5.typ`](file:///home/jjss/Desktop/ABC/repositorio_protocolo/tests/corpus_actas_fase_4_6_5.typ), el cual exporta:
   - `render-acta-asamblea()`
   - `render-acta-consejo()`
   - `render-acta-comite()`
2. Se creó el test oficial permanente [`tests/test_familia_actas_lock_fase_4_6_5.typ`](file:///home/jjss/Desktop/ABC/repositorio_protocolo/tests/test_familia_actas_lock_fase_4_6_5.typ), el cual importa exclusivamente de `componentes.typ` y `corpus_actas_fase_4_6_5.typ`.

---

## 6. VALIDACIÓN CONTRA GOLDEN CANDIDATES (COMPARATIVA RASTER PÍXEL A PÍXEL)

Se compiló el archivo maestro [`dist/TEST_FAMILIA_ACTAS_LOCK_FASE_4_6_5.pdf`](file:///home/jjss/Desktop/ABC/repositorio_protocolo/dist/TEST_FAMILIA_ACTAS_LOCK_FASE_4_6_5.pdf) (exactamente 6 páginas) y se ejecutó una suite de validación automatizada que comparó cada una de sus 6 páginas contra los PDFs individuales aprobados de la Fase 4.6.4:

| Página del Master | Documento y Folio | PDF de Referencia Aprobado (Fase 4.6.4) | Coincidencia Textual | Coincidencia Trazos Vectoriales | Diff Raster (150 DPI) | Estado |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: |
| **Pág 1** | Acta Asamblea — Verso (Folio 02) | `dist/TEST_ACTA_ASAMBLEA_FASE_4_6_4_CONTROL.pdf` (P1) | **100% IDÉNTICO** | 44 vs 44 trazos | **0 píxeles diff** (None) |  LOCKED |
| **Pág 2** | Acta Asamblea — Recto (Folio 03) | `dist/TEST_ACTA_ASAMBLEA_FASE_4_6_4_CONTROL.pdf` (P2) | **100% IDÉNTICO** | 43 vs 43 trazos | **0 píxeles diff** (None) |  LOCKED |
| **Pág 3** | Acta Consejo — Verso (Folio 02) | `dist/TEST_ACTA_CONSEJO_FASE_4_6_4.pdf` (P1) | **100% IDÉNTICO** | 33 vs 33 trazos | **0 píxeles diff** (None) |  LOCKED |
| **Pág 4** | Acta Consejo — Recto (Folio 03) | `dist/TEST_ACTA_CONSEJO_FASE_4_6_4.pdf` (P2) | **100% IDÉNTICO** | 34 vs 34 trazos | **0 píxeles diff** (None) |  LOCKED |
| **Pág 5** | Acta Comité — Verso (Folio 02) | `dist/TEST_ACTA_COMITE_FASE_4_6_4.pdf` (P1) | **100% IDÉNTICO** | 36 vs 36 trazos | **0 píxeles diff** (None) |  LOCKED |
| **Pág 6** | Acta Comité — Recto (Folio 03) | `dist/TEST_ACTA_COMITE_FASE_4_6_4.pdf` (P2) | **100% IDÉNTICO** | 26 vs 26 trazos | **0 píxeles diff** (None) |  LOCKED |

**Resultado:** La integración en `componentes.typ` reproduce matemáticamente y visualmente los documentos aprobados con **cero píxeles de discrepancia**.

---

## 7. AUDITORÍA DE FUENTE CANÓNICA (INTEGRIDAD CRIPTOGRÁFICA)

Se calcularon los hashes SHA-256 de todos los capítulos Markdown antes y después de la integración:

| Archivo Canónico | Hash SHA-256 Inicial | Hash SHA-256 Final | Estado |
| :--- | :---: | :---: | :---: |
| `capitulos/00_introduccion.md` | `da30bd94...` | `da30bd94...` | **INTACTO** |
| `capitulos/00_portada_e_indice.md` | `9621ef2f...` | `9621ef2f...` | **INTACTO** |
| `capitulos/01_capitulo1_declaracion_principios.md` | `5ee86efa...` | `5ee86efa...` | **INTACTO** |
| `capitulos/02_capitulo2_propiedad_control_liquidez.md` | `afcf7b12...` | `afcf7b12...` | **INTACTO** |
| `capitulos/03_capitulo3_gobierno_profesionalizacion.md` | `bc0373a1...` | `bc0373a1...` | **INTACTO** |
| `capitulos/04_capitulo4_sucesion_familiar.md` | `d7b5c2c9...` | `d7b5c2c9...` | **INTACTO** |
| `capitulos/05_capitulo5_control_informacion_comunicacion.md` | `e43ed0d2...` | `e43ed0d2...` | **INTACTO** |
| `capitulos/06_capitulo6_disciplina_financiera.md` | `aa7244a4...` | `aa7244a4...` | **INTACTO** |
| `capitulos/07_capitulo7_procedimiento_sancionador.md` | `b605a76d...` | `b605a76d...` | **INTACTO** |
| `capitulos/08_capitulo8_solucion_conflictos.md` | `b7ef9226...` | `b7ef9226...` | **INTACTO** |
| `capitulos/09_capitulo9_regimen_juridico.md` | `5d6eb559...` | `5d6eb559...` | **INTACTO** |
| `capitulos/10_anexos_formatos_operativos.md` | `d71e9ff3...` | `d71e9ff3...` | **INTACTO** |
| `capitulos/11_reglamento_asamblea_familia.md` | `5f42f147...` | `5f42f147...` | **INTACTO** |
| `capitulos/12_reglamento_consejo_familia.md` | `6b5b77cb...` | `6b5b77cb...` | **INTACTO** |
| `capitulos/13_reglamento_comite_honor_familiar.md` | `ba472b35...` | `ba472b35...` | **INTACTO** |

---

## 8. AUDITORÍA DE NO REGRESIÓN GLOBAL

Se recompilaron y verificaron los baselines institucionales existentes contra la versión actualizada de `componentes.typ`:
1. **Reglamentos Fase 4.5.8 (`tests/test_regulation_page_lock_fase_4_5_8.typ`):** Compila limpiamente a exactamente **24 páginas**, conservando la configuración locked (H2, O1, A12, T12, M1).
2. **Capítulos 01–09 (`tests/test_protocolo_capitulos_01_09_fase_3_9_3.typ`):** Compila limpiamente a exactamente **126 páginas**, sin alteración en cortes ni flujo.
3. **Componentes Previos:** `cover-page()`, `chapter-opening()`, `chapter-first-page()`, `interior-page()`, `introduction-page()`, `regulation-opening()` y `regulation-page()` permanecen intactos.

---

## 9. INCIDENCIAS TEXTUALES PENDIENTES (SIN MODIFICAR FUENTE)

Se preservan intactas en la fuente canónica para una fase posterior de saneamiento ortotipográfico:
- Metadatos: Discrepancia entre `Número:` (Asamblea), `Número de Sesión:` (Consejo) y `Expediente Número:` (Comité).
- Título Sección 4 Comité con dos puntos finales (`**4. Documentación Recibida del Consejo de Familia:**`).
- Capitalización de preposición en Consejo (`**1. Lista De Asistencia**`).
- Año de 8 guiones en Consejo (`de ________`) y año trunco en Comité (`de 20,`).
- Pegado de la Sección 6 en Comité inmediatamente tras el ítem 4 de la lista previa.
- Renglón de cierre espaciotemporal en Comité (ausente en los otros dos formatos).

---

## 10. AUDITORÍA DEL WORKSPACE Y PROPUESTA DE COMMIT

### Estado de Git (`git diff --stat`)
```
 templates/typst/componentes.typ | 417 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 417 insertions(+)
```
*(Cero archivos rastreados rotos o modificados fuera de la Sección 18 añadida a `componentes.typ`).*

### Propuesta Estricta de Commit para el LOCK Parcial
Se propone que el commit de consolidación de Fase 4.6.5 contenga **únicamente los 5 artefactos estrictamente necesarios**:

1. `templates/typst/componentes.typ` *(Integración de Sección 18: Anexos — Sistema de Actas)*
2. `tests/test_familia_actas_lock_fase_4_6_5.typ` *(Test permanente autónomo de 6 páginas)*
3. `tests/corpus_actas_fase_4_6_5.typ` *(Corpus estructurado derivado para regresión)*
4. `dist/TEST_FAMILIA_ACTAS_LOCK_FASE_4_6_5.pdf` *(Golden master oficial de 6 páginas)*
5. `reportes/FASE_4_6_5_LOCK_FAMILIA_ACTAS.md` *(Informe técnico de Lock Parcial)*

*Nota:* No se incluyen en el commit los artefactos exploratorios de fases intermedias (`test_acta_asamblea_fase_4_6_1.typ`, renders PNG, etc.), manteniendo el repositorio limpio y reproducible.

---

## 11. DECLARACIÓN DE HARD STOP

En estricto apego a las directrices de la Fase 4.6.5:
- **NO se ha ejecutado `git add`, `git commit` ni `git push`.**
- **NO se han iniciado los trabajos de diseño para Convocatorias.**
- **NO se ha modificado la Carta de Adhesión ni el Aviso Jurídico.**
- **NO se ha diseñado la portadilla de apertura general de Anexos.**
- **NO se ha modificado la Tabla de Contenidos.**
- El sistema queda en pausa obligatoria a la espera de la autorización humana del reporte y la propuesta de commit.
