# Ejercicio 33: Normalizacion Matriculas Academicas

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Descripcion del problema

La academia administraba sus matriculas en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde `modulos`, `horarios` y `notas` guardaban varios valores separados por `|` en una misma celda, y los datos de estudiante, ruta y trainer se repetian cada vez que no cabian todos los modulos en una sola fila (una misma matricula llegaba a aparecer en dos filas distintas). Esto generaba duplicidad, anomalias de insercion/actualizacion/eliminacion y dificultaba los reportes. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `estudiantes`: catalogo de estudiantes (nombre, documento unico).
- `rutas`: catalogo de rutas de formacion.
- `trainers`: catalogo de trainers.
- `modulos`: catalogo de modulos que se pueden cursar.
- `matriculas`: encabezado de una matricula (que estudiante cursa que ruta con que trainer). `estudiantes` 1—N `matriculas`, `rutas` 1—N `matriculas` y `trainers` 1—N `matriculas`.
- `notas`: detalle de cada modulo cursado dentro de una matricula, con su horario y la nota obtenida. `matriculas` 1—N `notas` y `modulos` 1—N `notas`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 6 tablas.
- `FOREIGN KEY`: `matriculas.id_estudiante`, `matriculas.id_ruta`, `matriculas.id_trainer`, `notas.id_matricula`, `notas.id_modulo`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `estudiantes.documento`, `rutas.nombre`, `trainers.nombre`, `modulos.nombre`, `(id_estudiante, id_ruta)` en `matriculas` (evita matricular dos veces al mismo estudiante en la misma ruta), `(id_matricula, id_modulo)` en `notas` (evita repetir el mismo modulo en una matricula).
- `CHECK`: `estudiantes.documento` no puede quedar vacio (`length(documento) > 0`), `notas.horario` con formato `HH:MM`, `notas.nota BETWEEN 0 AND 100`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 estudiantes, 5 rutas, 5 trainers, 6 modulos, 6 matriculas, 14 lineas de `notas`.
- Las filas 1 y 3 del CSV original (misma estudiante, ruta y trainer: Laura Cano / Node JS / Mario Paz) se reconstruyen como una sola matricula (`id_matricula = 1`) con sus 5 modulos en `notas`: `SQL` 08:00 (88), `Express` 10:00 (91), `JWT` 12:00 (85), `Docker` 15:00 (92), `Deploy` 17:00 (89) — verificado con la consulta 1 (`JOIN` que reconstruye el archivo original).
- Modulo con mejor promedio de nota (consulta 8): `Deploy` con promedio 91.0.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (estudiantes.documento)` y otro por `CHECK (nota BETWEEN 0 AND 100)`.

## Como ejecutar

```bash
sqlite3 ejercicio-33.db < ddl/schema.sql
sqlite3 ejercicio-33.db < dml/inserts.sql
sqlite3 ejercicio-33.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
