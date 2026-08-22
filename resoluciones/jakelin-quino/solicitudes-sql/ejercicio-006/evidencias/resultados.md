# Evidencias - Ejercicio 006

## Comandos ejecutados

```bash
sqlite3 ejercicio-006.db < ddl/schema.sql
sqlite3 ejercicio-006.db < dml/inserts.sql
sqlite3 ejercicio-006.db < dml/operaciones.sql
sqlite3 ejercicio-006.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se listaron los vehículos deportivos disponibles, las reservas activas con su costo total y el gasto acumulado por cliente.

## Explicacion final

La base de datos asegura el control del estado de alquiler de la flota de lujo y registra el historial de facturación por cliente.
