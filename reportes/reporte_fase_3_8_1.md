# REPORTE FORENSE DE CALIBRACIÓN EDITORIAL — FASE 3.8.1
## Alineación Inferior de Chapter-First-Page y Respiración Vertical entre Unidades Temáticas (+18 pt)
**Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)**  
**Documento Principal:** `dist/TEST_CAPITULOS_01_03_FASE_3_8_1.pdf` (61 páginas, 949.4 KB)  
**Pliegos Enfrentados:** `dist/TEST_CAPITULOS_01_03_FASE_3_8_1_SPREADS.pdf` (31 pliegos, 880.5 KB)  
**Pruebas Diagnósticas:**  
- `dist/TEST_CHAPTER_FIRST_PAGE_FOOTER_ALIGNMENT.pdf` (Comparativa vectorial con líneas guía de baseline)  
- `dist/TEST_TOPIC_SPACING_BEFORE_AFTER.pdf` (4 láminas A3 comparativas Antes vs Después)  
**Fecha de Auditoría:** 2026-09-26  
**Compilador Maestro:** `scripts/compilar_fase_3_8_1.py`  

---

## 1. Resumen Ejecutivo

La **Fase 3.8.1** abordó con precisión matemática dos requerimientos editoriales derivados de la inspección visual directa sobre la prueba completa de capítulos:

1. **Unificación de la Franja Inferior en `chapter-first-page()`:** Se corrigió el desfase vertical de la franja inferior (folio exterior, isotipo institucional POLIFLEX y textos `"PROTOCOLO FAMILIAR"` / `"VERSION 1.0"`). Se eliminó la discrepancia vertical de **+5.0535 pt (+1.78 mm)** respecto al folio de `interior-page()`, alcanzando una **discrepancia final de exactamente 0.000 pt** (ambos en la cota `y = 591.708 pt`).
2. **Respiración Temática Consistente (+18.00 pt):** Se incorporó una separación vertical adicional de **+18.00 pt** (equivalente a 1 línea de ritmo vertical de interlínea) antes de cada nueva unidad temática (Secciones H2, Subsecciones H3 y Sub-subsecciones H4), dotando al texto de una clara respiración óptica sin afectar el espacio descendente (*heading $\rightarrow$ body*).
3. **Colapso en Tope de Página y Protección Keep-with-Next:** Se verificó que el espacio *space-before* colapsa automáticamente a 0 pt cuando un heading encabeza página, manteniendo el margen superior consolidado de 71.01 pt (+6 mm) inalterado. La protección contra orfandad mantuvo **0 encabezados huérfanos** en todo el documento.
4. **Paginación Natural y Adaptación Ceremonial:** La inclusión de la respiración temática expandió naturalmente el documento de **56 a 61 páginas**, sin compresión artificial. La secuencia ceremonial de apertura se adaptó limpiamente para que **todas las portadas y primeras páginas de capítulo caigan estrictamente en páginas RECTO**, precedidas de su respectiva página ceremonial blanca en VERSO.
5. **Preservación Canónica Absoluta:** Los archivos canónicos `/capitulos/*.md` y las plantillas bloqueadas no sufrieron alteración alguna (SHA-256 verificado al 100%).

---

## 2. Estado de Gobernanza de Componentes

| Componente | Estado de Gobernanza | Observaciones |
|---|:---:|---|
| `cover-page()` | **APPROVED / LOCKED** | Portada institucional general. Código intacto. |
| `table-of-contents()` | **APPROVED / LOCKED** | Sumario editorial. Código intacto. |
| `chapter-opening()` | **APPROVED / LOCKED** | Portada ceremonial de capítulo (fondo crema, retícula, monograma, texto nativo sin comillas). Intacto. |
| `chapter-first-page()` | **PENDING FINAL REVIEW** | Primera página de capítulo con claim institucional superior (fijo en `y = 29.00 pt`), arcos concéntricos al 50%, número display grande (+17.01 pt), título de capítulo y **franja inferior unificada a `y = 591.708 pt`**. Retícula +6 mm congelada. |
| `interior-page()` | **PENDING FINAL REVIEW** | Páginas de contenido con running header y folio exterior en `y = 591.708 pt`. Retícula vertical +6 mm congelada. |

---

## 3. Parte A — Auditoría Forense de la Franja Inferior (`chapter-first-page`)

### 3.1 Diagnóstico Matemático y Causa Raíz
Mediante inspección vectorial con PyMuPDF sobre los bloques y tramos de texto (*spans*), se detectó que el folio en `chapter-first-page()` se situaba en una coordenada $y$ más baja que en `interior-page()`:
- **`interior-page()` (Páginas 06, 07, 08, etc.):**
  - Folio baseline: **`y = 591.708 pt`**
  - Folio Bounding Box: `y0 = 585.892 pt`, `y1 = 593.892 pt`
- **`chapter-first-page()` Estado Anterior (Páginas 05, 13, 45):**
  - Folio baseline: **`y = 596.761 pt`**
  - Folio Bounding Box: `y0 = 590.945 pt`, `y1 = 598.945 pt`
  - **Discrepancia detectada:** **`+5.0535 pt`** (+1.78 mm más abajo).

**Causa Raíz:** En `interior-page()`, el footer solo contiene el folio de 8 pt alineado con `#v(20pt)`. En `chapter-first-page()`, el footer contiene una cuadrícula de dos columnas `#grid(align: horizon)` que aloja en la columna izquierda el isotipo vectorial institucional (`width: 15.5740pt, height: 15.3150pt`) y el texto institucional de 4.82 pt. La altura total de la fila aumentó a ~18.38 pt, y la alineación `horizon` centró el folio de 8 pt en esa altura, empujándolo hacia abajo en **5.0535 pt**.

### 3.2 Solución Matemática Implementada
Para neutralizar con precisión absoluta el empuje de la cuadrícula, se compensó el espaciado superior en el pie de página de `chapter-first-page()`:
$$\Delta y_{\text{compensación}} = 20.0000\text{ pt} - 5.0535\text{ pt} = 14.9465\text{ pt}$$

Al aplicar `#v(20pt - 5.0535pt)` en `scripts/compilar_fase_3_8_1.py`:
- La cuadrícula completa (folio, textos institucionales e isotipo) asciende solidariamente **5.0535 pt**.
- El folio de `chapter-first-page()` se ubica exactamente en **`y = 591.708 pt`**.

### 3.3 Tabla Comparativa de Coordenadas Verticales

| Elemento | Estado Anterior (Fase 3.8) | Estado Corregido (Fase 3.8.1) | Referencia `interior-page()` | Discrepancia Final |
|---|:---:|:---:|:---:|:---:|
| **Folio Baseline ($y$)** | `596.761 pt` | **`591.708 pt`** | **`591.708 pt`** | **`0.000 pt` (0.00 mm)** |
| **Folio Bbox Top ($y_0$)** | `590.945 pt` | **`585.892 pt`** | `585.892 pt` | **`0.000 pt`** |
| **Folio Bbox Bottom ($y_1$)** | `598.945 pt` | **`593.892 pt`** | `593.892 pt` | **`0.000 pt`** |
| **Texto Institucional Baseline** | `598.753 pt` | **`593.700 pt`** | N/A (Solo First Page) | Desplazado $-5.05\text{ pt}$ |
| **Isotipo Bbox ($y_0, y_1$)** | `586.50, 601.82 pt` | **`581.45, 596.77 pt`** | N/A (Solo First Page) | Desplazado $-5.05\text{ pt}$ |

### 3.4 Evidencia Diagnóstica Generada
Se generó el documento vectorial **`dist/TEST_CHAPTER_FIRST_PAGE_FOOTER_ALIGNMENT.pdf`** (renderizado en alta resolución en `test_footer_alignment_preview.png`), el cual incluye:
- Comparación visual lado a lado: **ANTES (+0 pt de compensación)** vs **DESPUÉS (-5.05 pt de compensación)**.
- **Línea verde densamente punteada:** Línea base canónica aprobada de `interior-page()` ($y = 591.71\text{ pt}$).
- **Línea roja discontinua:** Línea base anterior de `chapter-first-page()` ($y = 596.76\text{ pt}$).
- Demostración gráfica de la coincidencia exacta de la línea verde con la base del número "05" en el estado corregido.

---

## 4. Parte B — Auditoría Forense de Respiración Temática (+18 pt)

### 4.1 Reglas de Espaciado Aplicadas
Para dar solución a la proximidad excesiva entre el final de una sección o cláusula y el comienzo de la siguiente unidad temática, se añadieron **+18.00 pt** al parámetro `above` de los encabezados, manteniendo estrictamente intacto el parámetro `below` (*heading $\rightarrow$ body*):

| Nivel Jerárquico | Elemento | Espacio Anterior (`above`) | Espacio Corregido (`above`) | Incremento | Espacio Descendente (`below`) |
|---|---|:---:|:---:|:---:|:---:|
| **H2** | Sección Principal | `18.35 pt` | **`36.35 pt`** | $+18.00\text{ pt}$ | `15.42 pt` (Intacto) |
| **H3** | Subsección | `14.00 pt` | **`32.00 pt`** | $+18.00\text{ pt}$ | `10.00 pt` (Intacto) |
| **H4** | Sub-subsección | `10.00 pt` | **`28.00 pt`** | $+18.00\text{ pt}$ | `8.00 pt` (Intacto) |

### 4.2 Comportamiento de Colapso en Inicio de Página
- **Páginas Interiores:** El motor de Typst colapsa de forma nativa el margen superior de un bloque (`above`) cuando éste se posiciona al comienzo del flujo de una página. El contenido superior se inicia estrictamente en la cota superior aprobada de la retícula vertical:
  $$y_{\text{top}} = 54.00\text{ pt} + 17.0079\text{ pt} = \mathbf{71.0079\text{ pt}}$$
  No se produce ningún desvío ni descenso involuntario del tope de caja tipográfica.
- **Primera Página de Capítulo (`chapter-first-page`):** La separación vertical `#v(177.80pt)` (o compensada según el número de líneas del título) absorbe y gobierna el inicio del primer encabezado mediante `calc.max(v_spacing, above)`. La distancia entre el título del capítulo y la sección inicial (ej. `1.1`, `2.1`, `3.1`) se mantiene idéntica a la consolidada en la Fase 3.7.3.

### 4.3 Protección Keep-with-Next y Detección de Orfandad
Cada nivel de encabezado está encapsulado en un bloque indivisible y adherente:
```typst
#show heading.where(level: 2): it => block(width: 100%, breakable: false, sticky: true, above: 36.35pt, below: 15.42pt)[...]
```
- **Auditoría de Encabezados Totales:** **90 / 90** reconocidos e indexados.
- **Encabezados Huérfanos (< 2 líneas posteriores al pie):** **0** (Cero).
- **Líneas viudas de 1 sola palabra al inicio de página:** **0** (Cero).

### 4.4 Láminas Comparativas en `dist/TEST_TOPIC_SPACING_BEFORE_AFTER.pdf`
Se generaron 4 láminas A3 apaisadas con textos canónicos reales que evidencian la ganancia en legibilidad:
1. **Hoja 1 (Caso A — H2):** Transición de Sección `1.1` $\rightarrow$ `1.2 Visión Intergeneracional y Proyecto de Largo Plazo` (Capítulo 01).
   - Espacio antes: `18.35 pt` $\rightarrow$ Corregido: `36.35 pt`.
2. **Hoja 2 (Caso B — H3):** Transición de Subsección `2.1.1` $\rightarrow$ `2.1.2 Alcance de las Restricciones sobre la Titularidad Accionaria` (Capítulo 02).
   - Espacio antes: `14.00 pt` $\rightarrow$ Corregido: `32.00 pt`.
3. **Hoja 3 (Caso C — H4):** Transición de Sub-subsección `2.3.4.1` $\rightarrow$ `2.3.4.2 Régimen de Derechos Corporativos` (Capítulo 02).
   - Espacio antes: `10.00 pt` $\rightarrow$ Corregido: `28.00 pt`.
4. **Hoja 4 (Caso D — H3 Auditado):** Transición de Subsección `3.1.1` $\rightarrow$ `3.1.2 Jerarquía Normativa Interna y Regla de Especialidad` (Capítulo 03).
   - Espacio antes: `14.00 pt` $\rightarrow$ Corregido: `32.00 pt`.

---

## 5. Dinámica de Paginación Natural y Secuencia Ceremonial

La adición de +18 pt en los 90 encabezados acumuló un volumen vertical equivalente a ~1,620 pt en todo el documento. El motor tipográfico redistribuyó el contenido de forma natural:

| Segmento Editorial | Paginación Fase 3.8 | Paginación Fase 3.8.1 | Variación | Cierre de Capítulo |
|---|:---:|:---:|:---:|---|
| **Cortesía Inicial** | P.01 | P.01 | 0 págs | Recto |
| **Capítulo 01** | P.03–P.07 (5 págs) | **P.03–P.08 (6 págs)** | $+1\text{ pág}$ | Termina en **P.08 (Verso)** |
| **Transición Cap 01 $\rightarrow$ Cap 02** | 1 blanca (P.08) | **2 blancas (P.09, P.10)** | $+1\text{ pág}$ | Permite Opening 02 en Recto |
| **Capítulo 02** | P.11–P.36 (26 págs) | **P.13–P.40 (28 págs)** | $+2\text{ págs}$ | Termina en **P.40 (Verso)** |
| **Transición Cap 02 $\rightarrow$ Cap 03** | 2 blancas (P.37, P.38) | **2 blancas (P.41, P.42)** | 0 págs | Permite Opening 03 en Recto |
| **Capítulo 03** | P.41–P.56 (16 págs) | **P.45–P.61 (17 págs)** | $+1\text{ pág}$ | Termina en **P.61 (Recto)** |
| **Total General** | **56 páginas** | **61 páginas** | **$+5\text{ págs}$** | **31 Pliegos Enfrentados** |

### Secuencia Ceremonial Garantizada
Con la matriz de páginas de transición `transition_blanks = {1: 1, 2: 2, 3: 2}`:
- **Chapter Opening 01:** Página 03 (Recto) | Frente a P.02 Blanca (Verso).
- **Chapter First Page 01:** Página 05 (Recto) | Frente a P.04 Blanca (Verso).
- **Chapter Opening 02:** Página 11 (Recto) | Frente a P.10 Blanca (Verso).
- **Chapter First Page 02:** Página 13 (Recto) | Frente a P.12 Blanca (Verso).
- **Chapter Opening 03:** Página 43 (Recto) | Frente a P.42 Blanca (Verso).
- **Chapter First Page 03:** Página 45 (Recto) | Frente a P.44 Blanca (Verso).

El archivo de pliegos `TEST_CAPITULOS_01_03_FASE_3_8_1_SPREADS.pdf` contiene **31 pliegos**. El pliego final 31 contiene `[P.60 Verso | P.61 Recto]`, cerrando el documento de forma limpia sin páginas desemparejadas.

---

## 6. Asignación Física Completa de las 61 Páginas

| Pág | Lado | Tipo de Página | Contenido / Unidad Editorial | Folio Impreso | Baseline Folio ($y$) |
|:---:|:---:|---|---|:---:|:---:|
| **01** | Recto | Cortesía Inicial | Página blanca ceremonial | — | — |
| **02** | Verso | Blanca Ceremonial | Spread A (Verso) previo a Opening Cap 01 | — | — |
| **03** | Recto | `chapter-opening()` | Portada Ceremonial Capítulo 01 | — | — |
| **04** | Verso | Blanca Ceremonial | Spread B (Verso) previo a First Page Cap 01 | — | — |
| **05** | Recto | `chapter-first-page()` | Claim + Arcos + "01" + Título + Sección 1.1 | **05** | **`591.708 pt`** |
| **06** | Verso | `interior-page()` | Continuación 1.1 $\rightarrow$ 1.2 $\rightarrow$ 1.3 | **06** | **`591.708 pt`** |
| **07** | Recto | `interior-page()` | Continuación 1.3 $\rightarrow$ 1.4 $\rightarrow$ 1.5 | **07** | **`591.708 pt`** |
| **08** | Verso | `interior-page()` | Continuación 1.5 $\rightarrow$ Conclusión Cap 01 | **08** | **`591.708 pt`** |
| **09** | Recto | Blanca de Transición | Transición de paridad ceremonial | — | — |
| **10** | Verso | Blanca Ceremonial | Spread A (Verso) previo a Opening Cap 02 | — | — |
| **11** | Recto | `chapter-opening()` | Portada Ceremonial Capítulo 02 | — | — |
| **12** | Verso | Blanca Ceremonial | Spread B (Verso) previo a First Page Cap 02 | — | — |
| **13** | Recto | `chapter-first-page()` | Claim + Arcos + "02" + Título + Sección 2.1 | **13** | **`591.708 pt`** |
| **14** | Verso | `interior-page()` | Subsecciones 2.1.1 $\rightarrow$ 2.1.2 $\rightarrow$ 2.1.3 | **14** | **`591.708 pt`** |
| **15** | Recto | `interior-page()` | Subsecciones 2.1.3 $\rightarrow$ 2.1.4 | **15** | **`591.708 pt`** |
| **16** | Verso | `interior-page()` | Subsección 2.1.5 $\rightarrow$ Sección 2.2 | **16** | **`591.708 pt`** |
| **17** | Recto | `interior-page()` | Subsecciones 2.2.1 $\rightarrow$ 2.2.2 $\rightarrow$ 2.2.3 | **17** | **`591.708 pt`** |
| **18** | Verso | `interior-page()` | Subsección 2.2.4 $\rightarrow$ Sección 2.3 | **18** | **`591.708 pt`** |
| **19** | Recto | `interior-page()` | Subsecciones 2.3.1 $\rightarrow$ 2.3.2 | **19** | **`591.708 pt`** |
| **20** | Verso | `interior-page()` | Subsección 2.3.3 $\rightarrow$ Sub-subsección 2.3.3.1 | **20** | **`591.708 pt`** |
| **21** | Recto | `interior-page()` | Subsección 2.3.4 $\rightarrow$ Sub-subsección 2.3.4.1 | **21** | **`591.708 pt`** |
| **22** | Verso | `interior-page()` | Sub-subsección 2.3.4.2 $\rightarrow$ Sección 2.4 | **22** | **`591.708 pt`** |
| **23** | Recto | `interior-page()` | Subsecciones 2.4.1 $\rightarrow$ 2.4.2 | **23** | **`591.708 pt`** |
| **24** | Verso | `interior-page()` | Subsección 2.4.3 $\rightarrow$ Sección 2.5 | **24** | **`591.708 pt`** |
| **25** | Recto | `interior-page()` | Subsecciones 2.5.1 $\rightarrow$ 2.5.2 $\rightarrow$ 2.5.3 | **25** | **`591.708 pt`** |
| **26** | Verso | `interior-page()` | Subsecciones 2.5.4 $\rightarrow$ 2.5.5 | **26** | **`591.708 pt`** |
| **27** | Recto | `interior-page()` | Subsección 2.5.6 $\rightarrow$ Sección 2.6 | **27** | **`591.708 pt`** |
| **28** | Verso | `interior-page()` | Subsecciones 2.6.1 $\rightarrow$ 2.6.2 $\rightarrow$ 2.6.3 | **28** | **`591.708 pt`** |
| **29** | Recto | `interior-page()` | Subsección 2.6.4 $\rightarrow$ Sección 2.7 | **29** | **`591.708 pt`** |
| **30** | Verso | `interior-page()` | Subsecciones 2.7.1 $\rightarrow$ 2.7.2 | **30** | **`591.708 pt`** |
| **31** | Recto | `interior-page()` | Subsecciones 2.7.3 $\rightarrow$ 2.7.4 | **31** | **`591.708 pt`** |
| **32** | Verso | `interior-page()` | Subsección 2.7.5 (con numerales romanos `i.`, `ii.`, `iii.`) | **32** | **`591.708 pt`** |
| **33** | Recto | `interior-page()` | Sección 2.8 $\rightarrow$ Subsecciones 2.8.1 $\rightarrow$ 2.8.2 | **33** | **`591.708 pt`** |
| **34** | Verso | `interior-page()` | Subsecciones 2.8.3 $\rightarrow$ 2.8.4 | **34** | **`591.708 pt`** |
| **35** | Recto | `interior-page()` | Sección 2.9 $\rightarrow$ Subsecciones 2.9.1 $\rightarrow$ 2.9.2 | **35** | **`591.708 pt`** |
| **36** | Verso | `interior-page()` | Subsección 2.9.3 $\rightarrow$ Sección 2.10 | **36** | **`591.708 pt`** |
| **37** | Recto | `interior-page()` | Subsecciones 2.10.1 $\rightarrow$ 2.10.2 | **37** | **`591.708 pt`** |
| **38** | Verso | `interior-page()` | Subsección 2.10.3 | **38** | **`591.708 pt`** |
| **39** | Recto | `interior-page()` | Subsección 2.10.4 | **39** | **`591.708 pt`** |
| **40** | Verso | `interior-page()` | Subsección 2.10.5 $\rightarrow$ Conclusión Cap 02 | **40** | **`591.708 pt`** |
| **41** | Recto | Blanca de Transición | Transición de paridad ceremonial | — | — |
| **42** | Verso | Blanca Ceremonial | Spread A (Verso) previo a Opening Cap 03 | — | — |
| **43** | Recto | `chapter-opening()` | Portada Ceremonial Capítulo 03 | — | — |
| **44** | Verso | Blanca Ceremonial | Spread B (Verso) previo a First Page Cap 03 | — | — |
| **45** | Recto | `chapter-first-page()` | Claim + Arcos + "03" + Título + Sección 3.1 | **45** | **`591.708 pt`** |
| **46** | Verso | `interior-page()` | Subsecciones 3.1.1 | **46** | **`591.708 pt`** |
| **47** | Recto | `interior-page()` | Subsección 3.1.2 (Respiración +18 pt verificada) | **47** | **`591.708 pt`** |
| **48** | Verso | `interior-page()` | Subsecciones 3.1.3 $\rightarrow$ 3.1.4 | **48** | **`591.708 pt`** |
| **49** | Recto | `interior-page()` | Sección 3.2 $\rightarrow$ Subsecciones 3.2.1 $\rightarrow$ 3.2.2 | **49** | **`591.708 pt`** |
| **50** | Verso | `interior-page()` | Subsecciones 3.2.3 $\rightarrow$ 3.2.4 $\rightarrow$ 3.2.5 | **50** | **`591.708 pt`** |
| **51** | Recto | `interior-page()` | Sección 3.3 $\rightarrow$ Subsecciones 3.3.1 $\rightarrow$ 3.3.2 | **51** | **`591.708 pt`** |
| **52** | Verso | `interior-page()` | Subsecciones 3.3.3 $\rightarrow$ 3.3.4 $\rightarrow$ 3.3.5 | **52** | **`591.708 pt`** |
| **53** | Recto | `interior-page()` | Sección 3.4 $\rightarrow$ Subsección 3.4.1 | **53** | **`591.708 pt`** |
| **54** | Verso | `interior-page()` | Subsecciones 3.4.2 $\rightarrow$ 3.4.3 $\rightarrow$ 3.4.4 | **54** | **`591.708 pt`** |
| **55** | Recto | `interior-page()` | Subsecciones 3.4.5 $\rightarrow$ 3.4.6 | **55** | **`591.708 pt`** |
| **56** | Verso | `interior-page()` | Sección 3.5 $\rightarrow$ Subsección 3.5.1 | **56** | **`591.708 pt`** |
| **57** | Recto | `interior-page()` | Subsecciones 3.5.2 $\rightarrow$ 3.5.3 | **57** | **`591.708 pt`** |
| **58** | Verso | `interior-page()` | Subsección 3.5.4 $\rightarrow$ Sección 3.6 | **58** | **`591.708 pt`** |
| **59** | Recto | `interior-page()` | Subsecciones 3.6.1 $\rightarrow$ 3.6.2 $\rightarrow$ 3.6.3 | **59** | **`591.708 pt`** |
| **60** | Verso | `interior-page()` | Subsecciones 3.6.4 $\rightarrow$ 3.6.5 $\rightarrow$ 3.6.6 | **60** | **`591.708 pt`** |
| **61** | Recto | `interior-page()` | Subsección 3.6.7 $\rightarrow$ Conclusión Cap 03 | **61** | **`591.708 pt`** |

---

## 7. Parte C — Verificación de No Regresión e Integridad Criptográfica

### 7.1 Integridad Criptográfica SHA-256
Se verificó que ninguna de las fuentes canónicas editables ni la biblioteca central de componentes haya sufrido alteraciones durante la ejecución de esta fase:

| Archivo | Hash SHA-256 | Estado |
|---|:---:|:---:|
| `capitulos/01_capitulo1_declaracion_principios.md` | `B18B22334759386A547DC94103F6A63EC5AD72BFC9BAA10E4453D9143E58246E` | **INTACTO / READ-ONLY** |
| `capitulos/02_capitulo2_propiedad_control_liquidez.md` | `5D3AA506523703D1D5588E74ADDABB3EB4F11B1A660653AD50F09B787EA46886` | **INTACTO / READ-ONLY** |
| `capitulos/03_capitulo3_gobierno_profesionalizacion.md` | `536C8D9879441CDE924C78C36F4B4879A9F69069540FAA699E002367A0B8CC53` | **INTACTO / READ-ONLY** |
| `templates/typst/componentes.typ` | `8433F851EA3E0EA9EDC09759DF25E37F6D95EBF20E0FDBAC072A2E9445E38442` | **INTACTO / LOCKED** |

### 7.2 Conservación de la Retícula Vertical Consolidada (+6 mm)
- **Top margin base:** $54.00\text{ pt}$
- **Incremento consolidado Fase 3.7.3:** $+6.00\text{ mm} = +17.0079\text{ pt}$
- **Top margin en `TEST_CAPITULOS_01_03_FASE_3_8_1.pdf`:** **`71.0079 pt`** (Intacto).
- **Desplazamiento de claim institucional:** Fijo en cota absoluta $y = 29.00\text{ pt}$.
- **Desplazamiento de bloque editorial en first-page:** $+17.01\text{ pt}$ (Número display $y = 28\text{ pt}$ relativo a caja, filete horizontal $y = 74.95\text{ pt}$, título $y = 98.30\text{ pt}$).

---

## 8. Conclusiones y Próximos Pasos

1. **Alineación Inferior Resuelta con Éxito:** La unificación de la línea base del folio en `chapter-first-page()` con la de `interior-page()` es matemáticamente exacta ($y = 591.708\text{ pt}$, error $0.000\text{ pt}$). La franja inferior se percibe visualmente continua y sólida a lo largo de todo el documento.
2. **Respiración Temática Consolidada:** La adición de +18 pt antes de cada encabezado resolvió la sensación de compresión temática, dotando de jerarquía y pausa a la lectura técnica jurídica.
3. **Estado de Componentes:** Conforme al mandato de gobernanza, los componentes `chapter-first-page()` e `interior-page()` permanecen en estado **PENDING FINAL REVIEW** a la espera de la confirmación visual definitiva del usuario.
