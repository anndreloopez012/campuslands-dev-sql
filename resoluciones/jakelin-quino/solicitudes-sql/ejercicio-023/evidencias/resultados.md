# Evidencias - Ejercicio 023

## Comandos ejecutados

```bash
sqlite3 ejercicio-023.db < ddl/schema.sql
sqlite3 ejercicio-023.db < dml/inserts.sql
sqlite3 ejercicio-023.db < dml/operaciones.sql
sqlite3 ejercicio-023.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se organizaron los miembros pertenecientes a cada clan, los mapas jugados y el registro de victorias en las guerras de clanes.

## Explicacion final

La base de datos gestiona la comunidad del juego shooter, registrando las confrontaciones entre clanes y destacando a los ganadores de cada enfrentamiento.
