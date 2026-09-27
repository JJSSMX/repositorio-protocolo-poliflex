# EVALUACIÓN DE COMPONENTES POTENCIALES Y MATRIZ DE HERENCIA (FASE 4.2)
**Protocolo Familiar POLIFLEX · Sistema de Diseño Editorial Typst**  
**Estado:** Dictamen Arquitectónico / Sin Implementación de Código

---

## 1. Revisión Crítica de Candidatos Detectados en Fase 4.0

A continuación se evalúa la viabilidad y necesidad estructural de cada uno de los 8 componentes propuestos inicialmente:

### 1. `introduction-page()`
- **Decisión:** **MANTENER COMO CANDIDATO** (con alcance acotado).
- **Justificación:** La Introducción (305 palabras) posee un carácter solemne no numerado que no encaja ni en `chapter-opening()` (no es un capítulo numerado con arco y matriz de puntos) ni en `interior-page()` estándar (requiere un encabezado institucional específico y supresión de running header en su inicio).
- **Alcance Propuesto:** Función de apertura y contenedor noble para la página única de introducción.

### 2. `annex-cover()`
- **Decisión:** **FUSIONAR** en un componente más general: `module-opening()`.
- **Justificación:** Crear un componente exclusivo para la portadilla de Anexos y otro para la de Reglamentos generaría duplicidad de código innecesaria. Ambos módulos (Anexos y Reglamentos) necesitan exactamente la misma estructura: una portadilla de módulo de gran categoría en página Recto, con cintillo institucional, título de módulo, descripción y verso blanco de transición.
- **Nuevo Candidato Fusionado:** `module-opening(title: "...", subtitle: "...", desc: "...")`.

### 3. `legal-form()`
- **Decisión:** **MANTENER COMO CANDIDATO**.
- **Justificación:** Los 7 formatos operativos requieren un layout que gestione:
  a) Inicio obligado en página nueva;
  b) Encabezado institucional de formato (número de anexo + título en bloque sobrio);
  c) Control estricto de no-desborde para mantener cada formato autocontenido en 1 o 2 páginas;
  d) Supresión o adaptación del running header para mostrar el nombre del formato específico.

### 4. `legal-table()`
- **Decisión:** **FUSIONAR / EXTENDER** la función existente `table-style()`.
- **Justificación:** En `componentes.typ` ya existe `#let table-style(columns, headers, rows, caption)`. Crear un nuevo `legal-table()` desde cero fragmentaría el sistema. Lo correcto es evolucionar y parametrizar `table-style()` para que admita alturas de fila personalizadas (para rúbricas de firma manual) y anchos porcentuales específicos sobre los 314.56 pt útiles.

### 5. `signature-block()`
- **Decisión:** **MANTENER COMO CANDIDATO** (con carácter prioritario).
- **Justificación:** La firma es el elemento crítico de cierre legal en contratos, convocatorias y actas. Es indispensable contar con un componente atómico que empaquete la fórmula de cortesía ("Atentamente"), la línea de rúbrica vectorial y el nombre/cargo, dotado de `breakable: false` y protección contra páginas de sola firma.

### 6. `regulation-opening()`
- **Decisión:** **MANTENER COMO CANDIDATO** (subordinado a `module-opening()`).
- **Justificación:** Si bien el módulo general de reglamentos usará `module-opening()`, cada uno de los 3 reglamentos individuales (Asamblea, Consejo, Comité) necesita una portadilla intermedia sobria (o encabezado mayor) para señalar la transición entre órganos.

### 7. `regulation-page()`
- **Decisión:** **DESCARTAR COMO COMPONENTE AISLADO** (Heredar directamente de `interior-page()`).
- **Justificación:** Las páginas de articulado de los reglamentos comparten exactamente la misma caja de texto, márgenes, sistema recto/verso, folio y retícula que las páginas de los Capítulos 01–09. Crear una `regulation-page()` independiente violaría el principio de "UNA SOLA OBRA". La única diferencia es el contenido del running header, lo cual se resuelve mediante selectores dinámicos en la plantilla existente.

### 8. `legal-article()`
- **Decisión:** **DESCARTAR COMO COMPONENTE TYPST AISLADO** (Resolver mediante reglas de estilo Typst nativas `#show heading.where(level: 3)`).
- **Justificación:** Los 36 artículos están formalmente marcados en Markdown como `### Artículo [N]. [Nombre]`. Encapsular cada artículo en una función Typst `#legal-article[...]` requeriría reescribir todo el Markdown canónico con llamadas a macros. En Typst es infinitamente más limpio y robusto aplicar una regla de visualización (`#show heading.where(level: 3): it => ...`) con `keep-with-next: true`.

---

## 2. Catálogo Consolidado de Componentes Candidatos

| Componente Propuesto | Rol Funcional | Relación con Línea Base | Decisión |
| :--- | :--- | :--- | :---: |
| **`module-opening()`** | Portadilla noble para macro-secciones (Módulo de Anexos, Módulo de Reglamentos). | Variante sobria de `chapter-opening()` (sin arco monumental ni matriz de puntos; tipografía institucional idéntica). | **NUEVO CANDIDATO** (Fusiona `annex-cover` y portadillas maestras) |
| **`introduction-page()`** | Layout solemne para la página noble unitaria de la Introducción. | Derivado de la caja noble en Recto, sin running header invasivo. | **MANTENER CANDIDATO** |
| **`regulation-header()`** | Encabezado o portadilla intermedia para cada uno de los 3 reglamentos. | Variante institucional jerarquizada de H1 reglamentario. | **MANTENER CANDIDATO** |
| **`legal-form-container()`** | Contenedor de página autocontenida para cada uno de los 7 formatos operativos. | Control de página y márgenes con encabezado de formato operativo. | **MANTENER CANDIDATO** |
| **`signature-block()`** | Bloque atómico de rúbrica individual indivisible con protección anti-huérfana. | Vectorial nativo parametrizado con DNA institucional. | **MANTENER CANDIDATO** |
| **`table-style()` (Extendido)** | Adaptación de la función existente para tablas con filas de firma manual. | Hereda 100% de `templates/typst/componentes.typ`. | **EXTENDER EXISTENTE** |

---

## 3. Matriz de Herencia Editorial desde la Baseline Aprobada

Todos los componentes candidatos están obligados a heredar sin excepciones los fundamentos de la baseline consolidada en Fase 3.9.3:

| Parámetro Editorial | Herencia Estricta de Baseline (LOCKED) | Adaptación Específica por Módulo |
| :--- | :--- | :--- |
| **Dimensiones de Página** | `396 pt × 612 pt` (Media Carta / Half Letter, 5.5 × 8.5 in). | **Inalterable.** Ningún módulo puede cambiar de tamaño de hoja. |
| **Caja Tipográfica y Márgenes** | Lomo: `58.74 pt`, Corte: `22.70 pt`. Ancho útil: **`314.56 pt`**. | **Inalterable.** La retícula horizontal es unificada para toda la obra. |
| **Sistema Recto / Verso** | Alternancia de márgenes interior/exterior según paridad de página. | **Inalterable.** Aperturas siempre en Recto. |
| **Tipografía Primaria** | Minion Pro (Serif clásica institucional). | Texto corrido en 10.5 pt / interlínea 14.5 pt (Introducción) y 9.5 pt / interlínea 13.5 pt (Reglamentos y Anexos). |
| **Tipografía Secundaria** | Neuzeit Grotesk (Sans-serif institucional geométrica). | Títulos, encabezados, rótulos de formularios, tablas y cintillos. |
| **Paleta Cromática** | • Naranja: `#f04e23`<br>• Gris Oscuro: `#2e2f31`<br>• Gris Medio: `#6c6b67`<br>• Gris Fondo: `#ebe5e3` | **Inalterable.** Se prohíbe introducir colores no corporativos. |
| **Control de Párrafos** | Regla `2+2` (mínimo 2 líneas a la apertura de página y 2 al cierre). | Aplicación estricta en Introducción y Reglamentos. |
| **Protección de Encabezados** | `keep-with-next: true` en todos los niveles H2, H3, H4. | Reforzado en Reglamentos para no separar `Artículo N` de sus fracciones. |
| **Folios** | Posición exterior (Verso izquierda, Recto derecha) a `594.6387 pt`. | Foliado continuo arábigo en todo el volumen maestro. |

---

## 4. Síntesis
El ecosistema de componentes se mantiene magro, elegante y disciplinado: no se crean componentes superfluos; se reutiliza la retícula consolidada y se definen exclusivamente 4 candidatos nuevos y 1 extensión funcional sobre la base LOCKED de `componentes.typ`.
