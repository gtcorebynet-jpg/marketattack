#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  RESTAURAR KIT · MARKETATTACK
#  Úsalo en CUALQUIER dispositivo (PC o Android/Termux) para
#  recuperar el chat y el estado del proyecto.
#
#  Uso:  bash RESTAURAR.sh
# ═══════════════════════════════════════════════════════════════
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
IP=149.130.190.118

echo "╔══════════════════════════════════════════════╗"
echo "║  RESTAURACIÓN MARKETATTACK                    ║"
echo "╚══════════════════════════════════════════════╝"
echo "Kit: $DIR"
echo ""

# ── 1) leer la memoria y la conversación ──
echo "── 1) ¿Qué hay en este kit? ──"
for f in CONTEXTO.md chat/conversacion.md estado/ESTADO.txt; do
  if [ -f "$DIR/$f" ]; then
    printf "   ✅ %-28s %s\n" "$f" "$(du -h "$DIR/$f" | cut -f1)"
  else
    printf "   ❌ %-28s falta\n" "$f"
  fi
done
N=$(grep -c '^## ' "$DIR/chat/conversacion.md" 2>/dev/null || echo 0)
echo "   📋 $N mensajes guardados en la conversación"
echo ""

# ── 2) mostrar el estado como estaba ──
echo "── 2) Cómo estaba todo ──"
sed -n '1,30p' "$DIR/estado/ESTADO.txt" 2>/dev/null | sed 's/^/   /'
echo ""

# ── 3) ver si el servidor sigue vivo ──
echo "── 3) ¿El servidor sigue en pie? ──"
if command -v ssh >/dev/null 2>&1; then
  LLAVE=""
  [ -f ~/.ssh/ma_celular ] && LLAVE="-i ~/.ssh/ma_celular"
  [ -f ~/.ssh/id_rsa ] && LLAVE="-i ~/.ssh/id_rsa"
  if timeout 20 ssh $LLAVE -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
       ubuntu@$IP "echo OK" 2>/dev/null | grep -q OK; then
    echo "   ✅ el servidor responde. El chat NO está perdido."
    echo "   💡 siga en '3)' para usar el chat en vivo por el túnel."
  else
    echo "   ⚠️  no se pudo entrar por SSH (sin llave o sin internet)."
    echo "      da igual: la conversación está en chat/conversacion.md"
  fi
else
  echo "   ℹ️  este dispositivo no tiene ssh. No importa para leer el kit."
fi
echo ""

# ── 4) instrucciones por dispositivo ──
cat <<PASO

── 4) CÓMO SEGUIR DESDE AQUÍ ─────────────────────────────

  ▶ EN LA PC (Windows/Linux/Mac)
    1. Descomprime el kit.
    2. Abre CONTEXTO.md con Bloc de notas o editor.
    3. En el chat de opencode de la PC pega el bloque
       "PEGAME_ESTO_EN_EL_CHAT.txt" que viene en el kit.

  ▶ EN EL ANDROID (Termux)
    1. Descarga el kit de Telegram.
    2. pkg install -y unzip
    3. unzip KIT_RECUPERACION_MARKETATTACK_*.zip
    4. bash kit_*/RESTAURAR.sh
    5. Lee CONTEXTO.md:  less kit_*/CONTEXTO.md
    6. Copia "PEGAME_ESTO_EN_EL_CHAT.txt" y pégalo en el
       opencode del celular.

  ▶ VER EL CHAT EN VIVO DESDE EL ANDROID (lo mejor)
    1. Sube el túnel:
       ssh -N -L 4096:localhost:4096 -i ~/.ssh/ma_celular ubuntu@149.130.190.118
    2. En Chrome abre:
       http://opencode:<TU-CLAVE>@127.0.0.1:4096/
    (la clave va en la URL porque sin ella el servidor
     responde 401 y se ve en blanco)

── RESUMEN ─────────────────────────────────────────────
  · El proyecto vive en el VPS: $IP
  · La web:  http://$IP/tienda.html
  · Respaldos: /var/backups/marketattack/
  · Kit diario a Telegram: todos los días 00:00

PASO
cat <<'FIN'

── TU CLAVE DEL SERVIDOR (no está en ningún archivo) ──────
  Se guarda solo en el servidor, para que nadie más la vea:
    ssh -i ~/.ssh/ma_celular ubuntu@149.130.190.118
    sudo cat /root/CLAVE_OPENCODE.txt
  Anótala en el celular: la necesitas para el paso del túnel.

FIN
echo "Listo. Sigue el paso 4."