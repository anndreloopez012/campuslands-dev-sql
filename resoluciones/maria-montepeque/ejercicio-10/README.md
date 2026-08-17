# Ejercicio 10: Hotel Reservas

**Nombre:** Maria Jose Montepeque

## Descripcion del problema

El hotel necesita reemplazar el registro manual de huespedes, habitaciones, reservas y pagos por una base de datos relacional que evite duplicidad y permita controlar la ocupacion y el cobro de cada reserva.

## Tablas y relaciones

- `huespedes`: catalogo de huespedes (nombre, documento, correo).
- `habitaciones`: catalogo de habitaciones (numero, tipo, precio por noche).
- `reservas`: reserva de una habitacion por un huesped (`huespedes` 1—N `reservas`, `habitaciones` 1—N `reservas`).
- `pagos`: pago realizado sobre una reserva (`reservas` 1—N `pagos`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `reservas.id_huesped`, `reservas.id_habitacion`, `pagos.id_reserva`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `huespedes.documento`, `huespedes.correo`, `habitaciones.numero`.
- `CHECK`: `habitaciones.tipo IN (...)`, `habitaciones.precio_noche > 0`, `reservas.fecha_checkout > reservas.fecha_checkin`, `reservas.estado IN (...)`, `pagos.monto > 0`, `pagos.metodo IN (...)`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 6 huespedes, 5 habitaciones, 5 reservas y 10 pagos tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (habitaciones.numero)` y otra por `CHECK (fecha_checkout > fecha_checkin)`.
- Consulta de decision de negocio (huesped con mas monto pagado en total): `Byron Xicay` con 1800.00.

## Como ejecutar

```bash
sqlite3 ejercicio-10.db < ddl/schema.sql
sqlite3 ejercicio-10.db < dml/inserts.sql
sqlite3 ejercicio-10.db < dml/operaciones.sql
sqlite3 ejercicio-10.db < dql/consultas.sql
```
