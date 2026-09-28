#!/usr/bin/env bash
# ═══ Verificador independiente de tiendas ═══
# uso: verificar_tienda.sh <slug>   (o "todas")
set -u
WEB=/var/www/marketattack
IP=149.130.190.118
fallos=0

verificar() {
  s="$1"; fallos=0
  echo "  ── $s ──"
  [ -d "$WEB/clientes/$s" ] || { echo "     ❌ la carpeta no existe"; return 1; }

  c=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "http://127.0.0.1/clientes/$s/tienda.html")
  [ "$c" = "200" ] && echo "     ✅ tienda 200" || { echo "     ❌ tienda $c"; fallos=$((fallos+1)); }

  js=$(curl -s --max-time 10 "http://127.0.0.1/clientes/$s/assets/demo.js")
  n=$(printf '%s' "$js" | grep -c '"nombre":')
  [ "$n" -gt 0 ] && echo "     ✅ $n productos cargados" || { echo "     ❌ 0 productos"; fallos=$((fallos+1)); }

  printf '%s' "$js" | grep -q "\"$s\"" \
    && echo "     ✅ datos del cliente correctos" \
    || { echo "     ❌ los datos NO corresponden a $s"; fallos=$((fallos+1)); }

  w=$(printf '%s' "$js" | grep -oE '"whatsapp": "[0-9]{6,}"' | head -1)
  [ -n "$w" ] && echo "     ✅ WhatsApp $w" || { echo "     ❌ WhatsApp inválido"; fallos=$((fallos+1)); }

  q=$(curl -s -o /tmp/_qr.bin -w "%{http_code}" --max-time 10 "http://127.0.0.1/clientes/$s/qr.png")
  if [ "$q" = "200" ] && [ -s /tmp/_qr.bin ]; then
    if head -c 4 /tmp/_qr.bin | od -An -tx1 | grep -q "89 50 4e 47"; then
      echo "     ✅ QR válido ($(stat -c%s /tmp/_qr.bin) bytes)"
    else echo "     ❌ el QR no es un PNG"; fallos=$((fallos+1)); fi
  else echo "     ❌ QR $q"; fallos=$((fallos+1)); fi

  e=$(curl -s -o /dev/null -w "%{http_code}" --max-time 12 "http://$IP/clientes/$s/tienda.html")
  [ "$e" = "200" ] && echo "     ✅ visible en internet ($IP)" || { echo "     ❌ internet $e"; fallos=$((fallos+1)); }
  return $fallos
}

if [ "${1:-todas}" = "todas" ]; then
  L=$(ls -1 "$WEB/clientes" 2>/dev/null)
  [ -z "$L" ] && { echo "No hay tiendas todavía."; exit 0; }
  for s in $L; do verificar "$s"; [ $? -ne 0 ] && fallos=$((fallos+1)); done
else
  verificar "$1"
  fallos=$?
fi
echo ""
if [ "$fallos" = "0" ]; then echo "🎉 TODO CORRECTO"; else echo "🚨 $fallos PROBLEMAS"; fi
exit $fallos
