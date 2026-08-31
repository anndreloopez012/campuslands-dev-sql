# Evidencias - Ejercicio 053

## Comandos ejecutados

```bash
sqlite3 ejercicio-053.db < ddl/schema.sql
sqlite3 ejercicio-053.db < dml/inserts.sql
sqlite3 ejercicio-053.db < dml/operaciones.sql
sqlite3 ejercicio-053.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se relacionaron los jugadores con sus respectivos equipos y se calcularon las victorias alcanzadas por cada equipo en condición de local.

## Explicacion final

El sistema organiza la estructura del torneo de esports, permitiendo registrar la alineación de los equipos y computar los resultados de las partidas competitivas.
