#!/usr/bin/env bash
# ═══ Publica los cambios del proyecto en la web del servidor ═══
set -e
ORIGEN="/home/personalamd/Documentos/Default Project/02_DEMO"
DESTINO="/var/www/marketattack"

echo "▸ Publicando cambios..."
sudo rsync -a --delete "$ORIGEN/" "$DESTINO/"
sudo chown -R www-data:www-data "$DESTINO"

C1=$(curl -s -o /dev/null -w '%{http_code}' --max-time 8 http://127.0.0.1/tienda.html)
C2=$(curl -s -o /dev/null -w '%{http_code}' --max-time 8 http://127.0.0.1/assets/carrito.js)
if [ "$C1" = "200" ] && [ "$C2" = "200" ]; then
  echo "✓ PUBLICADO y verificado (tienda=$C1, carrito=$C2)"
  echo "  http://149.130.190.118/tienda.html"
else
  echo "⚠ ERROR al publicar (tienda=$C1 carrito=$C2)"
  exit 1
fi
