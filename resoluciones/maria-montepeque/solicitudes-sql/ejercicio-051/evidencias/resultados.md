# Evidencias - Solicitudes SQL - Ejercicio 051 (Cafeteria Campus)

## Comandos ejecutados

```bash
sqlite3 ejercicio-051.db < ddl/schema.sql
sqlite3 ejercicio-051.db < dml/inserts.sql
sqlite3 ejercicio-051.db < dml/operaciones.sql
sqlite3 ejercicio-051.db < dql/consultas.sql
```

## Resultados

**1. Todas las ventas, con JOIN al cliente y el total calculado desde el detalle (ya sin la duplicada, con la venta 4 pagada y el detalle de la venta 7 eliminado):**

```text
id_venta | nombre_cliente     | fecha_venta | estado          | total_venta
1         | Kimberly Solares    | 2026-08-01    | pagada           | 39.0
2         | Estuardo Ba         | 2026-08-01    | pagada           | 18.0
3         | Kimberly Solares    | 2026-08-02    | pagada           | 36.0
4         | Melany Roblero      | 2026-08-03    | pagada           | 28.0
5         | Josue Tojin         | 2026-08-04    | pagada           | 24.0
6         | Kimberly Solares    | 2026-08-05    | pagada           | 36.0
7         | Andrea Chavez       | 2026-08-06    | cancelada        | 0.0
8         | Estuardo Ba         | 2026-08-07    | pagada           | 51.0
```

La venta 7 quedo en 0.0 porque su detalle se elimino (era una venta cancelada), pero el encabezado se conservo como historial. Quedan 8 ventas (empezaron 9, se elimino la duplicada `id_venta = 9`) y 10 lineas de detalle (empezaron 11, se elimino la de la venta cancelada).

**2. Ventas que no estan pagadas todavia:**

```text
id_venta | id_cliente | fecha_venta | estado
7         | 5          | 2026-08-06    | cancelada
```

**3. Cliente con mas ventas:**

```text
nombre_cliente     | total_ventas
Kimberly Solares    | 3
Estuardo Ba         | 2
Andrea Chavez       | 1
Josue Tojin         | 1
Melany Roblero      | 1
```

**4. Ventas ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-07.

**5. Producto mas vendido en unidades (sin contar la venta cancelada), para decidir que reabastecer primero:**

```text
nombre_producto      | unidades_vendidas
Cafe Americano       | 7
Capuchino            | 3
Croissant            | 2
Papas Fritas         | 2
Agua Embotellada     | 1
Sandwich de Pollo    | 1
```

El Cafe Americano es, por mucho, el producto que mas se debe reabastecer.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO clientes (nombre_cliente, carnet) VALUES ('Otro Estudiante', '2024-01123');` → `UNIQUE constraint failed: clientes.carnet`.
- Valor fuera de rango: `INSERT INTO detalle_ventas (..., cantidad, ...) VALUES (..., 0, ...);` → `CHECK constraint failed: cantidad > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE ventas SET estado = 'pagada' WHERE id_venta = 4 AND estado = 'pendiente_pago';` → la venta de Melany Roblero quedo pagada.
- `UPDATE detalle_ventas SET cantidad = 2 WHERE id_venta = 5 AND id_producto = 1;` → se corrigio el conteo de cafes de Josue Tojin (de 1 a 2).
- `DELETE FROM detalle_ventas WHERE id_venta = 7 AND EXISTS (...);` → **DELETE controlado**: elimino unicamente el detalle de la venta cancelada de Andrea Chavez. El encabezado de la venta (id_venta = 7) se conservo intacto.
- `DELETE FROM ventas WHERE id_venta = 9;` → la venta duplicada desaparecio. Conteo final verificado: 8 ventas, 10 lineas de detalle, sin huerfanos.

## Aprendizaje

Separar `ventas` (encabezado) de `detalle_ventas` (lineas de producto) es justo lo que necesita la cafeteria para responder "que cliente compro y cuanto pago" de forma confiable, tal como lo planteaba el propio ejemplo del ejercicio. El `DELETE` controlado usa `EXISTS` sobre el estado de la venta padre: solo el detalle de una venta cancelada se elimina, nunca el de una venta pagada o pendiente, sin importar que tan simple parezca el borrado.
