# Evidencias - Ejercicio 47

## Tema

FOREIGN KEY

## Comandos ejecutados

```bash
sqlite3 ejercicio-47.db < ddl/schema.sql
sqlite3 ejercicio-47.db < dml/inserts.sql
sqlite3 ejercicio-47.db < dql/consultas.sql
```

## Resultados

**5.a Todas las ventas tienen referencias validas:**

```text
total_ventas | ventas_con_referencias_validas
10           | 10
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO ventas (..., id_producto, ...) VALUES (..., 999, ...);` (producto inexistente) → `FOREIGN KEY constraint failed`.
- `DELETE FROM productos WHERE id_producto = 1;` (referenciado por varias ventas) → `FOREIGN KEY constraint failed`.

## Aprendizaje

Una `FOREIGN KEY` no es solo una anotacion sobre como se relacionan las tablas: es una restriccion activa que SQLite hace cumplir (una vez activada con `PRAGMA foreign_keys = ON;`) tanto al insertar como al eliminar. Sin ella, seria responsabilidad exclusiva de la aplicacion evitar referencias invalidas; con ella, la base de datos misma se encarga, y el resultado se puede verificar directamente comparando el total de filas contra el total de filas con `JOIN` exitoso.
