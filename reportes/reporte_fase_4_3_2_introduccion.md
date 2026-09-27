# INFORME TÉCNICO EDITORIAL: FASE 4.3.2
## PROTOTIPO DE INTRODUCCIÓN BASADA EN CHAPTER-FIRST-PAGE()
### Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

---

### 1. OBJETIVO Y DIRECTRIZ
Se descartó la dirección visual experimental anterior de `introduction-page()` (Variantes A, B y C de la Fase 4.3) y se implementó una nueva solución basada directamente y sin reinterpretaciones en el lenguaje editorial formalmente **APROBADO** de `chapter-first-page()`, asegurando que la Introducción pertenezca orgánicamente a la misma familia gráfica de los Capítulos 01–09:

$$\text{introduction-page()} = \text{chapter-first-page() SIN número de capítulo, SIN etiqueta CAPÍTULO}$$

---

### 2. PARÁMETROS HEREDADOS LITERALMENTE
El componente experimental `introduction-page()` hereda exactamente de la baseline oficial consolidada (Fase 3.9.3) y del componente `chapter-first-page()` / `interior-page()`:

1. **Geometría de Página:** 396 × 612 pt (Media Carta / 139.7 × 215.9 mm).
2. **Retícula y Márgenes:**
   - Margen interior (lomo): 58.74 pt.
   - Margen exterior (corte): 22.70 pt.
   - Ancho de caja útil: 314.56 pt.
3. **Filete Vertical de Lomo:** Línea vertical continua en $x = 30.13\text{ pt}$, trazo 0.40 pt, color `#cbd5e1`.
4. **Arcos Superiores Concentricos:** SVG vectorial institucional en esquina superior derecha con opacidad al 50%.
5. **Claim Institucional Superior:**
   - Texto a 4 líneas:
     ```
     UN LEGADO
     QUE TRASCIENDE,
     UN FUTURO QUE
     CONSTRUIMOS JUNTOS.
     ```
   - Tipografía: Neuzeit Grotesk regular, tracking 0.371 em, baselines en $y \in \{28.93, 36.93, 44.93, 52.93\}\text{ pt}$.
   - Colores: `#6c6b67` (gris) y `#f15e22` ("JUNTOS.").
6. **Tipografía de Título:**
   - Fuente: *Minion Pro Medium Display*.
   - Tamaño: 15.9929 pt.
   - Color: `#2e2f31`.
   - Tracking: 0.019 em.
   - Alineación: Izquierda en $x = 58.34\text{ pt}$.
7. **Regla Decorativa Horizontal Institucional:**
   - Posición: $x = 60.10\text{ pt}$.
   - Ancho: 14.19 pt, Alto: 0.902 pt.
   - Color: `#f15d22` (naranja institucional).
8. **Sistema de Cuerpo de Texto:**
   - Tipografía: *Neuzeit Grotesk Regular*.
   - Tamaño: 7.9077 pt.
   - Leading Typst: 12.72949 pt.
   - Color: `#2e2f31`.
   - Tracking: 0 em.
   - Justificación: `justify: true`.
   - Sangría: Sin sangría (`first-line-indent: 0pt`).
   - Separación de párrafos: 12.72949 pt (`spacing: 12.72949pt`).
   - Control de saltos: `hyphenate: false`, `par(linebreaks: "simple")`.
9. **Pie de Página Institucional y Folio:**
   - Folio en corte exterior: Minion Pro Medium Display 10 pt, color `#f15d22`, numeral "05" en $x = 373.30\text{ pt}$, baseline en $y = 594.64\text{ pt}$.
   - Frase institucional: `PROTOCOLO FAMILIAR` en Neuzeit Grotesk 4.8234 pt, color `#6c6b67`, tracking 0.200 em en $x = 80.09\text{ pt}$.
   - Versión institucional: `VERSION 1.0` en Neuzeit Grotesk 4.8234 pt, color `#f15e22` en $x = 157.02\text{ pt}$.
   - Isotipo institucional: SVG vectorial al 50% de opacidad en $x = 55.84\text{ pt}$, $y = 582.95\text{ pt}$.

---

### 3. ELEMENTOS EXCLUSIVAMENTE SUPRIMIDOS
En estricto cumplimiento de las instrucciones de la Fase 4.3.2, se eliminaron exclusivamente:
1. **Número grande de capítulo:** Se suprimió la cifra de 39.37 pt en Minion Pro (la cual en los capítulos se ubicaba en $dy = 82.45\text{ pt}$).
2. **Etiqueta de capítulo:** Se eliminó cualquier referencia a "CAPÍTULO 00", "00" o numeración ficticia (la Introducción es un proemio no numerado).
3. **Subtítulos y cintillos ajenos:** Se eliminaron las propuestas de la Fase 4.3 como "PROTOCOLO FAMILIAR · PREÁMBULO", "ACUERDO INSTITUCIONAL FAMILIAR–EMPRESARIAL" o fechas/lugares.

---

### 4. MÉTRICAS VERTICALES DE CALIBRACIÓN EDITORIAL
La ausencia del número de capítulo de 39.37 pt permitió ascender naturalmente el título `INTRODUCCIÓN` y la regla horizontal, alojando la totalidad de los 6 párrafos canónicos en una **Página Noble Unitaria** sin compresión artificial de interlineado:

| Parámetro Editorial | Cota / Valor Extraído | Referencia Baseline |
| :--- | :--- | :--- |
| **Posición Y de INTRODUCCIÓN** | $y_0 = 83.78\text{ pt}, y_1 = 99.78\text{ pt}$ | $dy = 85.00\text{ pt}$ (ascent 10.41 pt, baseline $\approx 95.4\text{ pt}$) |
| **Posición Y de regla horizontal** | $y = 110.00\text{ pt}$ | $x = 60.10\text{ pt}, w = 14.19\text{ pt}, h = 0.902\text{ pt}$ |
| **Posición inicial del cuerpo** | $y_0 = 134.41\text{ pt}$ | `content_dy = 135.00 pt` |
| **Posición final del cuerpo** | $y_1 = 538.32\text{ pt}$ | Fin de línea 23 del Párrafo 6 |
| **Número total de líneas** | **23 líneas exactas** | 6 párrafos canónicos: $3 + 6 + 4 + 4 + 3 + 3 = 23$ líneas |
| **Palabras canónicas integradas** | **305 palabras** (100% de `00_introduccion.md`) | 6 párrafos canónicos íntegros |
| **Baseline del pie institucional** | $y = 594.64\text{ pt}$ | Baseline de folio y textos de pie |
| **Aire inferior resultante** | **56.32 pt libres** | Equivalente a **4.43 líneas** de ritmo vertical |
| **Aire libre hasta cima del pie** | **49.05 pt libres** | Holgura limpia y holgada |

---

### 5. INTEGRIDAD Y BLOQUEO DEL SISTEMA EDITORIAL

| Verificación de Integridad | Estado | Razón / Certificación |
| :--- | :---: | :--- |
| `chapter-first-page() modificado` | **FALSE** | Componente maestro intacto en `componentes.typ`. |
| `componentes.typ modificado` | **FALSE** | Exactamente 45,356 bytes, SHA-256 idéntico a Fase 3.9.3. |
| `Markdown modificado` | **FALSE** | Los 14 archivos Markdown canónicos conservan su SHA-256 íntegro. |
| `componentes LOCKED modificados` | **FALSE** | `cover-page`, `table-of-contents`, `chapter-opening`, `interior-page` LOCKED. |
| `introduction-page()` | **EXPERIMENTAL / NOT LOCKED** | Implementado exclusivamente en `componentes_fase_4_experimental.typ`. |

---

### 6. ENTREGABLES GENERADOS

1. **Documento Editorial Principal:**
   - `dist/TEST_INTRODUCCION_FASE_4_3_2_CHAPTER_STYLE.pdf` (2 páginas: Página 4 Verso en blanco ceremonial + Página 5 Recto noble unitaria).
2. **Lámina Comparativa Forense 1:1:**
   - `dist/TEST_INTRODUCCION_FASE_4_3_2_COMPARATIVO.pdf`:
     - **Página 1:** Lámina A3 horizontal a escala 1:1 comparando lado a lado `chapter-first-page()` de Capítulo 01 vs. `introduction-page()`.
     - **Página 2:** Pliego Spread 1:1 puro (792 × 612 pt) de Introducción (Verso ceremonial p. 4 + Recto p. 5).
     - **Página 3:** Pliego Spread 1:1 puro (792 × 612 pt) de Capítulo 01 (Verso ceremonial p. 4 + Recto p. 5).
3. **Renders en Alta Resolución (Artifacts):**
   - `intro_fase_4_3_2_recto.png` (300 DPI): Recto noble unitaria.
   - `intro_fase_4_3_2_lamina_comparativa_a3.png` (200 DPI): Lámina comparativa A3.
   - `intro_fase_4_3_2_spread.png` (200 DPI): Pliego spread abierto.

---

### 7. CONCLUSIÓN TÉCNICA
El prototipo Fase 4.3.2 demuestra de manera concluyente que la Introducción no requiere un lenguaje gráfico alternativo ni una tipometría experimental compactada. Al heredar directamente el sistema de `chapter-first-page()` y reutilizar la infraestructura de `interior-page()`, los 6 párrafos canónicos (305 palabras, 23 líneas) se alojan con perfecta fluidez en una **Página Noble Unitaria en Recto**, dejando **56.32 pt** de aire inferior libre antes del pie institucional.

La solución garantiza 100% de coherencia visual, jerárquica y ceremonial con el resto de la obra.
