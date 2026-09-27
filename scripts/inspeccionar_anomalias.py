import pymupdf
import re

doc = pymupdf.open('dist/TEST_PROTOCOLO_CAPITULOS_01_09.pdf')

print(f"Auditoría profunda de páginas en TEST_PROTOCOLO_CAPITULOS_01_09.pdf ({len(doc)} páginas):")
print("="*80)

# Check line counts, headings at page bottom, and short pages
short_pages = []
bottom_headings = []
page_info = []

for pno in range(1, len(doc) + 1):
    page = doc[pno - 1]
    text = page.get_text()
    lines = [l.strip() for l in text.splitlines() if l.strip()]
    
    # Classify page type
    is_blank = (len(lines) == 0)
    is_opening = any('CAPÍTULO' in l and ('DECLARACIÓN' in l or 'PROPIEDAD' in l or 'GOBIERNO' in l or 'RÉGIMEN' in l or 'CONTROL' in l or 'MEDIOS' in l or 'PROCEDIMIENTO' in l) for l in lines)
    is_first = any(re.match(r'^(?:0[1-9])\b', l) for l in lines) and any('CONSTRUIMOS' in l for l in lines)
    
    # Body lines (exclude headers and footers)
    body_lines = [l for l in lines if not any(k in l for k in ['PROTOCOLO FAMILIAR', 'VERSION 1.0', 'CAPÍTULO', 'UN LEGADO', 'TRASCIENDE', 'CONSTRUIMOS']) and not l.isdigit()]
    
    # Check if heading is last or second to last
    headings_on_page = [l for l in lines if re.match(r'^[1-9]\.[0-9]+(?:\.[0-9]+)*\.?\s+', l)]
    
    if len(lines) > 0 and len(body_lines) < 5 and not is_opening:
        short_pages.append((pno, len(body_lines), body_lines))
        
    for h in headings_on_page:
        h_idx = lines.index(h)
        lines_after = len(lines) - 1 - h_idx
        if lines_after <= 2:
            bottom_headings.append((pno, h, lines_after))

print(f"Páginas con menos de 5 líneas de cuerpo (excluyendo aperturas y blancas): {len(short_pages)}")
for sp in short_pages:
    print(f"  Pág {sp[0]:02d}: {sp[1]} líneas de cuerpo -> {sp[2]}")

print(f"\nEncabezados a menos de 3 líneas del pie de página: {len(bottom_headings)}")
for bh in bottom_headings:
    print(f"  Pág {bh[0]:02d}: '{bh[1]}' ({bh[2]} líneas posteriores)")
