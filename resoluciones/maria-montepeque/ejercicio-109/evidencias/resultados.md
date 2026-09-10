# Evidencias - Ejercicio 109

## Tema

Indices

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-109.db < ddl/schema.sql
sqlite3 ejercicio-109.db < dml/inserts.sql
sqlite3 ejercicio-109.db < dql/consultas.sql
```

## Resultados

**4. Total de unidades de salida por producto:**

```text
id_producto   total_salida
1               5
2               4
3               2
4               1
```

**5. Reporte de negocio: salidas del producto 1, plan de ejecucion (EXPLAIN QUERY PLAN):**

```text
id   parent   notused   detail
3      0         62       SEARCH movimientos USING INDEX idx_movimientos_salida (id_producto=?)
```

El plan confirma que SQLite uso `idx_movimientos_salida` (el indice
parcial) para buscar directamente las salidas del producto 1, en vez
de revisar las 10 filas de la tabla.

**Caso comentado verificado (CHECK):**

- `INSERT INTO movimientos (..., cantidad, ...) VALUES (1, 'salida', 0, '2026-08-11');` → `CHECK constraint failed: cantidad > 0`.

**Caso comentado verificado (reporte de entradas, el indice parcial no aplica):**

```text
EXPLAIN QUERY PLAN
SELECT id_movimiento, cantidad, fecha_movimiento
FROM movimientos
WHERE tipo_movimiento = 'entrada' AND id_producto = 1;
```

```text
id   parent   notused   detail
2      0         216       SCAN movimientos
```

A diferencia de la consulta 5, aqui el plan dice `SCAN movimientos`:
`idx_movimientos_salida` solo contiene filas con `tipo_movimiento =
'salida'`, asi que no tiene ninguna fila de `'entrada'` que ofrecerle
al planificador para esta busqueda.

## Aprendizaje

Un indice parcial (`CREATE INDEX ... WHERE condicion`) es una
herramienta de optimizacion dirigida: en vez de indexar toda la
tabla, solo indexa el subconjunto de filas que realmente se consulta
con frecuencia (aqui, las salidas, para el reporte diario de
reabastecimiento), lo que lo hace mas pequeno y mas rapido de
mantener que un indice completo. La contraparte es que ese indice
deja de existir, en la practica, para cualquier consulta cuya
condicion no sea compatible con el `WHERE` del indice: una busqueda de
entradas no puede usar `idx_movimientos_salida` en absoluto, porque
ninguna fila de entrada esta ahi dentro, y SQLite vuelve a un `SCAN`
completo de la tabla. Por eso un indice parcial solo tiene sentido
cuando el negocio realmente consulta ese subconjunto de datos mucho
mas seguido que el resto, como es el caso de las salidas frente a las
entradas en este inventario.
