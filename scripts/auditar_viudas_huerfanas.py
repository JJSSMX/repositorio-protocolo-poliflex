import pymupdf
import re

doc = pymupdf.open('dist/TEST_PROTOCOLO_CAPITULOS_01_09.pdf')

print("AUDITORÍA DE PÁRRAFOS QUE CRUZAN PÁGINA (VIUDAS Y HUÉRFANAS):")
print("="*80)

# We want to identify when a paragraph splits across page P and P+1.
# On page P, how many lines does the splitting paragraph have?
# On page P+1, how many lines does the continuation have?

page_paragraphs = []

for pno in range(1, len(doc) + 1):
    page = doc[pno - 1]
    d = page.get_text('dict')
    
    # Extract blocks that are in the body area (y between 65 and 555)
    body_blocks = []
    for b in d['blocks']:
        if b.get('type') == 0:
            lines = []
            for l in b['lines']:
                # filter out header, footer, claim
                y0, y1 = l['bbox'][1], l['bbox'][3]
                txt = "".join([s['text'] for s in l['spans']]).strip()
                if 60 < y0 < 560 and not any(k in txt for k in ['PROTOCOLO FAMILIAR', 'VERSION 1.0', 'CAPÍTULO', 'UN LEGADO', 'TRASCIENDE', 'CONSTRUIMOS']) and not txt.isdigit():
                    lines.append((txt, l['bbox']))
            if lines:
                body_blocks.append(lines)
    page_paragraphs.append((pno, body_blocks))

split_anomalies = []

for idx in range(len(page_paragraphs) - 1):
    pno_c, blocks_c = page_paragraphs[idx]
    pno_n, blocks_n = page_paragraphs[idx + 1]
    
    if not blocks_c or not blocks_n:
        continue
        
    last_block_c = blocks_c[-1]
    first_block_n = blocks_n[0]
    
    last_line_c = last_block_c[-1][0]
    first_line_n = first_block_n[0][0]
    
    # Check if last line of page C does not end with sentence-ending punctuation (., :, ;)
    # which indicates it splits to page N
    if not re.search(r'[.:;]$', last_line_c) and not first_line_n.startswith('=='):
        # This paragraph splits across pages!
        # Check lines on page C
        lines_on_c = len(last_block_c)
        # Check lines on page N (until sentence end or end of block)
        lines_on_n = len(first_block_n)
        
        # Check if orphan on C (only 1 line)
        if lines_on_c == 1:
            split_anomalies.append({
                'type': 'Línea huérfana al pie de página (1 línea aislada)',
                'page': pno_c,
                'next_page': pno_n,
                'lines_on_page': lines_on_c,
                'text': last_line_c
            })
            
        # Check if widow on N (only 1 line of continuation)
        # In a continued block, if the first sentence ends on line 1 and line 2 starts a new paragraph or heading
        # or if first_block_n has only 1 line:
        if lines_on_n == 1:
            split_anomalies.append({
                'type': 'Línea viuda al inicio de página (1 sola línea de remanente)',
                'page': pno_n,
                'prev_page': pno_c,
                'lines_on_page': lines_on_n,
                'text': first_line_n
            })

print(f"Anomalías de viudas/huérfanas en saltos de párrafo: {len(split_anomalies)}")
for sa in split_anomalies:
    print(f"  [{sa['type']}] Pág {sa['page']:02d}: '{sa['text'][:60]}...'")

if not split_anomalies:
    print("[OK] Cero viudas y cero huérfanas en saltos de párrafo en todo el documento.")
