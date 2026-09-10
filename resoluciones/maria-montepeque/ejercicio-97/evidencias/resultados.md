# Evidencias - Ejercicio 97

## Tema

JOIN

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-97.db < ddl/schema.sql
sqlite3 ejercicio-97.db < dml/inserts.sql
sqlite3 ejercicio-97.db < dql/consultas.sql
```

## Resultados

**4. Total de ventas (transacciones) por cliente:**

```text
id_cliente   total_ventas
1              2
2              2
3              2
```

**5. Reporte de negocio: ingresos por producto, catalogo completo (LEFT JOIN):**

```text
nombre_producto        total_facturado
Cafe Americano              75.0
Cafe Latte                   60.0
Croissant                    36.0
Muffin de Arandanos           0
```

Verificacion manual: Cafe Americano vendio 2+3=5 unidades a 15.00 =
75.0; Cafe Latte vendio 1+2=3 unidades a 20.00 = 60.0; Croissant
vendio 2+1=3 unidades a 12.00 = 36.0; Muffin de Arandanos no tiene
ninguna venta registrada y aparece con `total_facturado = 0` gracias a
`COALESCE`.

**Caso comentado verificado (CHECK):**

- `INSERT INTO ventas (..., cantidad, ...) VALUES (1, 1, 0, '2026-08-06');` → `CHECK constraint failed: cantidad > 0`.

**Caso comentado verificado (reporte con INNER JOIN, pierde el producto sin ventas):**

```text
SELECT p.nombre_producto,
       SUM(v.cantidad * p.precio_unitario) AS total_facturado
FROM productos p
INNER JOIN ventas v ON v.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre_producto
ORDER BY total_facturado DESC;
```

```text
nombre_producto      total_facturado
Cafe Americano            75.0
Cafe Latte                 60.0
Croissant                  36.0
```

Solo 3 productos, no 4: "Muffin de Arandanos" desaparece por completo
del reporte porque no hay ninguna fila de `ventas` que combine con el
en un `INNER JOIN`, en vez de aparecer con `total_facturado = 0` como
en la consulta 5.

## Aprendizaje

Cuando un reporte de negocio necesita mostrar TODO un catalogo (aqui,
todos los productos), aunque algunos elementos todavia no tengan
actividad relacionada (ventas), `LEFT JOIN` desde la tabla del
catalogo es la herramienta correcta: conserva cada fila del catalogo
aunque no tenga coincidencia, y `SUM` sobre las filas ausentes da
`NULL`, por lo que conviene envolverlo en `COALESCE(..., 0)` para que
el reporte muestre un total real de 0 en vez de un vacio. Usar
`INNER JOIN` en ese mismo reporte no genera ningun error, pero borra
silenciosamente del resultado a cualquier elemento del catalogo sin
actividad, lo cual puede ocultarle al negocio informacion importante
(por ejemplo, que un producto nunca se vendio).
