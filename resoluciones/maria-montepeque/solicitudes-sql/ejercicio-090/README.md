# Solicitud SQL - Ejercicio 090: Laboratorio Quimico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-25

## Solicitud del cliente

Un laboratorio quimico registra formulas, muestras, reactivos y
resultados. El cliente quiere detectar errores (registros repetidos,
relaciones invalidas o valores fuera de rango) y pidio convertir esa
operacion en una base de datos que permita consultar datos, corregir
estados, registrar movimientos y sacar reportes utiles.

## Que entendi de la solicitud

Ninguna muestra se borra una vez registrada: el historico solo se
corrige con `UPDATE` de estado. Es un nivel 5 (solicitud profesional):
ademas del modelo, se pide interpretar ambiguedad, normalizar datos,
documentar decisiones y crear al menos una vista SQL. El detalle
completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `tecnicos`, `formulas`, `reactivos`: catalogos.
- `muestras`: historico, cada muestra recibida para analisis.
- `resultados`: historico, con `UNIQUE (id_muestra)` para que una
  muestra nunca tenga dos resultados oficiales contradictorios.
- `detalle_reactivos`: tabla puente entre muestras y reactivos.

## Vista SQL

`vista_historial_muestra` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta muestra, formula, tecnico y
resultado, respondiendo directamente "que paso y cuando paso" con
cada muestra.

## Como se relacionan

`tecnicos` 1:N `muestras`; `formulas` 1:N `muestras`; `muestras` 1:1
`resultados`; `muestras` 1:N `detalle_reactivos`; `reactivos` 1:N
`detalle_reactivos`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 tecnicos, 4 formulas, 5 reactivos, 6 muestras (2 `finalizada`, 1
`rechazada`, 2 `en_analisis`, 1 `recibida`), 3 resultados y 7 lineas
de detalle, incluida una cargada por error en una muestra todavia
`en_analisis`. Tambien un `INSERT` comentado que reproduce el
problema de dos resultados oficiales para la misma muestra y debe
fallar. Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `INSERT` adicional
(nueva muestra recibida), un `UPDATE` de estado (una muestra pasa de
`recibida` a `en_analisis`) y un `DELETE` controlado que corrige la
linea de reactivo agregada por error (solo mientras la muestra sigue
`recibida` o `en_analisis`).

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el historial completo
usando la vista, que muestras estan en analisis en este momento, que
reactivos se usaron en cada muestra (via `JOIN`), las muestras
ordenadas por fecha de recepcion, un `GROUP BY` del promedio de valor
medido por formula, y un reporte final con `HAVING` de que formulas
tienen muestras rechazadas, para decidir cuales revisar con el
proveedor de reactivos.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-090.db < ddl/schema.sql
sqlite3 ejercicio-090.db < dml/inserts.sql
sqlite3 ejercicio-090.db < dml/operaciones.sql
sqlite3 ejercicio-090.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
