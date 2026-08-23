# Ejercicio 12: Streaming Musica

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Ejercicio | 12 - Streaming Musica |
| Motor | SQLite |
| Fecha | 2026-08-20 |
| Rama | `alumno/carlos-velasco/ejercicio-12` |

## Descripción

El ejercicio implementa una base de datos relacional para gestionar el catálogo musical y las reproducciones de una plataforma de música.

El modelo permite organizar artistas, álbumes y canciones, además de registrar las reproducciones para obtener indicadores sobre consumo musical, canciones con mayor demanda y dispositivos utilizados.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `artistas` | Registrar artistas y sus características principales. |
| `albumes` | Registrar álbumes asociados a cada artista. |
| `canciones` | Registrar las canciones pertenecientes a cada álbum. |
| `reproducciones` | Registrar cada reproducción de una canción. |

La tabla `reproducciones` funciona como entidad central de actividad.

```text
artistas 1 ──────── N albumes
                       │
                       1
                       │
                       N
                    canciones
                       │
                       1
                       │
                       N
                 reproducciones
```

## Relaciones

- Un artista puede tener múltiples álbumes.
- Cada álbum pertenece a un artista.
- Un álbum puede contener múltiples canciones.
- Cada canción pertenece a un álbum.
- Una canción puede tener múltiples reproducciones.
- Cada reproducción pertenece obligatoriamente a una canción.

## Restricciones

El esquema utiliza:

- `PRIMARY KEY` para identificar registros.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` en campos obligatorios.
- `UNIQUE` para evitar artistas duplicados.
- `UNIQUE` para evitar álbumes repetidos dentro del mismo artista.
- `UNIQUE` para evitar números de pista duplicados dentro de un álbum.
- `UNIQUE` para evitar títulos de canciones duplicados dentro de un álbum.
- `CHECK` para validar nombres de artistas.
- `CHECK` para validar años de inicio.
- `CHECK` para validar fechas de lanzamiento.
- `CHECK` para validar cantidades de canciones.
- `CHECK` para validar títulos de canciones.
- `CHECK` para validar duración de canciones.
- `CHECK` para validar números de pista.
- `CHECK` para validar fechas y horas de reproducción.
- `CHECK` para validar segundos escuchados.
- `CHECK` para validar dispositivos permitidos.
- `PRAGMA foreign_keys = ON` para activar la integridad referencial de SQLite.
- Índices para consultas frecuentes sobre artistas, álbumes, canciones y fechas.

## Datos

Los datos base incluyen:

- 5 artistas.
- 5 álbumes.
- 25 canciones.
- 15 reproducciones.

La información se distribuye entre diferentes géneros, artistas, álbumes, canciones y dispositivos para permitir consultas de catálogo y análisis de reproducciones.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `FOREIGN KEY`, comentada.

Las operaciones inválidas permanecen comentadas para permitir la ejecución completa del script.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar todas las reproducciones.
2. Mostrar fecha y dispositivo.
3. Filtrar reproducciones por fecha.
4. Ordenar reproducciones cronológicamente.
5. Obtener las cinco canciones con mayor cantidad de reproducciones.
6. Contar reproducciones totales.
7. Calcular promedio, mínimo y máximo de tiempo escuchado.
8. Agrupar reproducciones por dispositivo.
9. Relacionar canciones y álbumes.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte con canción, álbum, artista y datos de reproducción.
12. Identificar artistas con mayor demanda para apoyar decisiones de promoción.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-12.db < ddl/schema.sql
sqlite3 ejercicio-12.db < dml/inserts.sql
sqlite3 ejercicio-12.db < dml/operaciones.sql
sqlite3 ejercicio-12.db < dql/consultas.sql
```

Para validar las tablas:

```bash
sqlite3 ejercicio-12.db ".tables"
```

Para consultar el esquema:

```bash
sqlite3 ejercicio-12.db ".schema"
```

Para comprobar la integridad referencial:

```bash
sqlite3 ejercicio-12.db "PRAGMA foreign_keys = ON;"
sqlite3 ejercicio-12.db "PRAGMA foreign_key_check;"
```

Para comprobar que las reproducciones hacen referencia a canciones existentes:

```sql
SELECT
    r.id_reproduccion,
    r.id_cancion,
    c.titulo
FROM reproducciones AS r
INNER JOIN canciones AS c
    ON c.id_cancion = r.id_cancion;
```

## Validaciones

La implementación permite comprobar:

- Integridad entre artistas, álbumes, canciones y reproducciones.
- Prevención de artistas duplicados.
- Prevención de álbumes duplicados para un mismo artista.
- Prevención de números de pista repetidos dentro de un álbum.
- Prevención de títulos de canciones repetidos dentro de un álbum.
- Validación de duración de canciones.
- Validación de números de pista positivos.
- Validación de segundos escuchados positivos.
- Validación de dispositivos permitidos.
- Validación de fechas en formato ISO.
- Prevención de reproducciones asociadas a canciones inexistentes.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

Los artistas, álbumes y canciones se mantienen separados porque representan diferentes niveles del catálogo musical. Las reproducciones se almacenan de forma independiente porque una misma canción puede reproducirse muchas veces.

La fecha de lanzamiento se almacena en formato `YYYY-MM-DD`, mientras que la fecha de reproducción utiliza `YYYY-MM-DD HH:MM`.

La duración de las canciones y los segundos escuchados se almacenan como valores enteros en segundos para facilitar operaciones estadísticas y comparaciones.

Las restricciones únicas sobre álbumes y canciones evitan duplicidades dentro del contexto correspondiente.

Los índices se orientan a las relaciones entre las tablas y a las consultas sobre reproducciones por canción y fecha.

## Archivos principales

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```