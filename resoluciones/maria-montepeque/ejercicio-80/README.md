# Ejercicio 80: SELECT Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

SELECT

## Descripcion del problema

Un sistema de registro de campers necesita mostrar la informacion de
campers, rutas e inscripciones de forma legible: con nombres de
columna claros, valores calculados (como la edad o un descuento) y
resultados ordenados, no solo los datos crudos de las tablas.

## Tablas y relaciones

- `campers`: catalogo de campers, con su fecha de nacimiento y nivel.
- `rutas`: catalogo de rutas, con distancia y costo de inscripcion.
- `inscripciones`: relaciona un camper con una ruta. `campers` 1—N
  `inscripciones`; `rutas` 1—N `inscripciones`.

## Uso de SELECT

En `dql/consultas.sql`:

1. Alias de columnas (`AS`): `nombre AS camper`,
   `nivel AS nivel_experiencia`, para que el resultado se lea mas
   claro que los nombres tecnicos de la tabla.
2. Expresion calculada: la edad aproximada de cada camper se calcula
   a partir de `fecha_nacimiento` con `julianday('now')`, sin que esa
   edad este guardada en ninguna columna.
3. `WHERE`, `ORDER BY` y `GROUP BY` con `COUNT`, para filtrar, ordenar
   y resumir.
4. La consulta 5 combina todo: `JOIN` entre `inscripciones`,
   `campers` y `rutas`, con alias descriptivos y una segunda expresion
   calculada (costo con 10% de descuento), armando un reporte legible
   de una sola vez.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `inscripciones.id_camper`, `inscripciones.id_ruta`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `rutas.nombre_ruta`.
- `CHECK`: `campers.nivel IN (...)`, `rutas.distancia_km > 0`,
  `rutas.costo_inscripcion >= 0`.
- `DEFAULT` en `campers.nivel` e `inscripciones.fecha_inscripcion`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`SELECT nombre, apellido FROM campers;` falla porque la tabla
`campers` no tiene ninguna columna `apellido` (typo). Se valido con
Python (`sqlite3`): lanza `no such column: apellido`. Recuerda que
`SELECT` tambien puede fallar por errores simples de escritura, no
solo por restricciones de la base de datos.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 5 campers, 3 rutas, 5 inscripciones. Reporte final
  con costo y descuento calculado correctamente para las 5
  inscripciones.

## Como ejecutar

```bash
sqlite3 ejercicio-80.db < ddl/schema.sql
sqlite3 ejercicio-80.db < dml/inserts.sql
sqlite3 ejercicio-80.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
