# Ejercicio 22: Pedidos Delivery

## Información

- Nombre completo: Jose Luis Tot Herrera
- Fecha: 2026-08-20
- Motor: SQLite

## Descripción

Base de datos para gestionar clientes, restaurantes, repartidores y pedidos de una plataforma de delivery.

## Modelo implementado

- `clientes`
- `restaurantes`
- `repartidores`
- `pedidos`

## Relaciones

- Un cliente realiza varios pedidos.
- Un restaurante recibe varios pedidos.
- Un repartidor entrega varios pedidos.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-22/
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