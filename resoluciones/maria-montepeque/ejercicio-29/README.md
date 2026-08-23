# Ejercicio 29: Transacciones Reservas

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Un sistema de reservas de recursos (salas, canchas, auditorio, laboratorio) necesita reemplazar el registro manual de usuarios, recursos, reservas y pagos por una base de datos relacional que evite duplicidad de datos y que ademas garantice consistencia cuando una reserva y su pago se registran juntos.

## Tablas y relaciones

- `usuarios`: catalogo de usuarios que reservan recursos (nombre, correo).
- `recursos`: catalogo de recursos reservables (nombre, precio por hora).
- `reservas`: reserva de un recurso hecha por un usuario (fecha de inicio, fecha de fin, estado). `usuarios` 1—N `reservas` y `recursos` 1—N `reservas`.
- `pagos`: pago asociado a una reserva confirmada (monto, fecha). Relacion 1 a 1 con `reservas` (una reserva tiene a lo sumo un pago).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `reservas.id_usuario`, `reservas.id_recurso`, `pagos.id_reserva`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `usuarios.correo`, `recursos.nombre`, `pagos.id_reserva` (evita mas de un pago por reserva).
- `CHECK`: `recursos.precio_hora > 0`, `reservas.fecha_fin > fecha_inicio`, `reservas.estado IN ('pendiente', 'confirmada', 'cancelada')`, `pagos.monto > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Transacciones (tema del ejercicio)

En `dml/operaciones.sql`, ademas de los INSERT/UPDATE/DELETE requeridos, se incluyen dos bloques que demuestran el uso de transacciones para mantener la consistencia:

- **`BEGIN TRANSACTION ... COMMIT`**: crea una reserva y su pago en una sola transaccion atomica, usando `last_insert_rowid()` para enlazar el pago con la reserva recien creada. Si cualquiera de los dos INSERT fallara, ninguno quedaria aplicado.
- **`BEGIN TRANSACTION ... ROLLBACK`**: inicia una reserva de prueba y la revierte explicitamente, demostrando que un `ROLLBACK` deja la base de datos exactamente como estaba antes de la transaccion (no queda ningun rastro de la reserva de prueba).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 usuarios, 5 recursos, 10 reservas, 6 pagos (solo reservas confirmadas).
- Tras aplicar `operaciones.sql`: 6 usuarios, 5 recursos, 10 reservas y 7 pagos.
- Se verifico que la reserva del `ROLLBACK` (usuario 4, `2026-08-20 08:00`) no existe en la base de datos.
- Se verifico que la reserva y el pago del `COMMIT` (usuario 3, `2026-08-15 17:00`, pago de 750.00) quedaron registrados correctamente.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (usuarios.correo)` y otra por `CHECK (reservas.fecha_fin > fecha_inicio)`.
- Consulta de decision de negocio (recurso con mayores ingresos por reservas pagadas): `Auditorio Principal` con 1500.00.

## Como ejecutar

```bash
sqlite3 ejercicio-29.db < ddl/schema.sql
sqlite3 ejercicio-29.db < dml/inserts.sql
sqlite3 ejercicio-29.db < dml/operaciones.sql
sqlite3 ejercicio-29.db < dql/consultas.sql
```
