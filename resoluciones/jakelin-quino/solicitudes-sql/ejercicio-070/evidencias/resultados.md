# Evidencias - Ejercicio 070

## Comandos ejecutados

```bash
sqlite3 ejercicio-070.db < ddl/schema.sql
sqlite3 ejercicio-070.db < dml/inserts.sql
sqlite3 ejercicio-070.db < dml/operaciones.sql
sqlite3 ejercicio-070.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se listó el precio por kilo de los materiales, las órdenes de soldadura por empresa y el total invertido por cliente.

## Explicacion final

La estructura de la base de datos optimiza el control de costos en el taller metalmecánico, calculando el importe de las órdenes según el peso.
