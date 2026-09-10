# Evidencias - Ejercicio 100

## Tema

Vistas

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-100.db < ddl/schema.sql
sqlite3 ejercicio-100.db < dml/inserts.sql
sqlite3 ejercicio-100.db < dql/consultas.sql
```

## Resultados

**1. Reporte completo de disponibilidad (vista_disponibilidad_libros):**

```text
id_libro   titulo                      nombre_autor         stock_total   prestamos_activos   copias_disponibles
1            Clean Code                    Robert C. Martin       2               2                    0
2            Design Patterns               Erich Gamma            1               1                    0
3            The Pragmatic Programmer      Robert C. Martin       3               1                    2
4            Refactoring                   Martin Fowler          1               0                    1
```

**5. Reporte de negocio: libros agotados (HAVING/WHERE sobre la vista):**

```text
titulo             nombre_autor        stock_total   prestamos_activos   copias_disponibles
Clean Code            Robert C. Martin       2               2                    0
Design Patterns       Erich Gamma            1               1                    0
```

Verificacion manual: "Clean Code" tiene stock 2 y 2 prestamos activos
(0 disponibles); "Design Patterns" tiene stock 1 y 1 prestamo activo
(0 disponibles); "The Pragmatic Programmer" tiene stock 3 y solo 1
prestamo activo (2 disponibles, no aparece); "Refactoring" no tiene
ningun prestamo (1 disponible, no aparece). Solo los dos primeros
libros quedan en el reporte de agotados.

**Caso comentado verificado (CHECK):**

- `INSERT INTO libros (id_autor, titulo, stock_total) VALUES (1, 'Libro Fantasma', 0);` → `CHECK constraint failed: stock_total > 0`.

**Caso comentado verificado (CREATE VIEW IF NOT EXISTS no reemplaza una vista existente):**

```text
CREATE VIEW IF NOT EXISTS vista_disponibilidad_libros AS
SELECT l.id_libro, l.titulo, l.stock_total
FROM libros l
WHERE l.stock_total <= 1;
```

→ se ejecuta sin ningun error, pero `vista_disponibilidad_libros`
conserva sus columnas y su logica originales (`nombre_autor`,
`prestamos_activos`, `copias_disponibles`, con los mismos 4 libros del
reporte completo), no las de la sentencia nueva. La `CREATE VIEW IF
NOT EXISTS` fue completamente ignorada porque la vista ya existia.

## Aprendizaje

Una vista de negocio puede combinar varias tablas (con `JOIN` y
`LEFT JOIN`, para no perder registros sin relacion) y calcular
columnas derivadas (como `copias_disponibles`), dejando ese calculo
disponible para cualquier reporte que lo necesite con un simple
`WHERE` encima, sin repetir la logica. Al mismo tiempo, SQLite no
soporta `CREATE OR REPLACE VIEW`: usar `CREATE VIEW IF NOT EXISTS`
para intentar cambiar una vista que ya existe no produce ningun error,
pero tampoco actualiza nada, porque la clausula `IF NOT EXISTS` hace
que SQLite ignore por completo la sentencia si el nombre ya esta
tomado. La unica forma correcta de redefinir una vista existente es
eliminarla primero con `DROP VIEW` y despues crearla de nuevo con la
logica actualizada.
