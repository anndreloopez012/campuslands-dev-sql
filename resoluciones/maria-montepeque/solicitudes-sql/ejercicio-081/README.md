# Solicitud SQL - Ejercicio 081: Renta Autos de Lujo

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una empresa alquila autos deportivos y necesita controlar reservas,
clientes y pagos. El cliente dice que hoy todo se maneja en hojas de
calculo y que varias personas duplican datos sin darse cuenta. Pidio
convertir esa operacion en una base de datos que permita consultar
datos, corregir estados, registrar movimientos y sacar reportes
utiles.

## Que entendi de la solicitud

Es un nivel 5 (solicitud profesional): ademas del modelo relacional,
se pide interpretar ambiguedad, normalizar datos, documentar
decisiones de diseno y crear al menos una vista SQL. El problema
central del cliente (duplicados por varias personas) se resuelve con
restricciones `UNIQUE` en los puntos exactos donde ocurriria un
duplicado real: pagos e inspecciones. El detalle completo del
analisis, incluidas las decisiones de modelado y la ambiguedad que no
resolvio el cliente, esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`: catalogo de clientes, con licencia unica.
- `vehiculos`: catalogo de autos disponibles, con su tarifa diaria.
- `reservas`: tabla transaccional, cada renta de un vehiculo.
- `pagos`: resultado de una reserva. `UNIQUE (id_reserva)` impide
  registrar dos pagos para la misma reserva.
- `inspecciones`: detalle de cada reserva (entrega y devolucion).
  `UNIQUE (id_reserva, tipo_inspeccion)` impide cargar dos veces la
  misma inspeccion.

## Vista SQL

`vista_resumen_reservas` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta reserva, cliente, vehiculo y
pago en una sola consulta, usando `LEFT JOIN` para que las reservas
sin pago todavia (en curso o canceladas) sigan apareciendo con
`monto_pagado = NULL` en vez de desaparecer del reporte.

## Como se relacionan

`clientes` 1:N `reservas`; `vehiculos` 1:N `reservas`; `reservas` 1:1
`pagos`; `reservas` 1:N `inspecciones` (maximo 2: entrega y
devolucion). El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 clientes, 4 vehiculos, 4 reservas (2 `finalizada` con pago, 1
`en_curso` sin pago, 1 `reservada` con una inspeccion cargada por
error), 2 pagos y 6 inspecciones. Tambien un `INSERT` comentado que
reproduce exactamente el problema del cliente (segundo pago para la
misma reserva) y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(la reserva cancelada antes de recoger el vehiculo) y un `DELETE`
controlado que elimina la inspeccion de entrega que quedo invalida,
sin tocar ninguna inspeccion de una reserva ya `en_curso` o
`finalizada`.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el resumen completo de
reservas usando la vista, en que estado esta cada reserva, que cliente
tiene mas reservas, las reservas ordenadas por fecha, y un reporte con
`GROUP BY` + `HAVING` (tambien sobre la vista) de ingresos totales por
categoria de vehiculo, para decidir en cual invertir mas flota.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-081.db < ddl/schema.sql
sqlite3 ejercicio-081.db < dml/inserts.sql
sqlite3 ejercicio-081.db < dml/operaciones.sql
sqlite3 ejercicio-081.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
