# Diagrama ER

```mermaid
erDiagram
    VENDEDORES ||--o{ PRODUCTOS : ofrece
    COMPRADORES ||--o{ ORDENES : realiza
    PRODUCTOS ||--o{ ORDENES : pertenece

    VENDEDORES {
        INTEGER id_vendedor PK
        TEXT nombre
        TEXT email UK
        TEXT telefono
    }

    COMPRADORES {
        INTEGER id_comprador PK
        TEXT nombre
        TEXT email UK
        TEXT ciudad
    }

    PRODUCTOS {
        INTEGER id_producto PK
        INTEGER id_vendedor FK
        TEXT nombre
        TEXT sku UK
        REAL precio
        INTEGER stock
    }

    ORDENES {
        INTEGER id_orden PK
        INTEGER id_comprador FK
        INTEGER id_producto FK
        TEXT fecha
        INTEGER cantidad
        REAL precio_unitario
        TEXT estado
    }
```