# Ejercicio 031: Solicitud de cliente - Renta Autos de Lujo

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una empresa alquila autos deportivos y necesita controlar reservas, clientes y pagos, evitando el problema de que varias personas dupliquen datos sin darse cuenta. A diferencia de una version mas basica de este mismo caso, aqui se pide una relacion real (con `FOREIGN KEY` y `JOIN`) entre vehiculos, clientes y reservas.

## Tablas y relaciones

- `vehiculos`: catalogo de autos de la empresa (placa unica, marca, modelo, precio por dia, estado).
- `clientes`: catalogo de clientes (nombre unico, licencia unica).
- `reservas`: registro transaccional de cada alquiler (`vehiculos` 1—N `reservas`, `clientes` 1—N `reservas`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `reservas.id_vehiculo` -> `vehiculos.id_vehiculo`, `reservas.id_cliente` -> `clientes.id_cliente`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `vehiculos.placa`, `clientes.nombre_cliente`, `clientes.licencia`.
- `CHECK`: `precio_dia > 0`, `monto_total > 0`, `vehiculos.estado IN (...)`, `reservas.estado IN (...)`.
- `DEFAULT`: `vehiculos.estado` en `'disponible'`, `reservas.estado` en `'confirmada'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 vehiculos, 5 clientes y 9 reservas base (una de ellas, la reserva 9, es una duplicada por error de digitacion).
- `operaciones.sql` marca una reserva como finalizada, envia un auto a mantenimiento y elimina la duplicada: quedan 8 reservas.
- El caso comentado (`monto_total = 0`) falla al ejecutarlo: `CHECK constraint failed: monto_total > 0`.
- Cliente con mas reservas: Rosa Mendez, con 3.
- Vehiculo que mas ingresos genera (sin canceladas): Lamborghini Huracan, con 3900.0.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-031.db < ddl/schema.sql
sqlite3 ejercicio-031.db < dml/inserts.sql
sqlite3 ejercicio-031.db < dml/operaciones.sql
sqlite3 ejercicio-031.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
