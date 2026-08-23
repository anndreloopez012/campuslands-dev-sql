# Ejercicio 40: Normalizacion Integrador Avanzado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Descripcion del problema

La empresa administraba sus operaciones de venta en un archivo plano (`datos/datos-sin-normalizar.csv`) con dos grupos repetidos independientes en la misma fila: la lista de productos comprados, y el conjunto de pagos/cuotas/entregas/estados de la operacion. El detalle completo del analisis (dependencias funcionales, identificacion de los dos hechos multivaluados, el proceso de normalizacion 1FN -> 2FN -> 3FN, y la discusion sobre si `movimientos` requiere descomposicion 4FN adicional) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `clientes`: catalogo de clientes.
- `vendedores`: catalogo de vendedores.
- `productos`: catalogo de productos.
- `operaciones`: encabezado de cada operacion (cliente y vendedor). `clientes` 1—N `operaciones` y `vendedores` 1—N `operaciones`.
- `detalle_producto`: primer hecho multivaluado — productos comprados en la operacion. `operaciones` 1—N `detalle_producto` y `productos` 1—N `detalle_producto`.
- `movimientos`: segundo hecho multivaluado, independiente del primero — cada evento de pago con su cuota, zona de entrega y estado. `operaciones` 1—N `movimientos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 6 tablas.
- `FOREIGN KEY`: `operaciones.id_cliente/id_vendedor`, `detalle_producto.id_operacion/id_producto`, `movimientos.id_operacion`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.nombre`, `vendedores.nombre`, `productos.nombre`, `(id_operacion, id_producto)` en `detalle_producto`.
- `CHECK`: `movimientos.metodo_pago IN (...)`, `movimientos.cuotas >= 0`, `movimientos.estado IN (...)`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 clientes, 5 vendedores, 6 productos (catalogos), 6 operaciones, 12 lineas de `detalle_producto`, 8 de `movimientos`.
- La consulta 1 (`JOIN` con subconsultas `GROUP_CONCAT`) reconstruye **exactamente** las 3 filas del CSV original, incluyendo el caso con dos productos y dos movimientos (operacion 1) y los casos con dos productos pero un solo movimiento (operaciones 2 y 3) — confirmando que `productos` y `movimientos` son hechos independientes, no alineados por posicion.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (clientes.nombre)` y otro por `CHECK (cuotas >= 0)`.

## Como ejecutar

```bash
sqlite3 ejercicio-40.db < ddl/schema.sql
sqlite3 ejercicio-40.db < dml/inserts.sql
sqlite3 ejercicio-40.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
