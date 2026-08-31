# Evidencias - Ejercicio 010

## Comandos ejecutados

```bash
sqlite3 ejercicio-010.db < ddl/schema.sql
sqlite3 ejercicio-010.db < dml/inserts.sql
sqlite3 ejercicio-010.db < dml/operaciones.sql
sqlite3 ejercicio-010.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se visualizó el catálogo de libros, el estado actual de los préstamos activos y el histórico de lecturas por usuario.

## Explicacion final

El modelo relacional optimiza la gestión del inventario bibliográfico, evitando la pérdida de libros mediante el control estricto de préstamos y devoluciones.
