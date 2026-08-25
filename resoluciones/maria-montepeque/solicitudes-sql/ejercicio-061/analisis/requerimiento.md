# Analisis del requerimiento - Ejercicio 061

## Solicitud entendida

El cliente maneja un negocio de delivery de comida hoy en hojas de calculo,
donde varias personas duplican datos sin darse cuenta. Necesita una base de
datos relacional que le permita: consultar informacion, corregir estados de
un pedido, registrar movimientos (pagos) y sacar reportes utiles, por
ejemplo saber que repartidor entrega mas pedidos o cuanto se factura por
restaurante.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Persona que hace el pedido; se repite en muchos pedidos, hay que evitar duplicar su nombre/telefono en cada fila | nombre, telefono (unico), direccion |
| menus | Platillo ofrecido por un restaurante; se repite en muchos pedidos | nombre_platillo, restaurante, precio, disponible |
| repartidores | Persona que entrega el pedido; se repite en muchos pedidos | nombre, placa_vehiculo (unica), calificacion_promedio |
| pedidos | Tabla transaccional central: un cliente pide un platillo del menu y un repartidor lo entrega | cantidad, fecha_pedido, estado |
| pagos | Movimiento de dinero asociado a un pedido; se separa de `pedidos` porque tiene su propio ciclo de vida (pendiente, pagado, reembolsado) y metodo de pago | monto, metodo_pago, estado_pago |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> pedidos | 1:N | Un cliente puede hacer muchos pedidos, cada pedido es de un solo cliente. |
| menus -> pedidos | 1:N | Un platillo del menu puede aparecer en muchos pedidos, cada pedido es de un solo platillo. |
| repartidores -> pedidos | 1:N | Un repartidor puede entregar muchos pedidos, cada pedido tiene a lo sumo un repartidor asignado. |
| pedidos -> pagos | 1:1 | Cada pedido genera un unico registro de pago (se identifica con `UNIQUE (id_pedido)`). |

## Reglas de negocio

- Regla 1: un pedido nace en estado `'pendiente'` y solo puede avanzar a
  `'en_camino'`, `'entregado'` o `'cancelado'` (`CHECK`).
- Regla 2: un repartidor puede no estar asignado todavia (`id_repartidor`
  admite `NULL` mientras el pedido esta `'pendiente'`), pero si el pedido
  esta `'en_camino'` o `'entregado'` debe tener repartidor.
- Regla 3: cada pedido tiene como maximo un pago (`UNIQUE (id_pedido)` en
  `pagos`), y el monto y la cantidad deben ser mayores a cero (`CHECK`).
- Regla 4: el telefono del cliente y la placa del repartidor no se pueden
  repetir (`UNIQUE`), para evitar registros duplicados de la misma persona.

## Supuestos

- El cliente no especifico si un pedido puede tener varios platillos; se
  asume, para mantener el alcance de 5 tablas, que cada fila de `pedidos`
  es un platillo con una `cantidad`. Un pedido con varios platillos se
  modelaria como varias filas de `pedidos` con la misma fecha y cliente.
- No se especifico el metodo de pago disponible; se asumen `'efectivo'`,
  `'tarjeta'` y `'app'` como los mas comunes en delivery.
- La calificacion del repartidor se asume en una escala de 0 a 5.

## Preguntas que responde la base de datos

1. Cuales son todos los pedidos con su cliente, platillo y estado.
2. Que pedidos estan pendientes, en camino o ya entregados.
3. Que repartidor ha entregado mas pedidos (ranking de actividad).
4. Cuales son los pedidos ordenados por fecha, del mas reciente al mas
   antiguo.
5. Cuanto se factura por restaurante y cuales restaurantes superan un
   monto minimo de ventas (reporte para decision de negocio).
