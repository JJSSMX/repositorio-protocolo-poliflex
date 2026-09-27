#!/usr/bin/env python3
"""
AUDITORÍA INTEGRAL DE FASE 4.4.2 — CIERRE Y LOCK DE REGULATION-OPENING()
Protocolo Familiar · Poliductos Flexibles, S.A. de C.V. (POLIFLEX)
"""

import os
import hashlib
import pymupdf

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

EXPECTED_PREV_COMPONENTES_HASH = "51EBCD024FC7EC3C65C873DB08CD0F3B1A03718D2EC2234EC210C35D123DF803"
PREV_COMPONENTES_SIZE = 50020
EXPECTED_NEW_COMPONENTES_HASH = "DF123879AA8AFDF3ECEE7333FD31CC624401935CFC2349436A39594EE8CC9F2B"
EXPECTED_NEW_COMPONENTES_SIZE = 54780

EXPECTED_MD_HASHES = {
    "00_introduccion.md": "DEEECA7863249DB1348BEF6138E0DAEDA35B5120658459D0362309E543FECAD8",
    "00_portada_e_indice.md": "A030EC14A57B0C86DEA4B17FDD057C4FFABC53948F94BB91D37C79E2BD20CD54",
    "01_capitulo1_declaracion_principios.md": "B18B22334759386A547DC94103F6A63EC5AD72BFC9BAA10E4453D9143E58246E",
    "02_capitulo2_propiedad_control_liquidez.md": "753A51F4ACCB99708845BF0DF6759F91A171E1098261CC308DCC1334E167CB8A",
    "03_capitulo3_gobierno_profesionalizacion.md": "536C8D9879441CDE924C78C36F4B4879A9F69069540FAA699E002367A0B8CC53",
    "04_capitulo4_sucesion_familiar.md": "4CCBE4D2E25B5FC8E50EA11BE6206DA044E532CACA7FB70BEDA6345BD693619A",
    "05_capitulo5_control_informacion_comunicacion.md": "B8A731FCB4939E95861F2608D86A20137E67EC462FF4D40B06C567719F336342",
    "06_capitulo6_disciplina_financiera.md": "3D6157E2201487A43B8262CF22E4E07F60BD680E827759F7BC3D02F47F383D73",
    "07_capitulo7_procedimiento_sancionador.md": "DE32E740807452DBBB5E2676386EB491A268071859E8CF00110A578127A30CAF",
    "08_capitulo8_solucion_conflictos.md": "E041394A51C1DCE44389BAC05A4A3D393CD48F3D825AEF17E0495402271669EF",
    "09_capitulo9_regimen_juridico.md": "C3A7B5E4DC6D45CA9980A687E1DB7DCDF1286228DAFAAE6D09180FE23A4F1245",
    "10_anexos_formatos_operativos.md": "102AC1DE3C815C616CC5740D0F3676FEF929578373B0EB6BFF0641BFF6115D3C",
    "11_reglamento_asamblea_familia.md": "CF58D4959CE88BD2A2863AB6F018EB5F649151A9905859ACE203B4C853A3B5A8",
    "12_reglamento_consejo_familia.md": "42B59E7D5D26A90BDDBCA124B128F07BBA335C844B83FA4D7711433D9675A2A0",
    "13_reglamento_comite_honor_familiar.md": "B8D238BD294EC30DAE0DB0AAD76A8313EEB51D2CB69734B821C1E37337335CAF",
}

def sha256_bytes(b):
    h = hashlib.sha256()
    h.update(b)
    return h.hexdigest().upper()

def sha256_file(filepath):
    with open(filepath, "rb") as f:
        return sha256_bytes(f.read())

def main():
    print("=== AUDITORÍA INTEGRAL FORMAL: FASE 4.4.2 ===")
    
    # 1. Integridad de componentes.typ y verificación de carácter estrictamente aditivo
    comp_path = os.path.join(BASE_DIR, "templates", "typst", "componentes.typ")
    with open(comp_path, "rb") as f:
        data = f.read()
        
    print(f"componentes.typ tamaño actual: {len(data)} bytes")
    assert len(data) == EXPECTED_NEW_COMPONENTES_SIZE, f"ERROR: Tamaño inesperado {len(data)} != {EXPECTED_NEW_COMPONENTES_SIZE}"
    
    prefix = data[:PREV_COMPONENTES_SIZE]
    prefix_hash = sha256_bytes(prefix)
    print(f"componentes.typ prefix (bytes 0..{PREV_COMPONENTES_SIZE-1}) SHA-256: {prefix_hash}")
    assert prefix_hash == EXPECTED_PREV_COMPONENTES_HASH, "ERROR: Los componentes previos locked fueron alterados!"
    print("Integración estrictamente aditiva: PASS (100% de coincidencia bit a bit previa)")
    
    full_hash = sha256_bytes(data)
    print(f"componentes.typ consolidado SHA-256: {full_hash}")
    assert full_hash == EXPECTED_NEW_COMPONENTES_HASH, f"ERROR: Hash consolidado no coincide! {full_hash} != {EXPECTED_NEW_COMPONENTES_HASH}"
    print("componentes.typ [LOCKED CONSOLIDADO]: PASS")
    
    # 2. Integridad de las 15 fuentes canónicas Markdown
    print("\n--- Verificación de fuentes canónicas Markdown ---")
    for fname, expected_h in EXPECTED_MD_HASHES.items():
        fpath = os.path.join(BASE_DIR, "capitulos", fname)
        curr_h = sha256_file(fpath)
        assert curr_h == expected_h, f"ERROR: {fname} fue alterado! {curr_h} != {expected_h}"
        print(f"  {fname}: PASS")
    print("Fuentes Markdown: 100% ÍNTEGRAS")
    
    # 3. Verificación de TEST_REGULATION_OPENING_LOCKED.pdf
    pdf_path = os.path.join(BASE_DIR, "dist", "TEST_REGULATION_OPENING_LOCKED.pdf")
    assert os.path.exists(pdf_path), "ERROR: TEST_REGULATION_OPENING_LOCKED.pdf no existe!"
    doc = pymupdf.open(pdf_path)
    print(f"\nTEST_REGULATION_OPENING_LOCKED.pdf: {len(doc)} páginas")
    assert len(doc) == 5, f"ERROR: Se esperaban 5 páginas, se encontraron {len(doc)}"
    
    for p_idx in range(len(doc)):
        page_num = p_idx + 1
        txt = doc[p_idx].get_text().strip()
        if page_num % 2 == 0:
            assert len(txt) == 0, f"ERROR: Página {page_num} (Verso) no está en blanco!"
            print(f"  Pág. {page_num:02d} [VERSO BLANCO CEREMONIAL]: PASS")
        else:
            assert len(txt) > 0, f"ERROR: Página {page_num} (Recto) está vacía!"
            print(f"  Pág. {page_num:02d} [RECTO NOBLE LOCKED]: PASS ({repr(txt[:30])}...)")
            
    # 4. Verificación de Renders PNG
    pngs = [
        "regulation_locked_p1_asamblea.png",
        "regulation_locked_p3_consejo.png",
        "regulation_locked_p5_comite.png",
        "regulation_locked_spread_comite.png",
    ]
    print("\n--- Verificación de Renders PNG ---")
    for png in pngs:
        p_dist = os.path.join(BASE_DIR, "dist", png)
        assert os.path.exists(p_dist), f"ERROR: No se encontró dist/{png}"
        size_kb = os.path.getsize(p_dist) / 1024
        print(f"  dist/{png}: PASS ({size_kb:.1f} KB)")
        
    print("\n=== AUDITORÍA FASE 4.4.2 FINALIZADA CON ÉXITO ===")

if __name__ == "__main__":
    main()
