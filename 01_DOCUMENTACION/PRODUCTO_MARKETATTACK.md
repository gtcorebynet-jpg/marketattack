# MARKETATTACK — Documento de Producto (v1)
_Fecha: 11 de septiembre de 2026_ | _Estado: Validación_

---

## 1. QUÉ ES
MarketAttack es una plataforma de automatización empresarial con IA para pequeñas y medianas empresas en Colombia. No es un chatbot: es atención + captación + marketing + seguimiento + automatización construida en etapas.

**Filosofía:** Visión grande + inicio pequeño + ejecución práctica.
**Ciclo:** Construir → Probar → Demostrar → Vender → Aprender → Mejorar → Repetir → Escalar.

## 2. PROPUESTA DE VALOR (evolución)
- No vendemos "inteligencia artificial".
- Vendemos: *"Respondemos automáticamente a tus clientes, captamos sus datos y hacemos seguimiento sin que tengas que estar pendiente de cada conversación."*
- Beneficios: ahorro de tiempo, respuesta rápida, menos prospectos perdidos, mayor organización, más oportunidades comerciales.

## 3. NICHO INICIAL
**Restaurantes + Barberías/Salones de belleza.**
- Alta frecuencia de preguntas (menús, precios, horarios, citas, ubicación).
- Captación natural por WhatsApp e Instagram.
- Disposición a pagar por no perder clientes.
- Facilidad de demostrar valor en la primera venta.

_Regla: no atender todos los nichos al inicio. Uno o dos primeros, validar y luego replicar._

## 4. MERCADO OBJETIVO
| Tag | Tipo | Ejemplo |
|---|---|---|
| 🟢 AHORA | Restaurantes, barberías, salones | Menús, citas, promociones |
| 🟡 DESPUÉS | Tiendas, gimnasios, ecommerce | Catálogos, pedidos, carrito |
| 🔵 VISIÓN | Inmobiliarias, servicios prof., talleres | CRM, reservas, cotizaciones |

**Criterio de selección de nicho:** necesidad real → capacidad de pago → frecuencia de consultas → potencial de automatización → facilidad de adquisición → complejidad técnica → reutilización.

## 5. MVP EXACTO (V1-LAB, V2-MVP)
Proceso completo que debe demostrar:
1. Cliente envía consulta.
2. IA comprende y responde (con conocimiento del negocio).
3. Captura nombre + teléfono + interés.
4. Registrar el prospecto.
5. Derivación humana cuando haga falta.

**Funciones del MVP:**
- Base de conocimiento del negocio (info, menú/servicios, precios, horarios, ubicación, FAQs).
- Respuestas automáticas con IA.
- Captura de datos del prospecto (nombre, teléfono, interés).
- Registro almacenado de prospectos.
- Derivación a persona.

**NO incluir en el MVP** (por más que sea posible): CRM completo, calendario, pagos, multi-canal, publicación automática.

## 6. MÓDULO MARKETING IA (V3+)
Input: "Tenemos promoción hamburguesa + bebida por $25.000 este viernes."
Output: textos para Instagram, Facebook, WhatsApp, historias, Llamadas a la Acción, variaciones, ideas y calendario básico.
**Principio:** IA genera → humano revisa → humano aprueba → se publica.
**Después:** calendario, programación, APIs oficiales, análisis.

## 7. INTEGRACIÓN MARKETING → VENTAS (demo principal)
Restaurante publica promoción → cliente ve y escribe "quiero la promoción" → IA responde → identifica interés → captura datos → registra prospecto/pedido → empresa recibe la oportunidad.

## 8. EVOLUCIÓN DEL PRODUCTO
| Etapa | Descripción | Estado |
|---|---|---|
| 1. Atención | Responder clientes | 🟢 |
| 2. Captación | Registrar prospectos | 🟢 |
| 3. Marketing | Generar contenido | 🟡 |
| 4. Seguimiento | Comunicaciones/recordatorios | 🟡 |
| 5. CRM | Organizar clientes | 🔵 |
| 6. Automatizaciones | Reservas, cotizaciones | 🔵 |
| 7. Analítica | Estadísticas | 🔵 |
| 8. Plataforma | Multicliente escalable | 🔵 |

## 9. ARQUITECTURA (Sistema base + configuración)
Por cada cliente configuraremos: nombre, logo, info, productos/servicios, precios, horarios, ubicación, promociones, FAQs, tono, reglas comerciales, canales, automatizaciones.

**Meta:** incorporar un nuevo cliente sea cada vez más rápido (plantilla `00_PLANTILLA_CLIENTE`).

## 10. MODELO DE NEGOCIO
1. **Implementación inicial:** configuración y personalización.
2. **Mensualidad:** uso, mantenimiento, soporte, infraestructura.
3. **Servicios adicionales:** marketing, automatizaciones, integraciones, CRM.

**Estrategia:** precio promocional para los primeros clientes (validar + testimonios + casos de éxito) y aumentar precio con el valor entregado. No competir solo por ser baratos.

## 11. INFRAESTRUCTURA
- **Ahora (lab/demo):** PC local (i5, 16GB, SSD 32GB sistema, HDD 320GB proyectos) → `/mnt/proyectos/04_MARKETATTACK/`.
- **Después (primer cliente):** VPS económica (~US$5/mes) o cloud, 24/7.
- Stack: Linux, Docker + Compose, Python, Git, PostgreSQL, APIs oficiales (WhatsApp/redes), API de IA. n8n cuando convenga.

## 12. IA
- **MVP:** API comercial (Claude/Gemini/OpenAI) — calidad, facilidad, velocidad.
- **Local:** evaluar después (privacidad, costo) — el hardware actual no corre modelos grandes bien.
- Decisión por: costo + calidad + velocidad + privacidad + hardware + escalabilidad.

## 13. WHATSAPP Y REDES
Solo mecanismos oficiales: WhatsApp Business Platform/API, APIs de Meta. Evitar métodos no oficiales (bloqueos, suspensiones, ilegalidad, inestabilidad).
**MVP:** sandbox/Meta test + widget web. WhatsApp real recién en primer cliente (V4).

## 14. SEGURIDAD Y PROTECCIÓN DE DATOS
- Desde V1: contraseñas seguras, variables de entorno, secretos fuera del código, HTTPS, firewall, permisos, logs, actualizaciones, aislamiento entre clientes, mínimo privilegio.
- **Datos personales en Colombia: Ley 1581 de 2012.** El bot debe pedir consentimiento al capturar datos. Validación legal profesional para detalles críticos.

## 15. BACKUPS (CRÍTICO) — PRINCIPIO: NO PUEDE EXISTIR UN ÚNICO PUNTO DE FALLA
- Proteger: código, BD, configuración, documentación, flujos, credenciales (seguras), info de clientes.
- Estrategia 3-2-1: 3 copias, 2 medios, 1 fuera del equipo.
- Backups automáticos, versionado, cifrado cuando aplique, **pruebas periódicas de restauración**, procedimiento documentado.

## 16. MULTICLIENTE
Pensar multicliente desde temprano (aislamiento Cliente A/B/C) sin construir arquitectura compleja en V1. Evitar decisiones que obliguen a reconstruir.

## 17. DEMO COMERCIAL ("Tienda Demo IA")
Empresa ficticia + demo de 1-2 minutos, visual, fácil, desde teléfono, profesional:
1. Cliente pregunta → 2. IA responde → 3. usa info realista del negocio → 4. identifica interés → 5. captura datos → 6. registra prospecto → 7. empresa recibe oportunidad → 8. (opcional) Marketing IA genera promoción.

## 18. METODOLOGÍA DE DESARROLLO
V1 Laboratorio → V2 MVP → V3 Demo → V4 Primer cliente → V5 Producto reutilizable → V6 Multicliente → V7 Producción Cloud/VPS → V8 Escalamiento.
Cada versión: objetivo, funcionalidades, criterios de éxito, pruebas, documentación, backups, rollback.

## 19. MÉTRICAS
- **Producto:** tiempo de respuesta, precisión, errores, disponibilidad.
- **Comercial:** prospectos capturados, conversaciones, conversiones, clientes.
- **Marketing:** contenidos generados, publicaciones, interacciones, conversaciones generadas.
- **Negocio:** costo/cliente, ingreso/cliente, MRR, retención, rentabilidad, tiempo de implementación por cliente.

## 20. RIESGOS CLAVE (probabilidad→impacto→prevención→contingencia)
| Riesgo | Mitigación |
|---|---|
| Sobreingeniería | MVP mínimo definido; no agregar por factibilidad |
| Costos excesivos | Presupuesto mensual estimado antes de gastar |
| Dependencia de proveedor (IA) | APIs estándar, desacoplar capa de IA |
| Bloqueos de WhatsApp | Solo API oficial |
| Pérdida de datos | Backups 3-2-1 + restauración probada |
| IA con respuestas incorrectas | Base de conocimiento curada + límites de tema |
| Exceso de personalización por cliente | Sistema base + configuración, límite claro |
| Dependencia de una sola persona | Documentación, automatizar nuestro proceso, Git |
| Precio incorrecto | Precio promocional inicial + revisión con métricas |

## 21. PRINCIPIO DE DESARROLLO (para el equipo)
Trabajar en pasos: qué → por qué → comando → dónde → resultado → verificar → continuar.
Si hay error: **detenerse → diagnosticar → solucionar → verificar → continuar.** No acumular errores.

## 22. VENTAS Y ADQUISICIÓN
Orgánico: WhatsApp, Instagram, Facebook, TikTok, LinkedIn, contacto directo, visitas, referidos, networking, demos. Sin spam. Demostrar problemas reales y resultados.
Mensaje: *"Podemos ayudarte a responder automáticamente tus clientes, captar sus datos y hacer seguimiento."*

## 23. ESTRATEGIA FINANCIERA
$0 → construir → demostrar → vender → cobrar → reinvertir. Gastos solo cuando sean necesarios (infra, APIs, dominio). No gastar en infraestructura antes de tener clientes.

## 24. METAS INMEDIATAS
1. ✅ Estructura del proyecto creada.
2. ✅ Demo "Tienda Demo IA" funcional (PC + móvil).
3. ✅ Respaldo local automático (`05_OPERACION/respaldo_marketattack.sh`).
4. ⏳ GitHub (nube) como respaldo 2 → instalar git.
5. Demo → Primer cliente → Feedback.
6. Automatizar nuestro propio onboarding y backups.

---

## 25. EL "KIT MARKETATTACK" — cómo lo explica un cliente (nuevo eje comercial)

Para que el cliente **entienda de inmediato** lo que es, vendemos un **KIT** — no
"un chatbot" ni "inteligencia artificial" (palabras difusas). El kit habla de su
negocio en términos que él ya conoce:

> **"El Kit MarketAttack responde automáticamente a tus clientes por WhatsApp y
> redes, capta sus datos (nombre, teléfono e interés) y te entrega la oportunidad
> lista para que la cierres. Además, te ayuda a crear contenido para promocionar."**

### En una frase (elevator pitch)
> *"Tu negocio atendido 24/7, con cada cliente nuevo captado y organizado, y con tu
> marketing listo — sin que tú hagas nada extra."*

### Las 4 piezas del Kit (cada pieza resuelve un dolor)
| Pieza | Resuelve este dolor |
|---|---|
| 💬 **Atención IA 24/7** | "No alcanzo a responder todos los mensajes" |
| 📥 **Captación de datos** | "No sé quién me escribe, muchos clientes se pierden" |
| 🏪 **Panel + seguimiento** | "Tengo todo en el aire, no organizo mis prospectos" |
| 📣 **Marketing IA** | "No se me ocurre qué publicar, no tengo contenido" |

### Tecnología sí, pero empática
Muestra la demo rápido, en el propio negocio: "pregúntale a tu propio asistente por
el menú". El cliente ve con SUS PROPIOS datos el valor. La demo es el argumento
comercial más fuerte — por eso se usa en celular/PC sin instalación.

### Regla del Kit (evoluciona con el cliente)
1. **Kit base:** Atención + captación + panel (el MVP que ya demuestra valor).
2. **Kit pro:** + marketing IA + WhatsApp real + CTA de pedidos.
3. **Kit escala:** + CRM, automatizaciones, analítica, multicanal.

La presentación de cliente (`kit.html` en `/02_DEMO`) ya existe y se adapta con un
cambio de nombre/número. Fácil de personalizar por cliente = producto adaptable.