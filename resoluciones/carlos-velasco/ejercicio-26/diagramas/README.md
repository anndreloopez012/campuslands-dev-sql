# Diagrama ER

## Modelo relacional

El modelo está normalizado hasta tercera forma normal (3FN) y utiliza cuatro tablas con responsabilidades independientes.

```mermaid
erDiagram
    CATEGORIAS {
        INTEGER id_categoria PK
        VARCHAR nombre UK
    }

    CLIENTES {
        INTEGER id_cliente PK
        VARCHAR nombre_completo
        VARCHAR correo UK
        VARCHAR telefono
    }

    PRODUCTOS {
        INTEGER id_producto PK
        VARCHAR nombre
        VARCHAR sku UK
        DECIMAL precio
        INTEGER stock
        INTEGER id_categoria FK
    }

    COMPRAS {
        INTEGER id_compra PK
        INTEGER id_cliente FK
        INTEGER id_producto FK
        INTEGER cantidad
        TEXT fecha_compra
    }

    CATEGORIAS ||--o{ PRODUCTOS : clasifica
    CLIENTES ||--o{ COMPRAS : realiza
    PRODUCTOS ||--o{ COMPRAS : contiene
```

## Relaciones

- `categorias` mantiene el catálogo independiente de categorías.
- `productos` pertenece a una categoría mediante `id_categoria`.
- `clientes` mantiene los datos independientes de cada cliente.
- `compras` registra cada operación y relaciona un cliente con un producto mediante claves foráneas.
- La información de categoría no se repite dentro de `productos`.
- La información del cliente no se repite dentro de `compras`.
- La información del producto no se repite dentro de `compras`.

## Cardinalidades

- Una categoría puede tener cero o muchos productos.
- Cada producto pertenece obligatoriamente a una categoría.
- Un cliente puede realizar cero o muchas compras.
- Cada compra pertenece obligatoriamente a un cliente.
- Un producto puede aparecer en cero o muchas compras.
- Cada compra referencia obligatoriamente un producto.