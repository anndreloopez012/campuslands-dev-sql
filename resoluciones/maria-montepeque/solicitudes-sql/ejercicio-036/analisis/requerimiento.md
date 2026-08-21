# Analisis del requerimiento - Ejercicio 036

## Solicitud entendida

Un negocio de comida recibe pedidos, repartidores, menus y calificaciones. El cliente pide explicitamente diferenciar catalogos (informacion permanente) de operaciones (movimientos), y quiere poder consultar datos, corregir estados, registrar movimientos y sacar reportes utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes que hacen pedidos. Informacion permanente. | nombre_cliente (unico), telefono |
| menus | Es el catalogo de platillos que el negocio ofrece. Informacion permanente. | nombre_platillo (unico), categoria, precio |
| pedidos | Es el registro de movimientos: que cliente pidio, que platillo, quien lo reparte, cuando, cuanto se pago, en que estado va y como lo califico el cliente. Aqui es donde el negocio corrige estados y saca reportes. | id_cliente (FK), id_menu (FK), repartidor, fecha_pedido, monto_pagado, estado, calificacion |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> pedidos | 1:N | Un cliente puede hacer muchos pedidos. |
| menus -> pedidos | 1:N | Un platillo del menu puede aparecer en muchos pedidos. |

## Reglas de negocio

- Regla 1: Todo pedido debe apuntar a un cliente real y a un platillo real (`FOREIGN KEY` doble).
- Regla 2: `telefono` y `repartidor` son `NOT NULL`: son datos que, si faltaran, romperian el contacto con el cliente o la trazabilidad de quien entrego el pedido.
- Regla 3: `monto_pagado` y `precio` siempre deben ser mayores a cero (`CHECK`).
- Regla 4: Un pedido puede estar `pendiente`, `en_camino`, `entregado` o `cancelado` (`CHECK`); el negocio necesita poder corregir este estado mientras el pedido avanza.
- Regla 5: `calificacion` solo se llena cuando el pedido ya se entrego, y solo puede ser un numero entre `1` y `5` o quedar vacia (`CHECK`).
- Regla 6: `nombre_cliente` y `nombre_platillo` no se repiten (`UNIQUE`).

## Supuestos

- `repartidor` se guardo como texto simple dentro de `pedidos` (no como tabla `repartidores` aparte), porque el alcance de este nivel es relaciones basicas y el dato que importa es saber quien entrego cada pedido, no llevar una ficha completa del repartidor.
- `calificacion` se guarda en la misma fila del pedido (no en una tabla separada) porque cada pedido tiene como maximo una calificacion, hecha por el mismo cliente que lo pidio.

## Preguntas que responde la base de datos

1. Que pedidos existen, con que cliente, que platillo y que repartidor.
2. Que pedidos no estan entregados todavia.
3. Que cliente tiene mas pedidos.
4. Como se ordenan los pedidos por fecha.
5. Que calificacion promedio tiene cada repartidor (para decidir a quien asignar mas pedidos).
