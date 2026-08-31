# Evidencias - Ejercicio 86

## Tema

ORDER BY

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-86.db < ddl/schema.sql
sqlite3 ejercicio-86.db < dml/inserts.sql
sqlite3 ejercicio-86.db < dql/consultas.sql
```

## Resultados

**3. Libros ordenados por ejemplares, ascendente (por defecto):**

```text
titulo                                              ejemplares_totales
Clean Architecture                                    1
The Art of Computer Programming Vol. 1                1
Clean Code                                            2
Patterns of Enterprise Application Architecture       2
Refactoring                                           3
```

**5. Orden por dos columnas (categoria ascendente, ejemplares
descendente):**

```text
titulo                                              categoria      ejemplares_totales
The Art of Computer Programming Vol. 1                Algoritmos      1
Refactoring                                           Arquitectura    3
Patterns of Enterprise Application Architecture       Arquitectura    2
Clean Architecture                                    Arquitectura    1
Clean Code                                            Ingenieria      2
```

Dentro del grupo "Arquitectura" (que quedo ordenado alfabeticamente
antes que "Ingenieria"), los libros bajan de 3 a 1 ejemplares: el
segundo criterio de orden solo actua dentro de cada grupo del primero.

**Caso comentado verificado:**

- `SELECT titulo, categoria FROM libros ORDER BY 5;` → `1st ORDER BY term out of range - should be between 1 and 2` (la consulta solo tiene 2 columnas).

Nota: se probo primero un caso con `SELECT DISTINCT ... ORDER BY` de
una columna fuera del resultado, pero en SQLite esa combinacion **si
es valida** (a diferencia de otros motores como PostgreSQL), asi que
se reemplazo por el caso de la posicion fuera de rango, que si falla.

## Aprendizaje

`ORDER BY` ordena ascendente por defecto y descendente con `DESC`.
Cuando se listan varias columnas separadas por coma, cada una puede
tener su propia direccion, y la segunda columna solo desempata dentro
de los grupos que ya formo la primera (no reordena todo el resultado
de nuevo). Ordenar por la posicion numerica de una columna (`ORDER BY
5`) es fragil: si esa posicion no existe en el resultado, la consulta
falla, y aunque existiera, cualquier cambio en el orden de las
columnas del `SELECT` cambiaria el significado del `ORDER BY` sin
avisar. Por eso es mejor ordenar siempre por nombre de columna.
