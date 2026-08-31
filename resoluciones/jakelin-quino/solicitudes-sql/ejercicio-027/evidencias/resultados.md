# Evidencias - Ejercicio 027

## Comandos ejecutados

```bash
sqlite3 ejercicio-027.db < ddl/schema.sql
sqlite3 ejercicio-027.db < dml/inserts.sql
sqlite3 ejercicio-027.db < dml/operaciones.sql
sqlite3 ejercicio-027.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se listaron las motocicletas asociadas a sus propietarios, el estado de los servicios (pendientes y completados) y el costo acumulado por cada vehículo.

## Explicacion final

La base de datos centraliza el historial de mantenimiento de las motos por cliente, optimizando el seguimiento de servicios y la facturación del taller.
