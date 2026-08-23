# Diagrama ER

## Modelo entidad-relacion

```mermaid
erDiagram
    USUARIOS ||--o{ PUBLICACIONES : crea
    USUARIOS ||--o{ COMENTARIOS : escribe
    USUARIOS ||--o{ REACCIONES : realiza
    PUBLICACIONES ||--o{ COMENTARIOS : recibe
    PUBLICACIONES ||--o{ REACCIONES : recibe

    USUARIOS {
        INTEGER id_usuario PK
        TEXT nombre_completo
        TEXT nombre_usuario UK
        TEXT correo UK
        TEXT fecha_registro
    }

    PUBLICACIONES {
        INTEGER id_publicacion PK
        INTEGER usuario_id FK
        TEXT contenido
        TEXT fecha_publicacion
        TEXT visibilidad
    }

    COMENTARIOS {
        INTEGER id_comentario PK
        INTEGER publicacion_id FK
        INTEGER usuario_id FK
        TEXT contenido
        TEXT fecha_comentario
    }

    REACCIONES {
        INTEGER id_reaccion PK
        INTEGER publicacion_id FK
        INTEGER usuario_id FK
        TEXT tipo
        TEXT fecha_reaccion
    }
```

## Relaciones

- Un usuario puede crear cero o muchas publicaciones.
- Una publicación pertenece a un único usuario.
- Un usuario puede escribir cero o muchos comentarios.
- Un comentario pertenece a un único usuario y a una única publicación.
- Un usuario puede realizar cero o muchas reacciones.
- Una reacción pertenece a un único usuario y a una única publicación.
- La tabla `reacciones` utiliza una restricción `UNIQUE` sobre `(publicacion_id, usuario_id)` para evitar que un mismo usuario reaccione más de una vez a una publicación.
- Las relaciones se implementan mediante llaves foráneas.