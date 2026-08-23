# Ejercicio 14: Marketplace Campus

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una organizacion necesita dejar de manejar en hojas sueltas la informacion de vendedores, productos, compradores y ordenes de un marketplace. Esto provoca duplicidad, errores de captura y dificultad para generar reportes de ventas. La solucion propone una base de datos relacional en SQLite que permita registrar vendedores y su catalogo de productos, compradores y las ordenes de compra que realizan.

## Tablas y relaciones

- `vendedores`: catalogo de vendedores del marketplace (nombre, correo, telefono).
- `productos`: producto publicado por un vendedor (nombre, precio, stock). `vendedores` 1—N `productos`.
- `compradores`: catalogo de compradores (nombre, correo).
- `ordenes`: orden de compra de un comprador sobre un producto (cantidad, fecha, estado). `compradores` 1—N `ordenes` y `productos` 1—N `ordenes`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `productos.id_vendedor`, `ordenes.id_comprador`, `ordenes.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `vendedores.correo`, `compradores.correo`.
- `CHECK`: `productos.precio > 0`, `productos.stock >= 0`, `ordenes.cantidad > 0`, `ordenes.estado IN ('pendiente', 'pagada', 'enviada', 'cancelada')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 vendedores, 5 productos, 5 compradores, 10 ordenes.
- Tras aplicar `operaciones.sql`: 5 vendedores, 5 productos, 6 compradores y 9 ordenes (2 insertadas, 2 eliminadas).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (vendedores.correo)` y otra por `CHECK (ordenes.cantidad > 0)`.
- Consulta de decision de negocio (producto con mayor cantidad total vendida): `Cuaderno profesional` con 7 unidades.

## Como ejecutar

```bash
sqlite3 ejercicio-14.db < ddl/schema.sql
sqlite3 ejercicio-14.db < dml/inserts.sql
sqlite3 ejercicio-14.db < dml/operaciones.sql
sqlite3 ejercicio-14.db < dql/consultas.sql
```
