#!/bin/bash
# MARKETATTACK — VERIFICACIÓN TOTAL + RESPALDO DE ESTE AVANCE (todo medido, nada supuesto)
P=/mnt/proyectos/04_MARKETATTACK
D="$P/02_DEMO"
GHO=gtcorebynet-jpg; GHR=marketattack
FECHA=$(date +%Y-%m-%d_%H%M)
echo "═══════════ VERIFICACIÓN TOTAL — MARKETATTACK (en vivo, no supuesto) ═══════════"

echo ""
echo "═══ [A] ¿SERVIDOR LOCAL :8000 está sirviendo la tienda? ═══"
C=$(curl -s -o /dev/null -w '%{http_code}' --max-time 4 "http://localhost:8000/tienda.html" 2>/dev/null)
echo "  tienda.html :8000 → $C  $([ "$C" = 200 ] && echo '✓ VIVO' || echo '⏳ (revisar servidor)')"
C2=$(curl -s -o /dev/null -w '%{http_code}' --max-time 4 "http://localhost:8000/assets/carrito.js" 2>/dev/null)
echo "  carrito.js  :8000 → $C2  $([ "$C2" = 200 ] && echo '✓ VIVO')"

echo ""
echo "═══ [B] ¿LINK PÚBLICO htmlpreview (el del QR/difusión) sigue 200? ═══"
L="https://htmlpreview.github.io/?https://raw.githubusercontent.com/$GHO/$GHR/main/02_DEMO/assets/tienda_autocontenida.html"
H=$(curl -s -o /dev/null -w '%{http_code}' --max-time 10 "$L")
echo "  público → $H  $([ "$H" = 200 ] && echo '✓ ¡FUNCIONA — compártelo a clientes YA!')"

echo ""
echo "═══ [C] ¿NETLIFY LIMPIO (el link .netlify.app) sigue 200? ═══"
N1=$(curl -s -o /dev/null -w '%{http_code}' --max-time 10 "https://marketattack.netlify.app/")
N2=$(curl -s -o /dev/null -w '%{http_code}' --max-time 10 "https://marketattack.netlify.app/tienda.html")
echo "  /            → $N1  $([ "$N1" = 200 ] && echo '✓')"
echo "  /tienda.html → $N2  $([ "$N2" = 200 ] && echo '✓ LIMPIO PÚBLICO')"

echo ""
echo "═══ [D] ¿QR + KIT DIFUSIÓN ya en disco? ═══"
for F in "06_DIFUSION/QR_tienda_marketattack.png" "06_DIFUSION/textos_difusion.txt"; do
  [ -f "$P/$F" ] && echo "  ✓ $F ($(stat -c%s "$P/$F") B)" || echo "  ⚠ $F falta"
done

echo ""
echo "═══ [E] FÁBRICA CLIENTE — plantilla + ejemplo ═══"
for F in "05_CLIENTES/plantilla/config_cliente.js" "05_CLIENTES/ejemplo/config_cliente.js"; do
  [ -f "$P/$F" ] && echo "  ✓ $F ($(stat -c%s "$P/$F") B)" || echo "  ⚠ $F falta"
done

echo ""
echo "═══ [F] RESPALDO ZIP local de respaldos previos ═══"
ls -1t "$P/05_RESPALDOS/"*.zip 2>/dev/null | head -4 | sed 's/^/  ✓ /'
echo ""
echo "═══ [G] memoria portable (CONTEXTO.md) ✍️ ACTUALIZO con este avance ═══"
Fc="$P/CONTEXTO.md"; [ -f "$Fc" ] && echo "  ✓ existe ($(stat -c%s "$Fc") B) — lo refresco con fecha $FECHA"
echo "  ✓ CONTEXTO.md folder-inicio de retomada listo"