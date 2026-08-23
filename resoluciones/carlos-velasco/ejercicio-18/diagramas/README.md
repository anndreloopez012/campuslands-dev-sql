# Diagrama ER

## Ejercicio 18: Farmacia Inventario

```mermaid
erDiagram
    LABORATORIOS ||--o{ MEDICAMENTOS : "fabrica"
    MEDICAMENTOS ||--o{ COMPRAS : "se compra"
    MEDICAMENTOS ||--o{ VENTAS : "se vende"

    LABORATORIOS {
        INTEGER id_laboratorio PK
        TEXT nombre UK
        TEXT telefono
        TEXT ciudad
    }

    MEDICAMENTOS {
        INTEGER id_medicamento PK
        INTEGER id_laboratorio FK
        TEXT nombre
        TEXT principio_activo
        REAL precio_venta
        INTEGER stock
        TEXT fecha_vencimiento
    }

    COMPRAS {
        INTEGER id_compra PK
        INTEGER id_medicamento FK
        TEXT fecha_compra
        INTEGER cantidad
        REAL precio_compra
        TEXT proveedor
    }

    VENTAS {
        INTEGER id_venta PK
        INTEGER id_medicamento FK
        TEXT fecha_venta
        INTEGER cantidad
        REAL precio_unitario
        TEXT cliente
    }
```

## Relaciones

- `laboratorios` tiene una relación de uno a muchos con `medicamentos`.
- `medicamentos` tiene una relación de uno a muchos con `compras`.
- `medicamentos` tiene una relación de uno a muchos con `ventas`.
- Cada medicamento pertenece obligatoriamente a un laboratorio.
- Cada compra corresponde obligatoriamente a un medicamento.
- Cada venta corresponde obligatoriamente a un medicamento.

## Restricciones representadas

- `PRIMARY KEY` en las cuatro entidades.
- `FOREIGN KEY` entre laboratorios y medicamentos.
- `FOREIGN KEY` entre medicamentos y compras.
- `FOREIGN KEY` entre medicamentos y ventas.
- `UNIQUE` en el nombre del laboratorio.
- `UNIQUE` compuesto entre nombre del medicamento y laboratorio.
- `CHECK` para precios positivos.
- `CHECK` para cantidades y stock válidos.
- `CHECK` para fechas con formato interpretable por SQLite.