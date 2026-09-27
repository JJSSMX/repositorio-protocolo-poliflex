# ARQUITECTURA EDITORIAL — REGLAMENTOS (FASE 4.2)
**Protocolo Familiar POLIFLEX · Órganos de Gobierno Familiar**  
**Documentos Fuente:**  
- [`capitulos/11_reglamento_asamblea_familia.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/11_reglamento_asamblea_familia.md)  
- [`capitulos/12_reglamento_consejo_familia.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/12_reglamento_consejo_familia.md)  
- [`capitulos/13_reglamento_comite_honor_familiar.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/13_reglamento_comite_honor_familiar.md)  
**Estado:** Propuesta Arquitectónica / Sin Implementación

---

## 1. Caracterización Forense de las Fuentes

El corpus normativo de los órganos de gobierno familiar comprende:
- **3 Reglamentos Autónomos:**
  1. *Reglamento de la Asamblea de Familia* (8 Capítulos, 12 Artículos, 1 Transitorio, 1,484 palabras).
  2. *Reglamento del Consejo de Familia* (9 Capítulos, 12 Artículos, 1 Transitorio, 1,301 palabras).
  3. *Reglamento del Comité de Honor Familiar* (9 Capítulos, 12 Artículos, 1 Transitorio, 1,377 palabras).
- **Consolidado Estructural:** 26 Capítulos internos, 36 Artículos jurídicos, 3 Transitorios únicos, 121 párrafos, 4,162 palabras totales.
- **Función Jurídica y Operativa:** Normativa reglamentaria subordinada al Protocolo Familiar (Prevalencia normativa ratificada en el Artículo 2 de cada reglamento). Diseñados para la consulta ágil, orden procedimental y aplicación disciplinada.

---

## 2. Diferenciación Jerárquica: Reglamentos vs. Capítulos Principales

### Principio de Prevención de Confusión (`CAPÍTULO 01` vs. `CAPÍTULO I`)
Uno de los riesgos editoriales más graves en la obra completa es que el lector confunda:
- `CAPÍTULO 01: DECLARACIÓN DE PRINCIPIOS` (Cuerpo Principal del Protocolo) con
- `CAPÍTULO I: DE LAS DISPOSICIONES GENERALES` (Reglamento interno).

Para garantizar parentesco pero **subordinación jerárquica incuestionable**, se establecen las siguientes reglas de diferenciación:

| Parámetro Editorial | Capítulos Principales (01–09) | Capítulos de Reglamentos (I–IX) |
| :--- | :--- | :--- |
| **Numeración** | Arábiga a 2 dígitos con cero inicial (`01`, `02`, ..., `09`). | Romana mayúscula clásica (`CAPÍTULO I`, `CAPÍTULO II`, ...). |
| **Apertura Ceremonial** | `chapter-opening()` a doble página (pliego monumental con arco, matriz de puntos y folio ceremonial). | Portadilla de sección sobria o encabezado en bloque; **nunca** matriz de puntos ni arco monumental. |
| **Escala Tipográfica** | Número colosal (~40–60 pt), título principal en 18–22 pt. | Encabezado H2 sobrio (11–13 pt), subtítulo en 9–10 pt semibold. |
| **Filete / Rúbrica** | Filete horizontal naranja institucional (#f04e23) de 0.902 pt de grosor. | Filete sutil en gris institucional (#6c6b67) o naranja reducido, subordinado. |
| **Continuidad de Flujo** | Siempre inicia en página RECTO impar obligatoria. | Flujo continuo protegido (evitando páginas desiertas) con separación reforzada (18–24 pt) entre capítulos romanos. |
| **Running Header** | `chapter_title` del Protocolo. | `REGLAMENTO: [ÓRGANO] · CAPÍTULO [ROMANO]`. |

---

## 3. Arquitectura de Apertura de cada Reglamento

### A. Portadilla Propia de Reglamento
Cada uno de los tres reglamentos regula un órgano de gobierno específico (Asamblea, Consejo, Comité de Honor).
- **Criterio:** Cada reglamento debe contar con una **Portadilla de Identificación Institucional en RECTO**, que establezca su autonomía funcional dentro del sistema de gobernanza.
- **Contenido de la Portadilla:**
  - Cintillo superior: `GOBIERNO CORPORATIVO FAMILIAR · NORMATIVA ADJETIVA`
  - Título principal: `REGLAMENTO DE LA ASAMBLEA DE FAMILIA` (o Consejo / Comité).
  - Subtítulo: `Poliductos Flexibles, S.A. de C.V. · Familia Velasco Chedraui`.
  - Cuadro de metadatos: Aprobación, Vigencia, Carácter vinculante.
- **Verso Blanco:** Sí, el verso posterior a la portadilla de cada reglamento queda en blanco para permitir que el articulado comience con dignidad en el siguiente Recto.

---

## 4. Representación Tipográfica del Articulado

### A. Encabezado de Capítulo Romano (`## CAPÍTULO [ROMANO]`)
- Línea 1: `CAPÍTULO I` (Neuzeit Grotesk, 10 pt, tracking 0.100 em, color gris oscuro institucional o naranja de acento).
- Línea 2: `**DE LAS DISPOSICIONES GENERALES**` (Neuzeit Grotesk o Minion Pro, 10 pt, bold, tracking 0.050 em, color #2e2f31).
- Comportamiento: Regla `keep-with-next` inquebrantable; nunca queda huérfano al fondo de página. Requiere un mínimo de 1 artículo completo posterior o heading + 3 líneas.

### B. Encabezado de Artículo (`### Artículo [N]. [Nombre]`)
- Formato canónico: `Artículo 1. Del Objeto y Alcance` (Sin punto final tras el título).
- Tipografía: Minion Pro Bold o Neuzeit Bold, 9.5–10 pt, color #2e2f31.
- Espaciado: 12 pt antes, 4–5 pt después. `keep-with-next: true`.

### C. Fracciones Romanas (`I.`, `II.`, `III.`)
- Numeración: Romana mayúscula seguida de punto (`I.`, `II.`).
- Sangría y Alineación: Sangría francesa (hanging indent) calibrada (prefijo ancho fijo ~18–22 pt), permitiendo que el bloque de texto mantenga una alineación vertical perfecta en el margen izquierdo.
- Cuerpo: Minion Pro Regular, 9.5 pt, justificado, interlínea 13.5 pt.

### D. TRANSITORIO ÚNICO
- Tratamiento: Encabezado centrado o alineado a la izquierda precedido de filete separador sutil, tratado como disposición de vigencia y cierre.
- Texto: `**TRANSITORIO ÚNICO**`, seguido del párrafo de entrada en vigor en texto regular.

---

## 5. Navegación y Flujo de Páginas

### A. Flujo entre Capítulos Romanos Internos
- **Problema:** En el Reglamento 11 hay 8 capítulos en 1,484 palabras (~4-5 páginas totales). Si cada capítulo romano forzara un salto de página, se generarían páginas con solo 3 o 4 líneas y un número excesivo de páginas blancas artificiales.
- **Regla Arquitectónica:** Los capítulos romanos (I, II, III...) se desarrollan en **flujo continuo con separación vertical reforzada** (20–24 pt) y protección estricta contra viudas/huérfanas (mínimo heading + artículo + 2 líneas). No fuerzan página nueva a menos que no quepa el bloque inicial.

### B. Running Header y Folios
- **Verso (Izquierda):** `Poliductos Flexibles, S.A. de C.V. · Protocolo Familiar`
- **Recto (Derecha):** `Reglamento de la Asamblea de Familia` (o nombre del reglamento activo).
- **Folio:** Paginación arábiga continua integrada en el foliado maestro del Protocolo Familiar (sin paginaciones fragmentadas con prefijos "R-1" que rompan la unidad de encuadernación).

---

## 6. Alternativas Arquitectónicas para Reglamentos

### Alternativa A: "Módulo con Portadilla Noble Individual en Recto" (Recomendada)
- **Concepto:** Una macro-portadilla para la sección general de Reglamentos ("MÓDULO DE REGLAMENTOS Y GOBIERNO FAMILIAR") en Recto + Verso blanco. Luego, cada uno de los 3 reglamentos inicia con su propia portadilla sobria en Recto (página impar) + Verso blanco, y su texto corre en flujo continuo con capítulos romanos encadenados.
- **Ventajas:** Máxima claridad jurídica y jerárquica; cada reglamento funciona como un cuerpo normativo individualizado; lectura limpia sin inflación de páginas.
- **Riesgos:** Consume 6 páginas de portadilla en total para los 3 reglamentos.
- **Consistencia POLIFLEX:** 100% óptima. Refleja la autonomía formal de cada órgano.
- **Complejidad:** Media.

### Alternativa B: "Encabezado de Apertura Directa en Recto (Sin Portadilla Exclusiva)"
- **Concepto:** Cada reglamento inicia directamente en una página RECTO con un encabezado noble superior (Header Banner institucional) de un tercio de página, comenzando de inmediato con el Capítulo I y el Artículo 1 en la misma página.
- **Ventajas:** Reduce el número total de páginas eliminando 3 portadillas y sus versos blancos (ahorro de 6 páginas).
- **Riesgos:** Menor solemnidad; el inicio de un cuerpo legal formal se siente abrupto.
- **Consistencia POLIFLEX:** Media.
- **Complejidad:** Baja.

### Alternativa C: "Compilación Continua Unificada"
- **Concepto:** Los 3 reglamentos corren como un único apéndice normativo sin portadillas independientes, separándose únicamente por títulos H1 a inicio de página.
- **Ventajas:** Máxima compacidad física.
- **Riesgos:** Difumina la frontera entre los tres órganos de gobierno familiar; dificulta la consulta separada de un reglamento específico por sus miembros.
- **Consistencia POLIFLEX:** Baja. Desaconsejada en protocolos de alto nivel patrimonial.
- **Complejidad:** Mínima.

---

## 7. Síntesis y Recomendación Técnica
La **Alternativa A (Portadilla Noble Individual en Recto con flujo interno continuo de capítulos romanos)** es la propuesta que mejor honra la jerarquía jurídica de los tres órganos de gobierno familiar de POLIFLEX, asegurando al mismo tiempo que ningún capítulo romano genere páginas vacías accidentales.
