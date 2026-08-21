# Diagrama ER

El modelo de Biblioteca Tech está compuesto por cuatro tablas:

- `autores`
- `libros`
- `campers`
- `prestamos`

La tabla `prestamos` funciona como entidad transaccional y relaciona a los campers con los libros.

```mermaid
erDiagram
    AUTORES ||--o{ LIBROS : escribe
    LIBROS ||--o{ PRESTAMOS : registra
    CAMPERS ||--o{ PRESTAMOS : realiza

    AUTORES {
        INTEGER id_autor PK
        TEXT nombre_completo UK
        TEXT nacionalidad
        TEXT fecha_nacimiento
    }

    LIBROS {
        INTEGER id_libro PK
        TEXT titulo
        TEXT isbn UK
        INTEGER anio_publicacion
        INTEGER paginas
        INTEGER id_autor FK
    }

    CAMPERS {
        INTEGER id_camper PK
        TEXT nombre_completo
        TEXT email UK
        TEXT fecha_ingreso
        TEXT nivel
    }

    PRESTAMOS {
        INTEGER id_prestamo PK
        INTEGER id_libro FK
        INTEGER id_camper FK
        TEXT fecha_prestamo
        TEXT fecha_devolucion
        TEXT estado
    }
```

## Relaciones

- Un autor puede tener varios libros.
- Cada libro pertenece a un autor.
- Un camper puede realizar varios préstamos.
- Cada préstamo pertenece a un camper.
- Un libro puede aparecer en varios préstamos.
- Cada préstamo corresponde a un libro.

## Restricciones relevantes

- Las claves primarias identifican de forma única cada registro.
- Las claves foráneas mantienen la integridad referencial.
- Los ISBN de los libros son únicos.
- Los correos electrónicos de los campers son únicos.
- Los niveles de los campers están restringidos mediante `CHECK`.
- Los estados de los préstamos están restringidos mediante `CHECK`.
- Las fechas de devolución no pueden ser anteriores a la fecha del préstamo.