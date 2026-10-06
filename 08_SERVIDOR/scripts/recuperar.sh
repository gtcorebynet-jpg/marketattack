#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  RESTAURAR EL MARKETATTACK  (funciona desde CUALQUIER vía)
#
#  Elige de dónde recuperar según lo que tengas disponible:
#    A) Kit de Telegram  → si tienes el ZIP descargado
#    B) VPS              → si el servidor sigue vivo
#    C) GitHub           → si solo tienes la PC y la red
# ═══════════════════════════════════════════════════════════
IP=149.130.190.118
LLAVE=~/.ssh/ma_celular
case "$1" in
  A|a|telegram) VIA="A — Kit de Telegram"; ;;
  B|b|vps)      VIA="B — VPS"; ;;
  C|c|github)   VIA="C — GitHub"; ;;
  *) echo "Uso: recuperar.sh [A=telegram | B=vps | C=github]"; exit 1 ;;
esac
DEST=${2:-$PWD/marketattack-restaurado}
echo "══════════════════════════════════════"
echo " RESTAURAR: $VIA"
echo " Destino:   $DEST"
echo "══════════════════════════════════════"
mkdir -p "$DEST" && cd "$DEST" || exit 1

case "$1" in
A|a|telegram)
  ZIP=$(find "$HOME" /sdcard/Download /storage/emulated/0/Download -maxdepth 3 -name 'KIT_RECUPERACION*.zip' 2>/dev/null | head -1)
  [ -z "$ZIP" ] && { echo "✗ No encuentro el ZIP. Descárgalo de Telegram y ponlo en Descargas."; exit 1; }
  echo "→ kit: $ZIP"
  unzip -qo "$ZIP" && K=$(find . -maxdepth 1 -type d -name 'kit_*' | head -1)
  echo "→ contenido: $K"
  [ -f "$K/CONTEXTO.md" ] && cp "$K/CONTEXTO.md" . && echo "  ✓ CONTEXTO.md recuperado"
  cp -r "$K/scripts" . 2>/dev/null && echo "  ✓ scripts recuperados"
  cp -r "$K/chat" . 2>/dev/null && echo "  ✓ conversación recuperada"
  cp -r "$K/config" . 2>/dev/null && echo "  ✓ configuración (saneada) recuperada"
  bash "$K/RESTAURAR.sh" 2>/dev/null | head -40
  ;;
B|b|vps)
  echo "→ conectando al VPS..."
  ssh -o BatchMode=yes -o ConnectTimeout=15 -i "$LLAVE" ubuntu@$IP '
    ult=$(sudo find /var/backups/marketattack/completos -name "completo_*.tar.gz" | sort -r | head -1)
    [ -z "$ult" ] && { echo "✗ no hay respaldos"; exit 1; }
    echo "  respaldo más reciente: $(basename $ult)"
    sudo tar -xzf "$ult" -C /tmp/ 2>/dev/null
    cd /tmp && sudo cp -r contenido/* ESTADO.txt SHA256SUMS /home/ubuntu/ 2>/dev/null
    sudo rm -rf /tmp/contenido /tmp/ESTADO.txt /tmp/SHA256SUMS
    echo "  ✓ restaurado en el VPS en ~/ (contenido, ESTADO.txt, SHA256SUMS)"
  '
  ;;
C|c|github)
  echo "→ clonando desde GitHub..."
  git clone git@github.com:gtcorebynet-jpg/marketattack.git "$DEST/repo" 2>/dev/null \
    && echo "  ✓ repo clonado en $DEST/repo" \
    || { echo "✗ no se pudo clonar (revisa la red o la llave SSH)"; exit 1; }
  ;;
esac
echo ""
echo "✅ Restauración terminada desde $VIA"
