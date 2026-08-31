# Ejercicio 62: AUTO_INCREMENT Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

Un sistema de registro de campers necesita generar automaticamente el id
de cada camper y cada inscripcion, sin que la aplicacion o la persona que
captura datos tenga que calcular el siguiente numero disponible.

## Tablas y relaciones

- `rutas`: catalogo de rutas de entrenamiento (nombre).
- `campers`: tabla principal; el id se genera con
  `INTEGER PRIMARY KEY AUTOINCREMENT`.
- `inscripciones`: inscripcion de un camper en una ruta. `campers` 1—N
  `inscripciones`; `rutas` 1—N `inscripciones`.

## Uso de AUTO_INCREMENT

En SQLite el equivalente de `AUTO_INCREMENT` es
`INTEGER PRIMARY KEY AUTOINCREMENT`. Se aplico en las 3 tablas
(`rutas.id_ruta`, `campers.id_camper`, `inscripciones.id_inscripcion`):
ningun `INSERT` indica el id, SQLite lo asigna solo y de forma creciente.

Para demostrar que el id nunca se reutiliza:

1. Se insertan 5 campers (ids 1 a 5).
2. Se elimina el camper con `id_camper = 3` (`Byron Xicay`).
3. Se inserta un camper nuevo: recibe el `id_camper = 6`, **no** el 3 que
   quedo libre. Esto es porque `AUTOINCREMENT` usa la tabla interna
   `sqlite_sequence` para recordar el maximo historico, en vez de basarse
   solo en `MAX(id)` de la tabla (que si podria reutilizar huecos con un
   `INTEGER PRIMARY KEY` simple, sin la palabra `AUTOINCREMENT`).

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `inscripciones.id_camper`, `inscripciones.id_ruta`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `rutas.nombre`, `campers.email`, y
  `inscripciones (id_camper, id_ruta)` para evitar inscribir dos veces al
  mismo camper en la misma ruta.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla (comentado en `dml/inserts.sql`)

`INSERT INTO campers (id_camper, nombre, email) VALUES (1, 'Duplicado', 'duplicado@correo.com');`
falla porque el `id_camper = 1` ya existe (viola la `PRIMARY KEY`). Se
valido ejecutandolo con Python (`sqlite3`): lanza
`IntegrityError: UNIQUE constraint failed: campers.id_camper`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con Python
(modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en
el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 rutas, 5 campers (ids 1, 2, 4, 5, 6 -- el 3 nunca se
  reutilizo), 6 inscripciones.

## Como ejecutar

```bash
sqlite3 ejercicio-62.db < ddl/schema.sql
sqlite3 ejercicio-62.db < dml/inserts.sql
sqlite3 ejercicio-62.db < dql/consultas.sql
```
