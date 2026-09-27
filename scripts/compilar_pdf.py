"""
Script para compilar el Protocolo Familiar a PDF en formato Media Carta (Half Letter: 5.5 x 8.5 in).
Utiliza el motor de renderizado de Microsoft Edge en modo headless (nativo en Windows)
sin requerir dependencias externas pesadas.
"""

import os
import sys
import subprocess
import shutil

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HTML_FILE = os.path.join(REPO_DIR, 'plantillas_pdf', 'protocolo_media_carta.html')
DEFAULT_OUTPUT = os.path.join(REPO_DIR, 'PROTOCOLO_FAMILIAR_POLIFLEX_MEDIA_CARTA.pdf')

def find_browser():
    # 1. Check Microsoft Edge
    edge_paths = [
        r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
        r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
        shutil.which("msedge")
    ]
    for p in edge_paths:
        if p and os.path.exists(p):
            return p
            
    # 2. Check Google Chrome
    chrome_paths = [
        r"C:\Program Files\Google\Chrome\Application\chrome.exe",
        r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
        shutil.which("google-chrome"),
        shutil.which("google-chrome-stable"),
        shutil.which("chromium"),
        shutil.which("chromium-browser"),
        shutil.which("chrome"),
        "/usr/bin/google-chrome",
        "/usr/bin/chromium-browser",
        "/usr/bin/chromium"
    ]
    for p in chrome_paths:
        if p and os.path.exists(p):
            return p
            
    return None

def compile_pdf(output_path=DEFAULT_OUTPUT):
    browser_exe = find_browser()
    if not browser_exe:
        print("[ERROR] No se encontró Microsoft Edge ni Google Chrome para generar el PDF.")
        print("Instale Microsoft Edge o Google Chrome, o use WeasyPrint.")
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
            print(f"[ÉXITO] PDF generado correctamente: {output_path} ({size_kb:.1f} KB)")
            return True
        else:
            print(f"[ERROR] Falló la creación del PDF: {res.stderr}")
            return False
    except Exception as e:
        print(f"[ERROR] Excepción al compilar: {e}")
        return False

if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_OUTPUT
    compile_pdf(out)
