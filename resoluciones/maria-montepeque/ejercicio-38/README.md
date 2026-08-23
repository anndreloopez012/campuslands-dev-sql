# Ejercicio 38: Normalizacion Ecommerce Envios

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Descripcion del problema

La tienda administraba sus ordenes en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde `productos` guardaba varios valores separados por `|`, el pago y el envio estaban mezclados con los datos del comprador, y la ausencia de cupon se representaba con el texto `SIN_CUPON` en vez de un valor nulo. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `compradores`: catalogo de compradores.
- `productos`: catalogo de productos con su precio.
- `cupones`: catalogo de cupones.
- `ordenes`: encabezado de una orden (comprador y cupon opcional). `compradores` 1—N `ordenes` y `cupones` 1—N `ordenes` (opcional).
- `detalle_orden`: detalle de cada producto comprado en una orden (relacion N:M entre `ordenes` y `productos`, con cantidad y precio aplicado).
- `pagos`: metodo y monto pagado de una orden (relacion 1 a 1 con `ordenes`).
- `envios`: direccion y transportadora del envio de una orden (relacion 1 a 1 con `ordenes`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 7 tablas.
- `FOREIGN KEY`: `ordenes.id_comprador`, `ordenes.id_cupon` (nullable), `detalle_orden.id_orden/id_producto`, `pagos.id_orden`, `envios.id_orden`.
- `NOT NULL` en todos los campos obligatorios (`ordenes.id_cupon` es la unica excepcion intencional, para representar "sin cupon").
- `UNIQUE`: `compradores.nombre`, `productos.nombre`, `cupones.codigo`, `(id_orden, id_producto)` en `detalle_orden`, `pagos.id_orden`, `envios.id_orden`.
- `CHECK`: `productos.precio > 0`, `detalle_orden.cantidad > 0`, `detalle_orden.precio_unitario > 0`, `pagos.metodo_pago IN (...)`, `pagos.monto > 0`, `envios.transportadora IN (...)`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 compradores, 5 productos, 5 cupones (catalogos), 6 ordenes, 12 lineas de `detalle_orden`, 6 pagos, 6 envios.
- La consulta 1 (`JOIN` con subconsulta `GROUP_CONCAT`) reconstruye el CSV original, incluyendo el texto `SIN_CUPON` para la orden 2 (que en la base tiene `id_cupon = NULL`).
- Productos con mas unidades vendidas (consulta 8): `Mouse` y `Audifonos`, con 4 unidades cada uno.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (cupones.codigo)` y otro por `CHECK (cantidad > 0)`.

## Como ejecutar

```bash
sqlite3 ejercicio-38.db < ddl/schema.sql
sqlite3 ejercicio-38.db < dml/inserts.sql
sqlite3 ejercicio-38.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
