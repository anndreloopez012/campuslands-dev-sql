# Diagrama ER

## Modelo

El sistema de facturación está compuesto por cuatro entidades: clientes, productos, facturas y detalle de factura.

Las facturas pertenecen a un cliente y cada factura puede contener múltiples productos mediante la tabla `detalle_factura`.

```mermaid
erDiagram
    CLIENTES ||--o{ FACTURAS : "realiza"
    FACTURAS ||--|{ DETALLE_FACTURA : "contiene"
    PRODUCTOS ||--o{ DETALLE_FACTURA : "aparece en"

    CLIENTES {
        INTEGER id_cliente PK
        TEXT nombre_completo
        TEXT documento UK
        TEXT correo UK
        TEXT telefono
    }

    PRODUCTOS {
        INTEGER id_producto PK
        TEXT nombre UK
        TEXT descripcion
        REAL precio
        INTEGER stock
    }

    FACTURAS {
        INTEGER id_factura PK
        INTEGER id_cliente FK
        TEXT numero_factura UK
        TEXT fecha
        REAL impuesto
        TEXT estado
    }

    DETALLE_FACTURA {
        INTEGER id_detalle PK
        INTEGER id_factura FK
        INTEGER id_producto FK
        INTEGER cantidad
        REAL precio_unitario
    }
```

## Relaciones

- `clientes` tiene una relación de uno a muchos con `facturas`.
- `facturas` tiene una relación de uno a muchos con `detalle_factura`.
- `productos` tiene una relación de uno a muchos con `detalle_factura`.
- `detalle_factura` funciona como entidad asociativa entre facturas y productos.
- La combinación `id_factura` e `id_producto` es única dentro de `detalle_factura`.

## Restricciones representadas

- Claves primarias en las cuatro tablas.
- Claves foráneas entre facturas, clientes y detalle de factura.
- Restricciones `UNIQUE` en documentos, correos, productos y números de factura.
- Restricciones `CHECK` para precios, cantidades, stock, impuestos, fechas y estados.