# Analisis del requerimiento - Ejercicio 058

## Solicitud entendida

Una agencia vende experiencias de viaje, turismo y saltos en paracaidas. El cliente quiere poder consultar rankings, totales y casos pendientes directamente desde la base de datos. Es nivel 3: se pide `DELETE` controlado con criterios de negocio reales.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes de la agencia. | nombre_cliente (unico), telefono |
| experiencias | Es el catalogo de experiencias que vende la agencia. | nombre_experiencia (unico), tipo, precio |
| reservas | Es el registro de cada reserva: que cliente, que experiencia, cuando y en que estado va. | id_cliente (FK), id_experiencia (FK), fecha_reserva, estado |
| pagos | Es el registro de cada pago o deposito asociado a una reserva. | id_reserva (FK), monto, fecha_pago, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> reservas | 1:N | Un cliente puede tener varias reservas. |
| experiencias -> reservas | 1:N | Una experiencia puede tener varias reservas. |
| reservas -> pagos | 1:N | Una reserva puede tener uno o mas pagos (por ejemplo, un deposito y despues el resto). |

## Reglas de negocio

- Regla 1: Toda reserva debe apuntar a un cliente real y a una experiencia real; todo pago debe apuntar a una reserva real (`FOREIGN KEY` en cadena).
- Regla 2: `telefono`, `tipo`, `fecha_reserva` y `fecha_pago` son `NOT NULL`.
- Regla 3: `precio` y `monto` siempre deben ser mayores a cero (`CHECK`).
- Regla 4: `nombre_cliente` y `nombre_experiencia` no se repiten (`UNIQUE`).
- Regla 5: Una reserva puede estar `pendiente`, `confirmada`, `completada` o `cancelada`, y un pago puede estar `completado` o `reembolsado` (`CHECK`); ambos se corrigen con `UPDATE`.
- Regla 6: Solo se permite `DELETE` de una reserva cuando esta `cancelada` **y** nunca tuvo ningun pago registrado (ni siquiera un deposito). Una reserva cancelada que si tuvo un pago (aunque haya sido reembolsado) no se borra: se conserva como historial financiero.

## Supuestos

- Una reserva puede tener cero, uno o varios pagos (por ejemplo, un deposito y luego el resto), por eso `pagos` es una tabla aparte y no una columna dentro de `reservas`.

## Preguntas que responde la base de datos

1. Que reservas existen, con que cliente, que experiencia y cuanto se ha pagado.
2. Que reservas no estan completadas todavia (casos pendientes).
3. Que cliente tiene mas reservas (ranking de actividad).
4. Como se ordenan las reservas por fecha.
5. Cuanto ha recaudado cada experiencia (solo pagos completados), para decidir cual promocionar mas.
