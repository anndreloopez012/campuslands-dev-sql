# Ejercicio 18: Farmacia Inventario

## Información

- Nombre completo: Jose Luis Tot Herrera
- Ejercicio: 18
- Fecha: 2026-08-20
- Motor de base de datos: SQLite
- Contexto: Inventario de farmacia

## Descripción

La base de datos permite administrar laboratorios, medicamentos, compras y ventas de una farmacia.

El modelo permite controlar el inventario de medicamentos, registrar adquisiciones y ventas, relacionar cada medicamento con su laboratorio y generar reportes para apoyar decisiones de inventario.

## Modelo implementado

La solución utiliza cuatro tablas:

- `laboratorios`: almacena la información de los laboratorios.
- `medicamentos`: almacena los medicamentos, precios, stock y fechas de vencimiento.
- `compras`: registra las compras realizadas para abastecer medicamentos.
- `ventas`: registra las ventas realizadas a clientes.

## Relaciones

- Un laboratorio puede fabricar varios medicamentos.
- Cada medicamento pertenece a un laboratorio.
- Un medicamento puede aparecer en múltiples compras.
- Una compra pertenece a un medicamento.
- Un medicamento puede aparecer en múltiples ventas.
- Una venta pertenece a un medicamento.

## Datos

Se registran:

- 5 laboratorios.
- 5 medicamentos.
- 10 compras.
- 10 ventas.

Los datos permiten generar resultados para inventario, compras, ventas, ingresos, laboratorios y decisiones de reposición.

## Consultas

`dql/consultas.sql` contiene consultas para:

1. Listar todos los medicamentos.
2. Mostrar nombre y stock.
3. Filtrar medicamentos con stock inferior a 100 unidades.
4. Ordenar medicamentos por fecha de vencimiento.
5. Obtener los cinco medicamentos con mayor stock.
6. Contar medicamentos.
7. Calcular precio promedio, mínimo y máximo.
8. Agrupar medicamentos por laboratorio.
9. Relacionar medicamentos con laboratorios.
10. Obtener los medicamentos con mayor cantidad de unidades vendidas.
11. Generar un reporte de ventas e ingresos.
12. Analizar las unidades compradas.
13. Filtrar medicamentos según unidades vendidas.
14. Generar una decisión de inventario según stock y ventas.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-018/
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