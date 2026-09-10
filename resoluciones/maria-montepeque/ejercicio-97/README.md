# Ejercicio 97: JOIN Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

JOIN

## Descripcion del problema

Una cafeteria necesita un reporte final de ingresos por producto que
incluya TODO el catalogo, incluso los productos que todavia no se han
vendido, para poder decidir si vale la pena mantenerlos en el menu.

## Tablas y relaciones

- `clientes`: catalogo de clientes.
- `productos`: catalogo de productos del menu.
- `ventas`: tabla principal, cada fila es una venta de un producto a
  un cliente, con su `cantidad`. `clientes` 1—N `ventas`; `productos`
  1—N `ventas`.

## Uso de JOIN

En `dql/consultas.sql`:

1. `INNER JOIN` de 3 tablas (consulta 1): combina cada venta con el
   nombre del cliente y del producto.
2. Caso de negocio con `LEFT JOIN` (consulta 5): parte de `productos`
   (tabla izquierda) con `LEFT JOIN` hacia `ventas`, agrupa por
   producto y calcula `SUM(cantidad * precio_unitario)` envuelto en
   `COALESCE(..., 0)` (porque `SUM` sobre un grupo sin ventas da
   `NULL`, no `0`). El resultado es el reporte completo que pide el
   negocio: los 4 productos del catalogo, con "Muffin de Arandanos"
   mostrando `total_facturado = 0` en vez de desaparecer.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `clientes.email`, `productos.nombre_producto`.
- `CHECK`: `productos.precio_unitario >= 0`, `ventas.cantidad > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

El mismo reporte de ingresos por producto, pero usando `INNER JOIN` en
vez de `LEFT JOIN`. Al no existir ninguna venta que combine con
"Muffin de Arandanos", el `INNER JOIN` descarta esa fila por completo
en vez de mostrarla con `total_facturado = 0`. Se verifico con Python
(`sqlite3`) que esta version del reporte devuelve solo 3 productos en
vez de los 4 del catalogo, ocultandole al negocio que existe un
producto que nunca se ha vendido.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-97.db < ddl/schema.sql
sqlite3 ejercicio-97.db < dml/inserts.sql
sqlite3 ejercicio-97.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
