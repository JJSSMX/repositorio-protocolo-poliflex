import os
import json
import pymupdf
from PIL import Image

WORKSPACE_ROOT = "C:/Users/JJSS/Desktop/ABC/repositorio_protocolo"
ARTIFACT_DIR = "C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2"

metrics = {}

for v in ["A", "B", "C"]:
    pdf_path = os.path.join(WORKSPACE_ROOT, f"dist/TEST_REGULATION_PAGE_FASE_4_5_{v}.pdf")
    doc = pymupdf.open(pdf_path)
    print(f"\n==========================================")
    print(f"=== VARIANTE {v} ({len(doc)} PÁGINAS) ===")
    print(f"==========================================")
    v_metrics = {
        "variant": v,
        "pdf_file": f"dist/TEST_REGULATION_PAGE_FASE_4_5_{v}.pdf",
        "file_size_bytes": os.path.getsize(pdf_path),
        "total_pages": len(doc),
        "pages": []
    }
    
    for p_idx, page in enumerate(doc):
        text = page.get_text()
        raw_lines = [l.strip() for l in text.split("\n") if l.strip()]
        
        # Clasificar elementos
        first_line = raw_lines[0] if raw_lines else ""
        last_line = raw_lines[-1] if raw_lines else ""
        
        # Extraer bloques de texto con coordenadas
        blocks = page.get_text("blocks")
        
        # Calcular ocupación vertical
        # Útil: top 71.0079pt a bottom 547.00pt (475.99pt)
        body_blocks = [b for b in blocks if b[1] >= 60 and b[3] <= 570]
        if body_blocks:
            min_y = min(b[1] for b in body_blocks)
            max_y = max(b[3] for b in body_blocks)
            used_h = max_y - min_y
            occupancy_pct = round((used_h / 475.9921) * 100, 1)
        else:
            used_h = 0
            occupancy_pct = 0
            
        print(f"  Página {p_idx+1} ({'RECTO' if p_idx % 2 == 0 else 'VERSO'}):")
        print(f"    Líneas de texto: {len(raw_lines)}")
        print(f"    Ocupación vertical: {occupancy_pct}% (altura usada: {used_h:.1f} pt de 476.0 pt)")
        print(f"    Primeras 2 líneas: {raw_lines[:2]}")
        print(f"    Últimas 2 líneas: {raw_lines[-2:]}")
        
        p_data = {
            "page_number": p_idx + 1,
            "parity": "RECTO" if p_idx % 2 == 0 else "VERSO",
            "line_count": len(raw_lines),
            "occupancy_pct": occupancy_pct,
            "first_line": first_line,
            "last_line": last_line
        }
        v_metrics["pages"].append(p_data)
        
    metrics[f"VARIANTE_{v}"] = v_metrics

# Guardar métricas preliminares
with open(os.path.join(WORKSPACE_ROOT, "datos/fase_4_5_metricas_regulation_page.json"), "w", encoding="utf-8") as f:
    json.dump(metrics, f, indent=2, ensure_ascii=False)
print("\nMétricas guardadas en datos/fase_4_5_metricas_regulation_page.json")
