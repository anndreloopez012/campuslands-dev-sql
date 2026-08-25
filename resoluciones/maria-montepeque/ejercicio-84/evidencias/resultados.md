# Evidencias - Ejercicio 84

## Tema

WHERE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-84.db < ddl/schema.sql
sqlite3 ejercicio-84.db < dml/inserts.sql
sqlite3 ejercicio-84.db < dql/consultas.sql
```

## Resultados

**2. Libros que NO son de Arquitectura, con mas de 1 ejemplar o de
Algoritmos:**

```text
titulo                                    categoria    ejemplares_totales
Clean Code                                  Ingenieria     2
The Art of Computer Programming Vol. 1      Algoritmos     1
```

**4. Prestamos activos vs. devueltos (`IS NULL` / `IS NOT NULL`):**

```text
activos    devueltos
5            2
```

**5. Prestamos activos de libros de categoria Arquitectura
(subconsulta dentro de `WHERE ... IN`):**

```text
id_prestamo | nombre_prestatario | fecha_prestamo
4             | Fernanda Lopez       | 2026-08-02
6             | Priscila Ajanel      | 2026-08-06
7             | Bryan Solis          | 2026-08-07
```

**Caso comentado verificado:**

- `SELECT * FROM libros WHERE (categoria = 'Arquitectura' AND ejemplares_totales > 1;` → `near ";": syntax error` (falta el parentesis de cierre).

## Aprendizaje

Ademas de `LIKE`, `BETWEEN` y fechas simuladas (nivel basico), este
ejercicio de nivel intermedio demostro `<>` (negacion), agrupacion de
condiciones con parentesis para controlar el orden en que se evaluan
`AND`/`OR`, `IS NULL`/`IS NOT NULL` para distinguir prestamos activos
de devueltos, y una subconsulta dentro de `WHERE ... IN (...)` que
primero filtra los libros de una categoria y despues usa esa lista
para filtrar los prestamos. El caso comentado muestra un error de
sintaxis muy comun: un parentesis que se abre pero nunca se cierra
rompe toda la consulta.
