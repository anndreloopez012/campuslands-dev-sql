# Evidencias - Ejercicio 91

## Tema

GROUP BY

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-91.db < ddl/schema.sql
sqlite3 ejercicio-91.db < dml/inserts.sql
sqlite3 ejercicio-91.db < dql/consultas.sql
```

## Resultados

**4. Total de movimientos por producto:**

```text
id_producto   total_movimientos
1               3
2               3
3               2
4               2
5               2
```

**5. Reporte de stock calculado (caso de negocio: productos en sobreventa):**

```text
nombre_producto      stock_inicial   total_entradas   total_salidas   stock_calculado
Mouse Inalambrico         30              10               45              -5
Disco SSD 1TB              15               2               20              -3
```

Verificacion manual: Laptop Pro 15 tiene stock_inicial 10, entradas 5
y salidas 7, stock calculado 8 (no aparece, esta bien); Teclado
Mecanico tiene 20 + 5 - 5 = 20 (no aparece); Laptop Basica 14 tiene
8 + 3 - 2 = 9 (no aparece). Solo Mouse Inalambrico (30 + 10 - 45 = -5)
y Disco SSD 1TB (15 + 2 - 20 = -3) quedan con stock negativo, y son
justo los que devuelve la consulta con `HAVING stock_calculado < 0`.

**Caso comentado verificado (CHECK):**

- `INSERT INTO movimientos (..., cantidad, ...) VALUES (1, 'entrada', 0, '2026-08-13');` → `CHECK constraint failed: cantidad > 0`.

**Caso comentado verificado (WHERE con funcion agregada):**

```text
SELECT id_producto, SUM(cantidad) AS total_salida
FROM movimientos
WHERE tipo_movimiento = 'salida' AND SUM(cantidad) > 40
GROUP BY id_producto;
```

→ `misuse of aggregate: SUM()`. `WHERE` filtra filas individuales
antes de que `GROUP BY` forme los grupos, por lo que todavia no existe
ningun total sobre el cual evaluar `SUM(cantidad) > 40`.

## Aprendizaje

`GROUP BY` agrupa las filas que comparten un mismo valor (aqui,
`id_producto`) para que las funciones de agregacion (`COUNT`, `SUM`)
calculen un resultado por grupo. Combinar `SUM(CASE WHEN ...)` dentro
de un `GROUP BY` permite construir en una sola consulta un reporte de
negocio real (entradas y salidas por producto), y `HAVING` filtra esos
grupos ya calculados, no las filas originales: por eso `HAVING` si
puede comparar contra `stock_calculado` (un valor agregado) mientras
que `WHERE` no puede comparar contra `SUM(cantidad)`, porque en el
momento en que se evalua `WHERE` los movimientos individuales todavia
no se han agrupado ni sumado.
