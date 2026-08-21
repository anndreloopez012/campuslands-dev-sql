# Ejercicio 27: Indices y Busquedas

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Un catalogo de cursos necesita reemplazar el registro manual de categorias, instructores, cursos e inscripciones por una base de datos relacional que evite duplicidad de datos y que ademas permita busquedas eficientes sobre las inscripciones a medida que crece el volumen de datos.

## Tablas y relaciones

- `categorias`: catalogo de categorias tematicas de los cursos (nombre).
- `instructores`: catalogo de instructores (nombre, correo).
- `cursos`: curso ofrecido, asociado a una categoria y a un instructor (nombre, precio, duracion en horas). `categorias` 1—N `cursos` y `instructores` 1—N `cursos`.
- `inscripciones`: inscripcion de un estudiante a un curso (datos del estudiante, fecha, estado). `cursos` 1—N `inscripciones`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `cursos.id_categoria`, `cursos.id_instructor`, `inscripciones.id_curso`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `categorias.nombre`, `instructores.correo`, `cursos.nombre`.
- `CHECK`: `cursos.precio > 0`, `cursos.duracion_horas > 0`, `inscripciones.estado IN ('inscrito', 'completado', 'cancelado')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Indices creados

Ademas de los indices automaticos que SQLite genera para las columnas `UNIQUE`, se crearon estos indices para acelerar las busquedas y los `JOIN` mas frecuentes:

- `idx_cursos_id_categoria` sobre `cursos (id_categoria)`, para filtrar cursos por categoria.
- `idx_inscripciones_id_curso` sobre `inscripciones (id_curso)`, para acelerar el `JOIN` con `cursos`.
- `idx_inscripciones_estudiante_correo` sobre `inscripciones (estudiante_correo)`, para buscar rapidamente las inscripciones de un estudiante.

Se verifico con `EXPLAIN QUERY PLAN` que la busqueda por correo del estudiante usa el indice `idx_inscripciones_estudiante_correo` (`SEARCH inscripciones USING INDEX idx_inscripciones_estudiante_correo (estudiante_correo=?)`) en lugar de un escaneo completo de la tabla.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 categorias, 5 instructores, 5 cursos, 10 inscripciones.
- Tras aplicar `operaciones.sql`: 6 categorias, 5 instructores, 5 cursos y 9 inscripciones (2 insertadas, 2 eliminadas).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (instructores.correo)` y otra por `CHECK (inscripciones.estado IN (...))`.
- Consulta de decision de negocio (curso con mayores ingresos por inscripciones completadas): `SQL desde Cero` con 640.00.

## Como ejecutar

```bash
sqlite3 ejercicio-27.db < ddl/schema.sql
sqlite3 ejercicio-27.db < dml/inserts.sql
sqlite3 ejercicio-27.db < dml/operaciones.sql
sqlite3 ejercicio-27.db < dql/consultas.sql
```
