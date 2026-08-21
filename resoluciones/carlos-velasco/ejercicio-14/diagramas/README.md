# Diagrama ER

## Modelo entidad-relación

El modelo está compuesto por cuatro entidades: `vendedores`, `productos`, `compradores` y `ordenes`.

La tabla `ordenes` representa la entidad transaccional central del marketplace y relaciona al comprador, al producto y al vendedor responsable de la venta.

```mermaid
erDiagram
    VENDEDORES ||--o{ PRODUCTOS : "publica"
    VENDEDORES ||--o{ ORDENES : "recibe"
    PRODUCTOS ||--o{ ORDENES : "incluye"
    COMPRADORES ||--o{ ORDENES : "realiza"

    VENDEDORES {
        INTEGER id_vendedor PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT ciudad
        TEXT fecha_registro
        TEXT estado
    }

    PRODUCTOS {
        INTEGER id_producto PK
        INTEGER id_vendedor FK
        TEXT nombre
        TEXT categoria
        REAL precio
        INTEGER stock
        TEXT estado
    }

    COMPRADORES {
        INTEGER id_comprador PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT ciudad
        TEXT fecha_registro
        TEXT estado
    }

    ORDENES {
        INTEGER id_orden PK
        INTEGER id_vendedor FK
        INTEGER id_producto FK
        INTEGER id_comprador FK
        INTEGER cantidad
        REAL precio_unitario
        TEXT fecha_orden
        TEXT estado
    }
```

## Relaciones

- `vendedores` 1:N `productos`: un vendedor puede publicar múltiples productos.
- `vendedores` 1:N `ordenes`: un vendedor puede recibir múltiples órdenes.
- `productos` 1:N `ordenes`: un producto puede aparecer en múltiples órdenes.
- `compradores` 1:N `ordenes`: un comprador puede realizar múltiples órdenes.
- Cada orden pertenece obligatoriamente a un vendedor, producto y comprador.
- `vendedores.correo` es único.
- `compradores.correo` es único.
- Los productos controlan precio, stock y estado mediante `CHECK`.
- Las órdenes controlan cantidad, precio, estado y formato de fecha mediante `CHECK`.