#!/usr/bin/env bash
# ═══ Informe diario automático: llega a Telegram cada mañana ═══
set -u
exec 9>/run/informe.lock || exit 0
flock -n 9 || exit 0

IP=149.130.190.118
T=/usr/local/bin/aviso_telegram.sh

estado(){
  c=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "http://127.0.0.1$u")
  [ "$c" = "200" ] && echo "✅ $u" || echo "❌ $u ($c)"
}

N_CLIENTES=$(ls -1 /var/www/marketattack/clientes/ 2>/dev/null | wc -l)
N_TIENDAS=$(curl -s --max-time 8 "http://127.0.0.1/clientes/" 2>/dev/null | wc -c)

MSG="📅 <b>INFORME DIARIO · MARKETATTACK</b>
$(date '+%A %d de %B de %Y, %H:%M')

<b>Servicios</b>
$(for u in "/" "/tienda.html" "/kit.html"; do echo "  $(estado)"; done)
  opencode: $(systemctl is-active opencode) · telegram: $(systemctl is-active puente-telegram)

<b>Tiendas de clientes</b>
  ${N_CLIENTES} publicada(s)

<b>Respaldos</b>
  $(ls -1 /var/backups/marketattack/*.tar.gz 2>/dev/null | wc -l) diarios
  $(du -sh /var/backups/marketattack 2>/dev/null | cut -f1) en disco

<b>Recursos</b>
  💾 $(df -h / | awk 'NR==2{print $4" de "$2}')
  🧠 $(free -m | awk '/Mem:/{print $7" MB"}')
  ⏱️ $(uptime -p)

<b>Seguridad</b>
  🔑 llaves autorizadas: $(sudo wc -l < /home/ubuntu/.ssh/authorized_keys)
$(sudo /usr/local/bin/verificar_tienda.sh todas 2>/dev/null | tail -1)"

bash "$T" "$MSG"
