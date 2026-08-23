# Ejercicio 008: Solicitud de cliente - Viajes y Paracaidismo

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una agencia vende experiencias de viaje, turismo y saltos en paracaidas, y pidio explicitamente poder consultar rankings, totales y casos pendientes directamente desde la base de datos.

## Tablas y relaciones

- `experiencias`: catalogo de lo que vende la agencia (nombre unico, tipo, precio).
- `reservas`: registro transaccional de cada venta, con su estado (`experiencias` 1—N `reservas`).

No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del cliente se guarda dentro de `reservas` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `reservas.id_experiencia` -> `experiencias.id_experiencia`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `experiencias.nombre_experiencia`.
- `CHECK`: `precio > 0`, `monto_pagado > 0`, `tipo IN (...)`, `estado IN ('pendiente', 'confirmada', 'completada', 'cancelada')`.
- `DEFAULT`: `fecha_reserva` con la fecha actual, `estado` en `'pendiente'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 experiencias y 9 reservas base (una de ellas, la reserva 9, es una entrada de prueba insertada por error).
- `operaciones.sql` confirma una reserva pendiente, ajusta el precio de una experiencia y elimina la entrada de prueba: quedan 8 reservas.
- El caso comentado (`tipo = 'buceo'`) falla al ejecutarlo: `CHECK constraint failed: tipo IN ('viaje', 'paracaidismo', 'turismo')`.
- Ranking (experiencia con mas reservas): `Salto en Paracaidas Nivel 1`, con 3.
- Totales (ingresos por experiencia, sin canceladas): `Salto en Paracaidas Nivel 1` genera el mayor ingreso (4500.0).
- Casos pendientes: solo queda 1 reserva pendiente (la de Ana Gomez del 2026-07-20).

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-008.db < ddl/schema.sql
sqlite3 ejercicio-008.db < dml/inserts.sql
sqlite3 ejercicio-008.db < dml/operaciones.sql
sqlite3 ejercicio-008.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
