# INFORME FORENSE Y EVALUACIÓN TÉCNICA: FASE 4.5
**PROTOCOLO FAMILIAR POLIFLEX — PROTOTIPO DE SISTEMA NORMATIVO INTERIOR**

---

### ESTADO DEL SISTEMA EDITORIAL

```yaml
FASE: "4.5 — Prototipo de Sistema Normativo Interior"
FECHA_EVALUACION: "2026-09-27"
ESTADO_REGULATION_PAGE: "EXPERIMENTAL / NOT LOCKED"
VARIANTES_EVALUADAS: ["VARIANTE A", "VARIANTE B", "VARIANTE C"]
GANADOR_SELECCIONADO: "NINGUNO (Evaluación comparativa abierta a decisión humana)"
COMPONENTES_TYP_MODIFICADO: FALSE
CANONICAL_MARKDOWN_MODIFIED: FALSE
PREVIOUS_LOCKED_COMPONENTS_MODIFIED: FALSE
LOCKED_COMPONENTS_REGRESSION: PASS (126/126 páginas Capítulos 01–09 100% idénticas)
TOC_MODIFIED: FALSE
```

---

### 1. OBJETIVO Y ALCANCE

El objetivo exclusivo de la **Fase 4.5** consiste en diseñar, prototipar y evaluar experimentalmente la gramática tipográfica, la jerarquía visual y el comportamiento editorial del cuerpo interior de los tres Reglamentos:
1. `capitulos/11_reglamento_asamblea_familia.md`
2. `capitulos/12_reglamento_consejo_familia.md`
3. `capitulos/13_reglamento_comite_honor_familiar.md`

En estricto apego a las directrices:
- Se concibe `regulation-page()` como una **variante semántica de `interior-page()`**, compartiendo su geometría de página, retícula, márgenes, filete de lomo y folio, pero dotándola de una gramática jurídica propia.
- **NO** se modifica `templates/typst/componentes.typ`. Todo el desarrollo experimental reside en `templates/typst/componentes_fase_4_experimental.typ`.
- **NO** se realiza LOCK del componente.
- **NO** se selecciona automáticamente una variante ganadora.
- Se mantiene congelada la Tabla de Contenido (`table-of-contents()` en estado `UNLOCK AUTHORIZED / PENDING REDESIGN`).

---

### 2. MAPA TIPOGRÁFICO DE JERARQUÍAS NORMATIVAS (NIVELES R1 A R7)

Se estableció una matriz formal de 7 niveles jerárquicos normativos sin introducir niveles inexistentes ni alterar la estructura canónica:

| Nivel | Elemento Normativo | Función Editorial | Tratamiento Base |
| :--- | :--- | :--- | :--- |
| **R1** | **Running Header / Navegación** | Identidad del Reglamento en lectura corrida | Adaptación simétrica de `interior-page()` con paridad Recto/Verso e isotipo exterior |
| **R2** | **CAPÍTULO [ROMANO]** | División orgánica principal interna | Mayúsculas sostenidas, numeración romana literal, anclaje rígido |
| **R3** | **Subtítulo Temático** | Denominación temática del capítulo | Mayúsculas sostenidas, vinculado como bloque indivisible a R2 (`sticky: true`) |
| **R4** | **Artículo [N]. [Nombre]** | Encabezado normativo de articulado | Distinción clara del cuerpo, soporte para nombres extensos, indivisible de $\ge 2$ líneas |
| **R5** | **Párrafo Normativo** | Disposición jurídica ordinaria | *Neuzeit Grotesk Regular* $7.9077\text{ pt}$, justificado, ritmo vertical $12.72949\text{ pt}$ |
| **R6** | **Fracciones Romanas / Listas** | Incisos normativos ordenados | Hanging indent con numeral romano alineado a la derecha, preservando `I.`, `II.`, etc. |
| **R7** | **TRANSITORIO ÚNICO** | Cláusula de cierre y vigencia | Cláusula solemne de cierre, unida rígidamente a su texto normativo |

---

### 3. CORPUS CANÓNICO DE PRUEBA REAL

En cumplimiento del principio de **no usar texto simulado (lorem ipsum)**, se seleccionó un fragmento 100% contiguo y representativo de la fuente canónica:
- **Archivo fuente:** `capitulos/11_reglamento_asamblea_familia.md`
- **Líneas exactas:** Línea 76 a Línea 178 (103 líneas de texto canónico ininterrumpido).
- **Extensión:** 907 palabras.
- **Validación de cobertura de casos solicitados:**
  1. *CAPÍTULO con título corto:* `CAPÍTULO VI` `**DE LAS FACULTADES**` (Líneas 121–123).
  2. *CAPÍTULO con título largo:* `CAPÍTULO IV` `**INSTALACIÓN Y DESARROLLO DE LAS SESIONES**` (Líneas 76–78) y `CAPÍTULO VII` `**DE LAS ACTAS Y SEGUIMIENTO DE ACUERDOS**` (Líneas 133–135).
  3. *Artículo con nombre corto:* `Artículo 8. De las Facultades` (Línea 126).
  4. *Artículo con nombre largo:* `Artículo 11. De la Identificación de los Participantes` (Línea 164) y `Artículo 5. De la Instalación de la Asamblea` (Línea 81).
  5. *Artículo con múltiples fracciones:* `Artículo 7` (4 fracciones I–IV, Líneas 112–115) y `Artículo 9` (7 fracciones I–VII, Líneas 142–148).
  6. *Transición Artículo → Artículo:* `Artículo 5` $\to$ `Artículo 6`; `Artículo 10` $\to$ `Artículo 11` $\to$ `Artículo 12`.
  7. *Transición Artículo → nuevo CAPÍTULO:* `Artículo 6` $\to$ `CAPÍTULO V`; `Artículo 7` $\to$ `CAPÍTULO VI`; `Artículo 8` $\to$ `CAPÍTULO VII`; `Artículo 9` $\to$ `CAPÍTULO VIII`.
  8. *Páginas con flujo de continuación:* Flujo natural continuo verificado a través de las 4 páginas completas.
  9. *TRANSITORIO ÚNICO:* Líneas 175 a 178 completas con su párrafo de vigencia.

---

### 4. MATRIZ COMPARATIVA DE VARIANTES DISEÑADAS

Se prototiparon y compilaron tres variantes sobre exactamente el mismo contenido:

| Parámetro | VARIANTE A (Clásica Institucional) | VARIANTE B (Diferenciación Dinámica) | VARIANTE C (Soberanía Compacta) |
| :--- | :--- | :--- | :--- |
| **Concepto Visual** | Continuidad natural de `interior-page()` | Mayor acento jurídico y contraste híbrido | Monofamilia técnica de alta densidad |
| **R1: Running Header** | `REGLAMENTO · ASAMBLEA DE FAMILIA` (*Neuzeit* $5.5\text{ pt}$, $+0.200\text{ em}$, `#6c6b67`, $133.98\text{ pt}$) | `ASAMBLEA DE FAMILIA` (*Neuzeit Medium* $5.5\text{ pt}$, $+0.220\text{ em}$, `#2e2f31`, $79.09\text{ pt}$) | `REGLAMENTO DE LA ASAMBLEA...` (*Neuzeit* $5.0\text{ pt}$, $+0.180\text{ em}$, `#6c6b67`, $152.06\text{ pt}$) |
| **R2: CAPÍTULO** | *Minion Pro Medium* $10.5\text{ pt}$, tracking $+0.050\text{ em}$, stroke $0.3\text{ pt}$ `#f15d22` | *Minion Pro Medium* $11.0\text{ pt}$, tracking $+0.080\text{ em}$, con mini-pleca $14\text{ pt} \times 0.75\text{ pt}$ `#f15d22` | *Neuzeit Grotesk Bold* $8.8\text{ pt}$, tracking $+0.060\text{ em}$, `#f15d22` |
| **R2: Espacio antes** | $18.00\text{ pt}$ ($1.41 \times$ ritmo) | $20.00\text{ pt}$ ($1.57 \times$ ritmo) | $14.50\text{ pt}$ ($1.14 \times$ ritmo) |
| **R3: Subtítulo** | *Minion Pro Medium* $9.5\text{ pt}$, tracking $+0.020\text{ em}$, `#2e2f31` | *Neuzeit Grotesk Bold* $8.5\text{ pt}$, tracking $+0.040\text{ em}$, `#2e2f31` | *Neuzeit Grotesk Medium* $8.0\text{ pt}$, tracking $+0.030\text{ em}$, `#6c6b67` |
| **R3: Espacio después**| $12.73\text{ pt}$ ($1.00 \times$ ritmo) | $12.73\text{ pt}$ ($1.00 \times$ ritmo) | $9.50\text{ pt}$ ($0.75 \times$ ritmo) |
| **R4: Etiqueta Art.** | *Minion Pro Medium* $9.2\text{ pt}$ `#f15d22` (stroke $0.2\text{ pt}$) | *Neuzeit Grotesk Bold* $8.2\text{ pt}$ `#f15d22` ($+0.020\text{ em}$) | *Neuzeit Grotesk Bold* $8.0\text{ pt}$ `#2e2f31` (punto `#f15d22`) |
| **R4: Nombre Art.** | *Minion Pro Medium* $9.2\text{ pt}$ `#2e2f31` | *Minion Pro Bold Italic* $9.0\text{ pt}$ `#2e2f31` | *Neuzeit Grotesk Bold* $8.0\text{ pt}$ `#2e2f31` |
| **R4: Espaciados** | Superior $14.0\text{ pt}$ / Inferior $5.5\text{ pt}$ | Superior $15.0\text{ pt}$ / Inferior $6.0\text{ pt}$ | Superior $10.5\text{ pt}$ / Inferior $4.5\text{ pt}$ |
| **R5: Párrafo ordinario**| *Neuzeit* $7.9077\text{ pt}$, leading $12.73\text{ pt}$, spacing $12.73\text{ pt}$ | *Neuzeit* $7.9077\text{ pt}$, leading $12.73\text{ pt}$, spacing $12.73\text{ pt}$ | *Neuzeit* $7.9077\text{ pt}$, leading $12.73\text{ pt}$, spacing $10.50\text{ pt}$ |
| **R6: Fracciones** | Numeral *Neuzeit Medium* `#2e2f31`, col $14\text{ pt}$, sep $6.0\text{ pt}$ | Numeral *Minion Pro* $8.2\text{ pt}$ `#f15d22`, col $15\text{ pt}$, sep $6.36\text{ pt}$ | Numeral *Neuzeit Bold* `#6c6b67`, col $13\text{ pt}$, sep $4.5\text{ pt}$ |
| **R7: Transitorio** | *Minion Pro Medium* $10.0\text{ pt}$ `#f15d22` | *Minion Pro Medium* $10.5\text{ pt}$ `#f15d22` con pleca | *Neuzeit Grotesk Bold* $8.8\text{ pt}$ `#f15d22` |
| **Páginas Resultantes**| **4 páginas exactas** | **4 páginas exactas** | **4 páginas exactas** |

---

### 5. ANÁLISIS FORENSE DE FLUJO Y PAGINACIÓN

Las tres variantes fueron compiladas en un flujo estricto de **4 páginas** (Página 1 Recto, Página 2 Verso, Página 3 Recto, Página 4 Verso). El análisis detallado de ocupación y cortes revela hallazgos críticos:

```
Página 1 (RECTO)  ——>  Página 2 (VERSO)  ——>  Página 3 (RECTO)  ——>  Página 4 (VERSO)
```

#### Variante A (Clásica Institucional):
- **Página 1 (Recto):** 30 líneas de texto, ocupación vertical del **95.3%** ($453.6\text{ pt}$ / $476.0\text{ pt}$). Alberga `CAPÍTULO IV`, `Artículo 5` íntegro y el párrafo inicial del `Artículo 6`.
- **Página 2 (Verso):** 30 líneas de texto, ocupación vertical del **93.1%** ($443.0\text{ pt}$). Alberga la conclusión del `Artículo 6`, `CAPÍTULO V` con `Artículo 7` (y sus 4 fracciones), `CAPÍTULO VI` y el párrafo 1 del `Artículo 8`.
- **Página 3 (Recto):** 39 líneas de texto, ocupación vertical del **92.6%** ($440.8\text{ pt}$). Alberga la conclusión de `Artículo 8`, `CAPÍTULO VII` con `Artículo 9` (y sus 7 fracciones), `CAPÍTULO VIII` y `Artículo 10`.
- **Página 4 (Verso):** 19 líneas de texto, ocupación vertical del **52.1%** ($248.0\text{ pt}$). Alberga `Artículo 11`, `Artículo 12` y el `TRANSITORIO ÚNICO`. Deja un $47.9\%$ de aire inferior ceremonial perfecto para el final de un reglamento.
- **Huérfanas / Viudas:** **0 detectadas**. Cada bloque de capítulo y artículo se mantiene sólidamente agrupado.

#### Variante B (Diferenciación Jurídica Dinámica):
- **Página 1 (Recto):** 30 líneas de texto, ocupación vertical del **95.9%** ($456.7\text{ pt}$).
- **Página 2 (Verso):** 30 líneas de texto, ocupación vertical del **95.0%** ($452.1\text{ pt}$).
- **Página 3 (Recto):** 39 líneas de texto, ocupación vertical del **94.8%** ($451.1\text{ pt}$).
- **Página 4 (Verso):** 19 líneas de texto, ocupación vertical del **53.1%** ($252.6\text{ pt}$).
- **Comportamiento:** Cortes prácticamente idénticos a la Variante A gracias a su estricta sincronización con el ritmo de $12.72949\text{ pt}$. El dinamismo gráfico introducido por las mini-plecas de capítulo y los numerales romanos naranjas genera un contraste institucional muy legible y estructurado sin añadir páginas adicionales.

#### Variante C (Soberanía Normativa Compacta):
- **Página 1 (Recto):** 32 líneas de texto, ocupación vertical del **97.3%** ($463.0\text{ pt}$).
- **Página 2 (Verso):** 39 líneas de texto, ocupación vertical del **88.0%** ($418.7\text{ pt}$).
- **Página 3 (Recto):** 35 líneas de texto, ocupación vertical del **95.8%** ($456.1\text{ pt}$).
- **Página 4 (Verso):** 12 líneas de texto, ocupación vertical del **25.3%** ($120.4\text{ pt}$).
- **Comportamiento:** La compresión interparrafal ($10.5\text{ pt}$) y de cabeceras rompe la sincronía de página:
  1. En Página 1, el Artículo 6 queda cortado de forma abrupta a final de página (`...en el Protocolo Familiar. La`).
  2. En Página 4, se produce un desbalance severo: sólo quedan 12 líneas de texto, dejando el **74.7% de la página vacío**, lo cual visualmente desmerece la solemnidad del cierre reglamentario.

---

### 6. EVALUACIÓN EDITORIAL CENTRAL

> **¿SE PERCIBE EL REGLAMENTO COMO PARTE DEL MISMO LIBRO, PERO CON UNA GRAMÁTICA NORMATIVA PROPIA?**

**Conclusión afirmativa concluyente:**
1. **Pertenencia al mismo libro:**
   - La arquitectura exterior (caja útil de $314.56 \times 475.99\text{ pt}$ en Media Carta), el filete vertical de lomo en $0.5\text{ pt}$ `#f15d22`, el running header con la unidad institucional `PROTOCOLO FAMILIAR · VERSION 1.0` y el isotipo POLIFLEX al 50%, el folio inferior en Minion Pro Medium 8pt `#f15d22`, y la tipografía de cuerpo en *Neuzeit Grotesk Regular* $7.9077\text{ pt}$ a $12.72949\text{ pt}$ de leading garantizan una continuidad táctil, visual y tipográfica total con los Capítulos 01–09.
2. **Gramática normativa propia:**
   - Mientras los Capítulos 01–09 articulan una narrativa conceptual por cláusulas y secciones descriptivas (`1.5 Legitimidad del Protocolo...`), los Reglamentos introducen una estructura orgánica codificada:
     - Distinción entre la división capitular romana (`CAPÍTULO IV`) y el articulado legal directo (`Artículo 5.`).
     - Claridad técnica en las fracciones romanas (`I.`, `II.`, `III.`) con sangría francesa precisa.
     - Identificación unívoca del órgano en el running header (`ASAMBLEA DE FAMILIA`), evitando la numeración corrida errónea de capítulo (`CAPÍTULO 11`).
     - Cláusula de cierre solemne (`TRANSITORIO ÚNICO`).

---

### 7. INTEGRIDAD Y AUDITORÍA DE NO REGRESIÓN

- **Fuentes Canónicas Markdown (`capitulos/*.md`):** 15/15 archivos 100% íntegros e inalterados.
- **Archivo Matriz [componentes.typ](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ):**
  - Tamaño: 54,780 bytes.
  - Hash SHA-256: `DF123879AA8AFDF3ECEE7333FD31CC624401935CFC2349436A39594EE8CC9F2B`.
  - Estado: **MODIFICADO = FALSE (PASS)**.
- **Auditoría de No Regresión Capítulos 01–09:**
  - Archivo de prueba: `tests/test_protocolo_capitulos_01_09_fase_3_9_3.typ`.
  - Salida: `dist/TEST_NON_REGRESSION_4_5.pdf` (126 páginas).
  - Resultado: **126/126 páginas exactamente idénticas** a la baseline consolidada. **Cero regresiones**.
- **Componentes LOCKED:**
  - `cover-page()` = INTACTO
  - `chapter-opening()` = INTACTO
  - `chapter-first-page()` = INTACTO
  - `interior-page()` = INTACTO
  - `introduction-page()` = INTACTO
  - `regulation-opening()` = INTACTO
- **Tabla de Contenido:**
  - `table-of-contents()` = INTACTO (`UNLOCK AUTHORIZED / PENDING REDESIGN`).

---

### 8. ÍNDICE DE ENTREGABLES Y ARTEFACTOS

#### Archivos de Producción Experimental y Pruebas:
- [componentes_fase_4_experimental.typ](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes_fase_4_experimental.typ) — Infraestructura experimental de `regulation-page()` y helpers.
- [corpus_fase_4_5.typ](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/corpus_fase_4_5.typ) — Corpus canónico de prueba (Líneas 76–178 de Reglamento 11).
- [test_regulation_page_fase_4_5_a.typ](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_regulation_page_fase_4_5_a.typ) — Archivo de prueba Variante A.
- [test_regulation_page_fase_4_5_b.typ](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_regulation_page_fase_4_5_b.typ) — Archivo de prueba Variante B.
- [test_regulation_page_fase_4_5_c.typ](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_regulation_page_fase_4_5_c.typ) — Archivo de prueba Variante C.
- [test_regulation_page_fase_4_5_comparativo.typ](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_regulation_page_fase_4_5_comparativo.typ) — Archivo comparativo multipágina integral.

#### Documentos PDF Compilados:
- [TEST_REGULATION_PAGE_FASE_4_5_A.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_A.pdf) (4 páginas, 42.1 KB)
- [TEST_REGULATION_PAGE_FASE_4_5_B.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_B.pdf) (4 páginas, 43.5 KB)
- [TEST_REGULATION_PAGE_FASE_4_5_C.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_C.pdf) (4 páginas, 37.2 KB)
- [TEST_REGULATION_PAGE_FASE_4_5_COMPARATIVO.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_COMPARATIVO.pdf) (12 páginas, 95.5 KB)

#### Datos y Métricas:
- [fase_4_5_metricas_regulation_page.json](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/datos/fase_4_5_metricas_regulation_page.json) — Archivo JSON formal con todas las mediciones y coordenadas.

#### Renders de Evaluación Visual:
- **Lámina Comparativa General 4-Way (Escala 1:1):**
  - [Lámina Comparativa 4-Way](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/lamina_comparativa_fase_4_5_4way.png) — Muestra simultánea de `interior-page() LOCKED` vs Variantes A, B y C.
- **Spreads de Lectura Enfrentada (P2 Verso + P3 Recto):**
  - [Spread Variante A](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/spread_fase_4_5_var_a.png)
  - [Spread Variante B](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/spread_fase_4_5_var_b.png)
  - [Spread Variante C](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/spread_fase_4_5_var_c.png)
- **Páginas Individuales a 300 DPI (Variante A):**
  - [Página 1 (Recto)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_a_p1.png) | [Página 2 (Verso)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_a_p2.png) | [Página 3 (Recto)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_a_p3.png) | [Página 4 (Verso)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_a_p4.png)
- **Páginas Individuales a 300 DPI (Variante B):**
  - [Página 1 (Recto)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_b_p1.png) | [Página 2 (Verso)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_b_p2.png) | [Página 3 (Recto)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_b_p3.png) | [Página 4 (Verso)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_b_p4.png)
- **Páginas Individuales a 300 DPI (Variante C):**
  - [Página 1 (Recto)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_c_p1.png) | [Página 2 (Verso)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_c_p2.png) | [Página 3 (Recto)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_c_p3.png) | [Página 4 (Verso)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_var_c_p4.png)

---

> [!IMPORTANT]
> **ESTADO DE DETENCIÓN FORMAL (HARD STOP)**
> La Fase 4.5 ha finalizado exitosamente su ciclo de diseño, prototipado y evaluación métrica.
> El componente `regulation-page()` permanece en estado **EXPERIMENTAL / NOT LOCKED** dentro de `componentes_fase_4_experimental.typ`.
> No se ha seleccionado automáticamente ninguna variante ni se han modificado componentes locked ni fuentes canónicas.
> En espera de la evaluación humana de las láminas comparativas para determinar la dirección definitiva.
