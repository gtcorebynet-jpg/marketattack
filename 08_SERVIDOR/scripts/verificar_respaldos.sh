#!/bin/bash
# Verifica que los respaldos estén completos, íntegros y NO dependan de un solo sitio.
BASE=/var/backups/marketattack/completos
ESPEJO=/root/marketattack-rescate
malos=0

echo "═══ VERIFICACIÓN DE RESPALDOS ═══"
echo ""
for VIA in "$BASE" "$ESPEJO"; do
  NOMBRE=$([ "$VIA" = "$BASE" ] && echo "VÍA A (disco principal)" || echo "VÍA B (espejo)")
  echo "$NOMBRE — $VIA"
  n=$(sudo find "$VIA" -name 'completo_*.tar.gz' | wc -l)
  if [ "$n" -eq 0 ]; then echo "  ⚠ sin respaldos"; malos=$((malos+1)); else echo "  $n respaldos"; fi
  for f in $(sudo find "$VIA" -name 'completo_*.tar.gz' | sort -r); do
    b=$(basename "$f")
    if sudo tar -tzf "$f" >/dev/null 2>&1; then
      # validar los SHA256 de dentro
      sudo mkdir -p /tmp/vr && sudo rm -rf /tmp/vr/* && sudo tar -xzf "$f" -C /tmp/vr 2>/dev/null
      if sudo test -f /tmp/vr/SHA256SUMS && (cd /tmp/vr && sudo sha256sum -c --quiet SHA256SUMS >/dev/null 2>&1); then
        echo "  ✓ $b íntegro ($(sudo du -h $f | cut -f1))"
      else
        echo "  ✗ $b CORRUPTO (checksums no cuadran)"; malos=$((malos+1))
      fi
      sudo rm -rf /tmp/vr
    else
      echo "  ✗ $b NO SE PUEDE LEER"; malos=$((malos+1))
    fi
  done
  echo ""
done

# ¿coinciden las dos vías?
echo "COHERENCIA ENTRE VÍAS"
a=$(sudo find "$BASE" -name 'completo_*.tar.gz' -printf '%f\n' | sort | tail -1)
b=$(sudo find "$ESPEJO" -name 'completo_*.tar.gz' -printf '%f\n' | sort | tail -1)
if [ -n "$a" ] && [ "$a" = "$b" ]; then echo "  ✓ ambas vías tienen el mismo respaldo más reciente: $a"
else echo "  ⚠ difieren: vía A='$a' vía B='$b'"; fi

echo ""
echo "Telegram"
k=$(sudo find /var/backups/marketattack/kits -name '*.zip' | wc -l)
echo "  $k kit(s) guardado(s) — se envían a Telegram cada día 00:00"

echo ""
if [ "$malos" -eq 0 ]; then echo "RESULTADO: todos los respaldos íntegros"; else echo "RESULTADO: $malos PROBLEMAS"; exit 1; fi
