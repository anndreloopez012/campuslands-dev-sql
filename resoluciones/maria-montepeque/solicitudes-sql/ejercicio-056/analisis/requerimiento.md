# Analisis del requerimiento - Ejercicio 056

## Solicitud entendida

Una empresa alquila autos deportivos y necesita controlar reservas, clientes y pagos. El cliente pide explicitamente diferenciar catalogos, operaciones y resultados para no mezclar informacion permanente con movimientos. Es nivel 3: se pide `DELETE` controlado con criterios de negocio.

## Entidades detectadas

El modelo se organizo en los tres grupos que pidio el cliente:

| Grupo | Entidad | Por que existe | Atributos importantes |
| --- | --- | --- | --- |
| Catalogo | clientes | Informacion permanente de cada cliente. | nombre_cliente (unico), licencia_conducir (unica) |
| Catalogo | vehiculos | Informacion permanente de cada auto deportivo. | placa (unica), modelo, tarifa_diaria |
| Operacion | reservas | Un movimiento: una reserva de un cliente sobre un vehiculo, con fechas y estado. | id_cliente (FK), id_vehiculo (FK), fecha_inicio, fecha_fin, estado |
| Resultado | pagos | El resultado economico de una reserva: cuanto se pago, cuando, con que metodo y en que estado. | id_reserva (FK), monto, fecha_pago, metodo, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> reservas | 1:N | Un cliente puede tener varias reservas. |
| vehiculos -> reservas | 1:N | Un vehiculo puede tener varias reservas a lo largo del tiempo. |
| reservas -> pagos | 1:N | Una reserva puede tener uno o mas pagos asociados. |

## Reglas de negocio

- Regla 1: Toda reserva debe apuntar a un cliente real y a un vehiculo real; todo pago debe apuntar a una reserva real (`FOREIGN KEY` en cadena).
- Regla 2: `licencia_conducir`, `modelo`, `fecha_pago` y `metodo` son `NOT NULL`.
- Regla 3: `tarifa_diaria` y `monto` siempre deben ser mayores a cero (`CHECK`); `fecha_fin` siempre debe ser posterior a `fecha_inicio` (`CHECK`).
- Regla 4: `nombre_cliente`, `licencia_conducir` y `placa` no se repiten (`UNIQUE`).
- Regla 5: Una reserva puede estar `confirmada`, `en_curso`, `finalizada` o `cancelada` (`CHECK`); un pago puede estar `completado` o `reembolsado` (`CHECK`); ambos se corrigen con `UPDATE`.
- Regla 6: Solo se permite `DELETE` de un pago cuando esta `reembolsado` **y** la reserva a la que pertenece esta `cancelada`. Un pago reembolsado de una reserva que no esta cancelada (por ejemplo, un reembolso parcial de una reserva activa) no se borra.

## Supuestos

- Una reserva puede no tener pago todavia (por ejemplo, una reserva `confirmada` que se pagara al recoger el auto); por eso `pagos` es una tabla aparte y no columnas dentro de `reservas`.

## Preguntas que responde la base de datos

1. Que reservas existen, con que cliente, que vehiculo y cuanto se ha pagado.
2. Que reservas no estan finalizadas todavia.
3. Que cliente tiene mas reservas.
4. Como se ordenan las reservas por fecha de inicio.
5. Cuanto ingreso genera cada vehiculo (solo pagos completados), para decidir cual vehiculo es mas rentable.
