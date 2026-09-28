# 08_SERVIDOR · Configuración del VPS

Todo lo que hace que MARKETATTACK funcione **sin la PC**, en el servidor Oracle
(`149.130.190.118`).

> 🔒 **Nada de secretos en este repo.** El `opencode.service` y el
> `telegram.conf.EJEMPLO` llevan marcadores `CAMBIAR_ESTA`. Los secretos reales
> viven solo en el servidor, en:
> - `/etc/systemd/system/opencode.service` → `OPENCODE_SERVER_PASSWORD`
> - `/etc/marketattack/telegram.conf` → token del bot (permisos `600`)

## Estructura

| Ruta | Qué es |
|---|---|
| `config/opencode.service` | Servicio systemd del servidor de opencode (puerto 4096, solo local) |
| `config/telegram.conf.EJEMPLO` | Plantilla de configuración del bot |
| `scripts/publicar.sh` | Sube `02_DEMO` a `/var/www/marketattack` con `rsync` |
| `scripts/backup_marketattack.sh` | Respaldo diario 3:00 AM, guarda 7 copias |
| `scripts/watchdog_marketattack.sh` | Revisa nginx cada 5 min y lo reinicia si cae |
| `scripts/informe_diario.sh` | Informe diario 8:00 AM |
| `scripts/qr_tienda.py` | Genera el QR de cualquier URL |
| `scripts/nuevo_cliente.py` | **Crea la tienda de un cliente** (la base del servicio) |
| `scripts/verificar_tienda.sh` | Audita una tienda: web, datos, WhatsApp, QR |
| `scripts/puente_telegram.py` | Puente Telegram → opencode |

## Servicios

```bash
sudo systemctl status opencode puente-telegram nginx
sudo systemctl restart puente-telegram     # tras tocar el puente
```

## Crear la tienda de un cliente

```bash
sudo /usr/local/bin/nuevo_cliente.py \
  --nombre "Tienda Don Pepe" \
  --whatsapp "573001234567" \
  --tagline "Los mejores arepas de Soacha" \
  --horario "Lun-Sab 8am-8pm" \
  --ubicacion "Soacha y alrededores" \
  --menu "Arepa con pollo|12000|Pollo, queso y arepa" \
  --menu "Jugo de mango|5000|Natural 400ml"

sudo /usr/local/bin/verificar_tienda.sh todas
```

Cada producto va como `nombre | precio | descripción`. El precio puede ir con o
sin `$`. El WhatsApp se limpia solo (quita `+`, espacios y guiones).

## Verificación (no confíes, comprueba)

```bash
curl -s -o /dev/null -w "%{http_code}\n" http://149.130.190.118/tienda.html
sudo /usr/local/bin/verificar_tienda.sh todas
```

⚠️ nginx está configurado con `try_files ... =404` a propósito: si una página no
existe devuelve **404 real**, no la portada. Un `200` engañoso fue un bug real
que ya se corrigió.

## Acceso desde el celular

El puerto 4096 **nunca** se abre a internet. Desde Android/Termux:

```bash
ssh -N -L 4096:localhost:4096 -i ~/.ssh/ma_celular ubuntu@149.130.190.118
# luego abrir http://127.0.0.1:4096  (usuario: opencode)
```

## Copias de seguridad

- Respaldo diario 3:00 AM → `/var/backups/marketattack/web_*.tar.gz` (7 copias)
- Respaldo antes de cada publicación de cliente
- Los `.zip` de paquetes NUNCA se suben a este repo (contienen el chat)
