import pymupdf
import re

doc = pymupdf.open('dist/TEST_PROTOCOLO_CAPITULOS_01_09.pdf')

print("AUDITORÍA FORENSE DETALLADA DE LAS 26 VIUDAS / HUÉRFANAS DE PÁRRAFO:")
print("="*80)

# We have the 26 transitions:
# (p_prev, p_next)
transitions = [
    (37, 38, 2),
    (45, 46, 3),
    (48, 49, 3),
    (49, 50, 3),
    (51, 52, 3),
    (54, 55, 3),
    (56, 57, 3),
    (57, 58, 3),
    (58, 59, 3),
    (59, 60, 3),
    (60, 61, 3),
    (65, 66, 4),
    (67, 68, 4),
    (69, 70, 4),
    (72, 73, 4),
    (74, 75, 4),
    (75, 76, 4),
    (79, 80, 4),
    (81, 82, 4),
    (82, 83, 4),
    (84, 85, 4),
    (85, 86, 4),
    (86, 87, 4),
    (92, 93, 5),
    (93, 94, 5),
    (101, 102, 6)
]

def clean_txt(t):
    return " ".join(t.split())

results = []

for idx, (p_prev, p_next, ch) in enumerate(transitions, 1):
    page_prev = doc[p_prev - 1]
    page_next = doc[p_next - 1]
    
    # Extract blocks & lines on page_prev
    d_prev = page_prev.get_text('dict')
    lines_prev = []
    current_sec_prev = "N/A"
    
    for b in d_prev['blocks']:
        if b.get('type') == 0:
            for l in b['lines']:
                txt = "".join([s['text'] for s in l['spans']]).strip()
                y0, y1 = l['bbox'][1], l['bbox'][3]
                if 60 < y0 < 560 and not any(k in txt for k in ['PROTOCOLO FAMILIAR', 'VERSION 1.0', 'CAPÍTULO', 'UN LEGADO', 'TRASCIENDE', 'CONSTRUIMOS']) and not txt.isdigit():
                    m = re.match(r'^([1-9]\.[0-9]+(?:\.[0-9]+)*)\.?\s+(.*)', txt)
                    if m:
                        current_sec_prev = f"{m.group(1)} {m.group(2)}"
                    else:
                        lines_prev.append((txt, l['bbox'], current_sec_prev))

    # Extract blocks & lines on page_next
    d_next = page_next.get_text('dict')
    lines_next = []
    current_sec_next = current_sec_prev
    
    for b in d_next['blocks']:
        if b.get('type') == 0:
            for l in b['lines']:
                txt = "".join([s['text'] for s in l['spans']]).strip()
                y0, y1 = l['bbox'][1], l['bbox'][3]
                if 60 < y0 < 560 and not any(k in txt for k in ['PROTOCOLO FAMILIAR', 'VERSION 1.0', 'CAPÍTULO', 'UN LEGADO', 'TRASCIENDE', 'CONSTRUIMOS']) and not txt.isdigit():
                    m = re.match(r'^([1-9]\.[0-9]+(?:\.[0-9]+)*)\.?\s+(.*)', txt)
                    if m:
                        current_sec_next = f"{m.group(1)} {m.group(2)}"
                    else:
                        lines_next.append((txt, l['bbox'], current_sec_next))

    # Identify the splitting paragraph:
    # On page_prev: find how many lines belong to the last paragraph before the break
    # We walk backwards on lines_prev until we hit a sentence end or a large y gap
    split_lines_prev = []
    if lines_prev:
        split_lines_prev.append(lines_prev[-1])
        # walk backwards
        for i in range(len(lines_prev) - 2, -1, -1):
            line_txt = lines_prev[i][0]
            # if previous line ends with period/colon, paragraph started at i+1
            if line_txt.endswith('.') or line_txt.endswith(':') or lines_prev[i][2] != lines_prev[-1][2]:
                break
            # check vertical gap between lines_prev[i] and lines_prev[i+1]
            gap = lines_prev[i+1][1][1] - lines_prev[i][1][3]
            if gap > 8.0: # paragraph break!
                break
            split_lines_prev.insert(0, lines_prev[i])

    # On page_next: find how many lines belong to the continuation of this paragraph
    # We walk forwards on lines_next until we hit a sentence end
    split_lines_next = []
    if lines_next:
        for i in range(len(lines_next)):
            line_txt = lines_next[i][0]
            split_lines_next.append(lines_next[i])
            if line_txt.endswith('.') or line_txt.endswith(':') or (i+1 < len(lines_next) and lines_next[i+1][1][1] - lines_next[i][1][3] > 8.0):
                break

    lines_prev_count = len(split_lines_prev)
    lines_next_count = len(split_lines_next)
    total_par_lines = lines_prev_count + lines_next_count

    # Classification
    # A: 1 línea al pie de página (lines_prev_count == 1 and lines_next_count >= 2)
    # B: 1 línea al inicio de página (lines_next_count == 1 and lines_prev_count >= 2)
    # C: ambas (lines_prev_count == 1 and lines_next_count == 1)
    # D: otro caso (e.g. >= 2 on both, or special list)
    if lines_prev_count == 1 and lines_next_count == 1:
        cat = "C. Ambas (1 línea al pie y 1 línea al tope)"
    elif lines_prev_count == 1:
        cat = "A. 1 línea al pie de página (huérfana)"
    elif lines_next_count == 1:
        cat = "B. 1 línea al inicio de página (viuda)"
    else:
        cat = "D. Otro caso problemático"

    sec_name = split_lines_prev[0][2] if split_lines_prev else current_sec_prev
    par_sample = " ".join([l[0] for l in split_lines_prev] + [l[0] for l in split_lines_next])

    results.append({
        'id': idx,
        'chapter': ch,
        'page_prev': p_prev,
        'page_next': p_next,
        'section': sec_name,
        'lines_prev_count': lines_prev_count,
        'lines_next_count': lines_next_count,
        'total_lines': total_par_lines,
        'category': cat,
        'text_prev': " // ".join([l[0] for l in split_lines_prev]),
        'text_next': " // ".join([l[0] for l in split_lines_next]),
        'par_sample': par_sample
    })

    print(f"[{idx:02d}] Cap {ch:02d} | Pág {p_prev:02d} -> Pág {p_next:02d} | Sec: {sec_name[:40]}")
    print(f"     Líneas en P.{p_prev:02d}: {lines_prev_count} | Líneas en P.{p_next:02d}: {lines_next_count} | Total: {total_par_lines} | Categoría: {cat}")
    print(f"     Prev: {split_lines_prev[-1][0][:70]}...")
    print(f"     Next: {split_lines_next[0][0][:70]}...")
    print("-" * 80)
