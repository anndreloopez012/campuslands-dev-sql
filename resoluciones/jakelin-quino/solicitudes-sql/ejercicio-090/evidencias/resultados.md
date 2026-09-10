# Evidencias - Ejercicio 090

## Comandos ejecutados

```bash
sqlite3 ejercicio-090.db < ddl/schema.sql
sqlite3 ejercicio-090.db < dml/inserts.sql
sqlite3 ejercicio-090.db < dml/operaciones.sql
sqlite3 ejercicio-090.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se monitoreó el nivel de pureza de los reactivos, el origen de las muestras y el resultado de los ensayos ejecutados.

## Explicacion final

El sistema garantiza la trazabilidad del laboratorio, asociando reactivos y muestras para documentar con precisión los resultados de los experimentos realizados.
