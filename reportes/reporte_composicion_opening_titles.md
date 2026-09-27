# Reporte Técnico de Composición Tipográfica — Propuesta de Saltos Editoriales Controlados (`opening_title`)

**Proyecto:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Fase:** Fase 3.4 — Diseño Visual Definitivo (Apertura de Capítulo · Validación Editorial Multi-Capítulo)  
**Documento Compilado:** [`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf)  
**Documento de Prueba:** [`tests/test_chapter_openings_all.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_chapter_openings_all.typ)  
**Componente Evaluado:** `chapter-opening()` en [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ)  
**Fecha:** 26 de septiembre de 2026  
**Estado de Aprobación:** **NO BLOQUEADO / EN ESPERA DE REVISIÓN Y APROBACIÓN EDITORIAL DEL USUARIO**

---

## 1. Resumen Ejecutivo y Arquitectura Editorial

Tras la resolución técnica de la colisión vertical dinámica (donde el espaciado inter-bloques se desacopló de coordenadas absolutas y se vinculó dinámicamente con una separación baseline-to-baseline exacta de $\Delta y = 25.67 - 25.68\text{ pt}$), la inspección visual manual de los 9 capítulos evidenció la necesidad de aplicar **criterio editorial a los saltos de línea** de los títulos de apertura.

En particular, en el **Capítulo 07**, la partición automática generaba:
1. Una línea con la conjunción huérfana `"Y"`.
2. Una primera línea (`"PROCEDIMIENTO SANCIONADOR"`) de $244.39\text{ pt}$ de longitud, extendiéndose hasta $x = 272.73\text{ pt}$ frente a un límite diagonal de $x_{\text{diagonal}} = 261.74\text{ pt}$, lo que representaba una invasión física de $-10.99\text{ pt}$ sobre el plano diagonal naranja.

### Decisión Arquitectónica Adoptada
Se separa formalmente la **semántica del contenido** del **control tipográfico de presentación**:

- **Campo canónico `title`:** Permanece como una cadena semántica continua en el frontmatter de `/capitulos/*.md` (e.g., `"Capítulo 7. Procedimiento Sancionador y Régimen de Sanciones Internas"`). Este campo no contendrá saltos de línea forzados, permitiendo su uso limpio en metadatos, tabla de contenidos (`table-of-contents()`), encabezados corrientes (*running headers*) y exportaciones estructuradas.
- **Campo de presentación `opening_title`:** Controla de manera exclusiva la composición tipográfica de la portada de capítulo en `chapter-opening()`. Permite especificar los cortes de línea que garantizan el balance óptico, el ritmo jerárquico y el respeto a la zona de seguridad diagonal.

### Principios de Composición Aplicados
1. **Fidelidad al Título Canónico:** Ningún título altera, suprime ni agrega palabras respecto al título canónico.
2. **Invarianza Paramétrica:** Se preservan rigurosamente el cuerpo tipográfico ($15.9929\text{ pt}$), interletraje / tracking ($+0.019\text{ em}$), interlineado / leading ($24.0\text{ pt}$ de paso vertical), color (`#2e2f31`), punto de anclaje inicial ($x = 28.3398\text{ pt}$, $dy = 412.3005\text{ pt}$, $y_{\text{base}} = 422.7119\text{ pt}$), ancho de caja maestra ($250\text{ pt}$) y la geometría vectorial de fondo.
3. **Zona de Seguridad Óptica:** Ninguna línea invade la masa diagonal naranja ($x_{\text{end}} < x_{\text{diagonal}}(y)$) ni su zona de penumbra de sombra paralela.
4. **Erradicación de Palabras Huérfanas:** No se dejan conjunciones, artículos o preposiciones aisladas (`"Y"`, `"DE"`, `"DEL"`, `"LA"`) en una línea independiente.
5. **Ritmo y Cadencia Visual:** Distribución equilibrada de masa tipográfica en 2 a 4 líneas (excepto el Capítulo 03 que, por su extensión semántica de 10 palabras, se compone limpiamente en 5 líneas).

---

## 2. Tabla Comparativa de Composición de los 9 Capítulos

La siguiente tabla resume los resultados cuantitativos y geométricos obtenidos en [`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf):

| Cap. | Título Canónico | Opening Title Propuesto | Líneas | Línea Más Larga (Ancho) | Línea Más Próxima a Diagonal | Margen Mínimo a Diagonal | Distancia Título $\rightarrow$ Desc. | Margen Libre al Footer | Estado |
| :---: | :--- | :--- | :---: | :--- | :--- | :---: | :---: | :---: | :---: |
| **01** | Capítulo 1. Declaración de Principios Familiares y Visión Intergeneracional | `DECLARACIÓN DE \`<br>`PRINCIPIOS FAMILIARES Y \`<br>`VISIÓN INTERGENERACIONAL` | 3 | L3: `VISIÓN INTERGENERACIONAL`<br>($217.28\text{ pt}$) | L3: `VISIÓN INTERGENERACIONAL` | **$+28.89\text{ pt}$** | $25.68\text{ pt}$ | $74.62\text{ pt}$ | **ÓPTIMO**<br>*(Referencia 1:1)* |
| **02** | Capítulo 2. Propiedad Accionaria, Control Familiar y Liquidez Patrimonial | `PROPIEDAD ACCIONARIA, \`<br>`CONTROL FAMILIAR Y \`<br>`LIQUIDEZ PATRIMONIAL` | 3 | L1: `PROPIEDAD ACCIONARIA,`<br>($187.08\text{ pt}$) | L1: `PROPIEDAD ACCIONARIA,` | **$+46.32\text{ pt}$** | $25.68\text{ pt}$ | $74.62\text{ pt}$ | **ÓPTIMO** |
| **03** | Capítulo 3. Gobierno Corporativo Familiar, Institucionalización y Régimen de Profesionalización | `GOBIERNO CORPORATIVO \`<br>`FAMILIAR, \`<br>`INSTITUCIONALIZACIÓN Y \`<br>`RÉGIMEN DE \`<br>`PROFESIONALIZACIÓN` | 5 | L3: `INSTITUCIONALIZACIÓN Y`<br>($194.11\text{ pt}$) | L1: `GOBIERNO CORPORATIVO` | **$+42.94\text{ pt}$** | $25.68\text{ pt}$ | $26.61\text{ pt}$ | **AJUSTADO**<br>*(Sin colisión)* |
| **04** | Capítulo 4. Régimen de Sucesión Familiar Empresarial | `RÉGIMEN DE SUCESIÓN \`<br>`FAMILIAR EMPRESARIAL` | 2 | L2: `FAMILIAR EMPRESARIAL`<br>($175.41\text{ pt}$) | L2: `FAMILIAR EMPRESARIAL` | **$+64.38\text{ pt}$** | $25.67\text{ pt}$ | $98.63\text{ pt}$ | **ÓPTIMO** |
| **05** | Capítulo 5. Control Institucional de la Información y Comunicación Familiar–Empresarial | `CONTROL INSTITUCIONAL \`<br>`DE LA INFORMACIÓN \`<br>`Y COMUNICACIÓN \`<br>`FAMILIAR–EMPRESARIAL` | 4 | L1: `CONTROL INSTITUCIONAL`<br>($193.31\text{ pt}$) | L1: `CONTROL INSTITUCIONAL` | **$+40.09\text{ pt}$** | $25.67\text{ pt}$ | $50.62\text{ pt}$ | **AJUSTADO**<br>*(Equilibrado)* |
| **06** | Capítulo 6. Régimen de Disciplina Financiera Familiar–Empresarial | `RÉGIMEN DE \`<br>`DISCIPLINA FINANCIERA \`<br>`FAMILIAR–EMPRESARIAL` | 3 | L3: `FAMILIAR–EMPRESARIAL`<br>($180.05\text{ pt}$) | L2: `DISCIPLINA FINANCIERA` | **$+60.61\text{ pt}$** | $25.68\text{ pt}$ | $74.62\text{ pt}$ | **ÓPTIMO** |
| **07** | Capítulo 7. Procedimiento Sancionador y Régimen de Sanciones Internas | `PROCEDIMIENTO \`<br>`SANCIONADOR Y \`<br>`RÉGIMEN DE SANCIONES \`<br>`INTERNAS` | 4 | L3: `RÉGIMEN DE SANCIONES`<br>($179.94\text{ pt}$) | L3: `RÉGIMEN DE SANCIONES` | **$+66.23\text{ pt}$** | $25.67\text{ pt}$ | $50.62\text{ pt}$ | **AJUSTADO**<br>*(Solicitado)* |
| **08** | Capítulo 8. Medios Alternativos de Solución de Conflictos Familiares–Empresariales | `MEDIOS ALTERNATIVOS DE \`<br>`SOLUCIÓN DE CONFLICTOS \`<br>`FAMILIARES–EMPRESARIALES` | 3 | L3: `FAMILIARES–EMPRESARIALES`<br>($213.17\text{ pt}$) | L3: `FAMILIARES–EMPRESARIALES` | **$+33.00\text{ pt}$** | $25.68\text{ pt}$ | $74.62\text{ pt}$ | **ÓPTIMO** |
| **09** | Capítulo 9. Régimen Jurídico del Protocolo Familiar | `RÉGIMEN JURÍDICO DEL \`<br>`PROTOCOLO FAMILIAR` | 2 | L1: `RÉGIMEN JURÍDICO DEL`<br>($174.53\text{ pt}$) | L1: `RÉGIMEN JURÍDICO DEL` | **$+58.87\text{ pt}$** | $25.67\text{ pt}$ | $98.63\text{ pt}$ | **ÓPTIMO** |

---

## 3. Análisis Específico de Casos Críticos

### 3.1. Capítulo 07: Evaluación de la Composición Solicitada

La composición editorial instruida por el usuario para el Capítulo 07:
```text
PROCEDIMIENTO \
SANCIONADOR Y \
RÉGIMEN DE SANCIONES \
INTERNAS
```

#### Comparativa Geométrica: Automático vs. Editorial Controlado

| Métrica | Composición Automática Previa | Composición Editorial Solicitada | Impacto Editorial |
| :--- | :---: | :---: | :--- |
| **Línea 1** | `"PROCEDIMIENTO SANCIONADOR"` | `"PROCEDIMIENTO"` | Se acorta de $244.39\text{ pt}$ a $126.78\text{ pt}$. |
| **Extremo X Línea 1** | $x_{\text{end}} = 272.73\text{ pt}$ | $x_{\text{end}} = 155.12\text{ pt}$ | Retrocede $117.61\text{ pt}$ hacia la izquierda. |
| **Límite Diagonal (L1)** | $x_{\text{diag}} = 261.74\text{ pt}$ | $x_{\text{diag}} = 261.74\text{ pt}$ | Invariante geométrico. |
| **Margen a Diagonal (L1)** | **$-10.99\text{ pt}$ (INVASIÓN)** | **$+106.62\text{ pt}$ (AMPLIO)** | **Erradicación total de la colisión.** |
| **Línea 2** | `"Y"` (Huérfana) | `"SANCIONADOR Y"` | Conjunción agrupada con su adjetivo rector. |
| **Línea Más Larga** | L1: $244.39\text{ pt}$ | L3: `"RÉGIMEN DE SANCIONES"` ($179.94\text{ pt}$) | Masa tipográfica contenida y proporcionada. |
| **Margen Mínimo al Plano** | $-10.99\text{ pt}$ (Penetración) | **$+66.23\text{ pt}$ (Línea 3)** | **Holgura de seguridad de más de $2.3\text{ cm}$.** |
| **Línea Base Final** | $y = 494.73\text{ pt}$ | $y = 494.73\text{ pt}$ | Idéntica altura total de bloque (4 líneas). |
| **Distancia a Descripción** | $25.67\text{ pt}$ | $25.67\text{ pt}$ | Ritmo dinámico idéntico a la referencia. |
| **Margen Libre a Footer** | $50.62\text{ pt}$ | $50.62\text{ pt}$ | Espacio vertical seguro. |

**Conclusión del Capítulo 07:** La composición solicitada no solo resuelve el defecto estético de la conjunción `"Y"` aislada, sino que corrige de forma contundente la proximidad excesiva al plano diagonal, convirtiendo un área con penetración negativa en una composición con **$+66.23\text{ pt}$ de holgura óptica libre**.

---

### 3.2. Capítulo 03: Desafío de Máxima Extensión (5 Líneas)

El Capítulo 03 presenta el título más largo de todo el protocolo (68 caracteres, 10 palabras):  
`"Capítulo 3. Gobierno Corporativo Familiar, Institucionalización y Régimen de Profesionalización"`

#### Desglose de Líneas y Márgenes Geométricos

$$\begin{aligned}
\text{L1: } & \text{"GOBIERNO CORPORATIVO"} & (w = 190.46\text{ pt}, \ x_{\text{end}} = 218.80\text{ pt}, \ x_{\text{diag}} = 261.74\text{ pt}) & \implies \mathbf{+42.94\text{ pt}} \\
\text{L2: } & \text{"FAMILIAR,"} & (w = 74.29\text{ pt}, \ x_{\text{end}} = 102.63\text{ pt}, \ x_{\text{diag}} = 268.13\text{ pt}) & \implies \mathbf{+165.50\text{ pt}} \\
\text{L3: } & \text{"INSTITUCIONALIZACIÓN Y"} & (w = 194.11\text{ pt}, \ x_{\text{end}} = 222.45\text{ pt}, \ x_{\text{diag}} = 274.51\text{ pt}) & \implies \mathbf{+52.06\text{ pt}} \\
\text{L4: } & \text{"RÉGIMEN DE"} & (w = 92.42\text{ pt}, \ x_{\text{end}} = 120.76\text{ pt}, \ x_{\text{diag}} = 280.90\text{ pt}) & \implies \mathbf{+160.14\text{ pt}} \\
\text{L5: } & \text{"PROFESIONALIZACIÓN"} & (w = 164.25\text{ pt}, \ x_{\text{end}} = 192.59\text{ pt}, \ x_{\text{diag}} = 287.29\text{ pt}) & \implies \mathbf{+94.70\text{ pt}}
\end{aligned}$$

- **Última Línea Base del Título:** $y = 518.73\text{ pt}$.
- **Primera Línea Base de la Descripción:** $y = 544.41\text{ pt}$ (separación de $25.68\text{ pt}$, idéntica a la referencia).
- **Límite Inferior de la Descripción:** $y_{\text{bottom}} = 564.46\text{ pt}$.
- **Inicio del Bloque de Footer:** $y_{\text{footer}} = 591.07\text{ pt}$ ($dy = 591.42\text{ pt}$).
- **Margen Libre al Footer:** $y_{\text{footer}} - y_{\text{bottom}} = \mathbf{26.61\text{ pt}}$ ($9.39\text{ mm}$).
- **Margen Mínimo a la Diagonal:** Ocurre en la Línea 1 con **$+42.94\text{ pt}$**, garantizando un espacio de seguridad holgado frente al bisel naranja.

**Conclusión del Capítulo 03:** A pesar de ocupar 5 líneas y ser el caso de mayor presión vertical del libro, la solución dinámica mantiene el paso vertical exacto de la referencia sin invadir el footer ni recortar ningún estilo.

---

### 3.3. Capítulo 05: Equilibrio Sintáctico y Eliminación de Huérfanas

En la versión inicial automática, el Capítulo 05 se dividía en 3 líneas donde la segunda línea contenía `"LA INFORMACIÓN Y COMUNICACIÓN"` ($232.89\text{ pt}$ de longitud), aproximándose a $+16.82\text{ pt}$ de la diagonal.

Con la partición editorial en 4 líneas:
```text
CONTROL INSTITUCIONAL \
DE LA INFORMACIÓN \
Y COMUNICACIÓN \
FAMILIAR–EMPRESARIAL
```
- Cada línea representa una unidad sintáctica completa y coherente.
- La línea más larga es L1 (`"CONTROL INSTITUCIONAL"`, $193.31\text{ pt}$).
- El margen mínimo a la diagonal sube de $+16.82\text{ pt}$ a **$+40.09\text{ pt}$**.
- La palabra compuesta `"FAMILIAR–EMPRESARIAL"` se conserva en una sola línea sin corte guionado.

---

### 3.4. Capítulos 06 y 08: Protección de Palabras Compuestas

Tanto el Capítulo 06 (`"FAMILIAR–EMPRESARIAL"`, $180.05\text{ pt}$) como el Capítulo 08 (`"FAMILIARES–EMPRESARIALES"`, $213.17\text{ pt}$) contienen términos técnicos clave con guion medio (*en-dash*). Las particiones propuestas:
- **Capítulo 06 (3 líneas):** `RÉGIMEN DE \ DISCIPLINA FINANCIERA \ FAMILIAR–EMPRESARIAL` (margen mínimo: $+60.61\text{ pt}$).
- **Capítulo 08 (3 líneas):** `MEDIOS ALTERNATIVOS DE \ SOLUCIÓN DE CONFLICTOS \ FAMILIARES–EMPRESARIALES` (margen mínimo: $+33.00\text{ pt}$).

Evitan que el motor tipográfico rompa por el guion en un tamaño de display de $16\text{ pt}$, preservando la integridad del concepto jurídico-empresarial.

---

## 4. Ecuación Geométrica del Plano Diagonal y Verificación de Distancias

La diagonal naranja de fondo se genera a partir del vector extraído de Adobe Illustrator (`capitulo_apertura_fondo.pdf`). Dicha arista diagonal conecta:
- Punto superior: $(x_1, y_1) = (173.6763\text{ pt}, 91.7580\text{ pt})$
- Punto inferior: $(x_2, y_2) = (312.1043\text{ pt}, 612.0000\text{ pt})$

La ecuación lineal paramétrica de la frontera diagonal en función de la coordenada vertical $y$ es:
$$x_{\text{diagonal}}(y) = 173.6763 + 0.266083 \times (y - 91.7580)$$

Para cada línea de título $i \in \{1, \dots, N\}$, con línea base $y_{\text{base}, i}$ y coordenada de terminación horizontal $x_{\text{end}, i} = x_0 + \text{width}_i$ (donde $x_0 = 28.3398\text{ pt}$):
$$\text{Margen Óptico}_i = x_{\text{diagonal}}(y_{\text{base}, i}) - x_{\text{end}, i}$$

### Resultados en Todos los Capítulos:
- **Margen mínimo absoluto en los 9 capítulos:** **$+28.89\text{ pt}$** (Capítulo 01, Línea 3, que corresponde exactamente al diseño original de Illustrator).
- **Margen promedio de separación a la diagonal:** **$+49.03\text{ pt}$**.
- **Invasiones o solapamientos en los 9 capítulos:** **$0.00\text{ pt}$ (Cero incidencias)**.

---

## 5. Verificación de Integridad y No-Regresión

1. **Componentes Bloqueados:**
   - `cover-page()`: **APPROVED / LOCKED** (Inalterado).
   - `table-of-contents()`: **APPROVED / LOCKED** (Inalterado).
2. **Archivos Canónicos Markdown:**
   - La carpeta `/capitulos/*.md` **NO ha sido modificada** en ninguna forma.
   - La incorporación definitiva del campo `opening_title` en los frontmatters se posterga hasta que el usuario revise y apruebe esta propuesta.
3. **Recursos Gráficos y Tipografías:**
   - `assets/fonts/` intactas (`Minion Pro Medium Display`, `Neuzeit Grotesk Regular`).
   - `assets/images/` intactas (`portada_fondo.pdf`, `capitulo_apertura_fondo.pdf`).
4. **Archivos Generados:**
   - [`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf): Documento PDF de 9 páginas con la compilación completa de la propuesta.
   - [`tests/test_chapter_openings_all.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_chapter_openings_all.typ): Código Typst fuente aislado para reproducción y regresión continua.

---

## 6. Estado y Próximos Pasos

El componente `chapter-opening()` permanece:
$$\mathbf{chapter\text{-}opening() = \text{NO BLOQUEADO / EN ESPERA DE REVISIÓN}}$$

Queda a disposición del usuario la revisión visual de [`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf) para confirmar la composición tipográfica propuesta antes de proceder a la migración de metadatos o al cierre formal del componente.
