# Evidencias - Ejercicio 001

## Comandos ejecutados

```bash
sqlite3 ejercicio-001.db < ddl/schema.sql
sqlite3 ejercicio-001.db < dml/inserts.sql
sqlite3 ejercicio-001.db < dml/operaciones.sql
sqlite3 ejercicio-001.db < dql/consultas.sql
```

## Verificacion

- Se crearon 2 tablas con llaves primarias.
- `ventas.producto_id` relaciona cada venta con un producto.
- `CHECK`, `UNIQUE` y `NOT NULL` protegen los datos.
- Las consultas muestran productos, estados, ventas e ingresos.
- El `UPDATE` cambia una venta pendiente a pagada.
- El `DELETE` solo permite quitar productos sin ventas.

## Resultados importantes

- Se identificaron los productos activos más vendidos y el total de ingresos desglosado por método de pago (efectivo, tarjeta, transferencia).

## Explicacion final

El modelo relacional permite controlar las ventas diarias de la cafetería, evitando productos duplicados y garantizando un registro claro de ingresos por cada método de pago.
