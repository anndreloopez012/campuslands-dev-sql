# Evidencias - Ejercicio 099

## Comandos ejecutados

```bash
sqlite3 ejercicio-099.db < ddl/schema.sql
sqlite3 ejercicio-099.db < dml/inserts.sql
sqlite3 ejercicio-099.db < dml/operaciones.sql
sqlite3 ejercicio-099.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se presentó la tabla de posiciones con los mánagers, los resultados de los partidos y los goles anotados por club.

## Explicacion final

El modelo relacional automatiza el torneo virtual de fútbol, actualizando los puntos y la tabla de clasificación según los marcadores ingresados.
