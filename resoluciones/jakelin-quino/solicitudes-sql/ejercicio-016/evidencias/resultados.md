# Evidencias - Ejercicio 016

## Comandos ejecutados

```bash
sqlite3 ejercicio-016.db < ddl/schema.sql
sqlite3 ejercicio-016.db < dml/inserts.sql
sqlite3 ejercicio-016.db < dml/operaciones.sql
sqlite3 ejercicio-016.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se listó el equipamiento gaming de las habitaciones, las reservas registradas y el total facturado por estancia de huésped.

## Explicacion final

El modelo gestiona las reservas del hotel temático, asegurando la disponibilidad de las consolas y el cálculo de la facturación por noche.
