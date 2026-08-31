# Ejercicio 98: Vistas Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Vistas

## Descripcion del problema

Un programa de entrenamiento consulta con frecuencia la lista de
inscripciones activas de sus campers (con el nombre del camper en vez
del id). En lugar de reescribir ese `JOIN` con `WHERE estado =
'activo'` cada vez, conviene guardarlo como una vista reutilizable.

## Tablas y relaciones

- `campers`: catalogo de campers.
- `inscripciones`: tabla principal, cada fila es la inscripcion de un
  camper a una ruta (guardada como texto, `nombre_ruta`), con su
  `estado`. `campers` 1—N `inscripciones`.

## Uso de Vistas

En `ddl/schema.sql` se define `vista_inscripciones_activas`, que
encapsula el `JOIN` entre `inscripciones` y `campers` filtrado por
`estado = 'activo'`. En `dql/consultas.sql`:

- La consulta 2 muestra la version "manual" (consulta directa sobre
  `inscripciones` con `WHERE estado = 'activo'`, sin nombre de
  camper).
- La consulta 5 usa la vista con un simple `SELECT * FROM
  vista_inscripciones_activas`, que devuelve el mismo tipo de
  resultado (las 4 inscripciones activas, con nombre de camper) sin
  tener que repetir la logica del `JOIN` ni del `WHERE`: la vista se
  consulta como si fuera una tabla, pero por dentro siempre ejecuta la
  definicion con la que se creo, asi que si cambian los datos de base
  el resultado de la vista cambia solo.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 2 tablas.
- `FOREIGN KEY`: `inscripciones.id_camper`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `campers.email`.
- `CHECK`: `inscripciones.estado IN ('activo', 'retirado', 'completado')`.
- `DEFAULT` en `inscripciones.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Intentar hacer `INSERT` directamente sobre
`vista_inscripciones_activas`, como si fuera una tabla normal. Se
verifico con Python (`sqlite3`) que SQLite lo rechaza con el error
`cannot modify vista_inscripciones_activas because it is a view`: una
vista simple (`CREATE VIEW ... AS SELECT ...`) en SQLite es de solo
lectura; para que aceptara `INSERT`/`UPDATE`/`DELETE` haria falta
definir explicitamente un trigger `INSTEAD OF` sobre ella, algo que
este ejercicio no requiere. Los datos siempre se modifican en las
tablas base (`campers`, `inscripciones`), nunca en la vista.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-98.db < ddl/schema.sql
sqlite3 ejercicio-98.db < dml/inserts.sql
sqlite3 ejercicio-98.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
