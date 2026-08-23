# Analisis del requerimiento - Ejercicio 038

## Solicitud entendida

Un estudio de tatuajes agenda sesiones, artistas, estilos y pagos. El cliente quiere poder consultar rankings, totales y casos pendientes directamente desde la base de datos, no calcularlos a mano.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes que agendan sesiones de tatuaje. | nombre_cliente (unico), telefono |
| artistas | Es el catalogo de tatuadores del estudio, cada uno con su estilo. | nombre_artista (unico), estilo |
| sesiones | Es el registro transaccional de cada sesion: que cliente, que artista, cuando, cuanto cuesta, cuanto se ha pagado y en que estado va. Aqui es donde el estudio saca los rankings y detecta los pagos pendientes. | id_cliente (FK), id_artista (FK), fecha_sesion, costo_total, monto_pagado, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> sesiones | 1:N | Un cliente puede agendar muchas sesiones. |
| artistas -> sesiones | 1:N | Un artista puede tener muchas sesiones asignadas. |

## Reglas de negocio

- Regla 1: Toda sesion debe apuntar a un cliente real y a un artista real (`FOREIGN KEY` doble).
- Regla 2: `telefono` y `estilo` son `NOT NULL`: son datos que, si faltaran, romperian el contacto con el cliente o la clasificacion del artista.
- Regla 3: `costo_total` siempre debe ser mayor a cero (`CHECK`).
- Regla 4: `monto_pagado` nunca puede ser negativo ni superar el `costo_total` (`CHECK`), porque no tiene sentido cobrar de mas ni registrar un pago negativo.
- Regla 5: Una sesion puede estar `agendada`, `completada` o `cancelada` (`CHECK`); el estudio necesita poder corregir este estado.
- Regla 6: `nombre_cliente` y `nombre_artista` no se repiten (`UNIQUE`).

## Supuestos

- El pago se guarda como dos columnas en la misma fila de `sesiones` (`costo_total` y `monto_pagado`), no en una tabla `pagos` aparte, porque el alcance de este nivel es relaciones basicas y cada sesion tiene como maximo un saldo que rastrear. Una version mas avanzada necesitaria una tabla `pagos` para registrar abonos parciales en fechas distintas.
- Una sesion `cancelada` no genera saldo pendiente que cobrar, aunque tenga `costo_total` definido, porque el servicio no se llego a prestar.

## Preguntas que responde la base de datos

1. Que sesiones existen, con que cliente y que artista.
2. Que sesiones no estan completadas todavia.
3. Que artista tiene mas sesiones (ranking de actividad).
4. Como se ordenan las sesiones por fecha.
5. Que sesiones tienen saldo pendiente de pago, para saber a quien cobrar (casos pendientes).
