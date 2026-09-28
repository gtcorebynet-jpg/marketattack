#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  RESPALDO AUTOMÁTICO — MARKETATTACK
#  Guarda una copia local fechada y, si hay credencial, sube a GitHub.
#  Se activa con cron (ver --instalar abajo). Todo gratis.
# ═══════════════════════════════════════════════════════════════
set -u
P="${MARKETATTACK_PATH:-/mnt/proyectos/04_MARKETATTACK}"
R="$P/05_RESPALDOS"
TS="$(date +%Y-%m-%d_%H%M)"
Z="$R/AUTO_respaldo_$TS.zip"

mkdir -p "$R"

# ── 1) copia local (siempre, no requiere internet ni cuentas) ──
cd "$P" 2>/dev/null || { echo "✗ no encuentro $P"; exit 1; }
zip -rq "$Z" CONTEXTO.md 02_DEMO 05_CLIENTES 06_DIFUSION 07_KIT_RESCATE 2>/dev/null
if [ -f "$Z" ]; then
  echo "✓ copia local: $(basename "$Z") ($(stat -c%s "$Z") bytes)"
else
  echo "✗ falló la copia local"; exit 1
fi

# ── 2) rotación: conserva los últimos 10 respaldos automáticos ──
ls -1t "$R"/AUTO_respaldo_*.zip 2>/dev/null | tail -n +11 | while read -r old; do
  rm -f "$old" && echo "  (purgado respaldo viejo: $(basename "$old"))"
done

# ── 3) subida a GitHub, SOLO si ya hay credencial configurada ──
GH_DIR="$HOME/.config/gh/hosts.yml"
if [ -f "$GH_DIR" ] && grep -q oauth_token "$GH_DIR" 2>/dev/null; then
  cd "$(git -C "$P" rev-parse --show-toplevel 2>/dev/null || echo "$P")" 2>/dev/null
  if [ -d .git ] && command -v git >/dev/null 2>&1; then
    git add -A >/dev/null 2>&1
    if git diff --cached --quiet >/dev/null 2>&1; then
      echo "· sin cambios nuevos que subir"
    else
      git commit -m "respaldo automático $TS" >/dev/null 2>&1 \
        && git push >/dev/null 2>&1 \
        && echo "✓ subido a GitHub (respaldo en la nube)" \
        || echo "· no se pudo subir a GitHub (se conserva la copia local)"
    fi
  else
    echo "· sin repo git inicializado en $P (se conserva la copia local)"
  fi
else
  echo "· GitHub sin credencial en este equipo → solo copia local (normal si aún no la configuraste)"
fi

echo "✓ respaldo automático terminado: $TS"
