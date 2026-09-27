# REPORTE FORENSE EDITORIAL: FASE 3.7.1
**Ajuste de Retícula Superior y Apertura Ceremonial · Capítulos 01–03**  
**Documento:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Fecha de Ejecución:** 26 de septiembre de 2026  
**Motor Editorial:** Typst 0.15.1 + Python 3  
**Estado de Gobernanza de Componentes:**
- `cover-page()`: **APPROVED / LOCKED**
- `table-of-contents()`: **APPROVED / LOCKED**
- `chapter-opening()`: **APPROVED / LOCKED**
- `chapter-first-page()`: **PENDING STRESS TEST REVIEW**
- `interior-page()`: **PENDING STRESS TEST REVIEW**

---

## 1. RESUMEN EJECUTIVO

La **Fase 3.7.1** tuvo por objetivo resolver de manera quirúrgica y exclusiva dos observaciones editoriales derivadas de la inspección visual de la prueba de estrés de los capítulos 01–03:

1. **Ajuste de Retícula Superior / Respiración:** Producir una comparativa rigurosa con tres alternativas de incremento vertical (+4 mm, +6 mm, +8 mm) manteniendo fija la posición absoluta del running header aprobado. Conforme a las instrucciones, el valor actual del margen superior se mantiene provisionalmente en el documento maestro completo hasta la decisión visual del usuario.
2. **Doble Apertura Ceremonial:** Implementar una infraestructura obligatoria y genérica (`ceremonial-blank-page()`) mediante la cual **todo capítulo** inicie con una secuencia ceremonial de doble pliego:
   - **Spread A:** `[ BLANCA ] (Verso) | [ CHAPTER-OPENING ] (Recto)`
   - **Spread B:** `[ BLANCA ] (Verso) | [ CHAPTER-FIRST-PAGE ] (Recto)`
   - **Spread C en adelante:** `[ INTERIOR-PAGE ] (Verso) | [ INTERIOR-PAGE ] (Recto)`

### Entregables Generados

| Documento | Archivo PDF | Descripción |
|:---|:---|:---|
| **Comparativa de Margen** | [`dist/TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf) | 3 páginas con banners diagnósticos comparando +4, +6 y +8 mm |
| **Variante +4 mm** | [`dist/TEST_INTERIOR_TOP_MARGIN_4MM.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTERIOR_TOP_MARGIN_4MM.pdf) | Página interior real con +4 mm (+11.34 pt) de separación |
| **Variante +6 mm** | [`dist/TEST_INTERIOR_TOP_MARGIN_6MM.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTERIOR_TOP_MARGIN_6MM.pdf) | Página interior real con +6 mm (+17.01 pt) de separación |
| **Variante +8 mm** | [`dist/TEST_INTERIOR_TOP_MARGIN_8MM.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTERIOR_TOP_MARGIN_8MM.pdf) | Página interior real con +8 mm (+22.68 pt) de separación |
| **Panel Comparativo** | [`dist/TEST_INTERIOR_TOP_MARGIN_PANEL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_INTERIOR_TOP_MARGIN_PANEL.pdf) | Pliego horizontal triple (1188 × 612 pt) lado a lado |
| **Aperturas Ceremoniales** | [`dist/TEST_CEREMONIAL_OPENINGS.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CEREMONIAL_OPENINGS.pdf) | 6 spreads enfrentados mostrando exclusivamente las aperturas |
| **PDF Ceremonial Completo** | [`dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CAPITULOS_01_03_CEREMONIAL.pdf) | 54 páginas secuenciales completas con la nueva arquitectura |
| **Pliegos Completos** | [`dist/TEST_CAPITULOS_01_03_CEREMONIAL_SPREADS.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CAPITULOS_01_03_CEREMONIAL_SPREADS.pdf) | 28 pliegos dobles enfrentados (Verso \| Recto a 792 × 612 pt) |

---

## 2. COMPARATIVA DE RETÍCULA SUPERIOR / RESPIRACIÓN

Se evaluó la distancia vertical entre la línea base del running header institucional ($y = 35.00\text{ pt}$) y el inicio superior de la caja de contenido en páginas interiores de lectura continua (`interior-page()`).

### Parámetros Congelados
- **Línea base del running header:** $y = 35.00\text{ pt}$ (fija e inalterada).
- **Tipografía y tracking del running header:** Neuzeit Grotesk 5.5 pt, tracking +0.200em.
- **Isotipo institucional POLIFLEX:** $7.12 \times 7.00\text{ pt}$ al 50% de opacidad.
- **Filete vertical del lomo:** $x = 30.13\text{ pt}$ (Recto) / $365.87\text{ pt}$ (Verso).
- **Folio exterior:** $y = 595.00\text{ pt}$ (Minion Pro Medium Display 8 pt, color naranja).
- **Chapter First Page:** Su geometría vertical permanece 100% inalterada.

### Mediciones Forenses de las Variantes

| Parámetro | Base Actual (3.7) | Variante A (+4 mm) | Variante B (+6 mm) | Variante C (+8 mm) |
|:---|:---:|:---:|:---:|:---:|
| **Incremento adicional** | $0.00\text{ mm}$ ($0.00\text{ pt}$) | **$+4.00\text{ mm}$ ($+11.34\text{ pt}$)** | **$+6.00\text{ mm}$ ($+17.01\text{ pt}$)** | **$+8.00\text{ mm}$ ($+22.68\text{ pt}$)** |
| **Límite superior de caja (`top`)** | $54.00\text{ pt}$ ($19.05\text{ mm}$) | $65.34\text{ pt}$ ($23.05\text{ mm}$) | $71.01\text{ pt}$ ($25.05\text{ mm}$) | $76.68\text{ pt}$ ($27.05\text{ mm}$)|
| **Línea base Running Header** | $35.00\text{ pt}$ | $35.00\text{ pt}$ | $35.00\text{ pt}$ | $35.00\text{ pt}$ |
| **Separación Header $\rightarrow$ Caja** | $19.00\text{ pt}$ ($6.70\text{ mm}$) | **$30.34\text{ pt}$ ($10.70\text{ mm}$)** | **$36.01\text{ pt}$ ($12.70\text{ mm}$)** | **$41.68\text{ pt}$ ($14.70\text{ mm}$)** |
| **Línea base primer Heading (H2)** | $74.58\text{ pt}$ | $85.92\text{ pt}$ | $91.59\text{ pt}$ | $97.26\text{ pt}$ |

> [!NOTE]
> Las tres alternativas se encuentran compiladas en `dist/TEST_INTERIOR_TOP_MARGIN_COMPARISON.pdf` para facilitar la decisión visual del usuario. En el documento maestro ceremonial completo se conservó provisionalmente la base de $54.00\text{ pt}$.

---

## 3. ARQUITECTURA DE LA DOBLE APERTURA CEREMONIAL

Para conferir solemnidad y jerarquía editorial, se estableció que cada capítulo inicie siempre en página impar (Recto), enfrentado a una página completamente blanca en plana izquierda (Verso).

### Secuencia Física por Capítulo

```text
SPREAD A — PORTADA DEL CAPÍTULO
[ BLANCA ] (Verso) | [ CHAPTER-OPENING ] (Recto)

SPREAD B — PRIMERA PÁGINA DE CONTENIDO
[ BLANCA ] (Verso) | [ CHAPTER-FIRST-PAGE ] (Recto)

SPREAD C EN ADELANTE — LECTURA NORMAL
[ INTERIOR-PAGE ] (Verso) | [ INTERIOR-PAGE ] (Recto)
```

### Componente `ceremonial-blank-page()`
- **Implementación:** Emisión de página física en Typst sin márgenes, cabeceras, pies ni gráficos:
  `#page(margin: 0pt, header: none, footer: none)[ #metadata("ceremonial-blank") <blank-page-marker> ]`
- **Elementos gráficos:** 0 (cero líneas, cero imágenes, cero textos).
- **Folio visible:** Falso (suprimido).
- **Cómputo:** Participa en la paridad física y secuencia del contador global de páginas.

---

## 4. REGISTRO DE EVENTOS CEREMONIALES POR CAPÍTULO

| Capítulo | Evento | Página Física | Paridad | Página Anterior | Estado Anterior | Primera Interior | Paridad Primera Interior |
|:---:|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| **01** | `chapter-opening()` | **Pág 03** | **RECTO (Odd)** | Pág 02 | **BLANCA / VERSO** | — | — |
| **01** | `chapter-first-page()` | **Pág 05** | **RECTO (Odd)** | Pág 04 | **BLANCA / VERSO** | **Pág 06** | **VERSO (Even)** |
| **02** | `chapter-opening()` | **Pág 09** | **RECTO (Odd)** | Pág 08 | **BLANCA / VERSO** | — | — |
| **02** | `chapter-first-page()` | **Pág 11** | **RECTO (Odd)** | Pág 10 | **BLANCA / VERSO** | **Pág 12** | **VERSO (Even)** |
| **03** | `chapter-opening()` | **Pág 37** | **RECTO (Odd)** | Pág 36 | **BLANCA / VERSO** | — | — |
| **03** | `chapter-first-page()` | **Pág 39** | **RECTO (Odd)** | Pág 38 | **BLANCA / VERSO** | **Pág 40** | **VERSO (Even)** |

---

## 5. VALIDACIÓN DE REGLAS OBLIGATORIAS (AUDITORÍA AUTOMATIZADA)

La auditoría forense ejecutada por [`scripts/auditar_fase_3_7_1.py`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/scripts/auditar_fase_3_7_1.py) arrojó un cumplimiento del **100%** en todas las reglas obligatorias:

1. **`chapter-opening parity = ODD / RECTO`:**
   - Capítulo 01: P.03 $\rightarrow$ **CUMPLE**
   - Capítulo 02: P.09 $\rightarrow$ **CUMPLE**
   - Capítulo 03: P.37 $\rightarrow$ **CUMPLE**
2. **`chapter-first-page parity = ODD / RECTO`:**
   - Capítulo 01: P.05 $\rightarrow$ **CUMPLE**
   - Capítulo 02: P.11 $\rightarrow$ **CUMPLE**
   - Capítulo 03: P.39 $\rightarrow$ **CUMPLE**
3. **`previous page to chapter-opening = BLANK / VERSO`:**
   - Capítulo 01: P.02 (Verso, Blanca) $\rightarrow$ **CUMPLE**
   - Capítulo 02: P.08 (Verso, Blanca) $\rightarrow$ **CUMPLE**
   - Capítulo 03: P.36 (Verso, Blanca) $\rightarrow$ **CUMPLE**
4. **`previous page to chapter-first-page = BLANK / VERSO`:**
   - Capítulo 01: P.04 (Verso, Blanca) $\rightarrow$ **CUMPLE**
   - Capítulo 02: P.10 (Verso, Blanca) $\rightarrow$ **CUMPLE**
   - Capítulo 03: P.38 (Verso, Blanca) $\rightarrow$ **CUMPLE**
5. **`primera interior-page parity = EVEN / VERSO`:**
   - Capítulo 01: P.06 (Verso) $\rightarrow$ **CUMPLE**
   - Capítulo 02: P.12 (Verso) $\rightarrow$ **CUMPLE**
   - Capítulo 03: P.40 (Verso) $\rightarrow$ **CUMPLE**
6. **`blank page graphic elements = 0`:**
   - Todas las páginas blancas (P.01, P.02, P.04, P.08, P.10, P.36, P.38) tienen **0 texto y 0 trazados** $\rightarrow$ **CUMPLE**
7. **`blank page visible folio = false`:**
   - Ninguna página blanca exhibe folio $\rightarrow$ **CUMPLE**
8. **Ausencia de spreads `BLANCA | BLANCA`:**
   - **Cero spreads con doble página blanca.** Toda página blanca queda emparejada frente a contenido real (Opening o First Page) $\rightarrow$ **CUMPLE**

---

## 6. MAPA COMPLETO DE PÁGINAS (54 PÁGINAS)

| PDF | Folio | Paridad | Capítulo | Componente | Primer Contenido | Último Contenido |
|:---:|:---:|:---:|:---:|:---:|:---|:---|
| 01 | — | RECTO | Cap 01 | `ceremonial-blank-page()` | — (PÁGINA EN BLANCO) | — (PÁGINA EN BLANCO) |
| 02 | — | VERSO | Cap 01 | `ceremonial-blank-page()` | — (PÁGINA EN BLANCO) | — (PÁGINA EN BLANCO) |
| 03 | — | RECTO | Cap 01 | `chapter-opening()` | Portada de Capítulo 01 | y la visión que orienta nuestro camino h |
| 04 | — | VERSO | Cap 01 | `ceremonial-blank-page()` | — (PÁGINA EN BLANCO) | — (PÁGINA EN BLANCO) |
| 05 | 05 | RECTO | Cap 01 | `chapter-first-page()` | VISIÓN INTERGENERACIONAL | preservación. |
| 06 | 06 | VERSO | Cap 01 | `interior-page()` | 1.3 Valores Comunes y Principios Rectore | y el orden del sistema. |
| 07 | 07 | RECTO | Cap 01 | `interior-page()` | 1.6 Revisión Generacional del Protocolo | sistema familiar–empresarial. |
| 08 | — | VERSO | Cap 02 | `ceremonial-blank-page()` | — (PÁGINA EN BLANCO) | — (PÁGINA EN BLANCO) |
| 09 | — | RECTO | Cap 02 | `chapter-opening()` | Portada de Capítulo 02 | para preservar la propiedad en la famili |
| 10 | — | VERSO | Cap 02 | `ceremonial-blank-page()` | — (PÁGINA EN BLANCO) | — (PÁGINA EN BLANCO) |
| 11 | 11 | RECTO | Cap 02 | `chapter-first-page()` | LIQUIDEZ PATRIMONIAL | transmisión, gravamen, uso como garantía |
| 12 | 12 | VERSO | Cap 02 | `interior-page()` | corporativos o activación de mecanismos  | objetivos, independientes y vinculantes  |
| 13 | 13 | RECTO | Cap 02 | `interior-page()` | La limitación, suspensión o ausencia de  | de equidad patrimonial y preservación de |
| 14 | 14 | VERSO | Cap 02 | `interior-page()` | 2.2.4 Principio de Separación Funcional  | y descendientes vinculados a cada rama,  |
| 15 | 15 | RECTO | Cap 02 | `interior-page()` | Con el objeto de preservar claridad en l | la familia consanguínea en línea directa |
| 16 | 16 | VERSO | Cap 02 | `interior-page()` | régimen de separación de bienes, o media | transmisión de acciones, derechos corpor |
| 17 | 17 | RECTO | Cap 02 | `interior-page()` | administración o representación de la so | las mayorías requeridas. |
| 18 | 18 | VERSO | Cap 02 | `interior-page()` | Esta habilitación tendrá carácter excepc | del Protocolo; y |
| 19 | 19 | RECTO | Cap 02 | `interior-page()` | c) El reconocimiento formal por parte de | político o de control, sin perjuicio del |
| 20 | 20 | VERSO | Cap 02 | `interior-page()` | 2.4.4 Protección Patrimonial y No Interf | accionista. |
| 21 | 21 | RECTO | Cap 02 | `interior-page()` | 2.5.1 Regla General de Permanencia en Ma | justificarán la incorporación de tercero |
| 22 | 22 | VERSO | Cap 02 | `interior-page()` | 2.5.3 Derecho de Tanto Inter-Familiar | mecanismos que permitan mantener la prop |
| 23 | 23 | RECTO | Cap 02 | `interior-page()` | En caso de no ser posible garantizar dic | cualquier mecanismo equivalente. |
| 24 | 24 | VERSO | Cap 02 | `interior-page()` | Esta prohibición comprende toda forma di | integridad del sistema, sin afectar dere |
| 25 | 25 | RECTO | Cap 02 | `interior-page()` | En caso de embargo, adjudicación o inten | ejercicio, el accionista deberá presenta |
| 26 | 26 | VERSO | Cap 02 | `interior-page()` | manifestando su intención de transmitir  | integridad del modelo de gobernanza. Su  |
| 27 | 27 | RECTO | Cap 02 | `interior-page()` | verificables, tales como el incumplimien | que ello implique la transmisión automát |
| 28 | 28 | VERSO | Cap 02 | `interior-page()` | corporativos. En consecuencia, la sucesi | Protocolo, sin que ello implique afectac |
| 29 | 29 | RECTO | Cap 02 | `interior-page()` | 2.8.4 Remisión al Régimen Específico de  | Before Interest, Taxes, Depreciation and |
| 30 | 30 | VERSO | Cap 02 | `interior-page()` | Dicha valuación será obligatoria en todo | incluyendo, en su caso: |
| 31 | 31 | RECTO | Cap 02 | `interior-page()` | %2. La deducción de la deuda financiera  | renegociación por mera inconformidad con |
| 32 | 32 | VERSO | Cap 02 | `interior-page()` | 2.9.3 Carácter Vinculante del Resultado | circunstancias coyunturales. |
| 33 | 33 | RECTO | Cap 02 | `interior-page()` | 2.10.1 Principio de Control Mayoritario  | comprometer el control familiar efectivo |
| 34 | 34 | VERSO | Cap 02 | `interior-page()` | Estas materias no podrán aprobarse media | prohibido su ejercicio abusivo o con fin |
| 35 | 35 | RECTO | Cap 02 | `interior-page()` | 2.10.5 Designación y Control de Órganos  | conforme a los mecanismos previstos. |
| 36 | — | VERSO | Cap 03 | `ceremonial-blank-page()` | — (PÁGINA EN BLANCO) | — (PÁGINA EN BLANCO) |
| 37 | — | RECTO | Cap 03 | `chapter-opening()` | Portada de Capítulo 03 | Órganos de gobierno, roles familiares, i |
| 38 | — | VERSO | Cap 03 | `ceremonial-blank-page()` | — (PÁGINA EN BLANCO) | — (PÁGINA EN BLANCO) |
| 39 | 39 | RECTO | Cap 03 | `chapter-first-page()` | INSTITUCIONALIZACIÓN Y | organización y preservando la estabilida |
| 40 | 40 | VERSO | Cap 03 | `interior-page()` | 3.1.1 Principio de Institucionalización  | del presente Protocolo, ni directa ni in |
| 41 | 41 | RECTO | Cap 03 | `interior-page()` | La jerarquía normativa y la delimitación | sea jurídicamente admisible su utilizaci |
| 42 | 42 | VERSO | Cap 03 | `interior-page()` | instrucción operativa. Cualquier conduct | sistema. |
| 43 | 43 | RECTO | Cap 03 | `interior-page()` | 3.2.4 Prohibición de Intervención Cruzad | en el presente Protocolo, los cuales con |
| 44 | 44 | VERSO | Cap 03 | `interior-page()` | para la deliberación, adopción y conducc | excluido cualquier ejercicio informal, p |
| 45 | 45 | RECTO | Cap 03 | `interior-page()` | manifestación de voluntad emitida fuera  | servirán como base para la activación de |
| 46 | 46 | VERSO | Cap 03 | `interior-page()` | ello implique por sí mismo la imposición | familiar conforme a lo previsto en este  |
| 47 | 47 | RECTO | Cap 03 | `interior-page()` | 3.4 Régimen de Profesionalización | decisiones estratégicas. Este principio  |
| 48 | 48 | VERSO | Cap 03 | `interior-page()` | independiente para el acceso, permanenci | cumplimiento íntegro de los estándares p |
| 49 | 49 | RECTO | Cap 03 | `interior-page()` | de interés estructurales y la acreditaci | de las responsabilidades que pudieran de |
| 50 | 50 | VERSO | Cap 03 | `interior-page()` | 3.5 Régimen de Función Ejecutiva en la E | influencia al margen de la estructura ej |
| 51 | 51 | RECTO | Cap 03 | `interior-page()` | 3.5.2 Régimen Aplicable a Directivos Fam | derivarse conforme a los instrumentos ap |
| 52 | 52 | VERSO | Cap 03 | `interior-page()` | 3.6 Régimen de Tipificación de Infraccio | jerarquía familiar o la trayectoria hist |
| 53 | 53 | RECTO | Cap 03 | `interior-page()` | utilización de la titularidad accionaria | integrantes del sistema familiar–empresa |
| 54 | 54 | VERSO | Cap 03 | `interior-page()` | Protocolo, constituyendo el parámetro ob | conductas y la preservación del orden in |

---

## 7. AUDITORÍA DE REGRESIÓN Y SEGURIDAD CANÓNICA

### Verificación Criptográfica de Archivos Canónicos (`/capitulos/*.md`)
Todos los archivos canónicos permanecen estrictamente **READ ONLY** e intactos byte por byte:

| Archivo | SHA256 Hash | Estado |
|:---|:---:|:---:|
| `00_introduccion.md` | `DEEECA7863249DB1348BEF6138E0DAEDA35B5120658459D0362309E543FECAD8` | INTACTO |
| `00_portada_e_indice.md` | `A030EC14A57B0C86DEA4B17FDD057C4FFABC53948F94BB91D37C79E2BD20CD54` | INTACTO |
| `01_capitulo1_declaracion_principios.md` | `B18B22334759386A547DC94103F6A63EC5AD72BFC9BAA10E4453D9143E58246E` | INTACTO |
| `02_capitulo2_propiedad_control_liquidez.md` | `5D3AA506523703D1D5588E74ADDABB3EB4F11B1A660653AD50F09B787EA46886` | INTACTO |
| `03_capitulo3_gobierno_profesionalizacion.md` | `536C8D9879441CDE924C78C36F4B4879A9F69069540FAA699E002367A0B8CC53` | INTACTO |
| `04_capitulo4_sucesion_familiar.md` | `4CCBE4D2E25B5FC8E50EA11BE6206DA044E532CACA7FB70BEDA6345BD693619A` | INTACTO |
| `05_capitulo5_control_informacion_comunicacion.md` | `B8A731FCB4939E95861F2608D86A20137E67EC462FF4D40B06C567719F336342` | INTACTO |
| `06_capitulo6_disciplina_financiera.md` | `3D6157E2201487A43B8262CF22E4E07F60BD680E827759F7BC3D02F47F383D73` | INTACTO |
| `07_capitulo7_procedimiento_sancionador.md` | `DE32E740807452DBBB5E2676386EB491A268071859E8CF00110A578127A30CAF` | INTACTO |
| `08_capitulo8_solucion_conflictos.md` | `E041394A51C1DCE44389BAC05A4A3D393CD48F3D825AEF17E0495402271669EF` | INTACTO |
| `09_capitulo9_regimen_juridico.md` | `C3A7B5E4DC6D45CA9980A687E1DB7DCDF1286228DAFAAE6D09180FE23A4F1245` | INTACTO |
| `10_anexos_formatos_operativos.md` | `588A64539A62B89BA25D31E54E504FB7A5EDF9698AC085B6250CC3F91B774826` | INTACTO |
| `11_reglamento_asamblea_familia.md` | `52034B382BA0F3137016F1F8BE8F20AB2C76D134E9DEEC1160BE55ABFAD724D3` | INTACTO |
| `12_reglamento_consejo_familia.md` | `FDE5F0D62F99B198D4C238E36225AE62770C4C9255371715B0292DA12CB0EA18` | INTACTO |
| `13_reglamento_comite_honor_familiar.md` | `8662411CBAA2AAD718F4F48D0CE6083250D6935349530843966DC2A00140C23B` | INTACTO |

### Verificación de Componentes Bloqueados
- `templates/typst/componentes.typ`: Hash `8433F851EA3E0EA9EDC09759DF25E37F6D95EBF20E0FDBAC072A2E9445E38442` (intacto).
- `cover-page()`, `table-of-contents()`, `chapter-opening()` no sufrieron ninguna alteración geométrica ni de diseño.

---

## 8. GALERÍA VISUAL Y REGISTRO DE ARTEFACTOS

````carousel
![Aperturas Ceremoniales: Cap 01 Portada](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_01_cap01_opening.png)
<!-- slide -->
![Aperturas Ceremoniales: Cap 01 Primera Página](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_02_cap01_first_page.png)
<!-- slide -->
![Aperturas Ceremoniales: Cap 02 Portada](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_03_cap02_opening.png)
<!-- slide -->
![Aperturas Ceremoniales: Cap 02 Primera Página](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_04_cap02_first_page.png)
<!-- slide -->
![Aperturas Ceremoniales: Cap 03 Portada](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_05_cap03_opening.png)
<!-- slide -->
![Aperturas Ceremoniales: Cap 03 Primera Página](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_06_cap03_first_page.png)
<!-- slide -->
![Panel Comparativo Respiración: +4 mm, +6 mm, +8 mm](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/top_margin_comparison_panel.png)
````

### Enlaces a Imágenes de Diagnóstico (150 DPI)
- Spread Ceremonial 01 (Cap 01 Portada): [`ceremonial_spread_01_cap01_opening.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_01_cap01_opening.png)
- Spread Ceremonial 02 (Cap 01 Primera Página): [`ceremonial_spread_02_cap01_first_page.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_02_cap01_first_page.png)
- Spread Ceremonial 03 (Cap 02 Portada): [`ceremonial_spread_03_cap02_opening.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_03_cap02_opening.png)
- Spread Ceremonial 04 (Cap 02 Primera Página): [`ceremonial_spread_04_cap02_first_page.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_04_cap02_first_page.png)
- Spread Ceremonial 05 (Cap 03 Portada): [`ceremonial_spread_05_cap03_opening.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_05_cap03_opening.png)
- Spread Ceremonial 06 (Cap 03 Primera Página): [`ceremonial_spread_06_cap03_first_page.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/ceremonial_spread_06_cap03_first_page.png)
- Panel Comparativo Triple (1188 × 612 pt): [`top_margin_comparison_panel.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/top_margin_comparison_panel.png)
- Variante A (+4 mm): [`top_margin_4mm.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/top_margin_4mm.png)
- Variante B (+6 mm): [`top_margin_6mm.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/top_margin_6mm.png)
- Variante C (+8 mm): [`top_margin_8mm.png`](file:///C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2/top_margin_8mm.png)

---

## 9. ESTADO FINAL DE GOBERNANZA

- `cover-page()`: **APPROVED / LOCKED**
- `table-of-contents()`: **APPROVED / LOCKED**
- `chapter-opening()`: **APPROVED / LOCKED**
- `chapter-first-page()`: **PENDING STRESS TEST REVIEW**
- `interior-page()`: **PENDING STRESS TEST REVIEW**

> [!IMPORTANT]
> El sistema se detiene en este punto. No se ha seleccionado automáticamente ninguna de las opciones de margen superior (+4, +6 u +8 mm), no se han compilado los Capítulos 04 a 09 ni anexos, y no se ha modificado el contenido canónico. El proyecto queda a la espera de la decisión visual del usuario sobre el margen superior y la aprobación de la doble apertura ceremonial.
