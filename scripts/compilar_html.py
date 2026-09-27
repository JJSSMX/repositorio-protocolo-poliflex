"""
MOTOR EDITORIAL ALTERNATIVO: CHROMIUM / EDGE HEADLESS
Compila las plantillas templates/html a PDF tamaño Media Carta.
"""

import os
import sys
import subprocess
import shutil

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HTML_FILE = os.path.join(REPO_DIR, 'templates', 'html', 'protocolo_media_carta.html')
DIST_PDF = os.path.join(REPO_DIR, 'dist', 'PROTOCOLO_FAMILIAR_POLIFLEX_CHROMIUM.pdf')

def find_browser():
    edge_paths = [
        r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
        r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
        shutil.which("msedge")
    ]
    for p in edge_paths:
        if p and os.path.exists(p):
            return p
            
    chrome_paths = [
        r"C:\Program Files\Google\Chrome\Application\chrome.exe",
        r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
        shutil.which("chrome")
    ]
    for p in chrome_paths:
        if p and os.path.exists(p):
            return p
            
    return None

def compile_html(output_path=DIST_PDF):
    browser_exe = find_browser()
    if not browser_exe:
        print("[ERROR] No se encontró Microsoft Edge ni Google Chrome.")
        return False
        
    print(f"[INFO] Motor de renderizado: {browser_exe}")
    print(f"[INFO] Leyendo plantilla: {HTML_FILE}")
    print(f"[INFO] Generando PDF en: {output_path}")
    
    file_url = "file:///" + HTML_FILE.replace('\\', '/')
    
    cmd = [
        browser_exe,
        "--headless",
        "--disable-gpu",
        "--no-pdf-header-footer",
        f"--print-to-pdf={output_path}",
        file_url
    ]
    
    try:
        res = subprocess.run(cmd, capture_output=True, text=True, timeout=60)
        if os.path.exists(output_path) and os.path.getsize(output_path) > 1000:
            size_kb = os.path.getsize(output_path) / 1024
            print(f"[ÉXITO] PDF Chromium generado: {output_path} ({size_kb:.1f} KB)")
            return True
        else:
            print(f"[ERROR] Falló la creación del PDF: {res.stderr}")
            return False
    except Exception as e:
        print(f"[ERROR] Excepción al compilar: {e}")
        return False

if __name__ == "__main__":
    compile_html()
