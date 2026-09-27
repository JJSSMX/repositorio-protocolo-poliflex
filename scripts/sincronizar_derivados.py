"""
SCRIPT DE SINCRONIZACIÓN DE ARCHIVOS DERIVADOS.
Lee la fuente canónica /capitulos/*.md y actualiza todas las representaciones derivadas:
- dist/protocolo_maestro.md
- dist/protocolo_estructurado.json
- templates/html/protocolo_media_carta.html
"""

import os
import sys
import re
import json
import yaml

sys.stdout.reconfigure(encoding='utf-8')

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP_DIR = os.path.join(REPO_DIR, 'capitulos')
CONFIG_FILE = os.path.join(REPO_DIR, 'config', 'editorial_config.yaml')
DIST_DIR = os.path.join(REPO_DIR, 'dist')
DATOS_DIR = os.path.join(REPO_DIR, 'datos')
TEMPLATES_HTML_DIR = os.path.join(REPO_DIR, 'templates', 'html')

os.makedirs(DIST_DIR, exist_ok=True)
os.makedirs(DATOS_DIR, exist_ok=True)

def sync_derived():
    print("[INFO] Sincronizando representaciones derivadas desde /capitulos/*.md ...")
    
    with open(CONFIG_FILE, 'r', encoding='utf-8') as f:
        cfg = yaml.safe_load(f)
    meta = cfg['metadata']
    
    chapter_files = sorted([f for f in os.listdir(CAP_DIR) if f.endswith('.md')])
    
    master_lines = [
        "---",
        f"title: \"{meta['title'].upper()}\"",
        f"company: \"{meta['company']}\"",
        f"brand: \"{meta['brand']}\"",
        f"family: \"{meta['family']}\"",
        f"version: \"{meta['version']}\"",
        f"date: \"{meta['date']}\"",
        f"location: \"{meta['location']}\"",
        "derived_from: \"/capitulos/*.md\"",
        "---\n",
        f"# {meta['title'].upper()}",
        f"## {meta['company']} ({meta['brand']})",
        f"### {meta['family']}",
        f"**{meta['location']} — {meta['date']}**\n",
        "---\n"
    ]
    
    json_modules = []
    html_sections = []
    
    for cfile in chapter_files:
        cpath = os.path.join(CAP_DIR, cfile)
        with open(cpath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            
        frontmatter = {}
        in_fm = False
        fm_lines = []
        body_lines = []
        for line in lines:
            if line.strip() == '---':
                in_fm = not in_fm
                continue
            if in_fm:
                fm_lines.append(line)
            else:
                body_lines.append(line)
                
        if fm_lines:
            try:
                frontmatter = yaml.safe_load(''.join(fm_lines)) or {}
            except Exception:
                pass
                
        module_title = frontmatter.get('title', cfile)
        master_lines.append(f"\n<!-- MÓDULO CANÓNICO: {cfile} -->\n")
        master_lines.append(''.join(body_lines).strip() + "\n")
        
        # Parse body for JSON and HTML
        mod_elements = []
        html_sec_lines = [f"  <!-- {module_title} -->", f"  <section class=\"capitulo-seccion\" id=\"{cfile.replace('.md', '')}\">"]
        
        for bl in body_lines:
            sbl = bl.strip()
            if not sbl:
                continue
                
            el_type = 'paragraph'
            lvl = None
            if sbl.startswith('# '):
                el_type = 'heading'
                lvl = 1
                html_sec_lines.append(f"    <div class=\"capitulo-header\"><h1 class=\"capitulo-titulo\">{sbl[2:]}</h1></div>")
            elif sbl.startswith('## '):
                el_type = 'heading'
                lvl = 2
                html_sec_lines.append(f"    <h2>{sbl[3:]}</h2>")
            elif sbl.startswith('### '):
                el_type = 'heading'
                lvl = 3
                html_sec_lines.append(f"    <h3>{sbl[4:]}</h3>")
            elif sbl.startswith('#### '):
                el_type = 'heading'
                lvl = 4
                html_sec_lines.append(f"    <h4>{sbl[5:]}</h4>")
            elif sbl.startswith('|'):
                el_type = 'table'
            else:
                # Check legal prefix
                html_txt = sbl.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
                html_txt = re.sub(r'\*\*(.*?)\*\*', r'<b>\1</b>', html_txt)
                html_txt = re.sub(r'\*(.*?)\*', r'<i>\1</i>', html_txt)
                html_sec_lines.append(f"    <p>{html_txt}</p>")
                
            mod_elements.append({
                'type': el_type,
                'level': lvl,
                'text': sbl
            })
            
        html_sec_lines.append("  </section>\n")
        html_sections.append('\n'.join(html_sec_lines))
        
        json_modules.append({
            'archivo_fuente': cfile,
            'titulo': module_title,
            'total_elementos': len(mod_elements),
            'elementos': mod_elements
        })
        
    # 1. Write dist/protocolo_maestro.md
    dist_master_md = os.path.join(DIST_DIR, 'protocolo_maestro.md')
    with open(dist_master_md, 'w', encoding='utf-8') as f:
        f.write('\n'.join(master_lines))
    print(f"[OK] Generado derivado: {dist_master_md}")
    
    # Also update root protocolo_maestro.md for backwards compatibility
    root_master_md = os.path.join(REPO_DIR, 'protocolo_maestro.md')
    with open(root_master_md, 'w', encoding='utf-8') as f:
        f.write('\n'.join(master_lines))
        
    # 2. Write dist/protocolo_estructurado.json
    dist_json = os.path.join(DIST_DIR, 'protocolo_estructurado.json')
    json_payload = {
        'metadatos': meta,
        'configuracion_editorial': cfg,
        'modulos': json_modules
    }
    with open(dist_json, 'w', encoding='utf-8') as f:
        json.dump(json_payload, f, ensure_ascii=False, indent=2)
    print(f"[OK] Generado derivado: {dist_json}")
    
    # Also update datos/estructura_documento.json
    datos_json = os.path.join(DATOS_DIR, 'estructura_documento.json')
    with open(datos_json, 'w', encoding='utf-8') as f:
        json.dump(json_payload, f, ensure_ascii=False, indent=2)
        
    print("[ÉXITO] Sincronización completa de todos los archivos derivados.")

if __name__ == "__main__":
    sync_derived()
