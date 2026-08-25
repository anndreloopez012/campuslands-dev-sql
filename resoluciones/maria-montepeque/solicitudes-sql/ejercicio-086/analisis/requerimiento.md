# Analisis del requerimiento - Ejercicio 086

## Solicitud entendida

Un negocio de comida recibe pedidos, repartidores, menus y
calificaciones. El cliente quiere diferenciar catalogos, operaciones y
resultados para no mezclar informacion permanente con movimientos. Es
un nivel 5 (solicitud profesional): ademas del modelo, se pide
interpretar ambiguedad, normalizar datos, documentar decisiones y
crear al menos una vista SQL.

## Entidades detectadas

| Entidad | Por que existe | Capa | Atributos importantes |
| --- | --- | --- | --- |
| clientes | Quien hace el pedido | Catalogo | nombre_cliente, telefono (unico) |
| menus | Cada platillo disponible | Catalogo | nombre_platillo (unico), precio, categoria |
| repartidores | Quien entrega el pedido | Catalogo | nombre_repartidor (unico), vehiculo |
| pedidos | Cada pedido de un cliente | Operacion | cantidad, fecha_pedido, estado |
| pagos | El pago de un pedido | Resultado | monto, metodo_pago |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> pedidos | 1:N | Un cliente puede hacer varios pedidos. |
| menus -> pedidos | 1:N | Un platillo aparece en muchos pedidos distintos. |
| repartidores -> pedidos | 1:N | Un repartidor entrega muchos pedidos. |
| pedidos -> pagos | 1:1 | Cada pedido tiene, como mucho, un pago oficial. |

## Decisiones de modelado y ambiguedad interpretada

- **Diferenciar catalogos, operaciones y resultados (la peticion
  central del cliente):** `clientes`, `menus` y `repartidores` son
  catalogos (informacion permanente, cambia poco); `pedidos` es la
  operacion (un movimiento nuevo cada vez que alguien pide comida);
  `pagos` es el resultado (lo que se cobro realmente). Ninguna tabla
  mezcla las tres capas.
- **Un pedido, un platillo:** para mantener el modelo dentro de las 5
  entidades sugeridas por el cliente (sin agregar una sexta tabla de
  detalle), se asume que cada fila de `pedidos` representa un platillo
  con su cantidad; un cliente que quiere varios platillos distintos
  genera varios pedidos. Se documenta como supuesto porque el cliente
  no lo aclaro.
- **Vista SQL:** se crea `vista_pedidos_completos`, que junta pedido,
  cliente, menu, repartidor y pago (si existe) con `LEFT JOIN`. Separa
  visualmente las tres capas en un solo reporte legible, sin mezclar
  el dato permanente con el movimiento.
- **Ambiguedad no resuelta por el cliente:** no se detallo si un
  repartidor puede rechazar un pedido asignado. Se documenta como
  fuera del alcance: el modelo asume que todo pedido con repartidor
  asignado sera entregado, salvo que se cancele explicitamente.

## Reglas de negocio

- Regla 1 (relaciones invalidas): todo pedido debe apuntar a un
  cliente, un menu y un repartidor reales; todo pago debe apuntar a un
  pedido real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `clientes.telefono`,
  `menus.nombre_platillo` y `repartidores.nombre_repartidor` no se
  repiten (`UNIQUE`); un pedido no puede tener mas de un pago
  (`UNIQUE (id_pedido)` en `pagos`).
- Regla 3 (valores fuera de rango): `menus.precio` y `pagos.monto`
  nunca negativos; `pedidos.cantidad` siempre mayor que 0 (`CHECK`).
- Regla 4: un pedido nace `'recibido'` y avanza a `'en_camino'`,
  `'entregado'` o `'cancelado'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: un pago se elimina con `DELETE` solo cuando el pedido al
  que pertenece se cancela y ese pago resulto ser un error (se cobro
  un pedido que en realidad no se entrego). Un pago de un pedido
  `'entregado'` nunca se borra.

## Supuestos

- Se asume que el precio cobrado puede diferir del precio de catalogo
  (por ejemplo, promociones), por eso el monto real se guarda en
  `pagos.monto`, separado de `menus.precio`.
- No se detallo un tiempo maximo de entrega; se asume que ese control
  queda fuera del alcance de este nivel.

## Preguntas que responde la base de datos

1. Que pedidos existen, con su cliente, menu, repartidor y pago (via
   la vista `vista_pedidos_completos`).
2. Que pedidos estan recibidos, en camino, entregados o cancelados.
3. Que cliente tiene mas pedidos (ranking de actividad).
4. Como se ordenan los pedidos por fecha y por monto.
5. Que categoria de menu genero mas ingresos, para decidir en cual
   enfocar promociones.
