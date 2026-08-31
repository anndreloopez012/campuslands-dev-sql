# Analisis del requerimiento - Ejercicio 076

## Solicitud entendida

Una cafeteria cerca del campus quiere controlar productos, ventas
rapidas y pagos de estudiantes. El cliente quiere diferenciar
catalogos, operaciones y resultados para no mezclar informacion
permanente con movimientos: eso significa separar claramente lo que
no cambia seguido (productos, clientes) de lo que si (ventas, su
detalle, pagos). Se necesita una base de datos que permita consultar
datos, corregir estados, registrar movimientos y sacar reportes
utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| productos | Catalogo permanente: cada producto que vende la cafeteria | nombre_producto (unico), precio, categoria |
| clientes | Catalogo permanente: cada estudiante que compra | nombre_cliente, carnet_estudiante (unico) |
| ventas | Operacion: cada venta rapida, encabezado del ticket | fecha_venta, estado |
| detalle_ventas | Operacion: cada linea de producto dentro de una venta | cantidad, precio_unitario |
| pagos | Resultado: el pago de una venta, uno por venta | monto, metodo_pago |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> ventas | 1:N | Un cliente puede tener varias ventas. |
| ventas -> detalle_ventas | 1:N | Una venta tiene una linea por cada producto distinto que se llevo. |
| productos -> detalle_ventas | 1:N | Un producto aparece en muchas ventas distintas. |
| ventas -> pagos | 1:1 | Cada venta tiene, como mucho, un pago oficial (evita registrar el mismo pago dos veces). |

## Reglas de negocio

Esta separacion catalogo/operacion/resultado es justo lo que pidio el
cliente:

- Regla 1 (relaciones invalidas): toda linea de `detalle_ventas` debe
  apuntar a una venta y a un producto reales; todo pago debe apuntar a
  una venta real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `productos.nombre_producto` y
  `clientes.carnet_estudiante` no se repiten (`UNIQUE`); un producto
  no puede aparecer dos veces como linea separada en la misma venta
  (`UNIQUE (id_venta, id_producto)`); una venta no puede tener mas de
  un pago (`UNIQUE (id_venta)` en `pagos`).
- Regla 3 (valores fuera de rango): `detalle_ventas.cantidad` siempre
  mayor que 0; `productos.precio`, `detalle_ventas.precio_unitario` y
  `pagos.monto` nunca negativos (`CHECK`).
- Regla 4: una venta nace `'abierta'` y avanza a `'cerrada'` o
  `'cancelada'` (`CHECK`); se corrige con `UPDATE` cuando se cobra o se
  anula.
- Regla 5: el total de una venta no se guarda como numero fijo, se
  calcula sumando `cantidad * precio_unitario` de sus lineas (ver
  reporte en `dql/consultas.sql`). Si una linea se agrego por error
  mientras la venta sigue `'abierta'` (sin pago todavia), se corrige
  con `DELETE`; una vez que la venta tiene pago, sus lineas ya no se
  tocan.

## Supuestos

- El cliente no detallo si el precio del producto en el catalogo
  puede diferir del precio cobrado en una venta especifica; se guarda
  `precio_unitario` tambien en `detalle_ventas` para conservar el
  precio real de esa venta aunque el precio del catalogo cambie
  despues.
- Se asume que cada venta se paga completa de una sola vez (no hay
  pagos parciales), por eso `pagos` es 1:1 con `ventas`.
- No se detallo un limite de productos por venta; se asume que puede
  tener cualquier cantidad de lineas distintas.

## Preguntas que responde la base de datos

1. Que lineas de venta existen, con que producto y que venta.
2. Que ventas estan abiertas, cerradas o canceladas.
3. Que cliente tiene mas actividad (mas gastado en total).
4. Como se ordenan las lineas de venta por su subtotal.
5. Que productos son los mas vendidos, para decidir cuales
   reabastecer primero.
