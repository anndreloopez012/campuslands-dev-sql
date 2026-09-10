# Ejercicio 93: HAVING Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

HAVING

## Descripcion del problema

Una bodega de dispositivos tecnologicos necesita saber que categorias
de producto estan vendiendo mas: especificamente, cuales categorias
acumulan mas de 30 unidades de salida entre todos sus productos, para
priorizar reabastecimiento.

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto.
- `productos`: catalogo de productos, cada uno pertenece a una
  categoria.
- `movimientos`: tabla principal, cada fila es un movimiento de
  bodega (`entrada` o `salida`) con su `cantidad`.
  `categorias` 1—N `productos`; `productos` 1—N `movimientos`.

## Uso de HAVING

En `dql/consultas.sql`:

1. Conteo simple (consulta 4): se unen las 3 tablas y se agrupa por
   categoria con `COUNT(*)`, sin filtrar todavia los grupos.
2. Validacion especifica de `HAVING` (consulta 5): primero `WHERE
   tipo_movimiento = 'salida'` deja solo los movimientos de salida
   (filtro por fila, antes de agrupar), luego `GROUP BY id_categoria`
   agrupa esas salidas por categoria a traves del `JOIN`
   productos-movimientos, y `HAVING SUM(cantidad) > 30` filtra los
   grupos resultantes, quedandose solo con "Perifericos" (33 unidades
   de salida entre Mouse Inalambrico y Teclado Mecanico).

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `movimientos.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `categorias.nombre_categoria`.
- `CHECK`: `productos.precio_unitario >= 0`,
  `movimientos.cantidad > 0`,
  `movimientos.tipo_movimiento IN ('entrada', 'salida')`.
- `DEFAULT` en `movimientos.tipo_movimiento`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Escribir la clausula `HAVING` antes que `GROUP BY`. El orden de
clausulas en SQL es fijo (`SELECT ... FROM ... WHERE ... GROUP BY ...
HAVING ... ORDER BY`), y `HAVING` depende de los grupos que arma
`GROUP BY`, por lo que no puede evaluarse antes de que estos existan.
Se verifico con Python (`sqlite3`) que SQLite rechaza la consulta con
el error `near "GROUP": syntax error`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-93.db < ddl/schema.sql
sqlite3 ejercicio-93.db < dml/inserts.sql
sqlite3 ejercicio-93.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
