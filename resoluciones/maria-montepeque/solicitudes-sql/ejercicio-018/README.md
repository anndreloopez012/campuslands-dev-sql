# Ejercicio 018: Solicitud de cliente - Escuela de Dibujo

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una escuela creativa administra cursos, alumnos, entregas y evaluaciones, y pidio explicitamente poder consultar rankings, totales y casos pendientes directamente desde la base de datos.

## Tablas y relaciones

- `cursos`: catalogo de cursos que ofrece la escuela (nombre unico, nivel, precio).
- `entregas`: registro transaccional de cada trabajo entregado, con su calificacion y estado (`cursos` 1—N `entregas`).

No se creo una tabla `alumnos` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del alumno se guarda dentro de `entregas` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `entregas.id_curso` -> `cursos.id_curso`.
- `NOT NULL` en todos los campos obligatorios (excepto `calificacion`, opcional mientras la entrega no se evalua).
- `UNIQUE`: `cursos.nombre_curso`.
- `CHECK`: `precio > 0`, `calificacion BETWEEN 0 AND 100`, `nivel IN (...)`, `estado IN ('pendiente', 'evaluada', 'rechazada')`.
- `DEFAULT`: `fecha_entrega` con la fecha actual, `estado` en `'pendiente'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 cursos y 9 entregas base (una de ellas, la entrega 9, es una entrada de prueba insertada por error).
- `operaciones.sql` evalua una entrega pendiente, ajusta el precio de un curso y elimina la entrada de prueba: quedan 8 entregas.
- El caso comentado (`calificacion = 150`) falla al ejecutarlo: `CHECK constraint failed: calificacion BETWEEN 0 AND 100`.
- Ranking (promedio de calificacion por curso, solo evaluadas): `Comic y Storyboard` lidera con 95.0.
- Casos pendientes: solo queda 1 entrega pendiente (la de Ana Gomez del 2026-07-15).

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-018.db < ddl/schema.sql
sqlite3 ejercicio-018.db < dml/inserts.sql
sqlite3 ejercicio-018.db < dml/operaciones.sql
sqlite3 ejercicio-018.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
