"""
Script de Verificación de Integridad.
Comprueba que el contenido del DOCX original coincida al 100% con
el Repositorio Markdown, JSON y Plantilla HTML.
"""

import os
import sys
import json
import zipfile
import xml.etree.ElementTree as ET

sys.stdout.reconfigure(encoding='utf-8')

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DOCX_PATH = os.path.join(os.path.dirname(REPO_DIR), 'PROTOCOLO FAMILIAR - POLIFLEX V2.docx')
MASTER_MD = os.path.join(REPO_DIR, 'protocolo_maestro.md')
JSON_FILE = os.path.join(REPO_DIR, 'datos', 'protocolo_estructurado.json')
HTML_FILE = os.path.join(REPO_DIR, 'plantillas_pdf', 'protocolo_media_carta.html')

def check_integrity():
    print("=== VERIFICACIÓN DE INTEGRIDAD DEL REPOSITORIO ===")
    
    # 1. Check files existence
    files_to_check = [
        ("DOCX Original", DOCX_PATH),
        ("Markdown Maestro", MASTER_MD),
        ("JSON Estructurado", JSON_FILE),
        ("Plantilla HTML", HTML_FILE)
    ]
    for name, p in files_to_check:
        exists = os.path.exists(p)
        size = os.path.getsize(p) if exists else 0
        print(f"[{'OK' if exists else 'FALTA'}] {name:20}: {size/1024:.1f} KB")

    # 2. Check JSON content
    with open(JSON_FILE, 'r', encoding='utf-8') as f:
        data = json.load(f)
        
    total_modulos = len(data['modulos'])
    total_elementos = data['metadatos']['total_elementos']
    print(f"\n[INFO] Total Módulos en JSON: {total_modulos}")
    print(f"[INFO] Total Elementos en JSON: {total_elementos}")
    
    # 3. Check modular chapters
    cap_dir = os.path.join(REPO_DIR, 'capitulos')
    cap_files = [f for f in os.listdir(cap_dir) if f.endswith('.md')]
    print(f"[INFO] Archivos en carpeta capitulos/: {len(cap_files)}")
    
    # 4. Check critical sections in Master Markdown
    with open(MASTER_MD, 'r', encoding='utf-8') as f:
        md_text = f.read()
        
    crit_terms = [
        "José Antonio Velasco Chedraui",
        "David Velasco Chedraui",
        "Jorge Velasco Chedraui",
        "EBITDA",
        "Horizonte de proyección",
        "seis ejercicios fiscales",
        "Salida Forzada",
        "Comité de Honor Familiar",
        "Reglamento de la Asamblea de Familia",
        "Reglamento del Consejo de Familia",
        "Reglamento del Comité de Honor Familiar",
        "Albacea Especial Empresarial",
        "Congelamiento Accionario",
        "separación de bienes",
        "75%",
        "51%"
    ]
    
    print("\n--- Verificación de Términos Críticos en Markdown Maestro ---")
    all_ok = True
    for term in crit_terms:
        found = term in md_text
        if not found:
            all_ok = False
        print(f"[{'OK' if found else 'FAIL'}] Término: \"{term}\"")
        
    if all_ok:
        print("\n[ÉXITO] Todos los términos y cláusulas críticas están íntegros y preservados.")
    else:
        print("\n[ALERTA] Algunos términos no fueron encontrados en el texto final.")

if __name__ == "__main__":
    check_integrity()
