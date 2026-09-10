# Evidencias - Ejercicio 082

## Comandos ejecutados

```bash
sqlite3 ejercicio-082.db < ddl/schema.sql
sqlite3 ejercicio-082.db < dml/inserts.sql
sqlite3 ejercicio-082.db < dml/operaciones.sql
sqlite3 ejercicio-082.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se obtuvieron los alumnos con inscripciones activas, las tarifas de los planes y la recaudación total mensual por plan.

## Explicacion final

El modelo simplifica la administración de la academia, controlando los estados de las membresías de los alumnos y facilitando la proyección de ingresos.
