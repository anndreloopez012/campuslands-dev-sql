# Evidencias - Solicitudes SQL - Ejercicio 076 (Cafeteria Campus)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-076.db < ddl/schema.sql
sqlite3 ejercicio-076.db < dml/inserts.sql
sqlite3 ejercicio-076.db < dml/operaciones.sql
sqlite3 ejercicio-076.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 5 productos, 4 clientes, 4 ventas
(2 `cerrada` con pago, 2 `abierta`) y 8 lineas de detalle (incluye la
del Sandwich Jamon agregado por error en la venta 4).

**Caso comentado verificado:**

- `INSERT INTO detalle_ventas (id_venta, id_producto, ...) VALUES (1, 1, ...);` (segunda linea de Cafe Americano en la venta 1) → `UNIQUE constraint failed: detalle_ventas.id_venta, detalle_ventas.id_producto`.

**3. Cliente con mas actividad (total gastado):**

```text
nombre_cliente          total_gastado
Alejandra Chinchilla      75.0
Manuel Estrada            48.0
Byron Xicay               32.0
Cristina Barrios          15.0
```

**5. Productos mas vendidos por unidades (minimo 2 unidades, para
decidir cuales reabastecer primero):**

```text
nombre_producto    unidades_vendidas
Cafe Americano       3
Papas Fritas         3
```

## Operaciones de mantenimiento verificadas

- **DELETE controlado**: se elimino el Sandwich Jamon agregado por error en la venta 4, mientras esta seguia `abierta` y sin pago. La venta 4 quedo solo con Cafe Americano (1 unidad).
- `UPDATE ventas SET estado = 'cerrada' WHERE id_venta = 3 ...;` → la venta de Byron Xicay se cobro y se cerro.
- Se registro el pago oficial de la venta 3 (`transferencia`, Q32.00 = 12.00 + 20.00 de sus lineas), ahora que ya esta cerrada. Total de pagos: 2 -> 3.

## Aprendizaje

El `UNIQUE (id_venta, id_producto)` en `detalle_ventas` y el `UNIQUE (id_venta)` en `pagos` son las restricciones que resuelven directamente lo que pidio el cliente: separar catalogos de operaciones de resultados sin permitir registros duplicados en ninguna de las tres capas. El `DELETE` controlado solo se aplico mientras la venta 4 seguia `abierta` y sin pago; una vez que una venta tiene su pago oficial (como la 1, 2 y 3), sus lineas ya no se tocan. El reporte de productos mas vendidos (`GROUP BY` + `HAVING`) demuestra que, con el modelo separado en capas, es facil responder una pregunta de negocio real sin mezclar informacion permanente con movimientos.
