# Analisis del requerimiento - Ejercicio 033

## Solicitud entendida

Una agencia vende experiencias de viaje, turismo y saltos en paracaidas. El cliente pidio explicitamente evitar registros incompletos, porque despues no puede hacer reportes confiables. A diferencia de una version mas basica de este mismo caso, aqui se pide una relacion real (con `FOREIGN KEY` y `JOIN`) entre experiencias, clientes y reservas.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| experiencias | Es el catalogo de lo que vende la agencia (nombre unico, tipo, precio). | nombre_experiencia (unico), tipo, precio |
| clientes | Es el catalogo de clientes de la agencia. | nombre_cliente (unico), telefono |
| reservas | Es el registro transaccional de cada venta: que experiencia, que cliente, cuando, cuanto se pago y en que estado va. Aqui es donde el cliente sufre los registros incompletos si algun campo clave falta. | id_experiencia (FK), id_cliente (FK), fecha_reserva, monto_pagado, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| experiencias -> reservas | 1:N | Una experiencia puede tener muchas reservas. |
| clientes -> reservas | 1:N | Un cliente puede hacer muchas reservas. |

## Reglas de negocio

- Regla 1: Toda reserva debe apuntar a una experiencia real y a un cliente real (`FOREIGN KEY` doble).
- Regla 2: `precio`, `monto_pagado` y `telefono` son `NOT NULL`: son exactamente los datos que, si faltaran, harian que un reporte de ingresos o de contacto no sea confiable.
- Regla 3: `monto_pagado` siempre debe ser mayor a cero (`CHECK`).
- Regla 4: Una reserva puede estar `pendiente`, `confirmada`, `completada` o `cancelada` (`CHECK`); la agencia necesita poder corregir este estado.
- Regla 5: `nombre_experiencia` y `nombre_cliente` no se repiten (`UNIQUE`).

## Supuestos

- A diferencia de una version mas simple de este mismo caso (donde el cliente se guardaba como texto dentro de la reserva), aqui se creo una tabla `clientes` real con `FOREIGN KEY`, siguiendo el alcance de este nivel.

## Preguntas que responde la base de datos

1. Que reservas existen y en que estado quedo cada una.
2. Que reservas no estan completadas todavia.
3. Que cliente tiene mas reservas.
4. Como se ordenan las reservas por fecha.
5. Totales: cuanto genera cada experiencia (sin contar canceladas), para decidir cual promocionar mas.
