# Analisis del requerimiento - Ejercicio 004

## Solicitud entendida

Una tienda de ropa urbana vende sneakers en distintas tallas y necesita registrar sus pedidos para poder sacar, al final de cada semana, un reporte rapido que le ayude a tomar decisiones (que se vendio, cuanto se gano, que reabastecer). Tambien quiere poder consultar datos, corregir estados de un pedido y registrar movimientos.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| productos | Es el catalogo de sneakers que vende la tienda; un mismo modelo existe en varias tallas, y cada combinacion modelo+talla es un producto distinto con su propio stock. | nombre_modelo, talla, precio, stock |
| pedidos | Es el registro transaccional de cada venta a un cliente: que producto, cuando, cuanto y en que estado va el pedido (pendiente, enviado, entregado, cancelado). Aqui vive el reporte semanal que pide el cliente. | id_producto (FK), nombre_cliente, cantidad, precio_total, fecha_pedido, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| productos -> pedidos | 1:N | Un producto (modelo+talla) puede aparecer en muchos pedidos distintos, pero cada pedido es de un unico producto. |

## Reglas de negocio

- Regla 1: Todo pedido debe apuntar a un producto real del catalogo (`FOREIGN KEY`).
- Regla 2: `precio` y `precio_total` siempre deben ser mayores a cero (`CHECK`), y `stock` nunca puede ser negativo.
- Regla 3: Un pedido pasa por los estados `pendiente`, `enviado`, `entregado` o `cancelado` (`CHECK`); el cliente necesita poder corregir ese estado a medida que avanza la logistica.
- Regla 4: No se repite el mismo modelo en la misma talla dos veces en el catalogo (`UNIQUE` sobre `nombre_modelo` + `talla`), porque cada combinacion es un producto distinto con su propio stock.

## Supuestos

- No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del cliente se guarda dentro de `pedidos`.
- `precio_total` se guarda en el pedido (no solo se calcula desde `productos.precio`) porque el precio de catalogo puede cambiar con el tiempo, y el pedido debe conservar lo que realmente se cobro ese dia.
- El reporte semanal se arma agrupando `pedidos` por dia dentro del rango de fechas de la semana de prueba (2026-08-10 a 2026-08-16), usando `date(fecha_pedido)`.

## Preguntas que responde la base de datos

1. Que pedidos existen y en que estado quedo cada uno.
2. Que pedidos no estan entregados todavia (pendientes, enviados o cancelados).
3. Que cliente le compra mas a la tienda.
4. Como se ordenan los pedidos por fecha, para revisar la semana dia a dia.
5. Que reporte semanal (ingresos por dia, solo pedidos entregados) puede usar el cliente para decidir que reabastecer.
