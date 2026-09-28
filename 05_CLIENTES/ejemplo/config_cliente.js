/* ═══════════════════════════════════════════════════════════════════════
   MARKETATTACK · 05_CLIENTES/ejemplo/config_cliente.js  ← EJEMPLO REAL
   ═══════════════════════════════════════════════════════════════════════
   ▸ Este archivo ES el demo actual convertido en "cliente ejemplo":
     así se ve un cliente YA configurado. Por cliente solo cambia ESTE archivo.
   ▸ El motor (02_DEMO) NUNCA se toca → cero riesgo, cero re-test.
   ═══════════════════════════════════════════════════════════════════════ */

var CLIENTE = {

  /* [1] IDENTIDAD */
  negocio: "HUELLA PROVEEDORES (demo)",
  rubro:   "Proveedores / insumos",
  promo:   "🔥 La huella digital que deja tu negocio: hoy, 2x1 en tu primera compra",

  /* [2] CONTACTO — el Nº con el que se piden los pedidos (del CLIENTE, no el nuestro) */
  whatsapp: "52 1 55 1234 5678",   // ← reemplazar por el REAL del primer cliente
  horario:  "Lun–Sáb 9:00–20:00",
  zona:     "Entrega en CDMX y alrededores",

  /* [3] PRODUCTOS (nombre · precio · foto opcional) */
  productos: [
    { nombre: "Kit Proveedor Básico", precio: 499, foto: "" },
    { nombre: "Kit Proveedor Pro",    precio: 899, foto: "" },
    { nombre: "Asesoría personalizada", precio: 1499, foto: "" }
  ],

  /* [4] DESPEDIDA post-pedido */
  despedida: "¡Gracias por tu pedido! Te escribimos por WhatsApp en minutos."

  /* NO edites nada más abajo de esta línea. */
};