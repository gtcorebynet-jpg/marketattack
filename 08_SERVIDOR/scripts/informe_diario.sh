#!/usr/bin/env bash
S=$(curl -s -o /dev/null -w '%{http_code}' --max-time 8 http://127.0.0.1/tienda.html)
D=$(df -h / | tail -1 | awk '{print $4" libres de "$2}')
R=$(free -m | awk '/Mem:/{print $7" MB libres de "$2}')
B=$(ls -1t /var/backups/marketattack/ 2>/dev/null | head -1)
E=$(ls -1t /var/backups/marketattack/ 2>/dev/null | wc -l)
/usr/local/bin/aviso_telegram.sh "📊 <b>MARKETATTACK — estado diario</b>
Tienda: <b>$S</b> $( [ "$S" = 200 ] && echo '✅' || echo '❌' )
Disco: $D
RAM: $R
Ultimo backup: ${B:-sin respaldos}
Respaldos guardados: $E
Respaldo automatico: diario 3:00 AM (sin PC)"
