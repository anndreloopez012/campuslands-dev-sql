# Solicitud SQL - Ejercicio 070: Soldadura Industrial

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Un taller de soldadura industrial controla ordenes, materiales,
tecnicos, inspecciones y costos. El cliente pidio detectar tres tipos
de error: registros repetidos, relaciones invalidas y valores fuera de
rango. Ademas queria poder consultar datos, corregir estados,
registrar movimientos y sacar reportes utiles (no solo guardar texto).

## Que entendi de la solicitud

El nivel pedido (4, reportes y agrupaciones) exige, ademas del modelo
base con `CHECK`/`FOREIGN KEY`/`UNIQUE`, consultas con `JOIN`,
`GROUP BY`, `HAVING`, totales y ranking. El detalle completo del
analisis (entidades, relaciones, reglas de negocio y supuestos) esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`: catalogo de quien encarga cada orden de trabajo.
- `tecnicos`: catalogo de quien ejecuta el trabajo de soldadura.
- `ordenes`: tabla transaccional, ligada a un cliente y a un tecnico
  reales (`FOREIGN KEY`).
- `materiales`: detalle de costos de cada orden (`cantidad` y
  `costo_unitario`, ambos protegidos con `CHECK` para que nunca queden
  fuera de rango).
- `inspecciones`: historico de calidad de cada orden; nunca se borra,
  solo se agrega una inspeccion nueva cuando se corrige algo.

Aqui es donde se detectan y corrigen los tres errores que pidio el
cliente:

- Registros repetidos -> `UNIQUE` en `clientes.nombre_cliente`,
  `clientes.telefono` y `tecnicos.nombre_tecnico`.
- Relaciones invalidas -> `FOREIGN KEY` en cadena (orden -> cliente,
  orden -> tecnico, material -> orden, inspeccion -> orden).
- Valores fuera de rango -> `CHECK` (`cantidad > 0`,
  `costo_unitario >= 0`, `estado`/`resultado` dentro de una lista
  cerrada de valores).

## Como se relacionan

`clientes` 1:N `ordenes`, `tecnicos` 1:N `ordenes`, `ordenes` 1:N
`materiales`, `ordenes` 1:N `inspecciones`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 clientes, 3 tecnicos, 4 ordenes, 6 materiales (uno duplicado a
proposito por error de digitacion) y 3 inspecciones, ademas de tres
`INSERT` comentados que deben fallar (uno por cada tipo de error que
pidio detectar el cliente). Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(una orden que pasa de `pendiente` a `en_proceso`), una nueva
inspeccion que corrige una rechazada sin borrar el historico original,
y un `DELETE` que elimina el material duplicado, permitido solo porque
esa orden todavia no tenia ninguna inspeccion asociada.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que ordenes existen (JOIN
cliente-tecnico), que ordenes siguen abiertas, que tecnico tiene mas
ordenes asignadas (ranking), los materiales ordenados por costo total,
y un reporte con `GROUP BY` + `HAVING` de que ordenes tienen
inspecciones rechazadas, para saber cuales corregir antes de
entregarlas.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion de los
tres casos de error y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-070.db < ddl/schema.sql
sqlite3 ejercicio-070.db < dml/inserts.sql
sqlite3 ejercicio-070.db < dml/operaciones.sql
sqlite3 ejercicio-070.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
