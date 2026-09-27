# Repositorio Editorial y Motor de Publicación
## Protocolo Familiar — Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
### Versión 2.0 · Familia Velasco Chedraui (Coatepec, Veracruz)

---

### 1. Declaración de Fuente Canónica

> [!IMPORTANT]
> **FUENTE CANÓNICA EDITABLE: `/capitulos/*.md`**
>
> A partir de la Fase 2, la carpeta `/capitulos/` constituye la **única fuente canónica y editable** del contenido del Protocolo Familiar.
>
> Todas las demás representaciones son **estrictamente derivadas** y se regeneran de forma automatizada mediante los scripts del repositorio:
> * `dist/protocolo_maestro.md` (o raíz `protocolo_maestro.md`) $\rightarrow$ Derivado consolidado.
> * `dist/protocolo_estructurado.json` (y `datos/estructura_documento.json`) $\rightarrow$ Derivado sintáctico (AST).
> * `templates/html/protocolo_media_carta.html` $\rightarrow$ Derivado web/impresión alternativa.
> * `dist/*.pdf` $\rightarrow$ Derivados binarios de salida editorial.
>
> **Regla de oro:** Cualquier corrección o ajuste de redacción debe realizarse exclusivamente en el archivo correspondiente dentro de `/capitulos/*.md` y propagarse mediante `python scripts/sincronizar_derivados.py`.

---

### 2. Arquitectura de Separación de Responsabilidades

El repositorio sigue un desacoplamiento estricto entre contenido, configuración, plantillas y compilación:

```text
repositorio_protocolo/
│
├── README.md                                    # Documentación técnica y reglas de arquitectura
├── protocolo_maestro.md                         # [DERIVADO] Markdown consolidado para consulta rápida
│
├── capitulos/                                   # [CONTENIDO - FUENTE CANÓNICA EDITABLE]
│   ├── 00_portada_e_indice.md
│   ├── 00_introduccion.md
│   ├── 01_capitulo1_declaracion_principios.md
│   ├── 02_capitulo2_propiedad_control_liquidez.md
│   ├── 03_capitulo3_gobierno_profesionalizacion.md
│   ├── 04_capitulo4_sucesion_familiar.md
│   ├── 05_capitulo5_control_informacion_comunicacion.md
│   ├── 06_capitulo6_disciplina_financiera.md
│   ├── 07_capitulo7_procedimiento_sancionador.md
│   ├── 08_capitulo8_solucion_conflictos.md
│   ├── 09_capitulo9_regimen_juridico.md
│   ├── 10_anexos_formatos_operativos.md
│   ├── 11_reglamento_asamblea_familia.md
│   ├── 12_reglamento_consejo_familia.md
│   └── 13_reglamento_comite_honor_familiar.md
│
├── config/                                      # [CONFIGURACIÓN EDITORIAL]
│   └── editorial_config.yaml                    # Parámetros globales (página, fuentes, márgenes, tablas)
│
├── datos/                                       # [DATOS Y METADATOS]
│   ├── metadatos.json                           # Variables institucionales (sociedad, fundadores, fechas)
│   └── estructura_documento.json                # Árbol de elementos derivado sincronizado
│
├── assets/                                      # [RECURSOS GRÁFICOS]
│   └── (Logotipos vectoriales, firmas, sellos institucionales)
│
├── templates/                                   # [PLANTILLAS Y MOTORES EDITORIALES]
│   ├── typst/                                   # Motor Principal (Typst)
│   │   └── protocolo_generado.typ               # Documento fuente Typst compilado
│   └── html/                                    # Motor Alternativo (Chromium / Paged Media)
│       ├── protocolo_media_carta.html           # Plantilla HTML5 semántica
│       └── estilos_media_carta.css              # Hoja de estilos CSS @page Media Carta
│
├── scripts/                                     # [SCRIPTS DE COMPILACIÓN Y CONTROL]
│   ├── compilar_typst.py                        # Compilador principal (capitulos/*.md -> Typst -> PDF)
│   ├── compilar_html.py                         # Compilador secundario (HTML -> PDF via Edge/Chromium)
│   ├── sincronizar_derivados.py                 # Regenera maestro.md, JSON y HTML desde /capitulos
│   └── validar_numeraciones.py                  # Auditoría estricta de incisos y viñetas jurídicas
│
└── dist/                                        # [ARCHIVOS GENERADOS Y ENTREGABLES]
    ├── PROTOCOLO_FAMILIAR_POLIFLEX_TYPST.pdf    # PDF de prueba técnica generado con Typst (1.1 MB)
    ├── PROTOCOLO_FAMILIAR_POLIFLEX_CHROMIUM.pdf # PDF de prueba técnica generado con Chromium (968 KB)
    ├── protocolo_maestro.md                     # Markdown consolidado derivado
    └── protocolo_estructurado.json              # Base de datos en JSON derivada
```

---

### 3. Reporte de Validación de Numeraciones Jurídicas

A partir de la inspección a bajo nivel de `word/numbering.xml` y `word/document.xml` del archivo original `PROTOCOLO FAMILIAR - POLIFLEX V2.docx`, se identificaron y preservaron **133 estructuras enumerativas dinámicas** que en conversiones estándar suelen degradarse erróneamente en viñetas genéricas (`-`):

| Formato Original en DOCX | Expresión XML | Cantidad | Ejemplos en el Texto |
| :--- | :--- | :---: | :--- |
| **Incisos alfabéticos minúsculos** | `lowerLetter` (`%1)`) | **49** | `a) Continuidad institucional...`, `b) Formalidad...`, `c) Mérito y capacidad...` |
| **Sub-incisos romanos minúsculos** | `lowerRoman` (`%1.` / `%2.`) | **7** | `i. Excluir ingresos extraordinarios...`, `i. La deducción de la deuda financiera neta;` |
| **Fracciones en romanos mayúsculos** | `upperRoman` (`%1.`) | **73** | `I. Registro de asistencia...`, `II. Declaración formal...`, `I. Presidente;` |
| **Pasos procedimentales decimales** | `decimal` (`%1.`) | **4** | `1. Análisis del expediente.`, `2. Valoración de antecedentes.` |
| **Total de incisos jurídicos formalizados** | — | **133** | **100.0% recuperados sin pérdida ni viñetas genéricas** |

> [!NOTE]
> **Casos analizados y resueltos:**
> 1. **Sub-incisos de Valuación EBITDA (Art. 2.9.2):** En el DOCX original, las reglas de ajuste del EBITDA y del capital accionario dependen jerárquicamente de los incisos `b)` y `d)`. Fueron implementadas con sangría de nivel 2 y numeración `i.`, `ii.`, `iii.`, `iv.`, preservando expresamente la **deducción de la deuda financiera neta** y la **adición de efectivo no operativo**.
> 2. **Integración y Convocatorias de Órganos (Reglamentos):** Todos los listados de cargos (`I. Presidente; II. Secretario; III. Tres Vocales`) y órdenes del día conservan sus fracciones en números romanos.
> 3. **Cláusulas Solemnes (Carta de Adhesión):** Los encabezados `PRIMERO.`, `SEGUNDO.`, `TERCERO.`, `CUARTO.`, `QUINTO.` se conservaron íntegramente en mayúsculas solemnes.

---

### 4. Configuración Editorial Centralizada (`config/editorial_config.yaml`)

El archivo [`config/editorial_config.yaml`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/config/editorial_config.yaml) desacopla por completo el diseño visual del contenido canónico. Los parámetros que controla globalmente incluyen:
* **Página y Márgenes:** Media Carta (5.5 × 8.5 in / 139.7 × 215.9 mm), páginas enfrentadas (`facing_pages: true`), sangrado de imprenta (3 mm), margen interior/lomo de 18 mm y exterior de 15 mm.
* **Tipografías y Escalas:** Fuentes de cuerpo (`Inter` / `Segoe UI`), jerarquías H1 a H4 (de 15.5pt a 9.5pt), interlineado relativo de `0.65em` (leading) y `1.35` (CSS).
* **Control de Composición:** Justificación completa, corte silábico en español (`hyphenation: true`), control de viudas y huérfanas (mínimo 2 líneas).
* **Encabezados y Pies:** Folios dinámicos en bordes exteriores, encabezados alternados (recto: título del capítulo / verso: razón social), supresión en portada e inicio de capítulo.
* **Tablas:** Bordes en color institucional `#cbd5e1`, relleno de encabezados `#f1f5f9`, padding regulado y compatibilidad con casillas de verificación `$\square$`.

---

### 5. Instrucciones de Compilación

#### A. Pipeline Principal con Typst (Recomendado)
El motor Typst 0.15.1 se encuentra instalado y configurado en el entorno local.
```powershell
python C:\Users\JJSS\Desktop\ABC\repositorio_protocolo\scripts\compilar_typst.py
```
* **Salida generada:** [`dist/PROTOCOLO_FAMILIAR_POLIFLEX_TYPST.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/PROTOCOLO_FAMILIAR_POLIFLEX_TYPST.pdf) (1.1 MB).
* **Velocidad de compilación:** < 2 segundos.

#### B. Pipeline Secundario con Chromium / Edge Headless
```powershell
python C:\Users\JJSS\Desktop\ABC\repositorio_protocolo\scripts\compilar_html.py
```
* **Salida generada:** [`dist/PROTOCOLO_FAMILIAR_POLIFLEX_CHROMIUM.pdf`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/dist/PROTOCOLO_FAMILIAR_POLIFLEX_CHROMIUM.pdf) (968 KB).

#### C. Sincronización de Archivos Derivados
Si edita algún archivo en `capitulos/*.md`, ejecute:
```powershell
python C:\Users\JJSS\Desktop\ABC\repositorio_protocolo\scripts\sincronizar_derivados.py
```

#### D. Auditoría de Numeraciones
```powershell
python C:\Users\JJSS\Desktop\ABC\repositorio_protocolo\scripts\validar_numeraciones.py
```

---

### 6. Reporte de Limitaciones y Puntos de Atención Detectados

1. **Tipografía "Inter" en Typst:** Si la fuente tipográfica *Inter* no está instalada como archivo del sistema en Windows, Typst aplica un reemplazo automático silencioso hacia *Segoe UI* o *Arial*. En la siguiente etapa de diseño visual, se pueden incorporar las fuentes `.otf` / `.ttf` directamente en la carpeta `/assets/fonts/` para garantizar renderizado idéntico en cualquier equipo.
2. **Líneas de Firma y Guiones Bajos en Typst:** En Typst, el carácter `_` denota cursiva. En la compilación se implementó un filtro de escape para que los espacios de firma (`________________________`) se rendericen sin generar advertencias de delimitadores no cerrados.
3. **Paginación en Tablas Extensas:** En el PDF de prueba técnica actual, las tablas pequeñas se mantienen indivisas (`keep_together: true`). Cuando se trabaje el diseño editorial definitivo, se calibrará la repetición automática de encabezados (`table.header`) para tablas que superen una página.

---

### 7. Estado del Sistema de Componentes Editoriales (Etapa 3: Diseño Visual)

| Componente | Función en `componentes.typ` | Configuración | Prueba Aislada | Referencia Autoritativa | Estado Formal |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **Portada General** | `cover-page(cfg)` | `config/editorial_config.yaml` (`cover:`) | `dist/TEST_COVER.pdf` | `referencias/01 portada.pdf` | **`APPROVED / LOCKED`** |
| **Tabla de Contenidos** | `table-of-contents(cfg, ...)` | `config/editorial_config.yaml` (`toc:`) | `dist/TEST_TOC.pdf` | `referencias/02 tabla de contenidos.pdf` | **`APPROVED / LOCKED`** |
| **Apertura de Capítulo** | `chapter-opening()` | *Pendiente Fase 3.4* | — | *Pendiente* | *Por maquetar* |
| **Páginas Interiores** | `running-header()`, `folio()`, etc. | *Pendiente* | — | *Pendiente* | *Por maquetar* |

> [!CAUTION]
> **REGLA DE CONGELAMIENTO (LOCKED):**
> Los componentes `cover-page()` y `table-of-contents()` han sido validados con fidelidad nanométrica contra sus referencias originales de Adobe Illustrator.
> **Queda estrictamente prohibido modificar directa o indirectamente su geometría, coordenadas, fuentes, leading, tracking, colores o recursos asociados** durante las fases siguientes del proyecto, salvo instrucción expresa.

