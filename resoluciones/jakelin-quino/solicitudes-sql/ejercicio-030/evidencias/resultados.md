# Evidencias - Ejercicio 030

## Comandos ejecutados

```bash
sqlite3 ejercicio-030.db < ddl/schema.sql
sqlite3 ejercicio-030.db < dml/inserts.sql
sqlite3 ejercicio-030.db < dml/operaciones.sql
sqlite3 ejercicio-030.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se generó la cartelera con horarios y precios, filtrando películas de mayor duración y contabilizando las funciones asignadas por sala.

## Explicacion final

El modelo organiza eficientemente la programación del cine de terror, controlando la capacidad de las salas y permitiendo ajustar las tarifas de las funciones.
