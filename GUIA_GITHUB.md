# GUÍA GITHUB — Respaldo de MarketAttack desde cero

Sigue en orden. Cuando un paso diga "**(TÚ)**", lo ejecutas en la terminal y me avisas.

---

## PASO 1 — Instalar git (TÚ)
Abre una terminal y ejecuta:

```bash
sudo apt install git -y
```

Te pedirá la contraseña. Cuando termine, confírmame y sigo yo.

## PASO 2 — Configurar tu identidad (lo hago yo)
Necesito dos datos que verás en tu GitHub:
- Tu **nombre de usuario** (aparece arriba a la derecha en github.com).
- El **correo** asociado a tu cuenta.

## PASO 3 — Crear el repositorio en GitHub (TÚ, en el navegador)
1. Entra a https://github.com y haz clic en el botón verde **"New"** (o + → New repository).
2. Nombre del repositorio: `marketattack`
3. **IMPORTANTE:** marca la casilla **"Private"** (privado — nadie lo ve, solo tú).
4. NO marques "Initialize this repository with..." (la dejamos vacío).
5. Clic en **"Create repository"**.
6. Te mostrará una página que dice `git remote add origin ...`. **Cópiame la línea que empieza con `git remote`** (o el enlace https que aparece).

## PASO 4 — Conectar y subir (lo hago yo)
Enlazo la carpeta local con tu repositorio y subo todo. Te pediré tu **usuario** y una **contraseña/token de GitHub** la primera vez (lo explica el paso siguiente).

## PASO 5 — Si GitHub pide contraseña (TÚ, opcional pero recomendado)
Desde 2021 GitHub ya **no acepta tu contraseña normal para subir**, pide un **token**:
1. En github.com: tu foto → **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)** → **Generate new token**.
2. Marca por lo menos **`repo`** y en "Expiration" pon "No expiration".
3. Clic en **Generate token** y cópialo (solo se ve una vez).
4. Cuando suba el código y me pida contraseña, pegas ese token. (O mejor: yo te explico un comando para que git lo recuerde y no lo pidas otra vez.)

---

### ¿Por qué todo esto?
- GitHub = **copia en la nube gratis** → si el disco falla o se apaga la PC, tu código no se pierde.
- **Privado** = solo tú lo ves (y a quien invites).
- `.gitignore` = ya quedó creado para que **nunca** se suban datos personales ni el respaldo local.

### Que NO se subirá a GitHub (por privacidad)
- Las cartas migratorias (datos personales: cédula, pasaporte, salud).
- El respaldo comprimido (`05_RESPALDOS/`).
- Dentro de MarketAttack, la carpeta `copia_seguridad/`.