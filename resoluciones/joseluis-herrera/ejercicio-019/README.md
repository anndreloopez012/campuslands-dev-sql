# Ejercicio 19: Universidad Notas

## Información

- Nombre completo: Jose Luis Tot Herrera
- Ejercicio: 19
- Fecha: 2026-08-20
- Motor de base de datos: SQLite
- Contexto: Registro académico y promedios

## Descripción

La base de datos permite administrar estudiantes, profesores, materias y notas dentro de un contexto universitario.

El modelo permite registrar las calificaciones obtenidas por los estudiantes, relacionarlas con las materias y profesores correspondientes y generar reportes de rendimiento académico.

## Modelo implementado

La solución utiliza cuatro tablas:

- `estudiantes`: almacena la información de los estudiantes.
- `profesores`: almacena la información de los profesores.
- `materias`: almacena las materias académicas.
- `notas`: registra las calificaciones obtenidas por los estudiantes.

## Relaciones

- Un estudiante puede tener múltiples notas.
- Una nota pertenece a un estudiante.
- Una materia puede tener múltiples notas.
- Una nota pertenece a una materia.
- Un profesor puede registrar múltiples notas.
- Una nota pertenece a un profesor.

La tabla `notas` funciona como entidad transaccional y relaciona estudiantes, materias y profesores.

## Datos

Se registran:

- 5 estudiantes.
- 5 profesores.
- 5 materias.
- 10 notas.

Los datos permiten generar resultados para promedios, materias, estudiantes, profesores y rendimiento académico.


## Consultas

`dql/consultas.sql` contiene consultas para:

1. Listar todas las notas.
2. Mostrar dos columnas relevantes de las notas.
3. Filtrar notas con calificación igual o superior a 4.0.
4. Ordenar notas por fecha.
5. Obtener las cinco calificaciones más altas.
6. Contar notas registradas.
7. Calcular promedio, mínimo y máximo.
8. Agrupar notas por materia.
9. Relacionar estudiantes, materias, profesores y notas.
10. Obtener las cinco mejores calificaciones mediante `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte de promedios por estudiante.
12. Generar un reporte de actividad de profesores.
13. Analizar el rendimiento por materia.
14. Clasificar estudiantes según su promedio para apoyar decisiones académicas.
## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-019/
        ├── README.md
        ├── diagramas/
        │   └── README.md
        ├── ddl/
        │   └── schema.sql
        ├── dml/
        │   ├── inserts.sql
        │   └── operaciones.sql
        └── dql/
            └── consultas.sql
```