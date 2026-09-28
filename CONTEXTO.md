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
