# Diagrama ER

## Modelo entidad-relación

```mermaid
erDiagram
    SEDES ||--o{ USUARIOS : "registra"
    USUARIOS ||--o{ PRESTAMOS : "realiza"
    LIBROS ||--o{ PRESTAMOS : "participa"

    SEDES {
        INTEGER id_sede PK
        TEXT nombre UK
        TEXT direccion
        INTEGER capacidad
    }

    LIBROS {
        INTEGER id_libro PK
        TEXT titulo
        TEXT autor
        TEXT isbn UK
        INTEGER anio_publicacion
        INTEGER ejemplares
    }

    USUARIOS {
        INTEGER id_usuario PK
        INTEGER id_sede FK
        TEXT nombre_completo
        TEXT correo UK
        TEXT fecha_registro
        TEXT estado
    }

    PRESTAMOS {
        INTEGER id_prestamo PK
        INTEGER id_usuario FK
        INTEGER id_libro FK
        TEXT fecha_prestamo
        TEXT fecha_devolucion
        TEXT estado
        INTEGER dias_prestamo
    }
```

## Relaciones

- Una sede puede registrar cero o muchos usuarios.
- Cada usuario pertenece obligatoriamente a una sede.
- Un usuario puede realizar cero o muchos préstamos.
- Cada préstamo pertenece obligatoriamente a un usuario.
- Un libro puede participar en cero o muchos préstamos.
- Cada préstamo referencia obligatoriamente un libro.

## Restricciones relevantes

- `PK`: llave primaria.
- `FK`: llave foránea.
- `UK`: restricción `UNIQUE`.
- `NOT NULL`: campos obligatorios.
- `CHECK`: validación de capacidad, año, ejemplares, fechas, estados y duración del préstamo.