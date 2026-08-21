# Diagrama entidad-relación — Campus Shop

```mermaid
erDiagram

    CATEGORIAS {
        INTEGER id PK
        TEXT nombre UK
        TEXT descripcion
    }

    PRODUCTOS {
        INTEGER id PK
        INTEGER categoria_id FK
        TEXT nombre
        REAL precio
        INTEGER stock
        TEXT fecha_ingreso
        TEXT sku UK
    }

    CLIENTES {
        INTEGER id PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT telefono
        TEXT fecha_registro
    }

    VENTAS {
        INTEGER id PK
        INTEGER producto_id FK
        INTEGER cliente_id FK
        INTEGER cantidad
        TEXT fecha_venta
        REAL total
    }

    CATEGORIAS ||--o{ PRODUCTOS : contiene
    PRODUCTOS ||--o{ VENTAS : participa
    CLIENTES ||--o{ VENTAS : realiza