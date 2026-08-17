# Ejercicio 02: Campus Shop

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-04

## Descripcion del problema

Campus Shop necesita reemplazar el registro manual de productos, categorias, clientes y ventas por una base de datos relacional que evite duplicidad y permita generar reportes de inventario y ventas.

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto (nombre).
- `productos`: catalogo de productos con precio y stock (`categorias` 1—N `productos`).
- `clientes`: catalogo de clientes (nombre, correo, telefono).
- `ventas`: transaccion de compra de un producto por un cliente (`clientes` 1—N `ventas`, `productos` 1—N `ventas`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `ventas.id_cliente`, `ventas.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `categorias.nombre`, `clientes.correo`.
- `CHECK`: `productos.precio > 0`, `productos.stock >= 0`, `ventas.cantidad > 0`, `ventas.precio_unitario > 0`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 6 categorias, 6 productos, 5 clientes y 9 ventas tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (categorias.nombre)` y otra por `CHECK (stock >= 0)`.
- Consulta de decision de negocio (producto con mas unidades vendidas): `Mouse inalambrico` con 5 unidades.

## Como ejecutar

```bash
sqlite3 ejercicio-02.db < ddl/schema.sql
sqlite3 ejercicio-02.db < dml/inserts.sql
sqlite3 ejercicio-02.db < dml/operaciones.sql
sqlite3 ejercicio-02.db < dql/consultas.sql
```
