#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  ESPEJO AUTOMÁTICO EN GITHUB (para no depender de la PC)
#
#  Mientras el VPS no tenga llave de GitHub, NO hace nada
#  destructivo: informa qué falta y termina con OK.
#
#  Para activarlo (una sola vez, tú):
#    sudo ssh-keygen -t ed25519 -C "vps-marketattack" -f /root/.ssh/id_ed25519
#    sudo cat /root/.ssh/id_ed25519.pub
#  Copia esa llave en GitHub → tu repositorio → Settings →
#  Deploy keys → Add deploy key → ☑ Allow write access
# ═══════════════════════════════════════════════════════════
REPO=/root/marketattack-git
ORIGEN=/var/backups/marketattack/completos
REMOTO=git@github.com:gtcorebynet-jpg/marketattack.git

echo "→ espejo en GitHub"

if ! sudo test -f /root/.ssh/id_ed25519; then
  echo "  ℹ el VPS todavía no tiene llave de GitHub."
  echo "    Se deja constancia del estado en el VPS: $REPO"
  exit 0
fi
if ! sudo ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new -T git@github.com >/dev/null 2>&1; then
  echo "  ⚠ la llave existe pero GitHub no la acepta."
  echo "    Añádela como deploy key con permiso de escritura en el repositorio."
  exit 0
fi

# reconstruir el espejo desde el último respaldo íntegro
ult=$(sudo find "$ORIGEN" -name 'completo_*.tar.gz' | sort -r | head -1)
[ -z "$ult" ] && { echo "  ✗ no hay respaldos en $ORIGEN"; exit 1; }
echo "  fuente: $(basename "$ult")"

sudo rm -rf /tmp/pub && sudo mkdir -p /tmp/pub
sudo tar -xzf "$ult" -C /tmp/pub
# solo lo que tiene sentido versionar (nunca la DB del chat ni secretos)
sudo mkdir -p "$REPO"
for d in scripts config; do
  [ -d "/tmp/pub/contenido/$d" ] && sudo cp -r "/tmp/pub/contenido/$d" "$REPO/" 2>/dev/null
done
[ -d /tmp/pub/contenido/web ] && sudo cp -r /tmp/pub/contenido/web "$REPO/" 2>/dev/null
sudo cp /tmp/pub/ESTADO.txt "$REPO/ESTADO.txt" 2>/dev/null
sudo cp /tmp/pub/SHA256SUMS "$REPO/SHA256SUMS" 2>/dev/null
sudo chown -R gituser:gituser "$REPO" 2>/dev/null || true

export GIT_SSH_COMMAND="ssh -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new"

if sudo git ls-remote "$REMOTO" >/dev/null 2>&1; then
  if [ ! -d "$REPO/.git" ]; then
    echo "  · clonando el repo desde GitHub"
    sudo rm -rf "$REPO"
    sudo git clone -q --branch main "$REMOTO" "$REPO" 2>/dev/null || sudo git clone -q "$REMOTO" "$REPO"
  fi
else
  [ -d "$REPO/.git" ] || sudo git init -q -b main "$REPO"
fi

sudo bash -c "
  export GIT_SSH_COMMAND='ssh -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new'
  cd '$REPO' || exit 1
  git config user.email 'vps@marketattack.local'
  git config user.name 'MARKETATTACK VPS'
  git config core.safecrlf false
  git remote set-url origin '$REMOTO'
  git checkout -q -B main
  printf '*.db\n*.zip\n*.tar.gz\n*.key\n' > .gitignore
  git add -A 2>/dev/null
  if git diff --cached --quiet; then echo '  sin cambios nuevos'; exit 0; fi
  git commit -q -m \"respaldo automático del VPS $(date '+%Y-%m-%d %H:%M')\"
  if git push -q origin main; then
    echo '  ✓ empujado a GitHub (rama main)'
  else
    echo '  ✗ no se pudo empujar'
  fi
" || echo "  ⚠ el espejo no se pudo actualizar"

sudo rm -rf /tmp/pub
