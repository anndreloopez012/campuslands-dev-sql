# Analisis del requerimiento - Ejercicio 041

## Solicitud entendida

Un hotel tematico recibe reservas, habitaciones, torneos internos y consumos. Hoy todo se maneja en hojas de calculo y varias personas duplican datos sin darse cuenta. Este es un ejercicio de nivel 3: ademas de consultar y corregir estados, se pide `DELETE` controlado (con criterios seguros, no borrados a ciegas).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| huespedes | Es el catalogo de huespedes del hotel. | nombre_huesped (unico), email (unico) |
| habitaciones | Es el catalogo de habitaciones disponibles. | numero_habitacion (unico), tipo, precio_noche |
| reservas | Es el registro transaccional de cada estadia: que huesped, que habitacion, cuando entra y sale, y en que estado va. | id_huesped (FK), id_habitacion (FK), fecha_checkin, fecha_checkout, estado |
| consumos | Es el registro de cada gasto extra durante una reserva (torneos internos, renta de consolas, snacks). Depende de una reserva especifica. | id_reserva (FK), descripcion, monto, fecha_consumo |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| huespedes -> reservas | 1:N | Un huesped puede tener muchas reservas. |
| habitaciones -> reservas | 1:N | Una habitacion puede tener muchas reservas a lo largo del tiempo. |
| reservas -> consumos | 1:N | Una reserva puede tener muchos consumos asociados. |

## Reglas de negocio

- Regla 1: Toda reserva debe apuntar a un huesped real y a una habitacion real (`FOREIGN KEY` doble).
- Regla 2: Todo consumo debe apuntar a una reserva real (`FOREIGN KEY`).
- Regla 3: `nombre_huesped`, `email` y `numero_habitacion` no se repiten (`UNIQUE`), justamente para evitar el problema que reporto el cliente: personas duplicando el mismo huesped o la misma habitacion sin darse cuenta.
- Regla 4: `fecha_checkout` siempre debe ser posterior a `fecha_checkin` (`CHECK`).
- Regla 5: `precio_noche` y `monto` siempre deben ser mayores a cero (`CHECK`).
- Regla 6: Una reserva puede estar `confirmada`, `en_curso`, `finalizada` o `cancelada` (`CHECK`); el hotel corrige este estado con `UPDATE` a medida que avanza la estadia.
- Regla 7: Solo se permite `DELETE` de una reserva cuando esta `cancelada` **y** no tiene ningun consumo registrado. Si ya tiene un consumo (por ejemplo un deposito cobrado antes de cancelar), no se borra: queda como historial de que la cancelacion tuvo un costo.

## Supuestos

- El "torneo interno" que menciona el contexto se modelo como una fila mas de `consumos` (con `descripcion = 'Torneo interno - inscripcion'`), no como una tabla aparte, porque el alcance de este nivel es 3 a 4 tablas y un torneo interno, para efectos de facturacion, es un cargo mas asociado a una reserva.
- El total a facturar de una reserva se calcula como noches de estadia (`fecha_checkout - fecha_checkin`) por `precio_noche`, mas la suma de sus `consumos`.

## Preguntas que responde la base de datos

1. Que reservas existen, con que huesped y que habitacion.
2. Que reservas no estan finalizadas todavia.
3. Que huesped tiene mas consumo acumulado.
4. Como se ordenan las reservas por fecha de checkin.
5. Cuanto hay que facturar por cada reserva activa (habitacion + consumos), para priorizar el cobro de las cuentas mas altas.
