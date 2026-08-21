# Ejercicio 02: Campus Shop

## Información

- **Nombre:** Jose Luis Herrera
- **Ejercicio:** 02 - Campus Shop
- **Motor:** SQLite
- **Fecha:** 2026-08-20

## Descripción

Campus Shop requiere una base de datos relacional para administrar productos, categorías, clientes y ventas, reemplazando el manejo manual de información y reduciendo duplicidad y errores de captura.

La solución utiliza cuatro tablas relacionadas mediante llaves primarias y foráneas.

## Modelo implementado

### Categorías

Almacena las categorías disponibles para clasificar los productos.

### Productos

Representa el inventario de la tienda. Cada producto pertenece a una categoría.

### Clientes

Almacena la información básica de los compradores.

### Ventas

Registra las operaciones de venta y relaciona un cliente con el producto adquirido.

## Relaciones

```text
CATEGORIAS 1 ─────── N PRODUCTOS
CLIENTES   1 ─────── N VENTAS
PRODUCTOS  1 ─────── N VENTAS
```

## Restricciones

- Todas las tablas utilizan `PRIMARY KEY`.
- Las relaciones utilizan `FOREIGN KEY`.
- Los campos obligatorios utilizan `NOT NULL`.
- Los nombres de categorías utilizan `UNIQUE`.
- Los nombres de productos utilizan `UNIQUE`.
- Los correos de clientes utilizan `UNIQUE`.
- El precio de productos debe ser mayor que cero.
- El stock de productos no puede ser negativo.
- La cantidad de una venta debe ser mayor que cero.
- El precio unitario de una venta debe ser mayor que cero.
- Las claves foráneas se validan mediante `PRAGMA foreign_keys = ON`.
- Las fechas utilizan formato ISO `YYYY-MM-DD`.

## Datos registrados

```text
Categorias: 5 registros
Productos: 8 registros iniciales/operacionales
Clientes: 8 registros iniciales/operacionales
Ventas: 10 registros
```

Los datos iniciales cumplen con los mínimos solicitados y permiten ejecutar todas las consultas con resultados.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

```text
2 INSERT adicionales
2 UPDATE validos
2 DELETE controlados
2 operaciones invalidas comentadas
```

Las operaciones inválidas corresponden a:

```text
UNIQUE
FOREIGN KEY
```

Se mantienen comentadas para evitar que interrumpan la ejecución completa del script.

## Consultas

El archivo `dql/consultas.sql` contiene las consultas requeridas:

```text
1. Listado completo de productos.
2. Selección de dos columnas.
3. Filtro por precio.
4. Ordenamiento alfabético.
5. Cinco productos principales según precio.
6. Conteo total de productos.
7. Promedio, mínimo y máximo de precios.
8. Agrupación de productos por categoría.
9. JOIN entre clientes, ventas y productos.
10. Consulta con WHERE, ORDER BY y LIMIT.
11. Reporte con alias legibles.
12. Consulta para decisión de inventario.
```

## Evidencias de ejecución

La estructura permite ejecutar los scripts en el siguiente orden:

```bash
sqlite3 ejercicio-02.db < ddl/schema.sql
sqlite3 ejercicio-02.db < dml/inserts.sql
sqlite3 ejercicio-02.db < dml/operaciones.sql
sqlite3 ejercicio-02.db < dql/consultas.sql
```

No se incluye ningún archivo de base de datos `.db`, `.sqlite` o `.sqlite3` en la solución.

## Validaciones principales

```text
PRIMARY KEY       -> Identificación única de cada registro.
FOREIGN KEY       -> Integridad entre categorías, productos, clientes y ventas.
UNIQUE            -> Evita nombres y correos duplicados.
CHECK             -> Controla precios, cantidades y stock.
NOT NULL          -> Garantiza información obligatoria.
PRAGMA            -> Activa la validación de claves foráneas en SQLite.
```

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

`categorias` y `productos` separan el catálogo de productos.

`clientes` mantiene independiente la información de compradores.

`ventas` concentra las transacciones y utiliza llaves foráneas para relacionar clientes y productos.

La separación permite evitar duplicidad y facilita consultas de inventario, ventas y clientes.