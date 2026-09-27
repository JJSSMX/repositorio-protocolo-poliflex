# INFORME TÉCNICO DE PROTOTIPOS EDITORIALES: INTRODUCCIÓN — FASE 4.3

**Fecha:** Septiembre 2026  
**Proyecto:** Protocolo Familiar POLIFLEX  
**Fase:** 4.3 — Prototipo Editorial de Introducción  
**Decisión Adoptada:** Alternativa A (Página Noble Unitaria en RECTO)  
**Estado de Componente:** `introduction-page()` = `EXPERIMENTAL / NOT LOCKED`  

---

## 1. Alcance y Protección de Baseline

En estricto apego a las directrices de la Fase 4.3:

- **Trabajo Exclusivo:** Se prototipó única y exclusivamente la Introducción a partir de `capitulos/00_introduccion.md`.
- **Preservación Textual (100%):** Se conservaron íntegras las 305 palabras y los 6 párrafos de la fuente canónica sin omisiones, adiciones ni alteraciones.
- **Componentes Bloqueados:** `cover-page()`, `chapter-opening()`, `chapter-first-page()` e `interior-page()` permanecen `APPROVED / LOCKED` sin alteración.
- **Tabla de Contenido:** `table-of-contents()` permanece en estado `UNLOCK AUTHORIZED / PENDING REDESIGN` (no fue modificada en esta fase).
- **Aislamiento Técnico:** El nuevo componente experimental `introduction-page()` se programó exclusivamente en [`templates/typst/componentes_fase_4_experimental.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes_fase_4_experimental.typ), preservando intacto `templates/typst/componentes.typ`.

## 2. Entregables Generados

- [`dist/TEST_INTRODUCCION_FASE_4_3_A.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTRODUCCION_FASE_4_3_A.pdf) (Variante A: Sobria / Baseline)
- [`dist/TEST_INTRODUCCION_FASE_4_3_B.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTRODUCCION_FASE_4_3_B.pdf) (Variante B: Respiración Ceremonial Calibrada)
- [`dist/TEST_INTRODUCCION_FASE_4_3_C.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTRODUCCION_FASE_4_3_C.pdf) (Variante C: Identidad Asimétrica POLIFLEX)
- [`dist/TEST_INTRODUCCION_FASE_4_3_COMPARATIVO.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTRODUCCION_FASE_4_3_COMPARATIVO.pdf) (Lámina comparativa A3 a escala 1:1 + Spreads completos)

## 3. Matriz Comparativa Detallada de las Tres Variantes

| Parámetro Editorial | VARIANTE A (Sobria / Baseline) | VARIANTE B (Respiración Ceremonial) | VARIANTE C (Asimétrica POLIFLEX) |
| :--- | :--- | :--- | :--- |
| **Filosofía de Diseño** | Continuidad directa con la retícula aprobada de capítulos. | Mayor pausa y solemnidad; caja de lectura concentrada. | Contemporánea, dinámica y estructurada; estilo carta/tratado. |
| **Posición Inicial del Título** | `y = 78.00 pt` | `y = 75.00 pt` | `y = 72.00 pt` |
| **Tipografía del Título** | Minion Pro Medium Display (15.99 pt, tracking 0.019 em) | Minion Pro Medium (16.50 pt, tracking 0.080 em) | Minion Pro Medium (16.50 pt, tracking 0.025 em) |
| **Elementos Gráficos del Título** | Cintillo superior naranja (`5.5 pt`) + Filete inferior (`20 pt × 0.9 pt`) | Filete horizontal naranja sobrio (`16 pt × 0.9 pt`) | Barra vertical naranja (`2 pt × 38 pt`) + Cintillos dobles |
| **Posición Inicial del Cuerpo** | `y = 140.00 pt` | `y = 130.00 pt` | `y = 142.00 pt` |
| **Posición Final del Cuerpo** | `y = 543.32 pt` | `y = 552.50 pt` | `y = 549.72 pt` |
| **Altura Total del Contenido** | `465.73 pt` | `478.75 pt` | `478.10 pt` |
| **Aire Libre antes de Folio (594 pt)** | **`51.32 pt`** | **`42.14 pt`** | **`44.92 pt`** |
| **Ancho de Caja Útil** | `314.56 pt` (Lomo 58.74 pt / Corte 22.70 pt) | `304.56 pt` (Lomo 63.74 pt / Corte 27.70 pt) | `314.56 pt` (Lomo 58.74 pt / Corte 22.70 pt) |
| **Tipografía del Cuerpo** | Neuzeit Grotesk (7.9077 pt) | Neuzeit Grotesk (Lead 8.2 pt; Resto 7.9077 pt) | Neuzeit Grotesk (7.9077 pt) |
| **Interlínea (Leading)** | `12.7295 pt` (Estricta baseline) | `13.50 pt` (Lead) / `12.80 pt` (Resto) | `12.7295 pt` |
| **Separación entre Párrafos** | `12.7295 pt` (Línea en blanco) | `8.50 pt` | `5.50 pt` + Sangría clásica de 14 pt en P2–P6 |
| **Colofón de Cierre** | No (cierre con párrafo 6) | No (cierre con párrafo 6) | Sí (`Coatepec, Veracruz · Agosto 2026`) |
| **Pie de Página (Folio)** | Folio naranja `5` + Frase `PROTOCOLO FAMILIAR · VERSION 1.0` | Folio gris sobrio `5` + Frase `FAMILIA VELASCO CHEDRAUI` | Folio naranja `5` + Frase `PROTOCOLO FAMILIAR` |

## 4. Análisis Crítico Descriptivo (Sin Declaración de Ganador)

### Variante A: Disciplina y Ortodoxia de Baseline
- **Fortalezas:** Mantiene una afinidad total con el sistema de lectura de los capítulos 01–09. El interlineado idéntico y el ancho de caja estándar de 314.56 pt garantizan que el ojo del lector no perciba ningún salto de ritmo técnico al avanzar al Capítulo 01. Los 51.32 pt de aire libre al pie brindan un reposo impecable.
- **Observación:** Al ser idéntica en espaciados a una página interior, su carácter solemne recae primordialmente en el encabezado noble.

### Variante B: Nobleza y Solemnidad de Proemio
- **Fortalezas:** Al recoger los márgenes en 10 pt por lado (caja de 304.56 pt) y jerarquizar el primer párrafo a 8.2 pt con interlínea de 13.5 pt, adquiere un aire inequívoco de manifiesto fundacional. El espaciado de 8.5 pt entre párrafos compacta elegantemente la lectura y deja 42.14 pt de aire libre al pie, sin saturar ni cortar jamás una sola línea.
- **Observación:** Se percibe más exclusiva y ceremonial que una página ordinaria de articulado.

### Variante C: Identidad Corporativa Contemporánea
- **Fortalezas:** La barra de acento vertical naranja de 2 pt evoca de inmediato el rigor institucional de POLIFLEX. La sangría de primera línea en los párrafos 2 al 6 aporta una cadencia clásica de acta o declaración formal, mientras que el colofón final ubica temporal y geográficamente el acuerdo en Coatepec.
- **Observación:** Posee una personalidad gráfica más activa y corporativa que las dos anteriores.

## 5. Garantía de Integridad y Verificación de No-Regresión

- `capitulos/00_introduccion.md` modificado: **`FALSE`**
- `capitulos/01–09` modificados: **`FALSE`**
- `capitulos/10–13` modificados: **`FALSE`**
- `templates/typst/componentes.typ` modificado: **`FALSE`**
- `table-of-contents()` modificado: **`FALSE`**
- Estado de `introduction-page()`: **`EXPERIMENTAL / NOT LOCKED`**
