# Evidencias - Ejercicio 48

## Tema

FOREIGN KEY

## Comandos ejecutados

```bash
sqlite3 ejercicio-48.db < ddl/schema.sql
sqlite3 ejercicio-48.db < dml/inserts.sql
sqlite3 ejercicio-48.db < dql/consultas.sql
```

## Resultados

**5.a Libros por autor (Robert Martin conserva sus 2 libros, protegido por RESTRICT):**

```text
autor           | cantidad_libros
Robert Martin    | 2
Martin Fowler    | 1
Kathy Sierra     | 1
Andrew Hunt      | 1
```

**5.b Efecto de ON DELETE CASCADE tras borrar "Design Patterns" (id_libro = 5) en el DML:**

```text
total_prestamos_tras_cascada
8
```

(10 prestamos originales - 2 de "Design Patterns" eliminados en cascada = 8)

```text
SELECT * FROM prestamos WHERE id_libro = 5;   -- 0 filas: sin huerfanos
```

**Reporte: libros con su autor y cantidad de prestamos:**

```text
libro                       | autor            | veces_prestado
Clean Code                  | Robert Martin     | 2
Refactoring                 | Martin Fowler     | 2
The Pragmatic Programmer    | Andrew Hunt       | 2
Clean Architecture          | Robert Martin     | 1
Head First Java             | Kathy Sierra      | 1
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `DELETE FROM autores WHERE id_autor = 1;` (Robert Martin, con libros en el catalogo) → `FOREIGN KEY constraint failed`.
- `INSERT INTO prestamos (id_libro, ...) VALUES (999, ...);` (libro inexistente) → `FOREIGN KEY constraint failed`.

## Aprendizaje

Este ejercicio mostro que `FOREIGN KEY` no es una restriccion de un solo comportamiento: la clausula `ON DELETE` decide si la base de datos protege el dato relacionado (`RESTRICT`, el comportamiento por defecto) o lo elimina junto con su padre (`CASCADE`). Elegir una u otra depende de si el dato dependiente sigue teniendo sentido cuando su referencia desaparece: el historial de prestamos de un libro dado de baja no aporta valor por si solo, pero el catalogo de libros de un autor si debe protegerse aunque el autor se intente eliminar por error.
