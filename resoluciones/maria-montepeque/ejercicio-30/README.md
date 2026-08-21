# Ejercicio 30: Proyecto Integrador SQL

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una plataforma academica integral necesita reemplazar el registro manual de rutas, trainers, campers, modulos, evaluaciones y asistencias por una base de datos relacional que evite duplicidad de datos y permita medir el desempeno y la asistencia de cada camper por modulo.

## Tablas y relaciones

- `rutas`: catalogo de rutas de formacion (nombre, duracion en semanas).
- `trainers`: catalogo de instructores (nombre, correo).
- `campers`: estudiante inscrito en una ruta (nombre, correo, fecha de ingreso). `rutas` 1—N `campers`.
- `modulos`: modulo perteneciente a una ruta, impartido por un trainer (nombre, horas). `rutas` 1—N `modulos` y `trainers` 1—N `modulos`.
- `evaluaciones`: nota obtenida por un camper en un modulo (nota, fecha). `campers` 1—N `evaluaciones` y `modulos` 1—N `evaluaciones`.
- `asistencias`: registro de asistencia de un camper a un modulo (fecha, estado). `campers` 1—N `asistencias` y `modulos` 1—N `asistencias`.

Se usan 6 tablas porque `evaluaciones` y `asistencias` tienen responsabilidades distintas (calificacion vs. control de asistencia) y cardinalidades independientes: un camper puede tener varias evaluaciones y varias asistencias registradas para el mismo modulo, por lo que combinarlas en una sola tabla mezclaria dos conceptos distintos.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 6 tablas.
- `FOREIGN KEY`: `campers.id_ruta`, `modulos.id_ruta`, `modulos.id_trainer`, `evaluaciones.id_camper`, `evaluaciones.id_modulo`, `asistencias.id_camper`, `asistencias.id_modulo`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `rutas.nombre`, `trainers.correo`, `campers.correo`.
- `CHECK`: `rutas.duracion_semanas > 0`, `modulos.horas > 0`, `evaluaciones.nota >= 0 AND nota <= 100`, `asistencias.estado IN ('presente', 'ausente', 'tardanza')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 rutas, 5 trainers, 5 campers, 5 modulos, 10 evaluaciones, 10 asistencias.
- Tras aplicar `operaciones.sql`: 5 rutas, 5 trainers, 6 campers, 5 modulos, 10 evaluaciones (1 insertada, 1 eliminada) y 9 asistencias (1 eliminada).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (campers.correo)` y otra por `CHECK (evaluaciones.nota <= 100)`.
- Consulta de decision de negocio (camper con el mejor promedio de notas, cruzado con su porcentaje de asistencia): `Manuel Estrada` con promedio 88.75 y 100% de asistencia (sin ausencias registradas).

## Como ejecutar

```bash
sqlite3 ejercicio-30.db < ddl/schema.sql
sqlite3 ejercicio-30.db < dml/inserts.sql
sqlite3 ejercicio-30.db < dml/operaciones.sql
sqlite3 ejercicio-30.db < dql/consultas.sql
```
