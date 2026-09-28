#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  RESTAURAR MARKETATTACK  —  script de 1 clic
#  Uso:  bash restaurar.sh
#  Regresa el proyecto, mi configuración y nuestra conversación.
#  NO borra nada: si algo ya existe, lo respalda con fecha antes de tocarlo.
# ═══════════════════════════════════════════════════════════════
set -u
KIT="$(cd "$(dirname "$0")" && pwd)"
DEST="${MARKETATTACK_DEST:-$HOME/MARKETATTACK}"
TS="$(date +%Y-%m-%d_%H%M%S)"
say(){ printf '%s\n' "$*"; }
sep(){ say "───────────────────────────────────────────────"; }

say ""
say "  🛟 RESTAURACIÓN DE MARKETATTACK"
say "  Kit: $KIT"
sep

# ── 0) ¿estamos en el folder correcto del kit?
if [ ! -f "$KIT/CONTEXTO.md" ] && [ ! -d "$KIT/proyecto" ]; then
  say "  ✗ No encuentro CONTEXTO.md ni proyecto/ dentro de este kit."
  say "    ¿Abriste la carpeta correcta del kit? Vuelve a ejecutar aquí."
  exit 1
fi

# ── 1) RESTAURAR EL PROYECTO ──
sep; say "  [1/4] Proyecto → $DEST"
mkdir -p "$DEST"
if [ -d "$KIT/proyecto" ]; then
  if [ -d "$DEST/02_DEMO" ]; then
    BK="$DEST/_respaldo_antes_de_restaurar_$TS"
    say "      ya había un proyecto → lo guardo en: $(basename "$BK")"
    mkdir -p "$BK" && cp -a "$DEST/." "$BK/" 2>/dev/null
  fi
  cp -a "$KIT/proyecto/." "$DEST/" 2>/dev/null
  say "      ✓ copiado: web, clientes, QR, textos y respaldos"
else
  say "      ⚠ el kit no trae carpeta proyecto/ (solo memoria + chat)"
fi
# CONTEXTO.md siempre a la mano
[ -f "$KIT/CONTEXTO.md" ] && cp -f "$KIT/CONTEXTO.md" "$DEST/CONTEXTO.md" 2>/dev/null && say "      ✓ CONTEXTO.md (la memoria) en $DEST/CONTEXTO.md"
sep

# ── 2) RESTAURAR MI CONFIGURACIÓN ──
sep; say "  [2/4] Configuración de opencode"
CFGDIR="$HOME/.config/opencode"
if [ -f "$KIT/config/opencode.jsonc" ]; then
  mkdir -p "$CFGDIR"
  [ -f "$CFGDIR/opencode.jsonc" ] && cp -f "$CFGDIR/opencode.jsonc" "$CFGDIR/opencode.jsonc.bak_$TS" 2>/dev/null
  cp -f "$KIT/config/opencode.jsonc" "$CFGDIR/opencode.jsonc" 2>/dev/null
  say "      ✓ configuración lista en ~/.config/opencode/"
else
  say "      ⚠ el kit no trae config/ (puedes copiarla a mano de la carpeta config/)"
fi
sep

# ── 3) RESTAURAR NUESTRA CONVERSACIÓN ──
sep; say "  [3/4] Nuestra conversación (chat)"
DBDIR="$HOME/.local/share/opencode"
if [ -f "$KIT/chat/opencode.db" ]; then
  mkdir -p "$DBDIR"
  if [ -f "$DBDIR/opencode.db" ]; then
    say "      ya había un chat aquí → lo respaldo: opencode.db.bak_$TS"
    cp -f "$DBDIR/opencode.db" "$DBDIR/opencode.db.bak_$TS" 2>/dev/null
    # -( WAL / SHM: se necesitan para consistencia si existen en el kit )
    for S in opencode.db-wal opencode.db-shm; do
      [ -f "$KIT/chat/$S" ] && cp -f "$KIT/chat/$S" "$DBDIR/$S" 2>/dev/null
    done
  fi
  cp -f "$KIT/chat/opencode.db" "$DBDIR/opencode.db" 2>/dev/null
  [ -f "$KIT/chat/opencode.db-wal" ] && cp -f "$KIT/chat/opencode.db-wal" "$DBDIR/opencode.db-wal" 2>/dev/null
  [ -f "$KIT/chat/opencode.db-shm" ] && cp -f "$KIT/chat/opencode.db-shm" "$DBDIR/opencode.db-shm" 2>/dev/null
  say "      ✓ chat copiado a ~/.local/share/opencode/opencode.db"
  say "        (CIERRA opencode antes de abrirlo, para que lea bien el archivo)"
else
  say "      ⚠ el kit no trae chat/ (puedes copiar opencode.db a ~/.local/share/opencode/)"
fi
sep

# ── 4) VERIFICACIÓN + SIGUIENTE PASO ──
sep; say "  [4/4] Verificación"
[ -f "$DEST/CONTEXTO.md" ] && say "      ✓ CONTEXTO.md presente" || say "      ✗ falta CONTEXTO.md"
[ -d "$DEST/02_DEMO" ]    && say "      ✓ web (02_DEMO) presente" || say "      · sin 02_DEMO (opcional)"
[ -f "$DBDIR/opencode.db" ] && say "      ✓ chat presente"        || say "      · sin chat (opcional)"
sep
say ""
say "  ✅ ¡RESTAURACIÓN TERMINADA!"
say ""
say "  ▶ AHORA HAZ ESTO:"
say "    1) Abre opencode  y elige la carpeta:  $DEST"
say "    2) Ahí你应该 ver nuestra conversación. Si no aparece, ciérralo y reabrelo."
say "    3) Escríbeme:  \"lee CONTEXTO.md\"   ← y yo retomo donde dejamos."
say ""
say "  (Si la web debe verse local:  cd \"$DEST/02_DEMO\" && python3 -m http.server 8000 )"
say ""
