# Solicitud SQL - Ejercicio 083: Viajes y Paracaidismo

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una agencia vende experiencias de viaje, turismo y saltos en
paracaidas. El cliente quiere evitar registros incompletos porque
despues no puede hacer reportes confiables. Pidio convertir esa
operacion en una base de datos que permita consultar datos, corregir
estados, registrar movimientos y sacar reportes utiles.

## Que entendi de la solicitud

El problema no es "guardar reservas", es garantizar que ninguna
reserva quede duplicada y que el estado de sus pagos siempre sea
visible y confiable, incluso cuando falta informacion (una reserva sin
pago todavia). Es un nivel 5 (solicitud profesional): ademas del
modelo, se pide interpretar ambiguedad, normalizar datos, documentar
decisiones y crear al menos una vista SQL. El detalle completo del
analisis esta en [analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`: catalogo de clientes.
- `experiencias`: catalogo de experiencias disponibles.
- `instructores`: catalogo de instructores.
- `reservas`: tabla transaccional. `UNIQUE (id_cliente, id_experiencia,
  fecha_reserva)` impide registrar la misma reserva dos veces.
- `pagos`: resultado de una reserva. `UNIQUE (id_reserva)` garantiza
  un solo pago oficial por reserva.

## Vista SQL

`vista_resumen_reservas` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta reserva, cliente, experiencia,
instructor y pago con `LEFT JOIN`. Esto ataca directamente el problema
de "reportes no confiables": una reserva sin pago no desaparece del
reporte, aparece con `monto_pagado = NULL`, visible y explicito.

## Como se relacionan

`clientes` 1:N `reservas`; `experiencias` 1:N `reservas`;
`instructores` 1:N `reservas`; `reservas` 1:1 `pagos`. El diagrama
esta en [diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 clientes, 3 experiencias, 2 instructores, 4 reservas (2 `realizada`
con pago, 1 `confirmada` sin pago, 1 marcada `realizada` por error con
un pago que se corrige despues) y 3 pagos. Tambien un `INSERT`
comentado que reproduce el problema de duplicar una reserva y debe
fallar. Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(la reserva que se marco realizada por error pasa a `cancelada`) y un
`DELETE` controlado que elimina el pago invalido de esa reserva, sin
tocar ningun pago de una reserva ya `realizada`.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el resumen completo de
reservas usando la vista, en que estado esta cada reserva, que cliente
tiene mas reservas, las reservas ordenadas por fecha, y un reporte con
`GROUP BY` + `HAVING` (tambien sobre la vista) de ingresos totales por
tipo de experiencia, para decidir en cual invertir mas promocion.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-083.db < ddl/schema.sql
sqlite3 ejercicio-083.db < dml/inserts.sql
sqlite3 ejercicio-083.db < dml/operaciones.sql
sqlite3 ejercicio-083.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
