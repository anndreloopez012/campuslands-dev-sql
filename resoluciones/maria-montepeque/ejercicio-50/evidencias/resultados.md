# Evidencias - Ejercicio 50

## Tema

UNIQUE

## Comandos ejecutados

```bash
sqlite3 ejercicio-50.db < ddl/schema.sql
sqlite3 ejercicio-50.db < dml/inserts.sql
sqlite3 ejercicio-50.db < dql/consultas.sql
```

## Resultados

**4. Resumen:**

```text
total_libros | libros_con_isbn | libros_sin_isbn
6            | 4                | 2
```

**5.a Confirmacion de unicidad (mismo numero = sin ISBN repetidos):**

```text
libros_con_isbn | isbn_distintos
4                | 4
```

**5.b Libros sin ISBN, conviviendo sin conflicto (UNIQUE permite varios NULL):**

```text
titulo
Manual interno de Java
Guia rapida de Git
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO libros (isbn, ...) VALUES ('978-0132350884', ...);` (ISBN ya usado por "Clean Code") → `UNIQUE constraint failed: libros.isbn`.
- `INSERT INTO autores (nombre) VALUES ('Robert Martin');` (autor ya existe) → `UNIQUE constraint failed: autores.nombre`.

## Aprendizaje

`UNIQUE` resuelve un problema distinto al de `PRIMARY KEY`: mientras la llave primaria identifica cada fila, `UNIQUE` protege que un dato del negocio (como un ISBN o un nombre de autor) no se repita, sin necesidad de que ese dato sea la llave de la tabla. Su comportamiento con `NULL` es la parte menos intuitiva del tema: varios `NULL` en una columna `UNIQUE` **no** se consideran duplicados entre si, algo que hay que tener presente al decidir si una columna candidata a `UNIQUE` tambien deberia llevar `NOT NULL`.
