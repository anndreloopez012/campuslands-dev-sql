# Ejercicio 09: Gimnasio Membresias

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-04

## Descripcion del problema

El gimnasio necesita reemplazar el registro manual de clientes, planes, membresias y pagos por una base de datos relacional que evite duplicidad y permita controlar membresias activas y su historial de pagos.

## Tablas y relaciones

- `clientes`: catalogo de clientes (nombre, correo).
- `planes`: catalogo de planes de membresia (nombre, duracion, precio).
- `membresias`: membresia adquirida por un cliente sobre un plan (`clientes` 1—N `membresias`, `planes` 1—N `membresias`).
- `pagos`: pago realizado sobre una membresia (`membresias` 1—N `pagos`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `membresias.id_cliente`, `membresias.id_plan`, `pagos.id_membresia`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.correo`, `planes.nombre`.
- `CHECK`: `planes.duracion_meses > 0`, `planes.precio > 0`, `membresias.estado IN (...)`, `pagos.monto > 0`, `pagos.metodo IN (...)`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 5 clientes, 6 planes, 6 membresias y 9 pagos tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (planes.nombre)` y otra por `CHECK (monto > 0)`.
- Consulta de decision de negocio (cliente con mas monto pagado en total): `Nestor Cabrera` con 2600.00.

## Como ejecutar

```bash
sqlite3 ejercicio-09.db < ddl/schema.sql
sqlite3 ejercicio-09.db < dml/inserts.sql
sqlite3 ejercicio-09.db < dml/operaciones.sql
sqlite3 ejercicio-09.db < dql/consultas.sql
```
