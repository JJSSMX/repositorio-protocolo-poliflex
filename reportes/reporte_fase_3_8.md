# REPORTE FORENSE DE CALIBRACIÓN EDITORIAL — FASE 3.8
## Saneamiento del Parser, Supresión de Comillas Espurias y Validación de Jerarquía
**Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)**  
**Documento de Prueba:** `dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8.pdf` (56 páginas, 940.8 KB)  
**Fecha de Auditoría:** 2026-09-26  
**Compilador Maestro:** `scripts/compilar_fase_3_8.py`  

---

## 1. Resumen Ejecutivo

La **Fase 3.8** tuvo como objetivo primordial el **saneamiento estructural y editorial del motor de composición**, resolviendo anomalías tipográficas y de parsing detectadas durante las pruebas de estrés previas, **sin alterar en lo absoluto la geometría vertical, márgenes, interlineado (+6 mm consolidado en Fase 3.7.3) ni el contenido canónico de los archivos `/capitulos/*.md`**.

### Logros Principales:
1. **Resolución Estructural del Artefacto `%2.`:** Se identificó la causa raíz en la exportación OpenXML/Word (`w:lvlText="%2."`, formato `lowerRoman`). Se implementó un algoritmo dinámico en el parser que convierte secuencias jerárquicas subordinadas en numerales romanos minúsculos (`i.`, `ii.`, `iii.`), asignándoles el componente `#legal-roman` con sangría de bloque exacta de 40 pt. En el PDF final, **cero ocurrencias de `%2.` subsisten**, y la página 32 muestra una lista romana inmaculada.
2. **Erradicación de Comillas Espurias en Portadas:** Se diagnosticó la causa de las comillas simples curvas (`‘ ’`) en `chapter-opening()` (serialización como array de Python interpretado por Typst como bloque de contenido). Al transicionar a una tupla/array nativa de strings Typst `("...", "...")`, el componente evalúa el array con `join(" \ ")` como texto plano, **eliminando el 100% de las comillas en los capítulos 01, 02 y 03**.
3. **Auditoría Exhaustiva de Headings (90/90):** Se verificó la totalidad de los 90 headings en los tres capítulos. Se confirmó que la numeración generada por Typst coincide con exactitud matemática con los títulos canónicos, manejando correctamente números de 2 dígitos (`2.10`, `2.10.1` a `2.10.5`) y niveles cuaternarios H4 (`2.3.3.1`, `2.3.4.1`, `2.3.4.2`).
4. **Cero Orfandad y Cumplimiento Estricto de Keep-with-Next:** Todos los headings (H2, H3, H4) están protegidos con `block(sticky: true, breakable: false)`. La auditoría automatizada demostró que **ningún heading queda solo al pie de página sin al menos dos líneas de texto posterior** (0 orfandades detectadas).
5. **Preservación Rigurosa de la Arquitectura Ceremonial y Paridad:** El documento conserva sus **56 páginas exactas**, respetando las aperturas ceremoniales de doble pliego, la página de cortesía inicial en P.1 y las transiciones pares/impares consolidadas en la Fase 3.7.3.

---

## 2. Estado de Gobernanza de Componentes

| Componente | Estado de Gobernanza | Observaciones |
|---|:---:|---|
| `cover-page()` | **APPROVED / LOCKED** | Portada general del protocolo familiar. No modificada. |
| `table-of-contents()` | **APPROVED / LOCKED** | Sumario / Índice general. No modificado. |
| `chapter-opening()` | **APPROVED / LOCKED** | Portada ceremonial de capítulo (fondo crema, retícula, logo). Código de plantilla intacto; corregida la llamada en el compilador. |
| `chapter-first-page()` | **PENDING FINAL LOCK** | Primera página con claim + arcos concéntricos + número display. Retícula +6 mm consolidada. A la espera de aprobación final. |
| `interior-page()` | **PENDING FINAL LOCK** | Páginas interiores de texto con running header y lomo dinámico. Retícula +6 mm consolidada. A la espera de aprobación final. |

> **Nota de Seguridad:** El archivo maestro de plantillas `templates/typst/componentes.typ` no sufrió alteración alguna (SHA-256 verificado: `8433F851EA3E0EA9EDC09759DF25E37F6D95EBF20E0FDBAC072A2E9445E38442`).

---

## 3. Diagnóstico y Resolución del Artefacto %2.

### Diagnóstico Forense de Causa Raíz
En el archivo canónico `capitulos/02_capitulo2_propiedad_control_liquidez.md` (líneas 438–440), aparecían las siguientes tres líneas subordinadas al inciso d):
```markdown
  %2. La deducción de la deuda financiera neta;
  %2. La adición de efectivo no operativo; y
  %2. Cualquier otra partida relevante que impacte materialmente el valor económico de la Sociedad.
```

Al examinar el archivo original `PROTOCOLO FAMILIAR - POLIFLEX V2.docx` (`word/numbering.xml`), se identificó la definición:
```xml
<w:abstractNum w:abstractNumId="27">
  <w:lvl w:ilvl="1">
    <w:numFmt w:val="lowerRoman"/>
    <w:lvlText w:val="%2."/>
  </w:lvl>
</w:abstractNum>
```
El extractor inicial Word $\rightarrow$ Markdown volcó literalmente la máscara de formato `%2.` en lugar de evaluar el contador subordinado (`i.`, `ii.`, `iii.`). Por su parte, el compilador anterior sólo reconocía `^[a-z]\)` e `^[ivxlcdm]+\.`, provocando que `%2.` fuera emitido como un párrafo común sin sangría subordinada.

### Solución Estructural Implementada
En `scripts/compilar_fase_3_8.py`, se implementó un evaluador de listas OpenXML general:
```python
elif re.match(r"^%(\d+)\.\s+(.*)", line):
    m = re.match(r"^%(\d+)\.\s+(.*)", line)
    lvl = int(m.group(1))
    sublist_roman_counter += 1
    roman_marker = f"{to_roman(sublist_roman_counter)}."
    content = clean_inline_text(m.group(2))
    typ.append(f'#legal-roman("{roman_marker}", [{content}])')
```
El contador de nivel se reinicia automáticamente al salir de la secuencia subordinada. No existe ningún `replace("%2.", "i.")` hardcodeado.

### Verificación en el PDF Final (Página 32)
El barrido automatizado del PDF confirmó **0 ocurrencias de `%2.` en todo el documento**. En la página 32, el texto se renderiza exactamente como:
- `i. La deducción de la deuda financiera neta;`
- `ii. La adición de efectivo no operativo; y`
- `iii. Cualquier otra partida relevante que impacte materialmente el valor económico de la Sociedad.`
Con sangría izquierda de **40 pt**, perfectamente subordinada bajo el inciso d).

---

## 4. Diagnóstico y Resolución de Comillas en Portadas

### Diagnóstico de Causa Raíz
En las portadas `chapter-opening()`, los títulos aparecían con comillas tipográficas simples curvadas: `‘DECLARACIÓN DE’`, etc.  
El rastreo determinó que `compilar_fase_3_7_3.py` generaba el código Typst con la función `str(ch_opening)`, produciendo:
`opening_title: ['DECLARACIÓN DE', 'PRINCIPIOS FAMILIARES Y', 'VISIÓN INTERGENERACIONAL']`  
En Typst:
- La sintaxis `[...]` define un bloque de contenido (`content`), no un array.
- Al recibir `content`, `componentes.typ` no ejecutaba la rama `type(raw_title) == array`.
- El motor de texto de Typst interpretaba las comillas simples de Python (`'`) como comillas ortográficas inglesas, convirtiéndolas automáticamente en comillas curvadas simples (`‘` y `’`).

### Solución Estructural
Se serializó el parámetro como una **tupla/array nativa de strings Typst**:
`opening_title: ("DECLARACIÓN DE", "PRINCIPIOS FAMILIARES Y", "VISIÓN INTERGENERACIONAL")`  
Al recibir un tipo `array` de strings:
1. `componentes.typ` toma la rama `raw_title.join(" \\ ")`.
2. Evalúa las líneas concatenadas sin comillas perimetrales ni signos espurios.

### Auditoría en el PDF Final
Se verificó el texto extraído de las páginas 3, 9 y 39:
- **Página 3 (Capítulo 01):** 0 comillas encontradas (`[]`).
- **Página 9 (Capítulo 02):** 0 comillas encontradas (`[]`).
- **Página 39 (Capítulo 03):** 0 comillas encontradas (`[]`).

---

## 5. Inventario Forense de Normalización de Caracteres

Se realizó un escrutinio exhaustivo a nivel de punto de código Unicode en los tres archivos canónicos:

| Categoría | Carácter | Código Unicode | Frecuencia | Tratamiento Editorial |
|---|:---:|:---:|:---:|---|
| Guión común | `-` | `U+002D` | 33 | Utilizado en términos compuestos y sintaxis markdown. Preservado fielmente. |
| En-dash | `–` | `U+2013` | 24 | Utilizado en rangos numéricos y términos jurídicos (`familiar–empresarial`). Renderizado nítido. |
| Em-dash | `—` | `U+2014` | 4 | Guión largo de inciso o separación enfática. Preservado. |
| Comilla recta doble | `"` | `U+0022` | 70 | Preservada en el cuerpo sin alteración. |
| Comilla recta simple | `'` | `U+0027` | 6 | Preservada fielmente. |
| Comilla tipográfica abre | `“` | `U+201C` | 1 | Presente en Cap 02:98 (`“familia empresaria”`). Renderizado correcto. |
| Comilla tipográfica cierra | `”` | `U+002D` | 1 | Presente en Cap 02:98. Renderizado correcto. |
| Comilla tipográfica simple | `‘` / `’` | `U+2018/9` | 0 | Ausente en fuentes canónicas. Erradicadas del PDF. |
| Espacio duro | `\u00a0` | `U+00A0` | 0 | Ninguno detectado. |
| Soft hyphen | `\u00ad` | `U+00AD` | 0 | Ninguno detectado. |
| Zero-width space | `\u200b` | `U+200B` | 0 | Ninguno detectado. |
| Signo de porcentaje | `%` | `U+0025` | 6 | 3 porcentajes legítimos (`51%`) + 3 artefactos `%2.` saneados a `i.`, `ii.`, `iii.`. |

---

## 6. Auditoría Exhaustiva de Headings y Jerarquía Editorial

Se auditaron los 90 headings presentes en el corpus de los capítulos 01, 02 y 03. No se detectó ninguna omisión, duplicación ni salto numérico.

### Estilos Tipográficos por Nivel:
- **H1:** Reservado a Títulos de Capítulo (Procesados por `chapter-opening()` y `chapter-first-page()`).
- **H2 (Secciones):** Minion Pro Medium Display 10 pt, tracking +0.019em, número en naranja `#f15d22` con trazo perimetral de 0.4 pt, `above: 18.35pt`, `below: 15.42pt`.
- **H3 (Subsecciones):** Minion Pro Medium Display 9.5 pt, tracking +0.019em, número en naranja `#f15d22` con trazo de 0.3 pt, `above: 14.00pt`, `below: 10.00pt`.
- **H4 (Sub-subsecciones):** Minion Pro Medium Display 9 pt, tracking +0.019em, número en naranja `#f15d22` con trazo de 0.2 pt, `above: 10.00pt`, `below: 8.00pt`.

### Catálogo Completo de Headings Verificados en PDF (90):

| Pág. | Nivel | Numeración | Título Canónico |
|:---:|:---:|:---:|---|
| 05 | H2 | **1.1** | Misión y Propósito Familiar Empresarial |
| 05 | H2 | **1.2** | Visión Intergeneracional y Proyecto de Largo Plazo |
| 06 | H2 | **1.3** | Valores Comunes y Principios Rectores |
| 06 | H2 | **1.4** | Unidad Familiar como Activo Estratégico |
| 06 | H2 | **1.5** | Legitimidad del Protocolo y Adhesión Voluntaria |
| 07 | H2 | **1.6** | Revisión Generacional del Protocolo |
| 07 | H2 | **1.7** | Naturaleza Jurídica y Coordinación Normativa |
| 07 | H2 | **1.8** | Criterio de Interpretación del Protocolo |
| 11 | H2 | **2.1** | Naturaleza del Patrimonio Accionario Familiar |
| 11 | H3 | **2.1.1** | Reconocimiento del Carácter Institucional de las Acciones |
| 11 | H3 | **2.1.2** | Alcance de las Restricciones sobre la Titularidad Accionaria |
| 12 | H3 | **2.1.3** | Prevalencia del Interés Patrimonial Común |
| 12 | H2 | **2.2** | Distinción Estructural de Derechos sobre las Acciones |
| 12 | H3 | **2.2.1** | Derechos Económicos |
| 13 | H3 | **2.2.2** | Derechos Corporativos y de Control |
| 13 | H3 | **2.2.3** | Derecho de Liquidez o Salida |
| 14 | H3 | **2.2.4** | Principio de Separación Funcional de Derechos |
| 14 | H2 | **2.3** | Definición Normativa de la Familia Empresaria |
| 15 | H3 | **2.3.1** | Familia Consanguínea en Línea Directa |
| 15 | H3 | **2.3.2** | Accionistas Familiares |
| 15 | H3 | **2.3.3** | Familia Política |
| 16 | H4 | **2.3.3.1** | Régimen de Incorporación de la Familia Política |
| 17 | H3 | **2.3.4** | Descendencia No Tradicional |
| 18 | H4 | **2.3.4.1** | Reconocimiento de Derechos Económicos |
| 18 | H4 | **2.3.4.2** | Régimen de Derechos Corporativos |
| 18 | H3 | **2.3.5** | Principio de Diferenciación Funcional |
| 18 | H2 | **2.4** | Ramas Familiares Activas y Pasivas |
| 19 | H3 | **2.4.1** | Ramas Familiares Activas |
| 19 | H3 | **2.4.2** | Ramas Familiares Pasivas |
| 20 | H3 | **2.4.3** | Diferenciación en el Ejercicio de Derechos |
| 20 | H3 | **2.4.4** | Protección Patrimonial y No Interferencia |
| 20 | H3 | **2.4.5** | Transición entre Ramas Activas y Pasivas |
| 21 | H2 | **2.5** | Permanencia Familiar y Restricciones a la Transmisión |
| 21 | H3 | **2.5.1** | Regla General de Permanencia en Manos Familiares |
| 22 | H3 | **2.5.2** | Restricción a la Transmisión a Terceros |
| 22 | H3 | **2.5.3** | Derecho de Tanto Inter-Familiar |
| 23 | H3 | **2.5.4** | Derecho de Preferencia en Nuevas Emisiones |
| 23 | H3 | **2.5.5** | Supremacía del Control Familiar sobre la Liquidez Individual |
| 24 | H2 | **2.6** | Prohibición de Gravámenes, Garantías y Uso Instrumental de las Acciones |
| 24 | H3 | **2.6.1** | Prohibición de Gravámenes y Garantías |
| 25 | H3 | **2.6.2** | Ineficacia de Actos Contrarios |
| 25 | H3 | **2.6.3** | Protección frente a Acreedores Personales |
| 26 | H3 | **2.6.4** | Vinculación con el Régimen de Operaciones entre Familiares |
| 26 | H2 | **2.7** | Liquidez Patrimonial y Mecanismos de Salida |
| 26 | H3 | **2.7.1** | Salida Voluntaria |
| 27 | H3 | **2.7.2** | Salida Forzada |
| 28 | H2 | **2.8** | Principios Rectores de la Sucesión Accionaria |
| 29 | H3 | **2.8.1** | Transmisión del Valor Patrimonial por Sucesión |
| 29 | H3 | **2.8.2** | No Transmisión Automática de Derechos Corporativos |
| 29 | H3 | **2.8.3** | Derecho de Asociación y Control de Integración |
| 30 | H3 | **2.8.4** | Remisión al Régimen Específico de Ejecución |
| 30 | H2 | **2.9** | Valuación del Capital Accionario |
| 30 | H3 | **2.9.1** | Supuestos de Activación Obligatoria |
| 30 | H3 | **2.9.2** | Metodología de Cálculo |
| 33 | H3 | **2.9.3** | Carácter Vinculante del Resultado |
| 33 | H3 | **2.9.4** | Canalización de Controversias |
| 33 | H2 | **2.10** | Control Familiar Efectivo |
| 34 | H3 | **2.10.1** | Principio de Control Mayoritario Familiar |
| 34 | H3 | **2.10.2** | Materias Reservadas |
| 35 | H3 | **2.10.3** | Régimen de Mayorías Reforzadas |
| 35 | H3 | **2.10.4** | Derecho de Veto Familiar |
| 36 | H3 | **2.10.5** | Designación y Control de Órganos Sociales |
| 41 | H2 | **3.1** | Principio de Institucionalización y Jerarquía Normativa Interna |
| 42 | H3 | **3.1.1** | Principio de Institucionalización del Sistema Familiar–Empresarial |
| 42 | H3 | **3.1.2** | Jerarquía Normativa Interna y Regla de Especialidad |
| 43 | H2 | **3.2** | Régimen de Separación Funcional entre Propiedad, Gobierno y Operación |
| 43 | H3 | **3.2.1** | Propiedad Accionaria como Esfera Patrimonial sin Atribuciones de Gobierno |
| 44 | H3 | **3.2.2** | Gobierno Corporativo Familiar como Esfera de Decisión Estratégica y Control |
| 44 | H3 | **3.2.3** | Operación Empresarial como Esfera Ejecutiva Autónoma |
| 45 | H3 | **3.2.4** | Prohibición de Intervención Cruzada y Supuestos Excepcionales |
| 45 | H3 | **3.2.5** | Coordinación y Límites de los Órganos Societarios |
| 46 | H2 | **3.3** | Órganos de Gobierno Corporativo Familiar |
| 46 | H3 | **3.3.1** | Asamblea de Familia |
| 47 | H3 | **3.3.2** | Consejo de Familia |
| 48 | H3 | **3.3.3** | Comité de Honor Familiar |
| 48 | H3 | **3.3.4** | Principio de Vocería Única Familiar |
| 49 | H2 | **3.4** | Régimen de Profesionalización |
| 50 | H3 | **3.4.1** | Profesionalización como Condición de Acceso al Poder Familiar |
| 50 | H3 | **3.4.2** | Régimen de Elegibilidad para Órganos de Gobierno Corporativo Familiar |
| 51 | H3 | **3.4.3** | Elegibilidad para el Desempeño de Funciones Ejecutivas por Familiares |
| 52 | H3 | **3.4.4** | Incompatibilidades y Nulidad de Designaciones Contrarias al Protocolo |
| 52 | H2 | **3.5** | Régimen de Función Ejecutiva en la Empresa Familiar |
| 53 | H3 | **3.5.1** | Naturaleza y Límites de la Función Ejecutiva |
| 53 | H3 | **3.5.2** | Régimen Aplicable a Directivos Familiares |
| 54 | H3 | **3.5.3** | Neutralidad, Lealtad Institucional y Rendición de Cuentas |
| 54 | H2 | **3.6** | Régimen de Tipificación de Infracciones al Gobierno Corporativo Familiar |
| 54 | H3 | **3.6.1** | Invasión Competencial y Actuación Extrainstitucional |
| 55 | H3 | **3.6.2** | Abuso de Posición Familiar, Patrimonial o Institucional |
| 55 | H3 | **3.6.3** | Desconocimiento de la Institucionalidad Decisoria y de la Vocería Única |
| 56 | H3 | **3.6.4** | Calificación de la Infracción y Activación del Régimen de Consecuencias |

---

## 7. Auditoría de Listas Jurídicas y Subordinación

El sistema cuenta con dos niveles estandarizados de listas jurídicas con control de sangría y prevención de orfandad:
1. **Primer Nivel (`#legal-alpha`):**
   - Sangría izquierda de bloque: `inset: (left: 20pt)`
   - Separación inferior: `below: 12.73pt` (1 línea de interlineado exacto)
   - Marcador: Letra minúscula seguida de paréntesis de cierre: `a)`, `b)`, `c)`...
   - Anclaje: El marcador se encuentra dentro de un `#box` en línea, garantizando que el texto de la primera línea no pueda desligarse del identificador.
2. **Segundo Nivel (`#legal-roman`):**
   - Sangría izquierda de bloque: `inset: (left: 40pt)`
   - Separación inferior: `below: 12.73pt`
   - Marcador: Numeral romano en minúsculas seguido de punto: `i.`, `ii.`, `iii.`...
   - Comportamiento validado en página 32 con 100% de alineación estructural y sin salto de página entre marcador e ítem.

---

## 8. Control de Orfandad, Viudas y Keep-with-Next

Se ejecutaron scripts de inspección vectorial y tipográfica para evaluar el comportamiento de los saltos de página:
- **Headings (`sticky: true`):** El motor Typst garantiza que ningún encabezado quede como última línea de la caja tipográfica. Si el espacio remanente en la página no permite alojar el encabezado y al menos las 2 primeras líneas del cuerpo posterior, el bloque completo se traslada al inicio de la página siguiente.
  - **Resultado de la auditoría:** **0 encabezados huérfanos** en las 56 páginas.
- **Marcadores de listas:** Al estar encapsulados en el mismo bloque jerárquico (`block(breakable: true)` con caja fija de partida), nunca quedan flotando solos al fondo de página.
- **Líneas viudas al inicio de página:** La auditoría sobre las primeras líneas de cada página interior confirmó que **0 páginas inician con líneas viudas de 1 sola palabra**.

---

## 9. Auditoría de Paridad Recto/Verso y Arquitectura Ceremonial

Se ratificó la regla editorial de doble apertura ceremonial establecida en la Fase 3.7.1:

```mermaid
graph LR
  A["Blanca Verso"] --> B["Chapter Opening Recto"]
  B --> C["Blanca Verso"]
  C --> D["Chapter First Page Recto"]
  D --> E["Páginas Interiores"]
```

### Puntos Críticos de Paridad Auditados:
1. **Página 1 (Recto):** Cortesía protocolaria inicial en blanco.
2. **Capítulo 01:**
   - P.02 Verso (Blanca) enfrentada a P.03 Recto (`chapter-opening()`).
   - P.04 Verso (Blanca) enfrentada a P.05 Recto (`chapter-first-page()`).
   - Concluye en P.07 (Recto).
3. **Capítulo 02:**
   - P.08 Verso (Blanca de balance) enfrentada a P.09 Recto (`chapter-opening()`).
   - P.10 Verso (Blanca) enfrentada a P.11 Recto (`chapter-first-page()`).
   - Concluye en P.36 (Verso).
4. **Capítulo 03:**
   - Al terminar Cap 02 en Verso (P.36), se insertan dos blancas: P.37 Recto + P.38 Verso.
   - P.38 Verso enfrentada a P.39 Recto (`chapter-opening()`).
   - P.40 Verso (Blanca) enfrentada a P.41 Recto (`chapter-first-page()`).
   - Concluye en P.56 (Verso).

---

## 10. Tabla de Asignación Física Página por Página (1 a 56)

| Pág. | Lado | Tipo de Componente | Contenido Editorial / Identificador |
|:---:|:---:|:---:|---|
| 01 | Recto | `Cortesía Inicial` | Página blanca protocolaria |
| 02 | Verso | `Blanca Ceremonial` | Guarda / Transición ceremonial de apertura |
| 03 | Recto | `Chapter Opening` | Portada Cap 01 · Declaración de Principios (Sin comillas) |
| 04 | Verso | `Blanca Ceremonial` | Guarda / Transición ceremonial de apertura |
| 05 | Recto | `Chapter First Page` | Inicio Cap 01 · Claim + Arcos 50% + Display 01 + Headings 1.1–1.2 |
| 06 | Verso | `Interior Page` | Cap 01 · Headings: 1.3, 1.4, 1.5 |
| 07 | Recto | `Interior Page` | Cap 01 · Headings: 1.6, 1.7, 1.8 |
| 08 | Verso | `Blanca Ceremonial` | Guarda / Transición ceremonial de apertura |
| 09 | Recto | `Chapter Opening` | Portada Cap 02 · Propiedad Accionaria (Sin comillas) |
| 10 | Verso | `Blanca Ceremonial` | Guarda / Transición ceremonial de apertura |
| 11 | Recto | `Chapter First Page` | Inicio Cap 02 · Claim + Arcos 50% + Display 02 + Headings 2.1–2.1.2 |
| 12 | Verso | `Interior Page` | Cap 02 · Headings: 2.1.3, 2.2, 2.2.1 |
| 13 | Recto | `Interior Page` | Cap 02 · Headings: 2.2.2, 2.2.3 |
| 14 | Verso | `Interior Page` | Cap 02 · Headings: 2.2.4, 2.3 |
| 15 | Recto | `Interior Page` | Cap 02 · Headings: 2.3.1, 2.3.2, 2.3.3 |
| 16 | Verso | `Interior Page` | Cap 02 · Headings: 2.3.3.1 |
| 17 | Recto | `Interior Page` | Cap 02 · Headings: 2.3.4 |
| 18 | Verso | `Interior Page` | Cap 02 · Headings: 2.3.4.1, 2.3.4.2, 2.3.5, 2.4 |
| 19 | Recto | `Interior Page` | Cap 02 · Headings: 2.4.1, 2.4.2 |
| 20 | Verso | `Interior Page` | Cap 02 · Headings: 2.4.3, 2.4.4, 2.4.5 |
| 21 | Recto | `Interior Page` | Cap 02 · Headings: 2.5, 2.5.1 |
| 22 | Verso | `Interior Page` | Cap 02 · Headings: 2.5.2, 2.5.3 |
| 23 | Recto | `Interior Page` | Cap 02 · Headings: 2.5.4, 2.5.5 |
| 24 | Verso | `Interior Page` | Cap 02 · Headings: 2.6, 2.6.1 |
| 25 | Recto | `Interior Page` | Cap 02 · Headings: 2.6.2, 2.6.3 |
| 26 | Verso | `Interior Page` | Cap 02 · Headings: 2.6.4, 2.7, 2.7.1 |
| 27 | Recto | `Interior Page` | Cap 02 · Headings: 2.7.2 |
| 28 | Verso | `Interior Page` | Cap 02 · Headings: 2.8 |
| 29 | Recto | `Interior Page` | Cap 02 · Headings: 2.8.1, 2.8.2, 2.8.3 |
| 30 | Verso | `Interior Page` | Cap 02 · Headings: 2.8.4, 2.9, 2.9.1, 2.9.2 |
| 31 | Recto | `Interior Page` | Cap 02 · Continuación de texto normativo |
| 32 | Verso | `Interior Page` | Cap 02 · Inciso d) con lista romana saneada (i., ii., iii.) + e)–g) |
| 33 | Recto | `Interior Page` | Cap 02 · Headings: 2.9.3, 2.9.4, 2.10 |
| 34 | Verso | `Interior Page` | Cap 02 · Headings: 2.10.1, 2.10.2 |
| 35 | Recto | `Interior Page` | Cap 02 · Headings: 2.10.3, 2.10.4 |
| 36 | Verso | `Interior Page` | Cap 02 · Headings: 2.10.5 |
| 37 | Recto | `Blanca Ceremonial` | Guarda / Transición ceremonial de apertura |
| 38 | Verso | `Blanca Ceremonial` | Guarda / Transición ceremonial de apertura |
| 39 | Recto | `Chapter Opening` | Portada Cap 03 · Gobierno Corporativo (Sin comillas) |
| 40 | Verso | `Blanca Ceremonial` | Guarda / Transición ceremonial de apertura |
| 41 | Recto | `Chapter First Page` | Inicio Cap 03 · Claim + Arcos 50% + Display 03 + Heading 3.1 |
| 42 | Verso | `Interior Page` | Cap 03 · Headings: 3.1.1, 3.1.2 |
| 43 | Recto | `Interior Page` | Cap 03 · Headings: 3.2, 3.2.1 |
| 44 | Verso | `Interior Page` | Cap 03 · Headings: 3.2.2, 3.2.3 |
| 45 | Recto | `Interior Page` | Cap 03 · Headings: 3.2.4, 3.2.5 |
| 46 | Verso | `Interior Page` | Cap 03 · Headings: 3.3, 3.3.1 |
| 47 | Recto | `Interior Page` | Cap 03 · Headings: 3.3.2 |
| 48 | Verso | `Interior Page` | Cap 03 · Headings: 3.3.3, 3.3.4 |
| 49 | Recto | `Interior Page` | Cap 03 · Headings: 3.4 |
| 50 | Verso | `Interior Page` | Cap 03 · Headings: 3.4.1, 3.4.2 |
| 51 | Recto | `Interior Page` | Cap 03 · Headings: 3.4.3 |
| 52 | Verso | `Interior Page` | Cap 03 · Headings: 3.4.4, 3.5 |
| 53 | Recto | `Interior Page` | Cap 03 · Headings: 3.5.1, 3.5.2 |
| 54 | Verso | `Interior Page` | Cap 03 · Headings: 3.5.3, 3.6, 3.6.1 |
| 55 | Recto | `Interior Page` | Cap 03 · Headings: 3.6.2, 3.6.3 |
| 56 | Verso | `Interior Page` | Cap 03 · Headings: 3.6.4 |

---

## 11. Verificación de Integridad Criptográfica (SHA-256)

Para dar cumplimiento estricto a las **Reglas de Seguridad**, se certifica que los archivos fuente no han sufrido ninguna alteración física ni modificación de texto:

| Archivo Canónico / Plantilla | Hash SHA-256 Verificado | Estado de Integridad |
|---|:---:|:---:|
| `capitulos/01_capitulo1_declaracion_principios.md` | `B18B22334759386A547DC94103F6A63EC5AD72BFC9BAA10E4453D9143E58246E` | **INTACTO / READ-ONLY** |
| `capitulos/02_capitulo2_propiedad_control_liquidez.md` | `5D3AA506523703D1D5588E74ADDABB3EB4F11B1A660653AD50F09B787EA46886` | **INTACTO / READ-ONLY** |
| `capitulos/03_capitulo3_gobierno_profesionalizacion.md` | `536C8D9879441CDE924C78C36F4B4879A9F69069540FAA699E002367A0B8CC53` | **INTACTO / READ-ONLY** |
| `templates/typst/componentes.typ` | `8433F851EA3E0EA9EDC09759DF25E37F6D95EBF20E0FDBAC072A2E9445E38442` | **INTACTO / LOCKED** |

---

## 12. Comparativa Forense Fase 3.7.3 vs Fase 3.8

| Parámetro Editorial | Fase 3.7.3 (Consolidación Retícula) | Fase 3.8 (Saneamiento de Parser) | Impacto / Estado |
|---|:---:|:---:|:---:|
| Artefacto `%2.` en P.32 | 3 ocurrencias (`%2. La deducción...`) | **0 ocurrencias** (`i.`, `ii.`, `iii.`) | **Corregido 100%** |
| Sangría lista subordinada P.32 | 0 pt (párrafo plano sin indentar) | **40 pt** (`#legal-roman`) | **Jerarquía restaurada** |
| Comillas en Portada Cap 01 | Comillas simples curvas (`‘ ’`) | **0 comillas** (Texto limpio) | **Corregido 100%** |
| Comillas en Portada Cap 02 | Comillas simples curvas (`‘ ’`) | **0 comillas** (Texto limpio) | **Corregido 100%** |
| Comillas en Portada Cap 03 | Comillas simples curvas (`‘ ’`) | **0 comillas** (Texto limpio) | **Corregido 100%** |
| Headings reconocidos | 90 headings | **90 headings** | Consistente |
| Headings huérfanos | 0 | **0** | Consistente |
| Total de Páginas | 56 páginas | **56 páginas** | Paridad idéntica |
| Retícula vertical superior | +6.00 mm (+17.01 pt) | **+6.00 mm (+17.01 pt)** | Congelado |
| Tamaño de archivo PDF | 940.4 KB | **940.8 KB** | Óptimo |

---

## 13. Renders y Evidencia Visual de Calibración

Se exportaron renders a 200 DPI disponibles en la carpeta de artefactos:

1. **Página 32 (Lista Romana Saneada):**
   - Archivo: `page_32_roman_numerals.png`
   - Muestra la subordinación perfecta de `i.`, `ii.`, `iii.` con sangría de 40 pt bajo el inciso d).
2. **Portadas de Capítulos sin Comillas:**
   - `opening_cap01_no_quotes.png` (Página 3)
   - `opening_cap02_no_quotes.png` (Página 9)
   - `opening_cap03_no_quotes.png` (Página 39)
3. **Pliegos Enfrentados de Verificación (Spreads):**
   - `spread_17_page_32_33.png`: Pliego completo P.32 (Verso) y P.33 (Recto).
   - `spread_02_opening_cap01_fase38.png`: Pliego P.02 (Blanca) | P.03 (Opening Cap 01).
   - `spread_05_opening_cap02_fase38.png`: Pliego P.08 (Blanca) | P.09 (Opening Cap 02).
   - `spread_20_opening_cap03_fase38.png`: Pliego P.38 (Blanca) | P.39 (Opening Cap 03).

---

## 14. Conclusiones y Próximos Pasos

1. El parser automatizado ha alcanzado **madurez institucional**, eliminando artefactos heredados de OpenXML sin tocar una sola coma de las fuentes canónicas.
2. La serialización de títulos de apertura en tuplas nativas erradicó las comillas espurias de manera elegante y definitiva.
3. La jerarquía editorial de 90 headings opera con estabilidad total, respetando la numeración multinivel y la retícula congelada de +6 mm.
4. El documento maestro `dist/STRESS_TEST_CAPITULOS_01_03_FASE_3_8.pdf` se encuentra listo para su revisión visual definitiva.

---

## 15. Veredicto Editorial

> ### **FASE 3.8: APROBADA TÉCNICAMENTE Y LISTA PARA REVISIÓN VISUAL**  
> **Saneamiento de Parser:** RESUELTO (100% libre de `%2.` y comillas espurias).  
> **Jerarquía y Keep-with-Next:** AUDITADO Y CERTIFICADO (90/90 headings, 0 huérfanos).  
> **Arquitectura Ceremonial:** CONSOLIDADA (56 páginas, paridad perfecta).  
> **Gobernanza:** `cover-page()`, `table-of-contents()`, `chapter-opening()` permanecen LOCKED. `chapter-first-page()` e `interior-page()` permanecen **PENDING FINAL LOCK** a la espera de la instrucción formal del usuario.