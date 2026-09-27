# Reporte Técnico de Fase 3.4 — Sistema Editorial: Apertura de Capítulo

**Proyecto:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Componente:** Tercer Componente Maestro: Portada / Apertura de Capítulo (`chapter-opening()`)  
**Fecha de Emisión:** 26 de septiembre de 2026  
**Referencia Autoritativa:** [`referencias/03 portada capitulos.pdf`](file:///C:/Users/JJSS/Desktop/ABC/referencias/03%20portada%20capitulos.pdf)  
**Compilado de Validación:** [`dist/TEST_CHAPTER_OPENING.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENING.pdf)  
**Estado del Componente:** **EN ESPERA DE APROBACIÓN MANUAL** (No bloqueado formalmente)  

---

## 1. Identificación y Verificación de la Referencia Autoritativa

Se analizó la estructura interna, objetos PDF y flujos de contenido de la referencia visual autoritativa provista:

- **Archivo fuente:** `referencias/03 portada capitulos.pdf`
- **Páginas:** 1 página (Media Carta / Half Letter / Statement).
- **Dimensiones maestras:** `396.0 × 612.0 pt` ($5.5 \times 8.5\text{ in}$ / $139.7 \times 215.9\text{ mm}$).
- **MediaBox:** `[0.0, 0.0, 396.0, 612.0]`.
- **CropBox:** `[0.0, 0.0, 396.0, 612.0]`.
- **Orientación:** Vertical (Portrait).
- **Rotación:** 0°.
- **Total de objetos de dibujo vectorial:** 382 trazos.
- **Objetos de sombreado (Form XObjects):** 2 (`Fm0` y `Fm1`) con máscaras de transparencia suave (`/SMask`).
- **Bloques de texto activos (`BT ... ET`):** 6 bloques delimitados (número de capítulo, 3 líneas de título, 2 líneas de descripción, 2 cadenas de pie de página).

---

## 2. Tipografías Detectadas y Empleadas

El análisis de streams confirmó la coincidencia exacta con las fuentes tipográficas originales suministradas en `assets/fonts/`:

| Familia Interna Typst | Archivo Físico | Nombre PostScript | Peso Typst | Bloque Asignado |
| :--- | :--- | :--- | :--- | :--- |
| **Minion Pro** | `Minion Pro Medium Display.otf` | `MinionPro-MediumDisp` | `medium` (500) | Número ("01") y Título del Capítulo |
| **Neuzeit Grotesk** | `NeuzeitGro-Reg.ttf` | `NeuzeitGro-Reg` | `regular` (400) | Descripción y Leyendas de Footer |

### Verificación de Exclusión de Fuentes de Sistema
La compilación se realizó con la bandera estricta `--ignore-system-fonts`. La inspección mediante PyMuPDF del archivo [`dist/TEST_CHAPTER_OPENING.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENING.pdf) arrojó:
```text
(9, 'cid', 'Type0', 'CUNYHU+MinionPro-MediumDisp-Identity-H', 'f0', 'Identity-H')
(12, 'ttf', 'Type0', 'JOKWTB+NeuzeitGro-Reg', 'f1', 'Identity-H')
(38, 'cff', 'Type1', 'PRICCP+MinionPro-MediumDisp', 'T1_0', 'WinAnsiEncoding')
(35, 'cff', 'Type1', 'NOEQAT+NeuzeitGro-Reg', 'T1_1', 'WinAnsiEncoding')
```
Se confirma que fuentes como Georgia, Segoe UI o Arial no fueron cargadas ni embebidas.

---

## 3. Conversiones Adobe Illustrator → Typst

Para lograr una réplica submilimétrica sin aproximaciones visuales, se formalizaron las ecuaciones de equivalencia entre el modelo de caja de Adobe Illustrator y el modelo de cajas de texto de Typst:

### A. Compensación del Interlineado (`leading`)
En Illustrator, el leading representa la distancia exacta de línea base a línea base consecutiva ($\Delta y$). En Typst, `par(leading)` representa el espaciado adicional libre entre el descent de la línea previa y el ascent de la siguiente:
$$\text{Typst leading} = \text{Target leading (Illustrator)} - \text{Font ascent}$$

1. **Título de Capítulo (`Minion Pro Medium Display`, 15.9929 pt):**
   - Leading Illustrator: $24.0000\text{ pt}$
   - Ascenso de glifo medido en Typst: $10.4114\text{ pt}$
   - Typst leading configurado: $24.0000\text{ pt} - 10.4114\text{ pt} = \mathbf{13.5939\text{ pt}}$
   - Resultado medido en PDF: $\Delta y = 24.0053\text{ pt}$ (error residual: $0.0053\text{ pt}$ / $0.0018\text{ mm}$).

2. **Descripción de Capítulo (`Neuzeit Grotesk Regular`, 7.9077 pt):**
   - Leading Illustrator: $18.0000\text{ pt}$
   - Ascenso de glifo medido en Typst: $5.2705\text{ pt}$
   - Typst leading configurado: $18.0000\text{ pt} - 5.2705\text{ pt} = \mathbf{12.7295\text{ pt}}$
   - Resultado medido en PDF: $\Delta y = 18.0000\text{ pt}$ (error residual: $0.0000\text{ pt}$).

### B. Conversión de Tracking (Letter-Spacing)
Illustrator define el tracking en milésimas de em ($1/1000\text{ em}$):
$$\text{Typst tracking} = \frac{\text{Tracking}_{\text{Illustrator}}}{1000}\,\text{em}$$

- Número ("01"): $-50/1000 \rightarrow \mathbf{-0.050\text{ em}}$
- Título: $+19/1000 \rightarrow \mathbf{+0.019\text{ em}}$
- Descripción: $0/1000 \rightarrow \mathbf{0.000\text{ em}}$
- Footer ("PROTOCOLO FAMILIAR" y "VERSION 1.0"): $+200/1000 \rightarrow \mathbf{+0.200\text{ em}}$

### C. Conversión de Origen Top-Left (`dy`) desde Baseline ($y_{\text{baseline}}$)
Typst ubica los bloques con `#place(top + left, dx, dy)` midiendo desde el borde superior de la caja de texto (ascendente superior). Dado que Illustrator ancla el texto a la línea base:
$$dy = y_{\text{baseline}} - \text{Font ascent}$$

- Número "01": $y = 368.0762\text{ pt}$, ascent $= 25.6271\text{ pt} \rightarrow dy = \mathbf{342.4491\text{ pt}}$
- Título Línea 1: $y = 422.7119\text{ pt}$, ascent $= 10.4114\text{ pt} \rightarrow dy = \mathbf{412.3005\text{ pt}}$
- Descripción Línea 1: $y = 496.3955\text{ pt}$, ascent $= 5.2705\text{ pt} \rightarrow dy = \mathbf{491.1250\text{ pt}}$
- Footer Línea 1: $y = 594.6387\text{ pt}$, ascent $= 3.2148\text{ pt} \rightarrow dy = \mathbf{591.4239\text{ pt}}$

---

## 4. Desglose Tipográfico Completo

| Elemento | Familia | Tamaño | Leading | Typst `par(leading)` | Tracking | Color | Stroke |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Número ("01")** | Minion Pro Medium Disp | 39.3657 pt | 59.0746 pt | — | -0.050 em | `#f15d22` | Ninguno (`0 Tr`, fill only) |
| **Título (L1-L3)** | Minion Pro Medium Disp | 15.9929 pt | 24.0000 pt | 13.5939 pt | +0.019 em | `#2e2f31` | Ninguno (`0 Tr`, fill only) |
| **Descripción (L1-L2)** | Neuzeit Grotesk Reg | 7.9077 pt | 18.0000 pt | 12.7295 pt | 0.000 em | `#2e2f31` | Ninguno (`0 Tr`, fill only) |
| **Footer: Frase** | Neuzeit Grotesk Reg | 4.8234 pt | 4.5478 pt | — | +0.200 em | `#6c6b67` | 0.1 pt (`#6c6b67`) |
| **Footer: Versión** | Neuzeit Grotesk Reg | 4.8234 pt | 4.5478 pt | — | +0.200 em | `#f15e22` | 0.2 pt (`#f15e22`) |

---

## 5. Extracción y Conservación del Fondo Vectorial

Para salvaguardar la pureza gráfica institucional y evitar la rasterización de elementos vectoriales o degradados complejos, se extrajo la capa de fondo hacia:
[`assets/images/capitulo_apertura_fondo.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/assets/images/capitulo_apertura_fondo.pdf)

- **Total de trazos vectoriales conservados:** 382 trazos puros (curvas Bézier, rectángulos, trazados combinados).
- **Form XObjects conservados:** 2 objetos de forma (`Fm0` y `Fm1`) con máscaras suaves de canal alfa (`/SMask`).
- **Bloques de texto eliminados:** 6 de 6 bloques `BT ... ET`. El archivo resultante contiene **cero caracteres de texto estático**, garantizando que el 100% de la tipografía es inyectada dinámicamente por Typst.
- **Peso del recurso:** 673 KB.

---

## 6. Análisis de la Retícula de Puntos (Dot Matrix)

La retícula decorativa ubicada en la franja lateral superior derecha fue verificada geométricamente:
- **Estructura matricial:** 7 columnas $\times$ 53 filas = **371 puntos circulares** idénticos (más 1 punto aislado en la tilde del logotipo POLIFLEX).
- **Distribución horizontal:** $x \in [327.86, 370.43]\text{ pt}$, con paso regular $\Delta x = 7.0952\text{ pt}$.
- **Distribución vertical:** $y \in [19.45, 465.89]\text{ pt}$, con paso regular $\Delta y = 8.7538\text{ pt}$.
- **Geometría de glifo:** Diámetro $2.068\text{ pt}$ (radio $r = 1.034\text{ pt}$).
- **Colorimetría:** `#ebe5e3` (gris cálido institucional de bajo contraste).
- **Profundidad z-index:** Subyace al plano diagonal naranja y a las sombras arrojadas, integrándose de forma nativa en la capa de fondo.

---

## 7. Planos Diagonales, Sombras y Logotipo

- **Plano diagonal:** Cuña poligonal en naranja corporativo (`#f15d22`) con vértice superior en el margen derecho y proyección angular hacia el tercio inferior de la página.
- **Sombras suaves (Drop Shadows):** Ejecutadas mediante los objetos `Fm0` y `Fm1` con matrices de transformación afín, produciendo un difuminado progresivo de 12 pt a lo largo del bisel sin efecto de bandas (*banding*).
- **Logotipo POLIFLEX:** Vectorial original, ubicado en $x = 28.34\text{ pt}$, $y = 42.00\text{ pt}$, integrado por isotipo de anillos concéntricos en naranja y wordmark tipográfico en negro, conservando su precisión matemática original.
- **Filete divisorio:** Línea horizontal en color `#f15d22` situada inmediatamente bajo el número "01" en $y = 387.87\text{ pt}$, ancho $14.19\text{ pt}$ y grosor $0.90\text{ pt}$.

---

## 8. Modos de Renderizado, Colores y Strokes

La inspección de los operadores de flujo PDF arrojó la siguiente especificación de llenado y trazo:

| Elemento | Operador PDF | Modo de Renderizado | Color Relleno | Operador Stroke | Grosor Stroke | Color Stroke |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Número "01"** | `0 Tr` | Fill only (sin trazo) | `#f15d22` (CMYK `0, 0.788, 1, 0`) | — | — | — |
| **Título** | `0 Tr` | Fill only (sin trazo) | `#2e2f31` (CMYK `0.714, 0.647, 0.612, 0.608`) | — | — | — |
| **Descripción** | `0 Tr` | Fill only (sin trazo) | `#2e2f31` (CMYK `0.714, 0.647, 0.612, 0.608`) | — | — | — |
| **Footer: Frase** | `1 Tr` | Stroke only sobre `0 Tr` | `#6c6b67` (CMYK `0.573, 0.494, 0.525, 0.188`) | `0.1 w` | 0.1 pt | `#6c6b67` |
| **Footer: Versión**| `1 Tr` | Stroke only sobre `0 Tr` | `#f15e22` (CMYK `0, 0.784, 1, 0`) | `0.2 w` | 0.2 pt | `#f15e22` |

---

## 9. Geometría, Coordenadas Absolutas y Comparativa de Spans

Se compararon las coordenadas de origen de cada span de texto entre `referencias/03 portada capitulos.pdf` y `dist/TEST_CHAPTER_OPENING.pdf`:

| Elemento / Cadena | Ref $x$ (pt) | Ref $y$ (pt) | Typst $x$ (pt) | Typst $y$ (pt) | $\Delta x$ (pt) | $\Delta y$ (pt) | Estado |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `01` | 28.92 | 368.08 | 28.92 | 368.08 | **0.00** | **0.00** | Idéntico |
| `DECLARACIÓN DE` | 28.34 | 422.71 | 28.34 | 422.71 | **0.00** | **0.00** | Idéntico |
| `PRINCIPIOS FAMILIARES Y` | 28.34 | 446.72 | 28.34 | 446.72 | **0.00** | **0.00** | Idéntico |
| `VISIÓN INTERGENERACIONAL` | 28.34 | 470.72 | 28.34 | 470.72 | **0.00** | **0.00** | Idéntico |
| `Los principios que nos guían como f...` | 28.74 | 496.40 | 28.74 | 496.40 | **0.00** | **0.00** | Idéntico |
| `y la visión que orienta nuestro cam...` | 28.74 | 514.39 | 28.74 | 514.40 | **0.00** | **+0.01** | Idéntico (< 0.003 mm) |
| `PROTOCOLO FAMILIAR` | 28.92 | 594.64 | 28.92 | 594.64 | **0.00** | **0.00** | Idéntico |
| `VERSION 1.0` | 105.84 | 594.70 | 105.84 | 594.70 | **0.00** | **0.00** | Idéntico |

Todos los elementos coinciden en su posición de inicio y línea base con un margen de tolerancia nulo ($\Delta x = 0.00\text{ pt}$, $\Delta y \le 0.01\text{ pt}$).

---

## 10. Arquitectura Dinámica del Componente

El componente `chapter-opening()` en [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ) fue diseñado con las siguientes capacidades modulares:

1. **Firma Flexible y Retrocompatible:**
   ```typst
   #let chapter-opening(
     arg1,
     number: none,
     title: none,
     description: none,
     subtitle: none,
     label: none,
     cfg: none,
     is_recto: false
   ) = { ... }
   ```
   - Permite invocación directa moderna pasando el diccionario de configuración: `chapter-opening(cfg, number: "01", title: "...", description: "...")`.
   - Soporta invocaciones de prueba sin argumentos: utiliza automáticamente `default_chapter` de `editorial_config.yaml`.
   - Mantiene compatibilidad con llamadas legadas que pasen un `string` o `content` como primer argumento.

2. **Control de Página Impar (Recto):**
   - En compilaciones aisladas de prueba (`is_recto: false`), evita la emisión de páginas en blanco previas.
   - En compilación del libro completo (`is_recto: true`), ejecuta `pagebreak(to: "odd")` para garantizar que la apertura de capítulo siempre quede a la derecha de la doble página.

3. **Independencia del Contenido:**
   - No contiene textos fijos ("hardcoded") en su implementación.
   - Admite títulos de 1, 2 o 3 líneas y descripciones de longitud variable dentro de bloques con ancho acotado (`width: 250pt`), manteniendo la verticalidad exacta mediante el interlineado calibrado.

---

## 11. Métricas de Discrepancia Visual (300 DPI)

Se generaron renderizados de alta resolución a 300 DPI ($1650 \times 2550\text{ píxeles}$) comparando píxel a píxel la referencia original contra el PDF compilado por Typst:

- **Diferencia Media Global (Diff Score):** **`0.9725`** (en escala 0 a 255).
- **Diferencia Máxima:** 209 (restringida exclusivamente al antialiasing de contornos curvos de glifos).

### Desglose Regional de Discrepancia:
| Zona | Elementos Involucrados | Diff Score (0-255) | Diagnóstico |
| :--- | :--- | :--- | :--- |
| **Superior (0% - 40% alto)** | Logotipo POLIFLEX, Retícula de 371 puntos, Plano diagonal naranja | **`0.5558`** | Coincidencia vectorial idéntica; micro-variación por antialiasing del rasterizador. |
| **Número (50% - 65% alto, izq)**| Número "01" | **`0.5449`** | Glifo 1:1, alineación perfecta. |
| **Título (65% - 80% alto, izq)** | Título a 3 líneas | **`1.3180`** | Líneas base idénticas; mínima variación por hinting tipográfico. |
| **Descripción (80% - 90% alto)**| Descripción a 2 líneas | **`3.8727`** | Variación generada por pares de kerning manuales de Illustrator (`TJ`) frente al motor OpenType nativo de Typst. |
| **Pie de Página (95% - 100%)** | Frase legal y versión | **`1.0891`** | Coincidencia en baseline y grosor de trazo. |

### Archivos de Evidencia Generados:
- Tríptico (Original | Typst | Diferencia ×5): [`dist/chapter_opening_comparacion.png`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/chapter_opening_comparacion.png)
- Overlay de transparencia 50% / 50%: [`dist/chapter_opening_comparacion_overlay.png`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/chapter_opening_comparacion_overlay.png)

---

## 12. Propuesta sobre Almacenamiento Estructurado de Descripciones de Capítulos

Actualmente, los archivos de contenido en `/capitulos/*.md` contienen en su frontmatter únicamente el campo `title`. Para incorporar y mantener las descripciones de los capítulos sin quebrantar el principio de fuente canónica única, se formulan tres opciones técnicas:

### Opción A (Recomendada): Frontmatter Canónico en `/capitulos/*.md`
Extender el frontmatter YAML de cada capítulo incorporando la clave `description`:
```yaml
---
title: "Capítulo 1. Declaración de Principios Familiares y Visión Intergeneracional"
company: "Poliductos Flexibles, S.A. de C.V."
chapter_number: "01"
description: "Los principios que nos guían como familia empresaria y la visión que orienta nuestro camino hacia el futuro."
---
```
- **Ventajas:** Mantiene el principio rector de que `/capitulos/*.md` es la **única fuente canónica editable**. Si el contenido o la descripción cambian, cualquier motor de derivación (Typst, HTML, EPUB, JSON) se actualiza de manera coherente.
- **Implementación:** Se ejecutará únicamente cuando se autorice de forma expresa la edición del frontmatter de los capítulos, sin tocar el cuerpo del texto jurídico.

### Opción B: Catálogo Editorial en `config/editorial_config.yaml`
Centralizar las descripciones en la sección `chapter_opening.chapters` de la configuración editorial (estructura ya provista de manera preventiva en esta fase):
```yaml
chapter_opening:
  chapters:
    - num: "01"
      title: "DECLARACIÓN DE \\\nPRINCIPIOS FAMILIARES Y \\\nVISIÓN INTERGENERACIONAL"
      description: "Los principios que nos guían como familia empresaria \\\ny la visión que orienta nuestro camino hacia el futuro."
    - num: "02"
      ...
```
- **Ventajas:** Permite ajustar saltos de línea de diseño (`\\`) específicos para la maquetación visual sin alterar los archivos Markdown de contenido.

### Opción C: Diccionario Híbrido en `protocolo_estructurado.json`
Almacenar las descripciones como atributos en el árbol JSON generado y consumirlas desde Typst mediante `json()`.

---

## 13. Estructura de Configuración en `config/editorial_config.yaml`

Se incorporó la sección `chapter_opening:` al archivo [`config/editorial_config.yaml`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/config/editorial_config.yaml#L385-L498), conteniendo:
- Dimensiones de página (`396pt × 612pt`).
- Ruta del asset vectorial de fondo (`/assets/images/capitulo_apertura_fondo.pdf`).
- Parámetros tipográficos de Número, Título, Descripción y Footer (fuente, fallback, tamaño, tracking, colores, ascents, dy, leading).
- Entrada `default_chapter` para compilaciones de prueba.
- Catálogo de capítulos 01 al 09 con títulos y descripciones normalizadas.

---

## 14. Implementación en `templates/typst/componentes.typ`

Se actualizó la función `chapter-opening()` en [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ#L400-L570) implementando:
1. Posicionamiento absoluto submilimétrico mediante `place(top + left, dx, dy)`.
2. Bloques con interlineado corregido (`par(leading)` compensado).
3. Superposición del fondo vectorial completo en capa inferior.
4. Renderizado condicional de la descripción y footer con trazos calibrados.

---

## 15. Compilación de Prueba y Verificación de Regresiones

Se crearon y compilaron con éxito los entornos de prueba aislados:
- [`tests/test_chapter_opening.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_chapter_opening.typ)
- [`test_chapter_opening.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/test_chapter_opening.typ) (raíz)
- Resultado: [`dist/TEST_CHAPTER_OPENING.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENING.pdf) (1 página, tamaño exacto 396 × 612 pt).

### Prueba de Regresión Global
Se recompilaron simultáneamente los componentes previos para constatar que las adiciones no causaron efectos colaterales:
- `tests/test_cover.typ` $\rightarrow$ [`dist/TEST_COVER.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_COVER.pdf): **0 errores**.
- `tests/test_toc.typ` $\rightarrow$ [`dist/TEST_TOC.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_TOC.pdf): **0 errores**.
- `tests/test_chapter_opening.typ` $\rightarrow$ [`dist/TEST_CHAPTER_OPENING.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENING.pdf): **0 errores**.

---

## 16. Registro de Archivos Creados y Modificados en Fase 3.4

### Archivos Creados:
1. `assets/images/capitulo_apertura_fondo.pdf` (fondo vectorial limpio sin texto).
2. `tests/test_chapter_opening.typ` (harness de prueba en carpeta tests).
3. `test_chapter_opening.typ` (harness de prueba en raíz).
4. `dist/TEST_CHAPTER_OPENING.pdf` (documento compilado de validación).
5. `dist/chapter_opening_comparacion.png` (tríptico comparativo a 300 DPI).
6. `dist/chapter_opening_comparacion_overlay.png` (overlay 50/50 a 300 DPI).
7. `reportes/reporte_apertura_capitulo.md` (este documento técnico formal).

### Archivos Modificados:
1. `config/editorial_config.yaml` (incorporación exclusiva de la sección `chapter_opening:`; el resto del archivo permaneció intacto).
2. `templates/typst/componentes.typ` (actualización exclusiva del cuerpo de `chapter-opening()`; componentes bloqueados sin alteración).

---

## 17. Confirmación de Integridad de Componentes Bloqueados

Se hace constar formalmente el cumplimiento de las restricciones de alcance:

1. **`cover-page() = APPROVED / LOCKED`:**  
   La función de portada en `templates/typst/componentes.typ`, su sección de configuración en `config/editorial_config.yaml` y sus assets vectoriales **NO fueron modificados** en ningún parámetro.

2. **`table-of-contents() = APPROVED / LOCKED`:**  
   La función del índice en `templates/typst/componentes.typ`, su sección en `config/editorial_config.yaml` y su modo de folios de prueba ("00") **NO fueron modificados** en ningún parámetro.

3. **Fuente Canónica `/capitulos/*.md`:**  
   Los 15 archivos Markdown en `capitulos/` conservan íntegramente sus contenidos, marcas de tiempo y estructuras sin ninguna alteración.

4. **Estado de `chapter-opening()`:**  
   **EN ESPERA DE INSPECCIÓN VISUAL Y APROBACIÓN POR PARTE DEL USUARIO.** No ha sido marcado como `APPROVED / LOCKED`.
