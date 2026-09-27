import os
import sys
import hashlib
import json
import pymupdf

WORKSPACE_ROOT = "C:/Users/JJSS/Desktop/ABC/repositorio_protocolo"
ARTIFACT_DIR = "C:/Users/JJSS/.gemini/antigravity-cli/brain/44be4a15-c5f0-4a79-9d3a-ff9fd2e33ab2"

def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while chunk := f.read(8192):
            h.update(chunk)
    return h.hexdigest().upper()

print("=== AUDITORÍA FORMAL DE INTEGRIDAD Y NO-REGRESIÓN: FASE 4.5.1 ===")

# 1. componentes.typ
comp_path = os.path.join(WORKSPACE_ROOT, "templates/typst/componentes.typ")
expected_comp_hash = "DF123879AA8AFDF3ECEE7333FD31CC624401935CFC2349436A39594EE8CC9F2B"
actual_comp_hash = sha256_file(comp_path)
print(f"componentes.typ SHA-256: {actual_comp_hash}")
if actual_comp_hash == expected_comp_hash:
    print("  componentes.typ [LOCKED CONSOLIDADO]: PASS")
else:
    print("  ERROR: componentes.typ fue modificado!")
    sys.exit(1)

# 2. Markdown canónicos
expected_md_hashes = {
    "capitulos/00_introduccion.md": "DEEECA7863249DB1348BEF6138E0DAEDA35B5120658459D0362309E543FECAD8",
    "capitulos/00_portada_e_indice.md": "A030EC14A57B0C86DEA4B17FDD057C4FFABC53948F94BB91D37C79E2BD20CD54",
    "capitulos/01_capitulo1_declaracion_principios.md": "B18B22334759386A547DC94103F6A63EC5AD72BFC9BAA10E4453D9143E58246E",
    "capitulos/02_capitulo2_propiedad_control_liquidez.md": "753A51F4ACCB99708845BF0DF6759F91A171E1098261CC308DCC1334E167CB8A",
    "capitulos/03_capitulo3_gobierno_profesionalizacion.md": "536C8D9879441CDE924C78C36F4B4879A9F69069540FAA699E002367A0B8CC53",
    "capitulos/04_capitulo4_sucesion_familiar.md": "4CCBE4D2E25B5FC8E50EA11BE6206DA044E532CACA7FB70BEDA6345BD693619A",
    "capitulos/05_capitulo5_control_informacion_comunicacion.md": "B8A731FCB4939E95861F2608D86A20137E67EC462FF4D40B06C567719F336342",
    "capitulos/06_capitulo6_disciplina_financiera.md": "3D6157E2201487A43B8262CF22E4E07F60BD680E827759F7BC3D02F47F383D73",
    "capitulos/07_capitulo7_procedimiento_sancionador.md": "DE32E740807452DBBB5E2676386EB491A268071859E8CF00110A578127A30CAF",
    "capitulos/08_capitulo8_solucion_conflictos.md": "E041394A51C1DCE44389BAC05A4A3D393CD48F3D825AEF17E0495402271669EF",
    "capitulos/09_capitulo9_regimen_juridico.md": "C3A7B5E4DC6D45CA9980A687E1DB7DCDF1286228DAFAAE6D09180FE23A4F1245",
    "capitulos/10_anexos_formatos_operativos.md": "102AC1DE3C815C616CC5740D0F3676FEF929578373B0EB6BFF0641BFF6115D3C",
    "capitulos/11_reglamento_asamblea_familia.md": "CF58D4959CE88BD2A2863AB6F018EB5F649151A9905859ACE203B4C853A3B5A8",
    "capitulos/12_reglamento_consejo_familia.md": "42B59E7D5D26A90BDDBCA124B128F07BBA335C844B83FA4D7711433D9675A2A0",
    "capitulos/13_reglamento_comite_honor_familiar.md": "B8D238BD294EC30DAE0DB0AAD76A8313EEB51D2CB69734B821C1E37337335CAF"
}

print("\n--- Verificación de fuentes canónicas Markdown ---")
all_md_ok = True
for fpath, exp_hash in expected_md_hashes.items():
    real_path = os.path.join(WORKSPACE_ROOT, fpath)
    cur_hash = sha256_file(real_path)
    if cur_hash == exp_hash:
        print(f"  {fpath}: PASS")
    else:
        print(f"  {fpath}: FAIL (mismatch!)")
        all_md_ok = False

if not all_md_ok:
    print("ERROR: Fuentes canónicas Markdown modificadas!")
    sys.exit(1)
print("Fuentes Markdown: 100% ÍNTEGRAS")

# 3. Verificación de PDFs generados para Fase 4.5.1
print("\n--- Verificación de PDFs Fase 4.5.1 ---")
expected_pdfs = {
    "dist/TEST_REGULATION_PAGE_FASE_4_5_1_A_ORIG.pdf": 4,
    "dist/TEST_REGULATION_PAGE_FASE_4_5_1_A4.pdf": 4,
    "dist/TEST_REGULATION_PAGE_FASE_4_5_1_A6.pdf": 4,
    "dist/TEST_REGULATION_PAGE_FASE_4_5_1_A8.pdf": 4,
    "dist/TEST_REGULATION_PAGE_FASE_4_5_1_COMPARATIVO.pdf": 17
}

for pdf_rel, exp_pages in expected_pdfs.items():
    pdf_abs = os.path.join(WORKSPACE_ROOT, pdf_rel)
    if not os.path.exists(pdf_abs):
        print(f"ERROR: Archivo {pdf_rel} no existe!")
        sys.exit(1)
    doc = pymupdf.open(pdf_abs)
    if len(doc) == exp_pages:
        print(f"  {pdf_rel}: PASS ({len(doc)} páginas, {os.path.getsize(pdf_abs)} bytes)")
    else:
        print(f"  {pdf_rel}: FAIL (esperadas {exp_pages}, encontradas {len(doc)})")
        sys.exit(1)

# 4. Verificación de No Regresión Capítulos 01–09
print("\n--- Verificación de No Regresión Capítulos 01–09 ---")
doc_base = pymupdf.open(os.path.join(WORKSPACE_ROOT, "dist/TEST_PROTOCOLO_CAPITULOS_01_09_FASE_3_9_3.pdf"))
doc_test = pymupdf.open(os.path.join(WORKSPACE_ROOT, "dist/TEST_NON_REGRESSION_4_5.pdf"))
if len(doc_base) == len(doc_test) == 126:
    diffs = sum(1 for i in range(126) if doc_base[i].get_text() != doc_test[i].get_text())
    if diffs == 0:
        print("  Capítulos 01–09 (126 páginas): 100% IDÉNTICAS (PASS)")
    else:
        print(f"  ERROR: {diffs} diferencias encontradas en Capítulos 01–09!")
        sys.exit(1)
else:
    print(f"  ERROR en conteo de páginas Capítulos 01-09 ({len(doc_test)} vs 126)!")
    sys.exit(1)

# 5. Verificación de Artefactos de Imagen y JSON
print("\n--- Verificación de Artefactos y Métricas ---")
json_path = os.path.join(WORKSPACE_ROOT, "datos/fase_4_5_1_metricas_microajuste.json")
if os.path.exists(json_path):
    with open(json_path, "r", encoding="utf-8") as f:
        metrics = json.load(f)
    if len(metrics) == 4 and all(k in metrics for k in ["A_orig", "A4", "A6", "A8"]):
        print(f"  datos/fase_4_5_1_metricas_microajuste.json: PASS ({len(metrics)} microvariantes)")
    else:
        print("  ERROR: JSON de métricas incompleto!")
        sys.exit(1)
else:
    print("  ERROR: JSON de métricas no encontrado!")
    sys.exit(1)

expected_images = [
    "lamina_comparativa_fase_4_5_1_art_spacing.png",
    "regulation_page_fase_4_5_1_a_orig_p1.png",
    "regulation_page_fase_4_5_1_a4_p1.png",
    "regulation_page_fase_4_5_1_a6_p1.png",
    "regulation_page_fase_4_5_1_a8_p1.png"
]

for img_name in expected_images:
    dist_img = os.path.join(WORKSPACE_ROOT, "dist", img_name)
    art_img = os.path.join(ARTIFACT_DIR, img_name)
    if os.path.exists(dist_img) and os.path.exists(art_img):
        print(f"  {img_name}: PASS (dist & artifact ok)")
    else:
        print(f"  ERROR: Imagen {img_name} falta en dist o artifact!")
        sys.exit(1)

print("\n=== TODAS LAS PRUEBAS DE INTEGRIDAD Y AUDITORÍA PASARON AL 100% ===")
