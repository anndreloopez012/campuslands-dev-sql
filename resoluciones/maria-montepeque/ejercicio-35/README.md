# Ejercicio 35: Normalizacion Inventario Proveedores

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Descripcion del problema

La empresa administraba su inventario en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde cada fila mezclaba el catalogo de un producto (categoria, proveedor, telefono) con dos movimientos de inventario escondidos en las columnas `entradas` y `salidas`. Esto generaba duplicidad del proveedor y su telefono en cada producto que surtia, y limitaba el modelo a un solo par entrada/salida por producto. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto.
- `proveedores`: catalogo de proveedores (nombre, telefono).
- `bodegas`: catalogo de bodegas.
- `productos`: catalogo de productos, cada uno con su categoria y proveedor (`categorias` 1—N `productos`, `proveedores` 1—N `productos`).
- `movimientos`: detalle de cada entrada o salida de un producto en una bodega. `productos` 1—N `movimientos` y `bodegas` 1—N `movimientos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 5 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `productos.id_proveedor`, `movimientos.id_producto`, `movimientos.id_bodega`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `categorias.nombre`, `proveedores.nombre`, `proveedores.telefono`, `productos.nombre`, `bodegas.nombre`.
- `CHECK`: `movimientos.tipo_movimiento IN ('entrada', 'salida')`, `movimientos.cantidad > 0`, `movimientos.fecha_movimiento` con formato `YYYY-MM-DD`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 categorias, 5 proveedores, 5 bodegas, 5 productos, 12 lineas de `movimientos`.
- Los 3 movimientos del CSV original (Laptop X1 10/2, Mouse Pro 50/12, Silla Gamer 8/1) quedan representados como 6 filas individuales de entrada/salida; se agregaron movimientos adicionales de los 2 productos nuevos y un par extra de Laptop X1/Mouse Pro para cumplir el minimo de 10 lineas de detalle.
- La consulta 1 (`JOIN` con agregacion condicional) reconstruye el formato original, un renglon por producto y bodega con sus totales de `entradas` y `salidas`.
- Producto con mas entradas totales (consulta 8): `Mouse Pro` con 50 unidades.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (proveedores.nombre)` y otro por `CHECK (cantidad > 0)`.

## Como ejecutar

```bash
sqlite3 ejercicio-35.db < ddl/schema.sql
sqlite3 ejercicio-35.db < dml/inserts.sql
sqlite3 ejercicio-35.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
