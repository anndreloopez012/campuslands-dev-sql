# Analisis del requerimiento - Ejercicio 079

## Solicitud entendida

Una tienda de ropa urbana vende sneakers en distintas tallas. El
cliente necesita guardar historico porque en auditorias le preguntan
que paso y cuando paso: por eso el modelo no debe borrar informacion
de un pedido una vez confirmado, sino conservarla con su fecha y su
estado. Se necesita una base de datos que permita consultar datos,
corregir estados, registrar movimientos y sacar reportes utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: quien compra en la tienda | nombre_cliente, telefono (unico) |
| productos | Catalogo: cada modelo de sneaker | nombre_producto, marca |
| tallas | Catalogo: cada talla disponible | numero_talla (unico) |
| pedidos | Tabla transaccional: cada pedido de un cliente | fecha_pedido, estado |
| detalle_pedidos | Historico de auditoria: que producto y que talla se pidio, y cuantos | cantidad, precio_unitario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> pedidos | 1:N | Un cliente puede tener varios pedidos. |
| pedidos -> detalle_pedidos | 1:N | Un pedido puede tener varias lineas de producto/talla. |
| productos -> detalle_pedidos | 1:N | Un producto aparece en muchos pedidos distintos. |
| tallas -> detalle_pedidos | 1:N | Una talla aparece en muchos pedidos distintos. |

## Reglas de negocio

Esta es la regla central que pidio el cliente: conservar el historico
para auditorias.

- Regla 1 (relaciones invalidas): todo pedido debe apuntar a un
  cliente real; todo detalle debe apuntar a un pedido, un producto y
  una talla reales (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `clientes.telefono` y
  `tallas.numero_talla` no se repiten (`UNIQUE`); un producto en una
  talla especifica no puede aparecer dos veces como linea separada en
  el mismo pedido (`UNIQUE (id_pedido, id_producto, id_talla)`).
- Regla 3 (valores fuera de rango): `detalle_pedidos.cantidad`
  siempre mayor que 0; `detalle_pedidos.precio_unitario` nunca
  negativo (`CHECK`).
- Regla 4: un pedido nace `'pendiente'` y avanza a `'confirmado'`,
  `'enviado'`, `'entregado'` o `'cancelado'` (`CHECK`); se corrige
  siempre con `UPDATE`.
- Regla 5: un producto/talla solo se puede quitar de un pedido con
  `DELETE` mientras el pedido sigue `'pendiente'` (todavia no se
  confirmo). Una vez que el pedido pasa a `'confirmado'` o mas
  adelante, sus lineas ya son parte del historico de auditoria y no se
  borran; si algo estuvo mal, se corrige cambiando el estado del
  pedido, no eliminando el detalle.

## Supuestos

- El cliente no detallo si el precio de un producto puede cambiar
  entre pedidos; se guarda `precio_unitario` tambien en
  `detalle_pedidos` para conservar el precio real que se cobro en ese
  pedido especifico, incluso si el precio de catalogo cambia despues.
- No se detallo si una talla es especifica de cada producto (algunos
  modelos no tienen todas las tallas); se asume un catalogo general de
  tallas compartido por todos los productos, para el alcance de este
  nivel.
- Se asume que "auditorias" se refiere principalmente a poder
  reconstruir que se pidio, en que talla y cuando, sin que esa
  informacion desaparezca.

## Preguntas que responde la base de datos

1. Que lineas de pedido existen, con que producto, que talla y que
   cliente.
2. Que pedidos estan pendientes, confirmados, enviados, entregados o
   cancelados.
3. Que cliente tiene mas pedidos (ranking de actividad).
4. Como se ordenan las lineas de pedido por su subtotal.
5. Que productos son los mas pedidos, para decidir cuales
   reabastecer primero.
