# Evidencias - Ejercicio 084

## Comandos ejecutados

```bash
sqlite3 ejercicio-084.db < ddl/schema.sql
sqlite3 ejercicio-084.db < dml/inserts.sql
sqlite3 ejercicio-084.db < dml/operaciones.sql
sqlite3 ejercicio-084.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se reportaron los proyectos por cliente, el estado de renderizado de las escenas y el total de horas de cómputo invertidas.

## Explicacion final

La solución permite monitorear el avance de producción de animación 3D, calculando los tiempos de render para cumplir con las entregas a los clientes.
