# Ejercicio 31: Normalizacion Ventas Campus

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

La empresa administraba sus ventas en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde `productos_comprados`, `precios` y `cantidades` guardaban varios valores separados por `|` en una misma celda, y los datos del cliente y del vendedor se repetian en cada venta. Esto generaba duplicidad, anomalias de insercion/actualizacion/eliminacion y dificultaba los reportes. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `clientes`: catalogo de clientes (nombre, correo unico).
- `productos`: catalogo de productos con su precio de lista.
- `vendedores`: catalogo de vendedores y su sucursal.
- `ventas`: encabezado de una venta (cliente, vendedor, fecha). `clientes` 1—N `ventas` y `vendedores` 1—N `ventas`.
- `detalle_venta`: linea de producto de una venta (cantidad y precio unitario aplicado). `ventas` 1—N `detalle_venta` y `productos` 1—N `detalle_venta`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 5 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_vendedor`, `detalle_venta.id_venta`, `detalle_venta.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.email`, `productos.nombre`.
- `CHECK`: `productos.precio_unitario > 0`, `detalle_venta.cantidad > 0`, `detalle_venta.precio_unitario > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 clientes, 5 productos, 5 vendedores, 5 ventas, 10 lineas de `detalle_venta`. Las ventas 1-3 (con sus clientes, vendedores y productos) son equivalentes fila por fila al CSV original; se agregaron 2 clientes, 3 vendedores y 2 ventas adicionales solo para cumplir el minimo de datos pedido por el ejercicio.
- La consulta 1 (`JOIN` que reconstruye el archivo original) reproduce exactamente las filas del CSV: por ejemplo, la venta 1 vuelve a mostrar `Ana Perez, ana@mail.com, Mouse Gamer, 125, 1, Luis Rojas, Sede Norte` seguido de `..., Teclado RGB, 260, 2, ...`.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (clientes.email)` y otro por `CHECK (detalle_venta.cantidad > 0)`.

## Como ejecutar

```bash
sqlite3 ejercicio-31.db < ddl/schema.sql
sqlite3 ejercicio-31.db < dml/inserts.sql
sqlite3 ejercicio-31.db < dql/consultas.sql
```
