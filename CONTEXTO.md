# CONTEXTO.md — MARKETATTACK · ESTADO DEL PROYECTO (memoria portable)
# ▸ Pega ESTE archivo + la carpeta 02_DEMO a CUALQUIER PC/dispositivo,
#   ábreme ahí y dime: «lee /ruta/CONTEXTO.md» → retomo TODO sin perder nada.
# ▸ Última actualización: 2026-09-18
# ▸ REGLA BLINDADA: cada avance aprobado = 1 zip en 05_RESPALDOS/. El motor
#   (02_DEMO) JAMÁS se toca: por cliente solo cambia config_cliente.js.

## ── [1] QUÉ ES ESTO ──────────────────────────────────────────────
Tienda digital autocontenida (1 solo archivo HTML + assets) que el proveedor
cliente comparte como LINK público: tus clientes ven productos → CARITO →
pedido confirmado por WHATSAPP (el Nº del CLIENTE recibe pedidos). Programado
para crecer orgánico GRATIS ($0/mes, sin membresías): PC local + GitHub +
Netlify + Bitly + QR.

## ── [2] ESTRUCTURA REAL (verificada en /mnt/proyectos/04_MARKETATTACK/) ──
- 01_DOCUMENTACION/
- 02_DEMO/tienda.html + assets/(carrito.js, tienda_autocontenida.html, demo.js)
- 05_RESPALDOS/           ← respaldo zip de CADA avance aprobado (regla)
- 05_CLIENTES/<cliente>/config_cliente.js + RESPALDOS/  ← 1 carpeta por cliente
- 06_DIFUSION/            ← QR + textos listos-para-pegar
- 08_CLIENTES/ (o según lo ya creado)

## ── [3] LINKS VIVOS (verificados 200 en vivo, no prometidos) ──────
- LOCAL (tu PC):        http://localhost:8000/tienda.html
- PÚBLICO netlify.app:  https://marketattack.netlify.app/        ← EL LIMPIO, el del QR
- QR generado:          /05_EXPANSION/... / QR_tienda_marketattack.png
- GitHub repo público:  github.com/gtcorebynet-jpg/marketattack
  (raw sirve 200; HTMLPreview funcional si se necesita)

## ── [4] LOG DE AVANCES APROBADOS (línea por avance) ──────────────
- [2026-09-12] Demo 02_DEMO servida local :8000 (200) + respaldo zip inicial.
- [2026-09-12] Web «tienda_autocontenida» publicada (htmlpreview 200) + QR.
- [2026-09-18] Kit difusión (QR + textos listos-para-pegar) creado y respaldado.
- [2026-09-18] Netlify publicado: marketattack.netlify.app → 200 (ambas rutas).
- [2026-09-18] QR regenerado apuntando al link LIMPIO .netlify.app (escaneo OK usuario).
- [2026-09-25] Botones carrito/WhatsApp separados · servidor local relanzado (200).
- [2026-09-25] FASE 1 ✓ Kit de Rescate en 07_KIT_RESCATE/ (guía + restaurar.sh +
  chat exportado opencode.db + config + respaldo_automatico.sh + secretos.EJEMPLO).
  Zip portable: 05_RESPALDOS/KIT_RESCATE_2026-09-25_2338.zip
- [2026-09-25] FASE 2 ✓ Respaldo total subido a repo PRIVADO
  github.com/gtcorebynet-jpg/marketattack-respaldo  (verificado 404 = privado).
- [2026-09-26] FASE 3 ✓ VPS Oracle (149.130.190.118) — acceso SSH con llave
  `~/Descargas/ssh-key-2026-09-26.key`, usuario `ubuntu`, Ubuntu 24.04 (15GB/45GB/2CPU).
  · nginx instalado y sirviendo /var/www/marketattack (verificado 200 en
    /, /tienda.html, /assets/carrito.js)
  · iptables corregido: 80/443/22 aceptados ANTES de la regla REJECT + persistido
  · cron: backup diario 3:00 AM (/var/backups/marketattack) + watchdog cada 5 min
    que reinicia nginx si la web cae (/var/log/marketattack_watchdog.log)
  · nginx enabled al arrancar
  ✓ PUERTOS ABIERTOS (resuelto 2026-09-26): en "Default Security List for
    vcn-20260924-1640" → Reglas de entrada se agregaron 80 y 443 (TCP, 0.0.0.0/0).
  ✓ VERIFICADO DESDE INTERNET: http://149.130.190.118/ = 200,
    /tienda.html = 200, /assets/carrito.js = 200 (probado desde el celular con datos).
  → El VPS ya es un hosting propio y público. 2o link público del proyecto.

- [2026-09-26] PENDIENTES CERRADOS (pasos 4 y 5) ✓
  · Paso 5: servidor local http://localhost:8000/tienda.html → 200.
    Launcher permanente: 02_DEMO/encender_web.sh (tras reiniciar la PC).
  · Paso 4: LLAVE SSH ROTADA. Nueva: ~/Descargas/ssh-key-marketattack-20260926.key
    (probada, conecta OK). Vieja (ssh-key-2026-09-26.key) sigue en authorized_keys
    para no perder acceso → se elimina en Oracle cuando el usuario lo decida.

- [2026-09-26] FASE 4 · TELEGRAM — INSTALADO, SOLO FALTA ACTIVAR
  · /usr/local/bin/aviso_telegram.sh (envía alertas)
  · watchdog (cada 5 min) avisa si la web CAE y cuando se RECUPERA
  · /usr/local/bin/informe_diario.sh (8:00 AM): estado, disco, RAM, último backup
  · crons activos: 3:00 AM backup · cada 5 min watchdog · 8:00 AM informe
  · ACTIVAR: editar /etc/marketattack/telegram.conf y poner 2 datos de @BotFather:
      TELEGRAM_TOKEN="123456:ABC..."      TELEGRAM_CHAT_ID="987654321"
    (después: chmod 600 y probar con /usr/local/bin/informe_diario.sh)


## ── [4b] CÓMO RECUPERAR TODO EN OTRA PC (el "1 clic") ─────────────
1. Instalar opencode.
2. Clonar/descargar el repo privado marketattack-respaldo (o el ZIP del kit).
3. Descomprimir → `bash restaurar.sh` → restaura proyecto + config + chat.
4. Abrir opencode en la carpeta MARKETATTACK → ver la conversación.
5. Decirme: "lee CONTEXTO.md" → retomo aquí.


## ── [5] SIGUIENTE PASO PENDIENTE ─────────────────────────────────
- PRIMER CLIENTE REAL: pedirle nombre, rubro, zona, promo y SU Nº WhatsApp.
- Al recibirlo → generar su config_cliente.js + su respaldo zip + su QR propio.
- Siguiente avance con Netlify/bit.ly link corto (requiere SU sesión/token una vez).

## ── [6] CÓMO LEVANTAR TODO EN OTRO DISPOSITIVO (memoria portable) ──
1. Copia la carpeta del proyecto (o haz git clone/pull del repo público).
2. Asegura que CONTEXTO.md este junto a 02_DEMO/.
3. Ejecútame ahí y di: «lee /ruta/CONTEXTO.md» → listo, mismo contexto.
4. (Opcional) exporta esta conversación (tema: MARKETATTACK) como historial en texto
   y pásala igual: así conservamos TAMBIÉN el diálogo fino (decisiones, tu tono).

## ── [7] CREDENCIALES / SESIONES (honestidad: qué necesita TU sesión) ─
GitHub, Netlify, Bitly exigen TU autenticación la 1.ª vez (sesión o token) —
ningún agente puede generarla por ti SIN tu token. Verificado, no supuesto.
- Hazlo tú en 15 s (drag en Netlify Drop / token la primera vez), o
- Pégame TU token seguro y lo hace el agente (sin imprimirlo).

## ── [8] DECISIONES DE TONO (para conversación consistente) ────────
- Verdad medida, verificado-contigo (200/200/200), nunca links «prometidos».
- Respaldo CADA avance; el motor no se toca; práctico y breve.
- Crecimiento orgánico: solo herramientas con plan GRATIS inicial ($0).

---

## 2026-09-28 · Servicio de tiendas para clientes +/endurecimiento

### Nuevo: crear tiendas con datos por Telegram
El usuario manda los datos del cliente al bot y el servidor genera la web
completa (productos, WhatsApp, QR) y devuelve el link.

```
/cliente
Nombre: Tienda Don Pepe
WhatsApp: 573001234567
Tagline: Los mejores arepas
Horario: Lun-Sab 8am-8pm
Zona: Soacha
1. Arepa con pollo | 12000 | Pollo y queso
2. Jugo de mango | 5000 | Natural
```
Responde con el link `http://149.130.190.118/clientes/<slug>/tienda.html`
y manda el QR como foto.

Comandos: `/cliente` `/clientes` `/estado` `/respaldos` `/publicar`
`/backup` `/link` `/qr` `/leer` `/nueva` `/ayuda`

### Herramientas
| Script | Para qué |
|---|---|
| `nuevo_cliente.py` | genera la tienda de un cliente |
| `verificar_tienda.sh` | audita web + datos + WhatsApp + QR de verdad |
| `puente_telegram.py` | puente Telegram → opencode |

### Bug corregido: 200 engañoso
nginx tenía `try_files ... /index.html`, así que **toda** ruta inexistente
devolvía 200 con la portada. Ahora es `try_files ... =404`.
`nuevo_cliente.py` tampoco se fía del 200: comprueba que la página
realmente contenga los datos del cliente y que el QR sea un PNG válido.

### Watchdog v2 (antes solo miraba nginx)
Cada 5 minutos revisa: nginx, opencode, puente de Telegram, las 3 páginas
principales, **todas las tiendas de clientes** y el espacio en disco.
Si algo cae lo reinicia; si una página cae, re-publica.
Probado matando los 3 servicios: los levantó todos.

### Informe diario a Telegram
A las 8:00 AM llega el estado: páginas, servicios, número de tiendas,
respaldos, disco, RAM y resultado de la auditoría.

### Seguridad
- Llave SSH **vieja eliminada** del servidor (estuvo pegada en el chat).
  Quedan 2: `marketattack-nueva-20260926` (PC) y `telefono` (Android, solo túnel).
- Copia: `/home/ubuntu/.ssh/authorized_keys.bak-2026*`
- Backups con cron + el paquete del cliente se respaldan antes de publicar.
- `opencode` y el token del bot solo se leen desde el servidor, nunca se mandan.

### Android / Termux
El puerto 4096 **no** se abre a internet. Acceso por túnel:
```bash
ssh -N -L 4096:localhost:4096 -i ~/.ssh/ma_celular ubuntu@149.130.190.118
```
Luego, en Chrome del celular:
```
http://opencode:<CLAVE>@127.0.0.1:4096/
```
La clave va en la URL porque sin ella el servidor responde **401 con cuerpo
vacío** (por eso se veía en blanco).
El binario oficial ARM64 pide musl + libstdc++ que Termux no trae; la vía que
funciona es el tarball `opencode-linux-arm64-musl`.

---

## 2026-10-06 — Comandos por Telegram + respaldos redundantes

### Rotación de seguridad (hecho)
- Llave SSH de la PC activa: `ssh-key-marketattack-20260926.key`
  (huella `SHA256:VbRrdAfJiujLH/aNxcyjKtOBxrcvcJXbMSlqqLpspvo`).
  La llave antigua se quitó de `authorized_keys`.
- Llave del celular (`telefono`) restringida al túnel del puerto 4096:
  `SHA256:9lI9c4iGJDIgw2av5ud6a7azsVBUgwA4XhzdlVgCcnw`.
- **Clave de opencode rotada.** La antigua ya no sirve (401).
  Se guarda solo en el servidor: `sudo cat /root/CLAVE_OPENCODE.txt` (root, 600).
  **Nunca** escribirla en este archivo, en Telegram ni en GitHub.
- Las claves ya usadas se listan en `/etc/marketattack/claves_rotadas.txt`
  (600) y el exportador del chat las borra automáticamente.

### Comandos desde Telegram (nuevo)
El puente responde a:
- `/comandos` — lista lo que puede hacer.
- `/sh <comando>` — ejecuta y devuelve la salida. Lista blanca:
  `ls cat head tail grep find wc du df free uptime date uname whoami hostname
  id ps stat echo which file sed tree realpath md5sum verificar_tienda.sh
  backup_marketattack.sh publicar.sh qr_tienda.py nuevo_cliente.py
  exportar_sesion.py nginx python3 node opencode crontab env`
- `/reiniciar nginx|opencode|puente-telegram` — solo esos tres.

Lo destructivo está **bloqueado a propósito**: `rm`, `chmod`, `dd`, `wget`,
`kill`, `apt`, `curl -X`, `shutdown`, etc. se rechazan con un mensaje que
explica qué sí se puede hacer. Hay 22 pruebas automáticas que cubren
estos casos.

### Respaldo en 4 vías (nuevo)
| Vía | Qué guarda | Dónde | Cuándo |
|-----|-----------|-------|--------|
| A — VPS disco | chat + web + scripts + config saneada | `/var/backups/marketattack/completos/` | 02:30 diario, 14 días |
| B — VPS espejo | copia idéntica de A | `/root/marketattack-rescate/` | 02:30 diario, 14 días |
| C — Telegram | kit con contexto + chat + scripts | el chat, 00:00 diario | 00:00 diario, 30 kits |
| D — GitHub | código, contexto, config saneada | `gtcorebynet-jpg/marketattack` | al guardar cambios |

- Cada respaldo lleva `SHA256SUMS`: si algo se corrompe, se nota.
- `verificar_respaldos.sh` revisa **las dos vías** y comprueba que coincidan.
  Probado con dos fallos reales: archivo truncado y archivo manipulado.
  Ambos detectados.
- La copia del chat se hace con `sqlite3.backup()` (copia consistente
  aunque la base esté en uso), no con `cp`.

### Restaurar desde cualquier sitio
`recuperar.sh` permite elegir de dónde:
- `recuperar.sh A` — desde el ZIP de Telegram (el celu).
- `recuperar.sh B` — desde el VPS.
- `recuperar.sh C` — clonando GitHub.

### Bugs corregidos en el camino
1. **`exportar_sesion.py` corrompía el chat.** El patrón `re.compile(r"[CLAVE]")`
   es una *clase de caracteres* (C, L, A, V, E), no el texto literal: por eso
   `WDC` salía como `WD[CLAVE SERVIDOR]` y `el kit` como `[CLAVE SERVIDOR]l kit`.
   7977 sustituciones en el kit. Corregido con `re.escape()`.
   La auditoría de secretos decía "0 fugas" y aun así el texto estaba roto:
   **una auditoría de fugas no detecta corrupción**, hace falta mirar el texto.
2. **El kit no llevaba los scripts del servidor.** La ruta era
   `$W/../usr/local/bin/*.sh`, que no existe. Ahora usa `sudo cp`.
3. **`RESTAURAR.sh` imprimía literalmente `$IP`** por un `<<'PASO'` entrecomillado.
4. **La clave antigua se colaba** en el kit al volver el detector dinámico.
   Ahora el exportador lee la clave actual **y** `/etc/marketattack/claves_rotadas.txt`.
5. **`SERVICIOS` se había borrado** al reescribir la lista blanca; lo cazaron
   las pruebas (2 fallos) antes de desplegar.
6. **El verificador de tiendas no comprobaba el nombre comercial**, solo el slug.

### Cómo verificarlo todo
```bash
sudo bash /usr/local/bin/verificar_respaldos.sh   # integridad de las 2 vías
sudo bash /tmp/verificar_kit.sh                   # kit: fugas + corrupción
```

### Pendiente del usuario (2 cosas, 2 minutos)
1. **Rotar el token del bot** en `@BotFather`: `/revoke` → elegir el bot.
2. **Activar el espejo automático del VPS en GitHub** (para no depender de la PC):
   ```bash
   sudo ssh-keygen -t ed25519 -C "vps-marketattack" -f /root/.ssh/id_ed25519
   sudo cat /root/.ssh/id_ed25519.pub
   ```
   Copiar esa llave en GitHub → repo → Settings → Deploy keys →
   Add deploy key → ☑ **Allow write access**.
   A partir de ahí `publicar_github.sh` sube solo, cada día a las 04:00.

### Más correcciones (2026-10-06, tarde)
- **El puente reprocesaba el historial al reiniciar.** `off = 0` estaba fijo en
  el código: cada reinicio leía todos los mensajes antiguos y volvía a
  responderlos. Ahora el offset se lee y se guarda en
  `/home/ubuntu/.marketattack_offset`.
- `guardar_offset.py` ancla el offset a mano (`python3 /usr/local/bin/guardar_offset.py`).
- La verificación final compara **huellas SSH reales**, no comentarios de las
  llaves: la primera versión daba un falso "llave antigua presente".
- `verificacion_final.sh` corre todos los días a las 07:00 y comprueba servicios,
  web, 404 real, las tres claves de opencode, las dos huellas SSH, que la llave
  del celular esté restringida, las 4 vías de respaldo y fugas de secretos.
- `verificacion_final.sh` **no lleva ninguna clave escrita**: lee la clave
  antigua de `/etc/marketattack/claves_rotadas.txt`. Por eso se colaba en el kit.
- `verificar_kit.sh` compara el número de scripts contra lo que hay realmente
  en `/usr/local/bin` (no un número fijo: si el kit trae 20 de 20, vale).
- `prueba_restauracion.sh` **restaura de verdad** (no dice "debería"): descomprime
  el kit, abre la DB, y corre `sha256sum -c` sobre el respaldo. Requiere que
 乾 el chat se busque a 2 niveles (`chat/conversacion.md`).

### Recuperar de verdad (probado, no supuesto)
```bash
# Desde el celu, con el ZIP de Telegram descargado:
bash recuperar.sh A                    # busca en Descargas
bash recuperar.sh A /ruta/al/kit.zip   # o le dices cuál es

# Desde la PC con el VPS vivo:
bash recuperar.sh B

# Desde cualquier parte con GitHub:
bash recuperar.sh C
```
