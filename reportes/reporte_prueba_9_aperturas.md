# Reporte Técnico de Validación — Prueba Funcional de las 9 Aperturas de Capítulo (Actualizado)

**Proyecto:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Fase:** Corrección y Validación Funcional Multi-Capítulo (Fase 3.4 — Cierre)  
**Documento Compilado:** [`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf)  
**Componente Evaluado:** `chapter-opening()` en [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ)  
**Fecha de Actualización:** 26 de septiembre de 2026  
**Estado de Aprobación:** **NO BLOQUEADO / EN ESPERA DE REVISIÓN FINAL DEL USUARIO**  

---

## 1. Contexto y Solución Editorial Implementada

Tras la inspección visual manual del documento inicial de 9 aperturas, se constató una limitación arquitectónica: el anclaje estático independiente (`#place`) de la descripción en $dy = 491.13\text{ pt}$ asumía un título rígido de 3 líneas (referencia del capítulo 01), lo que provocaba colisiones directas con títulos de 4 líneas (capítulos 05 y 07) y sobreimpresión crítica en títulos de 5 líneas (capítulo 03).

### Solución Dinámica Aplicada
Conforme a la instrucción editorial recibida, se implementó una solución **100% genérica y no invasiva** dentro de `chapter-opening()` en [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ):

1. **Invarianza de la Posición Inicial del Título:**  
   La primera línea del título mantiene con exactitud milimétrica su posición calibrada contra Adobe Illustrator:
   $$dy_{\text{title}} = 412.3005\text{ pt} \quad \implies \quad y_{\text{baseline\_L1}} = 422.7119\text{ pt}$$
2. **Cálculo Dinámico de la Línea Base Final del Título:**  
   Mediante medición contextual (`context` y `measure()`), se determina la altura real del bloque del título y su número de líneas ($N$), calculando la última línea base del título:
   $$y_{\text{last\_title\_baseline}} = 422.7119\text{ pt} + (N - 1) \times 24.0053\text{ pt}$$
3. **Separación Inter-bloques Calibrada (Capítulo 01):**  
   Se desacopló la descripción de una $Y$ fija y se vinculó a la última línea real del título con la constante exacta de separación de la referencia autoritativa:
   $$\Delta y_{\text{baseline-to-baseline}} = y_{\text{desc\_L1\_ref}} - y_{\text{title\_L3\_ref}} = 496.3955\text{ pt} - 470.7226\text{ pt} = \mathbf{25.6729\text{ pt}}$$
4. **Posicionamiento Dinámico de la Descripción:**  
   $$y_{\text{desc\_first\_baseline}} = y_{\text{last\_title\_baseline}} + 25.6729\text{ pt}$$
   $$dy_{\text{desc}} = y_{\text{desc\_first\_baseline}} - \text{ascent}_{\text{neuzeit}} = y_{\text{desc\_first\_baseline}} - 5.2705\text{ pt}$$
5. **Preservación Absoluta del Capítulo 01:**  
   Para $N = 3$, la fórmula arroja $dy_{\text{desc}} = 491.1249\text{ pt}$ y $y_{\text{base}} = 496.3954\text{ pt}$ (error $= 0.00\text{ pt}$). La coincidencia con la referencia autoritativa de Illustrator permanece **100% inalterada**.
6. **Ausencia Total de Hardcoding:**  
   No existen condicionales por capítulo (`if chapter == ...`). El cálculo responde de forma universal al flujo tipográfico natural.

---

## 2. Parámetros Globales e Invarianza Tipográfica Confirmada

Se confirmó mediante inspección de flujos en [`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf):
- **Font-size:** Estrictamente $39.3657\text{ pt}$ (número), $15.9929\text{ pt}$ (título), $7.9077\text{ pt}$ (descripción), $4.8234\text{ pt}$ (footer) en las 9 páginas (**0% variación**).
- **Tracking:** Estrictamente $-0.050\text{ em}$ (número), $+0.019\text{ em}$ (título), $0\text{ em}$ (descripción), $+0.200\text{ em}$ (footer) en las 9 páginas (**0% variación**).
- **Leading:** Estrictamente $24.00 - 24.01\text{ pt}$ (título) y $18.00\text{ pt}$ (descripción) en las 9 páginas (**0% variación**).
- **Ancho de caja:** `width: 250pt` constante.

---

## 3. Matriz de Validación Geométrica de los 9 Capítulos

| Cap. | Líneas Título | Última Baseline Título | Primera Baseline Desc. | Distancia Baseline $\rightarrow$ Baseline | Colisión Título/Desc | Margen Libre Footer | Margen Plano Diagonal | Diagnóstico |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **01** | 3 | $470.72\text{ pt}$ | $496.40\text{ pt}$ | **$25.68\text{ pt}$** | **Ninguna** | $74.62\text{ pt}$ | $+28.89\text{ pt}$ | **Óptimo** (idéntico 1:1 a referencia). |
| **02** | 3 | $470.72\text{ pt}$ | $496.40\text{ pt}$ | **$25.68\text{ pt}$** | **Ninguna** | $74.62\text{ pt}$ | $+15.28\text{ pt}$ | **Correcto**. |
| **03** | **5** | **$518.73\text{ pt}$** | **$544.41\text{ pt}$** | **$25.68\text{ pt}$** | **Ninguna (Resuelto)** | **$26.61\text{ pt}$** | $+39.77\text{ pt}$ | **Composición más larga resuelta limpiamente.** |
| **04** | 2 | $446.72\text{ pt}$ | $472.39\text{ pt}$ | **$25.67\text{ pt}$** | **Ninguna (Ajustado)** | $98.63\text{ pt}$ | $+24.89\text{ pt}$ | **Hueco previo corregido de forma proporcional.** |
| **05** | 4 | $494.73\text{ pt}$ | $520.40\text{ pt}$ | **$25.67\text{ pt}$** | **Ninguna (Resuelto)** | $50.62\text{ pt}$ | $+16.82\text{ pt}$ | **Contacto previo resuelto limpiamente.** |
| **06** | 3 | $470.72\text{ pt}$ | $496.40\text{ pt}$ | **$25.68\text{ pt}$** | **Ninguna** | $74.62\text{ pt}$ | $+30.66\text{ pt}$ | **Correcto**. |
| **07** | 4 | $494.73\text{ pt}$ | $520.40\text{ pt}$ | **$25.67\text{ pt}$** | **Ninguna (Resuelto)** | $50.62\text{ pt}$ | $-10.99\text{ pt}$ (L1 fixture) | **Colisión vertical resuelta; descripción limpia.** |
| **08** | 3 | $470.72\text{ pt}$ | $496.40\text{ pt}$ | **$25.68\text{ pt}$** | **Ninguna** | $74.62\text{ pt}$ | $+6.66\text{ pt}$ | **Correcto** (fuera de la masa naranja). |
| **09** | 2 | $446.72\text{ pt}$ | $472.39\text{ pt}$ | **$25.67\text{ pt}$** | **Ninguna (Ajustado)** | $98.63\text{ pt}$ | $+36.75\text{ pt}$ | **Hueco previo corregido de forma proporcional.** |

---

## 4. Detalle y Verificación Capítulo por Capítulo

### Capítulo 01 (Página 1)
- Título: 3 líneas (`DECLARACIÓN DE \ PRINCIPIOS FAMILIARES Y \ VISIÓN INTERGENERACIONAL`).
- Última baseline título: $470.72\text{ pt}$.
- Primera baseline descripción: $496.40\text{ pt}$.
- Distancia entre ambas: **$25.68\text{ pt}$**.
- Ausencia de colisiones: **Confirmada**.
- Ausencia de overflow: **Confirmada**.
- Ausencia de invasión del footer: **Confirmada** ($74.62\text{ pt}$ de margen libre).
- Ausencia de invasión diagonal: **Confirmada** ($+28.89\text{ pt}$ de margen al borde naranja).
- Verificación de no-regresión: Deltas contra referencia autoritativa: $\Delta x = 0.00\text{ pt}$, $\Delta y \le 0.01\text{ pt}$.

### Capítulo 02 (Página 2)
- Título: 3 líneas (`PROPIEDAD ACCIONARIA, \ CONTROL FAMILIAR Y \ LIQUIDEZ PATRIMONIAL`).
- Última baseline título: $470.72\text{ pt}$.
- Primera baseline descripción: $496.40\text{ pt}$.
- Distancia entre ambas: **$25.68\text{ pt}$**.
- Ausencia de colisiones: **Confirmada**.
- Ausencia de overflow: **Confirmada**.
- Ausencia de invasión del footer: **Confirmada** ($74.62\text{ pt}$ de margen libre).
- Ausencia de invasión diagonal: **Confirmada** ($+15.28\text{ pt}$).

### Capítulo 03 (Página 3 — Composición Más Larga)
- Título: **5 líneas** (`GOBIERNO CORPORATIVO \ FAMILIAR, \ INSTITUCIONALIZACIÓN Y \ RÉGIMEN DE \ PROFESIONALIZACIÓN`).
- Última baseline título: **$518.73\text{ pt}$**.
- Primera baseline descripción: **$544.41\text{ pt}$** (antes: $496.40\text{ pt}$, sobreimpreso).
- Distancia entre ambas: **$25.68\text{ pt}$** (antes: colisión de $-22.33\text{ pt}$).
- Ausencia de colisiones: **Confirmada. La sobreimpresión fue erradicada al 100%.**
- Ausencia de overflow: **Confirmada**.
- Ausencia de invasión del footer: **Confirmada**. El punto inferior del texto de descripción se ubica en $y = 564.46\text{ pt}$; el footer inicia en $y = 591.07\text{ pt}$, manteniendo un margen libre de **$26.61\text{ pt}$** ($9.4\text{ mm}$).
- Ausencia de invasión diagonal: **Confirmada**. Margen libre al corte naranja: **$+39.77\text{ pt}$**.

### Capítulo 04 (Página 4)
- Título: 2 líneas (`RÉGIMEN DE SUCESIÓN \ FAMILIAR EMPRESARIAL`).
- Última baseline título: $446.72\text{ pt}$.
- Primera baseline descripción: **$472.39\text{ pt}$** (antes: $496.40\text{ pt}$).
- Distancia entre ambas: **$25.67\text{ pt}$** (antes: hueco excesivo de $49.68\text{ pt}$).
- Ausencia de colisiones: **Confirmada**. La descripción asciende de forma coordinada, restableciendo la armonía visual de proporciones.
- Ausencia de overflow: **Confirmada**.
- Ausencia de invasión del footer: **Confirmada** ($98.63\text{ pt}$ de margen libre).
- Ausencia de invasión diagonal: **Confirmada** ($+24.89\text{ pt}$).

### Capítulo 05 (Página 5)
- Título: 4 líneas (`CONTROL INSTITUCIONAL DE \ LA INFORMACIÓN Y \ COMUNICACIÓN \ FAMILIAR–EMPRESARIAL`).
- Última baseline título: $494.73\text{ pt}$.
- Primera baseline descripción: **$520.40\text{ pt}$** (antes: $496.40\text{ pt}$).
- Distancia entre ambas: **$25.67\text{ pt}$** (antes: contacto de $1.67\text{ pt}$).
- Ausencia de colisiones: **Confirmada. Contacto de glifos eliminado por completo.**
- Ausencia de overflow: **Confirmada**.
- Ausencia de invasión del footer: **Confirmada** ($50.62\text{ pt}$ de margen libre).
- Ausencia de invasión diagonal: **Confirmada** ($+16.82\text{ pt}$).

### Capítulo 06 (Página 6)
- Título: 3 líneas (`RÉGIMEN DE DISCIPLINA \ FINANCIERA FAMILIAR– \ EMPRESARIAL`).
- Última baseline título: $470.72\text{ pt}$.
- Primera baseline descripción: $496.40\text{ pt}$.
- Distancia entre ambas: **$25.68\text{ pt}$**.
- Ausencia de colisiones: **Confirmada**.
- Ausencia de overflow: **Confirmada**.
- Ausencia de invasión del footer: **Confirmada** ($74.62\text{ pt}$ de margen libre).
- Ausencia de invasión diagonal: **Confirmada** ($+30.66\text{ pt}$).

### Capítulo 07 (Página 7)
- Título: 4 líneas (`PROCEDIMIENTO SANCIONADOR \ Y \ RÉGIMEN DE SANCIONES \ INTERNAS`).
- Última baseline título: $494.73\text{ pt}$.
- Primera baseline descripción: **$520.40\text{ pt}$** (antes: $496.40\text{ pt}$).
- Distancia entre ambas: **$25.67\text{ pt}$** (antes: contacto de $1.67\text{ pt}$).
- Ausencia de colisiones verticales: **Confirmada. Colisión con la descripción erradicada al 100%.**
- Ausencia de invasión del footer: **Confirmada** ($50.62\text{ pt}$ de margen libre).
- Geometría diagonal: La descripción queda holgadamente fuera ($+34.18\text{ pt}$). La línea 1 del fixture temporal de configuración ("PROCEDIMIENTO SANCIONADOR") rebasa por $-10.99\text{ pt}$ debido a que el texto de prueba no incorpora el salto de línea adecuado a la diagonal menguante; esto se normalizará cuando se definan los textos canónicos en `/capitulos/*.md`.

### Capítulo 08 (Página 8)
- Título: 3 líneas (`MEDIOS ALTERNATIVOS DE \ SOLUCIÓN DE CONFLICTOS \ FAMILIARES–EMPRESARIALES`).
- Última baseline título: $470.72\text{ pt}$.
- Primera baseline descripción: $496.40\text{ pt}$.
- Distancia entre ambas: **$25.68\text{ pt}$**.
- Ausencia de colisiones: **Confirmada**.
- Ausencia de overflow: **Confirmada**.
- Ausencia de invasión del footer: **Confirmada** ($74.62\text{ pt}$ de margen libre).
- Geometría diagonal: Margen libre $+6.66\text{ pt}$ fuera de la masa naranja.

### Capítulo 09 (Página 9)
- Título: 2 líneas (`RÉGIMEN JURÍDICO DEL \ PROTOCOLO FAMILIAR`).
- Última baseline título: $446.72\text{ pt}$.
- Primera baseline descripción: **$472.39\text{ pt}$** (antes: $496.40\text{ pt}$).
- Distancia entre ambas: **$25.67\text{ pt}$** (antes: hueco excesivo de $49.68\text{ pt}$).
- Ausencia de colisiones: **Confirmada**.
- Ausencia de overflow: **Confirmada**.
- Ausencia de invasión del footer: **Confirmada** ($98.63\text{ pt}$ de margen libre).
- Ausencia de invasión diagonal: **Confirmada** ($+36.75\text{ pt}$).

---

## 5. Conclusiones de la Validación

1. **Constancia Visual Absoluta:**  
   La separación entre la última línea base del título y la primera línea base de la descripción es rigurosamente constante en los nueve capítulos:
   $$\text{GAP} = \mathbf{25.67\text{ pt} - 25.68\text{ pt}}$$
2. **Resolución Integral de Colisiones:**  
   Se eliminaron todas las sobreimpresiones y contactos físicos en los capítulos 03, 05 y 07, al tiempo que se armonizó el espaciado en los capítulos de 2 líneas (04 y 09).
3. **Coexistencia con el Footer:**  
   Incluso en la composición más larga (Capítulo 03 con 7 líneas de texto en total), se preserva un margen de respeto de **$26.61\text{ pt}$** ($9.4\text{ mm}$) por encima del pie de página.
4. **Fidelidad Intacta de la Referencia Original:**  
   El Capítulo 01 mantiene congruencia óptica y geométrica micrométrica con [`referencias/03 portada capitulos.pdf`](file:///C:/Users/JJSS/Desktop/ABC/referencias/03%20portada%20capitulos.pdf), sin desplazamiento de glifos.

---

## 6. Estado Formal de Componentes e Integridad

- **`cover-page()`:** **APPROVED / LOCKED** (intacto).
- **`table-of-contents()`:** **APPROVED / LOCKED** (intacto).
- **`chapter-opening()`:** **PENDIENTE DE REVISIÓN Y APROBACIÓN POR EL USUARIO** (No bloqueado formalmente).
- **Fuente Canónica:** `/capitulos/*.md` **100% intacta** (la migración de metadatos al frontmatter se ejecutará en la etapa correspondiente).
- **Configuración:** `config/editorial_config.yaml` intacto.
- **Recursos Vectoriales:** `assets/` intacto.
