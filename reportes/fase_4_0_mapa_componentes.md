# MAPA DE COMPONENTES EDITORIALES Y PATRONES ESTRUCTURALES
**FASE 4.0 — INVENTARIO Y MAPEO DE COMPONENTES**  
**Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)**  
**Fecha:** 26 de Septiembre de 2026  
**Carácter:** LECTURA, ANÁLISIS, CLASIFICACIÓN Y MAPEO (READ-ONLY)

---

## 1. CLASIFICACIÓN EDITORIAL PRELIMINAR DE ESTRUCTURAS

Conforme a las directivas de la Fase 4.0, las estructuras documentales identificadas en los módulos restantes se clasifican en tres categorías funcionales:

```text
==================================================================================================
CATEGORÍA                   DEFINICIÓN METODOLÓGICA                         ESTRUCTURAS ASOCIADAS
==================================================================================================
TIPO A — REUTILIZABLE       Estructura compatible directamente con          - Párrafos de texto justificado
DIRECTAMENTE                un componente LOCKED sin alterarlo.              - Incisos alfabéticos a)-d)
                                                                            - Articulado legal continuo

TIPO B — VARIANTE           Estructura que comparte la baseline             - Apertura/Portada de Reglamento
                            (retícula, márgenes, tipografías), pero          - Primera página de Reglamento
                            requiere un envoltorio o estado específico.      - Proemio solemne de Introducción
                                                                            - Portadilla de Anexos

TIPO C — COMPONENTE NUEVO   Estructura que conceptualmente requiere         - Formularios con líneas de llenado
                            tratamiento tipográfico o de maquetación         - Tablas de actas y asistencia
                            propio no existente en la baseline 01–09.        - Checklists con casillas (☐)
                                                                            - Bloques de firma y rúbrica
                                                                            - Fracciones romanas legislativas
==================================================================================================
```

---

## 2. MATRIZ DE PATRONES REPETIDOS

| PATRÓN ESTRUCTURAL | ARCHIVOS DONDE APARECE | FRECUENCIA TOTAL | VARIACIONES DETECTADAS | POSIBLE REUTILIZACIÓN (DIAGNÓSTICO) |
|:---|:---|:---:|:---|:---|
| **Estructura Articular con Título** (`Artículo #. Nombre`) | 11, 12, 13 | 36 artículos (12 en c/u) | Reg 12 Art 12 tiene punto final (`Previstos.`); Reg 11 y 13 tienen cuerpo en negrita. | Componente o macro de presentación de artículos legales independientes. |
| **Capítulos Romanos con Subtítulo Temático** (`CAPÍTULO X` + `**TÍTULO**`) | 11, 12, 13 | 26 capítulos (8 en 11, 9 en 12, 9 en 13) | En Reg 12 (Caps VI a IX) el título está fusionado en la misma línea (`CAPÍTULO VIDE...`). | Heading de capítulo reglamentario sin numeración decimal prefijada. |
| **Fracciones en Romano Mayúsculo** (`I.`, `II.`, `III.`) | 10, 11, 12, 13 | 61 fracciones (4 en 10, 16 en 11, 22 en 12, 19 en 13) | En Reg 11 y 13 están en negrita (`I. **Texto**`); en Anexo 10 forman parte de Órdenes del Día. | Macro de lista jurídica con sangría de fracción legislativa. |
| **Disposición Transitoria Final** (`TRANSITORIO ÚNICO`) | 11, 12, 13 | 3 instancias (1 en c/u) | Párrafo autónomo en negrita al final de cada reglamento. | Bloque de cierre reglamentario con filete o respiración especial. |
| **Tablas de Cierre y Firmas Colegiadas** | 10 (Anexos) | 5 tablas de firma | Varían de 3 a 4 columnas según el órgano (Asamblea, Consejo, Comité). | Grid o tabla de firmas estandarizada con líneas de rúbrica. |
| **Casillas de Verificación** (`☐`) | 10 (Anexos) | 18 casillas | Casillas aisladas en tablas (`☐ Sí ☐ No`), en votaciones y en checklist vertical. | Símbolo tipográfico inline (`#sym.square`) calibrado con texto. |
| **Líneas de Captura / Espacios en Blanco** (`_____`) | 10 (Anexos) | 34 líneas de captura | Líneas cortas para fechas/porcentajes y líneas completas para desarrollo. | Regla de relleno o bloque de formulario controlado para evitar overflow. |

---

## 3. MAPA PRELIMINAR DE COMPONENTES POTENCIALES

Basado **exclusivamente** en los requerimientos documentales reales:

| COMPONENTE POTENCIAL | FUNCIÓN EDITORIAL | ARCHIVOS REQUERIDOS | TIPO | COMPONENTE LOCKED RELACIONADO | JUSTIFICACIÓN TÉCNICA |
|:---|:---|:---:|:---:|:---|:---|
| `introduction-page()` | Presentación solemne del proemio familiar | `00` | **Tipo B** | `interior-page()` | Requiere retícula base +6 mm pero cabecera sobria y maquetación noble para 6 párrafos. |
| `annex-cover()` | Portadilla de sección de Anexos | `10` | **Tipo B** | `chapter-opening()` | Señaliza la transición de la parte dispositiva a los instrumentos operativos. |
| `legal-form()` | Envoltorio para formatos de llenado y actas | `10` | **Tipo C** | Ninguno | Controla el flujo de campos de llenado, metadatos y márgenes de formularios. |
| `legal-table()` | Maquetación de tablas en formato Media Carta | `10` | **Tipo C** | Ninguno | Ajusta proporciones de 3, 4 y 5 columnas a la caja neta de $314.56\text{ pt}$. |
| `signature-block()` | Bloque unificado de rúbricas y firmas | `10` | **Tipo C** | Ninguno | Agrupa líneas de firma, cargo y nombre evitando quiebres de página huérfanos. |
| `regulation-opening()` | Apertura ceremonial de cada Reglamento | `11, 12, 13` | **Tipo B** | `chapter-opening()` | Confiere entidad ceremonial a cada reglamento sin alterar la numeración de los 9 capítulos. |
| `regulation-page()` | Página interior de articulado reglamentario | `11, 12, 13` | **Tipo B** | `interior-page()` | Utiliza la misma retícula +6 mm pero actualiza el running header con el nombre del reglamento. |
| `legal-article()` | Formato de artículo normativo independiente | `11, 12, 13` | **Tipo C** | Heading H3 | Renderiza `Artículo #.` con tipografía Minion Pro destacada sin numeración decimal forzada. |

---

## 4. ANÁLISIS DE REUTILIZACIÓN DE COMPONENTES LOCKED

Se evaluó la aplicabilidad de los 5 componentes formalmente bloqueados frente a cada uno de los 5 módulos analizados:

```text
==================================================================================================
COMPONENTE LOCKED       00_INTRODUCCIÓN   10_ANEXOS         11_ASAMBLEA       12_CONSEJO        13_COMITÉ
==================================================================================================
cover-page()            NO APLICA         NO APLICA         NO APLICA         NO APLICA         NO APLICA
table-of-contents()     NO APLICA         NO APLICA         NO APLICA         NO APLICA         NO APLICA
chapter-opening()       NO APLICA         INFRAESTRUCTURA   INFRAESTRUCTURA   INFRAESTRUCTURA   INFRAESTRUCTURA
chapter-first-page()    INFRAESTRUCTURA   NO APLICA         INFRAESTRUCTURA   INFRAESTRUCTURA   INFRAESTRUCTURA
interior-page()         DIRECTAMENTE      INFRAESTRUCTURA   INFRAESTRUCTURA   INFRAESTRUCTURA   INFRAESTRUCTURA
==================================================================================================
```

### Glosario Metodológico:
- **DIRECTAMENTE:** El componente bloqueado se utiliza tal como fue congelado, sin parámetros ni wrappers especiales.
- **INFRAESTRUCTURA:** La lógica geométrica subyacente (retícula +6 mm, márgenes 58.74/22.70 pt, tipografías Neuzeit/Minion, paridad verso/recto, folios a $591.708\text{ pt}$) se hereda como base para envoltorios nuevos sin tocar el código fuente del componente bloqueado.
- **NO APLICA:** El componente no tiene relación funcional con el módulo analizado.
