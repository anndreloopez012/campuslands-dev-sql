# Evidencias - Ejercicio 83

## Tema

WHERE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-83.db < ddl/schema.sql
sqlite3 ejercicio-83.db < dml/inserts.sql
sqlite3 ejercicio-83.db < dql/consultas.sql
```

## Resultados

**2. Productos cuyo nombre empieza con "Ca" (`LIKE 'Ca%'`):**

```text
nombre_producto     precio
Cafe Americano        15.0
Cappuccino            20.0
```

**Caso comentado verificado:**

- `SELECT * FROM productos WHERE preci > 15;` → `no such column: preci` (falta la "o" en `precio`).

**5. Filtro combinado (numero + fecha + operador logico IN):**

```text
id_venta | nombre_cliente     | nombre_producto | precio | fecha_venta
4         | Manuel Estrada       | Croissant          | 18.0      | 2026-08-02
```

Solo la venta 4 cumple las tres condiciones a la vez: producto con
precio entre 12 y 18 (Croissant, 18.00), fecha desde el 2026-08-02 en
adelante, y cliente entre los ids 1 o 2 (Manuel Estrada). Las demas
ventas quedan fuera porque fallan al menos una condicion (por ejemplo,
la venta 2 es de Cappuccino a 20.00, fuera del rango de precio).

## Aprendizaje

`WHERE` filtra con distintos tipos de dato y distintos operadores en
una sola condicion: texto con `LIKE` y comodines (`%`), numeros con
`BETWEEN`, fechas simuladas como texto ISO comparadas con `>=`
(funciona porque `'2026-08-02'` ordena igual como texto que como
fecha), y varias condiciones combinadas con `AND` e `IN`. Cuando se
combinan varias condiciones con `AND`, una fila solo aparece en el
resultado si cumple todas a la vez, lo que reduce el resultado a un
subconjunto muy especifico. El caso comentado recuerda que un error de
escritura en el nombre de una columna dentro de `WHERE` tambien hace
fallar la consulta completa.
