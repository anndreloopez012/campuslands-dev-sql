# Ejercicio 14: Marketplace Campus

## Información

- Nombre completo: Jose Luis Tot Herrera
- Ejercicio: 14
- Fecha: 2026-08-20
- Motor de base de datos: SQLite
- Modelo: Marketplace de ordenes de compra y ventas por vendedor

## Descripción

El ejercicio implementa una base de datos relacional para administrar vendedores, productos, compradores y ordenes de compra de un marketplace.

El modelo permite registrar productos asociados a vendedores, compradores que realizan ordenes y los productos incluidos en dichas ordenes.

## Modelo implementado

La solución utiliza cuatro tablas:

- `vendedores`: almacena la información de los vendedores.
- `compradores`: almacena la información de los compradores.
- `productos`: almacena los productos ofrecidos y su vendedor.
- `ordenes`: registra las compras realizadas por los compradores sobre los productos.

### Relaciones

- Un vendedor puede ofrecer varios productos.
- Un producto pertenece a un vendedor.
- Un comprador puede realizar varias ordenes.
- Una orden pertenece a un comprador.
- Un producto puede aparecer en varias ordenes.
- Una orden corresponde a un producto.


## Datos

Se registran:

- 5 vendedores.
- 5 compradores.
- 10 productos.
- 10 ordenes.

Los datos permiten realizar consultas de conteo, agregación, agrupación, relaciones y análisis de ventas.


## Consultas

`dql/consultas.sql` contiene consultas para:

1. Listar las ordenes.
2. Seleccionar columnas específicas.
3. Filtrar por cantidad.
4. Ordenar por fecha.
5. Obtener las cinco ordenes de mayor valor.
6. Contar las ordenes.
7. Calcular valores promedio, mínimo y máximo.
8. Agrupar ordenes por estado.
9. Relacionar compradores, productos y ordenes.
10. Obtener las cinco compras de mayor valor.
11. Generar un reporte de ventas por vendedor.
12. Clasificar el inventario y el rendimiento de vendedores.


## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-014/
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