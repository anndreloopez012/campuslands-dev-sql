# Ejercicio 07: Academia de Cursos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-04

## Descripcion del problema

La academia necesita reemplazar el registro manual de cursos, instructores, estudiantes y matriculas por una base de datos relacional que evite duplicidad y permita dar seguimiento academico a cada estudiante.

## Tablas y relaciones

- `instructores`: catalogo de instructores (nombre, correo).
- `cursos`: catalogo de cursos que dicta cada instructor (`instructores` 1—N `cursos`).
- `estudiantes`: catalogo de estudiantes (nombre, correo).
- `matriculas`: inscripcion de un estudiante a un curso con su nota y estado (`estudiantes` 1—N `matriculas`, `cursos` 1—N `matriculas`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `cursos.id_instructor`, `matriculas.id_estudiante`, `matriculas.id_curso`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `instructores.correo`, `cursos.nombre`, `estudiantes.correo`, `(id_estudiante, id_curso)` en `matriculas`.
- `CHECK`: `cursos.duracion_horas > 0`, `cursos.modalidad IN (...)`, `matriculas.nota_final BETWEEN 0 AND 100`, `matriculas.estado IN (...)`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 6 instructores, 6 cursos, 5 estudiantes y 9 matriculas tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (estudiantes.correo)` y otra por `CHECK (nota_final BETWEEN 0 AND 100)`.
- Consulta de decision de negocio (curso con mas matriculas aprobadas): `Python para datos` con 2 aprobados.

## Como ejecutar

```bash
sqlite3 ejercicio-07.db < ddl/schema.sql
sqlite3 ejercicio-07.db < dml/inserts.sql
sqlite3 ejercicio-07.db < dml/operaciones.sql
sqlite3 ejercicio-07.db < dql/consultas.sql
```
