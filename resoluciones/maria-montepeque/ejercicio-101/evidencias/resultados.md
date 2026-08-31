# Evidencias - Ejercicio 101

## Tema

Procedimientos almacenados

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-101.db < ddl/schema.sql
sqlite3 ejercicio-101.db < dml/inserts.sql
sqlite3 ejercicio-101.db < dql/consultas.sql
```

## Resultados

**4. Total de unidades vendidas por producto:**

```text
id_producto   total_vendido
1               7
2               3
3               4
```

**5. Stock final por producto (descontado automaticamente por el trigger):**

```text
id_producto   nombre_producto   stock
1               Cafe Americano     43
2               Cafe Latte         27
3               Croissant          16
```

Verificacion manual: Cafe Americano partio con stock 50 y vendio 5+2=7
unidades -> 50-7=43; Cafe Latte partio con 30 y vendio 3 -> 30-3=27;
Croissant partio con 20 y vendio 4 -> 20-4=16. Los tres coinciden
exactamente con el resultado de la consulta 5, y en ningun momento
`dml/inserts.sql` escribio un `UPDATE` sobre `productos`: todo el
descuento lo hizo `trg_actualizar_stock_venta` en automatico.

**Caso comentado verificado (CHECK):**

- `INSERT INTO ventas (..., cantidad, ...) VALUES (1, 'Cliente Fantasma', 0, '2026-08-05');` → `CHECK constraint failed: cantidad > 0`.

**Caso comentado verificado (CREATE PROCEDURE en SQLite):**

```text
CREATE PROCEDURE registrar_venta (IN p_id_producto INT, IN p_cantidad INT)
BEGIN
    UPDATE productos SET stock = stock - p_cantidad WHERE id_producto = p_id_producto;
END;
```

→ `near "PROCEDURE": syntax error`.

## Aprendizaje

Un procedimiento almacenado encapsula varios pasos de logica de
negocio (aqui, insertar una venta y descontar el stock) bajo un
nombre reutilizable que se invoca con `CALL`, algo que SQLite
simplemente no implementa como objeto de base de datos: intentar
`CREATE PROCEDURE` falla con un error de sintaxis porque esa palabra
clave no existe en su gramatica. Sin embargo, el objetivo practico de
"que dos pasos relacionados siempre ocurran juntos, sin que quien
escribe el primero tenga que acordarse del segundo" si se puede lograr
en SQLite con un `TRIGGER`: en vez de que alguien "llame" a un
procedimiento con parametros, el trigger se dispara solo cada vez que
ocurre el evento base (aqui, un `INSERT` en `ventas`), y ejecuta el
resto de la logica automaticamente. No son lo mismo (un trigger
reacciona a un evento, un procedimiento se invoca explicitamente), pero
en un motor sin procedimientos almacenados, el trigger es la
herramienta mas cercana para no repetir logica de negocio de varios
pasos en cada lugar del codigo que la necesita.
