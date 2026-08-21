# Diagrama ER

```mermaid
erDiagram
    CLIENTES {
        INTEGER id_cliente PK
        TEXT nombre_completo
        TEXT telefono
        TEXT correo UK
        TEXT fecha_registro
    }

    MOTOS {
        INTEGER id_moto PK
        INTEGER id_cliente FK
        TEXT placa UK
        TEXT marca
        TEXT modelo
        INTEGER anio
        INTEGER kilometraje
    }

    SERVICIOS {
        INTEGER id_servicio PK
        TEXT nombre UK
        TEXT descripcion
        REAL precio_base
        INTEGER duracion_minutos
    }

    ORDENES_SERVICIO {
        INTEGER id_orden PK
        INTEGER id_moto FK
        INTEGER id_servicio FK
        TEXT fecha_servicio
        INTEGER kilometraje
        TEXT estado
        REAL precio_final
        TEXT observaciones
    }

    CLIENTES ||--o{ MOTOS : posee
    MOTOS ||--o{ ORDENES_SERVICIO : recibe
    SERVICIOS ||--o{ ORDENES_SERVICIO : corresponde
```

## Relaciones

- `clientes` → `motos`: un cliente puede poseer varias motos.
- `motos` → `ordenes_servicio`: una moto puede tener múltiples órdenes de servicio.
- `servicios` → `ordenes_servicio`: un servicio puede utilizarse en múltiples órdenes.
- `ordenes_servicio` relaciona cada moto con el servicio realizado.

## Claves

- `clientes.id_cliente`: clave primaria.
- `motos.id_moto`: clave primaria.
- `servicios.id_servicio`: clave primaria.
- `ordenes_servicio.id_orden`: clave primaria.
- `motos.id_cliente`: clave foránea hacia `clientes`.
- `ordenes_servicio.id_moto`: clave foránea hacia `motos`.
- `ordenes_servicio.id_servicio`: clave foránea hacia `servicios`.
- `clientes.correo`, `motos.placa` y `servicios.nombre`: valores únicos.