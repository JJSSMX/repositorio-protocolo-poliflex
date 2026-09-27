# REPORTE FORENSE DE EVALUACIÓN TIPOGRÁFICA — FASE 4.5.1
## Microajuste de Espacio Posterior R4 (Artículo) → R5 (Cuerpo de Texto)
### Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)

---

## 1. RESUMEN EJECUTIVO Y OBJETIVO DE LA FASE

El presente reporte documenta la evaluación forense, métrica y visual del microajuste vertical aplicado a la separación entre el encabezado normativo **R4** (`Artículo [N]. [Nombre]`) y el comienzo de su respectivo cuerpo normativo **R5** (primer párrafo), tomando como base editorial exclusiva la **VARIANTE A** consolidada experimentalmente en la Fase 4.5.

Conforme a las instrucciones de la Fase 4.5.1:
1. Se preserva al 100% la jerarquía tipográfica, fuente, tamaño, tracking, color y composición del encabezado `Artículo [N]. [Nombre]`.
2. Se preserva íntegramente la identidad de `CAPÍTULO [ROMANO]`, subtítulo, cuerpo, leading ($12.72949\text{ pt}$), interlineado, retícula, márgenes y running headers.
3. Se evalúa exclusivamente la variable de separación posterior del bloque de artículo (`below`) sobre el mismo fragmento canónico real (`capitulos/11_reglamento_asamblea_familia.md`, Líneas 76 a 178).
4. El componente `regulation-page()` permanece en estado **EXPERIMENTAL / NOT LOCKED**.
5. Se mantiene un criterio analítico neutral: **NO se declara ganador automático**, dejando la resolución final a la deliberación humana.

---

## 2. DIAGNÓSTICO DEL PROBLEMA VISUAL EN LA BASELINE (A ORIGINAL)

En la Fase 4.5, la Variante A utilizaba un parámetro `below: 5.50pt` en el componente `regulation-article()`. 

Al analizar la física del bloque compuesto:
* **Encabezado (Minion Pro Medium 9.2 pt):** La cota inferior de su caja tipográfica se ubica en $y_1 = 122.76\text{ pt}$ con su línea de base (baseline) en $120.25\text{ pt}$.
* **Primer párrafo (Neuzeit Grotesk Regular 7.9077 pt):** Comienza en $y_0 = 125.16\text{ pt}$ con baseline en $131.02\text{ pt}$.
* **Distancia inter-baseline:** $131.02\text{ pt} - 120.25\text{ pt} = \mathbf{10.77\text{ pt}}$.
* **Leading regular del cuerpo:** $\mathbf{12.72949\text{ pt}}$.

**Diagnóstico:**
Dado que la distancia entre baselines ($10.77\text{ pt}$) era **inferior** al leading interlineal ordinario del propio texto ($12.73\text{ pt}$), el salto óptico entre el titular y el primer renglón resultaba más comprimido que la separación natural entre renglones del mismo párrafo (ratio de $0.85\times$ leading). Esto generaba una **luz libre óptica de apenas $2.40\text{ pt}$**, produciendo una sensación visual de colisión y falta de respiración rítmica entre el rótulo del artículo y su disposición textual.

---

## 3. ESPECIFICACIÓN DE LAS MICROVARIANTES EVALUADAS

Se generaron y midieron con rigor micrométrico cuatro configuraciones sobre el entorno tipográfico oficial:

| Identificador | Espacio `below` | Descripción Conceptual |
| :--- | :---: | :--- |
| **`A4`** | `4.00 pt` | Microvariante ultracompacta experimental. |
| **`A original`** | `5.50 pt` | Baseline de Fase 4.5 sujeta a revisión. |
| **`A6`** | `6.00 pt` | Microvariante de apertura moderada (+0.50 pt vs. base). |
| **`A8`** | `8.00 pt` | Microvariante armónica calibrada al ritmo vertical (+2.50 pt vs. base). |

---

## 4. TABLA COMPARATIVA DE COTAS FORENSES Y DISTANCIAS VISUALES

Mediciones tomadas en la transición crítica de Página 1 (RECTO): `Artículo 5. De la Instalación de la Asamblea` $\to$ `Las sesiones serán presididas por la persona...`:

| Métrica / Parámetro Forense | A4 (4.0 pt) | A original (5.5 pt) | A6 (6.0 pt) | A8 (8.0 pt) |
| :--- | :---: | :---: | :---: | :---: |
| **Parámetro `below` configurado** | `4.00 pt` | `5.50 pt` | `6.00 pt` | `8.00 pt` |
| **Cota superior encabezado ($y_0$)** | $113.56\text{ pt}$ | $113.56\text{ pt}$ | $113.56\text{ pt}$ | $113.56\text{ pt}$ |
| **Cota inferior encabezado ($y_1$)** | $122.76\text{ pt}$ | $122.76\text{ pt}$ | $122.76\text{ pt}$ | $122.76\text{ pt}$ |
| **Baseline del encabezado** | $120.25\text{ pt}$ | $120.25\text{ pt}$ | $120.25\text{ pt}$ | $120.25\text{ pt}$ |
| **Cota superior primera línea ($y_0$)** | $123.66\text{ pt}$ | $125.16\text{ pt}$ | $125.66\text{ pt}$ | $127.66\text{ pt}$ |
| **Baseline primera línea de cuerpo** | $129.52\text{ pt}$ | $131.02\text{ pt}$ | $131.52\text{ pt}$ | $133.52\text{ pt}$ |
| **Distancia Baseline $\to$ Baseline** | **$9.27\text{ pt}$** | **$10.77\text{ pt}$** | **$11.27\text{ pt}$** | **$13.27\text{ pt}$** |
| **Ratio vs. Leading ($12.729\text{ pt}$)** | $0.73\times$ | $0.85\times$ | $0.89\times$ | $1.04\times$ |
| **Luz libre óptica (caja a caja)** | **$0.90\text{ pt}$** | **$2.40\text{ pt}$** | **$2.90\text{ pt}$** | **$4.90\text{ pt}$** |
| **Evaluación de holgura visual** | Severa colisión | Comprimida | Sutilmente aliviada | Respiración óptima |

---

## 5. IMPACTO ACUMULATIVO EN EL FLUJO MULTIPÁGINA (P1 A P4)

El corpus de prueba contiene un fragmento de 102 líneas en 4 páginas, con 8 artículos (`Artículos 5` a `12`), 11 fracciones romanas distribuidas y la sección de clausura `TRANSITORIO ÚNICO`.

A continuación se detalla el comportamiento de ocupación de caja (caja disponible: $475.99\text{ pt}$ por página):

| Página | Métrica de Flujo | A4 (4.0 pt) | A original (5.5 pt) | A6 (6.0 pt) | A8 (8.0 pt) |
| :---: | :--- | :---: | :---: | :---: | :---: |
| **P1**<br>*(RECTO)* | Altura útil ocupada<br>Porcentaje ocupación<br>Reserva libre inferior<br>Última línea de texto | $450.62\text{ pt}$<br>**94.7%**<br>$25.37\text{ pt}$<br>*...acta correspondiente.* | $453.62\text{ pt}$<br>**95.3%**<br>$22.37\text{ pt}$<br>*...acta correspondiente.* | $454.62\text{ pt}$<br>**95.5%**<br>$21.37\text{ pt}$<br>*...acta correspondiente.* | $458.62\text{ pt}$<br>**96.3%**<br>$17.37\text{ pt}$<br>*...acta correspondiente.* |
| **P2**<br>*(VERSO)* | Altura útil ocupada<br>Porcentaje ocupación<br>Reserva libre inferior<br>Última línea de texto | $440.01\text{ pt}$<br>**92.4%**<br>$35.98\text{ pt}$<br>*...a su competencia.* | $443.01\text{ pt}$<br>**93.1%**<br>$32.98\text{ pt}$<br>*...a su competencia.* | $444.01\text{ pt}$<br>**93.3%**<br>$31.98\text{ pt}$<br>*...a su competencia.* | $448.01\text{ pt}$<br>**94.1%**<br>$27.98\text{ pt}$<br>*...a su competencia.* |
| **P3**<br>*(RECTO)* | Altura útil ocupada<br>Porcentaje ocupación<br>Reserva libre inferior<br>Última línea de texto | $437.82\text{ pt}$<br>**92.0%**<br>$38.17\text{ pt}$<br>*...manera presencial.* | $440.82\text{ pt}$<br>**92.6%**<br>$35.17\text{ pt}$<br>*...manera presencial.* | $441.82\text{ pt}$<br>**92.8%**<br>$34.17\text{ pt}$<br>*...manera presencial.* | $445.82\text{ pt}$<br>**93.7%**<br>$30.17\text{ pt}$<br>*...manera presencial.* |
| **P4**<br>*(VERSO)* | Altura útil ocupada<br>Porcentaje ocupación<br>Reserva libre inferior<br>Cota $y_0$ `TRANSITORIO`<br>Última línea de texto | $245.05\text{ pt}$<br>**51.5%**<br>$230.94\text{ pt}$<br>$258.77\text{ pt}$ ($-3.0\text{ pt}$)<br>*...Protocolo Familiar.* | $248.05\text{ pt}$<br>**52.1%**<br>$227.94\text{ pt}$<br>$261.77\text{ pt}$ ($0.0\text{ pt}$)<br>*...Protocolo Familiar.* | $249.05\text{ pt}$<br>**52.3%**<br>$226.94\text{ pt}$<br>$262.77\text{ pt}$ ($+1.0\text{ pt}$)<br>*...Protocolo Familiar.* | $253.05\text{ pt}$<br>**53.2%**<br>$222.94\text{ pt}$<br>$266.77\text{ pt}$ ($+5.0\text{ pt}$)<br>*...Protocolo Familiar.* |

### 5.1. Conclusiones del Flujo Acumulativo
1. **Cero alteraciones en saltos de página:** Las 4 microvariantes preservan con exactitud matemática el mismo corte de página al cierre de P1, P2 y P3. Ningún párrafo se desborda a la página siguiente.
2. **Cero huérfanas y cero viudas:** Todos los encabezados de capítulo y artículo mantienen su comportamiento `sticky: true` y `breakable: false`, vinculándose indisolublemente a sus párrafos normativos.
3. **Desplazamiento del TRANSITORIO ÚNICO:**
   - En `A4`, se eleva $3.00\text{ pt}$ ($y_0 = 258.77\text{ pt}$).
   - En `A original`, descansa en $y_0 = 261.77\text{ pt}$.
   - En `A6`, desciende $1.00\text{ pt}$ ($y_0 = 262.77\text{ pt}$).
   - En `A8`, desciende $5.00\text{ pt}$ ($y_0 = 266.77\text{ pt}$).
   Dado que Página 4 cuenta con más de $222\text{ pt}$ de holgura en blanco (ocupación ~53%), el desplazamiento vertical de $+5\text{ pt}$ en `A8` resulta totalmente inocuo para la composición global.

---

## 6. DICTAMEN TÉCNICO Y PERFIL DE CADA OPCIÓN

### Opción A4 (`4.00 pt`):
* **Comportamiento:** Empeora sensiblemente el problema detectado. La distancia entre baselines cae a $9.27\text{ pt}$ ($0.73\times$ leading) y la luz libre óptica se reduce a $0.90\text{ pt}$.
* **Veredicto:** No recomendable. Produce aglutinamiento severo del encabezado con el texto.

### Opción A original (`5.50 pt`):
* **Comportamiento:** Distancia entre baselines de $10.77\text{ pt}$ ($0.85\times$ leading) y luz libre de $2.40\text{ pt}$.
* **Veredicto:** Aceptable en densidad, pero visualmente percibida como comprimida al carecer de una línea de respiración completa.

### Opción A6 (`6.00 pt`):
* **Comportamiento:** Añade un incremento sutil (+0.50 pt vs. baseline). Distancia entre baselines de $11.27\text{ pt}$ ($0.89\times$ leading) y luz libre de $2.90\text{ pt}$.
* **Veredicto:** Alivio tímido. Mejora marginalmente la legibilidad sin alterar el carácter compacto de la página.

### Opción A8 (`8.00 pt`):
* **Comportamiento:** Distancia entre baselines de $13.27\text{ pt}$ ($1.04\times$ leading) y luz libre óptica de $4.90\text{ pt}$.
* **Veredicto:** Sintonía rítmica completa con la retícula base de $12.73\text{ pt}$. El encabezado adquiere autonomía visual inmediata y legible sin desvincularse de la cláusula normativa que encabeza. La absorción presupuestaria por página (+5 pt en P1 y P2) se aloja dentro del colchón libre sin generar desbordamientos ni huérfanas.

---

## 7. AUDITORÍA DE INTEGRIDAD Y NO REGRESIÓN

Se ejecutó la verificación estricta mediante el script `scripts/auditar_fase_4_5_1.py`:

```
=== AUDITORÍA FORMAL DE INTEGRIDAD Y NO-REGRESIÓN: FASE 4.5.1 ===
componentes.typ SHA-256: DF123879AA8AFDF3ECEE7333FD31CC624401935CFC2349436A39594EE8CC9F2B
  componentes.typ [LOCKED CONSOLIDADO]: PASS

--- Verificación de fuentes canónicas Markdown ---
  capitulos/00_introduccion.md: PASS
  capitulos/00_portada_e_indice.md: PASS
  capitulos/01_capitulo1_declaracion_principios.md: PASS
  capitulos/02_capitulo2_propiedad_control_liquidez.md: PASS
  capitulos/03_capitulo3_gobierno_profesionalizacion.md: PASS
  capitulos/04_capitulo4_sucesion_familiar.md: PASS
  capitulos/05_capitulo5_control_informacion_comunicacion.md: PASS
  capitulos/06_capitulo6_disciplina_financiera.md: PASS
  capitulos/07_capitulo7_procedimiento_sancionador.md: PASS
  capitulos/08_capitulo8_solucion_conflictos.md: PASS
  capitulos/09_capitulo9_regimen_juridico.md: PASS
  capitulos/10_anexos_formatos_operativos.md: PASS
  capitulos/11_reglamento_asamblea_familia.md: PASS
  capitulos/12_reglamento_consejo_familia.md: PASS
  capitulos/13_reglamento_comite_honor_familiar.md: PASS
Fuentes Markdown: 100% ÍNTEGRAS

--- Verificación de PDFs Fase 4.5.1 ---
  dist/TEST_REGULATION_PAGE_FASE_4_5_1_A_ORIG.pdf: PASS (4 páginas)
  dist/TEST_REGULATION_PAGE_FASE_4_5_1_A4.pdf: PASS (4 páginas)
  dist/TEST_REGULATION_PAGE_FASE_4_5_1_A6.pdf: PASS (4 páginas)
  dist/TEST_REGULATION_PAGE_FASE_4_5_1_A8.pdf: PASS (4 páginas)
  dist/TEST_REGULATION_PAGE_FASE_4_5_1_COMPARATIVO.pdf: PASS (17 páginas)

--- Verificación de No Regresión Capítulos 01–09 ---
  Capítulos 01–09 (126 páginas): 100% IDÉNTICAS (PASS)
```

---

## 8. CATÁLOGO DE ARTEFACTOS Y ENTREGABLES GENERADOS

1. **Lámina Comparativa Forense 1:1 (PNG a 300 DPI):**
   - [`dist/lamina_comparativa_fase_4_5_1_art_spacing.png`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/lamina_comparativa_fase_4_5_1_art_spacing.png)
   - Copia en artefactos: [`lamina_comparativa_fase_4_5_1_art_spacing.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/lamina_comparativa_fase_4_5_1_art_spacing.png)
2. **Documento Comparativo Forense Multipágina (PDF 17 páginas):**
   - [`dist/TEST_REGULATION_PAGE_FASE_4_5_1_COMPARATIVO.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_1_COMPARATIVO.pdf)
3. **PDFs Individuales de Flujo Completo (4 páginas c/u):**
   - [`dist/TEST_REGULATION_PAGE_FASE_4_5_1_A_ORIG.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_1_A_ORIG.pdf) (Baseline 5.5 pt)
   - [`dist/TEST_REGULATION_PAGE_FASE_4_5_1_A4.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_1_A4.pdf) (Microvariante 4.0 pt)
   - [`dist/TEST_REGULATION_PAGE_FASE_4_5_1_A6.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_1_A6.pdf) (Microvariante 6.0 pt)
   - [`dist/TEST_REGULATION_PAGE_FASE_4_5_1_A8.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_REGULATION_PAGE_FASE_4_5_1_A8.pdf) (Microvariante 8.0 pt)
4. **Capturas de Página 1 (PNG a 150 DPI):**
   - [`regulation_page_fase_4_5_1_a_orig_p1.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_fase_4_5_1_a_orig_p1.png)
   - [`regulation_page_fase_4_5_1_a4_p1.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_fase_4_5_1_a4_p1.png)
   - [`regulation_page_fase_4_5_1_a6_p1.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_fase_4_5_1_a6_p1.png)
   - [`regulation_page_fase_4_5_1_a8_p1.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/regulation_page_fase_4_5_1_a8_p1.png)
5. **Métricas Estructuradas en Formato JSON:**
   - [`datos/fase_4_5_1_metricas_microajuste.json`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/datos/fase_4_5_1_metricas_microajuste.json)
6. **Script de Auditoría Formal:**
   - [`scripts/auditar_fase_4_5_1.py`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/scripts/auditar_fase_4_5_1.py)

---
*Reporte concluido conforme al protocolo estricto. Estado del componente: `regulation-page()` PERMANECE EXPERIMENTAL / NOT LOCKED. En espera de resolución humana.*
