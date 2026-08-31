# Evidencias - Ejercicio 95

## Tema

JOIN

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-95.db < ddl/schema.sql
sqlite3 ejercicio-95.db < dml/inserts.sql
sqlite3 ejercicio-95.db < dql/consultas.sql
```

## Resultados

**1. INNER JOIN productos + categorias (5 filas, solo categorias con productos):**

```text
id_producto   nombre_producto      nombre_categoria   precio_unitario
1               Laptop Pro 15         Laptops             8500.0
2               Mouse Inalambrico     Perifericos          120.0
3               Teclado Mecanico      Perifericos          250.0
4               Disco SSD 1TB         Almacenamiento       450.0
5               Laptop Basica 14      Laptops             4200.0
```

**5. LEFT JOIN categorias -> productos (6 filas, incluye "Redes" sin productos):**

```text
nombre_categoria   nombre_producto      precio_unitario
Almacenamiento      Disco SSD 1TB           450.0
Laptops             Laptop Basica 14       4200.0
Laptops             Laptop Pro 15          8500.0
Perifericos         Mouse Inalambrico       120.0
Perifericos         Teclado Mecanico        250.0
Redes                (NULL)                 (NULL)
```

Verificacion manual: "Redes" no tiene ningun producto en
`dml/inserts.sql`, y aun asi aparece en el `LEFT JOIN` con las
columnas de `productos` en `NULL`; con el `INNER JOIN` de la consulta
1 esa categoria no aparece en absoluto.

**Caso comentado verificado (CHECK):**

- `INSERT INTO productos (..., precio_unitario) VALUES (1, 'Laptop Danada', -100.00);` → `CHECK constraint failed: precio_unitario >= 0`.

**Caso comentado verificado (JOIN implicito sin condicion, producto cartesiano):**

```text
SELECT p.nombre_producto, c.nombre_categoria
FROM productos p, categorias c;
```

→ 20 filas (5 productos x 4 categorias), en vez de las 5 filas
correctas de la consulta 1. Cada producto se combino con las 4
categorias, sin importar la que le corresponde de verdad.

## Aprendizaje

`INNER JOIN` solo conserva las filas que tienen coincidencia en ambas
tablas segun la condicion `ON`; por eso una categoria sin productos
desaparece del resultado. `LEFT JOIN` conserva todas las filas de la
tabla de la izquierda (la que se escribe primero), y rellena con
`NULL` las columnas de la tabla derecha cuando no hay coincidencia,
por lo que es la herramienta correcta cuando se necesita ver "todo lo
de un lado, tenga o no relacion". Ademas, la condicion de union (`ON`)
no es opcional en la practica: omitirla (o usar la sintaxis antigua
con coma sin `WHERE`) no produce un error en SQLite, pero genera un
producto cartesiano que combina cada fila de una tabla con todas las
de la otra, multiplicando el numero de filas y mezclando datos que no
tienen relacion real entre si.
