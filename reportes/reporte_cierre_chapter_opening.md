# Reporte Técnico de Cierre y Formalización Arquitectónica — Portada de Capítulo (`chapter-opening`)

**Proyecto:** Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)  
**Fase:** Fase 3.4 — Diseño Visual Definitivo (Tercer Componente: Apertura / Portada de Capítulo)  
**Fecha:** 26 de septiembre de 2026  
**Componente:** `chapter-opening()` en [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ)  
**Estado Final del Componente:** **`chapter-opening() = APPROVED / LOCKED`**

---

## 1. Resumen Ejecutivo

Con la conclusión de esta fase, se formaliza la arquitectura canónica definitiva para las portadas de apertura de capítulo (`chapter-opening()`), cumpliendo con los estándares de diseño editorial, desacoplamiento arquitectónico y reproducibilidad automatizada:

1. **Fuente Canónica Única:** El contenido reside exclusivamente en `/capitulos/*.md` mediante frontmatter YAML estructurado. Se eliminó cualquier catálogo duplicado o remanente en `config/editorial_config.yaml`.
2. **Desacoplamiento Semántica vs. Presentación:** Se formalizó la distinción entre `title` (cadena semántica continua para índices, metadatos y encabezados) y `opening_title` (saltos de línea editoriales aprobados para la portada del capítulo).
3. **Integridad Absoluta del Cuerpo Jurídico:** Se validó mediante comprobación de hashes criptográficos SHA-256 que el cuerpo legal de los 9 capítulos Markdown permaneció **100% inalterado byte por byte**.
4. **Verificación de No-Regresión Visual (300 DPI):** Se recompiló [`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf) obteniendo los datos directamente de los Markdown, obteniendo **0 píxeles de diferencia (100.00% identidad)** frente al PDF aprobado previo en las 9 páginas.
5. **Aislamiento de Componentes:** Las portadas generales (`cover-page()`) y la tabla de contenidos (`table-of-contents()`) compilaron con éxito manteniéndose 100% bloqueadas e inalteradas.

---

## 2. Arquitectura de Responsabilidades y Esquema Canónico

### 2.1. Separación Estricta de Capas

| Capa | Archivos / Componentes | Responsabilidad |
| :--- | :--- | :--- |
| **Contenido Canónico** | [`capitulos/*.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/) | `chapter_number`, `title`, `opening_title`, `description`, metadatos corporativos y articulado jurídico indivisible. Única fuente de verdad editorial editable. |
| **Presentación y Geometría** | [`config/editorial_config.yaml`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/config/editorial_config.yaml) | Definición paramétrica de tipografías (`Minion Pro`, `Neuzeit Grotesk`), tamaños, tracking, leading, paleta de colores, márgenes, dimensiones y rutas a vectores base. Libre de textos reales de capítulos. |
| **Lógica de Composición** | [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ) | Funciones de maquetación modular (`chapter-opening()`, `cover-page()`, `table-of-contents()`), medición dinámica de alturas de bloque y cálculo automático de la separación inter-bloques. Libre de condicionales duros (`if chapter == ...`). |
| **Automatización / Pipeline** | [`scripts/compilar_typst.py`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/scripts/compilar_typst.py) | Extracción de metadatos frontmatter, generación del Typst maestro y orquestación del compilador de producción. |

### 2.2. Esquema Frontmatter YAML en `/capitulos/*.md`

Cada uno de los 9 capítulos incorpora ahora la siguiente estructura de metadatos:

```yaml
---
chapter_number: "07"
title: "Procedimiento Sancionador y Régimen de Sanciones Internas"
opening_title:
  - "PROCEDIMIENTO"
  - "SANCIONADOR Y"
  - "RÉGIMEN DE SANCIONES"
  - "INTERNAS"
description: 'Faltas, medidas disciplinarias y procedimientos formales ante el \ incumplimiento de los acuerdos del protocolo.'
company: "Poliductos Flexibles, S.A. de C.V."
brand: "POLIFLEX"
family: "Familia Velasco Chedraui"
version: "2.0"
date: "Agosto 2026"
location: "Coatepec, Veracruz, México"
---
```

---

## 3. Comprobación Criptográfica de Integridad del Cuerpo Jurídico

Antes de aplicar la migración de metadatos frontmatter, se aisló el cuerpo normativo de cada archivo (todo texto posterior al cierre del frontmatter `---\n`) y se calculó su firma hash SHA-256. Tras escribir los nuevos campos canónicos y guardar los archivos, se recalculó la firma para garantizar que ninguna palabra, número, coma o salto de línea legal fue afectado:

| Capítulo | Archivo Markdown | Longitud Cuerpo (bytes) | Hash SHA-256 (Cuerpo Legal) | Estado de Integridad |
| :---: | :--- | :---: | :---: | :---: |
| **01** | `01_capitulo1_declaracion_principios.md` | 4,217 | `51f689ebbe78c682...` | **INVIOLADO (Byte-for-byte exact)** |
| **02** | `02_capitulo2_propiedad_control_liquidez.md` | 48,940 | `4149b84276685e87...` | **INVIOLADO (Byte-for-byte exact)** |
| **03** | `03_capitulo3_gobierno_profesionalizacion.md` | 32,115 | `c3f5e451d499dd81...` | **INVIOLADO (Byte-for-byte exact)** |
| **04** | `04_capitulo4_sucesion_familiar.md` | 40,951 | `cd152a79bc36cf12...` | **INVIOLADO (Byte-for-byte exact)** |
| **05** | `05_capitulo5_control_informacion_comunicacion.md` | 6,295 | `85ad1e1b7737e11e...` | **INVIOLADO (Byte-for-byte exact)** |
| **06** | `06_capitulo6_disciplina_financiera.md` | 5,663 | `4443eb1a9cfa0cae...` | **INVIOLADO (Byte-for-byte exact)** |
| **07** | `07_capitulo7_procedimiento_sancionador.md` | 7,752 | `45635023c850712a...` | **INVIOLADO (Byte-for-byte exact)** |
| **08** | `08_capitulo8_solucion_conflictos.md` | 6,031 | `f2780da2b4f838bb...` | **INVIOLADO (Byte-for-byte exact)** |
| **09** | `09_capitulo9_regimen_juridico.md` | 4,420 | `566d8d3fb7c77754...` | **INVIOLADO (Byte-for-byte exact)** |

---

## 4. Eliminación de Duplicaciones en `editorial_config.yaml`

Conforme a la instrucción editorial, se purgó completamente de [`config/editorial_config.yaml`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/config/editorial_config.yaml):
- El bloque `default_chapter` (título y descripción duplicados de prueba).
- La lista completa `chapter_opening.chapters` (entradas 01 a 09 que duplicaban títulos y descripciones).

El componente `chapter-opening()` en [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ) fue refactorizado para aceptar `opening_title: none` de forma nativa:
- Normaliza transparentemente arrays de cadenas (e.g. listas YAML) uniéndolas mediante cortes de línea tipográficos (`\`).
- Acepta cadenas simples o bloques de `content`.
- Posee fallback defensivo a `title` en caso de ausencia de `opening_title`.
- Funciona de forma 100% agnóstica sin condicionales específicos por número de capítulo.

---

## 5. Resultados de Validación Post-Migración (Raster 300 DPI)

Se ejecutó una comparación raster de píxeles a 300 DPI entre el documento compilado desde los Markdown canónicos ([`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf)) y la versión previamente aprobada de la prueba editorial:

| Página | Capítulo Evaluado | Píxeles Totales | Píxeles Diferentes | Error Relativo | Resultado Visual |
| :---: | :---: | :---: | :---: | :---: | :---: |
| **1** | Cap. 01 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **2** | Cap. 02 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **3** | Cap. 03 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **4** | Cap. 04 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **5** | Cap. 05 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **6** | Cap. 06 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **7** | Cap. 07 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **8** | Cap. 08 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **9** | Cap. 09 | 4,207,500 | **0** | **0.000%** | **Identidad Bit-Level Absoluta** |
| **Total** | **9 Páginas** | **37,867,500** | **0** | **0.000%** | **100% Idéntico** |

---

## 6. Resultados de Regresión de la Suite Editorial

Se compilaron individualmente los 4 artefactos maestros del sistema:

1. [`dist/TEST_COVER.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_COVER.pdf):
   - Tamaño: **798,830 bytes** (Sin cambios).
   - Componente: `cover-page() = APPROVED / LOCKED`.
   - Estado: Intacto, reproduce 1:1 `/referencias/01_portada.pdf`.
2. [`dist/TEST_TOC.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_TOC.pdf):
   - Tamaño: **13,693 bytes** (Sin cambios).
   - Componente: `table-of-contents() = APPROVED / LOCKED`.
   - Estado: Intacto, utiliza el título semántico (`title`), folios `"00"` y reproduce 1:1 `/referencias/02 tabla de contenidos.pdf`.
3. [`dist/TEST_CHAPTER_OPENING.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENING.pdf):
   - Tamaño: **680,136 bytes** (Sin cambios).
   - Componente: `chapter-opening()` consumiendo directamente el Capítulo 01 canónico.
   - Estado: Intacto, reproduce 1:1 `/referencias/03 portada capitulos.pdf`.
4. [`dist/TEST_CHAPTER_OPENINGS_ALL.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/TEST_CHAPTER_OPENINGS_ALL.pdf):
   - Tamaño: **694,338 bytes**.
   - Componente: Suite completa de los 9 capítulos con `opening_title` dinámico.
   - Estado: Compilación perfecta sin errores ni warnings críticos.

### Inspección de Tipografías Incrustadas
Se validó la ausencia total de fuentes del sistema en todos los PDFs generados:
- `MinionPro-MediumDisp` (Titulares y numeración).
- `NeuzeitGro-Reg` (Textos secundarios, lemas, descripciones y pies de página).
- **Georgia / Segoe UI:** **0% de presencia** en los documentos finales.

---

## 7. Archivos Modificados / Creados en Esta Fase

| Archivo | Tipo de Acción | Detalle |
| :--- | :---: | :--- |
| [`capitulos/01_capitulo1_declaracion_principios.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/01_capitulo1_declaracion_principios.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`capitulos/02_capitulo2_propiedad_control_liquidez.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/02_capitulo2_propiedad_control_liquidez.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`capitulos/03_capitulo3_gobierno_profesionalizacion.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/03_capitulo3_gobierno_profesionalizacion.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`capitulos/04_capitulo4_sucesion_familiar.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/04_capitulo4_sucesion_familiar.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`capitulos/05_capitulo5_control_informacion_comunicacion.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/05_capitulo5_control_informacion_comunicacion.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`capitulos/06_capitulo6_disciplina_financiera.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/06_capitulo6_disciplina_financiera.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`capitulos/07_capitulo7_procedimiento_sancionador.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/07_capitulo7_procedimiento_sancionador.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`capitulos/08_capitulo8_solucion_conflictos.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/08_capitulo8_solucion_conflictos.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`capitulos/09_capitulo9_regimen_juridico.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/09_capitulo9_regimen_juridico.md) | Modificado | Incorporación de `chapter_number`, `title`, `opening_title`, `description`. Cuerpo intacto. |
| [`config/editorial_config.yaml`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/config/editorial_config.yaml) | Modificado | Eliminación de `chapters` y `default_chapter` bajo `chapter_opening`. Cero duplicación. |
| [`templates/typst/componentes.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/templates/typst/componentes.typ) | Modificado | Soporte nativo para `opening_title`, normalización de arrays de cadenas y preservación de gap vertical. |
| [`tests/test_chapter_openings_all.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_chapter_openings_all.typ) | Modificado | Lógica dinámica que lee los 9 markdown canónicos vía `yaml(bytes(...))`. |
| [`tests/test_chapter_opening.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/tests/test_chapter_opening.typ) | Modificado | Lee los datos canónicos del Capítulo 01 desde su frontmatter Markdown. |
| [`test_chapter_opening.typ`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/test_chapter_opening.typ) | Modificado | Documento raíz sincronizado con `tests/test_chapter_opening.typ`. |
| [`scripts/compilar_typst.py`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/scripts/compilar_typst.py) | Modificado | Extracción de metadatos canónicos Markdown e inyección en `chapter-opening()`. |
| [`reportes/reporte_cierre_chapter_opening.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/reportes/reporte_cierre_chapter_opening.md) | Creado | Este informe técnico formal de cierre. |

---

## 8. Estado Final Consolidado de Componentes

Al haber satisfecho rigurosamente todas las condiciones requeridas, se declara formalmente el bloqueo del componente:

```text
================================================================================
ESTADO CONSOLIDADO DEL SISTEMA EDITORIAL (FASE 3):
--------------------------------------------------------------------------------
1. cover-page()         : APPROVED / LOCKED  (Fase 3.2 — Portada General)
2. table-of-contents()  : APPROVED / LOCKED  (Fase 3.3 — Tabla de Contenidos)
3. chapter-opening()    : APPROVED / LOCKED  (Fase 3.4 — Portada de Capítulo)
================================================================================
```

A partir de este momento, ninguno de estos tres componentes maestros podrá ser modificado directa ni indirectamente sin autorización expresa.
