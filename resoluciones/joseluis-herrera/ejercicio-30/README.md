# Ejercicio 30: Proyecto Integrador SQL

## Información

- Nombre: Jose Luis Herrera
- Ejercicio: 30
- Tema: Proyecto Integrador SQL

## Descripción

La organización necesita reemplazar el manejo manual de campers, rutas, trainers, módulos, evaluaciones y asistencias por una base de datos relacional que permita centralizar la información académica y generar reportes sobre rendimiento y asistencia.

La solución utiliza seis tablas relacionadas y aplica restricciones de integridad, índices y consultas con múltiples relaciones y funciones de agregación.

## Modelo implementado

Las tablas utilizadas son:

- `campers`: almacena los estudiantes y la ruta académica asignada.
- `rutas`: almacena las rutas de formación disponibles.
- `trainers`: almacena los instructores responsables de los módulos.
- `modulos`: almacena los módulos pertenecientes a cada ruta.
- `evaluaciones`: registra las notas obtenidas por los campers.
- `asistencias`: registra la participación de los campers en los módulos.

Las relaciones principales son:

- `rutas` 1:N `campers`.
- `rutas` 1:N `modulos`.
- `trainers` 1:N `modulos`.
- `campers` 1:N `evaluaciones`.
- `modulos` 1:N `evaluaciones`.
- `campers` 1:N `asistencias`.
- `modulos` 1:N `asistencias`.


## Índices

Se crearon índices para las columnas utilizadas frecuentemente en relaciones y consultas:

- `campers.id_ruta`.
- `modulos.id_ruta`.
- `modulos.id_trainer`.
- `evaluaciones.id_camper`.
- `evaluaciones.id_modulo`.
- `asistencias.id_camper`.
- `asistencias.id_modulo`.


## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

- Listar todos los campers.
- Mostrar columnas específicas.
- Filtrar campers por fecha de ingreso.
- Ordenar campers alfabéticamente.
- Obtener los cinco campers con mejor promedio.
- Contar campers.
- Calcular promedio, mínimo y máximo de notas.
- Agrupar campers por ruta.
- Relacionar campers, rutas, módulos, trainers y evaluaciones.
- Utilizar `WHERE`, `ORDER BY` y `LIMIT`.
- Crear reportes con alias.
- Obtener promedios por módulo.
- Calcular porcentajes de asistencia.
- Clasificar campers según rendimiento académico y asistencia.

## Estructura
resoluciones/
└── joseluis-herrera/
    └── ejercicio-30/
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