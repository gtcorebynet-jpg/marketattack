# 🛟 GUÍA DE RESTAURACIÓN — MARKETATTACK
### (para cuando cambies de computadora y quieras volver a trabajar CONMIGO)

Esta guía es para **cualquier persona, aunque no sepa de computación**.
Si la lees de arriba abajo y haces lo que dice, **todo tu trabajo vuelve**.

---

## 🧠 PRIMERO: ¿QUÉ ES ESTO? (para entenderlo en 10 segundos)

Tu proyecto (MARKETATTACK) vive hoy en **3 lugares distintos**, y cada uno hace un papel:

| # | Lugar | Qué guarda | Si se pierde... |
|---|-------|-----------|-----------------|
| 1 | **Tu computadora** | Todo, para trabajar rápido | recuperás de la nube (fase 2) |
| 2 | **GitHub** (repo privado) | Código + memoria + chat | ⚠️ hay que re-subir (por eso hacemos fase 1 primero) |
| 3 | **VPS Oracle** | La web funcionando 24/7 | el sitio se apaga, pero el código sigue |

**La idea simple:** en la nube (GitHub) está **todo**. En la computadora solo está la copia de trabajo.

---

## 🎯 CUANDO CAMBIES DE COMPUTADORA — HAZ ESTO (5 pasos)

### Paso 1 — Instala opencode
Es el programa con el que hablamos. Búscalo en la web de opencode y descárgalo como
instales cualquier programa (con su instalador).

### Paso 2 — Consigue el "Kit de Rescate"
Es una carpeta (o un ZIP) con todo lo que necesitamos. Puede venir:
- de GitHub (dirección que te daré en la fase 2), **o**
- desde un USB / Drive, **o**
- desde el respaldo en la nube.

### Paso 3 — Copia el kit y ejecuta el script "restaurar"
Abre la terminal / línea de comandos y ejecuta:

```bash
bash restaurar.sh
```

Esto solo (no borra nada de forma”:
- copia tu proyecto a tu nueva computadora,
- reinstala mi configuración,
- **trae nuestra conversación de vuelta**,
- y te dice el último paso.

### Paso 4 — Abre opencode en la carpeta del proyecto
Abres opencode, eliges la carpeta `MARKETATTACK`, y ahí debe aparecer nuestra
conversación (el chat). Si aparece → todo bien.

### Paso 5 — Dime una frase y retomamos
Escríbeme exactamente:

> **"lee CONTEXTO.md"**

Con esa frase, yo leo el archivo de memoria del proyecto y **sigo exactamente
donde dejamos** — sin que tengas que explicarme nada.

---

## 🧩 ¿QUÉ HACE CADA ARCHIVO DEL KIT?

- **`GUIA_RESTAURACION.md`** → este documento (lo estás leyendo).
- **`restaurar.sh`** → el script del "1 clic" que hace el Paso 3.
- **`CONTEXTO.md`** → **la memoria del proyecto** (dónde dejamos todo, links, qué está hecho).
- **`proyecto/`** → todos tus archivos (web, clientes, QR, textos, respaldos).
- **`chat/opencode.db`** → **nuestra conversación** (para poder continuar donde quedamos).
- **`config/opencode.jsonc`** → mi configuración (cómo me comporto contigo).
- **`respaldo_automatico.sh`** → script de respaldo diario automático (opcional).
- **`secretos.EJEMPLO.md`** → **plantilla** de tus claves (las reales NO van aquí; se regeneran).

---

## ❓ SI ALGO SALE MAL (preguntas frecuentes)

**P: "bash no se reconoce" (Windows)**
Abre *PowerShell* y usa: `bash restaurar.sh` — o si no tienes bash, ábrelo con *Git Bash* (viene con Git).

**P: "no aparece la conversación"**
Abre opencode **desde la carpeta del proyecto** y revisa la lista de sesiones. Si aún no aparece,
pídeme ayuda y lo revisamos.

**P: "¿y mis contraseñas/tokens?"**
No se guardan (a propósito, por seguridad). Se recrean en 30 s en la cuenta
(Fine-grained tokens, o Netlify Access Tokens). Son sólo tuyas, nunca se comparten.

**P: "todo esto es gratis?"**
Sí. Todo el plan usa herramientas con **plan gratuito** (GitHub, Netlify, QR, el VPS
que ya tienes, y opencode). El respaldo automático también es gratis.

---

*Última actualización: 2026-09-18 · Proyecto MARKETATTACK · versión 1.0 del kit*
