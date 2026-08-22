# Analisis del requerimiento

## Solicitud recibida

El cliente dice que hoy todo se maneja en hojas de calculo y que varias personas duplican datos sin darse cuenta. Necesito que me ayuden a convertir esta operacion en una base de datos. No quiero solo guardar texto; quiero poder consultar datos, corregir estados, registrar movimientos y sacar reportes utiles.

## Solicitud entendida

La cafeteria necesita dejar las hojas de calculo y registrar productos,ventas, pagos y estados para evitar duplicados y obtener reportes. 

## Entidades

| Entidad | Atributos principales |
| --- | --- |
| productos | id, nombre, categoria, precio, estado |
| ventas | id, producto_id, estudiante, cantidad, fecha, metodo_pago, estado |

## Relacion

Un producto puede aparecer en muchas ventas (1:N). La venta usa
`producto_id` como llave foranea.

## Reglas y supuestos

- Precio y cantidad deben ser mayores que cero.
- Producto: activo o inactivo; venta: pendiente, pagada o cancelada.
- Cada venta corresponde a un solo producto.
- El estudiante es texto porque no se solicito un catalogo de clientes.

## Preguntas que responde

1. Que productos estan activos y cuanto cuestan.
2. Que ventas estan pagadas o pendientes.
3. Cuanto se ha vendido por producto y metodo de pago.
