# Ejercicio 032: Solicitud de cliente - Academia Kickboxing

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una academia de kickboxing gestiona alumnos, planes, entrenadores y asistencias. El cliente pidio saber quien pago, cuando ocurrio y cuanto dinero represento cada movimiento.

## Tablas y relaciones

- `planes`: catalogo de planes de entrenamiento (nombre unico, precio mensual).
- `alumnos`: catalogo de alumnos, cada uno con su plan y entrenador (`planes` 1—N `alumnos`).
- `pagos`: registro transaccional de cada pago (`alumnos` 1—N `pagos`).

No se creo una tabla `entrenadores` separada: el entrenador se guarda como texto dentro de `alumnos` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `alumnos.id_plan` -> `planes.id_plan`, `pagos.id_alumno` -> `alumnos.id_alumno`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `planes.nombre_plan`, `alumnos.nombre_completo`.
- `CHECK`: `precio_mensual > 0`, `monto_pagado > 0`, `metodo_pago IN (...)`, `estado IN ('confirmado', 'pendiente', 'rechazado')`.
- `DEFAULT`: `fecha_pago` con la fecha/hora actual, `estado` en `'confirmado'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 4 planes, 5 alumnos y 9 pagos base (uno de ellos, el pago 9, es una duplicada por error de digitacion).
- `operaciones.sql` confirma un pago que estaba pendiente, cambia el entrenador de un alumno y elimina la duplicada: quedan 8 pagos.
- El caso comentado (`monto_pagado = 0`) falla al ejecutarlo: `CHECK constraint failed: monto_pagado > 0`.
- Reporte financiero por plan (sin rechazados, JOIN de las tres tablas): Plan Basico lidera con 1000.0 recaudado.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-032.db < ddl/schema.sql
sqlite3 ejercicio-032.db < dml/inserts.sql
sqlite3 ejercicio-032.db < dml/operaciones.sql
sqlite3 ejercicio-032.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
