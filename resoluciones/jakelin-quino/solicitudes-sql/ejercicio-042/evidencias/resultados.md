# Evidencias - Ejercicio 042

## Comandos ejecutados

```bash
sqlite3 ejercicio-042.db < ddl/schema.sql
sqlite3 ejercicio-042.db < dml/inserts.sql
sqlite3 ejercicio-042.db < dml/operaciones.sql
sqlite3 ejercicio-042.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se organizaron las canciones por artista, el historial de reproducciones de los usuarios y las canciones más populares.

## Explicacion final

La base de datos estructura el catálogo de música y analiza las reproducciones de los usuarios para identificar las tendencias y temas más escuchados.
