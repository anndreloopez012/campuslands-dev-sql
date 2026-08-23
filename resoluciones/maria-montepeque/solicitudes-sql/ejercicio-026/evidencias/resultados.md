# Evidencias - Solicitudes SQL - Ejercicio 026 (Cafeteria Campus)

## Comandos ejecutados

```bash
sqlite3 ejercicio-026.db < ddl/schema.sql
sqlite3 ejercicio-026.db < dml/inserts.sql
sqlite3 ejercicio-026.db < dml/operaciones.sql
sqlite3 ejercicio-026.db < dql/consultas.sql
```

## Resultados

**1. Todas las ventas, con JOIN doble a clientes y productos (ya sin la duplicada y con el pago de Karen confirmado):**

```text
id_venta | nombre_cliente   | nombre_producto        | cantidad | monto_total | estado
1        | Ana Gomez          | Cafe Americano           | 2         | 17.0         | pagada
2        | Luis Marroquin     | Sandwich de Pollo        | 1         | 25.0         | pagada
3        | Karen Solis        | Cafe Americano           | 1         | 8.5          | pagada
4        | Ana Gomez          | Jugo Natural             | 1         | 10.0         | pagada
5        | Diego Paz          | Papas Fritas             | 2         | 24.0         | pagada
6        | Rosa Chavez        | Empanada de Queso        | 1         | 15.0         | cancelada
7        | Ana Gomez          | Sandwich de Pollo        | 1         | 25.0         | pagada
8        | Luis Marroquin     | Galletas Artesanales     | 3         | 27.0         | pagada
```

Quedan 8 ventas (empezaron 9, se elimino la duplicada del `id_venta = 9`).

**2. Ventas que no estan pagadas todavia:**

```text
id_venta | id_cliente | id_producto | monto_total | estado
6        | 5           | 5            | 15.0         | cancelada
```

**3. Cliente con mas actividad:**

```text
nombre_cliente   | total_compras_pagadas
Ana Gomez           | 3
Luis Marroquin      | 2
Karen Solis         | 1
Diego Paz           | 1
```

**4. Ventas ordenadas por fecha:** ver tabla completa arriba, de 2026-08-10 a 2026-08-12.

**5. Producto que genera mas ingresos (sin canceladas):**

```text
nombre_producto        | categoria | total_recaudado
Sandwich de Pollo        | comida     | 50.0
Galletas Artesanales      | snack      | 27.0
Cafe Americano             | bebida     | 25.5
Papas Fritas               | snack      | 24.0
Jugo Natural                | bebida     | 10.0
```

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO productos (nombre_producto, categoria, precio) VALUES ('Agua Embotellada', 'liquido', 5.00);` → `CHECK constraint failed: categoria IN ('bebida', 'comida', 'snack')`.

## Operaciones de mantenimiento verificadas

- `UPDATE ventas SET estado = 'pagada' WHERE id_venta = 3 AND estado = 'pendiente';` → la venta de Karen Solis paso de `pendiente` a `pagada`.
- `UPDATE productos SET precio = 9.00 WHERE id_producto = 1;` → el precio del Cafe Americano subio de 8.50 a 9.00.
- `DELETE FROM ventas WHERE id_venta = 9;` → la venta duplicada desaparecio; el conteo final es 8, no 9.

## Aprendizaje

A diferencia de una version mas simple de este caso (donde el cliente vivia como texto dentro de la venta), aqui `clientes` es un catalogo real con su propia `FOREIGN KEY`. Esto obligo a usar `JOIN` doble en casi todas las consultas (una hacia `clientes`, otra hacia `productos`), pero a cambio evita el problema exacto que preocupa al cliente: si un nombre de cliente se escribe con una letra distinta en dos ventas, el reporte de "cliente con mas actividad" las contaria como dos clientes diferentes. Con la llave foranea, ese error de digitacion simplemente no es posible: solo se puede vender a un `id_cliente` que ya existe en el catalogo.
