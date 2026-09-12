/* =========================================================================
   MARKETATTACK — TIENDA DEMO IA
   Lógica compartida (base reutilizable).
   Para un CLIENTE NUEVO solo se cambia el objeto CLIENTE abajo.
   ========================================================================= */

/* -------------------------------------------------------------------------
   1. CONFIGURACIÓN DEL CLIENTE (cambiar por cada negocio)
   ------------------------------------------------------------------------- */
const CLIENTE = {
  nombreComercial: "Market Burger",
  nombreInterno: "marketburger", // usado como prefijo del almacenamiento
  whatsapp: "573209226563",      // número de contacto (curiosamente es el del titular)
  marca: {
    tagline: "Las mejores hamburguesas de Ciudad Verde",
    tono: "amigable y cercano"
  },
  info: {
    horario: "Lunes a domingo de 11:00 a. m. a 10:00 p. m.",
    ubicacion: "Calle 33 #37-41, Barrio Ciudad Verde, Soacha (Cundinamarca)",
    contacto: "Pedidos y reservas: 320 922 6563"
  },
  menu: [
    { nombre: "Hamburguesa Clásica", precio: "$18.000", desc: "Carne 120 g, queso, lechuga, tomate" },
    { nombre: "Hamburguesa Doble", precio: "$24.000", desc: "Doble carne, doble queso, cebolla caramelizada" },
    { nombre: "Hamburguesa BBQ", precio: "$22.000", desc: "Salsa BBQ, aros de cebolla, tocineta" },
    { nombre: "Perro Sencillo", precio: "$12.000", desc: "Salchicha, papitas, salsas" },
    { nombre: "Perro Especial", precio: "$16.000", desc: "Salchicha, papitas, queso, tocineta" },
    { nombre: "Papas + Bebida", precio: "$10.000", desc: "Porción de papas con malteada/gaseosa" },
    { nombre: "Combo Familiar", precio: "$65.000", desc: "4 hamburguesas + papas + gaseosa 1 L" }
  ],
  promociones: [
    { titulo: "PROMO DEL VIERNES", texto: "Hamburguesa + bebida por solo $25.000. Solo este viernes." }
  ],
  preguntasFrecuentes: [
    { p: "¿Cuánto demora el domicilio?", r: "Entre 30 y 45 minutos en Ciudad Verde y alrededores, según el destino." },
    { p: "¿Aceptan pagos con tarjeta?", r: "Sí, aceptamos efectivo, tarjetas y datos de pago por trasferencia." },
    { p: "¿Tienen opciones vegetarianas?", r: "Próximamente tendremos opciones veggie. Hoy las papas y bebidas son libres de carne." }
  ]
};

/* Simula una IA real: junto a este demo se conectará un modelo (V4+).
   Aquí usamos reglas y plantillas para mostrar el flujo completo y barato. */
const KEY = "prospectos_" + CLIENTE.nombreInterno;

const ETAPAS_CAPTURA = ["nombre", "telefono", "interes"];

/* -------------------------------------------------------------------------
   2. ESTADO DE LA SESIÓN
   ------------------------------------------------------------------------- */
let etapaCaptura = null;         // null | "nombre" | "telefono" | "interes"
let prospectoParcial = {};
let conversacion = [];

/* -------------------------------------------------------------------------
   3. MOTOR DE RESPUESTAS (reglas + plantillas)
   ------------------------------------------------------------------------- */
const RESPONSES = {
  saludo: [
    "¡Hola! Bienvenido a {negocio} 😊 Soy el asistente virtual. Te ayudo con el menú, precios, horarios, ubicación y promociones. ¿Qué deseas saber?",
    "¡Hola! 😊 Gracias por escribirnos. ¿En qué podemos ayudarte? Puedes preguntar por el menú o la promo del viernes."
  ],
  despedida: ["¡Gracias por escribirnos! Que tengas un excelente día 🌟", "¡Fue un gusto atenderte! Estamos para lo que necesites 🙌"],
  gracias: ["¡Con gusto! 😊 ¿Quieres pedir algo o te interesa alguna promoción?", "¡Para eso estamos! 🍔 ¿Te preparo una orden?"],
  default: [
    "No estoy seguro de entenderte 😅. Por ejemplo, puedo decirte el menú, los precios, el horario o contarte la promo del viernes. ¿Sobre qué quieres saber?"
  ]
};

function rellenar(texto, extra) {
  let t = texto.replace("{negocio}", CLIENTE.nombreComercial);
  if (extra) for (const k in extra) t = t.replaceAll("{" + k + "}", extra[k]);
  return t;
}

function obtenerMenu() {
  const lineas = CLIENTE.menu.map(m => "🍔 " + m.nombre + " — " + m.precio + "\n   " + m.desc);
  return "Nuestro menú:\n" + lineas.join("\n") + "\n\n" + promocionActual() + "\n¿Te interesa alguna de estas opciones? 😊";
}

function promocionActual() {
  if (!CLIENTE.promociones.length) return "";
  const p = CLIENTE.promociones[0];
  return "🎉 " + p.titulo + ": " + p.texto;
}

function detectarIntencion(texto) {
  const t = texto.toLowerCase();
  if (/(hola|buenas|buenos días|buenas tardes|buenas noches|hey|qué más|bienvenido)/.test(t)) return "saludo";
  if (/(menu|carta|hamburguesa|perro|papas|combo|comida|precios|precio|productos|cuánto cuesta|qué venden|que venden|qué tienen|que tienen)/.test(t)) return "menu";
  if (/(horario|horarios|abren|cierran|abierto|cuándo abren)/.test(t)) return "horario";
  if (/(ubicación|ubicacion|dirección|direccion|dónde|donde|cuál es la ubicación|mapa)/.test(t)) return "ubicacion";
  if (/(promo|promoción|promocion|oferta|descuento|especial|combo.*promo|viernes)/.test(t)) return "promocion";
  if (/(reparto|cuánto demora|cuanto demora|demora|llega|tiempo d)/.test(t)) return "reparto";
  if (/(pago|pagar|tarjeta|efectivo|transferencia)/.test(t)) return "pago";
  if (/(pedir|pedido|domicilio|envio|envío|comprar|reservar|reserva|cotizar)/.test(t)) return "pedido";
  if (/(vegetariano|veggie|opciones sin carne|sin carne)/.test(t)) return "vegetariano";
  if (/(gracias|muchas gracias|perfecto|ok|de acuerdo|genial|excelente)/.test(t)) return "gracias";
  if (/(adiós|adios|chao|hasta luego|nos vemos|gracias.*adios)/.test(t)) return "despedida";
  return "desconocido";
}

function responderConIntencion(intencion, texto) {
  switch (intencion) {
    case "saludo": return aleatorio(RESPONSES.saludo);
    case "menu": return obtenerMenu();
    case "horario": return "📍 Nuestro horario:\n" + CLIENTE.info.horario + "\n\n¿Quieres que te cuente el menú o la promo del viernes?";
    case "ubicacion": return "📍 Estamos en: " + CLIENTE.info.ubicacion + "\n\n" + CLIENTE.info.contacto;
    case "promocion": return iniciarCaptura("Promoción del viernes: " + CLIENTE.promociones[0].texto);
    case "pedido": return "¡Claro! 🛵 Hacemos pedidos y domicilios.\n\n" + obtenerMenu() + "\n\nCuéntame qué te gustaría pedir.";
    case "pago": return "💳 Aceptamos efectivo, tarjeta y por transferencia. Al confirmar tu pedido te indicamos todos los medios.";
    case "reparto": return preguntasRapidas("reparto");
    case "vegetariano": return preguntasRapidas("vegetariano");
    case "gracias": return aleatorio(RESPONSES.gracias);
    case "despedida": return aleatorio(RESPONSES.despedida);
    default: {
      // Si el cliente menciona algo que parece un interés/compra, invita a capturar
      if (/(promo|oferta|quiero|me interesa|cuánto|cuanto|comprar)/.test(texto.toLowerCase())) {
        return iniciarCaptura(texto.trim());
      }
      return aleatorio(RESPONSES.default);
    }
  }
}

function preguntasRapidas(tema) {
  const r = CLIENTE.preguntasFrecuentes.find(r => tema === "reparto" ? r.p.includes("domicilio") : r.p.includes("vegetariano"));
  return r ? r.r : "Déjame verificarlo contigo 😊";
}

function iniciarCaptura(interes) {
  etapaCaptura = "nombre";
  prospectoParcial = { interes };
  return "¡Perfecto! 🎉 Para registrar tu interés y que el dueño te contacte rápido, necesito primero tu **NOMBRE**, por favor 😊";
}

function extraerNumero(texto) {
  const nums = texto.replace(/[^\d+]/g, "");
  return nums.length >= 7 ? nums.slice(0, 13) : null;
}

function guardarProspecto() {
  const p = { ...prospectoParcial, estado: "nuevo", fecha: new Date().toLocaleString("es-CO") };
  const lista = leerProspectos();
  lista.push(p);
  localStorage.setItem(KEY, JSON.stringify(lista));
  const nombre = prospectoParcial.nombre;
  etapaCaptura = null;
  prospectoParcial = {};
  return "✅ ¡Listo " + nombre + "! Tu información quedó registrada y el restaurante ya recibió tu oportunidad. En breve te contactamos por WhatsApp. ¡Gracias por preferir " + CLIENTE.nombreComercial + "! 🍔";
}

/* -------------------------------------------------------------------------
   4. ALMACENAMIENTO DE PROSPECTOS (mini-CRM)
   ------------------------------------------------------------------------- */
function leerProspectos() {
  try { return JSON.parse(localStorage.getItem(KEY)) || []; } catch (e) { return []; }
}

function guardarListaProspectos(lista) {
  localStorage.setItem(KEY, JSON.stringify(lista));
}

function cambiarEstadoProspecto(id, nuevoEstado) {
  const lista = leerProspectos();
  const p = lista.find(x => x.id === id);
  if (p) { p.estado = nuevoEstado; guardarListaProspectos(lista); }
}

function eliminarProspecto(id) {
  guardarListaProspectos(leerProspectos().filter(x => x.id !== id));
}

function limpiarProspectos() {
  localStorage.removeItem(KEY);
}

/* -------------------------------------------------------------------------
   5. FUNCIONALIDADES COMPARTIDAS
   ------------------------------------------------------------------------- */
function aleatorio(arr) { return arr[Math.floor(Math.random() * arr.length)]; }

function idsUnicos() {
  const lista = leerProspectos();
  lista.forEach((p, i) => { if (!p.id) p.id = Date.now() + "-" + i; });
  guardarListaProspectos(lista);
  return lista;
}

function templateProps() {
  return {
    negocio: CLIENTE.nombreComercial,
    whatsapp: CLIENTE.whatsapp,
    menu: CLIENTE.menu,
    inf: CLIENTE.info,
    promo: CLIENTE.promociones[0]
  };
}

/* -------------------------------------------------------------------------
   6. GENERADOR DE MARKETING (plantillas por canal)
   ------------------------------------------------------------------------- */
function generarContenido(idea) {
  const t = templateProps();
  return [
    {
      canal: "📸 Instagram",
      texto: `🔥 ¡ALERTA DE PROMO! 🔥\n\n${idea}\n\n¿No quieres perderte esta oferta? Escríbenos YA al WhatsApp y asegura la tuya. 🍔🥤\n\n📍 ${t.inf.ubicacion}\n⏰ ${t.inf.horario}\n\n#Promo #${CLIENTE.nombreComercial.replace(/\s/g, "")} #ComidaRica #Soacha`
    },
    {
      canal: "📘 Facebook",
      texto: `📌 Estamos de promoción este fin de semana.\n\n${idea}\n\nPide por inbox, déjanos tu nombre y teléfono, y te contactamos en minutos. 🚀\n\n${CLIENTE.nombreComercial} — Atención rápida y domicilios.`
    },
    {
      canal: "💬 WhatsApp (broadcast)",
      texto: `Hola 👋 Somos ${CLIENTE.nombreComercial}. Tenemos una oferta especialmente para ti:\n\n${idea}\n\n¡Responde este mensaje con tu nombre y teléfono para reservar la tuya! 🍔`
    },
    {
      canal: "🦋 Historias (CTA)",
      texto: `🔥 Quiero la promo → [ENLACE WHATSAPP]\n\n${idea}\n\nSolo por tiempo limitado ⏰`
    }
  ];
}

/* Exportar funciones útiles para páginas nuevas */
window.MarketAttack = {
  CLIENTE,
  KEY,
  ETAPAS_CAPTURA,
  leerProspectos,
  guardarListaProspectos,
  cambiarEstadoProspecto,
  eliminarProspecto,
  limpiarProspectos,
  idsUnicos,
  generarContenido,
  generarIdea: () => CLIENTE.promociones[0] ? CLIENTE.promociones[0].texto : ""
};