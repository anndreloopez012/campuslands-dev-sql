# Ejercicio 27: Indices y Busquedas

## Información

- Nombre: Jose Luis Herrera
- Ejercicio: 27
- Tema: Indices y Busquedas


## Descripción

La organización necesita reemplazar el manejo manual de información de categorías, cursos, instructores e inscripciones por una base de datos relacional que permita almacenar información consistente y realizar búsquedas eficientes.

La solución utiliza cuatro tablas normalizadas y agrega índices sobre las columnas utilizadas frecuentemente para relaciones, filtros y búsquedas.

## Modelo implementado

El modelo está compuesto por:

- `categorias`: almacena las categorías disponibles.
- `instructores`: almacena la información de los instructores.
- `cursos`: almacena el catálogo principal de cursos.
- `inscripciones`: registra los estudiantes inscritos en cada curso.

Las relaciones principales son:

- `categorias` 1:N `cursos`.
- `instructores` 1:N `cursos`.
- `cursos` 1:N `inscripciones`.

## Índices

Se crearon índices para optimizar búsquedas y relaciones sobre:

- `cursos.id_categoria`.
- `cursos.id_instructor`.
- `cursos.precio`.
- `inscripciones.id_curso`.
- `inscripciones.fecha_inscripcion`.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

- Listar los cursos.
- Seleccionar columnas específicas.
- Filtrar cursos por precio.
- Ordenar cursos por fecha.
- Obtener los 5 cursos con mayor cantidad de inscripciones.
- Contar cursos.
- Calcular promedio, mínimo y máximo de precios.
- Agrupar cursos por categoría.
- Relacionar cursos con categorías e instructores.
- Combinar `WHERE`, `ORDER BY` y `LIMIT`.
- Generar un reporte con alias.
- Clasificar la demanda de los cursos para apoyar decisiones de negocio.

## Estructura 
resoluciones/
└── joseluis-herrera/
    └── ejercicio-27/
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