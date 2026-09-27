# Reporte de Análisis Forense — Páginas Interiores Recto y Verso (Fase 3.5)

**Proyecto:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Fase:** Fase 3.5 — Análisis Forense de Páginas Interiores  
**Referencias Autoritativas:**  
- [`/referencias/04 texto pagina frente.pdf`](file:///C:/Users/JJSS/Desktop/ABC/referencias/04%20texto%20pagina%20frente.pdf) (Primera página interior de capítulo · Recto)  
- [`/referencias/05 texto pagina vuelta.pdf`](file:///C:/Users/JJSS/Desktop/ABC/referencias/05%20texto%20pagina%20vuelta.pdf) (Página interior de continuación · Verso)  
**Fecha:** 26 de septiembre de 2026  
**Carácter de la Fase:** **EXCLUSIVAMENTE DE ANÁLISIS FORENSE Y MEDICIÓN (SIN MODIFICACIONES DE CÓDIGO NI IMPLEMENTACIÓN)**

---

## 1. Verificación Metrológica de Documentos

Se inspeccionaron exhaustivamente las cajas de página y metadatos de bajo nivel en ambos archivos PDF mediante introspección de objetos PDF y PyMuPDF:

| Parámetro | Página 04 (Frente / Recto) | Página 05 (Vuelta / Verso) | Cumplimiento Master |
| :--- | :---: | :---: | :---: |
| **MediaBox** | `[0.0, 0.0, 396.0, 612.0] pt` | `[0.0, 0.0, 396.0, 612.0] pt` | **Exacto (396 × 612 pt)** |
| **CropBox** | `[0.0, 0.0, 396.0, 612.0] pt` | `[0.0, 0.0, 396.0, 612.0] pt` | **Exacto (396 × 612 pt)** |
| **BleedBox** | `[0.0, 0.0, 396.0, 612.0] pt` | `[0.0, 0.0, 396.0, 612.0] pt` | **Exacto (396 × 612 pt)** |
| **TrimBox** | `[0.0, 0.0, 396.0, 612.0] pt` | `[0.0, 0.0, 396.0, 612.0] pt` | **Exacto (396 × 612 pt)** |
| **Dimensiones (pt)** | $396.00 \times 612.00\text{ pt}$ | $396.00 \times 612.00\text{ pt}$ | **Exacto** |
| **Dimensiones (in)** | $5.50 \times 8.50\text{ in}$ | $5.50 \times 8.50\text{ in}$ | **Media Carta (Half Letter)** |
| **Dimensiones (mm)** | $139.70 \times 215.90\text{ mm}$ | $139.70 \times 215.90\text{ mm}$ | **Exacto** |
| **Orientación** | Vertical (Rotación $0^\circ$) | Vertical (Rotación $0^\circ$) | **Correcto** |
| **Fondo de Página** | Blanco puro (`#ffffff`) | Blanco puro (`#ffffff`) | **Sin plano crema** |
| **Imágenes Ráster** | 0 imágenes | 4 imágenes (máscaras de sombra) | Ver detalle §4 |
| **Form XObjects** | 0 XObjects | 5 XObjects (`Fm0`..`Fm3`) | Ver detalle §4 |
| **Elementos Vectoriales**| 20 dibujos vectoriales | 11 dibujos vectoriales | Ver detalle §4 |

> [!NOTE]
> Ambas referencias respetan estrictamente el tamaño maestro de la obra ($396 \times 612\text{ pt}$ / $5.5 \times 8.5\text{ in}$). No contienen sangre (*bleed*) ni marcas de corte (*crop marks*) que alteren el sistema coordenado.

---

## 2. Clasificación Conceptual de los Dos Tipos de Página

El análisis forense confirma que las referencias **NO son un simple espejo geométrico** una de otra:

```
┌─────────────────────────────────┐     ┌─────────────────────────────────┐
│ [04 FRENTE / RECTO]             │     │ [05 VUELTA / VERSO]             │
│ (Primera página de capítulo)    │     │ (Página de continuación)        │
│                                 │     │                                 │
│ │ [Claim superior izq.]    (O)  │     │       (O)   [Claim sup. der.] │ │
│ │                               │     │                               │ │
│ │ 01                            │     │                               │ │
│ │ ──                            │     │ 1.1 HEADING                   │ │
│ │ DECLARACIÓN DE...             │     │     Cuerpo de texto...        │ │
│ │                               │     │                               │ │
│ │ 1.1 MISIÓN Y PROPÓSITO...     │     │     a) Lista con sangría      │ │
│ │     Cuerpo de texto...        │     │     b) 20 pt a la izquierda  │ │
│ │                               │     │                               │ │
│ │ 1.2 VISIÓN INTERGENERACIONAL  │     │ 1.2 HEADING                   │ │
│ │     Cuerpo de texto...        │     │     Cuerpo de texto...        │ │
│ │                               │     │                               │ │
│ │ [Logo] PROTOCOLO FAM.    [08] │     │ [09]        PROTOCOLO FAM.    │ │
└─────────────────────────────────┘     └─────────────────────────────────┘
  ▲ Lomo (izq)            Corte ▲         ▲ Corte (izq)           Lomo (der) ▲
```

### Taxonomía de Elementos
1. **Elementos que Cambian por Paridad (Recto vs. Verso):**
   - **Filete vertical naranja continuo:** En Recto está a la izquierda ($x = 30.13\text{ pt}$); en Verso está a la derecha ($x = 365.71\text{ pt}$). En ambos casos corre pegado al **lomo / encuadernación**.
   - **Márgenes de la caja de contenido:** En Recto se desplaza hacia la derecha ($x_0 = 58.74\text{ pt}$); en Verso se desplaza hacia la izquierda ($x_0 = 35.80\text{ pt}$).
   - **Claim institucional superior:** En Recto inicia en $x = 59.79\text{ pt}$ (alineado a la izquierda del contenido); en Verso termina en $x = 350.79\text{ pt}$ (alineado a la derecha del contenido).
   - **Folio (Número de página):** En Recto se ubica a la derecha ($x = 355.33\text{ pt}$, margen de corte); en Verso se ubica a la izquierda ($x = 31.68\text{ pt}$, margen de corte).
   - **Texto del Footer (`PROTOCOLO FAMILIAR`):** En Recto se sitúa a la izquierda ($x = 80.09\text{ pt}$); en Verso se sitúa a la derecha ($x = 236.95\text{ pt}$).
2. **Elementos que Permanecen Fijos (NO se espejan):**
   - **Arcos / Círculos decorativos concéntricos:** En **ambas** páginas comparten el centro geométrico exacto $(396.00, 65.90)\text{ pt}$ en la esquina superior derecha. **No se invierten en Verso**.
3. **Elementos Exclusivos de la Primera Página de Capítulo (`chapter-first-page`):**
   - Número de capítulo en display grande `"01"` ($39.3657\text{ pt}$).
   - Filete horizontal naranja bajo el número ($w = 14.19\text{ pt}$, $h = 0.91\text{ pt}$).
   - Título de capítulo en display mediano ($15.9929\text{ pt}$, leading $24.0\text{ pt}$).
   - Isotipo corporativo POLIFLEX en el pie de página ($x = 55.84\text{ pt}$, $y = 590.61\text{ pt}$).
4. **Elementos Comunes a Todas las Páginas Interiores:**
   - Filete vertical continuo naranja en el lomo.
   - Claim superior de 4 líneas con palabra `"JUNTOS."` destacada en naranja.
   - Arcos concéntricos superiores.
   - Bloque de footer institucional y número de página.
   - Retícula de texto base con paso vertical de $18.00\text{ pt}$.

---

## 3. Retícula y Márgenes Cuantitativos

### 3.1. Coordenadas de Caja y Márgenes Efectivos

$$\begin{array}{|l|c|c|}
\hline
\textbf{Métrica} & \textbf{Página 04 (Recto / Frente)} & \textbf{Página 05 (Verso / Vuelta)} \\
\hline
\text{Margen Lomo (Spine)} & 58.74\text{ pt } (20.72\text{ mm}) \text{ [Izquierda]} & 44.29 - 45.64\text{ pt } (15.62\text{ mm}) \text{ [Derecha]} \\
\text{Margen Corte (Outer)} & 22.70\text{ pt } (8.01\text{ mm}) \text{ [Derecha]} & 35.80\text{ pt } (12.63\text{ mm}) \text{ [Izquierda]} \\
\text{Margen Superior (Top de Texto)} & 228.96\text{ pt } (\text{Heading 1.1}) & 120.85\text{ pt } (\text{Heading 1.1}) \\
\text{Margen Superior a Claim} & 24.74\text{ pt } (8.73\text{ mm}) & 24.74\text{ pt } (8.73\text{ mm}) \\
\text{Margen Inferior (Último texto)} & 506.71\text{ pt } (\text{Baseline } 504.73\text{ pt}) & 531.74\text{ pt } (\text{Baseline } 529.76\text{ pt}) \\
\text{Margen Inferior a Footer} & 582.95\text{ pt } (\text{Baseline } 594.64\text{ pt}) & 585.29\text{ pt } (\text{Baseline } 594.64\text{ pt}) \\
\hline
\textbf{Ancho Útil de Columna} & \mathbf{314.56\text{ pt}} \ (110.97\text{ mm}) & \mathbf{315.91\text{ pt}} \ (111.45\text{ mm}) \\
\hline
\text{Posición Filete Vertical} & x = 30.13\text{ pt} & x = 365.71\text{ pt} \ (396 - 30.29) \\
\text{Distancia Filete } \rightarrow \text{ Texto} & 58.74 - 30.13 = \mathbf{28.61\text{ pt}} & 365.71 - 351.71 = \mathbf{14.00 - 15.35\text{ pt}} \\
\hline
\end{array}$$

> [!IMPORTANT]
> **Asimetría Comprobada:** Los márgenes de corte y lomo no son rigurosamente idénticos en espejo. En Recto, el texto se aproxima más al corte ($22.70\text{ pt}$) para permitir el respiro del encabezado del capítulo y el filete; en Verso, el margen exterior es de $35.80\text{ pt}$. El ancho útil nominal de la columna de texto se establece en **$315.0\text{ pt}$** ($111.1\text{ mm}$).

---

## 4. Elementos Gráficos Singulares

### 4.1. Filete Vertical Naranja
- **Coordenadas Recto:** Línea continua de $(30.13, 0.0)$ a $(30.13, 612.0)\text{ pt}$.
- **Coordenadas Verso:** Línea continua de $(365.71, 0.0)$ a $(365.71, 612.0)\text{ pt}$.
- **Grosor:** $0.5\text{ pt}$ constante.
- **Color:** Naranja corporativo `#f04e23` (`rgb(0.9407, 0.3033, 0.1356)`).
- **Opacidad:** $100\%$ ($1.0$). Sin clipping paths asociados.

### 4.2. Arcos / Círculos Concéntricos Superiores
Los 4 círculos forman un cuadrante visible en la esquina superior derecha:
- **Centro Común:** $(x_c, y_c) = (396.00\text{ pt}, 65.90\text{ pt})$.
- **Círculo 1 (Exterior):** Radio $r_1 = 147.47\text{ pt}$, Bounding Box $[248.53, -79.11, 543.47, 210.94]\text{ pt}$.
- **Círculo 2:** Radio $r_2 = 116.15\text{ pt}$, Bounding Box $[279.85, -48.33, 512.15, 180.12]\text{ pt}$.
- **Círculo 3:** Radio $r_3 = 83.09\text{ pt}$, Bounding Box $[312.93, -15.84, 479.11, 147.63]\text{ pt}$.
- **Círculo 4 (Interior):** Radio $r_4 = 50.53\text{ pt}$, Bounding Box $[345.49, 16.19, 446.55, 115.60]\text{ pt}$.
- **Grosor de Trazo:** $0.5\text{ pt}$.
- **Color de Trazo:** Naranja corporativo `#f04e23`. Relleno: `None`.
- **Diferencia Crítica Detectada entre 04 y 05:**  
  En la Página 04 (frente), los arcos son trazos vectoriales limpios sin sombra. En la Página 05 (vuelta), Illustrator incorporó 4 imágenes ráster con máscaras de transparencia suave (`smask`) que proyectan una leve sombra difusa sobre cada arco.  
  *Recomendación técnica:* La reconstrucción paramétrica mediante círculos vectoriales de $0.5\text{ pt}$ en Typst es geométricamente perfecta y elimina la dependencia de activos ráster pesados.

### 4.3. Claim Institucional Superior
Compuesto en 4 líneas con Neuzeit Grotesk Regular, $4.8234\text{ pt}$, tracking ultra-expandido $+0.371\text{ em}$ (`371/1000 em`), interlineado vertical de paso $8.00\text{ pt}$:

| Línea | Texto | Color | Baseline $y$ | X Inicial (Recto) | X Inicial (Verso) |
| :---: | :--- | :---: | :---: | :---: | :---: |
| **1** | `U N   L E G A D O` | `#6c6b67` (Gris) | $28.93\text{ pt}$ | $59.79\text{ pt}$ | $268.74\text{ pt}$ |
| **2** | `Q U E   T R A S C I E N D E ,` | `#6c6b67` (Gris) | $36.93\text{ pt}$ | $59.79\text{ pt}$ | $268.74\text{ pt}$ |
| **3** | `U N   F U T U R O   Q U E` | `#6c6b67` (Gris) | $44.93\text{ pt}$ | $59.79\text{ pt}$ | $268.74\text{ pt}$ |
| **4a**| `C O N S T R U I M O S ` | `#6c6b67` (Gris) | $52.93\text{ pt}$ | $59.79\text{ pt}$ | $268.74\text{ pt}$ |
| **4b**| `J U N T O S .` | `#f15e22` (Naranja) | $52.93\text{ pt}$ | $113.92\text{ pt}$ | $322.87\text{ pt}$ |

### 4.4. Isotipo Inferior (POLIFLEX)
- **Presencia:** **Exclusivamente en Página 04 (frente / recto)**.
- **Bounding Box:** $x \in [55.84, 71.41]\text{ pt}$, $y \in [582.95, 598.26]\text{ pt}$.
- **Dimensiones:** Ancho $15.57\text{ pt}$, Alto $15.31\text{ pt}$, Centro $(63.63, 590.61)\text{ pt}$.
- **Composición:** 6 círculos/anillos vectoriales concéntricos en dos tintas:
  - Rojo profundo corporativo: `#c72026` (`rgb(199, 32, 38)`).
  - Naranja primario: `#f04d23` (`rgb(240, 77, 35)`).

---

## 5. Medición Exhaustiva de Footer y Folios

Se constata la implementación de la **nueva posición aprobada** del sistema de paginación e identificación:

### 5.1. Página 04 / Frente (Recto)
- **Isotipo:** En $x = 55.84\text{ pt}$, $y_{\text{center}} = 590.61\text{ pt}$.
- **Frase `PROTOCOLO FAMILIAR`:**
  - Tipografía: Neuzeit Grotesk Regular, $4.8234\text{ pt}$, tracking $+0.200\text{ em}$.
  - Color: `#6c6b67` (gris). Stroke: $0.1\text{ pt}$.
  - Baseline: $y = 594.6387\text{ pt}$.
  - Coordenadas: $x_{\text{start}} = 80.0889\text{ pt}$, $x_{\text{end}} = 143.0787\text{ pt}$ ($w = 62.99\text{ pt}$).
  - Separación desde el isotipo: $80.09 - 71.41 = \mathbf{8.68\text{ pt}}$.
- **Versión `VERSION 1.0`:**
  - Tipografía: Neuzeit Grotesk Regular, $4.8234\text{ pt}$, tracking $+0.200\text{ em}$.
  - Color: `#f15e22` (naranja). Stroke: $0.2\text{ pt}$.
  - Baseline: $y = 594.6963\text{ pt}$.
  - Coordenadas: $x_{\text{start}} = 157.0166\text{ pt}$, $x_{\text{end}} = 192.1068\text{ pt}$ ($w = 35.09\text{ pt}$).
  - Separación desde la frase: $157.02 - 143.08 = \mathbf{13.94\text{ pt}}$.
- **Folio `"08"`:**
  - Carácter: Curvas vectoriales derivadas de `Minion Pro Medium Display`, $10.0\text{ pt}$.
  - Color: Relleno `#f15d22` con filete de contorno de $0.4\text{ pt}$ `#f15e22`.
  - Baseline: $y = 594.64\text{ pt}$.
  - Bounding Box: $[355.33, 588.29, 364.00, 594.76]\text{ pt}$ ($w = 8.67\text{ pt}$).
  - Margen al borde exterior derecho ($396.0\text{ pt}$): $396.0 - 364.00 = \mathbf{32.00\text{ pt}}$.

### 5.2. Página 05 / Vuelta (Verso)
- **Folio `"09"`:**
  - Carácter: Texto real tipográfico en `Minion Pro Medium Display`, $10.0\text{ pt}$.
  - Color: `#f15d22` / `#f15e22`.
  - Baseline: $y = 594.6387\text{ pt}$ (exacto al recto).
  - Coordenadas: $x_{\text{start}} = 31.6816\text{ pt}$, $x_{\text{end}} = 41.0516\text{ pt}$ ($w = 9.37\text{ pt}$).
  - Margen al borde exterior izquierdo ($0.0\text{ pt}$): $\mathbf{31.68\text{ pt}}$.
- **Frase `PROTOCOLO FAMILIAR`:**
  - Baseline: $y = 594.6670\text{ pt}$.
  - Coordenadas: $x_{\text{start}} = 236.9453\text{ pt}$, $x_{\text{end}} = 299.9351\text{ pt}$ ($w = 62.99\text{ pt}$).
- **Versión `VERSION 1.0`:**
  - Baseline: $y = 594.7246\text{ pt}$.
  - Coordenadas: $x_{\text{start}} = 313.8726\text{ pt}$, $x_{\text{end}} = 348.9628\text{ pt}$ ($w = 35.09\text{ pt}$).
  - Margen al borde interior derecho ($396.0\text{ pt}$): $396.0 - 348.96 = \mathbf{47.04\text{ pt}}$.
- **Isotipo:** **Ausente**.

### 5.3. Regla de Paridad Demostrada
$$\begin{aligned}
\textbf{FOLIO} &\implies \mathbf{\text{SIEMPRE AL CORTE EXTERIOR}} \quad (x \approx 31.7\text{ pt en Verso} \mid x \approx 355.3\text{ pt en Recto}) \\
\textbf{FOOTER} &\implies \mathbf{\text{SIEMPRE AL LOMO INTERIOR}} \quad (x \in [80.1, 192.1]\text{ pt en Recto} \mid x \in [236.9, 349.0]\text{ pt en Verso}) \\
\textbf{ISOTIPO} &\implies \mathbf{\text{SOLO EN APERTURA / PRIMERA PÁGINA (RECTO)}}
\end{aligned}$$

---

## 6. Cabecera de Primera Página de Capítulo (Página 04)

Pertenecen con exclusividad al encabezado de `chapter-first-page()`:

1. **Número de Capítulo `"01"`:**
   - Tipografía: `Minion Pro Medium Display`, $39.3657\text{ pt}$.
   - Color: `#f15d22` (Naranja primario).
   - Tracking: $-0.050\text{ em}$ (`Tc: -0.05`).
   - Coordenadas: $x = 57.9150\text{ pt}$, Baseline $y = 108.0762\text{ pt}$.
   - Altura de caja: $y \in [71.27, 121.11]\text{ pt}$.
2. **Filete Horizontal Naranja:**
   - Dimensiones: Ancho $14.189\text{ pt}$, Alto $0.908\text{ pt}$.
   - Coordenadas: $x = 60.100\text{ pt}$, $y = 128.950\text{ pt}$.
   - Color: Relleno sólido `#f15d22`.
   - Distancia desde baseline del número: $128.95 - 108.08 = \mathbf{20.87\text{ pt}}$.
3. **Título de Capítulo (`DECLARACIÓN DE...`):**
   - Tipografía: `Minion Pro Medium Display`, $15.9929\text{ pt}$.
   - Color: `#2e2f31`.
   - Tracking: $+0.019\text{ em}$ (`Tc: 0.019`).
   - Coordenadas: $x = 58.3398\text{ pt}$.
   - Línea 1 (`DECLARACIÓN DE`): Baseline $y = 162.7119\text{ pt}$.
   - Línea 2 (`PRINCIPIOS FAMILIARES Y`): Baseline $y = 186.7173\text{ pt}$ ($\Delta y = 24.0054\text{ pt}$).
   - Línea 3 (`VISIÓN INTERGENERACIONAL`): Baseline $y = 210.7226\text{ pt}$ ($\Delta y = 24.0053\text{ pt}$).
   - Leading exacto: **$24.005\text{ pt}$**.
   - Distancia desde filete a Línea 1: $162.71 - 128.95 = \mathbf{33.76\text{ pt}}$.

---

## 7. Headings y Subsecciones Interiores

### 7.1. Estructura y Composición Tipográfica
- **Fuente del Título:** `Minion Pro Medium Display`, tamaño **$10.0000\text{ pt}$**.
- **Color del Título:** `#2e2f31` (Gris oscuro corporativo).
- **Tracking:** $+0.019\text{ em}$ (`Tc: 0.019`).
- **Numeración ("1.1", "1.2"):**
  - Es un objeto gráfico/vectorial independiente superpuesto al flujo tipográfico.
  - En el PDF se compone de contornos vectoriales con trazo de $0.4\text{ pt}$ y relleno `#f15d22`.
  - Ancho físico de `"1.1"`: $11.78\text{ pt}$.
  - Separación entre número y texto: La numeración inicia en $x_0$ del contenido ($58.74\text{ pt}$ en Recto; $35.80\text{ pt}$ en Verso), y el texto del título inicia exactamente con un desplazamiento de **$+11.78\text{ pt}$** ($70.52\text{ pt}$ en Recto; $47.58\text{ pt}$ en Verso).

### 7.2. Espaciados Verticales de Headings

$$\begin{aligned}
\textbf{Espacio Anterior (Preceding Body } \rightarrow \textbf{ Heading):} &\quad y_{\text{heading}} - y_{\text{prev\_body}} = 399.32 - 361.72 = \mathbf{37.60\text{ pt}} \\
\textbf{Espacio Posterior (Heading } \rightarrow \textbf{ First Body Line):} &\quad y_{\text{next\_body}} - y_{\text{heading}} = 271.73 - 238.31 = \mathbf{33.42\text{ pt}} \\
\textbf{Espacio desde Título de Capítulo } \rightarrow \textbf{ Heading 1.1:} &\quad y_{\text{h1.1}} - y_{\text{title\_L3}} = 238.31 - 210.72 = \mathbf{27.59\text{ pt}}
\end{aligned}$$

---

## 8. Cuerpo de Texto (Body)

- **Familia y Estilo:** `Neuzeit Grotesk Regular`.
- **Cuerpo Tipográfico:** **$7.9077\text{ pt}$** ($7.91\text{ pt}$).
- **Color:** `#2e2f31` (`rgb(46, 47, 49)`).
- **Tracking:** **$0\text{ em}$** (`Tc: 0` constante).
- **Alineación:** **Justificación completa** (`align: justify`).
- **Comportamiento de Última Línea:** Alineada a la izquierda sin forzar justificación.
- **Partición Silábica (Hyphenation):** **0% observada**. Ninguna palabra en los cuerpos de texto de ambas referencias está cortada con guion.
- **Sangría de Primera Línea:** **$0\text{ pt}$** (sin sangría).
- **Espacio Entre Párrafos:** **$0\text{ pt}$ adicional**. El salto entre párrafos es exactamente un paso de interlineado estándar ($18.00\text{ pt}$).
- **Interlineado Efectivo (Baseline-to-Baseline):**
  Todos los saltos medidos entre líneas consecutivas de un mismo párrafo o entre párrafos son estrictamente:
  $$\Delta y = \mathbf{17.9979\text{ pt}} \approx \mathbf{18.00\text{ pt}}$$

---

## 9. Listas Alfabéticas (Página 05 / Verso)

Analizadas en las entradas `a)` a `e)` de la Página 05:

- **Sangría de Bloque (Left Indent):**
  - Margen izquierdo del cuerpo general: $x = 35.80\text{ pt}$.
  - Margen izquierdo de la lista: $x = 55.80\text{ pt}$.
  - **Sangría izquierda del bloque:** $55.80 - 35.80 = \mathbf{20.00\text{ pt}}$ exactos.
- **Sangría Francesa (Hanging Indent):**
  - Línea 1 (con marcador `a)`): Inicia en $x = 55.80\text{ pt}$.
  - Línea 2 (continuación del texto): Inicia exactamente en $x = 55.80\text{ pt}$.
  - **Hanging Indent:** **$0\text{ pt}$ (Inexistente)**. El párrafo entero está tabulado $20\text{ pt}$ hacia la derecha y el marcador forma parte del flujo inicial.
- **Tipografía del Marcador:** Idéntica al cuerpo (`Neuzeit Grotesk Regular`, $7.9077\text{ pt}$, `#2e2f31`). No tiene color naranja ni negrita.
- **Interlineado y Separación Entre Ítems:**
  - Paso entre líneas de un ítem: $18.00\text{ pt}$.
  - Paso entre ítems consecutivos ($a \rightarrow b \rightarrow c$): **$18.00\text{ pt}$**.
  - No existe espaciado vertical adicional entre ítems de lista.

---

## 10. Inventario Tipográfico y Disponibilidad

| Nombre PostScript | Familia Tipográfica | Estilo | Tamaño(s) Observado(s) | Estado en `assets/fonts/` |
| :--- | :--- | :---: | :---: | :---: |
| `MinionPro-MediumDisp` | Minion Pro | Medium Display | $39.3657\text{ pt}$, $15.9929\text{ pt}$, $10.0000\text{ pt}$ | **DISPONIBLE** (`Minion Pro Medium Display.otf`) |
| `NeuzeitGro-Reg` | Neuzeit Grotesk | Regular | $7.9077\text{ pt}$, $4.8234\text{ pt}$ | **DISPONIBLE** (`NeuzeitGro-Reg.ttf`) |

> [!TIP]
> **Autosuficiencia Tipográfica Confirmada:** El 100% de las tipografías requeridas para maquetar las páginas interiores ya se encuentra instalado y validado en `assets/fonts/`. No se requiere descargar, adquirir ni sustituir fuentes.

---

## 11. Operadores de Bajo Nivel y Tracking Demostrable

Mediante la deconstrucción de los flujos de contenido (*content streams*), se derivan los siguientes operadores formales:

- **Tracking (`Tc`):**
  - `Tc: -0.05` $\implies$ Número de capítulo (`-50/1000 em`).
  - `Tc: 0.019` $\implies$ Títulos de capítulo y headings (`+19/1000 em`).
  - `Tc: 0.2` $\implies$ Textos de footer (`+200/1000 em`).
  - `Tc: 0.371` $\implies$ Claim institucional superior (`+371/1000 em`).
  - `Tc: 0` $\implies$ Cuerpo de texto y listas (`0 em`).
- **Word Spacing (`Tw`):** Modulado dinámicamente por la justificación de Adobe Illustrator entre $-0.371$ y $+0.409$.
- **Grosor de Trazo (`w`):**
  - $w = 0.5\text{ pt}$ para filete vertical y arcos concéntricos.
  - $w = 0.4\text{ pt}$ para contorno de numeración de headings y folio.
  - $w = 0.1 - 0.2\text{ pt}$ para texto de pie de página.

---

## 12. Paleta Cromática Exacta

$$\begin{array}{|l|c|c|c|l|}
\hline
\textbf{Rol Editorial} & \textbf{HEX} & \textbf{RGB (0–255)} & \textbf{RGB Float} & \textbf{Aplicación} \\
\hline
\text{Gris Tipográfico Principal} & \texttt{\#2e2f31} & (46, 47, 49) & (0.180, 0.184, 0.192) & \text{Cuerpo, títulos, headings, listas} \\
\text{Negro Enriquecido Alt.} & \texttt{\#231f20} & (35, 31, 32) & (0.137, 0.122, 0.125) & \text{Títulos en capas base Illustrator} \\
\text{Naranja Primario} & \texttt{\#f15d22} & (241, 93, 34) & (0.9457, 0.3638, 0.1332) & \text{Número cap., regla, números headings, folio} \\
\text{Naranja Acento / Trazo} & \texttt{\#f15e22} & (241, 94, 34) & (0.9460, 0.3672, 0.1330) & \text{Palabra "JUNTOS.", "VERSION 1.0", trazos} \\
\text{Naranja Gráfico / Filete} & \texttt{\#f04e23} & (240, 78, 35) & (0.9407, 0.3033, 0.1356) & \text{Filete vertical lomo, arcos concéntricos} \\
\text{Gris Institucional Footer} & \texttt{\#6c6b67} & (108, 107, 103) & (0.4235, 0.4196, 0.4039) & \text{Base del claim, "PROTOCOLO FAMILIAR"} \\
\text{Rojo Corporativo Isotipo} & \texttt{\#c72026} & (199, 32, 38) & (0.7810, 0.1262, 0.1502) & \text{Anillos interiores isotipo POLIFLEX} \\
\text{Fondo de Página} & \texttt{\#ffffff} & (255, 255, 255) & (1.0, 1.0, 1.0) & \text{Blanco editorial limpio} \\
\hline
\end{array}$$

---

## 13. Tabla Comparativa Recto vs. Verso

| Elemento | Página 04 (Frente / Recto) | Página 05 (Vuelta / Verso) | Regla de Arquitectura Propuesta |
| :--- | :--- | :--- | :--- |
| **Filete Vertical** | En $x = 30.13\text{ pt}$ (Lado izquierdo) | En $x = 365.71\text{ pt}$ (Lado derecho) | `if is_recto { x = 30.13pt } else { x = 365.71pt }` (Pegado al lomo) |
| **Claim Superior** | $x = 59.79\text{ pt}$, alineado a la izquierda | $x = 268.74\text{ pt}$, tope derecho $350.79\text{ pt}$ | Se alinea con el margen interior o exterior según paridad |
| **Arcos Concéntricos** | Centro $(396.0, 65.9)\text{ pt}$ (Esquina sup. der.) | Centro $(396.0, 65.9)\text{ pt}$ (Esquina sup. der.) | **Posición fija invariante** en la esquina superior derecha |
| **Caja de Contenido** | $x \in [58.74, 373.30]\text{ pt}$ ($w = 314.56\text{ pt}$) | $x \in [35.80, 351.71]\text{ pt}$ ($w = 315.91\text{ pt}$) | Margen interior mayor ($58.7\text{ pt} / 45.6\text{ pt}$) para encuadernación |
| **Cabecera de Cap.** | Número "01" + regla + título | **No aparece** | Exclusivo de `chapter-first-page()` |
| **Headings (1.1, etc.)**| $x_{\text{num}} = 58.74\text{ pt}$, $x_{\text{txt}} = 70.52\text{ pt}$ | $x_{\text{num}} = 35.80\text{ pt}$, $x_{\text{txt}} = 47.58\text{ pt}$ | Desplazamiento relativo $+11.78\text{ pt}$ para el texto respecto al número |
| **Cuerpo de Texto** | $x = 58.74\text{ pt}$, leading $18.00\text{ pt}$ | $x = 35.80\text{ pt}$, leading $18.00\text{ pt}$ | Justificado, leading $18.00\text{ pt}$, sin sangría de primera línea |
| **Listas Alfabéticas** | No presentes en muestra | Sangría $x = 55.80\text{ pt}$ ($\Delta x = +20\text{ pt}$) | `margin-left: 20pt`, sin sangría francesa, leading $18.00\text{ pt}$ |
| **Footer Texto** | $x = 80.09\text{ pt}$ (Hacia el lomo/izq) | $x = 236.95\text{ pt}$ (Hacia el lomo/der) | Siempre orientado hacia el lomo interior |
| **Isotipo Footer** | Presente en $x = 55.84\text{ pt}$ | **Ausente** | Exclusivo de primera página de capítulo |
| **Folio (Paginación)** | $x = 355.33\text{ pt}$ (Hacia el corte/der) | $x = 31.68\text{ pt}$ (Hacia el corte/izq) | **Siempre hacia el corte exterior** |

---

## 14. Parámetros Demostrables desde los Archivos PDF

1. **Geometría y Caja:** MediaBox $396 \times 612\text{ pt}$ confirmado al 100%.
2. **Leading del Cuerpo:** Rigurosamente **$18.00\text{ pt}$** ($\Delta y = 17.9979\text{ pt}$) demostrado en 25 saltos de línea consecutivos.
3. **Leading de Títulos de Capítulo:** Rigurosamente **$24.005\text{ pt}$**.
4. **Leading del Claim:** Rigurosamente **$8.00\text{ pt}$**.
5. **Espaciados de Headings:** Espacio anterior $= 37.60\text{ pt}$; Espacio posterior $= 33.42\text{ pt}$.
6. **Sangría de Listas:** Indentación en bloque de **$20.00\text{ pt}$** sin sangría francesa (hanging indent $= 0\text{ pt}$).
7. **Regla de Folios y Footer:** Folio exterior y footer interior confirmados en ambas páginas.
8. **Invarianza de los Arcos:** Centro fijo en $x = 396.00\text{ pt}$ comprobado por cálculo de cuerdas y radios.

---

## 15. Parámetros Ambiguos

Los siguientes parámetros corresponden a la configuración interna de Adobe Illustrator y presentan discrepancias o ambigüedades técnicas que aconsejan confirmación visual en el archivo `.ai` original:

1. **Leading Configurado vs. Leading Efectivo en Headings:**
   - En el PDF, el salto hacia el primer renglón del cuerpo es de $33.42\text{ pt}$ y el espacio antes del heading es de $37.60\text{ pt}$. ¿Fue configurado mediante el panel Párrafo (`Espacio antes` / `Espacio después`) o mediante cajas de texto independientes / renglones vacíos?
2. **Vectorización de Numeración de Headings y Folio 08:**
   - ¿Por qué el folio "08" en la página 04 y las numeraciones "1.1" y "1.2" fueron exportados como trazados vectoriales con contorno de $0.4\text{ pt}$, mientras que el folio "09" en la página 05 se exportó como texto editable? ¿Tienen un estilo de carácter con trazo (*stroke*) en Illustrator?
3. **Sombra Paralela en Arcos Concéntricos:**
   - ¿Deben llevar los arcos sombra difusa (como en la página 05) o deben ser líneas limpias de $0.5\text{ pt}$ (como en la página 04)?
4. **Presencia del Isotipo en Páginas Interiores Subsecuentes:**
   - ¿Aparece el isotipo únicamente en la primera página interior de cada capítulo, o debe omitirse en todas las páginas pares e incluirse en todas las impares?

---

## 16. Capturas de Adobe Illustrator Requeridas

Para resolver las ambigüedades mencionadas con máxima fidelidad, se solicita al usuario proporcionar las siguientes **4 capturas quirúrgicas de Adobe Illustrator**:

1. **Captura 1 — Panel Carácter y Párrafo de BODY:**
   - Seleccionar un párrafo de texto normal en Illustrator.
   - Mostrar paneles **Carácter** (`Fuente`, `Tamaño`, `Interlineado`, `Tracking`) y **Párrafo** (`Alineación`, `Sangría izquierda`, `Sangría primera línea`, `Espacio después`).
2. **Captura 2 — Panel Carácter y Párrafo de HEADING (1.1 / 1.2):**
   - Seleccionar el título `"1.1 MISIÓN Y PROPÓSITO FAMILIAR EMPRESARIAL"`.
   - Mostrar paneles **Carácter**, **Párrafo** (`Espacio antes`, `Espacio después`) y **Apariencia** (para verificar si el número tiene un trazo de $0.4\text{ pt}$).
3. **Captura 3 — Panel Párrafo de LISTA ALFABÉTICA:**
   - Seleccionar el ítem `a) Continuidad institucional...` en la página vuelta.
   - Mostrar panel **Párrafo** (`Sangría izquierda`, `Sangría de primera línea`).
4. **Captura 4 — Panel Apariencia de los ARCOS SUPERIORES:**
   - Seleccionar uno de los arcos concéntricos.
   - Mostrar panel **Apariencia** (confirmar si tiene aplicado efecto de `Estilizar > Sombra paralela` o si es únicamente trazo naranja de $0.5\text{ pt}$).

---

## 17. Propuesta de Arquitectura Typst para la Siguiente Fase

Se proyecta una arquitectura limpia y modular dividida en dos componentes especializados dentro de `templates/typst/componentes.typ`:

1. `chapter-first-page(cfg, ..)`:
   - Configura el lienzo en blanco (`#ffffff`).
   - Inserta el filete vertical izquierdo en $x = 30.13\text{ pt}$.
   - Inserta los arcos concéntricos fijos superiores.
   - Compone el claim superior izquierdo.
   - Renderiza el encabezado del capítulo: Número `"01"` ($39.37\text{ pt}$), filete horizontal ($14.19\text{ pt}$) y título del capítulo ($15.99\text{ pt}$).
   - Inicia el flujo del cuerpo de texto a partir de $y \approx 228.96\text{ pt}$.
   - Renderiza el footer de primera página con isotipo, frases y folio a la derecha.
2. `interior-page-setup(cfg, ..)`:
   - Manejador global `#show: setup-interior-pages(cfg)` que alterna dinámicamente según la paridad de página (`calc.even(page)`):
     - **Filete vertical:** Izquierda en impares ($30.13\text{ pt}$), derecha en pares ($365.71\text{ pt}$).
     - **Márgenes de página:** Lomo $58.74\text{ pt}$ / Corte $35.80\text{ pt}$.
     - **Claim:** Alineado a la izquierda en impares, a la derecha en pares.
     - **Footer y Folio:** Folio al corte exterior; frase y versión al lomo interior.
     - **Arcos:** Fijos en la esquina superior derecha.

---

## 18. Verificación de Integridad del Repositorio

- **Archivos de Código:** Ningún componente (`componentes.typ`, `editorial_config.yaml`, `/capitulos/*.md`, `tests/`, `dist/`) ha sido alterado.
- **Componentes Bloqueados:**
  - `cover-page()` = **APPROVED / LOCKED** (Inalterado).
  - `table-of-contents()` = **APPROVED / LOCKED** (Inalterado).
  - `chapter-opening()` = **APPROVED / LOCKED** (Inalterado).
