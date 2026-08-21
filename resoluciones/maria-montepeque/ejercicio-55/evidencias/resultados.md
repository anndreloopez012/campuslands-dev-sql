# Evidencias - Ejercicio 55

## Tema

NOT NULL

## Comandos ejecutados

```bash
sqlite3 ejercicio-55.db < ddl/schema.sql
sqlite3 ejercicio-55.db < dml/inserts.sql
sqlite3 ejercicio-55.db < dql/consultas.sql
```

## Resultados

**4. Reporte final del caso de negocio: stock actual por producto (entradas menos salidas):**

```text
sku      | nombre_producto      | stock_actual
ACC-001  | Mochila para laptop  | 0
LAP-001  | Laptop Pro 14        | 15
LAP-002  | Laptop Basica 15     | 12
MON-001  | Monitor 24 pulgadas  | 20
MON-002  | Monitor 27 pulgadas  | 10
PER-001  | Teclado mecanico     | 35
PER-002  | Mouse inalambrico    | 0
```

`PER-002` aparece con stock 0 porque nunca tuvo movimientos (el `LEFT JOIN` lo incluye igual, y `COALESCE` evita que el total quede en `NULL`). `ACC-001` tambien queda en 0 porque entraron 25 y salieron 25.

**5.a Campo obligatorio (cantidad): ningun movimiento queda sin cantidad:**

```text
total_movimientos | movimientos_con_cantidad
12                  | 12
```

**5.b Campo opcional (observaciones): es normal que falten valores:**

```text
total_movimientos | movimientos_con_observaciones | movimientos_sin_observaciones
12                  | 3                              | 9
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO productos (id_categoria, sku, nombre_producto) VALUES (1, 'LAP-003', NULL);` → `NOT NULL constraint failed: productos.nombre_producto`.
- `INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES (1, 'entrada', NULL, '2026-08-01 10:00');` → `NOT NULL constraint failed: movimientos.cantidad`.

## Aprendizaje

En un caso de negocio real (inventario de bodega), `NOT NULL` es lo que hace confiable un reporte agregado. El reporte de stock (consulta 4) suma y resta `cantidad` de todos los movimientos; si `cantidad` pudiera ser `NULL`, `SUM()` la ignoraria silenciosamente y el stock calculado quedaria mal sin que nadie lo note. Por eso `movimientos.cantidad` y `movimientos.fecha_movimiento` son `NOT NULL`: son los datos minimos para que el reporte sea correcto y auditable. En cambio `observaciones` se deja opcional porque es informacion de excepcion (una devolucion, un dano), no algo que todo movimiento normal necesite. La comparacion `COUNT(*)` contra `COUNT(columna)` es la forma mas directa de comprobar esto con datos: en `cantidad` los numeros siempre coinciden (12 y 12); en `observaciones`, que es opcional, es esperado que no coincidan (12 y 3).
