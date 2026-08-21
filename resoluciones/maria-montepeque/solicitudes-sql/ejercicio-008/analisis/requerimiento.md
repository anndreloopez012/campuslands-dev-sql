# Analisis del requerimiento - Ejercicio 008

## Solicitud entendida

Una agencia vende experiencias de viaje, turismo y saltos en paracaidas. El cliente pidio explicitamente poder consultar **rankings** (que experiencia se reserva mas), **totales** (cuanto genera cada experiencia) y **casos pendientes** (reservas que todavia no se confirman) directamente desde la base de datos.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| experiencias | Es el catalogo de lo que vende la agencia: saltos, tours, viajes, cada uno con su tipo y precio. | nombre_experiencia (unico), tipo, precio |
| reservas | Es el registro transaccional de cada venta: que experiencia, que cliente, cuanto pago y en que estado va (pendiente, confirmada, completada, cancelada). Aqui viven directamente los rankings, totales y pendientes que pidio el cliente. | id_experiencia (FK), nombre_cliente, fecha_reserva, monto_pagado, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| experiencias -> reservas | 1:N | Una experiencia puede tener muchas reservas, pero cada reserva es de una unica experiencia. |

## Reglas de negocio

- Regla 1: Toda reserva debe apuntar a una experiencia real del catalogo (`FOREIGN KEY`).
- Regla 2: `precio` y `monto_pagado` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Una reserva puede estar `pendiente`, `confirmada`, `completada` o `cancelada` (`CHECK`); esto es exactamente lo que permite responder "casos pendientes" con una simple consulta filtrada.
- Regla 4: El nombre de la experiencia no se repite (`UNIQUE`), evita cargarla dos veces en el catalogo.

## Supuestos

- No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del cliente se guarda dentro de `reservas`.
- `monto_pagado` se guarda en la reserva (no solo se calcula desde `experiencias.precio`) porque el precio de catalogo puede cambiar con el tiempo, y la reserva debe conservar lo que realmente se cobro ese dia.
- El "ranking" que pide el cliente se interpreta como la experiencia con mas reservas validas (sin contar canceladas), y el "total" como la suma de `monto_pagado` por experiencia.

## Preguntas que responde la base de datos

1. Que reservas existen y en que estado quedo cada una.
2. Que reservas estan pendientes (casos pendientes, tal como pidio el cliente).
3. Ranking: que experiencia tiene mas reservas.
4. Como se ordenan las reservas por fecha.
5. Totales: cuanto genera cada experiencia (sin contar canceladas), para decidir cual promocionar mas.
