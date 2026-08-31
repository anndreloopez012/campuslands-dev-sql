# Evidencias - Ejercicio 014

## Comandos ejecutados

```bash
sqlite3 ejercicio-014.db < ddl/schema.sql
sqlite3 ejercicio-014.db < dml/inserts.sql
sqlite3 ejercicio-014.db < dml/operaciones.sql
sqlite3 ejercicio-014.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se relacionaron los vehículos con sus dueños, las fallas mecánicas reportadas y el costo total estimado en reparaciones.

## Explicacion final

La base de datos centraliza las órdenes del taller automotriz, permitiendo llevar un control transparente del diagnóstico y costo de cada reparación.
