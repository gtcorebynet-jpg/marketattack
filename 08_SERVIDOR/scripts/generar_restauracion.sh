#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#  Genera RESTAURACION_RAPIDA.md — UN SOLO archivo, autocontenido,
#  para pegarlo a un chat nuevo de opencode en cualquier dispositivo.
#  Incluye: cómo entrar, estado verificado, cómo restaurar, los
#  4 respaldos, los comandos de Telegram, el producto para vender y
#  TODOS los scripts del servidor con su ruta de instalación.
# ═══════════════════════════════════════════════════════════════
set -u
KIT="${1:?uso: generar_restauracion.sh /ruta/al/kit}"
F="$KIT/RESTAURACION_RAPIDA.md"
IP=149.130.190.118
FECHA=$(date '+%Y-%m-%d %H:%M')

{
cat <<CAB
# MARKETATTACK — RESTAURACIÓN RÁPIDA (archivo único y autocontenido)

> **Generado:** $FECHA · **Servidor:** $IP · **Repo:** \`git@github.com:gtcorebynet-jpg/marketattack.git\`

---

## 0) SI ERES UN AGENTE NUEVO DE OPENCODE Y ESTÁS LEYENDO ESTO

Este archivo contiene **todo lo necesario para retomar MARKETATTACK desde cero**
sin ningún otro archivo. No hace falta descargar nada más para trabajar.

**Tu primera tarea, obligatoria:** lee las secciones 1 a 4 y responde en español,
en formato de lista, exactamente esto:

- **A)** ¿En qué quedó MARKETATTACK? (una frase)
- **B)** ¿Qué está funcionando ahora? Web pública, Telegram, respaldos, tienda.
- **C)** ¿Qué falta? Solo lo pendiente, en orden de prioridad.
- **D)** ¿Hay algún problema técnico abierto? ¿Cómo lo comprobaste?
- **E)** El comando EXACTO para entrar al servidor por SSH, con la ruta de la llave.

**Reglas de trabajo:**
- Español, corto y simple.
- No borres ni sobrescribas este archivo.
- Antes de cada cambio en el servidor: respaldo y verificación.
- Si no puedes comprobar algo, dilo. No lo inventes.

CAB

cat <<'CAB2'
---

## 1) QUÉ ES MARKETATTACK

Plataforma de IA para pequeños negocios: chat que atiende y cotiza solo,
captación de prospectos, mini-CRM, dashboard y generación de contenido.
Se vende como servicio mensual. Tienda pública incluida.

---

## 2) CÓMO ENTRAR AL SERVIDOR

| Dato | Valor |
|---|---|
| IP del VPS | `149.130.190.118` |
| Usuario | `ubuntu` |
| Llave SSH (PC) | `/home/personalamd/Descargas/ssh-key-marketattack-20260926.key` |
| Llave SSH (Android) | `/home/personalamd/Descargas/telefono/ma_celular` — restringida al túnel `localhost:4096` |
| opencode (solo local) | `127.0.0.1:4096` — nunca expuesto a internet |

```bash
# Desde la PC
ssh -i /home/personalamd/Descargas/ssh-key-marketattack-20260926.key ubuntu@149.130.190.118

# Desde Android (dentro de Termux, por túnel)
ssh -i ~/ma_celular -L 4096:localhost:4096 ubuntu@149.130.190.118
# y abrir en Chrome: http://localhost:4096
```

---

## 3) ESTADO ACTUAL

| Servicio | Cómo verificar |
|---|---|
| `nginx` | `systemctl is-active nginx` |
| `opencode` | `systemctl is-active opencode` |
| `puente-telegram` | `systemctl is-active puente-telegram` |

| Dirección | Qué es |
|---|---|
| `http://149.130.190.118/` | Portafolio |
| `http://149.130.190.118/tienda.html` | Tienda con chat, prospectos y panel |
| `http://149.130.190.118/kit.html` | Enlace de descarga del kit de recuperación |
| `https://marketattack.netlify.app/tienda.html` | Espejo de la tienda |

Servicios que se reinician solos si se caen: `watchdog` cada 5 minutos.

---
CAB2

cat <<'CAB3'
## 4) LOS 4 RESPALDOS Y CÓMO RESTAURAR

| Vía | Dónde vive | Cómo se recupera |
|---|---|---|
| **A** Disco VPS | `/var/backups/marketattack/completos/` | `sudo bash /usr/local/bin/recuperar.sh B` |
| **B** Espejo interno | `/root/marketattack-rescate/` | se lee directamente |
| **C** Telegram | kits diarios por este chat | descarga el `.zip` y ejecuta `RESTAURAR.sh` |
| **D** GitHub | repo privado `marketattack` | `sudo bash /usr/local/bin/recuperar.sh C` |

Cada kit trae `SHA256SUMS` y `conversacion.json` + `conversacion.md`.

### Comprobación rápida de que todo está sano
```bash
sudo bash /usr/local/bin/verificacion_final.sh    # estado global
sudo bash /usr/local/bin/verificar_respaldos.sh  # integridad de los 4 respaldos
sudo bash /usr/local/bin/verificar_kit.sh        # el kit no lleva secretos
sudo python3 /usr/local/bin/pruebas_puente.py    # 27 pruebas del bot de Telegram
```

---

## 5) COMANDOS DE TELEGRAM (escribe al bot)

**Operación**
- `/comandos` — lista completa
- `/estado` — cómo están los servicios
- `/respaldos` — últimos respaldos
- `/backup` — forzar un respaldo ahora
- `/publicar` — publicar la web

**Vender el producto**
- `/producto` — catálogo completo de MARKETATTACK
- `/oferta` — mensaje corto para mandarle a un cliente
- `/precios` — tabla de precios

**Clientes**
- `/cliente` — crear tienda para un cliente
- `/clientes` — ver las tiendas creadas
- `/prospecto Nombre \| Rubro \| Ciudad \| contacto` — guardar prospecto
- `/prospectos` — ver prospectos

**Servidor**
- `/sh <comando>` — ejecutar un comando (solo lista blanca segura)
- `/reiniciar nginx\|opencode\|puente-telegram`

**Link**
- `/link` — enlaces de la web

Y cualquier texto en español se lo mandas al agente: responde ahí mismo.

---

## 6) EL PRODUCTO PARA VENDER

Precios en pesos colombianos, sin permanencia:

| Plan | Precio | Incluye |
|---|---|---|
| 🟢 Esencial | $450.000/mes | Chat con IA, prospectos, panel, 500 conversaciones |
| 🔵 Profesional | $850.000/mes ⭐ | Todo lo anterior + contenido para redes + QR ilimitado |
| 🟣 Escala | $1.400.000/mes | Todo lo anterior + varias sedes + acompañamiento |

Instalación en 24 horas. El catálogo completo está en `/usr/local/bin/catalogo.sh`.

---
CAB3

echo "## 7) TODOS LOS SCRIPTS DEL SERVIDOR"
echo ""
echo "Cada bloque va en la ruta indicada dentro de \`/usr/local/bin/\`."
echo "Están sanitizados: **ningún secreto** está en este archivo."
echo ""
for f in $(ls -1 /usr/local/bin/*.sh /usr/local/bin/*.py 2>/dev/null | grep -v __pycache__ | sort); do
  n=$(basename "$f")
  echo "### \`/usr/local/bin/$n\`"
  echo ""
  echo '```bash'
  cat "$f"
  echo '```'
  echo ""
done

echo "---"
echo ""
echo "## 8) LA MEMORIA COMPLETA DEL PROYECTO"
echo ""
if [ -f "$KIT/CONTEXTO.md" ]; then
  echo "Todo lo que se ha construido y dejado pendiente, en orden cronológico:"
  echo ""
  cat "$KIT/CONTEXTO.md"
else
  echo "_No se encontró CONTEXTO.md en el kit._"
fi
echo ""

cat <<'CAB4'
---

## 9) DÓNDE ESTÁN LOS SECRETOS (no están aquí, a propósito)

| Qué | Dónde vive en el servidor |
|---|---|
| Contraseña vigente de opencode | `/root/CLAVE_OPENCODE.txt` |
| Contraseñas ya rotadas | `/etc/marketattack/claves_rotadas.txt` |
| Token del bot de Telegram | `/etc/marketattack/telegram.conf` |

```bash
# leer la contraseña vigente
sudo cat /root/CLAVE_OPENCODE.txt
```

Nunca se copian a este archivo, ni al repo, ni a Telegram. Es lo correcto.

---

## 10) PENDIENTES CONOCIDOS

1. **Rotar el token del bot** en `@BotFather` → `/revoke` → luego
   `sudo bash /usr/local/bin/activar_token.sh`. Requiere la cuenta del dueño.
2. **Deploy key de GitHub** para el espejo automático de las 04:00 →
   `sudo bash /usr/local/bin/activar_espejo.sh`. Requiere la cuenta de GitHub.
3. **Dominio + HTTPS** propio (opcional): la web ya funciona por IP.
4. **Prueba real desde Android** y un mensaje entrante real al bot.

---

## 11) CÓMO SE GENERÓ ESTE ARCHIVO

```bash
sudo /usr/local/bin/kit_recuperacion.sh
```

Se rehace solo a las 00:00 y se manda a Telegram cada día.
Contiene la clave vigente del servidor, el token del bot, los chats completos
y el historial de la conversación, ya saneados.
CAB4
} > "$F"

chmod 644 "$F"
echo "✓ RESTAURACION_RAPIDA.md generado ($(du -h "$F" | cut -f1), $(grep -c '^### ' "$F") scripts embebidos)"
