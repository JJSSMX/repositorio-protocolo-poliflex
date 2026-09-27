# ARQUITECTURA EDITORIAL — ANEXOS Y FORMATOS OPERATIVOS (FASE 4.2)
**Protocolo Familiar POLIFLEX · Instrumentación Práctica**  
**Documento Fuente:** [`capitulos/10_anexos_formatos_operativos.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/10_anexos_formatos_operativos.md)  
**Estado:** Propuesta Arquitectónica / Sin Implementación

---

## 1. Caracterización Forense de la Fuente

El archivo contiene **7 unidades documentales operativas** bajo el encabezado maestro `# Anexos y Formatos Operativos`:
1. `## AVISO DE EXCLUSIVIDAD Y PERSONALIZACIÓN` (Aviso legal y reserva de confidencialidad y autoría).
2. `## Carta de Aceptación y Adhesión al Protocolo Familiar` (Instrumento formal de adhesión individual con 5 cláusulas y bloque de firma).
3. `## Convocatoria de Asamblea de Familia` (Formato operativo con campos en blanco, orden del día de 8 puntos y firma de convocante).
4. `## Acta de Asamblea General Familiar` (Minuta solemne con tabla de asistencia de 5 columnas, 4 puntos de desarrollo, votación y tabla de firmas de mesa directiva).
5. `## Convocatoria a Sesión de Consejo de Familia` (Formato operativo con orden del día de 8 puntos y firma del Presidente del Consejo).
6. `## Acta de Sesión del Consejo de Familia` (Minuta de sesión con tabla de asistencia de 4 columnas, desarrollo, votaciones y tabla de firmas de consejeros).
7. `## Acta de Constitución y Sesión del Comité de Honor Familiar` (Minuta de órgano disciplinario con tabla de integrantes de 3 columnas, descripción, checklist de 5 documentos recibidos, 9 puntos de procedimiento y tabla de firmas).

### Diagnóstico de Clasificación Canónica
**¿Cómo deben entenderse estas 7 unidades?**
- **Dictamen:** Son **Formatos Operativos e Instrumentos Jurídicos Autónomos** agrupados dentro de la sección maestra `ANEXOS`.
- *Fundamentación:* La unidad 1 es un *aviso institucional*; la unidad 2 es un *contrato de adhesión*; las unidades 3 y 5 son *cédulas de convocatoria*; y las unidades 4, 6 y 7 son *actas notariales/corporativas*. Cada una posee una finalidad práctica independiente y está diseñada para ser completada, firmada y archivada por separado en la vida societaria. Por tanto, editorialmente no pueden tratarse como un texto fluido continuo, sino como **piezas documentales independientes que deben iniciar siempre en nueva página**.

---

## 2. Requerimientos de Funcionalidad Operativa

A diferencia del cuerpo doctrinal del Protocolo (Capítulos 01–09), los Formatos Operativos deben cumplir una doble exigencia:
1. **Legibilidad Integrada:** Leerse con armonía y prestancia dentro del volumen encuadernado.
2. **Capacidad Funcional de Escritura:** Espacio físico real para captura manual o mecanográfica de nombres, fechas, porcentajes y firmas sin que los renglones queden reducidos a trazos minúsculos.
3. **Identidad Institucional:** Mantener la tipografía Neuzeit/Minion, paleta POLIFLEX y filetes corporativos sin comprometer la ergonomía del formulario.

---

## 3. Catálogo y Modelo Semántico de Formularios

Para transformar el Markdown canónico en una composición editorial estructurada, se define el siguiente catálogo semántico:

| Elemento Semántico | Representación Actual en Markdown | Función Operativa | Comportamiento Deseado | ¿Divisible entre Páginas? |
| :--- | :--- | :--- | :--- | :---: |
| **`FIELD / LEGAL-LINE`** | Renglones de guiones bajos (`___...___`) | Línea de captura para nombres, fechas, horas o lugares. | Línea de llenado tipográfica (baseline rule) con altura de renglón suficiente (18–22 pt) para caligrafía humana. | **NO** (Línea atómica) |
| **`CHECKBOX`** | Carácter Unicode (`☐`) | Casilla de verificación binaria (Aprobado/No aprobado; Sí/No). | Cuadro vectorial delimitado (8×8 pt), perfectamente centrado verticalmente con la etiqueta tipográfica. | **NO** (Atómico con su etiqueta) |
| **`LEGAL-TABLE`** | Sintaxis de tabla Markdown (`\| Col \| Col \|`) | Registro tabular de asistentes, acciones, cargos y firmas. | Tabla institucional con encabezado gris neutro (`#f1f5f9`), filete sutil (`#cbd5e1`), padding generoso de celda (6 pt) para firma. | **NO** para tablas pequeñas ($\le 5$ filas); **SÍ** para tablas extensas con repetición de encabezado. |
| **`SIGNATURE-BLOCK`** | Línea de guión bajo + Nombre/Cargo (`C. ___...`) | Bloque formal de rúbrica individual. | Espacio de rúbrica (40–50 pt de alto) + línea de firma (135–180 pt de ancho) + Nombre y Cargo centrados. | **NO** (Bloque 100% indivisible; protección anti-huérfana estricta) |
| **`TEXTAREA`** | Líneas de guiones múltiples (`(Naturaleza...)\n___`) | Área de descripción extendida de controversias o hechos. | Caja delimitada con pauta lineal o retícula sutil de captura para escritura de párrafos. | **SÍ** (Permite salto si mantiene mínimo 3 renglones por página) |
| **`VOTING-BLOCK`** | Casillas emparejadas (`☐ Aprobado  ☐ No aprobado`) | Asentamiento formal del sentido del acuerdo colegiado. | Bloque agrupado horizontalmente con espaciado equilibrado y caja protectora. | **NO** (Indivisible) |

---

## 4. Auditoría Forense de las Seis Tablas Operativas

Todas las tablas deben convivir en la caja útil interior aprobada de **314.56 pt** ($396\text{ pt ancho} - 58.74\text{ pt lomo} - 22.70\text{ pt corte}$).

| Tabla | Ubicación | Columnas Canónicas | Filas | Propósito y Contenido | Anchura Relativa Sugerida en 314.56 pt | Riesgo en Media Carta Vertical | ¿Requiere Landscape? |
| :--- | :---: | :--- | :---: | :--- | :--- | :---: | :---: |
| **Tabla 1** | L126 (Acta Asamblea) | 5: `Nombre`, `Rama Familiar`, `% Capital`, `Acreditación`, `Firma` | 4 | Lista de asistencia y verificación de capital y legitimación. | • Nombre: 95 pt<br>• Rama: 60 pt<br>• % Capital: 45 pt<br>• Acreditación: 55 pt<br>• Firma: 59.56 pt | **Moderado.** 5 columnas en 314.56 pt es el límite de compresión. Requiere tipografía compacta (8 pt) y padding horizontal de 3 pt. | **NO.** Cabe perfectamente en vertical sin forzar rotación. |
| **Tabla 2** | L165 (Acta Asamblea) | 4: `Nombre`, `Rama`, `Cargo / Calidad`, `Firma` | 3 | Firmas de clausura de la Mesa Directiva de la Asamblea. | • Nombre: 95 pt<br>• Rama: 65 pt<br>• Cargo: 75 pt<br>• Firma: 79.56 pt | **Bajo.** 4 columnas amplias y confortables. | **NO.** |
| **Tabla 3** | L219 (Acta Consejo) | 4: `Nombre`, `Rama Familiar`, `Cargo en el Consejo`, `Firma` | 3 | Asistencia de consejeros a sesión. | • Nombre: 95 pt<br>• Rama: 65 pt<br>• Cargo: 75 pt<br>• Firma: 79.56 pt | **Bajo.** Idéntica ergonomía a Tabla 2. | **NO.** |
| **Tabla 4** | L257 (Acta Consejo) | 3: `Nombre`, `Cargo`, `Firma` | 4 | Clausura y firmas de consejeros. | • Nombre: 110 pt<br>• Cargo: 85 pt<br>• Firma: 119.56 pt | **Nulo.** Formato sumamente espacioso. | **NO.** |
| **Tabla 5** | L273 (Acta Comité) | 3: `Nombre`, `Carácter`, `Firma de Aceptación` | 3 | Aceptación de designación de miembros del Comité de Honor. | • Nombre: 110 pt<br>• Carácter: 85 pt<br>• Firma: 119.56 pt | **Nulo.** Gran comodidad de captura. | **NO.** |
| **Tabla 6** | L323 (Acta Comité) | 3: `Nombre`, `Cargo en el Comité`, `Firma` | 3 | Clausura y firmas definitivas de resolución del Comité de Honor. | • Nombre: 110 pt<br>• Cargo: 85 pt<br>• Firma: 119.56 pt | **Nulo.** Gran comodidad de captura. | **NO.** |

*Conclusión sobre Orientación:* **Las 6 tablas caben de manera óptima en orientación vertical (Media Carta portrait)**. Ninguna tabla excede las 5 columnas ni contiene cadenas kilométricas. La rotación a Landscape queda **totalmente descartada**, preservando la integridad del volumen encuadernado.

---

## 5. Arquitectura de Bloques de Firma

Se identifican dos tipologías de firma en las 7 unidades:

### Tipología 1: Firmas Unipersonales / Individuales (Líneas de Firma)
- **Unidad 2 (Carta de Adhesión):** 1 firma individual (Adherente familiar).
- **Unidad 3 (Convocatoria Asamblea):** 1 firma individual (Convocante).
- **Unidad 5 (Convocatoria Consejo):** 1 firma individual (Presidente del Consejo).
- **Regla Arquitectónica:**
  - El bloque completo (`Atentamente` + línea `___` + Nombre + Cargo) debe tener la propiedad `breakable: false` (`keep-together: true`).
  - Nunca debe permitirse que la palabra "Atentamente" quede al final de una página y la línea de firma pase a la siguiente.
  - El bloque de firma debe requerir obligatoriamente que al menos el párrafo anterior (o mínimo 2 líneas del texto final) lo acompañen en la misma página para evitar una "página de sola firma".

### Tipología 2: Tablas de Firmas Colegiadas
- **Unidad 4 (Asamblea):** Tabla 2 (3 integrantes de mesa).
- **Unidad 6 (Consejo):** Tabla 4 (4 consejeros).
- **Unidad 7 (Comité de Honor):** Tabla 5 (3 integrantes) y Tabla 6 (3 integrantes).
- **Regla Arquitectónica:**
  - Las tablas de firma son atómicas e indivisibles.
  - Cada fila debe ofrecer una altura vertical útil de mínimo 28–35 pt para permitir la rúbrica manual holgada sin invadir el texto colindante.

---

## 6. Alternativas Arquitectónicas para Anexos y Formatos

### Alternativa A: "Sección con Portadilla General y Formatos con Inicio en Nueva Página" (Recomendada)
- **Concepto:** Una macro-portadilla para el módulo ("MÓDULO DE ANEXOS Y FORMATOS OPERATIVOS") en Recto + Verso blanco. A continuación, cada una de las 7 unidades inicia obligatoriamente en **página nueva** (Recto o Verso, según fluya), tratada con un encabezado de formato institucional y numeración propia (ej. "FORMATO ANEXO 1", "FORMATO ANEXO 2").
- **Ventajas:** Cada formato se puede imprimir o fotocopiar de forma aislada para uso operativo sin cortar ni arrastrar fragmentos de otros formatos. Máxima utilidad práctica y rigor corporativo.
- **Riesgos:** Requiere cuidar la densidad interna de cada formato para que cierren limpiamente en páginas enteras (1 o 2 páginas por formato).
- **Consistencia POLIFLEX:** 100% óptima.
- **Complejidad:** Media.

### Alternativa B: "Flujo Continuo sin Salto Forzado de Página por Formato"
- **Concepto:** Los formatos corren uno detrás de otro de forma continua, separados únicamente por un espacio vertical y un filete.
- **Ventajas:** Menor número total de páginas.
- **Riesgos:** Catastrófico operativamente: una convocatoria podría empezar al fondo de una página donde terminó un acta anterior; inutilizable para impresión o llenado individual.
- **Consistencia POLIFLEX:** Inaceptable para un estándar corporativo de gobernanza familiar.
- **Complejidad:** Baja.

### Alternativa C: "Formatos Forzados Exclusivamente a Inicios en Recto (Página Impar)"
- **Concepto:** Cada uno de los 7 formatos debe nacer obligatoriamente en página RECTO. Si el formato anterior termina en Recto, se genera un verso blanco obligatorio.
- **Ventajas:** Máxima solemnidad y uniformidad de apertura.
- **Riesgos:** Inflación innecesaria de páginas blancas si los formatos tienen 1 sola página.
- **Consistencia POLIFLEX:** Media.
- **Complejidad:** Media.

---

## 7. Síntesis y Recomendación Técnica
La **Alternativa A (Macro-portadilla de módulo + Formatos con inicio en nueva página, ajustados a 1 o 2 páginas autocontenidas)** representa el equilibrio perfecto entre elegancia editorial, funcionalidad práctica y respeto por la economía de páginas del libro maestro.
