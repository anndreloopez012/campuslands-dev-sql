# Evidencias - Ejercicio 075

## Comandos ejecutados

```bash
sqlite3 ejercicio-075.db < ddl/schema.sql
sqlite3 ejercicio-075.db < dml/inserts.sql
sqlite3 ejercicio-075.db < dml/operaciones.sql
sqlite3 ejercicio-075.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se asociaron los pilotos con sus vehículos de alta gama, los circuitos recorridos y los mejores tiempos por vuelta.

## Explicacion final

El sistema registra los tiempos del club de automovilismo, permitiendo evaluar la potencia de los hiperdeportivos y destacar las mejores vueltas del circuito.
