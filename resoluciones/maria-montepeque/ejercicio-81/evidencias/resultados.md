# Evidencias - Ejercicio 81

## Tema

SELECT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-81.db < ddl/schema.sql
sqlite3 ejercicio-81.db < dml/inserts.sql
sqlite3 ejercicio-81.db < dql/consultas.sql
```

## Resultados

**4. Resumen: unidades vendidas por producto:**

```text
nombre_producto     unidades_vendidas
Cafe Americano         4
Cappuccino             1
Te Chai                3
Croissant              1
```

**5a. Productos con precio por encima del promedio del catalogo
(subconsulta, promedio = 16.25):**

```text
nombre_producto     precio
Cappuccino             20.0
Croissant              18.0
```

**5b. Clientes distintos que compraron algo (`COUNT(DISTINCT ...)`):**

```text
clientes_distintos
3
```

**Caso comentado verificado:**

- `SELECT id_producto FROM productos, ventas;` → `ambiguous column name: id_producto` (ambas tablas tienen esa columna y ninguna esta calificada con su alias).

## Aprendizaje

Ademas de alias y expresiones calculadas (nivel basico), este
ejercicio de nivel intermedio demostro dos tecnicas mas de `SELECT`:
una subconsulta (`WHERE precio > (SELECT AVG(precio) FROM productos)`)
que calcula un valor de referencia una sola vez y lo usa para filtrar
el resultado externo, y `COUNT(DISTINCT ...)` para contar valores
unicos sin que las repeticiones inflen el conteo. El caso comentado
muestra un error real y comun al combinar tablas: cuando dos tablas
comparten el nombre de una columna, `SELECT` no puede adivinar de cual
tabla tomarla si no se califica con el alias (`v.id_producto` o
`p.id_producto`).
