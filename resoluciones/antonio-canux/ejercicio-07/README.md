# Ejercicio 07: Academia de Cursos

**Camper:** Antonio Canux

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

## Como ejecutar

```bash
sqlite3 ejercicio-07.db < ddl/schema.sql
sqlite3 ejercicio-07.db < dml/inserts.sql
sqlite3 ejercicio-07.db < dml/operaciones.sql
sqlite3 ejercicio-07.db < dql/consultas.sql
```
