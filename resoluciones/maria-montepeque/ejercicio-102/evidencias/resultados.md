# Evidencias - Ejercicio 102

## Tema

Procedimientos almacenados

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-102.db < ddl/schema.sql
sqlite3 ejercicio-102.db < dml/inserts.sql
sqlite3 ejercicio-102.db < dql/consultas.sql
```

## Resultados

**4. Total de prestamos por libro (antes de la consulta 5):**

```text
id_libro   total_prestamos
1            1
2            2
```

("Refactoring", id_libro = 3, todavia no tiene ningun prestamo en este
punto del script.)

**5. Prestamo valido sobre un libro con copias disponibles:**

El `INSERT INTO prestamos (id_libro, nombre_prestatario,
fecha_prestamo) VALUES (3, 'Fernando Diaz', '2026-08-06');` paso la
validacion del trigger sin error y quedo registrado:

```text
id_prestamo   id_libro   nombre_prestatario   estado
4               3           Fernando Diaz        prestado
```

**Caso comentado verificado (CHECK):**

- `INSERT INTO libros (id_autor, titulo, stock_total) VALUES (1, 'Libro Fantasma', 0);` → `CHECK constraint failed: stock_total > 0`.

**Caso comentado verificado (trigger bloquea prestamo sin copias disponibles):**

```text
INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo)
VALUES (1, 'Gabriela Soto', '2026-08-07');
```

→ `No hay copias disponibles para este libro` (el error definido en
`RAISE(ABORT, ...)` dentro de `trg_validar_disponibilidad_prestamo`).
"Clean Architecture" tiene `stock_total = 1` y ya tenia 1 prestamo
activo antes de este intento, por lo que su disponibilidad calculada
era `1 - 1 = 0`.

## Aprendizaje

Un procedimiento almacenado no solo sirve para encadenar varios
`INSERT`/`UPDATE` (como en el ejercicio 101): tambien sirve para
validar una regla de negocio ANTES de ejecutar la escritura, y
cancelarla por completo si la regla no se cumple (en MySQL con
`SIGNAL`, en PostgreSQL con `RAISE EXCEPTION`). SQLite no tiene ese
objeto, pero un trigger `BEFORE INSERT` con una clausula `WHEN` y
`RAISE(ABORT, mensaje)` logra el mismo efecto: la condicion se evalua
antes de que la fila nueva se escriba, y si se cumple, la operacion
completa se cancela con un mensaje de error, sin insertar nada. La
diferencia frente a un `CHECK` es que la condicion aqui no depende
solo de las columnas de la fila que se inserta, sino de datos de OTRA
tabla (`libros`) y de un conteo sobre la propia tabla (`prestamos`):
ese tipo de regla, que combina varias tablas, es justamente el tipo de
logica que en un motor con procedimientos almacenados se resolveria
dentro del procedimiento antes del `INSERT`.
