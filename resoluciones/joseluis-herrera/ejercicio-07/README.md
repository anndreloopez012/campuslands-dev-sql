### README.md

# Ejercicio 07: Academia de Cursos

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 07
- Rama: `alumno/joseluis-herrera/ejercicio-07`

## Descripción

La organización necesita reemplazar el registro manual de cursos, instructores, estudiantes y matrículas por una base de datos relacional que permita controlar las inscripciones y realizar seguimiento académico mediante notas, estados y reportes.

## Modelo implementado

La solución utiliza cuatro tablas:

- `instructores`: almacena la información de los instructores y su experiencia.
- `cursos`: registra los cursos y el instructor responsable.
- `estudiantes`: almacena los estudiantes registrados en la academia.
- `matriculas`: relaciona estudiantes con cursos y registra su seguimiento académico.

## Relaciones

```text
INSTRUCTORES 1 ───────── N CURSOS
ESTUDIANTES  1 ───────── N MATRICULAS
CURSOS       1 ───────── N MATRICULAS
```

La tabla `matriculas` funciona como entidad transaccional y permite representar la relación entre estudiantes y cursos.


## Datos

```text
Instructores: 5 registros base
Cursos: 5 registros base
Estudiantes: 5 registros base
Matrículas: 10 registros base
```

Los datos incluyen diferentes niveles de cursos y notas académicas suficientes para realizar consultas de rendimiento.

## Consultas

El archivo `dql/consultas.sql` contiene las doce consultas requeridas:

```text
1. Listado completo de matrículas.
2. Selección de dos columnas relevantes.
3. Filtrado por nota.
4. Ordenamiento por fecha.
5. Top 5 estudiantes según nota.
6. Conteo total de matrículas.
7. Promedio, mínimo y máximo de notas.
8. Agrupación de matrículas por nivel.
9. JOIN entre estudiantes y cursos.
10. WHERE + ORDER BY + LIMIT.
11. Reporte académico con alias legibles.
12. Consulta de decisión sobre rendimiento y demanda de cursos.
```

## Decisiones de diseño

La tabla `matriculas` funciona como entidad transaccional central porque registra la inscripción de cada estudiante en un curso y almacena su seguimiento académico.

La tabla `cursos` mantiene separada la información académica de los estudiantes y permite asociar cada curso con un instructor.

La restricción compuesta `UNIQUE (id_estudiante, id_curso)` evita que un estudiante sea matriculado dos veces en el mismo curso.

La nota final permite valores nulos para representar matrículas que todavía no han sido calificadas.