#!/usr/bin/env bash
# ═══ Actualización del watchdog: ahora vigila TODO, no solo nginx ═══
# Detecta páginas publicadas que se caen y las repara.
set -u
LOCK=/run/watchdog.lock
exec 9>"$LOCK" || exit 0
flock -n 9 || exit 0   # solo una instancia

LOG=/var/log/marketattack_watchdog.log
log(){ echo "$(date '+%F %T') $1" >> "$LOG"; }

fallos=0

# ── 1) nginx ──
if ! systemctl is-active --quiet nginx; then
  systemctl restart nginx 2>/dev/null
  sleep 3
  if systemctl is-active --quiet nginx; then log "❌ nginx estaba caído → reiniciado"
  else log "🚨 nginx NO se pudo reiniciar"; fallos=$((fallos+1)); fi
fi

# ── 2) opencode (el chat) ──
if ! systemctl is-active --quiet opencode; then
  systemctl restart opencode 2>/dev/null
  sleep 8
  if systemctl is-active --quiet opencode; then log "❌ opencode estaba caído → reiniciado"
  else log "🚨 opencode NO se pudo reiniciar"; fallos=$((fallos+1)); fi
fi

# ── 3) puente de Telegram ──
if ! systemctl is-active --quiet puente-telegram; then
  systemctl restart puente-telegram 2>/dev/null
  sleep 5
  if systemctl is-active --quiet puente-telegram; then log "❌ puente Telegram caído → reiniciado"
  else log "🚨 puente Telegram NO se pudo reiniciar"; fallos=$((fallos+1)); fi
fi

# ── 4) páginas públicas: si la principal cae, re-publicar ──
IP=149.130.190.118
for u in "/" "/tienda.html" "/kit.html"; do
  c=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "http://127.0.0.1$u")
  if [ "$c" != "200" ]; then
    log "❌ $u devolvió $c → re-publicando"
    /usr/local/bin/publicar.sh >/dev/null 2>&1
    sleep 3
    c2=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "http://127.0.0.1$u")
    if [ "$c2" = "200" ]; then log "   ✓ $u recuperada (200)"
    else log "🚨 $u sigue en $c2"; fallos=$((fallos+1)); fi
  fi
done

# ── 5) tiendas de clientes: avisar si alguna se rompe ──
if [ -d /var/www/marketattack/clientes ]; then
  for d in /var/www/marketattack/clientes/*/; do
    [ -d "$d" ] || continue
    s=$(basename "$d")
    c=$(curl -s -o /dev/null -w "%{http_code}" --max-time 8 "http://127.0.0.1/clientes/$s/tienda.html")
    [ "$c" = "200" ] || { log "🚨 tienda '$s' caída ($c)"; fallos=$((fallos+1)); }
  done
fi

# ── 6) disco lleno ──
U=$(df -P / | awk 'NR==2{gsub("%","",$5); print $5}')
if [ "${U:-0}" -gt 90 ]; then
  log "⚠ disco al ${U}% → limpiando respaldos antiguos"
  find /var/backups/marketattack -name "*.tar.gz" -mtime +7 -delete 2>/dev/null
  [ "${U:-0}" -gt 95 ] && fallos=$((fallos+1))
fi

# ── 7) aviso si algo está mal ──
if [ "$fallos" -gt 0 ]; then
  echo "$(date '+%F %T') Watchdog: $fallos problema(s) detectado(s)" >> "$LOG"
fi
exit 0
