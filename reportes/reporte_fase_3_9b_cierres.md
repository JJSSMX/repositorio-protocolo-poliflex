# REPORTE DE FASE 3.9B — MICROPRUEBA FINAL DE CIERRES EDITORIALES
**CAPÍTULOS 04 / 08 / 09**  
**PROTOCOLO FAMILIAR POLIFLEX**  
**Fecha:** 26 de Septiembre de 2026  
**Sistema:** Typst 0.15.1  
**Harness de Prueba:** `scripts/generar_comparativa_cierres_3_9b.py`  
**Estado:** INFORME DE EVALUACIÓN COMPOSITIVA Y FORENSE · PENDIENTE DE SELECCIÓN VISUAL DEL USUARIO

---

## 1. RESUMEN EJECUTIVO Y OBJETIVO DE LA FASE

En cumplimiento estricto de las directrices de la **FASE 3.9B**, se ha llevado a cabo una microprueba compositiva y visual exhaustiva de los cierres de los **Capítulos 04, 08 y 09**, bajo el principio rector de determinar el **grado MÍNIMO de redistribución semántica necesario** para lograr un cierre editorialmente coherente, digno y natural, sin asumir dogmas tipográficos («última página corta = error» o «última sección debe permanecer siempre completa»).

### Condiciones de Seguridad y Congelamiento:
- **`templates/typst/componentes.typ`:** 100% INTACTO (LOCKED). Hash SHA-256 verificado bit a bit (`8433F851EA3E0EA9EDC09759DF25E37F6D95EBF20E0FDBAC072A2E9445E38442`).
- **`/capitulos/*.md`:** 100% READ-ONLY (Hashes SHA-256 originales verificados).
- **Experimento `x.1 +18 pt`:** DESCARTADO Y NO IMPLEMENTADO.
- **Retícula vertical:** Consolidada con +6 mm (+17.01 pt).
- **Extensión global:** Exactamente 126 páginas físicas y 64 pliegos en todas las alternativas.

---

## 2. CAPÍTULO 04: EVALUACIÓN DE CIERRE (PLIEGO 44 · P.86 VERSO | P.87 RECTO)

En el Capítulo 04, el contenido de la Subsección `4.9.4 Documentación y Formalización del Proceso` compite por el espacio final de la página par (P.86).

### 2.1 Comparación de Alternativas:
- **ALTERNATIVA A (Flujo Natural):** P.86 aloja 4 líneas de 4.9.2, la Subsección 4.9.3 completa (11 lín.), el encabezado 4.9.4, su Párrafo 1 completo (5 lín.) y 3 líneas de su Párrafo 2. P.87 recibe exclusivamente las últimas **2 líneas terminales** del Párrafo 2.
- **ALTERNATIVA B (Redistribución Mínima):** Se traslada hacia adelante **únicamente el Párrafo 2 completo de 4.9.4** (5 líneas). P.86 concluye limpiamente con el Párrafo 1 de 4.9.4.

### 2.2 Matriz Forense de Métricas (Capítulo 04)

| PARÁMETRO DE MEDICIÓN | ALTERNATIVA A: FLUJO NATURAL | ALTERNATIVA B: REDISTRIBUCIÓN MÍNIMA | EVALUACIÓN Y DELTA |
|:---|:---:|:---:|:---|
| **Líneas en página anterior (P.86)** | 27 líneas | **24 líneas** | $-3$ líneas trasladadas |
| **Líneas en página terminal (P.87)** | 2 líneas | **5 líneas** (Párrafo 2 completo) | $+3$ líneas recibidas |
| **Cota vertical P.86 (Verso)** | $y = 70.42$ a $527.24$ pt | **$y = 70.42$ a $473.24$ pt** | $-54.00$ pt de altura de bloque |
| **Ocupación vertical P.86** | **96.0%** (456.82 pt útiles) | **84.6%** (402.82 pt útiles) | Densidad plenamente sólida ($\ge 80\%$) |
| **Blanco residual libre P.86** | **19.76 pt** (~1.5 líneas) | **73.76 pt** (~5.8 líneas) | Respiración noble al pie, **NO hueco** |
| **Cota vertical P.87 (Recto)** | $y = 70.42$ a $96.33$ pt | **$y = 70.42$ a $150.33$ pt** | $+54.00$ pt de altura ganada |
| **Ocupación vertical P.87** | **5.4%** (25.91 pt útiles) | **16.8%** (79.91 pt útiles) | $+11.4\%$ de masa tipográfica |
| **Blanco residual libre P.87** | **450.67 pt** (94.6% vacía) | **396.67 pt** (83.2% vacía) | Reducción de vacancia en 54 pt |
| **Unidad semántica trasladada** | Ninguna (quiebre accidental) | **Párrafo 2 de 4.9.4 íntegro** | Traslado mínimo indispensable |
| **Cambio de paridad** | Ninguno (P.86 Verso / P.87 Recto) | Ninguno (P.86 Verso / P.87 Recto) | Paridad ceremonial idéntica |
| **Total Páginas Físicas** | 126 páginas | 126 páginas | Sin impacto en paginación |

### 2.3 Dictamen Editorial sobre Capítulo 04:
> [!TIP]
> **RECOMENDACIÓN TÉCNICA: ALTERNATIVA B (REDISTRIBUCIÓN MÍNIMA).**  
> 1. **P.86 no sufre ningún hueco visual:** Conserva una ocupación del **84.6%** (24 líneas sólidas) y concluye de manera natural en un punto y aparte legítimo (cierre del Párrafo 1 de 4.9.4). El blanco residual inferior de 73.76 pt (~2.6 cm) es completamente estándar para un pie de página editorial.
> 2. **P.87 gana dignidad jurídica:** En lugar de 2 líneas amputadas y descontextualizadas (5.4%), aloja una cláusula dispositiva completa de 5 líneas con sentido autónomo («Concluido el procedimiento y cumplidas las condiciones previstas en este Capítulo, el órgano de administración...»), alcanzando el 16.8% de ocupación.

---

## 3. CAPÍTULO 08: EVALUACIÓN CUADRÍPTICA (PLIEGO 60 · P.118 VERSO | P.119 RECTO)

Este es el **caso prioritario** de la prueba. En P.118 convergen tres secciones consecutivas:
- `8.7 Efectos de la Mediación y del Arbitraje` (H2 + 2 párrafos = 6 líneas).
- `8.8 Prohibición de Judicialización Prematura` (H2 + 3 párrafos = 8 líneas).
- `8.9 Coordinación con el Régimen Sancionador` (H2 + 3 párrafos = 7 líneas).

### 3.1 Descripción de las Cuatro Alternativas:
- **ALTERNATIVA A (Flujo Natural):** P.118 aloja 8.7, 8.8 y 8.9 (H2 + P1 + P2). P.119 recibe exclusivamente el **Párrafo 3 de 8.9 (2 líneas)**.
- **ALTERNATIVA B (Párrafo 1 con Heading):** P.118 mantiene unidos `8.9 + Párrafo 1` (2 líneas). P.119 recibe los **Párrafos 2 y 3 de 8.9 (5 líneas)**.
- **ALTERNATIVA C (Redistribución Intermedia):** Se parte en la Sección 8.8: P.118 aloja 8.7 y 8.8 (P1 y P2). P.119 recibe **8.8 Párrafo 3 (2 líneas) + Sección 8.9 completa (11 líneas) = 13 líneas**.
- **ALTERNATIVA D (Sección 8.9 Completa · Fase 3.9):** P.118 aloja 8.7 y 8.8 completos. P.119 recibe la **Sección 8.9 íntegra (H2 + 3 párrafos = 11 líneas / 8 de cuerpo)**.

### 3.2 Matriz Forense Comparativa Cuadríptica (Capítulo 08)

| PARÁMETRO DE EVALUACIÓN | A. FLUJO NATURAL | B. P1 CON HEADING | C. REDISTRIB. INTERMEDIA | D. SECCIÓN COMPLETA |
|:---|:---:|:---:|:---:|:---:|
| **Líneas en P.118 (Verso)** | 25 líneas (3 H2 + 19 lín.) | 22 líneas (3 H2 + 16 lín.) | 17 líneas (2 H2 + 12 lín.) | **19 líneas (2 H2 + 14 lín.)** |
| **Líneas en P.119 (Recto)** | 2 líneas (solo P3 de 8.9) | 5 líneas (P2 + P3 de 8.9) | 13 líneas (8.8 P3 + 8.9) | **11 líneas (H2 8.9 + 3 párrafos)** |
| **Cota vertical P.118** | $y = 70.25$ a $515.36$ pt | $y = 70.25$ a $461.36$ pt | $y = 70.25$ a $343.81$ pt | **$y = 70.25$ a $379.81$ pt** |
| **Ocupación vertical P.118** | **93.5%** (445.11 pt) | **82.2%** (391.11 pt) | **57.5%** (273.56 pt) | **65.0%** (309.56 pt) |
| **Blanco residual P.118** | **31.64 pt** libres | **85.64 pt** libres | **203.19 pt** libres | **167.19 pt** libres |
| **Cota vertical P.119** | $y = 70.42$ a $96.33$ pt | $y = 70.42$ a $150.33$ pt | $y = 70.42$ a $267.88$ pt | **$y = 70.25$ a $208.26$ pt** |
| **Ocupación vertical P.119** | **5.4%** (25.91 pt) | **16.8%** (79.91 pt) | **41.5%** (197.46 pt) | **29.0%** (138.01 pt) |
| **Blanco residual P.119** | **450.67 pt** (94.6% vacía) | **396.67 pt** (83.2% vacía) | **279.12 pt** (58.5% vacía) | **338.74 pt** (71.0% vacía) |
| **Fragmentación de Secciones** | **FRACTURADA (8.9)** | **FRACTURADA (8.9)** | **FRACTURADA (8.8)** | **0% FRAGMENTACIÓN** |
| **Encabezado H2 en P.119** | AUSENTE (en P.118) | AUSENTE (en P.118) | PRESENTE (tras 8.8 P3) | **PRESENTE (corona página)** |
| **Continuidad de Lectura** | Corta antes de última lín. | Corta tras primer párrafo | Corta sección 8.8 | **Limpia entre secciones** |
| **Naturalidad del Salto** | Mecánica accidental | Artificial intra-sección | Ilógica (mutila 8.8) | **Pausa formal inter-sección** |
| **Total Páginas Físicas** | 126 páginas | 126 páginas | 126 páginas | 126 páginas |
| **Cambio de Paridad** | Ninguno | Ninguno | Ninguno | Ninguno |

### 3.3 Evaluación Detallada de los Criterios Editoriales en Capítulo 08:

1. **Equilibrio Visual del Spread P.118 | P.119:**
   - **Alternativa A (93.5% vs 5.4%):** Severamente desbalanceado. La página izquierda está casi colapsada y la derecha casi vacía.
   - **Alternativa B (82.2% vs 16.8%):** Proporción aritmética aceptable en líneas (22 vs 5).
   - **Alternativa C (57.5% vs 41.5%):** El equilibrio numérico más cercano, pero obtenido a costa de quebrar la Sección 8.8 de manera inaceptable.
   - **Alternativa D (65.0% vs 29.0%):** Proporción áurea clásica (relación ~2:1 entre Verso y Recto de cierre). Ambas páginas lucen intencionales y armónicas.
2. **Blanco Residual y Masa Tipográfica:**
   - En **B**, P.118 tiene 85.64 pt de blanco y P.119 tiene 79.91 pt de masa tipográfica.
   - En **D**, P.118 tiene 167.19 pt de blanco (concluye con 8.8) y P.119 tiene 138.01 pt de masa tipográfica con su H2.
3. **Fragmentación y Jerarquía Institucional:**
   - La **Alternativa B fragmenta la Sección 8.9**: Coloca el título `8.9 Coordinación con el Régimen Sancionador` al fondo de P.118 para gobernar un único párrafo de 2 líneas, obligando a P.119 a abrir sin título normativo.
   - La **Alternativa D respeta la integridad de la unidad temática**: La Sección 8.9 abre, se desarrolla y concluye íntegramente en P.119.

### 3.4 Dictamen Editorial sobre Capítulo 08:
> [!IMPORTANT]
> **JUICIO COMPARATIVO ENTRE ALTERNATIVAS B Y D:**  
> - Si la máxima prioridad del usuario fuera **minimizar el blanco residual de P.118**, la **Alternativa B** es técnicamente viable (deja 82.2% en P.118 y 16.8% en P.119), asumiendo el costo editorial de fragmentar la Sección 8.9 y dejar a P.119 sin encabezado.
> - Si la prioridad fuera la **solemnidad jurídica y la elegancia editorial**, la **Alternativa D es claramente superior**: el blanco de 167 pt en P.118 coincide con el fin natural de la Sección 8.8, y P.119 se presenta como un bloque normativo perfecto, coronado por su H2 en Minion Pro.
> - La **Alternativa C queda descartada** por romper artificialmente la Sección 8.8.

---

## 4. CAPÍTULO 09: EVALUACIÓN DE CIERRE (PLIEGOS 63 Y 64 · P.125 RECTO | P.126 VERSO)

El Capítulo 09 culmina con la clausura normativa de todo el Protocolo Familiar POLIFLEX.

### 4.1 Comparación de Alternativas:
- **ALTERNATIVA A (Flujo Natural):** P.125 aloja 9.6, 9.7 y el inicio de 9.8 (H2 + P1 + P2). P.126 (última página física de la obra) recibe únicamente las **2 líneas terminales** del Párrafo 3 de 9.8.
- **ALTERNATIVA B (Sección 9.8 Completa · Fase 3.9):** P.125 concluye con la Sección 9.7 completa. P.126 aloja la **Sección 9.8 completa** (H2 + 3 párrafos normativos).

### 4.2 Matriz Forense de Métricas (Capítulo 09)

| PARÁMETRO DE MEDICIÓN | ALTERNATIVA A: FLUJO NATURAL | ALTERNATIVA B: SECCIÓN 9.8 COMPLETA | EVALUACIÓN Y DELTA |
|:---|:---:|:---:|:---|
| **Líneas en P.125 (Recto)** | 24 líneas (9.6, 9.7 e inicio de 9.8) | **18 líneas (9.6 y 9.7 completas)** | $-6$ líneas trasladadas |
| **Cota vertical P.125** | $y = 70.42$ a $520.98$ pt | **$y = 70.42$ a $385.43$ pt** | $-135.55$ pt de altura de bloque |
| **Ocupación vertical P.125** | **94.7%** (450.56 pt útiles) | **66.2%** (315.01 pt útiles) | Respiración inferior de sección |
| **Blanco residual P.125** | **26.02 pt** (~2 líneas) | **161.57 pt** (~12.7 líneas) | Pausa lógica inter-sección |
| **Líneas en P.126 (Verso - Cierre)** | 2 líneas terminales (solo fin de P3) | **11 líneas (H2 + 3 párrafos = 8 lín. cuerpo)** | $+6$ líneas ganadas con H2 |
| **Cota vertical P.126** | $y = 70.42$ a $96.33$ pt | **$y = 70.25$ a $208.26$ pt** | $+111.93$ pt de masa tipográfica |
| **Ocupación vertical P.126** | **5.4%** (25.91 pt útiles) | **29.0%** (138.01 pt útiles) | Ocupación noble y colofón solemne |
| **Blanco residual P.126** | **450.67 pt** (94.6% vacía) | **338.74 pt** (71.0% libre) | Reducción de vacancia en 112 pt |
| **Fragmentación de Sec. 9.8** | **GRAVE (partida entre pliegos)** | **0% FRAGMENTACIÓN (íntegra en P.126)** | Bloque de clausura preservado |
| **Encabezado H2 en P.126** | AUSENTE (quedó en P.125) | **PRESENTE al tope** | Jerarquía visual restaurada |
| **Total Páginas Físicas** | 126 páginas | 126 páginas | Paridad exacta |

### 4.3 Dictamen Editorial sobre Capítulo 09:
> [!TIP]
> **RECOMENDACIÓN TÉCNICA: ALTERNATIVA B (SECCIÓN 9.8 COMPLETA).**  
> En la clausura de una obra institucional solemne como el Protocolo Familiar, terminar el libro con 2 líneas perdidas en un pliego en blanco (Pliego 64) denota un error de composición tipográfica. La Alternativa B confiere al libro un **cierre digno, ordenado y autosuficiente** (29.0% de ocupación, H2 visible y los 3 párrafos articulados), aprovechando el blanco de P.125 como un respiro deliberado tras la sanción de nulidad de la Sección 9.7.

---

## 5. TABLA RESUMEN GENERAL DE DECISIÓN POR CAPÍTULO

| CAPÍTULO | ALTERNATIVA NATURAL (A) | ALTERNATIVA MÍNIMA (B) | OTRAS VARIANTES | RECOMENDACIÓN TÉCNICA |
|:---:|:---|:---|:---|:---|
| **CAP 04** | P.86: 96.0% \| P.87: 5.4% (2 lín.) | **P.86: 84.6% \| P.87: 16.8% (5 lín.)** | — | **APROBAR ALTERNATIVA B** (Trasladar 4.9.4 P2) |
| **CAP 08** | P.118: 93.5% \| P.119: 5.4% (2 lín.) | P.118: 82.2% \| P.119: 16.8% (5 lín.) | C: 57.5% / 41.5%<br>**D: 65.0% / 29.0% (8.9 completa)** | **DECISIÓN USUARIO: B o D** (Recomendado D por 0% fragmentación) |
| **CAP 09** | P.125: 94.7% \| P.126: 5.4% (2 lín.) | **P.125: 66.2% \| P.126: 29.0% (11 lín.)** | — | **APROBAR ALTERNATIVA B** (Sección 9.8 completa) |

---

## 6. ENTREGABLES DISPONIBLES PARA REVISIÓN VISUAL

1. [TEST_CIERRES_04_08_09_COMPARATIVA.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CIERRES_04_08_09_COMPARATIVA.pdf)  
   *Documento comparativo maestro de 4 láminas A3 apaisadas (238,081 bytes).*
   - **Lámina 01:** Capítulo 04 — Pliego 44 `[P.86 | P.87]` (Alternativa A vs B).
   - **Lámina 02:** Capítulo 08 — Pliego 60 `[P.118 | P.119]` (Cuadríptica A / B / C / D).
   - **Lámina 03:** Capítulo 08 — Matriz forense de evaluación y criterios editoriales.
   - **Lámina 04:** Capítulo 09 — Pliegos 63 y 64 (Alternativa A vs B).
2. **Artefactos PNG de Alta Resolución (Visualización Directa):**
   - [cierre_comparativa_lamina_01.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/cierre_comparativa_lamina_01.png) (Capítulo 04: Pliego 44 A vs B).
   - [cierre_comparativa_lamina_02.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/cierre_comparativa_lamina_02.png) (Capítulo 08: Cuadríptica A / B / C / D).
   - [cierre_comparativa_lamina_03.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/cierre_comparativa_lamina_03.png) (Capítulo 08: Matriz Forense y Criterios).
   - [cierre_comparativa_lamina_04.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/cierre_comparativa_lamina_04.png) (Capítulo 09: Pliegos 63 y 64 A vs B).
3. **PDFs de Spreads Específicos:**
   - [TEST_CAP04_B_SPREADS.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CAP04_B_SPREADS.pdf) (Pliego 44 con 4.9.4 P2 trasladado).
   - [TEST_CAP08_B_SPREADS.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CAP08_B_SPREADS.pdf) (Pliego 60 con 8.9 P1 en P.118).
   - [TEST_CAP08_C_SPREADS.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CAP08_C_SPREADS.pdf) (Pliego 60 con 8.8 P3 en P.119).
   - [TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1_SPREADS.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_1_SPREADS.pdf) (Pliego 60 con 8.9 completa; Pliegos 63-64 con 9.8 completa).
   - [TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_PROTOCOLO_CAPITULOS_01_09_SPREADS.pdf) (Spreads de flujo natural).

---

## 7. CONCLUSIÓN Y ESTADO DE DETENCIÓN

La microprueba ha finalizado con éxito técnico y forense pleno. **NO se ha modificado ningún archivo de producción ni ninguna fuente canónica.**

Se detiene la ejecución a la espera de que el usuario revise visualmente las alternativas en las láminas y seleccione la combinación definitiva para la consolidación de la Fase 3.9.1.
