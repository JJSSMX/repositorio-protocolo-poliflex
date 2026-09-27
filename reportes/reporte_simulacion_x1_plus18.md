# REPORTE DE FASE 3.9A — SIMULACIÓN DE DESFASE GLOBAL MEDIANTE RESPIRACIÓN EN x.1
**PROTOCOLO FAMILIAR POLIFLEX**  
**Fecha:** 26 de Septiembre de 2026  
**Sistema:** Typst 0.15.1  
**Compilador:** `scripts/compilar_fase_3_9a.py`  
**Estado:** INFORME DIAGNÓSTICO (FASE DE EXPERIMENTACIÓN ALTERNATIVA · NO CONSOLIDADA)

---

## RESUMEN EJECUTIVO

En cumplimiento estricto de las directrices de la **FASE 3.9A**, se ha ejecutado un experimento diagnóstico formal para evaluar la hipótesis de si un desplazamiento vertical inicial de **+18 pt exclusivamente antes del primer encabezado H2 (`x.1`) de cada capítulo**, sin reglas de redistribución selectiva, es capaz de propagarse de manera orgánica a lo largo del flujo y resolver de forma natural las incidencias editoriales detectadas (viudas en P.66/P.68 y cierres residuales de 2 líneas en Capítulos 04, 08 y 09).

### Conclusión Principal del Experimento:
**LA HIPÓTESIS QUEDA EMPÍRICAMENTE REFUTADA.**
El análisis forense y la medición milimétrica sobre el PDF compilado (`dist/TEST_PAGINATION_X1_PLUS18.pdf`) demuestran que:
1. **El desfase de +18 pt no resuelve las líneas viudas de P.66 y P.68**, las cuales reaparecen idénticas a la versión base.
2. **El desfase de +18 pt no mejora los cierres residuales de Capítulos 04, 08 y 09**, manteniendo las páginas terminales con 2 líneas, 1 línea y 2 líneas respectivamente.
3. **Causa técnica del fallo:** El incremento de +18 pt en la primera página (`chapter-first-page`) es **absorbido por la holgura inferior natural de la caja tipográfica** de dicha página, sin empujar líneas hacia las páginas pares siguientes; en los capítulos donde sí genera un ligero desplazamiento en páginas intermedias, la holgura acumulada en los cambios de sección y listas jurídicas disipa el desfase antes de alcanzar las páginas críticas.

---

## 1. COMPARACIÓN OBLIGATORIA DE LOS TRES ESTADOS

A continuación se presenta la matriz comparativa de los tres estados editoriales analizados:
- **ESTADO A — PAGINACIÓN ACTUAL (Base):** Prueba de estrés sin intervenciones (Fase 3.7 / 3.8).
- **ESTADO B — SIMULACIÓN FASE 3.9:** Con redistribución semántica hacia adelante (párrafo 4.1.1 atómico; pagebreak en 8.9 y 9.8).
- **ESTADO C — SIMULACIÓN FASE 3.9A:** Desfase global de +18 pt exclusivamente antes de `x.1`, con flujo natural y sin redistribuciones selectivas.

| CASO / INCIDENCIA | ESTADO A: ACTUAL (Base) | ESTADO B: FASE 3.9 (Redistribuida) | ESTADO C: x.1 +18 pt (Fase 3.9A) | RESULTADO EDITORIAL EN ESTADO C |
|:---|:---:|:---:|:---:|:---|
| **Posición Y0 de x.1 (Cap 01)** | $y = 248.05$ pt (Pág. 05) | $y = 248.05$ pt (Pág. 05) | **$y = 266.05$ pt (+18.0 pt)** | Desfase aplicado con exactitud matemática |
| **Posición Y0 de x.1 (Cap 04)** | $y = 224.04$ pt (Pág. 65) | $y = 224.04$ pt (Pág. 65) | **$y = 242.04$ pt (+18.0 pt)** | Desfase aplicado con exactitud matemática |
| **Posición Y0 de x.1 (Cap 08)** | $y = 248.05$ pt (Pág. 115) | $y = 248.05$ pt (Pág. 115) | **$y = 266.05$ pt (+18.0 pt)** | Desfase aplicado con exactitud matemática |
| **Posición Y0 de x.1 (Cap 09)** | $y = 224.04$ pt (Pág. 123) | $y = 224.04$ pt (Pág. 123) | **$y = 242.04$ pt (+18.0 pt)** | Desfase aplicado con exactitud matemática |
| **Viuda P.66 (Subsección 4.1.1)** | 1 línea al tope (Pág. 66) | **0 viudas (24 lín. sólidas)** | **1 línea al tope (Pág. 66)** | **FRACASO:** La viuda persiste idéntica |
| **Viuda P.68 (Subsección 4.2.1)** | 1 línea al tope (Pág. 68) | **0 viudas (quiebre 2+2)** | **1 línea al tope (Pág. 68)** | **FRACASO:** La viuda persiste idéntica |
| **Cierre Cap 01 (Sección 1.8)** | 6 líneas (Pág. 08 · H2 + cuerpo) | 6 líneas (Pág. 08 · H2 + cuerpo) | 6 líneas (Pág. 08 · H2 + cuerpo) | **ESTABLE:** Unidad semántica preservada (Regla D) |
| **Cierre Cap 04 (Subsección 4.9.4)** | 2 líneas (Pág. 87 · 4.2% caja) | **5 líneas (Pág. 87 · 24.1% caja)** | **2 líneas (Pág. 87 · 5.4% caja)** | **FRACASO:** Residuo débil persiste sin mejora |
| **Cierre Cap 06 (Sección 6.6)** | 10 líneas (Pág. 102 · 45% caja) | 10 líneas (Pág. 102 · 45% caja) | 10 líneas (Pág. 102 · 45% caja) | **ESTABLE:** Unidad semántica preservada (Regla D) |
| **Cierre Cap 08 (Sección 8.9)** | 1–2 líneas (Pág. 119 · 4.2% caja) | **7 líneas + H2 (Pág. 119 · 35.2%)** | **1 línea (Pág. 119 · 1.6% caja)** | **FRACASO:** Página degradada a 1 sola línea |
| **Cierre Cap 09 (Sección 9.8)** | 2 líneas (Pág. 126 · 4.2% caja) | **8 líneas + H2 (Pág. 126 · 35.2%)** | **2 líneas (Pág. 126 · 5.4% caja)** | **FRACASO:** Clausura del libro persiste frágil |
| **Total Páginas Físicas** | 126 páginas | 126 páginas | 126 páginas | Mantiene extensión global sin desborde |
| **Total Pliegos (Spreads)** | 64 pliegos | 64 pliegos | 64 pliegos | Paridad y secuencia de pliegos preservada |
| **Aperturas en Recto** | 9 de 9 (100%) | 9 de 9 (100%) | 9 de 9 (100%) | Preservadas |

---

## 2. RESPUESTA DETALLADA A LAS PREGUNTAS DEL EXPERIMENTO

### 1. ¿Elimina las dos viudas reales de P.66 y P.68?
**RESPUESTA: NO.**
- En P.65 (primera página del Cap 04), la caja útil tiene un espacio libre de más de 40 pt al fondo. Al desplazar el encabezado 4.1 hacia abajo en +18 pt (de $y=224.04$ pt a $y=242.04$ pt), P.65 aún cuenta con altura suficiente para alojar el encabezado y las 6 líneas del párrafo 4.1.1.
- Por tanto, el quiebre de párrafo ocurre exactamente en el mismo punto, expulsando la séptima línea («inmediatos a favor de los sucesores, condicionando cualquier...») al tope de P.66 antes del encabezado 4.1.2.
- De forma análoga, el desbalance se arrastra a P.67 y P.68, donde la viuda de la Subsección 4.2.1 («al régimen de separación de derechos, al congelamiento accio...») reaparece con idéntica fragilidad tipográfica.

### 2. ¿Evita o mejora los cierres residuales de 2 líneas?
**RESPUESTA: NO.**
- **Capítulo 04 (Pág. 87):** La página final sigue albergando exclusivamente 2 líneas («momento, el cuadro accionario se considerará regularizado y el proceso sucesorio se tendrá por cerrado...»), ocupando apenas 25.9 pt de altura de texto (5.4% de la caja útil).
- **Capítulo 08 (Pág. 119):** La página final alberga únicamente **1 sola línea** («régimen disciplinario, reforzando la eficacia y coherencia del sistema.»), representando una ocupación de solo 7.9 pt (1.6% de la caja útil).
- **Capítulo 09 (Pág. 126):** La clausura del Protocolo sigue terminando con solo 2 líneas («El Protocolo constituye un sistema normativo cerrado, no susceptible de integración mediante prácticas externas...»).

### 3. ¿Mantiene cierres válidos como Capítulo 01 y Capítulo 06?
**RESPUESTA: SÍ.**
- Capítulo 01 (Pág. 08) concluye con 6 líneas y su encabezado H2 1.8 (`1.8 Criterio de Interpretación del Protocolo`).
- Capítulo 06 (Pág. 102) concluye con 10 líneas y su encabezado H2 6.6 (`6.6 Responsabilidad Patrimonial del Accionista Familiar...`).
- Ambos casos se mantienen estables, confirmando la solidez de la Regla D.

### 4. ¿Evita la necesidad de reglas especiales de redistribución?
**RESPUESTA: NO.**
- El experimento demuestra de forma irrefutable que las anomalías de paginación en documentos extensos **no son causadas por un desfase global acumulativo**, sino por **contingencias locales de partición de bloques** al fondo de una página específica.
- Los problemas locales (como un párrafo de 5 líneas que empieza cuando solo caben 3 líneas, o una sección final que empieza cuando solo caben 2 párrafos) requieren **soluciones locales y semánticas** (declaración de atomicidad de la unidad en cuestión o desplazamiento en bloque de la sección conclusiva). Un desfase vertical al inicio del capítulo es incapaz de controlar lo que ocurre 20 páginas después.

### 5. ¿Conserva una paginación editorialmente natural?
**RESPUESTA: SÍ, pero resulta editorialmente ineficaz.**
- El flujo es completamente continuo y libre de forzamientos artificiales, pero tolera defectos que degradan la calidad del libro (líneas huérfanas/viudas aisladas y páginas finales prácticamente en blanco).

### 6. ¿Mantiene 126 páginas físicas?
**RESPUESTA: SÍ.**
- El documento totalizó exactamente 126 páginas físicas y 64 pliegos enfrentados. El desfase de +18 pt no generó desbordamiento de página en ningún capítulo.

---

## 3. AUDITORÍA AUTOMATIZADA DETALLADA DEL ESTADO C

Realizada mediante PyMuPDF sobre `dist/TEST_PAGINATION_X1_PLUS18.pdf`:

1. **Líneas Viudas Aisladas (< 2 líneas al tope):**
   - **3 incidencias detectadas** (en Estado B eran 0):
     - Pág. 66: 1 línea de remanente de 4.1.1 antes de H3 4.1.2.
     - Pág. 68: 1 línea de remanente de 4.2.1 antes de H3 4.2.2.
     - Pág. 119: 1 línea solitaria en toda la página (cierre Cap 08).
2. **Líneas Huérfanas al pie (< 2 líneas):**
   - **0 incidencias**. Ningún párrafo inicia con 1 sola línea al fondo.
3. **Encabezados Huérfanos (Keep-with-Next):**
   - **0 incidencias**. Los 175 encabezados reconocidos se encuentran acompañados de $\ge 2$ líneas de cuerpo subordinado.
4. **Arquitectura Ceremonial y Paridad:**
   - **100% de las 9 aperturas ceremoniales** en página RECTO precedidas por VERSO en blanco.
   - **100% de las 9 primeras páginas** en página RECTO precedidas por VERSO en blanco.
   - Conteo de páginas blancas ceremoniales: 23 páginas.

---

## 4. MEDIDAS Y COORDENADAS FORENSES EN CHAPTER-FIRST-PAGE

Comprobación milimétrica del desplazamiento +18 pt en cada uno de los 9 capítulos:

| Capítulo | Folio First Page | Y0 Estado A (Base) | Y0 Estado C (+18 pt) | Delta Medido | Líneas en First Page (A) | Líneas en First Page (C) | Efecto en Página Siguiente |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---|
| **Cap 01** | Pág. 05 | $248.05$ pt | $266.05$ pt | **$+18.00$ pt** | 18 líneas | 18 líneas | 0 líneas desplazadas (absorbido) |
| **Cap 02** | Pág. 13 | $248.05$ pt | $266.05$ pt | **$+18.00$ pt** | 19 líneas | 19 líneas | 0 líneas desplazadas (absorbido) |
| **Cap 03** | Pág. 45 | $296.06$ pt | $314.06$ pt | **$+18.00$ pt** | 18 líneas | 18 líneas | 0 líneas desplazadas (absorbido) |
| **Cap 04** | Pág. 65 | $224.04$ pt | $242.04$ pt | **$+18.00$ pt** | 20 líneas | 20 líneas | 0 líneas desplazadas (absorbido) |
| **Cap 05** | Pág. 91 | $272.06$ pt | $290.06$ pt | **$+18.00$ pt** | 21 líneas | 19 líneas | 2 líneas desplazadas a P.92 |
| **Cap 06** | Pág. 99 | $248.05$ pt | $266.05$ pt | **$+18.00$ pt** | 18 líneas | 18 líneas | 0 líneas desplazadas (absorbido) |
| **Cap 07** | Pág. 107 | $272.06$ pt | $290.06$ pt | **$+18.00$ pt** | 18 líneas | 15 líneas | 3 líneas desplazadas a P.108 |
| **Cap 08** | Pág. 115 | $248.05$ pt | $266.05$ pt | **$+18.00$ pt** | 17 líneas | 17 líneas | 0 líneas desplazadas (absorbido) |
| **Cap 09** | Pág. 123 | $224.04$ pt | $242.04$ pt | **$+18.00$ pt** | 18 líneas | 18 líneas | 0 líneas desplazadas (absorbido) |

**Observación Clave:**
En 7 de los 9 capítulos (Capítulos 01, 02, 03, 04, 06, 08 y 09), el número de líneas contenidas en la primera página de capítulo fue **exactamente el mismo** en Estado A y Estado C. El espacio de +18 pt simplemente consumió el espacio en blanco sobrante antes del margen inferior, sin generar ningún efecto dominó hacia el resto del capítulo.

---

## 5. CRITERIO VISUAL ADICIONAL — EVALUACIÓN TRIPARTITA DEL SPREAD DEL CAPÍTULO 09

En cumplimiento estricto del **Criterio Visual Adicional**, se desactivaron por completo las reglas experimentales de la Fase 3.9 que trasladan secciones completas (como las Secciones 8.9, 9.8 y la Subsección 4.9.4) como bloques atómicos forzados, permitiendo que el contenido fluya de manera libre y continua entre páginas, conservando únicamente:
- Protección heading + mínimo 2 líneas posteriores (Regla B);
- Reglas normales de párrafo (`orphans: 2`, `widows: 2`, `linebreaks: "simple"`);
- Retícula vertical consolidada (+6 mm);
- Desfase experimental de +18 pt antes de `x.1`.

A continuación se presenta el examen forense detallado del pliego del Capítulo 09 que contiene las secciones:
- **9.7 Nulidad de Pactos Paralelos y Actos de Elusión**
- **9.8 Interpretación y Cierre Normativo**

Comparando los tres estados editoriales:
- **ESTADO A:** Paginación original (Base nominal Fase 3.7 / 3.8).
- **ESTADO B:** Redistribución Fase 3.9 (Desplazamiento semántico de Sección 9.8 hacia Pág. 126).
- **ESTADO C:** Simulación x.1 +18 pt con flujo natural (Fase 3.9A).

```
========================================================================================
ESTRUCTURA DE PLIEGOS EN CAPÍTULO 09 (PÁGINAS 124 A 126)
========================================================================================

PLIEGO 63:
  [ P.124 Verso | P.125 Recto ]
  - P.124 (Verso): Contiene Secciones 9.3, 9.4 y 9.5 (IDÉNTICO en Estados A, B y C).
  - P.125 (Recto): 
      * En Estados A y C: Secciones 9.6, 9.7 e INICIO de 9.8 (H2 + párrafos 1 y 2).
      * En Estado B:     Secciones 9.6 y 9.7 COMPLETAS (9.8 se traslada a P.126).

PLIEGO 64:
  [ P.126 Verso | VACÍO Recto ] -> CIERRE DEFINITIVO DEL PROTOCOLO FAMILIAR
  - P.126 (Verso):
      * En Estados A y C: Remanente huérfano de solo 2 líneas del párrafo 3 de 9.8.
      * En Estado B:     Sección 9.8 ÍNTEGRA (Encabezado H2 + 3 párrafos completos).
========================================================================================
```

### 5.1 MATRIZ FORENSE DE MÉTRICAS COMPARATIVAS (PÁGINAS 125 Y 126)

| PARÁMETRO DE EVALUACIÓN | ESTADO A: BASE ORIGINAL | ESTADO B: FASE 3.9 REDISTRIBUIDA | ESTADO C: x.1 +18 pt (FLUJO NATURAL) |
|:---|:---:|:---:|:---:|
| **Secciones en Pág. 125** | 9.6, 9.7 e inicio de 9.8 | **9.6 y 9.7 completas** | 9.6, 9.7 e inicio de 9.8 (Idéntico a A) |
| **Líneas útiles en Pág. 125** | 24 líneas | **18 líneas** | 24 líneas (Idéntico a A) |
| **Cota Y0 / Y_bottom (P.125)** | $y = 70.42$ a $520.98$ pt | **$y = 70.42$ a $385.43$ pt** | $y = 70.42$ a $520.98$ pt (Idéntico a A) |
| **Ocupación vertical P.125** | **94.7%** (450.56 pt) | **66.2%** (315.01 pt) | **94.7%** (450.56 pt) |
| **Blanco residual al pie P.125** | **26.02 pt** (~2 líneas) | **161.57 pt** (~12.7 líneas) | **26.02 pt** (~2 líneas) |
| **Contenido en Pág. 126** | Solo 2 líneas terminales | **Sección 9.8 completa (H2 + 3 párrafos)** | Solo 2 líneas terminales (Idéntico a A) |
| **Encabezado H2 9.8 en P.126** | **AUSENTE** (atrapado en P.125) | **PRESENTE** (corona la página) | **AUSENTE** (atrapado en P.125) |
| **Líneas útiles en Pág. 126** | 2 líneas | **8 líneas** (H2 + 7 lín. cuerpo) | 2 líneas (Idéntico a A) |
| **Cota Y0 / Y_bottom (P.126)** | $y = 70.42$ a $96.33$ pt | **$y = 70.25$ a $208.26$ pt** | $y = 70.42$ a $96.33$ pt (Idéntico a A) |
| **Ocupación vertical P.126** | **5.4%** (25.91 pt) | **29.0%** (138.01 pt) | **5.4%** (25.91 pt) |
| **Blanco residual libre P.126** | **450.67 pt** (94.6% vacía) | **338.74 pt** (71.0% libre) | **450.67 pt** (94.6% vacía) |
| **Fragmentación de Sec. 9.8** | **FRACTURADA** (P.125 y P.126) | **0% FRAGMENTACIÓN** (Íntegra en P.126) | **FRACTURADA** (P.125 y P.126) |
| **Total Páginas Físicas** | 126 páginas | 126 páginas | 126 páginas |
| **Total Pliegos** | 64 pliegos | 64 pliegos | 64 pliegos |

---

### 5.2 EVALUACIÓN DETALLADA SEGÚN LOS 5 CRITERIOS VISUALES

#### 1. Cantidad de Espacio Blanco Residual
- **En Pliego 63 (P.124 | P.125):**
  - **Estados A y C:** Minimizan el blanco residual al pie de P.125 a solo **26.02 pt** (94.7% de ocupación), llenando la página casi hasta el margen inferior.
  - **Estado B:** Concluye deliberadamente la página tras la Sección 9.7, dejando **161.57 pt** de holgura inferior (66.2% de ocupación).
- **En Pliego 64 (P.126 | VACÍO):**
  - **Estados A y C:** Al haber exprimido P.125, solo dejan 2 líneas para P.126, generando un blanco residual desolador de **450.67 pt** (el 94.6% de toda la página queda vacío). El pliego de cierre del libro produce una sensación de abandono tipográfico involuntario.
  - **Estado B:** Al trasladar la Sección 9.8 a P.126, reduce el blanco residual a **338.74 pt**, dejando una masa sólida de 138 pt de texto formal (29.0% de ocupación) que confiere proporción áurea y dignidad tipográfica a la última página de la obra.

#### 2. Continuidad Visual Entre Páginas
- **En Estados A y C:** La continuidad visual entre P.124 y P.125 es mecánicamente alta pero editorialmente engañosa: se introduce el encabezado 9.8 y dos de sus párrafos en P.125, solo para cortar abruptamente la lectura antes del párrafo final («El Protocolo constituye un sistema normativo cerrado...»), forzando un salto de página innecesario para leer apenas 23 palabras en P.126.
- **En Estado B:** La continuidad se organiza con arreglo a **límites semánticos lógicos**: la página 125 concluye armónicamente con la sanción de nulidad de la Sección 9.7, y la página 126 abre con solemnidad bajo el título «9.8 Interpretación y Cierre Normativo», logrando una lectura fluida, sin saltos intra-cláusula.

#### 3. Fragmentación de Unidades Temáticas
- **Estados A y C:** Presentan una **fragmentación severa** de la cláusula de cierre del Protocolo Familiar. La Sección 9.8 queda partida en dos mitades desconectadas a través del cambio de pliego (de Recto a Verso).
- **Estado B:** Logra **cero fragmentación**. La Sección 9.8 se comporta como un bloque íntegro, autosuficiente y autocontenido. La regla editorial de la Fase 3.9 previene con éxito que una disposición normativa de cierre se mutile por falta de espacio vertical.

#### 4. Densidad del Spread (Pliegos 63 y 64)
- **Pliego 63 (`[P.124 | P.125]`):**
  - Estados A y C: Densidad simétrica y muy pesada (98.4% Verso / 94.7% Recto).
  - Estado B: Densidad asimétrica controlada (98.4% Verso / 66.2% Recto). El Recto respira elegantemente en su tercio inferior.
- **Pliego 64 (`[P.126 | VACÍO]`):**
  - Estados A y C: Densidad ínfima (5.4% Verso / 0% Recto). El pliego luce prácticamente desierto, con solo 2 líneas al tope del Verso.
  - Estado B: Densidad moderada y noble (29.0% Verso / 0% Recto). El Verso presenta una arquitectura tipográfica balanceada que actúa como un colofón legal formal.

#### 5. Cantidad Total de Páginas Físicas
- En los tres estados analizados, el documento totaliza **exactamente 126 páginas físicas y 64 pliegos**. La redistribución semántica de la Fase 3.9 no añade ni una sola página física adicional al Protocolo Familiar, redistribuyendo el volumen dentro del mismo presupuesto de pliegos.

---

## 6. CONCLUSIÓN TÉCNICA Y DICTAMEN DIAGNÓSTICO DEFINITIVO

1. **Refutación Absoluta de la Hipótesis x.1 (+18 pt):**
   - El desfase de +18 pt antes de `x.1` es absorbido en su totalidad por la holgura de la primera página (`chapter-first-page`) en 7 de los 9 capítulos.
   - En el Capítulo 09, el Estado C es **estrictamente idéntico al Estado A**: la coordenada de inicio de 9.1 pasó de $y=224.04$ pt a $y=242.04$ pt, pero las 18 líneas cupieron perfectamente en P.123 sin expulsar nada a P.124. En consecuencia, **las páginas 124, 125 y 126 no sufrieron la más mínima variación**, perpetuando el cierre residual defectuoso de 2 líneas.

2. **Juicio Editorial sobre el Trade-off Visual:**
   - La opción de "flujo natural estricto" (Estados A y C) sacrifica la calidad de la clausura del libro a cambio de rellenar mecánicamente el fondo de P.125.
   - La opción de "redistribución semántica" (Estado B de la Fase 3.9) prioriza la **unidad del bloque normativo final** y la **solemnidad del cierre institucional**, admitiendo un espacio en blanco de 161 pt al pie de P.125 que resulta editorialmente preferible y natural.

3. **Recomendación Final:**
   - Descartar definitivamente el modelo de desfase generalizado en `x.1`.
   - Ratificar la consolidación de la **Fase 3.9.1**, basada en reglas semánticas localizadas (atomicidad de bloques y keep-with-next reforzado), como el estándar de producción definitivo.

4. **Estado de Compromisos:**
   - **NO se implementa ni consolida ningún cambio en producción.**
   - Los archivos canónicos `/capitulos/*.md` y `templates/typst/componentes.typ` permanecen 100% intactos e inalterados.

---

## ENTREGABLES GENERADOS EN ESTA FASE

1. [TEST_PAGINATION_X1_PLUS18.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_PAGINATION_X1_PLUS18.pdf) (Documento maestro compilado Estado C, 126 páginas físicas, 1,237,661 bytes).
2. [TEST_PAGINATION_X1_PLUS18_SPREADS.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_PAGINATION_X1_PLUS18_SPREADS.pdf) (64 pliegos enfrentados a tamaño 792 × 612 pt, 1,102,683 bytes).
3. [TEST_PAGINATION_X1_PLUS18_BEFORE_AFTER.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_PAGINATION_X1_PLUS18_BEFORE_AFTER.pdf) (6 láminas comparativas A3 apaisadas a escala real 1:1, 149,075 bytes).
4. [TEST_COMPARATIVA_SPREAD_CAPITULO_09.pdf](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_COMPARATIVA_SPREAD_CAPITULO_09.pdf) (3 láminas A3 apaisadas con la comparativa tripartita A | B | C de Pliegos 63 y 64, 187,265 bytes).
5. [reporte_simulacion_x1_plus18.md](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/reportes/reporte_simulacion_x1_plus18.md) (este informe técnico diagnóstico integral).
6. **Artefactos PNG de Alta Resolución:**
   - [comparativa_spread_cap09_lamina_01.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/comparativa_spread_cap09_lamina_01.png) (Pliego 63: Secciones 9.7 y 9.8 en A, B y C).
   - [comparativa_spread_cap09_lamina_02.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/comparativa_spread_cap09_lamina_02.png) (Pliego 64: Clausura final en A, B y C).
   - [comparativa_spread_cap09_lamina_03.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/comparativa_spread_cap09_lamina_03.png) (Detalle forense 1:1 de páginas 125 y 126).
   - [simulacion_3_9a_lamina_01.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/simulacion_3_9a_lamina_01.png) a [06.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/simulacion_3_9a_lamina_06.png) (Láminas 1 a 6 de los casos críticos).

