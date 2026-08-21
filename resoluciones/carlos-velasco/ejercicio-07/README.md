# Ejercicio 07: Academia de Cursos

## Información

**Nombre:** Carlos Elias Tzoy Velasco  
**Fecha:** 2026-08-20  
**Tecnología:** SQLite  
**Ejercicio:** 07 - Academia de Cursos

## Descripción del problema

La academia necesita reemplazar el registro manual de cursos, instructores, estudiantes y matrículas por una base de datos relacional.

La solución permite administrar la oferta académica, los instructores, los estudiantes inscritos y el progreso de cada matrícula.

El modelo también permite generar reportes de rendimiento y detectar cursos que requieren seguimiento académico.

## Modelo implementado

La solución utiliza cuatro tablas.

### `cursos`

Representa los cursos ofrecidos por la academia.

Contiene:

- Nombre.
- Categoría.
- Duración.
- Nivel.

### `instructores`

Registra los instructores responsables de impartir los cursos.

Contiene:

- Nombre completo.
- Correo electrónico.
- Especialidad.

### `estudiantes`

Registra los estudiantes de la academia.

Contiene:

- Nombre completo.
- Correo electrónico.
- Fecha de nacimiento.
- Ciudad.

### `matriculas`

Representa la inscripción de un estudiante en un curso y registra su seguimiento académico.

Contiene:

- Estudiante.
- Curso.
- Instructor.
- Fecha de matrícula.
- Progreso.
- Estado.

## Relaciones

```text
cursos       1 ─────── N matriculas

instructores 1 ─────── N matriculas

estudiantes  1 ─────── N matriculas
```

La tabla `matriculas` funciona como tabla de relación y permite mantener separadas las responsabilidades de las entidades principales.

## Restricciones aplicadas

### PRIMARY KEY

Se utilizan:

- `cursos.id_curso`
- `instructores.id_instructor`
- `estudiantes.id_estudiante`
- `matriculas.id_matricula`

### FOREIGN KEY

Se implementaron las relaciones:

```text
matriculas.id_curso
    → cursos.id_curso

matriculas.id_instructor
    → instructores.id_instructor

matriculas.id_estudiante
    → estudiantes.id_estudiante
```

Las claves foráneas se habilitan mediante:

```sql
PRAGMA foreign_keys = ON;
```

### UNIQUE

Se aplicaron restricciones `UNIQUE` para:

- Nombre del curso.
- Correo del instructor.
- Correo del estudiante.
- Combinación estudiante-curso.

La combinación estudiante-curso evita que un estudiante sea matriculado dos veces en el mismo curso.

### CHECK

Se aplicaron restricciones para:

- Validar el nombre de cursos e instructores.
- Controlar la duración de los cursos.
- Validar los niveles disponibles.
- Validar el formato de las fechas.
- Mantener el progreso entre 0 y 100.
- Controlar los estados de matrícula.
- Validar el formato básico de correos electrónicos.

## Datos registrados

Los datos base contienen:

| Tabla | Registros |
| --- | ---: |
| cursos | 5 |
| instructores | 5 |
| estudiantes | 5 |
| matriculas | 10 |

Los datos fueron diseñados para que todas las consultas requeridas produzcan resultados.

## Operaciones DML

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados.
- Operaciones inválidas comentadas.

Los registros adicionales corresponden a un curso y un estudiante. Ambos son actualizados y posteriormente eliminados mediante condiciones `WHERE`.

## Operaciones inválidas documentadas

Se incluyen ejemplos de:

1. Violación de `CHECK` al intentar registrar un progreso superior al 100%.
2. Violación de `UNIQUE` al utilizar un correo electrónico existente.
3. Violación de `FOREIGN KEY` al utilizar un curso inexistente.

Las operaciones inválidas están comentadas para evitar que interrumpan la ejecución del script.

## Consultas implementadas

El archivo `dql/consultas.sql` contiene las 12 consultas solicitadas:

1. Listado de matrículas.
2. Selección de dos columnas relevantes.
3. Filtrado por porcentaje de progreso.
4. Ordenamiento por fecha.
5. Top 5 estudiantes según progreso promedio.
6. Conteo total de matrículas.
7. Promedio, mínimo y máximo de progreso.
8. Agrupación por estado.
9. JOIN entre estudiantes, cursos y matrículas.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte académico con alias legibles.
12. Consulta para identificar cursos que requieren seguimiento.

## Ejecución

Desde la raíz de `ejercicio-07`:

```bash
sqlite3 ejercicio-07.db < ddl/schema.sql
sqlite3 ejercicio-07.db < dml/inserts.sql
sqlite3 ejercicio-07.db < dml/operaciones.sql
sqlite3 ejercicio-07.db < dql/consultas.sql
```

El archivo `ejercicio-07.db` es temporal y no debe subirse al repositorio.

## Validación de tablas

```bash
sqlite3 ejercicio-07.db ".tables"
```

Salida esperada:

```text
cursos  estudiantes  instructores  matriculas
```

## Validación de cantidades

```bash
sqlite3 ejercicio-07.db <<'SQL'
SELECT 'cursos' AS tabla, COUNT(*) AS registros FROM cursos
UNION ALL
SELECT 'instructores', COUNT(*) FROM instructores
UNION ALL
SELECT 'estudiantes', COUNT(*) FROM estudiantes
UNION ALL
SELECT 'matriculas', COUNT(*) FROM matriculas;
SQL
```

Salida esperada:

```text
cursos|5
instructores|5
estudiantes|5
matriculas|10
```

## Validación de claves foráneas

```bash
sqlite3 ejercicio-07.db "PRAGMA foreign_keys;"
```

Salida esperada:

```text
1
```

## Validación de matrículas

```sql
SELECT
    m.id_matricula,
    e.nombre_completo AS estudiante,
    c.nombre AS curso,
    i.nombre_completo AS instructor,
    m.progreso,
    m.estado
FROM matriculas AS m
INNER JOIN estudiantes AS e
    ON m.id_estudiante = e.id_estudiante
INNER JOIN cursos AS c
    ON m.id_curso = c.id_curso
INNER JOIN instructores AS i
    ON m.id_instructor = i.id_instructor
ORDER BY m.id_matricula;
```

Esta consulta permite comprobar que cada matrícula mantiene correctamente sus relaciones con el estudiante, curso e instructor.

## Resultado final

La solución implementa un modelo relacional de cuatro tablas para gestionar una academia de cursos.

El modelo permite controlar la oferta académica, los instructores, los estudiantes y las matrículas, incluyendo el seguimiento del progreso académico.

Las restricciones garantizan integridad referencial, evitan duplicidades y controlan valores inválidos.

Las consultas permiten analizar el rendimiento de estudiantes, cursos y matrículas, además de identificar cursos que requieren intervención o seguimiento académico.