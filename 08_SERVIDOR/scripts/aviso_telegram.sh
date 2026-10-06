#!/usr/bin/env bash
# ═══ AVISOS POR TELEGRAM — MARKETATTACK ═══
# Estado: instalado y probado. Para ACTIVAR solo falta poner el token y el chat_id
# en /etc/marketattack/telegram.conf (2 lineas) — instrucciones en CONTEXTO.md

CFG=/etc/marketattack/telegram.conf
[ -f "$CFG" ] || { echo "sin configurar"; exit 0; }
. "$CFG"

[ -n "$TELEGRAM_TOKEN" ] && [ -n "$TELEGRAM_CHAT_ID" ] || { echo "sin configurar"; exit 0; }

MSG="$1"
[ -z "$MSG" ] && { echo "falta el mensaje"; exit 1; }

# limite de Telegram: 4096 caracteres
MSG="${MSG:0:4000}"

curl -s --max-time 20 -X POST \
  "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
  -d chat_id="${TELEGRAM_CHAT_ID}" \
  -d parse_mode=HTML \
  -d disable_web_page_preview=true \
  --data-urlencode "text=${MSG}" >/dev/null
echo "enviado"
