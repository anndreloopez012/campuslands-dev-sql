# Analisis del requerimiento - Ejercicio 029

## Solicitud entendida

Una tienda de ropa urbana vende sneakers en distintas tallas a sus clientes. El cliente necesita guardar historico porque en auditorias le preguntan "que paso y cuando paso" con cada pedido: no basta con saber el estado actual, necesita el registro cronologico completo (pedido creado, pagado, enviado, entregado o devuelto).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes de la tienda. | nombre_cliente (unico), email (unico) |
| pedidos | Es el catalogo/cabecera de cada pedido: que cliente, que modelo y talla, a que precio. Los datos permanentes de un pedido no cambian. | id_cliente (FK), nombre_modelo, talla, precio |
| eventos_pedido | Es el historico/bitacora de auditoria: cada fila es un evento real ocurrido a un pedido (creado, pagado, enviado, entregado, devuelto), con su fecha exacta. Aqui vive directamente la respuesta a "que paso y cuando paso". | id_pedido (FK), tipo_evento, fecha_evento, estado, comentario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> pedidos | 1:N | Un cliente puede hacer muchos pedidos. |
| pedidos -> eventos_pedido | 1:N | Un pedido acumula muchos eventos en su historico de vida (desde que se crea hasta que se entrega o devuelve). |

## Reglas de negocio

- Regla 1: Todo pedido debe pertenecer a un cliente real (`FOREIGN KEY`), y todo evento debe pertenecer a un pedido real (`FOREIGN KEY`).
- Regla 2: `precio` siempre debe ser mayor a cero (`CHECK`), y `talla` debe estar en un rango realista.
- Regla 3: `tipo_evento` solo puede ser uno de los valores del flujo de la tienda (`CHECK`): `creado`, `pagado`, `enviado`, `entregado`, `devuelto`.
- Regla 4: `estado` de un evento puede ser `valido` o `anulado` (`CHECK`); esto es lo que se corrige con `UPDATE` cuando un evento registrado en espera se confirma, sin borrar el evento original (el historico de auditoria no se toca).
- Regla 5: `nombre_cliente` y `email` no se repiten (`UNIQUE`).

## Supuestos

- No se creo una tabla `tallas` ni `productos` separada: la talla y el modelo se guardan como datos dentro de `pedidos`, ya que cada pedido es de un modelo y talla especificos y no se reutiliza entre pedidos distintos.
- Para efectos de auditoria, un evento en `eventos_pedido` NUNCA se borra una vez que representa algo que realmente ocurrio: solo se corrige su `estado`. La unica excepcion es una entrada de prueba que nunca fue un evento real.
- El estado por defecto de un evento nuevo es `valido`, porque asi entra normalmente un evento real registrado.

## Preguntas que responde la base de datos

1. Que eventos del historico existen y en que estado quedo cada uno.
2. Que eventos estan anulados (no confirmados).
3. Que pedido tiene mas eventos registrados en su historico.
4. Como se ordena el historico cronologicamente (que paso y cuando paso).
5. Cual fue el ultimo evento registrado de cada pedido, para saber en que quedo cada uno sin tener que revisar todo el historico.
