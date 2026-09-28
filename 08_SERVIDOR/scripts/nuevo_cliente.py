#!/usr/bin/env python3
"""
╔═══════════════════════════════════════════════════════════╗
║  MARKETATTACK · Generador de tienda para un cliente nuevo   ║
║  Crea la web, la publica y genera el QR.                  ║
╚═══════════════════════════════════════════════════════════╝
Uso:
  nuevo_cliente.py --nombre "Tienda Don Pepe" --whatsapp 573001234567 \
      --tagline "Los mejores arepas" --horario "Lun-Sab 8am-8pm" \
      --ubicacion "Soacha" --menu "Arepa con pollo|12000|Pollo y arepa" \
      --menu "Jugo|5000|Natural"
"""
import argparse, json, os, re, shutil, subprocess, sys, unicodedata

BASE_PROY = "/home/personalamd/Documentos/Default Project"
MOTOR = f"{BASE_PROY}/02_DEMO"
WEB = "/var/www/marketattack"
CLIENTES = f"{WEB}/clientes"


def slug(s):
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode().lower()
    s = re.sub(r"[^a-z0-9]+", "-", s).strip("-")
    return s or "cliente"


def reemplaza_cliente(texto, datos):
    """Reemplaza el objeto const CLIENTE = { ... } por los datos del cliente."""
    ini = texto.find("const CLIENTE = {")
    if ini == -1:
        raise SystemExit("ERROR: no se encontró 'const CLIENTE = {'")
    i = texto.find("{", ini)
    nivel, j = 0, i
    while j < len(texto):
        if texto[j] == "{":
            nivel += 1
        elif texto[j] == "}":
            nivel -= 1
            if nivel == 0:
                break
        j += 1
    nuevo = "const CLIENTE = " + json.dumps(datos, ensure_ascii=False, indent=2) + ";"
    return texto[:ini] + nuevo + texto[j + 1:]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--nombre", required=True)
    ap.add_argument("--whatsapp", required=True)
    ap.add_argument("--tagline", default="")
    ap.add_argument("--tono", default="amigable y cercano")
    ap.add_argument("--horario", default="Lunes a sábado de 8:00 a.m. a 6:00 p.m.")
    ap.add_argument("--ubicacion", default="")
    ap.add_argument("--contacto", default="")
    ap.add_argument("--menu", action="append", default=[])
    ap.add_argument("--faq", action="append", default=[])
    ap.add_argument("--promo", default="")
    a = ap.parse_args()

    s = slug(a.nombre)
    destino = f"{CLIENTES}/{s}"

    # 1) preparar estructura
    if os.path.exists(destino):
        shutil.rmtree(destino)
    os.makedirs(os.path.dirname(destino), exist_ok=True)
    shutil.copytree(MOTOR, destino)

    # 2) datos del cliente en el formato que la tienda realmente lee
    menu = []
    for m in a.menu:
        p = [x.strip() for x in m.split("|")]
        while len(p) < 3:
            p.append("")
        precio = p[1] or "0"
        if not precio.startswith("$"):
            precio = "$" + precio
        menu.append({"nombre": p[0], "precio": precio, "desc": p[2]})
    if not menu:
        menu = [{"nombre": "Producto de ejemplo", "precio": "$0", "desc": "Descripción"}]

    datos = {
        "nombreComercial": a.nombre,
        "nombreInterno": s,
        "whatsapp": re.sub(r"\D", "", a.whatsapp),
        "marca": {"tagline": a.tagline or a.nombre, "tono": a.tono},
        "info": {"horario": a.horario, "ubicacion": a.ubicacion, "contacto": a.contacto},
        "menu": menu,
        "promociones": ([{"titulo": "PROMO", "texto": a.promo}] if a.promo else []),
        "preguntasFrecuentes": ([{"p": p.split("|")[0], "r": (p.split("|")[1] if "|" in p else p)}
                                 for p in a.faq] if a.faq else []),
    }

    # 3) inyectar en el motor
    demo = f"{destino}/assets/demo.js"
    with open(demo, encoding="utf-8") as f:
        t = f.read()
    with open(demo, "w", encoding="utf-8") as f:
        f.write(reemplaza_cliente(t, datos))

    # 4) guardar la ficha del cliente en el proyecto
    ficha = f"{BASE_PROY}/05_CLIENTES/{s}"
    os.makedirs(ficha, exist_ok=True)
    with open(f"{ficha}/config_cliente.js", "w", encoding="utf-8") as f:
        f.write("// Generado automáticamente por nuevo_cliente.py\n")
        f.write("window.CLIENTE_CONFIG = " + json.dumps(datos, ensure_ascii=False, indent=2) + ";\n")
    with open(f"{ficha}/datos.txt", "w", encoding="utf-8") as f:
        f.write(f"Nombre: {a.nombre}\nWhatsApp: {a.whatsapp}\n")
        f.write(f"Tagline: {a.tagline}\nHorario: {a.horario}\nZona: {a.ubicacion}\n\n")
        for m in menu:
            f.write(f"- {m['nombre']} | {m['precio']} | {m['desc']}\n")

    # 5) QR
    url = f"http://149.130.190.118/clientes/{s}/tienda.html"
    q = subprocess.run(["python3", "/usr/local/bin/qr_tienda.py", url,
                        f"{destino}/qr.png", a.nombre.upper()[:22]],
                       capture_output=True, text=True, timeout=120)
    qr_ok = os.path.exists(f"{destino}/qr.png") and q.returncode == 0
    if not qr_ok:
        print(f"AVISO_QR={(q.stderr or q.stdout or 'sin detalle').strip()[:200]}")

    # 6) VERIFICACIÓN REAL: un 200 solo no basta.
    #    nginx podría devolver una portada inventada por una ruta mal puesta.
    def pedir(u):
        """Devuelve (codigo_http, cuerpo_en_bytes). Siempre bytes, nunca texto."""
        p = subprocess.run(["curl", "-s", "-w", "\n%{http_code}", "--max-time", "12", u],
                           capture_output=True, timeout=30)
        cuerpo, _, cod = p.stdout.rpartition(b"\n")
        return cod.decode("utf-8", "ignore").strip(), cuerpo

    base = f"http://127.0.0.1/clientes/{s}"
    c_web, _ = pedir(f"{base}/tienda.html")
    c_js, js = pedir(f"{base}/assets/demo.js")
    c_qr, _ = pedir(f"{base}/qr.png")
    txt = js.decode("utf-8", "ignore")
    con_datos = (f'"{s}"' in txt) and (a.nombre in txt)
    code = "200" if (c_web == "200" and c_js == "200" and c_qr == "200"
                     and con_datos and qr_ok) else f"FALLO({c_web}/{c_js}/{c_qr}/datos={con_datos})"

    # 7) permisos legibles por nginx
    subprocess.run(["chmod", "-R", "a+rX", destino], check=False)

    print(f"NOMBRE={a.nombre}")
    print(f"SLUG={s}")
    print(f"LINK={url}")
    print(f"QR=http://149.130.190.118/clientes/{s}/qr.png")
    print(f"FICHA={ficha}")
    print(f"VERIFICADO={code}")
    print(f"PRODUCTOS={len(menu)}")


if __name__ == "__main__":
    main()
