# Diagrama ER

## Modelo entidad-relacion

El modelo está compuesto por cuatro entidades: `huespedes`, `habitaciones`, `reservas` y `pagos`.

La tabla `reservas` funciona como entidad central y relaciona huéspedes con habitaciones. La tabla `pagos` registra las transacciones económicas asociadas a cada reserva.

```mermaid
erDiagram
    HUESPEDES ||--o{ RESERVAS : "realiza"
    HABITACIONES ||--o{ RESERVAS : "recibe"
    RESERVAS ||--o{ PAGOS : "genera"

    HUESPEDES {
        INTEGER id_huesped PK
        TEXT nombre_completo
        TEXT documento UK
        TEXT telefono
        TEXT correo UK
        TEXT fecha_registro
    }

    HABITACIONES {
        INTEGER id_habitacion PK
        INTEGER numero UK
        TEXT tipo
        INTEGER capacidad
        REAL precio_noche
        TEXT estado
    }

    RESERVAS {
        INTEGER id_reserva PK
        INTEGER id_huesped FK
        INTEGER id_habitacion FK
        TEXT fecha_entrada
        TEXT fecha_salida
        INTEGER cantidad_huespedes
        TEXT estado
    }

    PAGOS {
        INTEGER id_pago PK
        INTEGER id_reserva FK
        TEXT fecha_pago
        REAL monto
        TEXT metodo_pago
        TEXT estado
    }
```

## Relaciones

- `huespedes` 1:N `reservas`: un huésped puede realizar múltiples reservas y cada reserva pertenece a un huésped.
- `habitaciones` 1:N `reservas`: una habitación puede aparecer en múltiples reservas en diferentes períodos y cada reserva corresponde a una habitación.
- `reservas` 1:N `pagos`: una reserva puede tener múltiples pagos y cada pago pertenece a una reserva.
- `huespedes` utiliza `documento` y `correo` como valores únicos.
- `habitaciones` utiliza `numero` como identificador único del número físico.
- `reservas` utiliza `UNIQUE (id_habitacion, fecha_entrada)` para evitar duplicar reservas de una habitación con la misma fecha de entrada.