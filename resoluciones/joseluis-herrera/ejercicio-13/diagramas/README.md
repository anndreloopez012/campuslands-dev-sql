# Diagrama ER

```mermaid
erDiagram
    CLIENTES ||--o{ CUENTAS : "posee"
    CUENTAS ||--o{ TARJETAS : "tiene"
    CUENTAS ||--o{ TRANSACCIONES : "registra"

    CLIENTES {
        INTEGER id_cliente PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT telefono
    }

    CUENTAS {
        INTEGER id_cuenta PK
        INTEGER id_cliente FK
        TEXT numero_cuenta UK
        TEXT tipo_cuenta
        REAL saldo
        TEXT fecha_apertura
    }

    TARJETAS {
        INTEGER id_tarjeta PK
        INTEGER id_cuenta FK
        TEXT numero_tarjeta UK
        TEXT tipo_tarjeta
        TEXT estado
        TEXT fecha_emision
    }

    TRANSACCIONES {
        INTEGER id_transaccion PK
        INTEGER id_cuenta FK
        TEXT tipo_transaccion
        REAL monto
        TEXT fecha_transaccion
        TEXT descripcion
    }
```

## Relaciones

- Un cliente puede poseer una o varias cuentas.
- Una cuenta pertenece a un cliente.
- Una cuenta puede tener una o varias tarjetas.
- Una tarjeta pertenece a una cuenta.
- Una cuenta puede registrar múltiples transacciones.
- Cada transacción pertenece a una cuenta.