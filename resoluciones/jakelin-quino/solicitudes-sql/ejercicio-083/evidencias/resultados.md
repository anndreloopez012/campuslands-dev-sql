# Evidencias - Ejercicio 083

## Comandos ejecutados

```bash
sqlite3 ejercicio-083.db < ddl/schema.sql
sqlite3 ejercicio-083.db < dml/inserts.sql
sqlite3 ejercicio-083.db < dml/operaciones.sql
sqlite3 ejercicio-083.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se detallaron las modalidades de salto ofertadas, las reservas asignadas por cliente y los ingresos acumulados según la altura del salto.

## Explicacion final

El sistema gestiona las reservas de deportes extremos, garantizando el registro seguro de los clientes y la tarifación de cada experiencia de paracaidismo.
