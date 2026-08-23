# Ejercicio 27: Indices y Busquedas

## Información

- **Estudiante:** Carlos Velasco
- **Ejercicio:** 27
- **Tema:** Índices y búsquedas eficientes
- **Motor:** SQLite
- **Fecha:** 2026-08-20

## Descripción

El ejercicio implementa una base de datos relacional para administrar un catálogo de cursos. El modelo separa categorías, cursos, instructores e inscripciones para evitar duplicidad y facilitar las consultas.

El objetivo principal es demostrar el uso de índices para mejorar búsquedas sobre datos del catálogo y de las inscripciones.

## Modelo implementado

```text
categorias
    │
    └──< cursos >── instructores
             │
             └──< inscripciones
```

### Tablas

| Tabla | Responsabilidad |
| --- | --- |
| `categorias` | Catálogo de categorías de cursos |
| `instructores` | Información de los instructores |
| `cursos` | Catálogo principal de cursos |
| `inscripciones` | Registro de estudiantes inscritos en cursos |

## Relaciones

- `cursos.id_categoria` referencia `categorias.id_categoria`.
- `cursos.id_instructor` referencia `instructores.id_instructor`.
- `inscripciones.id_curso` referencia `cursos.id_curso`.

## Restricciones aplicadas

- `PRIMARY KEY` en todas las tablas.
- `FOREIGN KEY` para las relaciones.
- `NOT NULL` en los campos obligatorios.
- `UNIQUE` en nombres de categorías.
- `UNIQUE` en correos de instructores.
- `UNIQUE` en códigos de cursos.
- `CHECK (experiencia_anios >= 0)`.
- `CHECK (precio > 0)`.
- `CHECK (duracion_horas > 0)`.
- `CHECK` para limitar los estados de inscripción.
- `PRAGMA foreign_keys = ON`.

## Datos

Los datos iniciales contienen:

- 5 categorías.
- 5 instructores.
- 5 cursos.
- 10 inscripciones.

El archivo `dml/operaciones.sql` agrega posteriormente:

- 1 categoría adicional.
- 1 inscripción adicional.

También ejecuta 2 actualizaciones y 2 eliminaciones controladas.

## Índices

Se implementaron índices sobre columnas utilizadas frecuentemente para búsquedas, relaciones y ordenamiento:

```text
idx_categorias_nombre
idx_instructores_correo
idx_cursos_nombre
idx_cursos_categoria
idx_cursos_instructor
idx_inscripciones_curso
idx_inscripciones_fecha
idx_inscripciones_estado
idx_inscripciones_curso_fecha
```

El índice compuesto `idx_inscripciones_curso_fecha` permite optimizar búsquedas que combinan el curso con una fecha de inscripción.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 operaciones `INSERT`.
- 2 operaciones `UPDATE`.
- 2 operaciones `DELETE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `CHECK`, comentada.

Las operaciones inválidas permanecen comentadas para que el script pueda ejecutarse completamente.

## Consultas

El archivo `dql/consultas.sql` contiene las 12 consultas obligatorias:

1. Listado completo de cursos.
2. Selección de dos columnas.
3. Filtrado por precio.
4. Ordenamiento alfabético.
5. Cinco cursos con mayor cantidad de inscripciones.
6. Conteo total de cursos.
7. Promedio, mínimo y máximo de precios.
8. Agrupación de cursos por categoría.
9. Relación de cursos con categorías e instructores mediante `JOIN`.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Consulta de decisión empresarial basada en la demanda.

También se incluyen búsquedas específicas y `EXPLAIN QUERY PLAN` para comprobar el uso del modelo de índices.

## Ejecución

Desde la carpeta de la solución:

```bash
sqlite3 ejercicio-27.db < ddl/schema.sql
sqlite3 ejercicio-27.db < dml/inserts.sql
sqlite3 ejercicio-27.db < dml/operaciones.sql
sqlite3 ejercicio-27.db < dql/consultas.sql
```

## Validaciones

Comprobar las tablas:

```bash
sqlite3 ejercicio-27.db ".tables"
```

Comprobar el esquema y los índices:

```bash
sqlite3 ejercicio-27.db ".schema"
```

Comprobar las claves foráneas:

```bash
sqlite3 ejercicio-27.db "PRAGMA foreign_key_list(cursos);"
sqlite3 ejercicio-27.db "PRAGMA foreign_key_list(inscripciones);"
```

Comprobar los índices:

```bash
sqlite3 ejercicio-27.db "PRAGMA index_list(cursos);"
sqlite3 ejercicio-27.db "PRAGMA index_list(inscripciones);"
```

Comprobar el plan de ejecución:

```bash
sqlite3 ejercicio-27.db < dql/consultas.sql
```

Las consultas `EXPLAIN QUERY PLAN` permiten revisar cómo SQLite ejecuta las búsquedas indexadas.

## Evidencias de ejecución

Las consultas permiten verificar:

- Cantidad total de cursos.
- Precios promedio, mínimo y máximo.
- Cursos agrupados por categoría.
- Cursos relacionados con sus instructores.
- Cantidad de inscripciones por curso.
- Cursos con mayor demanda.
- Búsquedas por nombre.
- Búsquedas por curso y fecha.
- Planes de ejecución utilizados por SQLite.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido.

La tabla `cursos` funciona como entidad central del catálogo y referencia tanto la categoría como el instructor. La tabla `inscripciones` registra las relaciones de los estudiantes con los cursos.

Los índices se concentran en columnas utilizadas para búsquedas, relaciones y filtros frecuentes. El índice compuesto sobre `id_curso` y `fecha_inscripcion` permite atender consultas que utilizan ambas columnas.

Las fechas se almacenan en formato ISO `YYYY-MM-DD`, lo que facilita el ordenamiento y las comparaciones en SQLite.

No se incluye ningún archivo de base de datos generado (`.db`, `.sqlite` o `.sqlite3`) en la solución.