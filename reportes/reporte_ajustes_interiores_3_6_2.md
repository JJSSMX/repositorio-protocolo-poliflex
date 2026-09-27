# Reporte Técnico de Ajustes Editoriales — Páginas Interiores (Fase 3.6.2)

**Proyecto:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Fase:** Fase 3.6.2 — Ajustes Editoriales Previos al Cierre (Páginas Interiores)  
**Componentes Ajustados:**  
- `interior-page(cfg, ...)`  
- `chapter-first-page(cfg, ...)`  
- `interior-heading(title, ...)`  
- `interior-arcs(cfg, opacity: 50%)`  
**Referencias Autoritativas:**  
- [`/referencias/04 texto pagina frente.pdf`](file:///C:/Users/JJSS/Desktop/ABC/referencias/04%20texto%20pagina%20frente.pdf) (Recto / primera página interior de capítulo)  
- [`/referencias/05 texto pagina vuelta.pdf`](file:///C:/Users/JJSS/Desktop/ABC/referencias/05%20texto%20pagina%20vuelta.pdf) (Verso / página interior de continuación)  
- [`/referencias/icono.svg`](file:///C:/Users/JJSS/Desktop/ABC/referencias/icono.svg) (Isotipo vectorial original de Illustrator)  
**Fecha:** 26 de septiembre de 2026  
**Estado:** **PENDING VISUAL REVIEW** (ambos componentes continúan en revisión visual)

---

## 1. Sustitución del Isotipo por `/referencias/icono.svg`

Se eliminó la reconstrucción vectorial aproximada previa del isotipo del pie de página y se sustituyó por el recurso original:

- **Archivo canónico de origen:** [`/referencias/icono.svg`](file:///C:/Users/JJSS/Desktop/ABC/referencias/icono.svg).
- **Copia de trabajo en el proyecto:** [`assets/images/icono.svg`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/assets/images/icono.svg).
- **Propiedades del SVG original:**
  - `viewBox="0 0 15.57 15.31"` (Relación de aspecto: $1.01698$).
  - Estructura vectorial pura: 6 trayectorias compuestas (`<path>`) con rellenos corporativos `#c72026` y `#f04e23`.
  - Sin simplificaciones, sin filtros rasterizantes (`<filter>`), sin redondeos ni distorsiones geométricas.
- **Integración en Typst:**
  - Dimensiones exactas de despliegue: ancho $15.5740\text{ pt}$, alto $15.3150\text{ pt}$ ($100\%$ proporcional al `viewBox`).
  - Posicionamiento en pie de página recto: $x = 55.8388\text{ pt}$, $y = 582.9483\text{ pt}$.
  - El renderizador de Typst inserta el recurso como **6 objetos vectoriales puros nativos en el PDF** (`drawings`), con **cero imágenes ráster** (`images = 0`).

---

## 2. Gap Definitivo Propuesto para Headings

### Diagnóstico Previo
En la fase previa, el número de sección `"1.1"` se encontraba delimitado por un contenedor fijo de ancho $11.78\text{ pt}$ seguido de `#h(0pt)`. Debido a que el texto del título no contenía espacios en blanco iniciales, los glifos de la numeración y del título aparecían visualmente pegados (`1.1MISIÓN Y PROPÓSITO...`).

### Solución Implementada
Se parametrizó un espacio geométrico explícito (`gap`) independiente del ancho del número:

1. **Estructura en Typst:**
   ```typst
   #box[#text(...)[#number]]#h(gap)#text(...)[#title]
   ```
2. **Evaluación de Alternativas:**
   - `0.0pt`: Glifos en contacto visual directo (`1.1MISIÓN`). Inaceptable editorialmente.
   - `2.5pt` (ancho de un espacio ordinario): Legible pero compacto, el número no se destaca como distintivo de sección.
   - **`5.5pt` (Propuesta Definitiva Calibrada):** Espacio armónico equivalente a un *en-space* expandido ($550/1000\text{ em}$ a $10\text{ pt}$). Crea una separación nítida y distinguible entre el número naranja y el título en gris oscuro corporativo.
   - `7.0pt`: Separación excesiva que desvincula la relación jerárquica del encabezado.
3. **Independencia del Ancho:**
   - Al calcular el ancho del número de forma intrínseca mediante `#box[#number]`, la separación horizontal de $5.5\text{ pt}$ se conserva idéntica sin importar si el número es `1.1`, `1.2`, `1.10`, `2.1` o `3.4`.

---

## 3. Mecanismo de Numeración Dinámica

Se implementó un sistema desacoplado y semántico para gobernar la numeración de los headings sin requerir números hardcodeados ni alteraciones a la fuente canónica de `/capitulos/*.md`:

1. **Contadores de Estado en Typst:**
   - `interior-chapter-counter = counter("interior-chapter-counter")`: Almacena el número del capítulo activo.
   - `interior-section-counter = counter("interior-section-counter")`: Contador de sección que se incrementa en cada encabezado.
2. **Ciclo de Vida Automático:**
   - Al invocar `chapter-first-page(cfg, number: "01", ...)`, el componente actualiza automáticamente el contador de capítulo al entero correspondiente (`1`) y reinicia el contador de sección a cero (`0`).
   - Cada llamada a `#interior-heading("TÍTULO")` ejecuta de manera transparente `#interior-section-counter.step()` y compone el prefijo `str(ch) + "." + str(sec)` dentro de un contexto reactivo (`#context`).
   - Al cambiar al capítulo 2 (`number: "02"`), el contador de capítulo pasa a `2`, produciendo secuencialmente `2.1`, `2.2`, `2.3`...
3. **Compatibilidad y Respeto a Numeración Canónica Existente:**
   - El componente admite tanto llamadas con título directo como títulos extraídos de Markdown que ya posean numeración prefijada (`"1.1 Misión..."`):
     - El componente analiza mediante expresión regular `^([0-9]+(?:\.[0-9]+)*)\s+(.*)$` si el título contiene ya una numeración jurídica. De ser así, extrae el número y el título limpio, aplicando el estilo oficial y el gap geométrico de $5.5\text{ pt}$.
     - Si se especifica `number: auto`, se genera mediante el contador dinámico.
     - Si se proporciona un número manual explícito (`interior-heading("1.1", "TÍTULO")`), se respeta fielmente.
4. **Resultado en Fixtures:**
   - `TEST_CHAPTER_FIRST_PAGE.pdf`:
     - Heading 1: **1.1 MISIÓN Y PROPÓSITO FAMILIAR EMPRESARIAL**
     - Heading 2: **1.2 VISIÓN INTERGENERACIONAL Y PROYECTO DE LARGO PLAZO**
   - `TEST_INTERIOR_PAGE_VERSO.pdf`:
     - Heading 1: **1.1 VALORES COMUNES Y PRINCIPIOS RECTORES**
     - Heading 2: **1.2 VISIÓN INTERGENERACIONAL Y PROYECTO DE LARGO PLAZO**

---

## 4. Unificación de Arcos Superiores y Componente `interior-arcs()`

### Problema Previo
En la fase previa existían dos variantes asimétricas para los arcos superiores: una versión plana en Recto y una versión con desplazamiento y simulación de sombra difusa (*Drop Shadow*) en Verso.

### Solución Implementada
Se eliminaron todas las variantes divergentes, estableciendo una **única composición geométrica maestra** idéntica para todas las páginas interiores:

1. **Componente Modular `interior-arcs(cfg, opacity: 50%)`:**
   - Reutilizado de forma unificada por `interior-page()` y `chapter-first-page()`.
2. **Parámetros Geométricos Maestros:**
   - **Centro común:** $(x_c, y_c) = (396.00, 65.90)\text{ pt}$ (anclado exactamente en el vértice superior derecho de la página Media Carta).
   - **5 Radios concéntricos:** $118.91, 107.03, 95.14, 83.25, 71.37\text{ pt}$.
   - **Grosor del trazo:** $0.25\text{ pt}$.
   - **Color base:** Naranja corporativo `#f15e22`.
   - **Orientación:** Fija en la esquina superior derecha en todas las páginas (sin espejar, sin desplazar por paridad).
   - **Sombras:** Se desactivó cualquier efecto o sobrecapa de sombra; la composición es puramente vectorial lineal.

---

## 5. Opacidad al 50%

Conforme a la instrucción de evaluación visual, el componente `interior-arcs()` aplica una atenuación de trazo al **50% de opacidad**:
- Color resultante del trazo: `rgb(241, 94, 34, 50%)` / `#f15e2280`.
- Esta opacidad permite que los arcos actúen como un elemento gráfico de acompañamiento sutil y elegante, reduciendo el peso visual sobre la caja de texto y facilitando la lectura sin competir con el claim institucional ni los títulos.

---

## 6. Retícula Horizontal Simétrica (Especular)

### Principio de Diseño
Se abandonaron las diferencias manuales heredadas de los archivos de Illustrator para establecer una **retícula horizontal perfectamente especular** entre páginas enfrentadas (*Facing Pages / Spread*):

$$\begin{array}{ccc}
\textbf{VERSO (Página Par / Izquierda)} & \quad\vert\quad & \textbf{RECTO (Página Impar / Derecha)} \\
\text{Corte } (22.70\text{ pt}) \;\vert\; \text{Contenido } (314.56\text{ pt}) \;\vert\; \text{Lomo } (58.74\text{ pt}) & \quad\vert\quad & \text{Lomo } (58.74\text{ pt}) \;\vert\; \text{Contenido } (314.56\text{ pt}) \;\vert\; \text{Corte } (22.70\text{ pt})
\end{array}$$

### Características Clave
1. **Margen Interior (Lomo):** Exactamente $58.74\text{ pt}$ en ambas páginas.
2. **Margen Exterior (Corte):** Exactamente $22.70\text{ pt}$ en ambas páginas.
3. **Ancho Útil de Columna:** Exactamente $314.56\text{ pt}$ en ambas páginas (preservando el comportamiento exacto de los saltos de línea calibrados con `linebreaks: "simple"`).
4. **Filete Vertical del Lomo:**
   - Recto: $x = 30.13\text{ pt}$ (a $30.13\text{ pt}$ del lomo).
   - Verso: $x = 365.87\text{ pt}$ ($396.00 - 30.13 = 365.87\text{ pt}$, a $30.13\text{ pt}$ del lomo).
5. **Distancia Filete $\leftrightarrow$ Contenido:**
   - Recto: $58.74 - 30.13 = \mathbf{28.61\text{ pt}}$.
   - Verso: $365.87 - 337.26 = \mathbf{28.61\text{ pt}}$ (simetría milimétrica exacta).

---

## 7. Tabla Comparativa de Márgenes: Antes vs. Después

$$\begin{array}{|l|c|c|c|}
\hline
\textbf{Parámetro Geométrico} & \textbf{Fase 3.6.1 (Antes)} & \textbf{Fase 3.6.2 (Normalizado)} & \textbf{Condición de Simetría} \\
\hline
\text{Margen interior Recto (Lomo)} & 58.74\text{ pt} & \mathbf{58.74\text{ pt}} & \text{Base autoritativa Ref. 04} \\
\text{Margen interior Verso (Lomo)} & 44.29\text{ pt} & \mathbf{58.74\text{ pt}} & \mathbf{Especular = Recto} \\
\text{Margen exterior Recto (Corte)} & 22.70\text{ pt} & \mathbf{22.70\text{ pt}} & \text{Base autoritativa Ref. 04} \\
\text{Margen exterior Verso (Corte)} & 35.80\text{ pt} & \mathbf{22.70\text{ pt}} & \mathbf{Especular = Recto} \\
\text{Ancho útil de columna Recto} & 314.56\text{ pt} & \mathbf{314.56\text{ pt}} & \text{Preservado 100\%} \\
\text{Ancho útil de columna Verso} & 315.00\text{ pt} & \mathbf{314.56\text{ pt}} & \mathbf{Idéntico = Recto} \\
\text{Posición del Filete Recto} & x = 30.13\text{ pt} & \mathbf{x = 30.13\text{ pt}} & \text{Preservado 100\%} \\
\text{Posición del Filete Verso} & x = 365.71\text{ pt} & \mathbf{x = 365.87\text{ pt}} & \mathbf{396.00 - 30.13\text{ pt}} \\
\text{Distancia Filete } \to \text{ Texto (Recto)} & 28.61\text{ pt} & \mathbf{28.61\text{ pt}} & \text{Preservado 100\%} \\
\text{Distancia Texto } \to \text{ Filete (Verso)} & 15.35\text{ pt} & \mathbf{28.61\text{ pt}} & \mathbf{Especular exacta} \\
\text{Coordenadas } X \text{ Contenido Recto} & [58.74, 373.30]\text{ pt} & \mathbf{[58.74, 373.30]\text{ pt}} & \text{Columna estándar} \\
\text{Coordenadas } X \text{ Contenido Verso} & [35.80, 350.36]\text{ pt} & \mathbf{[22.70, 337.26]\text{ pt}} & \mathbf{Alineación especular} \\
\hline
\end{array}$$

---

## 8. Excepciones de Illustrator Eliminadas

En estricto cumplimiento de las instrucciones de la Fase 3.6.2:

1. **Eliminación de $x = 37.1602\text{ pt}$ en Vuelta:**
   - La caja de texto inferior del Verso (*"La cohesión entre los miembros..."*) ya no requiere un desplazamiento artificial independiente (`#interior-frame(dx: 1.3565pt)`).
   - Se eliminaron las claves `frame2_dx`, `frame2_x` y `frame2_width` de `config/editorial_config.yaml`.
   - Todo el contenido de la página Verso comparte el mismo margen izquierdo normalizado $x = 22.70\text{ pt}$, fluyendo de manera limpia y continua sobre una única retícula maestra.

---

## 9. Archivos Creados y Modificados

### Archivos Creados
| Archivo | Tipo | Descripción |
| :--- | :---: | :--- |
| [`assets/images/icono.svg`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/assets/images/icono.svg) | Recurso Vectorial | Isotipo POLIFLEX original copiado íntegramente de `/referencias/icono.svg`. |
| [`tests/test_interior_spread.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_interior_spread.typ) | Fixture de Prueba | Maquetación de doble página enfrentada ($792 \times 612\text{ pt}$). |
| [`tests/test_interior_spread_grid.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_interior_spread_grid.typ) | Fixture de Diagnóstico | Doble página enfrentada con sobreimpresión vectorial de guías diagnósticas de retícula. |
| [`dist/TEST_INTERIOR_SPREAD.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTERIOR_SPREAD.pdf) | PDF Generado | Spread a doble página ($792 \times 612\text{ pt}$) mostrando Verso y Recto enfrentados. |
| [`dist/TEST_INTERIOR_SPREAD_GRID.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTERIOR_SPREAD_GRID.pdf) | PDF Generado | Spread con guías vectoriales diagnósticas de márgenes, lomo, filetes y cotas de simetría. |
| [`reportes/reporte_ajustes_interiores_3_6_2.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/reportes/reporte_ajustes_interiores_3_6_2.md) | Documentación | Presente informe técnico de la Fase 3.6.2. |

### Archivos Modificados
| Archivo | Modificación Realizada |
| :--- | :--- |
| [`config/editorial_config.yaml`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/config/editorial_config.yaml) | Se actualizó `isotype_asset` a `/assets/images/icono.svg`. Se normalizó la paridad verso a retícula especular ($M_{\text{cut}} = 22.70\text{ pt}$, $M_{\text{spine}} = 58.74\text{ pt}$, $W_{\text{col}} = 314.56\text{ pt}$, $x_{\text{filete}} = 365.87\text{ pt}$). Se añadió `headings.gap = "5.5pt"`. Se eliminaron las claves de excepción `frame2_*`. |
| [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ) | Se implementaron los contadores de capítulo y sección. Se reescribió `interior-heading()` para dar soporte a numeración dinámica y gap geométrico. Se creó `interior-arcs(cfg, opacity: 50%)`. Se unificó la llamada de arcos en `interior-page()` y `chapter-first-page()`, eliminando variantes y sombras. |
| [`tests/test_chapter_first_page.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_chapter_first_page.typ) | Se actualizaron las llamadas a `interior-heading()` eliminando numeraciones manuales repetidas y adoptando la numeración dinámica. Se regeneró `dist/TEST_CHAPTER_FIRST_PAGE.pdf`. |
| [`tests/test_interior_page_verso.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_interior_page_verso.typ) | Se eliminó el bloque de desplazamiento manual `interior-frame`. Se actualizaron las llamadas a `interior-heading()`. Se regeneró `dist/TEST_INTERIOR_PAGE_VERSO.pdf`. |

---

## 10. Regresión de Componentes Bloqueados

Se ejecutó la suite completa de regresión editorial:

```
typst compile --root . --font-path assets/fonts tests/test_cover.typ dist/TEST_COVER.pdf
typst compile --root . --font-path assets/fonts tests/test_toc.typ dist/TEST_TOC.pdf
typst compile --root . --font-path assets/fonts tests/test_chapter_opening.typ dist/TEST_CHAPTER_OPENING.pdf
```

### Resultados de Integridad Estructural y de Contenido
$$\begin{array}{|l|c|c|c|c|}
\hline
\textbf{Documento de Prueba} & \textbf{Longitud de Texto} & \textbf{Trazos Vectoriales} & \textbf{Imágenes Ráster} & \textbf{Estado} \\
\hline
\texttt{dist/TEST\_COVER.pdf} & 153\text{ caracteres} & 25\text{ trazos} & 4\text{ imágenes} & \textbf{100\% INTACTO / IDÉNTICO} \\
\texttt{dist/TEST\_TOC.pdf} & 677\text{ caracteres} & 268\text{ trazos} & 0\text{ imágenes} & \textbf{100\% INTACTO / IDÉNTICO} \\
\texttt{dist/TEST\_CHAPTER\_OPENING.pdf} & 230\text{ caracteres} & 383\text{ trazos} & 2\text{ imágenes} & \textbf{100\% INTACTO / IDÉNTICO} \\
\hline
\end{array}$$

Se confirma que **ningún archivo canónico en `/capitulos/*.md` fue modificado**.

---

## 11. Estado Final de Componentes

- `cover-page()` = **APPROVED / LOCKED**
- `table-of-contents()` = **APPROVED / LOCKED**
- `chapter-opening()` = **APPROVED / LOCKED**
- `interior-page()` = **PENDING VISUAL REVIEW**
- `chapter-first-page()` = **PENDING VISUAL REVIEW**

---

*Fin del Reporte Técnico de la Fase 3.6.2.*
