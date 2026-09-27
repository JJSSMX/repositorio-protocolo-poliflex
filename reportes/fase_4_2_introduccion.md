# ARQUITECTURA EDITORIAL — INTRODUCCIÓN (FASE 4.2)
**Protocolo Familiar POLIFLEX · Familia Velasco Chedraui**  
**Documento Fuente:** [`capitulos/00_introduccion.md`](file:///C:/Users/JJSS/Desktop/ABC/repositorio_protocolo/capitulos/00_introduccion.md)  
**Estado:** Propuesta Arquitectónica / Sin Implementación

---

## 1. Caracterización Forense de la Fuente

- **Extensión:** 305 palabras.
- **Estructura:** 6 párrafos continuos de prosa solemne.
- **Jerarquía:** Un encabezado de primer nivel (`# Introducción`) y ningún subtítulo ni sección subordinada.
- **Naturaleza Ortotipográfica:** Sin articulado, sin fracciones, sin numeración decimal, sin viñetas ni cuadros.
- **Tono Editorial:** Solemne, institucional, fundacional, declarativo. Actúa como el preámbulo ético y político del pacto intergeneracional de la Familia Velasco Chedraui.

---

## 2. Definición Arquitectónica

### A. Función Editorial dentro de la Obra
La Introducción no es una parte normativa ni un manual operativo; es el **Manifiesto Institucional de Origen**. Expresa la voluntad unánime de los fundadores y sucesores de someter la relación familia–empresa–patrimonio a un orden de gobierno corporativo. Editorialmente, debe situar al lector en un plano de serenidad, compromiso y solemnidad previo a la densidad regulatoria del Capítulo 01.

### B. Posición Lógica en el Documento
1. **Portada General** (`cover-page()`, p. 1).
2. **Página de Guarda / Créditos Institucionales** (p. 2, verso).
3. **Tabla de Contenido** (`table-of-contents()`, p. 3, recto).
4. **Página Blanca Ceremonial de Respeto** (p. 4, verso).
5. **INTRODUCCIÓN** (p. 5, recto).
6. **Capítulo 01: Declaración de Principios** (apertura ceremonial en nueva página impar).

*Fundamento:* La Introducción pertenece a los **Preliminares Nobles** de la obra. Debe leerse inmediatamente después de visualizar el mapa de la obra (TOC) y antes de abordar las cláusulas dispositivas del cuerpo principal.

### C. Necesidad de Portadilla Ceremonial
- **Evaluación:** Una portadilla ceremonial de tipo `chapter-opening()` (con fondo blanco, arco y número gigante) resultaría desproporcionada y confusa para un texto de apenas 305 palabras, ya que la Introducción no tiene un número ordinal ("Capítulo 00" desvirtuaría su carácter solemne).
- **Criterio Arquitectónico:** No requiere portadilla ceremonial de 2 páginas con pliego previo. Requiere una **Apertura de Texto Noble en Recto**, tratada con dignidad monumental pero sin generar inflación de páginas blancas vacías.

### D. Comportamiento Recto / Verso
- Debe nacer obligatoriamente en página **RECTO** (página impar, derecha del pliego).
- Al tener 305 palabras, su composición en cuerpo tipográfico institucional (Minion Pro 10.5 pt / interlínea 14.5 pt) ocupa exactamente entre 24 y 28 líneas.
- Dado que la caja útil de Media Carta (5.5 × 8.5 in) permite entre 30 y 32 líneas con respiración holgada, el texto completo de la Introducción **cabe de manera natural y perfecta en UNA SOLA PÁGINA RECTO**.
- El verso subsiguiente (página par) queda en blanco como página de transición antes de la apertura del Capítulo 01, o bien el Capítulo 01 inicia directamente en el siguiente recto disponible.

### E. Relación Visual con Componentes Existentes (LOCKED)
- **Tipografía:** Título en `Neuzeit Grotesk` (o `Minion Pro Display` institucional), cuerpo en `Minion Pro Regular`, tracking institucional calibrado.
- **Herencia Gráfica:** Filete institucional naranja (`#f04e23`) como rúbrica superior o inferior del encabezado, preservando el ADN visual de POLIFLEX.
- **Running Header y Folio:** En su página de inicio no lleva running header (respetando la regla editorial de no ensuciar páginas de apertura), pero sí lleva folio exterior sutil.

### F. Tratamiento del Título
El rótulo no debe ser un encabezado H1 ordinario de texto corriente. Se propone un tratamiento en versalitas o caja alta espaciada:
- Prefijo sutil: `PROTOCOLO FAMILIAR · PREÁMBULO`
- Título principal: `INTRODUCCIÓN`
- Filete horizontal naranja calibrado (ancho 28 pt, grosor 1 pt).

### G. Tratamiento del Bloque de Seis Párrafos
- **Párrafo 1 (Apertura):** Párrafo de entrada destacado (Lead Paragraph), con cuerpo ligeramente mayor (+0.5 pt o interlínea +1 pt) o capitular sutil, para marcar el inicio solemne de la lectura.
- **Párrafos 2 a 5:** Prosa fluida, justificada con rigor tipográfico, sangría ceremonial de primera línea o separación limpia de 4–6 pt entre párrafos.
- **Párrafo 6 (Cierre):** Párrafo conclusivo que condensa la responsabilidad de la familia hacia el futuro.

---

## 3. Alternativas Arquitectónicas para la Introducción

### Alternativa A: "Página Noble Unitaria" (Recomendada)
- **Concepto:** La Introducción se compone íntegramente en una sola página RECTO (página 5). Encabezado noble en el tercio superior, los 6 párrafos ocupan los dos tercios inferiores con respiración generosa. Verso posterior en blanco como umbral solemne antes del Capítulo 01.
- **Ventajas:** Máxima elegancia, concisión, evita fraccionar un texto breve, cero riesgo de huérfanas, lectura completa de un solo vistazo.
- **Riesgos:** Requiere calibrar con precisión el interlineado y márgenes para que no se perciba ni apretado ni desierto.
- **Consistencia POLIFLEX:** 100% coherente con la filosofía de elegancia corporativa.
- **Complejidad de Implementación:** Baja.

### Alternativa B: "Pliego Ceremonial Extendido (Díptico)"
- **Concepto:** La Introducción se despliega en dos páginas enfrentadas (Verso y Recto). En la página izquierda (Verso) se ubica el título monumental, el prefijo institucional y los 2 primeros párrafos; en la página derecha (Recto) se ubican los 4 párrafos restantes y un cierre gráfico institucional.
- **Ventajas:** Crea un ritmo pausado de gran monumentalidad.
- **Riesgos:** 305 palabras distribuidas en dos páginas pueden dar sensación de dispersión o vacío ("aire excesivo") en un formato compacto Media Carta.
- **Consistencia POLIFLEX:** Media.
- **Complejidad de Implementación:** Media-Alta.

### Alternativa C: "Apertura Integrada sin Verso Blanco Posterior"
- **Concepto:** La Introducción ocupa el Recto; inmediatamente en el Verso posterior comienza la portadilla del Capítulo 01 (o su pliego de apertura).
- **Ventajas:** Optimiza el número total de páginas reduciendo blancos.
- **Riesgos:** Quita solemnidad a la entrada del Capítulo 01; rompe la regla de que los capítulos principales abren en pliego noble con portadilla en Recto.
- **Consistencia POLIFLEX:** Baja.
- **Complejidad de Implementación:** Baja.

---

## 4. Síntesis y Recomendación Técnica
La **Alternativa A (Página Noble Unitaria en Recto con Verso Blanco Posterior)** es la solución que maximiza la jerarquía ceremonial de la Familia Velasco Chedraui, mantiene la disciplina tipográfica y respeta la proporción texto/espacio en el formato Media Carta.
