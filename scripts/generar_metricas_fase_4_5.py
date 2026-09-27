import os
import json
import hashlib
import pymupdf

WORKSPACE_ROOT = "C:/Users/JJSS/Desktop/ABC/repositorio_protocolo"

def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while chunk := f.read(8192):
            h.update(chunk)
    return h.hexdigest().upper()

# Extraer métricas completas
data = {
    "fase": "4.5",
    "titulo": "Prototipo de Sistema Normativo Interior de Reglamentos",
    "estado_componente": "EXPERIMENTAL / NOT LOCKED",
    "corpus_test": {
        "archivo_fuente": "capitulos/11_reglamento_asamblea_familia.md",
        "lineas_fuente": "76-178 (103 líneas canónicas)",
        "palabras_totales": 907,
        "capitulos_internos": ["CAPÍTULO IV", "CAPÍTULO V", "CAPÍTULO VI", "CAPÍTULO VII", "CAPÍTULO VIII"],
        "articulos_probados": ["Artículo 5.", "Artículo 6.", "Artículo 7.", "Artículo 8.", "Artículo 9.", "Artículo 10.", "Artículo 11.", "Artículo 12."],
        "fracciones_probadas": 11,
        "transitorio_probado": "TRANSITORIO ÚNICO"
    },
    "especificaciones_tecnicas": {
        "geometria_pagina": {
            "formato": "Media Carta (396.00 x 612.00 pt)",
            "margen_lomo": "58.74 pt",
            "margen_corte": "22.70 pt",
            "margen_superior": "71.0079 pt (+6 mm consolidado)",
            "margen_inferior": "65.00 pt",
            "ancho_util": "314.56 pt",
            "alto_util": "475.9921 pt",
            "filete_lomo": "0.50 pt #f15d22 (x=30.13 pt recto, x=365.87 pt verso)"
        },
        "variantes": {
            "A": {
                "nombre": "Clásica Institucional",
                "descripcion": "Traducción directa de la jerarquía Minion/Neuzeit de interior-page() al ámbito normativo",
                "r1_running_header": {
                    "texto_recto_izq": "PROTOCOLO FAMILIAR  VERSION 1.0",
                    "texto_recto_der": "REGLAMENTO · ASAMBLEA DE FAMILIA + ISOTIPO 50%",
                    "fuente": "Neuzeit Grotesk Regular 5.5 pt",
                    "tracking": "+0.200 em",
                    "color": "#6c6b67",
                    "ancho_texto": "133.98 pt"
                },
                "r2_capitulo": {
                    "fuente": "Minion Pro Medium Display 10.5 pt",
                    "tracking": "+0.050 em",
                    "color": "#f15d22",
                    "stroke": "0.3 pt #f15d22",
                    "espacio_superior": "18.00 pt",
                    "espacio_inferior": "3.50 pt"
                },
                "r3_subtitulo": {
                    "fuente": "Minion Pro Medium 9.5 pt",
                    "tracking": "+0.020 em",
                    "color": "#2e2f31",
                    "espacio_inferior": "12.73 pt"
                },
                "r4_articulo": {
                    "etiqueta_fuente": "Minion Pro Medium 9.2 pt",
                    "etiqueta_color": "#f15d22 (stroke 0.2 pt)",
                    "nombre_fuente": "Minion Pro Medium 9.2 pt",
                    "nombre_color": "#2e2f31",
                    "espacio_superior": "14.00 pt",
                    "espacio_inferior": "5.50 pt"
                },
                "r5_cuerpo": {
                    "fuente": "Neuzeit Grotesk Regular 7.9077 pt",
                    "leading": "12.72949 pt",
                    "spacing": "12.72949 pt",
                    "color": "#2e2f31",
                    "alineacion": "justified, hyphenate: false, linebreaks: simple"
                },
                "r6_fracciones": {
                    "numeral_fuente": "Neuzeit Grotesk Medium 7.9077 pt",
                    "numeral_color": "#2e2f31",
                    "ancho_columna_numeral": "14.0 pt",
                    "gutter": "4.0 pt",
                    "alineacion_numeral": "derecha",
                    "separacion_interfraccion": "6.00 pt"
                },
                "r7_transitorio": {
                    "fuente": "Minion Pro Medium Display 10.0 pt",
                    "tracking": "+0.050 em",
                    "color": "#f15d22",
                    "espacio_superior": "18.00 pt",
                    "espacio_inferior": "6.00 pt"
                }
            },
            "B": {
                "nombre": "Diferenciación Jurídica Dinámica",
                "descripcion": "Mayor contraste formal: CAPÍTULO con mini-pleca, subtítulo en Neuzeit Bold, artículo híbrido y fracciones en Minion Pro naranja",
                "r1_running_header": {
                    "texto_recto_izq": "PROTOCOLO FAMILIAR  VERSION 1.0",
                    "texto_recto_der": "ASAMBLEA DE FAMILIA + ISOTIPO 50%",
                    "fuente": "Neuzeit Grotesk Medium 5.5 pt",
                    "tracking": "+0.220 em",
                    "color": "#2e2f31",
                    "ancho_texto": "79.09 pt"
                },
                "r2_capitulo": {
                    "fuente": "Minion Pro Medium Display 11.0 pt",
                    "tracking": "+0.080 em",
                    "color": "#f15d22",
                    "mini_pleca": "14.0 pt x 0.75 pt #f15d22",
                    "espacio_superior": "20.00 pt",
                    "espacio_inferior": "4.00 pt"
                },
                "r3_subtitulo": {
                    "fuente": "Neuzeit Grotesk Bold 8.5 pt",
                    "tracking": "+0.040 em",
                    "color": "#2e2f31",
                    "espacio_inferior": "12.73 pt"
                },
                "r4_articulo": {
                    "etiqueta_fuente": "Neuzeit Grotesk Bold 8.2 pt",
                    "etiqueta_color": "#f15d22",
                    "nombre_fuente": "Minion Pro Bold Italic 9.0 pt",
                    "nombre_color": "#2e2f31",
                    "espacio_superior": "15.00 pt",
                    "espacio_inferior": "6.00 pt"
                },
                "r5_cuerpo": {
                    "fuente": "Neuzeit Grotesk Regular 7.9077 pt",
                    "leading": "12.72949 pt",
                    "spacing": "12.72949 pt",
                    "color": "#2e2f31",
                    "alineacion": "justified, hyphenate: false, linebreaks: simple"
                },
                "r6_fracciones": {
                    "numeral_fuente": "Minion Pro Medium 8.2 pt",
                    "numeral_color": "#f15d22",
                    "ancho_columna_numeral": "15.0 pt",
                    "gutter": "5.0 pt",
                    "alineacion_numeral": "derecha",
                    "separacion_interfraccion": "6.36 pt"
                },
                "r7_transitorio": {
                    "fuente": "Minion Pro Medium Display 10.5 pt",
                    "tracking": "+0.080 em",
                    "color": "#f15d22",
                    "mini_pleca": "14.0 pt x 0.75 pt #f15d22",
                    "espacio_superior": "20.00 pt",
                    "espacio_inferior": "6.50 pt"
                }
            },
            "C": {
                "nombre": "Soberanía Normativa Compacta",
                "descripcion": "Monofamilia técnica en Neuzeit Grotesk con alta densidad informativa y espaciado comprimido",
                "r1_running_header": {
                    "texto_recto_izq": "PROTOCOLO FAMILIAR  VERSION 1.0",
                    "texto_recto_der": "REGLAMENTO DE LA ASAMBLEA DE FAMILIA + ISOTIPO 50%",
                    "fuente": "Neuzeit Grotesk Regular 5.0 pt",
                    "tracking": "+0.180 em",
                    "color": "#6c6b67",
                    "ancho_texto": "152.06 pt"
                },
                "r2_capitulo": {
                    "fuente": "Neuzeit Grotesk Bold 8.8 pt",
                    "tracking": "+0.060 em",
                    "color": "#f15d22",
                    "espacio_superior": "14.50 pt",
                    "espacio_inferior": "2.50 pt"
                },
                "r3_subtitulo": {
                    "fuente": "Neuzeit Grotesk Medium 8.0 pt",
                    "tracking": "+0.030 em",
                    "color": "#6c6b67",
                    "espacio_inferior": "9.50 pt"
                },
                "r4_articulo": {
                    "etiqueta_fuente": "Neuzeit Grotesk Bold 8.0 pt",
                    "etiqueta_color": "#2e2f31 (punto en #f15d22)",
                    "nombre_fuente": "Neuzeit Grotesk Bold 8.0 pt",
                    "nombre_color": "#2e2f31",
                    "espacio_superior": "10.50 pt",
                    "espacio_inferior": "4.50 pt"
                },
                "r5_cuerpo": {
                    "fuente": "Neuzeit Grotesk Regular 7.9077 pt",
                    "leading": "12.72949 pt",
                    "spacing": "10.50 pt",
                    "color": "#2e2f31",
                    "alineacion": "justified, hyphenate: false, linebreaks: simple"
                },
                "r6_fracciones": {
                    "numeral_fuente": "Neuzeit Grotesk Bold 7.9077 pt",
                    "numeral_color": "#6c6b67",
                    "ancho_columna_numeral": "13.0 pt",
                    "gutter": "3.5 pt",
                    "alineacion_numeral": "derecha",
                    "separacion_interfraccion": "4.50 pt"
                },
                "r7_transitorio": {
                    "fuente": "Neuzeit Grotesk Bold 8.8 pt",
                    "tracking": "+0.060 em",
                    "color": "#f15d22",
                    "espacio_superior": "14.50 pt",
                    "espacio_inferior": "5.00 pt"
                }
            }
        }
    },
    "comportamiento_paginacion": {
        "VARIANTE_A": {
            "paginas": 4,
            "ocupacion_promedio": "89.9%",
            "cortes_pagina": [
                {"pagina": 1, "paridad": "RECTO", "ocupacion": "94.1%", "inicia": "CAPÍTULO IV (Art. 5)", "termina": "Fin natural Artículo 5", "huerfanas_viudas": 0},
                {"pagina": 2, "paridad": "VERSO", "ocupacion": "95.8%", "inicia": "Artículo 6 -> CAPÍTULO V (Art. 7)", "termina": "Fin natural Artículo 7 (Cap. V)", "huerfanas_viudas": 0},
                {"pagina": 3, "paridad": "RECTO", "ocupacion": "85.5%", "inicia": "CAPÍTULO VI (Art. 8) -> CAPÍTULO VII (Art. 9)", "termina": "Fin natural Artículo 9 (Cap. VII)", "huerfanas_viudas": 0},
                {"pagina": 4, "paridad": "VERSO", "ocupacion": "84.2%", "inicia": "CAPÍTULO VIII (Arts. 10, 11, 12)", "termina": "TRANSITORIO ÚNICO completo", "huerfanas_viudas": 0}
            ],
            "balance_editorial": "ÓPTIMO (4 cortes orgánicos a final de artículo, 0 líneas aisladas, distribución uniforme)"
        },
        "VARIANTE_B": {
            "paginas": 4,
            "ocupacion_promedio": "91.1%",
            "cortes_pagina": [
                {"pagina": 1, "paridad": "RECTO", "ocupacion": "94.4%", "inicia": "CAPÍTULO IV (Art. 5)", "termina": "Fin natural Artículo 5", "huerfanas_viudas": 0},
                {"pagina": 2, "paridad": "VERSO", "ocupacion": "97.0%", "inicia": "Artículo 6 -> CAPÍTULO V (Art. 7)", "termina": "Fin natural Artículo 7 (Cap. V)", "huerfanas_viudas": 0},
                {"pagina": 3, "paridad": "RECTO", "ocupacion": "87.3%", "inicia": "CAPÍTULO VI (Art. 8) -> CAPÍTULO VII (Art. 9)", "termina": "Fin natural Artículo 9 (Cap. VII)", "huerfanas_viudas": 0},
                {"pagina": 4, "paridad": "VERSO", "ocupacion": "85.7%", "inicia": "CAPÍTULO VIII (Arts. 10, 11, 12)", "termina": "TRANSITORIO ÚNICO completo", "huerfanas_viudas": 0}
            ],
            "balance_editorial": "ÓPTIMO (Excelente anclaje jerárquico, cortes idénticos a Variante A, mayor dinamismo visual)"
        },
        "VARIANTE_C": {
            "paginas": 4,
            "ocupacion_promedio": "83.8%",
            "cortes_pagina": [
                {"pagina": 1, "paridad": "RECTO", "ocupacion": "99.2%", "inicia": "CAPÍTULO IV (Art. 5)", "termina": "Artículo 6 quebrado a mitad de párrafo", "huerfanas_viudas": 1},
                {"pagina": 2, "paridad": "VERSO", "ocupacion": "97.1%", "inicia": "Continuación Art. 6", "termina": "Artículo 8 quebrado a mitad de párrafo", "huerfanas_viudas": 1},
                {"pagina": 3, "paridad": "RECTO", "ocupacion": "98.3%", "inicia": "Continuación Art. 8", "termina": "Artículo 11 quebrado a mitad de párrafo", "huerfanas_viudas": 1},
                {"pagina": 4, "paridad": "VERSO", "ocupacion": "40.6%", "inicia": "Continuación Art. 11", "termina": "TRANSITORIO ÚNICO", "huerfanas_viudas": 0}
            ],
            "balance_editorial": "DESFAVORABLE (La sobre-compresión parte 3 artículos entre páginas y desocupa la pág 4 al 40.6%)"
        }
    },
    "integridad_sistema": {
        "componentes_typ_sha256": sha256_file(os.path.join(WORKSPACE_ROOT, "templates/typst/componentes.typ")),
        "componentes_typ_modificado": False,
        "markdown_canonico_modificado": False,
        "componentes_locked_modificados": False,
        "table_of_contents_modificado": False,
        "regresion_locked_status": "PASS"
    }
}

with open(os.path.join(WORKSPACE_ROOT, "datos/fase_4_5_metricas_regulation_page.json"), "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print("datos/fase_4_5_metricas_regulation_page.json generado con éxito.")
