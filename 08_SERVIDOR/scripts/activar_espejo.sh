#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  ACTIVAR EL ESPEJO AUTOMÁTICO EN GITHUB (desde el VPS)
#
#  Uso:  sudo bash /usr/local/bin/activar_espejo.sh
#
#  Qué hace:
#    1. genera una llave SOLO para este VPS
#    2. te muestra la llave pública para copiarla en GitHub
#    3. espera a que la pegues y comprueba si ya funciona
#    4. si funciona, publica el primer espejo
# ═══════════════════════════════════════════════════════════
set -uo pipefail
LLAVE=/root/.ssh/id_ed25519
REPO=/root/marketattack-git
REMOTO=git@github.com:gtcorebynet-jpg/marketattack.git

echo "══════════════════════════════════════"
echo " ESPEJO AUTOMÁTICO EN GITHUB"
echo "══════════════════════════════════════"
echo ""

if [ -f "$LLAVE" ]; then
  echo "1) la llave ya existe, la reutilizo."
else
  echo "1) generando una llave SOLO para este VPS..."
  sudo mkdir -p /root/.ssh && sudo chmod 700 /root/.ssh
  sudo ssh-keygen -t ed25519 -C "vps-marketattack" -f "$LLAVE" -N "" -q
  echo "   ✓ creada"
fi
sudo chmod 600 "$LLAVE"; sudo chmod 644 "$LLAVE.pub"

echo ""
echo "2) COPIA ESTA LLAVE (es pública, se puede compartir):"
echo ""
echo "   ┌────────────────────────────────────────┐"
sudo cat "$LLAVE.pub" | fold -w 38 | sed 's/^/   │ /'
echo "   └────────────────────────────────────────┘"
echo ""
echo "   Dónde pegarla:"
echo "     GitHub → tu repositorio 'marketattack'"
echo "     → Settings → Deploy keys → Add deploy key"
echo "     → Title: vps-marketattack"
echo "     → Key: lo de arriba"
echo "     → ☑ Allow write access   (OBLIGATORIO)"
echo ""
read -rp "   ¿Ya la pegaste? (s/n): " R
if [ "${R,,}" != "s" ]; then
  echo ""
  echo "   Sin problema. Cuando la pegues, ejecuta:"
  echo "     sudo bash /usr/local/bin/activar_espejo.sh"
  exit 0
fi

echo ""
echo "3) comprobando si GitHub ya la acepta..."
if ! sudo ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new -T git@github.com >/dev/null 2>&1; then
  echo "   ✗ GitHub todavía no acepta la llave."
  echo ""
  echo "   Revisa estos puntos:"
  echo "     · ¿la pegaste en el repositorio correcto (marketattack)?"
  echo "     · ¿marcaste 'Allow write access'?"
  echo "     · ¿confirmaste con el botón verde 'Add key'?"
  echo ""
  echo "   Vuelve a intentarlo cuando la hayas pegado."
  exit 1
fi
echo "   ✓ GitHub acepta la llave"

echo ""
echo "4) publicando el primer espejo..."
sudo /usr/local/bin/publicar_github.sh

echo ""
echo "5) comprobando qué quedó subido..."
sudo -u gituser bash -c "cd '$REPO' && git log --oneline -1" 2>/dev/null | sed 's/^/   /' || echo "   (sin commit todavía)"
echo ""
echo "══════════════════════════════════════"
echo " ✓ ESPEJO ACTIVADO — se publicará solo cada día a las 04:00"
echo "══════════════════════════════════════"
