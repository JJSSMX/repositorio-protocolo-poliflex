# INFORME TÉCNICO EDITORIAL: FASE 4.4.1
## MICROAJUSTE FORENSE DE `REGULATION-OPENING()`
### Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

---

### 1. OBJETIVO Y RESOLUCIÓN METODOLÓGICA
Conforme a la selección del usuario en **Fase 4.4**, se tomó como base exclusiva de evaluación:
- **Base:** VARIANTE A (Derivación literal de `chapter-opening()`)
- **Tratamiento tipográfico:** Mayúsculas sostenidas (**ALL CAPS**)
- **Estatus:** $\mathbf{regulation-opening() = EXPERIMENTAL\ /\ NOT\ LOCKED}$

El objetivo de esta microfase fue realizar una **calibración vertical forense** de la secuencia:
$$\mathbf{REGLAMENTO} \quad \longrightarrow \quad \text{Regla Naranja} \quad \longrightarrow \quad \mathbf{TÍTULO\ DEL\ ÓRGANO}$$
frente a la secuencia locked de referencia:
$$\mathbf{01} \quad \longrightarrow \quad \text{Regla Naranja} \quad \longrightarrow \quad \mathbf{DECLARACIÓN\ DE\ PRINCIPIOS...}$$

---

### 2. REGLAS DE CONGELAMIENTO Y AISLAMIENTO DE VARIABLES
1. **Regla naranja:** Fija e invariable en el fondo vectorial ($x_0 = 30.0960\text{ pt}, y_0 = 388.9540\text{ pt}, y_1 = 389.8560\text{ pt}$, ancho $14.1900\text{ pt}$, espesor $0.9020\text{ pt}$).
2. **Título inferior:** Congelado en $dy = 412.3005\text{ pt}$ (Línea 1 visual $y_0 = 411.0851\text{ pt}$, baseline $y = 422.7119\text{ pt}$).
3. **Relación Regla → Título:** Completamente congelada:
   - Luz libre de borde inferior de regla a borde superior de título: **$21.2291\text{ pt}$**.
   - Distancia de base de regla a baseline de Línea 1: **$32.8559\text{ pt}$**.
4. **Variable única calibrada:** Posición vertical $dy$ del identificador `REGLAMENTO`.

---

### 3. TABLA COMPARATIVA FORENSE: `CHAPTER-OPENING()` VS VARIANTES DE CALIBRACIÓN

| Parámetro Geométrico / Óptico | `chapter-opening()`<br>*(CAPÍTULO 01 LOCKED)* | `regulation-opening()`<br>**A0 (Baseline 4.4)** | `regulation-opening()`<br>**A- (Offset -4.00 pt)** | `regulation-opening()`<br>**A+ (Offset +4.00 pt)** |
| :--- | :---: | :---: | :---: | :---: |
| **Texto elemento superior** | `"01"` | `"REGLAMENTO"` | `"REGLAMENTO"` | `"REGLAMENTO"` |
| **Tipografía / Estilo** | Minion Pro MedDisp | Minion Pro MedDisp | Minion Pro MedDisp | Minion Pro MedDisp |
| **Cuerpo tipográfico** | $39.3657\text{ pt}$ | $20.0000\text{ pt}$ | $20.0000\text{ pt}$ | $20.0000\text{ pt}$ |
| **Tracking** | $-0.050\text{ em}$ | $+0.050\text{ em}$ | $+0.050\text{ em}$ | $+0.050\text{ em}$ |
| **Color del elemento sup.** | Naranja `#f15d22` | Naranja `#f15d22` | Naranja `#f15d22` | Naranja `#f15d22` |
| **Coordenada $dy$ de entrada** | $342.4491\text{ pt}$ | **$352.0000\text{ pt}$** | **$348.0000\text{ pt}$** | **$356.0000\text{ pt}$** |
| **Visual Bounding Box ($x_0, y_0, x_1, y_1$)** | $(28.92, 339.46, 63.08, 378.82)\text{ pt}$ | $(28.92, 350.48, 164.76, 370.48)\text{ pt}$ | $(28.92, 346.48, 164.76, 366.48)\text{ pt}$ | $(28.92, 354.48, 164.76, 374.48)\text{ pt}$ |
| **Ancho / Alto visual** | $34.17\text{ pt} \times 39.37\text{ pt}$ | $135.84\text{ pt} \times 20.00\text{ pt}$ | $135.84\text{ pt} \times 20.00\text{ pt}$ | $135.84\text{ pt} \times 20.00\text{ pt}$ |
| **Baseline del elemento superior ($y$)** | **$368.0762\text{ pt}$** | **$365.0200\text{ pt}$** | **$361.0200\text{ pt}$** | **$369.0200\text{ pt}$** |
| **Cima de la regla naranja ($y_0$)** | $388.9540\text{ pt}$ | $388.9540\text{ pt}$ | $388.9540\text{ pt}$ | $388.9540\text{ pt}$ |
| **Luz libre superior (Texto $\to$ Regla)** | **$10.1310\text{ pt}$** | **$18.4740\text{ pt}$** | **$22.4740\text{ pt}$** | **$14.4740\text{ pt}$** |
| **Distancia Baseline superior $\to$ Regla** | $20.8778\text{ pt}$ | $23.9340\text{ pt}$ | $27.9340\text{ pt}$ | $19.9340\text{ pt}$ |
| **Espesor de la regla naranja** | $0.9020\text{ pt}$ | $0.9020\text{ pt}$ | $0.9020\text{ pt}$ | $0.9020\text{ pt}$ |
| **Base de la regla naranja ($y_1$)** | $389.8560\text{ pt}$ | $389.8560\text{ pt}$ | $389.8560\text{ pt}$ | $389.8560\text{ pt}$ |
| **Luz libre inferior (Regla $\to$ Título)** | **$21.2291\text{ pt}$** | **$21.2291\text{ pt}$** | **$21.2291\text{ pt}$** | **$21.2291\text{ pt}$** |
| **Distancia Regla $\to$ Baseline Título L1** | $32.8559\text{ pt}$ | $32.8559\text{ pt}$ | $32.8559\text{ pt}$ | $32.8559\text{ pt}$ |
| **Balance simétrico (Luz sup. vs Luz inf.)** | $10.13\text{ pt}$ vs $21.23\text{ pt}$ ($\Delta = 11.10\text{ pt}$) | $18.47\text{ pt}$ vs $21.23\text{ pt}$ ($\mathbf{\Delta = 2.76\text{ pt}}$) | $22.47\text{ pt}$ vs $21.23\text{ pt}$ ($\mathbf{\Delta = 1.25\text{ pt}}$) | $14.47\text{ pt}$ vs $21.23\text{ pt}$ ($\mathbf{\Delta = 6.76\text{ pt}}$) |
| **Altura total del bloque de título** | $64.0034\text{ pt}$ (3 líneas) | $39.9982\text{ pt}$ (2 líneas) | $39.9982\text{ pt}$ (2 líneas) | $39.9982\text{ pt}$ (2 líneas) |

---

### 4. EVALUACIÓN Y ANÁLISIS ÓPTICO DE LAS TRES OPCIONES

#### A0: Baseline Fase 4.4 ($dy = 352.00\text{ pt}$, Baseline $365.02\text{ pt}$)
- **Comportamiento:** La distancia libre desde la base de `REGLAMENTO` a la regla naranja es de **$18.47\text{ pt}$**, frente a los **$21.23\text{ pt}$** de luz libre desde la regla al título inferior.
- **Diagnóstico:** Presenta una diferencia de apenas **$2.76\text{ pt}$** entre el aire superior y el aire inferior. Visualmente, la regla naranja se percibe casi exactamente en el centro óptico del intercolumnio vertical. Produce una sensación de estabilidad sólida, reposada y ceremonial.

#### A-: Microajuste hacia arriba ($-4.00\text{ pt}$, $dy = 348.00\text{ pt}$, Baseline $361.02\text{ pt}$)
- **Comportamiento:** La luz libre superior aumenta a **$22.47\text{ pt}$**, frente a los **$21.23\text{ pt}$** inferiores.
- **Diagnóstico:** Logra la **máxima simetría métrica** de aire libre ($\Delta = 1.25\text{ pt}$). La palabra `REGLAMENTO` adquiere mayor distancia respecto a la regla, acentuando su carácter de titular superior independiente y aumentando la sensación de amplitud y holgura.

#### A+: Microajuste hacia abajo ($+4.00\text{ pt}$, $dy = 356.00\text{ pt}$, Baseline $369.02\text{ pt}$)
- **Comportamiento:** La luz libre superior se reduce a **$14.47\text{ pt}$**, mientras que la baseline ($369.02\text{ pt}$) coincide de forma prácticamente exacta con la baseline original del número "01" ($368.08\text{ pt}$).
- **Diagnóstico:** Logra la **mayor fidelidad de cota de línea base con `chapter-opening()`**. Al estar $4\text{ pt}$ más cerca de la regla, `REGLAMENTO` y la regla naranja se agrupan con mayor tensión visual, emulando la proximidad compacta que el gran número "01" mantenía con su regla en la apertura de capítulo.

---

### 5. COMPORTAMIENTO CON LOS TRES TÍTULOS REALES

En las tres opciones de calibración ($A0, A-, A+$), la caja tipográfica de los tres títulos canónicos opera con saltos editoriales estrictamente controlados:

1. **Reglamento de la Asamblea de Familia:**
   - Línea 1: `DE LA ASAMBLEA` ($125.38\text{ pt}$)
   - Línea 2: `DE FAMILIA` ($84.09\text{ pt}$)
   - Altura total: $39.9982\text{ pt}$. Amplitud y respiración impecables.
2. **Reglamento del Consejo de Familia:**
   - Línea 1: `DEL CONSEJO` ($97.68\text{ pt}$)
   - Línea 2: `DE FAMILIA` ($84.09\text{ pt}$)
   - Altura total: $39.9982\text{ pt}$. Amplitud y respiración impecables.
3. **Reglamento del Comité de Honor Familiar (Caso Crítico Principal):**
   - Línea 1: `DEL COMITÉ DE` ($114.29\text{ pt}$)
   - Línea 2: `HONOR FAMILIAR` ($129.43\text{ pt}$)
   - Altura total: $39.9982\text{ pt}$. Máximo equilibrio visual ($114\text{ pt}$ frente a $129\text{ pt}$).

---

### 6. ENTREGABLES DISPONIBLES PARA REVISIÓN HUMANA

1. **Documento PDF de Evaluación (19 páginas, paridad ceremonial estricta):**
   - [`dist/TEST_REGULATION_OPENING_FASE_4_4_1_COMPARATIVO.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_OPENING_FASE_4_4_1_COMPARATIVO.pdf)
   *(Pág. 1: Capítulo 01; Págs. 3, 5, 7: Comité en A0, A-, A+; Págs. 9, 11: Asamblea y Consejo en A0; Págs. 13, 15: A-; Págs. 17, 19: A+; todas las páginas pares corresponden a versos blancos ceremoniales).*

2. **Láminas Comparativas a Escala 1:1:**
   - **Lámina 1 (Microajustes A0 vs A- vs A+ vs Capítulo 01):** [lamina_comparativa_fase_4_4_1_microajustes.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/lamina_comparativa_fase_4_4_1_microajustes.png)
   - **Lámina 2 (A0 aplicado a los tres Reglamentos):** [lamina_comparativa_fase_4_4_1_a0_multi_reglamento.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/lamina_comparativa_fase_4_4_1_a0_multi_reglamento.png)

3. **Renders en Alta Resolución (300 DPI):**
   - **Comité A0:** [regulation_opening_fase_4_4_1_a0_comite.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_fase_4_4_1_a0_comite.png)
   - **Comité A-:** [regulation_opening_fase_4_4_1_aminus_comite.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_fase_4_4_1_aminus_comite.png)
   - **Comité A+:** [regulation_opening_fase_4_4_1_aplus_comite.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_fase_4_4_1_aplus_comite.png)
   - **Asamblea A0:** [regulation_opening_fase_4_4_1_a0_asamblea.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_fase_4_4_1_a0_asamblea.png)
   - **Consejo A0:** [regulation_opening_fase_4_4_1_a0_consejo.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_opening_fase_4_4_1_a0_consejo.png)
   - **Capítulo 01 Referencia Locked:** [ch01_reference_opening.png](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ch01_reference_opening.png)

---

### 7. CERTIFICACIÓN DE INTEGRIDAD Y DECLARACIÓN DE CIERRE

```
Markdown modificado = FALSE

cover-page() modificado = FALSE
chapter-opening() modificado = FALSE
chapter-first-page() modificado = FALSE
interior-page() modificado = FALSE
introduction-page() modificado = FALSE
table-of-contents() modificado = FALSE
componentes.typ modificado = FALSE

REGULATION_OPENING_STATUS = EXPERIMENTAL / NOT LOCKED
WINNER_SELECTED = NONE (PENDING HUMAN EVALUATION)
```
