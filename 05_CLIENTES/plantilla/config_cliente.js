/* ═══════════════════════════════════════════════════════════════════════
   CONFIG DEL CLIENTE — MARKETATTACK · plantilla-fábrica (gratis, escalable)
   ▸ ÚNICO archivo que cambia por cliente. El motor de 02_DEMO NO se toca nunca.
   ▸ Por cliente solo llenas los 4 bloques de abajo (20 min, sin programar).
   ═══════════════════════════════════════════════════════════════════════ */

var CLIENTE = {

  /* [Bloque 1] IDENTIDAD — qué se ve en el título y el encabezado */
  nombre_negocio:  "NOMBRE DEL NEGOCIO",
  rubro:           "COMIDA | SERVICIO | ROPA | OTRO",
  promo_arriba:    "🔥 Promo destacada (ej: 2x1 hoy, envío gratis)",

  /* [Bloque 2] CONTACTO — verifica 2 veces. El nº DEBE ser del CLIENTE,
     porque por ahí le llegan los pedidos. (cód. país sin + ni espacios) */
  whatsapp:        "52155XXXXXXXX",   // ← TU CELULAR = quien recibe los pedidos
  horario:         "Lun–Sáb 9:00–20:00",
  zona_entrega:    "Tu zona / ciudad",

  /* [Bloque 3] PRODUCTOS — lista plana. Foto OPCIONAL (si la dejas vacía
     mostramos una genérica). Precio en MXN. */
  productos: [
    { nombre: "Producto 1", precio: 99,  foto: "" },
    { nombre: "Producto 2", precio: 149, foto: "" },
    { nombre: "Producto 3", precio: 249, foto: "" }
  ] /* ← agrega o quita filas con la misma forma: {..., }, */

  /* [Bloque 4] FIN DE CARRERA — lo que se ve DESPUÉS del pedido (la despedida) */
  , despedida: "¡Gracias por tu pedido! Te llega la confirmación por WhatsApp en unos minutos."
};

/* NO edites nada más abajo de esta línea. */