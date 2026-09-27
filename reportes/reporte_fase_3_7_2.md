# REPORTE FORENSE EDITORIAL: FASE 3.7.2
**Calibración de Respiración en Chapter-First-Page**  
**Documento:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Fecha de Ejecución:** 26 de septiembre de 2026  
**Motor Editorial:** Typst 0.15.1 + Python 3  
**Estado de Gobernanza de Componentes:**
- `cover-page()`: **APPROVED / LOCKED**
- `table-of-contents()`: **APPROVED / LOCKED**
- `chapter-opening()`: **APPROVED / LOCKED**
- `chapter-first-page()`: **PENDING VISUAL REVIEW**
- `interior-page()`: **PENDING STRESS TEST REVIEW**

---

## 1. RESUMEN EJECUTIVO

La **Fase 3.7.2** abordó de forma focalizada la separación vertical entre el bloque superior de identidad (claim institucional y arcos concéntricos) y el bloque de contenido editorial del capítulo (que arranca con el número grande display) en el componente `chapter-first-page()`.

### Diagnóstico Visual Previo
La revisión visual de la Fase 3.7.1 detectó proximidad excesiva entre la cuarta línea del claim (`CONSTRUIMOS JUNTOS.`) y el número display (`01`). El análisis forense de coordenadas confirmó una **superposición física de las cajas de texto de $2.29\text{ pt}$** en el estado previo, lo que provocaba que el número grande se percibiera erróneamente vinculado al claim en lugar de encabezar la sección de contenido.

### Solución Implementada
Se introdujo una separación vertical de **$+6\text{ mm}$ ($+17.01\text{ pt}$)** antes del número grande, desplazando hacia abajo como una **sola unidad indivisible**:
- Número grande display del capítulo.
- Filete horizontal naranja.
- Título completo multilínea del capítulo.
- Punto de inserción del primer encabezado de contenido (H2).
- Flujo de contenido jurídico de la página.

El claim superior, los arcos concéntricos, el filete vertical del lomo y la geometría de la página permanecieron estrictamente fijos.

---

## 2. MEDICIONES FORENSES COMPARATIVAS (CAPÍTULO 01)

| Elemento Estructural | Estado Actual (0 mm) | Propuesta (+6 mm) | Variación ($\Delta$) | Estado / Observación |
|:---|:---:|:---:|:---:|:---|
| **Claim: Línea 1** (`UN LEGADO`) | $y \in [28.64, 33.47]\text{ pt}$ | $y \in [28.64, 33.47]\text{ pt}$ | $0.00\text{ pt}$ | **Fijo e idéntico** |
| **Claim: Línea 4** (`CONSTRUIMOS JUNTOS.`) | $y \in [76.47, 81.30]\text{ pt}$ | $y \in [76.47, 81.30]\text{ pt}$ | $0.00\text{ pt}$ | **Fijo e idéntico** |
| **Arcos concéntricos (50%)** | $y = 0.00\text{ pt}$ | $y = 0.00\text{ pt}$ | $0.00\text{ pt}$ | **Fijo e idéntico** |
| **Filete de lomo** | $x = 30.13\text{ pt}$ | $x = 30.13\text{ pt}$ | $0.00\text{ pt}$ | **Fijo e idéntico** |
| **Número display (`01`)** | $y \in [79.01, 118.37]\text{ pt}$ | $y \in [96.02, 135.38]\text{ pt}$ | **$+17.01\text{ pt}$** | **$+6.00\text{ mm}$ hacia abajo** |
| **Separación Claim $\rightarrow$ Número** | **$-2.29\text{ pt}$ (colisión)** | **$+14.72\text{ pt}$ ($5.19\text{ mm}$)** | **$+17.01\text{ pt}$** | **Respiración nítida y limpia** |
| **Filete horizontal naranja** | $y \in [128.95, 129.86]\text{ pt}$ | $y \in [145.96, 146.87]\text{ pt}$ | **$+17.01\text{ pt}$** | **Desplazamiento solidario** |
| **Título de capítulo (Línea 1)** | $y \in [151.08, 167.08]\text{ pt}$ | $y \in [168.09, 184.09]\text{ pt}$ | **$+17.01\text{ pt}$** | **Desplazamiento solidario** |
| **Heading 1.1 (Sección)** | $y \in [231.04, 241.04]\text{ pt}$ | $y \in [248.05, 258.05]\text{ pt}$ | **$+17.01\text{ pt}$** | **Desplazamiento solidario** |

---

## 3. PRESERVACIÓN DE DISTANCIAS RELATIVAS INTERNAS

Se verificó matemáticamente que las distancias relativas entre los componentes del bloque editorial permanecen estrictamente inalteradas:

- **Distancia Número $\rightarrow$ Filete:**
  - Actual: $49.94\text{ pt}$
  - Propuesta +6 mm: $49.94\text{ pt}$ ($\Delta = 0.00\text{ pt}$)
- **Distancia Filete $\rightarrow$ Título (Línea 1):**
  - Actual: $22.13\text{ pt}$
  - Propuesta +6 mm: $22.13\text{ pt}$ ($\Delta = 0.00\text{ pt}$)
- **Distancia Título (Línea 1) $\rightarrow$ Heading 1.1:**
  - Actual: $79.96\text{ pt}$
  - Propuesta +6 mm: $79.96\text{ pt}$ ($\Delta = 0.00\text{ pt}$)

---

## 4. EVALUACIÓN DEL FLUJO DE CONTENIDO EN CAPÍTULOS 01, 02 Y 03

Conforme a la **Sección 6** de las instrucciones, no se comprimió el interlineado ni el tamaño de fuente; el contenido fluyó naturalmente:

1. **Capítulo 01 (Página 05):**
   - **Flujo:** **100% Idéntico**.
   - **Líneas desplazadas:** **0 líneas**.
   - Contiene la totalidad de la Sección 1.1 (*Misión y Propósito Familiar Empresarial*) y la Sección 1.2 (*Visión Intergeneracional y Proyecto de Largo Plazo*). El último párrafo finaliza en $y = 485.61\text{ pt}$, conservando un margen libre de más de $90\text{ pt}$ respecto al footer.
2. **Capítulo 02 (Página 11):**
   - **Flujo:** **100% Idéntico**.
   - **Líneas desplazadas:** **0 líneas**.
   - Contiene la totalidad de la Sección 2.1, Subsección 2.1.1 y el arranque de 2.1.2. El último párrafo finaliza en $y = 546.97\text{ pt}$, respetando holgadamente el límite de seguridad de $575\text{ pt}$.
3. **Capítulo 03 (Página 39):**
   - **Título de 5 líneas:** Requiere $106.43\text{ pt}$ de altura.
   - **Flujo:** Las **dos últimas líneas** del párrafo final de la Sección 3.1:
     > *"las barreras de acceso a posiciones de decisión, evitando la captura informal de la organización y preservando la estabilidad y continuidad del sistema."*
     pasaron naturalmente a la cabecera de la página siguiente (Página 40, `interior-page()`).
   - **Dictamen:** En estricto apego a las directrices de la Fase 3.7.2 (*"Si como consecuencia algunas líneas que antes cabían en chapter-first-page() pasan a la siguiente interior-page(): ESO ES CORRECTO. No introducir compensaciones manuales"*), este comportamiento es el esperado del motor tipográfico continuo y confirma la solidez de la regla.

---

## 5. AUDITORÍA DE REGRESIÓN Y CONTENIDO CANÓNICO

Los archivos canónicos `/capitulos/*.md` se conservaron estrictamente **READ ONLY**. Los hashes criptográficos confirman coincidencia bit por bit:

| Archivo | SHA-256 Hash | Estado |
|:---|:---:|:---:|
| `00_introduccion.md` | `deeeca7863249db1348bef6138e0daeda35b5120658459d0362309e543fecad8` | INTACTO |
| `00_portada_e_indice.md` | `a030ec14a57b0c86dea4b17fdd057c4ffabc53948f94bb91d37c79e2bd20cd54` | INTACTO |
| `01_capitulo1_declaracion_principios.md` | `b18b22334759386a547dc94103f6a63ec5ad72bfc9baa10e4453d9143e58246e` | INTACTO |
| `02_capitulo2_propiedad_control_liquidez.md` | `5d3aa506523703d1d5588e74addabb3eb4f11b1a660653ad50f09b787ea46886` | INTACTO |
| `03_capitulo3_gobierno_profesionalizacion.md` | `536c8d9879441cde924c78c36f4b4879a9f69069540faa699e002367a0b8cc53` | INTACTO |
| `04_capitulo4_sucesion_familiar.md` | `4ccbe4d2e25b5fc8e50ea11be6206da044e532caca7fb70beda6345bd693619a` | INTACTO |
| `05_capitulo5_control_informacion_comunicacion.md` | `b8a731fcb4939e95861f2608d86a20137e67ec462ff4d40b06c567719f336342` | INTACTO |
| `06_capitulo6_disciplina_financiera.md` | `3d6157e2201487a43b8262cf22e4e07f60bd680e827759f7bc3d02f47f383d73` | INTACTO |
| `07_capitulo7_procedimiento_sancionador.md` | `de32e740807452dbbb5e2676386eb491a268071859e8cf00110a578127a30caf` | INTACTO |
| `08_capitulo8_solucion_conflictos.md` | `e041394a51c1dce44389bac05a4a3d393cd48f3d825aef17e0495402271669ef` | INTACTO |
| `09_capitulo9_regimen_juridico.md` | `c3a7b5e4dc6d45ca9980a687e1db7dcdf1286228dafaae6d09180fe23a4f1245` | INTACTO |
| `10_anexos_formatos_operativos.md` | `588a64539a62b89ba25d31e54e504fb7a5edf9698ac085b6250cc3f91b774826` | INTACTO |
| `11_reglamento_asamblea_familia.md` | `52034b382ba0f3137016f1f8be8f20ab2c76d134e9deec1160be55abfad724d3` | INTACTO |
| `12_reglamento_consejo_familia.md` | `fde5f0d62f99b198d4c238e36225ae62770c4c9255371715b0292da12cb0ea18` | INTACTO |
| `13_reglamento_comite_honor_familiar.md` | `8662411cbaa2aad718f4f48d0ce6083250d6935349530843966dc2a00140c23b` | INTACTO |

---

## 6. GALERÍA VISUAL Y REGISTRO DE ARTEFACTOS

````carousel
![Comparativa Lado a Lado: Actual (0 mm) vs Propuesta (+6 mm)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/first_page_breathing_comparison.png)
<!-- slide -->
![Capítulo 01 con +6 mm](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/first_page_cap01_6mm.png)
<!-- slide -->
![Capítulo 02 con +6 mm](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/first_page_cap02_6mm.png)
<!-- slide -->
![Capítulo 03 con +6 mm (5 líneas de título)](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/first_page_cap03_6mm.png)
````

### Enlaces a Entregables PDF y Gráficos (150 DPI)
- **Pliego Comparativo Lado a Lado:** [`dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_COMPARISON.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_COMPARISON.pdf)
- **Primeras Páginas Capítulos 01–03 con +6 mm:** [`dist/TEST_CHAPTER_FIRST_PAGE_01_03_6MM.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_FIRST_PAGE_01_03_6MM.pdf)
- **Página Individual Actual (0 mm):** [`dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_CURRENT.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_CURRENT.pdf)
- **Página Individual Propuesta (+6 mm):** [`dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_6MM.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_FIRST_PAGE_BREATHING_6MM.pdf)
- **Imagen Comparativa (150 DPI):** [`first_page_breathing_comparison.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/first_page_breathing_comparison.png)

---

## 7. ESTADO DE GOBERNANZA Y CIERRE

- `cover-page()`: **APPROVED / LOCKED**
- `table-of-contents()`: **APPROVED / LOCKED**
- `chapter-opening()`: **APPROVED / LOCKED**
- `chapter-first-page()`: **PENDING VISUAL REVIEW**
- `interior-page()`: **PENDING STRESS TEST REVIEW**

> [!IMPORTANT]
> El sistema se detiene en este punto conforme a las instrucciones. No se ha consolidado el valor de $+6\text{ mm}$ como definitivo en producción, no se han modificado otros componentes ni se han compilado capítulos posteriores. El proyecto queda a la espera de la inspección visual del usuario sobre el pliego comparativo.
