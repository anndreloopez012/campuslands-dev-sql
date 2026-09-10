# Ejercicio 109: Indices Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Indices

## Descripcion del problema

Una bodega de dispositivos tecnologicos necesita, como reporte diario
de negocio, ver rapido las salidas recientes de cada producto (para
decidir reabastecimiento). Las entradas se consultan mucho menos
seguido, asi que indexarlas tambien seria gastar espacio sin
necesidad real.

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto.
- `productos`: catalogo de productos, con su categoria.
- `movimientos`: tabla principal, cada fila es un movimiento de
  bodega (`entrada` o `salida`). `categorias` 1—N `productos`;
  `productos` 1—N `movimientos`.

## Uso de Indices

En `ddl/schema.sql` se crea `idx_movimientos_salida`, un **indice
parcial**: `CREATE INDEX ... ON movimientos (id_producto,
fecha_movimiento) WHERE tipo_movimiento = 'salida'`. Un indice parcial
solo incluye las filas que cumplen su condicion `WHERE`, en vez de
toda la tabla. En `dql/consultas.sql`:

- La consulta 5 es el reporte de negocio final: busca las salidas del
  producto 1 (`WHERE tipo_movimiento = 'salida' AND id_producto =
  1`) y `EXPLAIN QUERY PLAN` confirma `SEARCH movimientos USING INDEX
  idx_movimientos_salida (id_producto=?)`, en vez de `SCAN
  movimientos`: el indice parcial es exactamente lo que este reporte
  necesita, sin gastar espacio indexando las entradas.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `movimientos.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `categorias.nombre_categoria`, `productos.nombre_producto`.
- `CHECK`: `productos.precio_unitario >= 0`, `movimientos.cantidad >
  0`, `movimientos.tipo_movimiento IN ('entrada', 'salida')`.
- `DEFAULT` en `movimientos.tipo_movimiento`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Esperar que `idx_movimientos_salida` tambien acelere un reporte de
ENTRADAS del mismo producto (`WHERE tipo_movimiento = 'entrada' AND
id_producto = 1`). Un indice parcial solo cubre las filas que cumplen
su condicion `WHERE` (aqui, `tipo_movimiento = 'salida'`); las filas
de entrada simplemente no estan en el indice. Se verifico con Python
(`sqlite3`) que el `EXPLAIN QUERY PLAN` de esa consulta (identica a la
5, pero con `'entrada'`) muestra `SCAN movimientos`, no `SEARCH ...
USING INDEX idx_movimientos_salida`, porque no hay ninguna fila de
entrada en ese indice que buscar.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-109.db < ddl/schema.sql
sqlite3 ejercicio-109.db < dml/inserts.sql
sqlite3 ejercicio-109.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
