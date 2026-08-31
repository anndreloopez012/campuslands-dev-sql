# Ejercicio 05: Inventario de Bicicletas

**Camper:** Antonio Canux

## Descripcion del problema

La tienda necesita reemplazar el registro manual de bicicletas, marcas, proveedores y movimientos de inventario por una base de datos relacional que evite duplicidad y permita controlar entradas y salidas de stock.

## Tablas y relaciones

- `marcas`: catalogo de marcas de bicicletas (nombre).
- `proveedores`: catalogo de proveedores (nombre, telefono).
- `bicicletas`: catalogo de modelos con precio y stock (`marcas` 1—N `bicicletas`).
- `movimientos_inventario`: entrada o salida de stock de una bicicleta asociada a un proveedor (`bicicletas` 1—N `movimientos_inventario`, `proveedores` 1—N `movimientos_inventario`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `bicicletas.id_marca`, `movimientos_inventario.id_bicicleta`, `movimientos_inventario.id_proveedor`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `marcas.nombre`, `proveedores.nombre`.
- `CHECK`: `bicicletas.tipo IN (...)`, `bicicletas.precio > 0`, `bicicletas.stock >= 0`, `movimientos_inventario.tipo_movimiento IN ('entrada', 'salida')`, `movimientos_inventario.cantidad > 0`.

## Como ejecutar

```bash
sqlite3 ejercicio-05.db < ddl/schema.sql
sqlite3 ejercicio-05.db < dml/inserts.sql
sqlite3 ejercicio-05.db < dml/operaciones.sql
sqlite3 ejercicio-05.db < dql/consultas.sql
```
