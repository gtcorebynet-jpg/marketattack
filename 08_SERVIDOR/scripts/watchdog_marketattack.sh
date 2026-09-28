#!/usr/bin/env bash
C=$(curl -s -o /dev/null -w '%{http_code}' --max-time 8 http://127.0.0.1/tienda.html)
LOG=/var/log/marketattack_watchdog.log
if [ "$C" != "200" ]; then
  echo "$(date '+%F %T') ALERTA tienda=$C -> reiniciando nginx" >> $LOG
  /usr/local/bin/aviso_telegram.sh "🚨 <b>MARKETATTACK CAIDO</b>
La tienda respondio <code>$C</code>.
Reiniciando nginx automaticamente..." 
  systemctl restart nginx
  sleep 4
  C2=$(curl -s -o /dev/null -w '%{http_code}' --max-time 8 http://127.0.0.1/tienda.html)
  echo "$(date '+%F %T') tras reinicio: $C2" >> $LOG
  if [ "$C2" = "200" ]; then
    /usr/local/bin/aviso_telegram.sh "✅ <b>RECUPERADO</b>
La tienda volvio a responder 200.
Backup automatico: diario 3:00 AM."
  else
    /usr/local/bin/aviso_telegram.sh "🛑 <b>SIGUE CAIDA</b>
La tienda responde <code>$C2</code> despues de reiniciar.
Hay que revisarla manualmente."
  fi
else
  echo "$(date '+%F %T') OK tienda=200" >> $LOG
fi
