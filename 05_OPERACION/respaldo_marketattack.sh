#!/usr/bin/env bash
# =========================================================================
# MARKETATTACK — Respaldo local automático
# Crea una copia comprimida con fecha de 04_MARKETATTACK
# En:  /mnt/proyectos/05_RESPALDOS/marketattack_AAAAMMDD_HHMM.tar.gz
# Uso: bash respaldo_marketattack.sh
# =========================================================================
set -e

ORIGEN="/mnt/proyectos/04_MARKETATTACK"
DESTINO="/mnt/proyectos/05_RESPALDOS"
FECHA=$(date +"%Y%m%d_%H%M")
ARCHIVO="$DESTINO/marketattack_$FECHA.tar.gz"

mkdir -p "$DESTINO"

# Comprimir excluyendo copias de seguridad internas (evita duplicados)
tar --exclude="$ORIGEN/copia_seguridad" \
    -czf "$ARCHIVO" -C "$(dirname "$ORIGEN")" "$(basename "$ORIGEN")"

# Conservar las últimas 12 copias (sobrescribe limpieza manual)
# ls -1t $DESTINO/marketattack_*.tar.gz | tail -n +13 | xargs -r rm -f

echo "✅ Respaldo creado:"
echo "   $ARCHIVO ($(du -h "$ARCHIVO" | cut -f1))"
echo ""
echo "Para restaurar en cualquier momento:"
echo "   tar -xzf \"$ARCHIVO\" -C /mnt/proyectos/"
echo ""
echo "Más adelante tendrás también GitHub (nube) como segunda copia."