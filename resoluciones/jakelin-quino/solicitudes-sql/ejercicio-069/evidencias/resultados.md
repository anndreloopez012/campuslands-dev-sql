# Evidencias - Ejercicio 069

## Comandos ejecutados

```bash
sqlite3 ejercicio-069.db < ddl/schema.sql
sqlite3 ejercicio-069.db < dml/inserts.sql
sqlite3 ejercicio-069.db < dml/operaciones.sql
sqlite3 ejercicio-069.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se reportó la superficie en metros cuadrados de los proyectos por cliente y el costo total de las imágenes renderizadas.

## Explicacion final

El modelo relacional permite administrar los proyectos arquitectónicos y sus renders asociando cada entregable al presupuesto aprobado por el cliente.
