# Evidencias - Ejercicio 75

## Tema

UPDATE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-75.db < ddl/schema.sql
sqlite3 ejercicio-75.db < dml/inserts.sql
sqlite3 ejercicio-75.db < dql/consultas.sql
```

## Resultados

Estado final de `productos` tras `dml/inserts.sql` (que incluye los 3
`UPDATE` de validacion):

```text
id_producto | nombre_producto     | id_categoria | precio_unitario | stock_actual
1            | Laptop Pro 14         | 1               | 9350.0             | 15
2            | Laptop Air 13         | 1               | 6820.0             | 8
3            | Mouse Inalambrico     | 2               | 150.0              | 38
4            | Teclado Mecanico      | 2               | 320.0              | 30
5            | Disco SSD 1TB         | 3               | 480.0              | 20
```

**Caso comentado verificado:**

- `UPDATE productos SET stock_actual = stock_actual - 999 WHERE id_producto = 2;` → `CHECK constraint failed: stock_actual >= 0`.

**4. Resumen: movimientos por tipo:**

```text
tipo_movimiento  total
entrada           1
salida            1
```

**5. Validacion especifica de UPDATE:**

```text
nombre_producto      precio_unitario  stock_actual
Laptop Pro 14           9350.0             15
Laptop Air 13           6820.0             8
Mouse Inalambrico       150.0              38
```

Laptop Pro 14: broto con `stock_actual = 10`, el `UPDATE` con
`stock_actual = stock_actual + 5` lo dejo en 15. Mouse Inalambrico:
broto con `stock_actual = 50`, el `UPDATE` con
`stock_actual = stock_actual - 12` lo dejo en 38. Las dos laptops
(Laptop Pro 14 y Laptop Air 13) subieron su precio un 10% con un solo
`UPDATE` multiple filtrado por `id_categoria = 1`
(8500.00 -> 9350.00 y 6200.00 -> 6820.00).

## Aprendizaje

`UPDATE` con una expresion (`columna = columna + n` o
`columna = columna * 1.10`) permite corregir un valor a partir de si
mismo, sin tener que calcular el resultado final antes de escribir la
sentencia. Un `WHERE` sobre una llave foranea
(`WHERE id_categoria = 1`) hace que un solo `UPDATE` afecte a todos
los productos de esa categoria a la vez, sin importar cuantos sean, lo
que es distinto a listar ids especificos con `IN (...)`. El `CHECK` de
`stock_actual >= 0` protege el modelo incluso durante un `UPDATE`: si
el nuevo valor calculado violara la restriccion, la fila no se
modifica, tal como se confirmo con el caso comentado.
