# Ejercicio 75: UPDATE Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

UPDATE

## Descripcion del problema

Una bodega de dispositivos tecnologicos necesita mantener actualizado
el stock y el precio de sus productos a medida que ocurren
movimientos y cambios de mercado, sin perder el registro de cada
movimiento individual.

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto.
- `productos`: catalogo de productos, con su propio `stock_actual`
  como columna (a diferencia de un modelo basado solo en historial).
- `movimientos`: historial de entradas y salidas de bodega.
  `categorias` 1—N `productos`; `productos` 1—N `movimientos`.

## Uso de UPDATE

En `dml/inserts.sql`:

1. `UPDATE` de una sola fila con expresion: al registrar un
   reabastecimiento de Laptop Pro 14, `stock_actual = stock_actual + 5`
   suma la cantidad recibida al stock existente.
2. `UPDATE` de una sola fila con expresion: al registrar una venta de
   Mouse Inalambrico, `stock_actual = stock_actual - 12` resta la
   cantidad vendida.
3. `UPDATE` multiple: un ajuste de precios del 10% se aplica con un
   solo `UPDATE` a todos los productos de la categoria Laptops
   (`WHERE id_categoria = 1`), sin listar cada `id_producto` a mano.

La consulta 5 en `dql/consultas.sql` confirma el `stock_actual` y el
`precio_unitario` finales de los 3 productos afectados.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `movimientos.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `categorias.nombre_categoria`, `productos.nombre_producto`.
- `CHECK`: `productos.precio_unitario >= 0`,
  `productos.stock_actual >= 0`, `movimientos.tipo_movimiento IN (...)`,
  `movimientos.cantidad > 0`.
- `DEFAULT` en `productos.stock_actual`, `movimientos.tipo_movimiento`
  y `fecha_movimiento`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dml/inserts.sql`)

`UPDATE productos SET stock_actual = stock_actual - 999 WHERE id_producto = 2;`
falla porque el resultado quedaria negativo, y eso viola el `CHECK` de
`stock_actual >= 0`. Se valido con Python (`sqlite3`): lanza
`CHECK constraint failed`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: Laptop Pro 14 con stock 15 y precio $9,350.00; Mouse
  Inalambrico con stock 38; Laptop Air 13 con precio $6,820.00.

## Como ejecutar

```bash
sqlite3 ejercicio-75.db < ddl/schema.sql
sqlite3 ejercicio-75.db < dml/inserts.sql
sqlite3 ejercicio-75.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
