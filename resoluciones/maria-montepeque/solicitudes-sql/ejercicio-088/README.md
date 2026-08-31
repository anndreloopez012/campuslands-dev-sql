# Solicitud SQL - Ejercicio 088: Clinica de Tatuajes

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Un estudio de tatuajes agenda sesiones, artistas, estilos y pagos. El
cliente quiere consultar rankings, totales y casos pendientes desde
la base de datos. Pidio convertir esa operacion en una base de datos
que permita consultar datos, corregir estados, registrar movimientos
y sacar reportes utiles.

## Que entendi de la solicitud

"Rankings, totales y casos pendientes" se tradujo en tres tipos de
consulta concretos: ranking de artistas por actividad, totales de
ingresos por artista, y sesiones `'programada'` como casos
pendientes. Es un nivel 5 (solicitud profesional): ademas del modelo,
se pide interpretar ambiguedad, normalizar datos, documentar
decisiones y crear al menos una vista SQL. El detalle completo del
analisis esta en [analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`, `artistas`, `estilos`: catalogos.
- `sesiones`: tabla transaccional, cada cita agendada.
- `pagos`: resultado de una sesion. `UNIQUE (id_sesion)` garantiza un
  solo pago oficial por sesion.

## Vista SQL

`vista_resumen_sesiones` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta sesion, cliente, artista,
estilo y pago con `LEFT JOIN`, y sirve de base comun para los tres
tipos de reporte que pidio el cliente.

## Como se relacionan

`clientes` 1:N `sesiones`; `artistas` 1:N `sesiones`; `estilos` 1:N
`sesiones`; `sesiones` 1:1 `pagos`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 clientes, 3 artistas, 3 estilos, 5 sesiones (3 `finalizada` con
pago, 1 `programada` como caso pendiente, 1 marcada `finalizada` por
error con un pago que se corrige despues) y 4 pagos. Tambien un
`INSERT` comentado que reproduce el problema de duplicar un pago para
la misma sesion y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(la sesion aplazada pasa a `cancelada`) y un `DELETE` controlado que
elimina el pago invalido de esa sesion, sin tocar ningun pago de una
sesion ya `finalizada`.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el resumen completo de
sesiones usando la vista, que sesiones estan pendientes, un ranking
de artistas con `ORDER BY` + `LIMIT`, las sesiones ordenadas por
fecha y duracion, y un reporte de totales con `GROUP BY` + `HAVING`
de ingresos por artista, para decidir a quien asignar mas horarios.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-088.db < ddl/schema.sql
sqlite3 ejercicio-088.db < dml/inserts.sql
sqlite3 ejercicio-088.db < dml/operaciones.sql
sqlite3 ejercicio-088.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
