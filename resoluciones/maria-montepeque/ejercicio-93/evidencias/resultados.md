# Evidencias - Ejercicio 93

## Tema

HAVING

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-93.db < ddl/schema.sql
sqlite3 ejercicio-93.db < dml/inserts.sql
sqlite3 ejercicio-93.db < dql/consultas.sql
```

## Resultados

**4. Total de movimientos por categoria:**

```text
id_categoria   nombre_categoria   total_movimientos
1                Laptops              4
2                Perifericos          4
3                Almacenamiento       2
```

**5. Categorias con mas de 30 unidades de salida (HAVING):**

```text
nombre_categoria   total_unidades_salida
Perifericos              33
```

Verificacion manual: Laptops acumula 12 (Laptop Pro 15) + 10 (Laptop
Basica 14) = 22 unidades de salida; Perifericos acumula 25 (Mouse
Inalambrico) + 8 (Teclado Mecanico) = 33; Almacenamiento acumula 15
(Disco SSD 1TB). Solo Perifericos supera el umbral de 30 y por eso es
la unica que aparece en el resultado.

**Caso comentado verificado (CHECK):**

- `INSERT INTO movimientos (..., cantidad, ...) VALUES (1, 'salida', -5, '2026-08-15');` → `CHECK constraint failed: cantidad > 0`.

**Caso comentado verificado (HAVING antes de GROUP BY):**

```text
SELECT id_producto, SUM(cantidad) AS total_salida
FROM movimientos
HAVING SUM(cantidad) > 30
GROUP BY id_producto;
```

→ `near "GROUP": syntax error`. El orden de las clausulas en SQL es
fijo; `HAVING` debe ir despues de `GROUP BY`, nunca antes.

## Aprendizaje

`HAVING` filtra los grupos que ya arma `GROUP BY`, por lo que
sintacticamente debe escribirse despues de esa clausula (y despues de
`WHERE`, si existe): el orden `SELECT ... FROM ... WHERE ... GROUP BY
... HAVING ... ORDER BY` no es opcional. En un modelo de 3 tablas, se
puede filtrar con `WHERE` las filas base (por ejemplo, solo los
movimientos de salida) antes de agrupar, y despues usar `HAVING` sobre
una funcion de agregacion calculada a traves del `JOIN` (como
`SUM(cantidad)` por categoria) para quedarse solo con los grupos que
cumplen una condicion de negocio, en este caso, las categorias que
vendieron mas de 30 unidades.
