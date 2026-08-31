# Ejercicio 91: GROUP BY Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

GROUP BY

## Descripcion del problema

Una bodega de dispositivos tecnologicos necesita un reporte que
calcule el stock real de cada producto a partir de sus movimientos de
entrada y salida, y que detecte automaticamente los productos que se
vendieron por encima de lo disponible (sobreventa), sin depender de
revisar cada movimiento a mano.

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto.
- `productos`: catalogo de productos, cada uno pertenece a una
  categoria y tiene un `stock_inicial`.
- `movimientos`: tabla principal, cada fila es un movimiento de
  bodega (`entrada` o `salida`) con su `cantidad`.
  `categorias` 1—N `productos`; `productos` 1—N `movimientos`.

## Uso de GROUP BY

En `dql/consultas.sql`:

1. Conteo simple: `GROUP BY id_producto` con `COUNT(*)`, para saber
   cuantos movimientos registro cada producto.
2. Caso de negocio (consulta 5): se agrupan los movimientos por
   producto y se calcula, con `SUM(CASE WHEN ...)`, el total de
   entradas y salidas de cada uno. Con esos totales se obtiene
   `stock_calculado = stock_inicial + entradas - salidas`, y
   `HAVING stock_calculado < 0` filtra solo los productos en
   sobreventa: este es el reporte/validacion final que pide el
   negocio.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `movimientos.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `categorias.nombre_categoria`.
- `CHECK`: `productos.precio_unitario >= 0`,
  `productos.stock_inicial >= 0`, `movimientos.cantidad > 0`,
  `movimientos.tipo_movimiento IN ('entrada', 'salida')`.
- `DEFAULT` en `movimientos.tipo_movimiento`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Filtrar un total agregado usando `WHERE SUM(cantidad) > 40` en vez de
`HAVING`. `WHERE` se evalua fila por fila, antes de que existan los
grupos, por lo que no puede usar una funcion de agregacion como
`SUM()`. Se verifico con Python (`sqlite3`) que SQLite rechaza esa
consulta con el error `misuse of aggregate: SUM()`. El filtro
correcto sobre un valor agregado va en `HAVING`, como en la consulta
5.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-91.db < ddl/schema.sql
sqlite3 ejercicio-91.db < dml/inserts.sql
sqlite3 ejercicio-91.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
