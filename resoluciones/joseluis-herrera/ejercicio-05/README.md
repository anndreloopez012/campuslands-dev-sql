### README.md

# Ejercicio 05: Inventario de Bicicletas

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 05
- Rama: `alumno/joseluis-herrera/ejercicio-05`

## Descripción

La organización necesita reemplazar el registro manual de bicicletas, marcas, proveedores y movimientos por una base de datos relacional que permita controlar las entradas y salidas de inventario, reducir errores y generar reportes para apoyar decisiones sobre existencias.

## Modelo implementado

La solución utiliza cuatro tablas:

- `marcas`: almacena las marcas de bicicletas.
- `proveedores`: almacena los proveedores.
- `bicicletas`: almacena los modelos, precios y stock actual.
- `movimientos_inventario`: registra las entradas y salidas de inventario.

## Relaciones

```text
MARCAS 1 ───────── N BICICLETAS
PROVEEDORES 1 ──── N BICICLETAS
BICICLETAS 1 ───── N MOVIMIENTOS_INVENTARIO
```

## Restricciones

- Todas las tablas poseen `PRIMARY KEY`.
- `bicicletas.id_marca` referencia `marcas.id_marca`.
- `bicicletas.id_proveedor` referencia `proveedores.id_proveedor`.
- `movimientos_inventario.id_bicicleta` referencia `bicicletas.id_bicicleta`.
- `marcas.nombre` posee `UNIQUE`.
- `proveedores.nombre_empresa` posee `UNIQUE`.
- `proveedores.email` posee `UNIQUE`.
- La combinación de marca y modelo posee `UNIQUE`.
- Los campos obligatorios utilizan `NOT NULL`.
- El precio utiliza `CHECK`.
- El stock utiliza `CHECK`.
- El tipo de bicicleta utiliza `CHECK`.
- La cantidad de movimientos utiliza `CHECK`.
- El tipo de movimiento utiliza `CHECK`.
- Las llaves foráneas se activan mediante `PRAGMA foreign_keys = ON`.

## Datos

```text
Marcas: 5 registros base
Proveedores: 5 registros base
Bicicletas: 5 registros base
Movimientos de inventario: 10 registros base
```

Los movimientos contienen entradas y salidas asociadas a diferentes bicicletas para permitir análisis de inventario.


## Consultas

El archivo `dql/consultas.sql` contiene las doce consultas requeridas:

```text
1. Listado completo de bicicletas.
2. Seleccion de modelo y stock.
3. Filtro de bicicletas por precio.
4. Ordenamiento alfabetico por modelo.
5. Top 5 bicicletas segun cantidad de movimientos.
6. Conteo total de bicicletas.
7. Precio promedio, minimo y maximo.
8. Agrupacion de bicicletas por tipo.
9. JOIN entre bicicletas, marcas y proveedores.
10. WHERE + ORDER BY + LIMIT.
11. Reporte de movimientos con alias legibles.
12. Consulta de decision sobre reabastecimiento.
```


## Decisiones de diseño

La tabla `bicicletas` funciona como entidad central del inventario porque almacena cada modelo, su marca, proveedor, precio y stock actual.

La tabla `movimientos_inventario` registra las operaciones de entrada y salida relacionadas con cada bicicleta.

Las tablas `marcas` y `proveedores` se mantienen independientes para evitar duplicidad de información y permitir consultas mediante llaves foráneas.