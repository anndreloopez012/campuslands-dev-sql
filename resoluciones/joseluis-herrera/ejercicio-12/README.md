# Ejercicio 12: Streaming Musica

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 12
- Contexto: Plataforma de música

## Descripción

La organización necesita reemplazar el manejo manual de artistas, álbumes, canciones y reproducciones por una base de datos relacional que permita almacenar información de forma consistente y generar consultas sobre el catálogo musical y su comportamiento de reproducción.

## Modelo implementado

La solución utiliza cuatro tablas:

- `artistas`: almacena la información principal de los artistas.
- `albumes`: almacena los álbumes asociados a cada artista.
- `canciones`: almacena las canciones pertenecientes a cada álbum.
- `reproducciones`: registra las reproducciones realizadas sobre las canciones.

## Relaciones

```text
ARTISTAS 1 ──────── N ALBUMES
ALBUMES  1 ──────── N CANCIONES
CANCIONES 1 ─────── N REPRODUCCIONES
```

## Datos registrados

```text
Artistas:          6
Álbumes:           6
Canciones:         5
Reproducciones:   10 iniciales
```

Las operaciones adicionales permiten comprobar `INSERT`, `UPDATE` y `DELETE`. Las operaciones inválidas se mantienen comentadas para no interrumpir la ejecución del script.

## Consultas implementadas

Se incluyen consultas para:

1. Listar canciones.
2. Seleccionar dos columnas de canciones.
3. Filtrar canciones por duración.
4. Ordenar canciones alfabéticamente.
5. Obtener las cinco canciones con mayor cantidad de reproducciones.
6. Contar reproducciones.
7. Calcular duración promedio, mínima y máxima.
8. Agrupar reproducciones por dispositivo.
9. Relacionar artistas, álbumes y canciones mediante `JOIN`.
10. Filtrar, ordenar y limitar reproducciones.
11. Generar un reporte con alias legibles.
12. Determinar qué canciones deben priorizarse para promoción.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-12/
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