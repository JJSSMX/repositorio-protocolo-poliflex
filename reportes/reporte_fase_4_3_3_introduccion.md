# INFORME TÉCNICO EDITORIAL: FASE 4.3.3
## MICROAJUSTE FINAL DE `INTRODUCTION-PAGE()`
### Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

---

### 1. OBJETIVO Y DIRECTRIZ
Tomando la Fase 4.3.2 como baseline inalterada, se evaluó una **ÚNICA MODIFICACIÓN EXPERIMENTAL**:
- `content_dy` Fase 4.3.2 = **135.00 pt**
- `content_dy` Fase 4.3.3 = **126.00 pt**
- **Desplazamiento vertical:** Desplazar en bloque la totalidad de los 6 párrafos canónicos **-9.00 pt**.

Se mantuvieron **100% IDÉNTICOS E INALTERADOS**:
- Tipografía de título: Minion Pro Medium Display 15.9929 pt (dy = 85.00 pt).
- Regla horizontal acento: $x = 60.10\text{ pt}$, $y = 110.00\text{ pt}$, ancho $14.19\text{ pt}$, alto $0.902\text{ pt}$ (`#f15d22`).
- Claim institucional superior a 4 líneas y arcos concéntricos al 50%.
- Filete vertical continuo de lomo en $x = 30.13\text{ pt}$.
- Tipografía de cuerpo: Neuzeit Grotesk 7.9077 pt, leading Typst 12.72949 pt, separación 12.72949 pt, ancho útil 314.56 pt, `justify: true`, `hyphenate: false`, `par(linebreaks: "simple")`.
- Pie de página institucional y folio "05" en $y = 594.64\text{ pt}$.
- Componentes LOCKED de `templates/typst/componentes.typ`.

---

### 2. TABLA COMPARATIVA DE MÉTRICAS FORENSES (ESCALA 1:1)

| Cota Editorial | Fase 4.3.2 (`content_dy = 135 pt`) | Fase 4.3.3 (`content_dy = 126 pt`) | Variación ($\Delta$) |
| :--- | :---: | :---: | :---: |
| **Origen `content_dy`** | $135.00\text{ pt}$ | $126.00\text{ pt}$ | **-9.00 pt** |
| **Cima de regla naranja** | $110.00\text{ pt}$ | $110.00\text{ pt}$ | $0.00\text{ pt}$ (Invariable) |
| **Base de regla naranja** | $110.90\text{ pt}$ | $110.90\text{ pt}$ | $0.00\text{ pt}$ (Invariable) |
| **Distancia regla → 1ª línea (luz libre)** | **23.51 pt** | **14.51 pt** | **-9.00 pt** (Más compacta y armónica) |
| **Distancia regla → 1ª línea (cota top)** | **24.41 pt** | **15.41 pt** | **-9.00 pt** |
| **Inicio del cuerpo ($y_0$)** | **134.41 pt** | **125.41 pt** | **-9.00 pt** |
| **Final del cuerpo ($y_1$)** | **538.32 pt** | **529.32 pt** | **-9.00 pt** |
| **Aire inferior hasta baseline ($594.64\text{ pt}$)** | **56.32 pt** (4.43 líneas) | **65.32 pt** (5.13 líneas) | **+9.00 pt libres** (+16.0%) |
| **Aire inferior hasta cima del pie ($587.37\text{ pt}$)** | **49.05 pt** | **58.05 pt** | **+9.00 pt libres** (+18.3%) |
| **Líneas totales de cuerpo** | **23 líneas** | **23 líneas** | **0 líneas** (Distribución idéntica) |
| **Identidad de contenido textual** | **100% idéntico** | **100% idéntico** | **TRUE** (Texto íntegro) |

---

### 3. AUDITORÍA DETALLADA DE LAS PREGUNTAS CLAVE

#### A) Distancia regla naranja → primera línea
- **Fase 4.3.2:**
  - Cota top de regla ($110.00\text{ pt}$) a inicio texto ($134.41\text{ pt}$): **24.41 pt**.
  - Luz libre (base de regla $110.90\text{ pt}$ a inicio texto $134.41\text{ pt}$): **23.51 pt**.
- **Fase 4.3.3:**
  - Cota top de regla ($110.00\text{ pt}$) a inicio texto ($125.41\text{ pt}$): **15.41 pt**.
  - Luz libre (base de regla $110.90\text{ pt}$ a inicio texto $125.41\text{ pt}$): **14.51 pt**.
- **Evaluación Visual:** En Fase 4.3.2 la distancia entre la baseline del título ($95.4\text{ pt}$) y la regla ($110.0\text{ pt}$) era de $\approx 14.6\text{ pt}$, mientras que la luz entre la regla y el texto era de $23.51\text{ pt}$ (creando una separación ligeramente dilatada). Con el ajuste a **$14.51\text{ pt}$**, la regla naranja actúa como un nexo proporcional y perfectamente equilibrado entre el título y el cuerpo ($14.6\text{ pt} \leftrightarrow 14.5\text{ pt}$).

#### B) Inicio y final del cuerpo
- **Inicio del cuerpo:** Pasa de **$y_0 = 134.41\text{ pt}$** a **$y_0 = 125.41\text{ pt}$** ($\Delta = -9.00\text{ pt}$).
- **Final del cuerpo:** Pasa de **$y_1 = 538.32\text{ pt}$** a **$y_1 = 529.32\text{ pt}$** ($\Delta = -9.00\text{ pt}$).
- Las relaciones internas de interlineado ($12.72949\text{ pt}$) y separación entre párrafos ($12.72949\text{ pt}$) permanecen absolutamente idénticas.

#### C) Aire inferior resultante
- **Aire inferior libre (hasta baseline $594.64\text{ pt}$):** Aumenta de **$56.32\text{ pt}$** a **$65.32\text{ pt}$** (+9.00 pt).
  - En términos de ritmo editorial, la respiración inferior pasa de **4.43 líneas** a **5.13 líneas completas de ritmo vertical**.
- **Aire inferior libre (hasta cima de pie $587.37\text{ pt}$):** Aumenta de **$49.05\text{ pt}$** a **$58.05\text{ pt}$** (+9.00 pt).
- El pie institucional (isotipo, frase `PROTOCOLO FAMILIAR VERSION 1.0` y folio `05`) respira con notable dignidad ceremonial.

#### D) Número de líneas y preservación de párrafos
- **Líneas totales:** Exactamente **23 líneas** en ambas versiones.
- **Distribución por párrafo:**
  - Párrafo 1: 3 líneas
  - Párrafo 2: 6 líneas
  - Párrafo 3: 4 líneas
  - Párrafo 4: 4 líneas
  - Párrafo 5: 3 líneas
  - Párrafo 6: 3 líneas
  - **Total:** $3 + 6 + 4 + 4 + 3 + 3 = 23$ líneas.

#### E) Confirmación de contenido 100% idéntico
- **Texto canónico:** 305 palabras extraídas de `capitulos/00_introduccion.md`.
- **Comparación textual bit a bit:** **100% IDÉNTICO** (`texts_identical = True`).
- Ninguna palabra, carácter, espacio o signo ortográfico fue modificado.

---

### 4. INTEGRIDAD Y BLOQUEO DEL SISTEMA EDITORIAL

| Verificación de Integridad | Estado | Certificación |
| :--- | :---: | :--- |
| `chapter-first-page() modificado` | **FALSE** | Componente maestro intacto en `componentes.typ`. |
| `componentes.typ modificado` | **FALSE** | Exactamente 45,356 bytes, SHA-256 intacto. |
| `Markdown modificado` | **FALSE** | Los 14 archivos Markdown canónicos conservan su SHA-256 íntegro. |
| `componentes LOCKED modificados` | **FALSE** | `cover-page`, `table-of-contents`, `chapter-opening`, `interior-page` LOCKED. |
| `introduction-page()` | **EXPERIMENTAL / NOT LOCKED** | Implementado exclusivamente en `componentes_fase_4_experimental.typ`. |

---

### 5. ENTREGABLES GENERADOS

1. **Documento Editorial Principal:**
   - `dist/TEST_INTRODUCCION_FASE_4_3_3.pdf` (Página 4: Verso ceremonial en blanco + Página 5: Recto noble unitaria con `content_dy = 126 pt`).
2. **Lámina Comparativa Forense 1:1:**
   - `dist/TEST_INTRODUCCION_FASE_4_3_3_COMPARATIVO.pdf`:
     - **Página 1:** Lámina A3 horizontal a escala 1:1 comparando lado a lado Fase 4.3.2 (135 pt) vs. Fase 4.3.3 (126 pt).
     - **Página 2:** Pliego Spread 1:1 puro (792 × 612 pt) de Fase 4.3.3.
     - **Página 3:** Pliego Spread 1:1 puro (792 × 612 pt) de Fase 4.3.2.
3. **Renders en Alta Resolución (Artifacts):**
   - `intro_fase_4_3_3_recto.png` (300 DPI): Recto noble unitaria Fase 4.3.3.
   - `intro_fase_4_3_3_lamina_comparativa_a3.png` (200 DPI): Lámina comparativa A3.
   - `intro_fase_4_3_3_spread.png` (200 DPI): Pliego spread abierto Fase 4.3.3.

---

### 6. VEREDICTO EDITORIAL
El microajuste de **$content\_dy = 126.00\text{ pt}$** resulta **plenamente superior**:
1. Resuelve la dilatación visual entre la regla de acento y el cuerpo de texto, creando un ritmo constante ($14.6\text{ pt} \approx 14.5\text{ pt}$).
2. Otorga $+9.00\text{ pt}$ adicionales de respiración inferior, totalizando **$65.32\text{ pt}$ libres** ($5.13$ líneas de ritmo), lo cual eleva la solemnidad del pie institucional en la página noble.
