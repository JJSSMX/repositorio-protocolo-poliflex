# INFORME TÉCNICO EDITORIAL: FASE 4.4
## PROTOTIPO DE APERTURA CEREMONIAL DE REGLAMENTOS (`REGULATION-OPENING`)
### Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

---

### 1. OBJETIVO Y MARCO DE DISEÑO
Conforme a las directrices de la **Fase 4.4**, se diseñó y evaluó el sistema de apertura ceremonial para los tres Reglamentos internos del Protocolo Familiar POLIFLEX:
1. `capitulos/11_reglamento_asamblea_familia.md`
2. `capitulos/12_reglamento_consejo_familia.md`
3. `capitulos/13_reglamento_comite_honor_familiar.md`

El desarrollo se ejecutó en la capa experimental (`templates/typst/componentes_fase_4_experimental.typ`), manteniendo intacto e inalterado el núcleo de producción consolidado (`templates/typst/componentes.typ`).

**Estatus del componente:**
$$\mathbf{regulation-opening() = EXPERIMENTAL\ /\ NOT\ LOCKED}$$

---

### 2. PRINCIPIO ARQUITECTÓNICO: SEMÁNTICA FRENTE A `CHAPTER-OPENING()`

La apertura ceremonial de un Reglamento funciona como una **variante semántica de `chapter-opening()`**. Comparte su ADN institucional pero comunica de forma inmediata un nivel documental diferenciado:
- **`chapter-opening()` (Capítulos 01–09):** Marca las 9 grandes divisiones troncales del Protocolo mediante un número monumental en Minion Pro Medium Display ($39.37\text{ pt}$) en color naranja `#f15d22` sobre la regla horizontal, un título general y un párrafo de descripción temática.
- **`regulation-opening()` (Reglamentos 11–13):** Representa cuerpos normativos adjetivos y operativos de gobierno corporativo familiar. **No utiliza números de archivo ("10", "11", "12", "13") como gran número ceremonial**, no utiliza el descriptor "CAPÍTULO", y **no inventa descripciones temáticas inexistentes en las fuentes canónicas**. El protagonista indiscutible es el nombre canónico completo de la normativa u órgano.

---

### 3. MATRIZ DE COMPARACIÓN DE LAS TRES VARIANTES CONCEPTUALES

| Parámetro / Dimensión | VARIANTE A<br>*(Derivación más literal)* | VARIANTE B<br>*(Jerarquía institucional Neuzeit)* | VARIANTE C<br>*(Sobria / Reducción ceremonial)* |
| :--- | :--- | :--- | :--- |
| **Concepto rector** | Sustituto literal del gran número por la palabra ceremonial `REGLAMENTO`. | Supra-identificador categórico en Neuzeit Grotesk + título canónico completo. | Umbral ceremonial puro: ausencia de elemento superior, regla naranja como anclaje. |
| **Elemento superior** | `REGLAMENTO` en Minion Pro Medium Display $20.0\text{ pt}$ | `REGLAMENTO` en Neuzeit Grotesk Regular $8.5\text{ pt}$ con tracking institucional | *Ninguno* (vacío noble y sereno) |
| **Color elemento sup.** | Naranja POLIFLEX `#f15d22` | Naranja POLIFLEX `#f15d22` (stroke $0.15\text{ pt}$) | N/A |
| **Coordenadas sup.** | $x = 28.9150\text{ pt}, dy = 352.00\text{ pt}$ (baseline $\approx 368.08\text{ pt}$) | $x = 28.9150\text{ pt}, dy = 366.00\text{ pt}$ (baseline $\approx 372.50\text{ pt}$) | N/A |
| **Aire sobre regla** | $20.88\text{ pt}$ de luz libre al acento naranja | $15.50\text{ pt}$ de luz libre al acento naranja | Espacio continuo sin obstáculos |
| **Regla horizontal** | Integrada en vector ($x = 30.10\text{ pt}, y = 388.95\text{ pt}, w = 14.19\text{ pt}$) | Integrada en vector ($x = 30.10\text{ pt}, y = 388.95\text{ pt}, w = 14.19\text{ pt}$) | Integrada en vector ($x = 30.10\text{ pt}, y = 388.95\text{ pt}, w = 14.19\text{ pt}$) |
| **Bloque de título** | Complemento del órgano normado (`DE LA ASAMBLEA...`) | Título canónico completo (`REGLAMENTO DE LA...`) | Título canónico completo (`REGLAMENTO DE LA...`) |
| **Tipografía de título** | Minion Pro Medium Display $15.9929\text{ pt}$ | Minion Pro Medium Display $15.9929\text{ pt}$ | Minion Pro Medium Display $15.9929\text{ pt}$ |
| **Coordenadas título** | $x = 28.3398\text{ pt}, dy = 412.3005\text{ pt}$ (baseline $422.71\text{ pt}$) | $x = 28.3398\text{ pt}, dy = 412.3005\text{ pt}$ (baseline $422.71\text{ pt}$) | $x = 28.3398\text{ pt}, dy = 412.3005\text{ pt}$ (baseline $422.71\text{ pt}$) |
| **Leading del título** | $24.0053\text{ pt}$ (typst leading $13.5939\text{ pt}$) | $24.0053\text{ pt}$ (typst leading $13.5939\text{ pt}$) | $24.0053\text{ pt}$ (typst leading $13.5939\text{ pt}$) |
| **Color del título** | Carbón institucional `#2e2f31` | Carbón institucional `#2e2f31` | Carbón institucional `#2e2f31` |
| **Lectura sintáctica** | Unitaria continua: `"REGLAMENTO — DE LA ASAMBLEA..."` | Categórica y formal: `[REGLAMENTO] / "REGLAMENTO DE LA..."` | Clásica directa: `"REGLAMENTO DE LA ASAMBLEA..."` |
| **Pie de página** | `PROTOCOLO FAMILIAR · VERSION 1.0` en Neuzeit ($y = 594.64\text{ pt}$) | `PROTOCOLO FAMILIAR · VERSION 1.0` en Neuzeit ($y = 594.64\text{ pt}$) | `PROTOCOLO FAMILIAR · VERSION 1.0` en Neuzeit ($y = 594.64\text{ pt}$) |
| **Aire inferior libre** | $\approx 144.14\text{ pt}$ libres de texto a pie ($11.3$ líneas tipográficas) | $\approx 144.14\text{ pt}$ libres de texto a pie ($11.3$ líneas tipográficas) | $\approx 144.14\text{ pt}$ libres de texto a pie ($11.3$ líneas tipográficas) |

---

### 4. ANÁLISIS DETALLADO POR VARIANTE

#### VARIANTE A: Derivación más literal de `chapter-opening()`
- **Elementos heredados:** Fondo vectorial con plano diagonal, logotipo POLIFLEX, retícula de puntos, regla naranja en $y = 388.95\text{ pt}$, tipografía Minion Pro Medium Display, color naranja `#f15d22`, cota de baseline superior ($368.08\text{ pt}$), cota de título ($412.30\text{ pt}$), footer corporativo.
- **Elementos eliminados:** Gran número arábigo de dos dígitos ("01"); párrafo de descripción inferior.
- **Elementos reinterpretados:** La cota del número es ocupada por el sustantivo ceremonial `REGLAMENTO`. Al medir $20\text{ pt}$ (ancho $\approx 135.8\text{ pt}$), se mantiene cómodamente dentro del margen libre antes del plano diagonal (que inicia en $x \approx 174\text{ pt}$). El título bajo la regla actúa como complemento sintáctico directo (*"DE LA ASAMBLEA DE FAMILIA"*), logrando una lectura corrida y natural.
- **Diferencia frente a `chapter-opening()`:** Se reemplaza el gran numeral abstracto por la categoría estatutaria, preservando exactamente el balance tripartito superior-regla-inferior.

#### VARIANTE B: Misma geometría y ADN, con jerarquía específica para REGLAMENTO
- **Elementos heredados:** Fondo vectorial completo, regla naranja, bloque de título en Minion Pro $15.9929\text{ pt}$, footer institucional.
- **Elementos eliminados:** Gran número en Minion Pro; párrafo de descripción inferior.
- **Elementos reinterpretados:** Se introduce como supra-identificador la tipografía secundaria institucional: **Neuzeit Grotesk** ($8.5\text{ pt}$, tracking $0.250\text{ em}$), color naranja `#f15d22`, similar al tratamiento editorial de los cintillos de sección en páginas interiores. Debajo de la regla se ubica el título formal canónico íntegro.
- **Diferencia frente a `chapter-opening()`:** La jerarquía tipográfica no compite con la caja de título; el identificador actúa como metadato institucional y el título formal asume la totalidad de la fuerza visual.

#### VARIANTE C: Versión más sobria / Reducción ceremonial
- **Elementos heredados:** Fondo vectorial institucional, regla naranja de acento, tipografía de título en Minion Pro $15.9929\text{ pt}$, footer corporativo.
- **Elementos eliminados:** Gran número ceremonial; texto sobre la regla naranja; párrafo de descripción inferior.
- **Elementos reinterpretados:** La regla horizontal naranja fija en $y = 388.95\text{ pt}$ se convierte en el **umbral ceremonial único**. El título canónico completo se ubica en $dy = 412.30\text{ pt}$ con amplio espacio de respiración noble por encima y por debajo.
- **Diferencia frente a `chapter-opening()`:** Máxima depuración y serenidad jurídica. Expresa que un Reglamento es una pieza adjetiva de carácter normativo que no requiere estridencia ceremonial, sino sobriedad y peso formal.

---

### 5. ANÁLISIS DE TÍTULOS LARGOS Y SALTOS EDITORIALES

Se evaluaron rigurosamente los tres títulos reales en sus versiones canónicas (Title Case) y en mayúsculas sostenidas (ALL CAPS):

#### 1. Reglamento de la Asamblea de Familia
- **Ancho continuo a 1 línea:** $239.61\text{ pt}$ (Title Case) / $320.58\text{ pt}$ (ALL CAPS).
- **Salto editorial adoptado (2 líneas):**
  - Variante A:
    - Línea 1: `De la Asamblea` ($96.61\text{ pt}$) | ALL CAPS: `DE LA ASAMBLEA` ($125.38\text{ pt}$)
    - Línea 2: `de Familia` ($64.71\text{ pt}$) | ALL CAPS: `DE FAMILIA` ($84.09\text{ pt}$)
  - Variantes B y C:
    - Línea 1: `Reglamento de la` ($106.99\text{ pt}$) | ALL CAPS: `REGLAMENTO DE LA` ($149.92\text{ pt}$)
    - Línea 2: `Asamblea de Familia` ($129.14\text{ pt}$) | ALL CAPS: `ASAMBLEA DE FAMILIA` ($167.19\text{ pt}$)

#### 2. Reglamento del Consejo de Familia
- **Ancho continuo a 1 línea:** $219.87\text{ pt}$ (Title Case) / $292.88\text{ pt}$ (ALL CAPS).
- **Salto editorial adoptado (2 líneas):**
  - Variante A:
    - Línea 1: `Del Consejo` ($76.88\text{ pt}$) | ALL CAPS: `DEL CONSEJO` ($97.68\text{ pt}$)
    - Línea 2: `de Familia` ($64.71\text{ pt}$) | ALL CAPS: `DE FAMILIA` ($84.09\text{ pt}$)
  - Variantes B y C:
    - Línea 1: `Reglamento del` ($96.77\text{ pt}$) | ALL CAPS: `REGLAMENTO DEL` ($135.88\text{ pt}$)
    - Línea 2: `Consejo de Familia` ($119.63\text{ pt}$) | ALL CAPS: `CONSEJO DE FAMILIA` ($153.53\text{ pt}$)

#### 3. Reglamento del Comité de Honor Familiar (Título más largo)
- **Ancho continuo a 1 línea:** $265.40\text{ pt}$ (Title Case) / $354.82\text{ pt}$ (ALL CAPS). Excede el ancho útil ($250\text{ pt}$).
- **Salto editorial adoptado (2 líneas piramidales equilibradas):**
  - Variante A:
    - Línea 1: `Del Comité de` ($89.94\text{ pt}$) | ALL CAPS: `DEL COMITÉ DE` ($114.29\text{ pt}$)
    - Línea 2: `Honor Familiar` ($97.17\text{ pt}$) | ALL CAPS: `HONOR FAMILIAR` ($129.43\text{ pt}$)
    - *Evaluación de balance:* Las dos líneas poseen una longitud prácticamente idéntica ($114.3\text{ pt}$ vs $129.4\text{ pt}$ en ALL CAPS), creando una caja tipográfica de máxima solidez sin palabras huérfanas.
  - Variantes B y C:
    - Línea 1: `Reglamento del Comité` ($146.67\text{ pt}$) | ALL CAPS: `REGLAMENTO DEL COMITÉ` ($198.65\text{ pt}$)
    - Línea 2: `de Honor Familiar` ($115.26\text{ pt}$) | ALL CAPS: `DE HONOR FAMILIAR` ($152.70\text{ pt}$)
    - *Evaluación de balance:* Ambas líneas se mantienen holgadamente por debajo de los $250\text{ pt}$, con una proporción de $1.27:1$, evitando partir la palabra "Comité" o aislar "Familiar" en una tercera línea huérfana.

---

### 6. CAPITALIZACIÓN: EVALUACIÓN EDITORIAL

Conforme al requerimiento expreso de Fase 4.4:
> *"Usar exactamente la denominación existente en cada fuente canónica. Si la capitalización real difiere de la anterior: PREVALECE EL MARKDOWN CANÓNICO."*

Las fuentes canónicas (`capitulos/11_*.md`, `12_*.md`, `13_*.md`) registran sus encabezados en **Title Case** (`Reglamento de la Asamblea de Familia`).
Se generaron las dos suites completas para evaluación visual:
1. **Suite Canónica (Prevalece Markdown):** Utiliza la capitalización real de las fuentes, aportando un matiz humanista clásico propio de la tipografía Garalde.
2. **Suite Mayúsculas Sostenidas (ALL CAPS):** Utiliza mayúsculas display en Minion Pro, manteniendo homogeneidad epigrafía estricta con `DECLARACIÓN DE PRINCIPIOS FAMILIARES...` de `chapter-opening()`.

---

### 7. VERIFICACIÓN DE PARIDAD CEREMONIAL

Se verificó mediante el script de auditoría automatizada [`scripts/auditar_fase_4_4.py`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/scripts/auditar_fase_4_4.py):
- Cada una de las 9 aperturas (más la apertura de referencia del Capítulo 01) inicia estrictamente en **RECTO** (páginas impares 1, 3, 5, 7, 9, 11, 13, 15, 17, 19).
- Todas las páginas pares (2, 4, 6, 8, 10, 12, 14, 16, 18) corresponden a **VERSOS BLANCOS CEREMONIALES**:
  - Sin folio;
  - Sin filete;
  - Sin encabezado;
  - Sin isotipo;
  - Sin pie institucional;
  - Sin claim.
- Total de páginas de cada documento comparativo: **19 páginas exactas**.

---

### 8. AUDITORÍA DE INTEGRIDAD CRIPTOGRÁFICA Y NO-REGRESIÓN

1. **Componentes Centrales locked ([`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ)):**
   - SHA-256: `51EBCD024FC7EC3C65C873DB08CD0F3B1A03718D2EC2234EC210C35D123DF803`
   - Tamaño: `50,020` bytes
   - Estado: **100% INTACTO / ZERO MODIFICATIONS**
2. **Fuentes Canónicas Markdown (`capitulos/*.md`):**
   - 14 archivos auditados: los 14 conservan sus hashes criptográficos idénticos a las Fases 4.1.1 y 4.3.4.
   - Estado: **100% INTACTOS / ZERO MODIFICATIONS**
3. **Auditoría de No-Regresión en Capítulos 01–09 (126 páginas):**
   - Recompilado contra [`tests/test_protocolo_capitulos_01_09_fase_3_9_3.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_protocolo_capitulos_01_09_fase_3_9_3.typ).
   - Resultado: **126 / 126 páginas idénticas bit a bit**. Cero regresión textual o visual.

---

### 9. ENTREGABLES DISPONIBLES PARA REVISIÓN HUMANA

1. **Documento Comparativo Oficial (19 páginas, paridad ceremonial):**
   - [`dist/TEST_REGULATION_OPENING_FASE_4_4_COMPARATIVO.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_OPENING_FASE_4_4_COMPARATIVO.pdf)
2. **Documento Comparativo en Mayúsculas Sostenidas (ALL CAPS, 19 páginas):**
   - [`dist/TEST_REGULATION_OPENING_FASE_4_4_UPPERCASE.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_OPENING_FASE_4_4_UPPERCASE.pdf)
3. **Láminas Comparativas de Visión Conjunta (4-Way Panels):**
   - [regulation_opening_comparativo_4way_canonical.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_comparativo_4way_canonical.png) *(Capítulo 01 + Var A + Var B + Var C en Title Case)*
   - [regulation_opening_comparativo_4way_uppercase.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_comparativo_4way_uppercase.png) *(Capítulo 01 + Var A + Var B + Var C en ALL CAPS)*
4. **Renders en Alta Resolución (300 DPI) del Reglamento más largo (Comité de Honor Familiar):**
   - **Variante A:** [regulation_opening_var_a_comite.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_var_a_comite.png) | [Versión ALL CAPS](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_var_a_comite_uppercase.png)
   - **Variante B:** [regulation_opening_var_b_comite.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_var_b_comite.png) | [Versión ALL CAPS](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_var_b_comite_uppercase.png)
   - **Variante C:** [regulation_opening_var_c_comite.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_var_c_comite.png) | [Versión ALL CAPS](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_var_c_comite_uppercase.png)
   - **Referencia Locked Capítulo 01:** [chapter_01_reference_opening.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/chapter_01_reference_opening.png)

---

### 10. DECLARACIÓN DE INTEGRIDAD Y DETENCIÓN

```
Markdown modificado = FALSE

cover-page() modificado = FALSE
chapter-opening() modificado = FALSE
chapter-first-page() modificado = FALSE
interior-page() modificado = FALSE
introduction-page() modificado = FALSE
table-of-contents() modificado = FALSE

REGULATION_OPENING_STATUS = EXPERIMENTAL / NOT LOCKED
WINNER_SELECTED = NONE (PENDING HUMAN EVALUATION)
```
