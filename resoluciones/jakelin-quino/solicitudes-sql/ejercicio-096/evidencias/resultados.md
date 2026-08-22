# Evidencias - Ejercicio 096

## Comandos ejecutados

```bash
sqlite3 ejercicio-096.db < ddl/schema.sql
sqlite3 ejercicio-096.db < dml/inserts.sql
sqlite3 ejercicio-096.db < dml/operaciones.sql
sqlite3 ejercicio-096.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se listó el nivel de los jugadores, la posición lograda en cada partida y el total de eliminaciones acumuladas.

## Explicacion final

El modelo permite registrar las estadísticas competitivas del juego battle royale, calculando el rendimiento y ranking general de los jugadores en la plataforma.
