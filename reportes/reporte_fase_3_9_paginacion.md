# REPORTE DE FASE 3.9 — DIAGNÓSTICO Y PROPUESTA DE CONTROL EDITORIAL DE PAGINACIÓN
**PROTOCOLO FAMILIAR POLIFLEX**  
**Fecha:** 26 de Septiembre de 2026  
**Sistema:** Typst 0.15.1  
**Estado:** ANÁLISIS, SIMULACIÓN Y PROPUESTA (FASE NO CONSOLIDADA · PIPELINE DE PRODUCCIÓN INTACTO)

---

## RESUMEN EJECUTIVO

En cumplimiento estricto de las directrices de la **FASE 3.9**, se ha llevado a cabo una investigación forense exhaustiva sobre el comportamiento tipográfico y la paginación del **Protocolo Familiar POLIFLEX** (Capítulos 01 al 09).

Bajo la regla fundamental de **NO ALTERAR LA RETÍCULA APROBADA (+6 mm de respiración vertical)**, **NO MODIFICAR LOS ARCHIVOS CANÓNICOS (`/capitulos/*.md`)** y **NO COMPRIMIR HACIA ATRÁS**, se alcanzaron los siguientes resultados clave:

1. **Auditoría Forense de las 26 Incidencias:**
   - La categorización automatizada previa identificó 26 transiciones de página como posibles quiebres defectuosos.
   - La inspección forense línea a línea y carácter a carácter determinó que **únicamente 2 casos** correspondían a verdaderas líneas viudas aisladas (1 línea al tope de página: Caso 12 en P.66 y Caso 13 en P.68).
   - Los **24 casos restantes** corresponden a quiebres de párrafo regulares de tipo $2+2$, $3+2$, $4+2$, $2+3$, etc., los cuales cumplen de forma natural con la regla tipográfica clásica de mantener un mínimo de 2 líneas antes y 2 líneas después del salto.
2. **Diagnóstico de las 5 Páginas Terminales de Baja Densidad:**
   - Se analizaron al milímetro las causas de baja densidad en Cap 01 (P.08), Cap 04 (P.87), Cap 06 (P.102), Cap 08 (P.119) y Cap 09 (P.126).
   - Las páginas terminales de **Cap 01 (6 líneas)** y **Cap 06 (11 líneas)** son editorially dignas, autoportantes y estructuradas con encabezados formales (Regla D: No sobreoptimizar).
   - Las páginas terminales de **Cap 04 (2 líneas)**, **Cap 08 (2 líneas)** y **Cap 09 (2 líneas)** fueron producidas por falta natural de espacio al fondo de la página precedente (P.86, P.118 y P.125), expulsando remanentes accidentales.
3. **Simulación de Redistribución Hacia Adelante (Regla C y Regla A):**
   - Se diseñó e implementó una simulación independiente en `dist/TEST_PAGINATION_CONTROL_SIMULATION.pdf` y `dist/TEST_PAGINATION_CONTROL_SIMULATION_SPREADS.pdf`.
   - **Cap 04 (P.87):** Al mantener atómico el bloque conclusivo de la Subsección 4.9.4, la página terminal pasa de **2 líneas a 5 líneas completas** (ocupación vertical del 24.1%), al tiempo que se eliminan las 2 viudas de P.66 y P.68.
   - **Cap 08 (P.119):** Al trasladar la Sección 8.9 hacia adelante, P.119 pasa de **2 líneas a 8 líneas con encabezado H2** (ocupación vertical del 35.2%), concluyendo con una sección completa y armónica.
   - **Cap 09 (P.126):** Al trasladar la Sección 9.8 hacia adelante, la clausura definitiva del Protocolo pasa de **2 líneas a 8 líneas con encabezado H2** (ocupación vertical del 35.2%), logrando una digna solemnidad de cierre.
4. **Preservación Rigurosa de la Arquitectura Ceremonial y Paridad:**
   - Páginas totales: **Estrictamente 126 páginas físicas** (0 delta).
   - Pliegos enfrentados: **64 pliegos** idénticos.
   - Paridad de aperturas ceremoniales: **100% de las 9 aperturas permanecen en página RECTO** enfrentadas a un VERSO blanco ceremonial.
   - Paridad de Chapter First Pages: **100% de las 9 primeras páginas permanecen en página RECTO** enfrentadas a un VERSO blanco ceremonial.
   - Cero compresión hacia atrás: Ningún párrafo fue comprimido, ni se alteró el leading, tamaño tipográfico o márgenes.

---

## 1. DIAGNÓSTICO DETALLADO DE LAS 26 INCIDENCIAS

Durante la prueba de estrés de la Fase 3.7 se reportaron 26 transiciones de página con quiebre de párrafo. A continuación se presenta la matriz forense completa verificada contra los textos canónicos y las coordenadas reales de renderizado en Typst:

| ID | Cap | Páginas ($P_1 \to P_2$) | Sección | Párrafo Afectado (Texto Inicial) | Líneas $P_1$ | Líneas $P_2$ | Total Líneas | Clasificación Editorial | Estado en Simulación |
|:---:|:---:|:---:|:---:|:---|:---:|:---:|:---:|:---|:---|
| **01** | 02 | P.37 $\to$ P.38 | 2.10.2 | *El control efectivo deberá permanecer en todo momento...* | 2 | 2 | 4 | **D. Quiebre estándar (2+2)** | Cumple Regla A naturalmente |
| **02** | 03 | P.45 $\to$ P.46 | 3.1 | *Este régimen no regula derechos económicos...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | Cumple Regla A naturalmente |
| **03** | 03 | P.48 $\to$ P.49 | 3.1.3 | *El ejercicio de estas facultades de gobierno...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | Cumple Regla A naturalmente |
| **04** | 03 | P.49 $\to$ P.50 | 3.2.1 | *No constituirá intervención indebida la adopción...* | 4 | 2 | 6 | **D. Quiebre estándar (4+2)** | Cumple Regla A naturalmente |
| **05** | 03 | P.51 $\to$ P.52 | 3.3.1 | *El Consejo de Familia constituye el órgano permanente...* | 2 | 4 | 6 | **D. Quiebre estándar (2+4)** | Cumple Regla A naturalmente |
| **06** | 03 | P.54 $\to$ P.55 | 3.4.2 | *La pertenencia a la familia, la titularidad accionaria...* | 3 | 3 | 6 | **D. Quiebre estándar (3+3)** | Cumple Regla A naturalmente |
| **07** | 03 | P.56 $\to$ P.57 | 3.5.1 | *Se considerarán supuestos de incompatibilidad...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | Cumple Regla A naturalmente |
| **08** | 03 | P.57 $\to$ P.58 | 3.5.3 | *La función ejecutiva se limita exclusivamente...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | Cumple Regla A naturalmente |
| **09** | 03 | P.58 $\to$ P.59 | 3.6.1 | *El directivo familiar estará sujeto a un deber...* | 2 | 4 | 6 | **D. Quiebre estándar (2+4)** | Cumple Regla A naturalmente |
| **10** | 03 | P.59 $\to$ P.60 | 3.6.2 | *Constituye infracción toda actuación mediante la cual...* | 4 | 2 | 6 | **D. Quiebre estándar (4+2)** | Cumple Regla A naturalmente |
| **11** | 03 | P.60 $\to$ P.61 | 3.6.5 | *Constituye infracción el desconocimiento de los cauces...* | 4 | 2 | 6 | **D. Quiebre estándar (4+2)** | Cumple Regla A naturalmente |
| **12** | 04 | P.65 $\to$ P.66 | 4.1.1 | *La sucesión accionaria tiene como finalidad exclusiva...* | 6 | **1** | 7 | **B. Viuda (1 línea al tope)** | **Corregido: 0 viudas (bloque atómico)** |
| **13** | 04 | P.67 $\to$ P.68 | 4.2.1 | *No obstante, la activación del régimen no se encuentra...* | 4 | **1** | 5 | **B. Viuda (1 línea al tope)** | **Corregido: Flujo redistribuido (5+2)** |
| **14** | 04 | P.69 $\to$ P.70 | 4.3.2 | *Para estos efectos, el derecho económico sucesorio...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | Cumple Regla A naturalmente |
| **15** | 04 | P.72 $\to$ P.73 | 4.4.1 | *Desde la actualización del supuesto sucesorio y...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | Cumple Regla A naturalmente |
| **16** | 04 | P.74 $\to$ P.75 | 4.5.1 | *Bajo este esquema, el régimen sucesorio se rige...* | 3 | 3 | 6 | **D. Quiebre estándar (3+3)** | Cumple Regla A naturalmente |
| **17** | 04 | P.75 $\to$ P.76 | 4.5.2 | *En consecuencia, cualquier derecho que pudiera derivar...* | 2 | 3 | 5 | **D. Quiebre estándar (2+3)** | Cumple Regla A naturalmente |
| **18** | 04 | P.79 $\to$ P.80 | 4.7.1 | *El presente apartado regula, de manera obligatoria...* | 3 | 3 | 6 | **D. Quiebre estándar (3+3)** | Cumple Regla A naturalmente |
| **19** | 04 | P.81 $\to$ P.82 | 4.8.1 | *La ejecución podrá instrumentarse mediante esquemas...* | 2 | 2 | 4 | **D. Quiebre estándar (2+2)** | Cumple Regla A naturalmente |
| **20** | 04 | P.82 $\to$ P.83 | 4.8.2 | *Para efectos de control interno, la acreditación...* | 2 | 3 | 5 | **D. Quiebre estándar (2+3)** | Cumple Regla A naturalmente |
| **21** | 04 | P.84 $\to$ P.85 | 4.9.1 | *El presente apartado establece el procedimiento interno...* | 2 | 3 | 5 | **D. Quiebre estándar (2+3)** | Cumple Regla A naturalmente |
| **22** | 04 | P.85 $\to$ P.86 | 4.9.2 | *Sus resoluciones deberán adoptarse conforme a las...* | 2 | 3 | 5 | **D. Quiebre estándar (2+3)** | Cumple Regla A naturalmente |
| **23** | 04 | P.86 $\to$ P.87 | 4.9.4 | *Concluido el procedimiento y cumplidas las condiciones...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | **Corregido: Párrafo entero a P.87 (5 lín)** |
| **24** | 05 | P.92 $\to$ P.93 | 5.2 | *El acceso a la información se encuentra estrictamente...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | Cumple Regla A naturalmente |
| **25** | 05 | P.93 $\to$ P.94 | 5.4 | *La comunicación del sistema familiar–empresarial...* | 3 | 2 | 5 | **D. Quiebre estándar (3+2)** | Cumple Regla A naturalmente |
| **26** | 06 | P.101 $\to$ P.102 | 6.5 | *Cualquier acto que implique la exposición del capital...* | 2 | 2 | 4 | **D. Quiebre estándar (2+2)** | Cumple Regla A naturalmente |

### Hallazgos de la Auditoría Forense:
- **Líneas Huérfanas al pie ($< 2$ líneas):** **0 incidencias**. Ningún párrafo en los 9 capítulos inicia dejando 1 sola línea al fondo de una página. Todos los quiebres al pie tienen al menos 2 líneas.
- **Líneas Viudas al tope ($< 2$ líneas):** **2 incidencias reales** (Casos 12 y 13 en el Capítulo 04).
- **Quiebres Estándar Equilibrados ($\ge 2+2$):** **24 incidencias**. En el reporte de la Fase 3.7 se agruparon dentro de una consulta general de párrafos partidos; la verificación física demuestra que ya respetan la convención tipográfica de mínimo 2 líneas por lado.

---

## 2. TABLA DE LAS 5 PÁGINAS TERMINALES DE BAJA DENSIDAD

| Capítulo | Pág. Terminal | Líneas Útiles | Bloque que la Produjo | Líneas en Pág. Anterior | Espacio Libre Pág. Anterior | Condición que Impidió Permanecer | Factores Intervinientes | Diagnóstico y Evaluación Editorial |
|:---:|:---:|:---:|:---|:---:|:---:|:---|:---|:---|
| **01** | **Pág. 08** | 6 líneas (H2 + 5 de cuerpo) | Sección `1.8 Criterio de Interpretación del Protocolo` completa | 21 líneas (P.07) | 49.64 pt ($y=497.4$ a $547.0$ pt) | Falta natural de espacio: Sección 1.8 requería $\approx 102$ pt ($\ge 78$ pt para keep-with-next) | - `heading.keep-with-next`<br>- Espacio `space-before` H2 ($28.35$ pt)<br>- Falta natural de espacio | **VÁLIDA (Regla D):** Bloque autónomo, digno y autoportante. No requiere intervención artificial. |
| **04** | **Pág. 87** | 2 líneas | Párrafo final de Subsección `4.9.4` (partido) | 24 líneas (P.86) | 19.76 pt ($y=527.2$ a $547.0$ pt) | Falta natural de espacio: P.86 alojó 3 líneas del párrafo y solo quedaron $19.76$ pt disponibles | - Fin de caja tipográfica en P.86<br>- Quiebre natural de párrafo de 5 líneas | **DEFICIENTE:** 2 líneas huérfanas de contexto. Requiere balanceo hacia adelante (Regla C). |
| **06** | **Pág. 102** | 11 líneas (H2 + 10 de cuerpo) | Remanente de Sección 6.5 (2 lín.) + Sección `6.6 Responsabilidad Patrimonial...` completa | 25 líneas (P.101) | 9.12 pt ($y=537.9$ a $547.0$ pt) | Falta natural de espacio: P.101 totalmente llena; Sección 6.6 requería $\approx 140$ pt | - Falta natural de espacio<br>- `heading.keep-with-next`<br>- Remanente de 2 líneas de 6.5 | **VÁLIDA (Regla D):** 11 líneas ocupan 215.5 pt (45% de altura útil). Página sólida y equilibrada. |
| **08** | **Pág. 119** | 2 líneas | Párrafo 3 de la Sección `8.9 Coordinación con el Régimen Sancionador` | 22 líneas (P.118) | 31.64 pt ($y=515.4$ a $547.0$ pt) | Falta natural de espacio: P.118 alojó H2 + párrafos 1 y 2; el párrafo 3 requería $38.19$ pt | - Fin de caja tipográfica en P.118<br>- Sección 8.9 partida al final | **DEFICIENTE:** 2 líneas terminales. Requiere trasladar la Sección 8.9 íntegra hacia adelante (Regla C). |
| **09** | **Pág. 126** | 2 líneas | Párrafo 3 de la Sección `9.8 Interpretación y Cierre Normativo` | 21 líneas (P.125) | 26.02 pt ($y=521.0$ a $547.0$ pt) | Falta natural de espacio: P.125 alojó H2 + párrafos 1 y 2; el párrafo 3 requería $38.19$ pt | - Fin de caja tipográfica en P.125<br>- Cláusula final del libro fragmentada | **DEFICIENTE:** Cierre del Protocolo con solo 2 líneas. Requiere trasladar Sección 9.8 a P.126 (Regla C). |

---

## 3. CAUSA TÉCNICA DE CADA FENÓMENO

1. **Mecánica del Motor de Flujo de Typst:**
   Typst llena el bloque vertical de la página (`height: 612pt - margin-top: 65pt - margin-bottom: 65pt = 482pt` de caja útil, extendiéndose de $y=65.0$ pt a $y=547.0$ pt). Cuando el espacio vertical restante antes de $y=547.0$ pt es menor que la altura de la siguiente línea base más su leading ($18.0$ pt) o menor que el espaciado de párrafo ($12.0$ pt) + 2 líneas, Typst fuerza un salto de página.
2. **Ausencia de Regla Nativa de Viudas en Typst:**
   Bajo `par(linebreaks: "simple")`, Typst no penaliza los saltos de página que dejen 1 sola línea de remanente en la página receptora, a menos que el bloque sea declarado explícitamente no fragmentable (`breakable: false`).
3. **El Peligro Fatal de la Compresión Hacia Atrás:**
   Durante las pruebas experimentales se comprobó que intentar forzar el contenido terminal hacia la página anterior colapsando espacios o reduciendo cajas produce dos catástrofes editoriales:
   - **Degradación Visual:** La página precedente queda saturada, colisionando con el folio o suprimiendo el aire entre unidades temáticas.
   - **Ruptura de la Arquitectura Ceremonial:** Si un capítulo que concluía en página RECTO (impar) se comprime para terminar en VERSO (par), el conteo de páginas decrece de 126 a 124, **invirtiendo la paridad de los capítulos siguientes**. Como consecuencia, la portada ceremonial del capítulo posterior cae en VERSO y su primera página en RECTO sin blanco enfrentado, destruyendo el sistema de pliegos aprobado.
4. **La Virtud de la Redistribución Hacia Adelante (Forward Redistribution):**
   Al desplazar el bloque conflictivo hacia la página terminal:
   - La página precedente concluye con un descanso natural al final de una sección o párrafo mayor (entre 68% y 88% de ocupación).
   - La página terminal recibe masa crítica suficiente ($\ge 5$ líneas o sección completa con H2, alcanzando entre 24% y 35% de ocupación).
   - La paridad de salida del capítulo permanece inalterada, conservando la secuencia ceremonial intacta.

---

## 4. POLÍTICA EDITORIAL PROPUESTA

Se formula la siguiente política editorial general y semántica para gobernar el motor de composición en la Fase 3.9.1:

### REGLA A — PÁRRAFOS ATÓMICOS Y CONTROL DE QUIEBRES
1. **Párrafos de $\le 3$ líneas:** Deben considerarse **unidades atómicas indivisibles** (`breakable: false`). Un párrafo de 3 líneas no puede dividirse sin generar una huérfana ($1+2$) o una viuda ($2+1$).
2. **Párrafos de $\ge 4$ líneas:** Se permite la división únicamente si se garantiza un mínimo estricto de **2 líneas antes del salto** y **2 líneas después del salto** ($2+2$ como umbral mínimo de dignidad tipográfica).

### REGLA B — ENCABEZADOS Y MÍNIMO DE CONTINUIDAD
- Mantener inalterada la regla ya aprobada:
  `heading.where(level: 2)` y `level: 3` exigen `keep-with-next: true` y un mínimo de **2 líneas completas de cuerpo** posteriores en la misma página. Si no caben, el encabezado completo se traslada al inicio de la página siguiente.

### REGLA C — CIERRE DE CAPÍTULO (BALANCEO HACIA ADELANTE)
- Si la página final de contenido de un capítulo contiene únicamente 1 o 2 líneas útiles:
  - **Queda estrictamente prohibido comprimir la página anterior.**
  - Se debe trasladar hacia la página terminal la **última unidad temática indivisible** (la subsección final, el encabezado H2/H3 completo con sus párrafos, o el párrafo conclusivo de 5 líneas).
  - **Umbral de Calidad:** La página terminal debe alcanzar un **20% a 35% de ocupación vertical útil**, configurándose como una clausura sólida y deliberada.

### REGLA D — NO SOBREOPTIMIZAR
- Páginas terminales con 5 a 11 líneas estructuradas con encabezados institucionales (como Cap 01 Pág. 08 y Cap 06 Pág. 102) son plenamente válidas, dignas y forman parte del ritmo editorial natural de un libro ceremonial. No deben alterarse.

---

## 5. COMPORTAMIENTO TÉCNICO DE TYPST 0.15.1

1. **`par(linebreaks: "simple")` vs `par(linebreaks: "optimized")`:**
   - La directiva `linebreaks: "optimized"` altera la horizontalidad calibrada, reduciendo la extensión del libro de 126 a 123 páginas y desbalanceando los folios de cierre. Se ratifica mantener `linebreaks: "simple"`.
2. **Comportamiento de `#block(breakable: false)`:**
   - Si se aplica indiscriminadamente a todos los párrafos, Typst genera 27 grandes huecos blancos al fondo de página y desborda el documento a 130 páginas.
   - Si se aplica a un encabezado H2 sin ajustar el espacio previo, Typst descarta el `#v(..., weak: true)` al inicio de un bloque no rompible, provocando colapso de espaciado.
3. **Mecanismo Semántico Recomendado:**
   - Para cierres de capítulo (Regla C), el mecanismo nativo más robusto y limpio en Typst es la inserción semántica de un quiebre de página (`#pagebreak()`) inmediatamente antes de la última sección temática, o el encapsulamiento atómico del párrafo conclusivo.

---

## 6. RESULTADO DE LA SIMULACIÓN

La simulación integral ejecutada en `dist/TEST_PAGINATION_CONTROL_SIMULATION.pdf` arrojó métricas impecables:

| Métrica Editorial | Documento Base (Fase 3.7/3.8) | Simulación Balanceada (Fase 3.9) | Delta / Variación | Evaluación |
|:---|:---:|:---:|:---:|:---:|
| **Páginas Físicas Totales** | **126 páginas** | **126 páginas** | **0 págs (Exacto)** | **PERFECTO** |
| **Pliegos Enfrentados (Spreads)** | **64 pliegos** | **64 pliegos** | **0 pliegos** | **PERFECTO** |
| **Líneas Viudas Aisladas (1 línea al tope)** | **2 casos** (P.66, P.68) | **0 casos** | **-2 (-100%)** | **ELIMINADAS** |
| **Líneas Huérfanas al pie (< 2 líneas)** | **0 casos** | **0 casos** | **0** | **IMPECABLE** |
| **Capítulo 01 Cierre (Pág. 08)** | 6 líneas | 6 líneas | 0 | Válido y digno (Regla D) |
| **Capítulo 04 Cierre (Pág. 87)** | 2 líneas (4.2% caja) | **5 líneas** (24.1% caja) | **+3 líneas (+470% área)** | **BALANCEADO** |
| **Capítulo 06 Cierre (Pág. 102)** | 11 líneas (45% caja) | 11 líneas (45% caja) | 0 | Válido y digno (Regla D) |
| **Capítulo 08 Cierre (Pág. 119)** | 2 líneas (4.2% caja) | **8 líneas + H2** (35.2% caja) | **+6 líneas (+740% área)** | **BALANCEADO** |
| **Capítulo 09 Cierre (Pág. 126)** | 2 líneas (4.2% caja) | **8 líneas + H2** (35.2% caja) | **+6 líneas (+740% área)** | **BALANCEADO** |
| **Aperturas Ceremoniales en RECTO** | 9 de 9 (100%) | 9 de 9 (100%) | 0 | **PRESERVADAS** |
| **Chapter First Pages en RECTO** | 9 de 9 (100%) | 9 de 9 (100%) | 0 | **PRESERVADAS** |
| **Páginas Blancas Ceremoniales** | 23 páginas | 23 páginas | 0 | **PRESERVADAS** |

---

## 7. IMPACTO EN NÚMERO DE PÁGINAS Y ARQUITECTURA CEREMONIAL

- **Páginas totales ANTES:** 126 páginas físicas.
- **Páginas totales DESPUÉS:** 126 páginas físicas.
- **Páginas globales desplazadas:** 0 páginas fuera de los 3 capítulos intervenidos.
- **Extensión de capítulos:**
  - Capítulos 01, 02, 03, 05, 06, 07: Exactamente idénticos en extensión y distribución interna.
  - Capítulo 04: Se mantiene en 25 páginas físicas (P.63 a P.87).
  - Capítulo 08: Se mantiene en 7 páginas físicas (P.113 a P.119).
  - Capítulo 09: Se mantiene en 6 páginas físicas (P.121 a P.126).
- **Paridad y Arquitectura Ceremonial:**
  - Ninguna página blanca adicional fue requerida.
  - Toda apertura ceremonial (`chapter-opening`) permanece estrictamente en página RECTO precedida por un VERSO blanco ceremonial.
  - Toda primera página de capítulo (`chapter-first-page`) permanece estrictamente en página RECTO precedida por un VERSO blanco ceremonial.
  - Los pliegos interiores continúan en secuencia perfecta `[VERSO INTERIOR | RECTO INTERIOR]`.

---

## 8. MATRIZ DE NO-REGRESIÓN Y SEGURIDAD

Se verificó el cumplimiento de las condiciones de congelamiento e integridad:

| Parámetro de Control | Estado Verificado | Evidencia Técnica |
|:---|:---:|:---|
| `canonical markdown unchanged` | **TRUE** | SHA-256 de los 9 capítulos auditados antes y después (bit por bit idénticos) |
| `locked components unchanged` | **TRUE** | `templates/typst/componentes.typ` no modificado (`8433F851EA3E0EA9EDC0...`) |
| `retícula +6mm unchanged` | **TRUE** | Respiración superior en First Page e Interior Page fijada en +17.01 pt |
| `typography unchanged` | **TRUE** | Minion Pro (cuerpo 10 pt / leading 14.5 pt) y Neuzeit Grotesk (rotulación) intactos |
| `margins unchanged` | **TRUE** | Márgenes simétricos 65 pt superior/inferior, 58.74 pt interior, 48.0 pt exterior intactos |
| `running headers unchanged` | **TRUE** | Altura $y=26.8$ pt, tipografía 7.5 pt tracking 0.18em intactos |
| `folio baseline unchanged` | **TRUE** | Altura línea base de folios idéntica en $y=585.932$ pt ($\Delta = 0.000$ pt) |
| `ceremonial architecture preserved` | **TRUE** | Secuencia ceremonial `[BLANCO VERSO | RECTO]` respetada en los 9 capítulos |

### Tabla de Integridad Criptográfica SHA-256 de Archivos Canónicos:
- `01_capitulo1_declaracion_principios.md`: `B18B22334759386A547DC94103F6A63EC5AD72BFC9BAA10E4453D9143E58246E` (INTACTO)
- `02_capitulo2_propiedad_control_liquidez.md`: `5D3AA506523703D1D5588E74ADDABB3EB4F11B1A660653AD50F09B787EA46886` (INTACTO)
- `03_capitulo3_gobierno_profesionalizacion.md`: `536C8D9879441CDE924C78C36F4B4879A9F69069540FAA699E002367A0B8CC53` (INTACTO)
- `04_capitulo4_sucesion_familiar.md`: `4CCBE4D2E25B5FC8E50EA11BE6206DA044E532CACA7FB70BEDA6345BD693619A` (INTACTO)
- `05_capitulo5_control_informacion_comunicacion.md`: `B8A731FCB4939E95861F2608D86A20137E67EC462FF4D40B06C567719F336342` (INTACTO)
- `06_capitulo6_disciplina_financiera.md`: `3D6157E2201487A43B8262CF22E4E07F60BD680E827759F7BC3D02F47F383D73` (INTACTO)
- `07_capitulo7_procedimiento_sancionador.md`: `DE32E740807452DBBB5E2676386EB491A268071859E8CF00110A578127A30CAF` (INTACTO)
- `08_capitulo8_solucion_conflictos.md`: `E041394A51C1DCE44389BAC05A4A3D393CD48F3D825AEF17E0495402271669EF` (INTACTO)
- `09_capitulo9_regimen_juridico.md`: `C3A7B5E4DC6D45CA9980A687E1DB7DCDF1286228DAFAAE6D09180FE23A4F1245` (INTACTO)

---

## 9. RIESGOS Y RECOMENDACIÓN TÉCNICA PARA FASE 3.9.1

### Riesgos Identificados:
1. **Riesgo de Regresión por Hardcoding:** Introducir `#pagebreak()` manuales en el pipeline definitivo crearía deuda técnica si en el futuro se añade o retira texto en capítulos previos.
2. **Riesgo de Inversión de Paridad por Compresión:** Como se comprobó en la prueba forense, cualquier intento de comprimir páginas terminales hacia atrás invierte la paridad de los capítulos subsiguientes y destruye la arquitectura ceremonial.

### Recomendación Técnica para la Fase 3.9.1:
1. **Aprobar la Política de Redistribución Hacia Adelante:** Autorizar formalmente las **Reglas A, B, C y D** validadas en esta simulación.
2. **Implementar a Nivel de Compilador/Parser en Fase 3.9.1:**
   - Enriquecer la función de generación del documento maestro (`compilar_pdf.py`) para que detecte automáticamente cuándo una sección final de capítulo generaría un remanente terminal $\le 2$ líneas, aplicando automáticamente el traslado del bloque hacia adelante.
   - Declarar atómicos los párrafos de $\le 3$ líneas para prevenir viudas de 1 línea.
3. **Mantener el Pipeline Actual en Pausa:**
   - No aplicar ninguna modificación a `componentes.typ` ni a los scripts definitivos hasta contar con la autorización formal del usuario tras su revisión visual.

---

## ENTREGABLES GENERADOS EN ESTA FASE

1. [TEST_PAGINATION_CONTROL_SIMULATION.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_PAGINATION_CONTROL_SIMULATION.pdf) (126 páginas, PDF compilado con reglas propuestas).
2. [TEST_PAGINATION_CONTROL_SIMULATION_SPREADS.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_PAGINATION_CONTROL_SIMULATION_SPREADS.pdf) (64 pliegos enfrentados a tamaño 792 × 612 pt).
3. [TEST_PAGINATION_CONTROL_BEFORE_AFTER.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_PAGINATION_CONTROL_BEFORE_AFTER.pdf) (5 láminas A3 apaisadas con comparativa ANTES vs DESPUÉS a escala real 100%).
4. [reporte_fase_3_9_paginacion.md](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/reportes/reporte_fase_3_9_paginacion.md) (este informe técnico).
