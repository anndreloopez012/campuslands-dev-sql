# Evidencias - Ejercicio 77

## Tema

DELETE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-77.db < ddl/schema.sql
sqlite3 ejercicio-77.db < dml/inserts.sql
sqlite3 ejercicio-77.db < dql/consultas.sql
```

## Resultados

Estado final tras `dml/inserts.sql` (que incluye el `DELETE` real y la
baja logica de validacion):

```text
movimientos (5 filas, ya sin el duplicado):
id_movimiento | id_producto | tipo_movimiento | cantidad
1               | 1              | entrada           | 10
2               | 2              | entrada           | 8
3               | 3              | entrada           | 50
4               | 4              | entrada           | 30
5               | 5              | entrada           | 20

productos:
id_producto | nombre_producto     | activo
1            | Laptop Pro 14         | 1
2            | Laptop Air 13         | 1
3            | Mouse Inalambrico     | 1
4            | Teclado Mecanico      | 0
5            | Disco SSD 1TB         | 1
```

**Caso comentado verificado:**

- `DELETE FROM productos WHERE id_producto = 4;` → `FOREIGN KEY constraint failed` (Teclado Mecanico todavia tiene un movimiento asociado).

**5. Validacion especifica de DELETE:**

```text
5a. Movimiento id_movimiento = 6: 0 filas -- el duplicado se elimino.
5b. Movimientos de Mouse Inalambrico (id_producto = 3): 1 -- solo el
    movimiento real, no el duplicado que se borro.
```

## Aprendizaje

`DELETE` con `WHERE` por id especifico elimina exactamente la fila
equivocada sin arriesgar el resto de movimientos del mismo producto.
Pero `DELETE` no siempre es la herramienta correcta: cuando otras
filas dependen de un registro por `FOREIGN KEY` (como los movimientos
de Teclado Mecanico), SQLite rechaza el `DELETE` fisico, tal como se
confirmo con el caso comentado. Ahi es donde tiene sentido la baja
logica: en vez de borrar el producto, se marca `activo = 0` con
`UPDATE`, conservando el historial de movimientos intacto mientras el
producto deja de aparecer como disponible.
