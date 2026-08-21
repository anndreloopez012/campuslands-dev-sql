# Analisis del requerimiento - Ejercicio 054

## Solicitud entendida

Una tienda de ropa urbana vende sneakers, tallas, clientes y pedidos. El cliente necesita un reporte rapido para tomar decisiones al final de cada semana. Es nivel 3: se pide `DELETE` controlado con criterios de negocio reales.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes de la tienda. | nombre_cliente (unico), telefono |
| productos | Es el catalogo de modelos de sneaker. | nombre_producto (unico), marca, precio |
| tallas | Es el catalogo de tallas disponibles por producto, cada una con su propio stock. | id_producto (FK), numero_talla, stock |
| pedidos | Es el registro transaccional de cada pedido: que cliente, que talla, cuando, cuanto y en que estado va. Aqui es donde la tienda corrige estados y controla el stock. | id_cliente (FK), id_talla (FK), fecha_pedido, cantidad, estado, stock_descontado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| productos -> tallas | 1:N | Un producto tiene varias tallas. |
| clientes -> pedidos | 1:N | Un cliente puede tener varios pedidos. |
| tallas -> pedidos | 1:N | Una talla especifica puede aparecer en varios pedidos. |

## Reglas de negocio

- Regla 1: Toda talla debe apuntar a un producto real; todo pedido debe apuntar a un cliente real y a una talla real (`FOREIGN KEY` en cadena).
- Regla 2: `telefono` y `marca` son `NOT NULL`.
- Regla 3: `precio` debe ser mayor a cero; `numero_talla` debe estar entre 20 y 33; `stock` nunca puede ser negativo; `cantidad` siempre debe ser mayor a cero (`CHECK`).
- Regla 4: `nombre_cliente` y `nombre_producto` no se repiten (`UNIQUE`); un mismo producto no puede repetir la misma talla dos veces (`UNIQUE` compuesto sobre `id_producto` + `numero_talla`).
- Regla 5: Un pedido puede estar `pendiente`, `confirmado`, `enviado` o `cancelado` (`CHECK`); se corrige con `UPDATE` a medida que avanza.
- Regla 6: `stock_descontado` marca si el pedido ya le resto stock a su talla (1) o no (0). Solo se permite `DELETE` de un pedido cuando esta `cancelado` **y** `stock_descontado = 0` (nunca llego a afectar el inventario). Un pedido cancelado que ya habia descontado stock no se borra: se conserva para que alguien devuelva el stock manualmente con `UPDATE`.

## Supuestos

- `stock_descontado` se guarda en el propio pedido (no se infiere) porque asi queda explicito, sin adivinar, si ese pedido especifico ya afecto el inventario o no; eso es justamente lo que decide si se puede borrar con seguridad.
- El reporte semanal que pide el cliente se resuelve consultando los pedidos `pendiente` o `confirmado` junto con el stock actual de su talla: eso muestra de inmediato cuales pedidos no se pueden surtir por falta de stock.

## Preguntas que responde la base de datos

1. Que pedidos existen, con que cliente, que producto y que talla.
2. Que pedidos no estan enviados todavia.
3. Que cliente tiene mas pedidos.
4. Como se ordenan los pedidos por fecha.
5. Que pedidos pendientes o confirmados tienen menos stock disponible en su talla, para decidir a cuales atender o reabastecer primero (el reporte semanal que pidio el cliente).
