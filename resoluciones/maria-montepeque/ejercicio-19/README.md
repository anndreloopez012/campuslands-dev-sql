# Ejercicio 19: Universidad Notas

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una universidad necesita reemplazar el registro manual de estudiantes, materias, profesores y notas por una base de datos relacional que evite duplicidad de datos y permita calcular promedios y generar reportes academicos de forma confiable.

## Tablas y relaciones

- `estudiantes`: catalogo de estudiantes (nombre, carnet, correo).
- `materias`: catalogo de materias del pensum (nombre, creditos).
- `profesores`: catalogo de profesores (nombre, correo).
- `notas`: nota obtenida por un estudiante en una materia impartida por un profesor (nota, fecha). `estudiantes` 1—N `notas`, `materias` 1—N `notas` y `profesores` 1—N `notas`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `notas.id_estudiante`, `notas.id_materia`, `notas.id_profesor`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `estudiantes.carnet`, `estudiantes.correo`, `materias.nombre`, `profesores.correo`.
- `CHECK`: `materias.creditos > 0`, `notas.nota >= 0 AND notas.nota <= 100`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 estudiantes, 5 materias, 5 profesores, 10 notas.
- Tras aplicar `operaciones.sql`: 6 estudiantes, 5 materias, 5 profesores y 9 notas (2 insertadas, 2 eliminadas).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (estudiantes.carnet)` y otra por `CHECK (notas.nota >= 0 AND notas.nota <= 100)`.
- Consulta de decision de negocio (estudiante con el mejor promedio general): `Douglas Pineda` con 90.0.

## Como ejecutar

```bash
sqlite3 ejercicio-19.db < ddl/schema.sql
sqlite3 ejercicio-19.db < dml/inserts.sql
sqlite3 ejercicio-19.db < dml/operaciones.sql
sqlite3 ejercicio-19.db < dql/consultas.sql
```
