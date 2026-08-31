# Evidencias - Ejercicio 037

## Comandos ejecutados

```bash
sqlite3 ejercicio-037.db < ddl/schema.sql
sqlite3 ejercicio-037.db < dml/inserts.sql
sqlite3 ejercicio-037.db < dml/operaciones.sql
sqlite3 ejercicio-037.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se listaron las plantillas de jugadores por equipo, los marcadores de los partidos y el total de goles anotados.

## Explicacion final

El sistema registra el desempeño de los equipos y jugadores en el torneo de fútbol sala, manteniendo actualizada la tabla de resultados.
