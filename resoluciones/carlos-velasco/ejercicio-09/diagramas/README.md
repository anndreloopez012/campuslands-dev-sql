# Diagrama ER

## Modelo entidad-relacion

El modelo utiliza cuatro entidades: `clientes`, `planes`, `membresias` y `pagos`.

La tabla `membresias` funciona como entidad central para relacionar clientes con los planes contratados. La tabla `pagos` registra las transacciones asociadas a cada membresía.

```mermaid
erDiagram
    CLIENTES ||--o{ MEMBRESIAS : "contrata"
    PLANES ||--o{ MEMBRESIAS : "define"
    MEMBRESIAS ||--o{ PAGOS : "recibe"

    CLIENTES {
        INTEGER id_cliente PK
        TEXT nombre_completo
        TEXT documento UK
        TEXT telefono
        TEXT correo UK
        TEXT fecha_registro
    }

    PLANES {
        INTEGER id_plan PK
        TEXT nombre UK
        INTEGER duracion_meses
        REAL precio
        TEXT descripcion
    }

    MEMBRESIAS {
        INTEGER id_membresia PK
        INTEGER id_cliente FK
        INTEGER id_plan FK
        TEXT fecha_inicio
        TEXT fecha_fin
        TEXT estado
    }

    PAGOS {
        INTEGER id_pago PK
        INTEGER id_membresia FK
        TEXT fecha_pago
        REAL monto
        TEXT metodo_pago
        TEXT estado
    }
```

## Relaciones

- `clientes` 1:N `membresias`: un cliente puede contratar múltiples membresías y cada membresía pertenece a un cliente.
- `planes` 1:N `membresias`: un plan puede ser contratado por múltiples clientes y cada membresía utiliza un plan.
- `membresias` 1:N `pagos`: una membresía puede tener múltiples pagos y cada pago pertenece a una membresía.
- `membresias` posee una restricción `UNIQUE` sobre cliente y fecha de inicio para evitar duplicar una membresía iniciada el mismo día.