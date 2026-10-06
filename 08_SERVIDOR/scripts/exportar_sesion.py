#!/usr/bin/env python3
"""
╔══════════════════════════════════════════════════════════════╗
║  Exporta la sesión MARKETATTACK del opencode a texto plano.  ║
║  Sirve dentro del kit de recuperación. Sanitiza secretos.    ║
╚══════════════════════════════════════════════════════════════╝
"""
import json, os, re, sqlite3, sys, datetime

DB = sys.argv[1] if len(sys.argv) > 1 else \
    "/home/ubuntu/.local/share/opencode/opencode.db"
DEST = sys.argv[2] if len(sys.argv) > 2 else "/tmp/kit/chat"
TITULO = (sys.argv[3] if len(sys.argv) > 3 else "marketattack").lower()

def claves_conocidas():
    """Claves que NUNCA deben salir: la actual y las ya rotadas."""
    claves = []
    try:
        with open("/etc/systemd/system/opencode.service") as f:
            for linea in f:
                if "OPENCODE_SERVER_PASSWORD=" in linea:
                    v = linea.split("=", 1)[1].strip().strip('"')
                    if len(v) >= 8:
                        claves.append(v)
    except OSError:
        pass
    try:
        with open("/etc/marketattack/claves_rotadas.txt") as f:
            for linea in f:
                v = linea.strip()
                if len(v) >= 8:
                    claves.append(v)
    except OSError:
        pass
    return claves


REGLAS_DINAMICAS = [
    (re.compile(re.escape(k)), "[CLAVE ROTADA -- no se incluye]")
    for k in claves_conocidas()
]

REGLAS = [
    (re.compile(r"-----BEGIN[A-Z ]*PRIVATE KEY-----.*?-----END[A-Z ]*PRIVATE KEY-----", re.S),
     "[LLAVE PRIVADA -- no se incluye]"),
    (re.compile(r"ma_celular\S*", re.I), "[LLAVE CELULAR]"),
    (re.compile(r"\b\d{8,10}:[A-Za-z0-9_-]{35}\b"), "[TOKEN TELEGRAM -- no se incluye]"),
    (re.compile(r"\bsk-[A-Za-z0-9_-]{20,}\b"), "[API KEY -- no se incluye]"),
    (re.compile(r"\bgh[pousr]_[A-Za-z0-9]{20,}\b"), "[GITHUB TOKEN]"),
    (re.compile(re.escape("[CLAVE]")), "[CLAVE SERVIDOR]"),
    (re.compile(r"(OPENCODE_SERVER_PASSWORD=)\S+"), r"\1[OCULTA]"),
    (re.compile(r"(TELEGRAM_TOKEN=)\S+"), r"\1[OCULTO]"),
    (re.compile(r"(TELEGRAM_CHAT_ID=)\S+"), r"\1[OCULTO]"),
]


def limpiar(t):
    if not t:
        return t
    for rx, rep in REGLAS + REGLAS_DINAMICAS:
        t = rx.sub(rep, t)
    return t


if not os.path.exists(DB):
    print("AVISO=base de datos no encontrada: " + DB)
    sys.exit(0)

c = sqlite3.connect(DB)
c.row_factory = sqlite3.Row

msgs = c.execute("""
    SELECT m.id AS mid, m.time_created AS tc, m.data AS md
    FROM message m JOIN session s ON m.session_id = s.id
    WHERE lower(s.title) LIKE ? ORDER BY m.time_created
""", ("%" + TITULO + "%",)).fetchall()

by = {}
for p in c.execute("SELECT message_id, data FROM part ORDER BY id"):
    try:
        by.setdefault(p["message_id"], []).append(json.loads(p["data"]))
    except Exception:
        pass

salida = []
n = 0
for m in msgs:
    txt = "\n".join(x.get("text", "") for x in by.get(m["mid"], [])
                    if x.get("type") == "text")
    if not txt.strip():
        continue
    try:
        rol = json.loads(m["md"]).get("role", "?")
    except Exception:
        rol = "?"
    ts = datetime.datetime.fromtimestamp((m["tc"] or 0) / 1000)
    salida.append({"rol": rol, "fecha": ts.isoformat(timespec="seconds"),
                   "texto": limpiar(txt)})
    n += 1

os.makedirs(os.path.dirname(DEST), exist_ok=True)
with open(DEST + ".json", "w", encoding="utf-8") as f:
    json.dump({"exportado": datetime.datetime.now().isoformat(),
               "sesion": TITULO, "mensajes": n, "conversacion": salida},
              f, ensure_ascii=False, indent=1)

with open(DEST + ".md", "w", encoding="utf-8") as f:
    f.write(f"# Conversación MARKETATTACK\n\n")
    f.write(f"Exportado: {datetime.datetime.now():%Y-%m-%d %H:%M}\n")
    f.write(f"Mensajes: {n}\n\n---\n\n")
    for m in salida:
        quien = "USUARIO" if m["rol"] == "user" else "OPENCODE"
        f.write(f"## {quien} · {m['fecha']}\n\n{m['texto']}\n\n---\n\n")

print(f"MENSAJES={n}")
print(f"JSON={DEST}.json")
print(f"MD={DEST}.md")
