# Diagrama ER

## Modelo entidad-relacion

El modelo está compuesto por cuatro entidades: `artistas`, `albumes`, `canciones` y `reproducciones`.

La tabla `reproducciones` funciona como entidad central de actividad y registra cada reproducción asociada a una canción.

```mermaid
erDiagram
    ARTISTAS ||--o{ ALBUMES : "publica"
    ALBUMES ||--o{ CANCIONES : "contiene"
    CANCIONES ||--o{ REPRODUCCIONES : "registra"

    ARTISTAS {
        INTEGER id_artista PK
        TEXT nombre UK
        TEXT genero_principal
        TEXT pais_origen
        INTEGER anio_inicio
    }

    ALBUMES {
        INTEGER id_album PK
        INTEGER id_artista FK
        TEXT titulo
        TEXT fecha_lanzamiento
        INTEGER cantidad_canciones
    }

    CANCIONES {
        INTEGER id_cancion PK
        INTEGER id_album FK
        TEXT titulo
        INTEGER duracion_segundos
        INTEGER numero_pista
    }

    REPRODUCCIONES {
        INTEGER id_reproduccion PK
        INTEGER id_cancion FK
        TEXT fecha_hora
        TEXT dispositivo
        INTEGER segundos_escuchados
    }
```

## Relaciones

- `artistas` 1:N `albumes`: un artista puede publicar múltiples álbumes y cada álbum pertenece a un artista.
- `albumes` 1:N `canciones`: un álbum contiene múltiples canciones y cada canción pertenece a un álbum.
- `canciones` 1:N `reproducciones`: una canción puede registrar múltiples reproducciones y cada reproducción pertenece a una canción.
- `artistas.nombre` es único.
- `albumes` utiliza una restricción única sobre `(id_artista, titulo)`.
- `canciones` utiliza restricciones únicas sobre `(id_album, numero_pista)` y `(id_album, titulo)`.
- Las fechas de lanzamiento utilizan el formato `YYYY-MM-DD`.
- Las fechas de reproducción utilizan el formato `YYYY-MM-DD HH:MM`.