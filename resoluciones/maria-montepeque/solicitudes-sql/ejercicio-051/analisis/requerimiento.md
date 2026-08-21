# Analisis del requerimiento - Ejercicio 051

## Solicitud entendida

Una cafeteria cerca del campus quiere controlar productos, ventas rapidas y pagos de estudiantes. Hoy todo se maneja en hojas de calculo y varias personas duplican datos sin darse cuenta. Es nivel 3: se pide `DELETE` controlado con criterios de negocio reales.

Como el ejemplo de razonamiento del propio ejercicio lo señala: una venta puede tener varios productos, asi que no basta una tabla `ventas` con texto suelto. Se separo en `ventas` (el encabezado: quien compro y cuando) y `detalle_ventas` (que productos y cuantos, en esa venta especifica).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| productos | Es el catalogo de productos que vende la cafeteria. | nombre_producto (unico), categoria, precio |
| clientes | Es el catalogo de estudiantes que compran en la cafeteria. | nombre_cliente (unico), carnet (unico) |
| ventas | Es el encabezado de cada venta: que estudiante, cuando y en que estado va (pagada, pendiente, cancelada). | id_cliente (FK), fecha_venta, estado |
| detalle_ventas | Es el detalle de cada venta: que producto, cuantas unidades y a que precio (el precio se copia al momento de la venta, no se recalcula despues). | id_venta (FK), id_producto (FK), cantidad, precio_unitario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> ventas | 1:N | Un estudiante puede tener muchas ventas. |
| ventas -> detalle_ventas | 1:N | Una venta puede tener varias lineas de producto. |
| productos -> detalle_ventas | 1:N | Un producto puede aparecer en muchas lineas de venta. |

## Reglas de negocio

- Regla 1: Toda venta debe apuntar a un cliente real; todo detalle debe apuntar a una venta real y a un producto real (`FOREIGN KEY` en cadena).
- Regla 2: `categoria` y `carnet` son `NOT NULL`.
- Regla 3: `precio`, `cantidad` y `precio_unitario` siempre deben ser mayores a cero (`CHECK`).
- Regla 4: `nombre_producto`, `nombre_cliente` y `carnet` no se repiten (`UNIQUE`), justo para evitar el problema que reporto el cliente: personas duplicando el mismo estudiante o el mismo producto sin darse cuenta.
- Regla 5: Una venta puede estar `pagada`, `pendiente_pago` o `cancelada` (`CHECK`); se corrige con `UPDATE`.
- Regla 6: Solo se permite `DELETE` de una linea de `detalle_ventas` cuando la venta a la que pertenece esta `cancelada`. El detalle de una venta pagada o pendiente nunca se borra.

## Supuestos

- `precio_unitario` se guarda en `detalle_ventas` (copiado del precio del producto al momento de la venta), no se recalcula desde `productos.precio`, porque si el precio del producto cambia despues, las ventas viejas deben conservar el precio real que se cobro entonces.
- El detalle de una venta cancelada se elimina (no solo se marca), porque una venta cancelada no representa inventario realmente vendido ni ingreso real; el encabezado de la venta si se conserva como historial de que la cancelacion ocurrio.

## Preguntas que responde la base de datos

1. Que ventas existen, con que cliente y su total.
2. Que ventas no estan pagadas todavia.
3. Que cliente tiene mas ventas.
4. Como se ordenan las ventas por fecha.
5. Que producto es el mas vendido en unidades, para decidir que reabastecer primero.
