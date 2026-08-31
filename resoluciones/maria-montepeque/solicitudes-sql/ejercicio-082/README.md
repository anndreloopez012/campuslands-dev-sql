# Solicitud SQL - Ejercicio 082: Academia Kickboxing

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una academia gestiona alumnos, planes, entrenadores y asistencias. El
cliente pide saber quien compro, que compro, cuando ocurrio y cuanto
dinero representa cada movimiento. Pidio convertir esa operacion en
una base de datos que permita consultar datos, corregir estados,
registrar movimientos y sacar reportes utiles.

## Que entendi de la solicitud

A diferencia de otras solicitudes de esta serie donde esta misma
frase ("quien compro, que compro...") no encajaba directo con el
dominio, aqui si: un alumno paga un plan, en una fecha, por un monto.
Es un nivel 5 (solicitud profesional): ademas del modelo, se pide
interpretar ambiguedad, normalizar datos, documentar decisiones y
crear al menos una vista SQL. El detalle completo del analisis,
incluidas las decisiones de modelado, esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `alumnos`: catalogo de alumnos inscritos.
- `planes`: catalogo de planes de membresia.
- `entrenadores`: catalogo de entrenadores.
- `asistencias`: tabla transaccional, cada clase a la que asiste un
  alumno. `UNIQUE (id_alumno, id_entrenador, fecha_clase)` evita
  registrar la misma clase dos veces.
- `pagos`: responde directamente la pregunta del cliente (quien pago,
  que plan, cuando y cuanto).

## Vista SQL

`vista_pagos_alumnos` (definida en [ddl/schema.sql](ddl/schema.sql))
junta pago, alumno y plan en una sola consulta legible, respondiendo
literalmente lo que pidio el cliente sin repetir el `JOIN` cada vez.

## Como se relacionan

`alumnos` 1:N `asistencias`; `entrenadores` 1:N `asistencias`;
`alumnos` 1:N `pagos`; `planes` 1:N `pagos`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 alumnos, 3 planes, 2 entrenadores, 7 asistencias (incluida una
cargada por error para un alumno que en realidad no asistio) y 4
pagos (2 `pendiente`, 2 `pagado`). Tambien un `INSERT` comentado que
reproduce el problema de registrar la misma asistencia dos veces y
debe fallar. Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `DELETE` controlado
que corrige la asistencia marcada por error (solo cuando es un error
de captura confirmado) y un `UPDATE` de estado (un pago pendiente se
confirma como pagado).

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el resumen completo de
pagos usando la vista (responde literalmente quien, que, cuando y
cuanto), en que estado esta cada pago, que alumno tiene mas
asistencias, los pagos ordenados por fecha, y un reporte con
`GROUP BY` + `HAVING` (tambien sobre la vista) de ingresos totales por
plan, para decidir en cual invertir mas promocion.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-082.db < ddl/schema.sql
sqlite3 ejercicio-082.db < dml/inserts.sql
sqlite3 ejercicio-082.db < dml/operaciones.sql
sqlite3 ejercicio-082.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
