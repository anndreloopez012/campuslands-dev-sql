# Ejercicio 23: Facturacion Simple

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una organizacion necesita reemplazar el registro manual de clientes, productos, facturas y detalles de factura por una base de datos relacional que evite duplicidad de datos y permita calcular subtotales, impuestos y totales de forma confiable.

## Tablas y relaciones

- `clientes`: catalogo de clientes que reciben facturas (nombre, nit, correo).
- `productos`: catalogo de productos facturables (nombre, precio unitario).
- `facturas`: factura emitida a un cliente (fecha, subtotal, impuesto, total). `clientes` 1—N `facturas`.
- `detalle_factura`: linea de producto dentro de una factura (cantidad, precio unitario). `facturas` 1—N `detalle_factura` y `productos` 1—N `detalle_factura`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `facturas.id_cliente`, `detalle_factura.id_factura`, `detalle_factura.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.nit`, `clientes.correo`, `productos.nombre`.
- `CHECK`: `productos.precio_unitario > 0`, `facturas.subtotal >= 0`, `facturas.impuesto >= 0`, `facturas.total >= 0`, `detalle_factura.cantidad > 0`, `detalle_factura.precio_unitario > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 clientes, 5 productos, 5 facturas, 10 detalles de factura.
- Tras aplicar `operaciones.sql`: 6 clientes, 5 productos, 5 facturas y 9 detalles de factura (2 insertados, 2 eliminados).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (clientes.nit)` y otra por `CHECK (detalle_factura.cantidad > 0)`.
- Consulta de decision de negocio (producto con mayores ingresos totales): `Laptop` con 9000.00.

## Como ejecutar

```bash
sqlite3 ejercicio-23.db < ddl/schema.sql
sqlite3 ejercicio-23.db < dml/inserts.sql
sqlite3 ejercicio-23.db < dml/operaciones.sql
sqlite3 ejercicio-23.db < dql/consultas.sql
```
