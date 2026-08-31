# Ejercicio 63: AUTO_INCREMENT Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

Un sistema de ventas de cafeteria necesita generar automaticamente el id
de clientes, productos y ventas, sin que la aplicacion tenga que
calcular el siguiente numero disponible, incluso cuando una venta se
elimina despues de registrada.

## Tablas y relaciones

- `clientes`: catalogo de clientes (nombre, telefono).
- `productos`: catalogo de productos de la cafeteria (nombre, precio).
- `ventas`: venta de un producto a un cliente (cantidad, fecha).
  `clientes` 1—N `ventas`; `productos` 1—N `ventas`.

## Uso de AUTO_INCREMENT

En SQLite el equivalente de `AUTO_INCREMENT` es
`INTEGER PRIMARY KEY AUTOINCREMENT`. Se aplico en las 3 tablas
(`clientes.id_cliente`, `productos.id_producto`, `ventas.id_venta`):
ningun `INSERT` indica el id, SQLite lo asigna solo y de forma creciente.

Para demostrar que el id nunca se reutiliza, incluso en la tabla que
tiene relaciones con otras dos tablas:

1. Se insertan 5 ventas (ids 1 a 5).
2. Se elimina la venta con `id_venta = 3` (Byron Xicay, Pastel de
   Chocolate).
3. Se inserta una venta nueva: recibe el `id_venta = 6`, **no** el 3 que
   quedo libre. `AUTOINCREMENT` usa la tabla interna `sqlite_sequence`
   para recordar el maximo historico de cada tabla, en vez de basarse
   solo en `MAX(id)`.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.telefono`, `productos.nombre`.
- `CHECK`: `productos.precio > 0`, `ventas.cantidad > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla (comentado en `dml/inserts.sql`)

`INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES (1, 999, 1);`
falla porque el `id_producto = 999` no existe (viola la `FOREIGN KEY`).
Se valido ejecutandolo con Python (`sqlite3`): lanza
`IntegrityError: FOREIGN KEY constraint failed`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con Python
(modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en
el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 clientes, 3 productos, 5 ventas (ids 1, 2, 4, 5, 6 --
  el 3 nunca se reutilizo).

## Como ejecutar

```bash
sqlite3 ejercicio-63.db < ddl/schema.sql
sqlite3 ejercicio-63.db < dml/inserts.sql
sqlite3 ejercicio-63.db < dql/consultas.sql
```
