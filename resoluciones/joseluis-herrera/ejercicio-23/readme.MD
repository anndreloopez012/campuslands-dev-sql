# Ejercicio 23: Facturación Simple

## Información

- Nombre completo: Jose Luis Tot Herrera
- Fecha: 2026-08-20
- Motor: SQLite

## Descripción

Sistema de facturación que administra clientes, productos, facturas y el detalle de cada factura para calcular subtotales, impuestos y totales.

## Modelo implementado

- `clientes`
- `productos`
- `facturas`
- `detalle_factura`

## Relaciones

- Un cliente puede tener varias facturas.
- Una factura contiene varios productos mediante el detalle.
- Un producto puede aparecer en múltiples facturas.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-23/
        ├── README.md
        ├── diagramas/
        │   └── README.md
        ├── ddl/
        │   └── schema.sql
        ├── dml/
        │   ├── inserts.sql
        │   └── operaciones.sql
        └── dql/
            └── consultas.sql
```