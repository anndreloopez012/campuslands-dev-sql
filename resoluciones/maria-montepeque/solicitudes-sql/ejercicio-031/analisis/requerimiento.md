# Analisis del requerimiento - Ejercicio 031

## Solicitud entendida

Una empresa alquila autos deportivos y necesita controlar reservas, clientes y pagos. Hoy todo se maneja en hojas de calculo y varias personas duplican datos sin darse cuenta. A diferencia de una version mas basica de este mismo caso, aqui se pide una relacion real (con `FOREIGN KEY` y `JOIN`) entre vehiculos, clientes y reservas.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| vehiculos | Es el catalogo permanente de autos que posee la empresa. | placa (unica), marca, modelo, precio_dia, estado |
| clientes | Es el catalogo de clientes que alquilan autos. | nombre_cliente (unico), licencia (unica) |
| reservas | Es el registro transaccional de cada alquiler: que vehiculo, que cliente, que fechas, cuanto se cobro y en que estado va. | id_vehiculo (FK), id_cliente (FK), fecha_inicio, fecha_fin, monto_total, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| vehiculos -> reservas | 1:N | Un vehiculo tiene muchas reservas a lo largo del tiempo. |
| clientes -> reservas | 1:N | Un cliente puede tener muchas reservas. |

## Reglas de negocio

- Regla 1: Toda reserva debe apuntar a un vehiculo real y a un cliente real (`FOREIGN KEY` doble).
- Regla 2: `precio_dia` y `monto_total` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Una reserva puede estar `confirmada`, `en_curso`, `finalizada` o `cancelada` (`CHECK`); la empresa necesita poder corregir este estado a medida que avanza el alquiler.
- Regla 4: Un vehiculo puede estar `disponible`, `rentado` o `mantenimiento` (`CHECK`); este estado es independiente del estado de cada reserva individual.
- Regla 5: `placa`, `nombre_cliente` y `licencia` no se repiten (`UNIQUE`).

## Supuestos

- A diferencia de una version mas simple de este mismo caso (donde el cliente se guardaba como texto dentro de la reserva), aqui se creo una tabla `clientes` real con `FOREIGN KEY`, siguiendo el alcance de este nivel.
- `monto_total` se guarda en la reserva porque el precio de catalogo puede cambiar con el tiempo, y la reserva debe conservar lo que realmente se cobro.

## Preguntas que responde la base de datos

1. Que reservas existen y en que estado quedo cada una.
2. Que reservas no estan finalizadas todavia.
3. Que cliente tiene mas reservas.
4. Como se ordenan las reservas por fecha de inicio.
5. Que reporte de ingresos por vehiculo (sin contar canceladas) puede usar la empresa para decidir que auto conviene mantener en la flota.
