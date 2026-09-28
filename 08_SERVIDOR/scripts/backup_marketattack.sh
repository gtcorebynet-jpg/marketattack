#!/usr/bin/env bash
D=/var/backups/marketattack
mkdir -p "$D"
TS=$(date +%Y-%m-%d_%H%M)
tar czf "$D/web_$TS.tar.gz" -C /var/www marketattack 2>/dev/null
ls -1t "$D"/web_*.tar.gz 2>/dev/null | tail -n +8 | xargs -r rm -f
echo "$(date '+%F %T') backup OK: web_$TS.tar.gz" >> /var/log/marketattack_backup.log
