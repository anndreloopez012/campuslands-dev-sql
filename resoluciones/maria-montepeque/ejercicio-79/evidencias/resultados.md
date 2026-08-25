# Evidencias - Ejercicio 79

## Tema

DELETE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-79.db < ddl/schema.sql
sqlite3 ejercicio-79.db < dml/inserts.sql
sqlite3 ejercicio-79.db < dql/consultas.sql
```

## Resultados

Estado final de `ventas` tras `dml/inserts.sql` (10 ventas cargadas,
1 duplicado y 4 del dia con falla de caja eliminados):

```text
id_venta | id_cliente | id_producto | cantidad | fecha_venta
1         | 1            | 1              | 2           | 2026-08-01
2         | 2            | 2              | 1           | 2026-08-01
3         | 3            | 3              | 3           | 2026-08-01
4         | 1            | 4              | 1           | 2026-08-01
5         | 4            | 1              | 1           | 2026-08-01
```

**Caso comentado verificado:**

- `DELETE FROM productos WHERE id_producto = 1;` → `FOREIGN KEY constraint failed` (Cafe Americano todavia tiene ventas del 2026-08-01 asociadas).

**4. Resumen: ventas por fecha:**

```text
fecha_venta    total_ventas
2026-08-01       5
```

**5. Reporte final del caso de negocio (nivel aplicado): total
cobrado por dia:**

```text
fecha_venta    total_dia
2026-08-01       119.0
```

Solo queda el 2026-08-01, con el monto correcto (2x15 + 1x20 + 3x12 +
1x18 + 1x15 = 119.00): el dia con la falla de caja (2026-08-02) ya no
existe, y la venta duplicada del Cafe Americano de Manuel Estrada
tampoco se cuenta.

## Aprendizaje

`DELETE` con `WHERE` por id especifico corrige un error puntual (la
venta duplicada) sin tocar el resto del dia. `DELETE` con `WHERE` por
fecha anula de una sola vez todas las ventas de un dia completo que
quedo invalido por una falla tecnica, sin tener que borrar fila por
fila. El reporte final (consulta 5) es la validacion propia del nivel
aplicado: demuestra, recalculando el total desde cero con
`cantidad * precio`, que despues de los `DELETE` los numeros del
negocio vuelven a ser confiables. El caso comentado confirma que un
producto con ventas activas no se puede borrar de verdad, lo mismo que
se vio con productos e inscripciones en ejercicios anteriores.
