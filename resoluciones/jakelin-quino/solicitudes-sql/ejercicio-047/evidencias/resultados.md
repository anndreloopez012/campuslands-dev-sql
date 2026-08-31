# Evidencias - Ejercicio 047

## Comandos ejecutados

```bash
sqlite3 ejercicio-047.db < ddl/schema.sql
sqlite3 ejercicio-047.db < dml/inserts.sql
sqlite3 ejercicio-047.db < dml/operaciones.sql
sqlite3 ejercicio-047.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se presentaron las alineaciones por región, los héroes más seleccionados en partida y el ratio KDA promedio de cada jugador.

## Explicacion final

El sistema administra la liga profesional de MOBA, evaluando el desempeño de los pro-players y organizando el historial de las partidas disputadas.
