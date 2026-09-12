#!/bin/bash
BIN=/tmp/opencode/cloudflared
export NO_AUTOUPDATE=true
kill 0 2>/dev/null
rm -f /tmp/tunel.log
nohup "$BIN" tunnel --url http://localhost:8000 --no-autoupdate --no-tls-verify >/tmp/tunel.log 2>&1 &
echo $! > /tmp/tunel.pid
disown
sleep 16
kill -0 "$(cat /tmp/tunel.pid)" 2>/dev/null && echo "vivo" || echo "muerto"
grep -oE 'https://[a-z0-9]+\.trycloudflare\.com' /tmp/tunel.log | head -1
