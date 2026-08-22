# Evidencias - Ejercicio 026

## Comandos ejecutados

```bash
sqlite3 ejercicio-026.db < ddl/schema.sql
sqlite3 ejercicio-026.db < dml/inserts.sql
sqlite3 ejercicio-026.db < dml/operaciones.sql
sqlite3 ejercicio-026.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se identificaron los productos activos más vendidos y el total de ingresos desglosado por método de pago (efectivo, tarjeta, transferencia).

## Explicacion final

El modelo relacional permite controlar las ventas diarias de la cafetería, evitando productos duplicados y garantizando un registro claro de ingresos por cada método de pago.
