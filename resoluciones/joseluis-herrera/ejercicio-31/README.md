
### README.md

````markdown
# Ejercicio 31: Normalización Ventas Campus

## Información

- Ejercicio: 31
- Nombre: Normalización Ventas Campus
- Motor: SQLite
- Nivel: Normalización

## Descripción

El ejercicio parte de un archivo plano utilizado para registrar ventas, clientes, productos, vendedores y sucursales.

El diseño original presenta datos repetidos, grupos repetitivos y múltiples valores dentro de una misma celda.

El objetivo es transformar el modelo hasta 3FN e implementarlo mediante un modelo relacional en SQLite.

## Solución

El modelo se divide en seis tablas:

```text
clientes
productos
vendedores
sucursales
ventas
detalle_venta
```

La tabla `ventas` representa el encabezado de una transacción.

La tabla `detalle_venta` representa los productos incluidos en cada transacción.

## Modelo implementado

```text
CLIENTES
    │
    └──< VENTAS >── VENDEDORES
             │
             └── SUCURSALES
             │
             └──< DETALLE_VENTA >── PRODUCTOS
```

## Tablas

| Tabla | Propósito |
|---|---|
| clientes | Información de los compradores |
| productos | Catálogo de productos |
| vendedores | Información de vendedores |
| sucursales | Información de sucursales |
| ventas | Encabezado de las transacciones |
| detalle_venta | Productos y cantidades de cada venta |

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Reconstruir una vista similar al archivo original mediante `JOIN`.
2. Listar entidades principales sin duplicados.
3. Contar productos por categoría.
4. Calcular el total de cada transacción.
5. Calcular promedio, mínimo y máximo.
6. Buscar productos mediante `LIKE`.
7. Filtrar ventas por rango de fechas.
8. Obtener el top 5 de ventas por monto.
9. Detectar ventas sin detalle.
10. Generar un reporte final con alias legibles.

## Normalización

### 1FN

Se eliminan los grupos repetitivos de productos, precios y cantidades.

Cada valor queda almacenado de manera atómica.

### 2FN

Se eliminan las dependencias parciales separando clientes, productos, vendedores y sucursales de la información de las ventas.

### 3FN

Se eliminan las dependencias transitivas y cada atributo descriptivo queda asociado a la entidad que representa.


## Archivos

```text
analisis/
└── normalizacion.md

diagramas/
└── README.md

ddl/
└── schema.sql

dml/
└── inserts.sql

dql/
└── consultas.sql
```