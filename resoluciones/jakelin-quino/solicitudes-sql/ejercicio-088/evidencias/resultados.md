# Evidencias - Ejercicio 088

## Comandos ejecutados

```bash
sqlite3 ejercicio-088.db < ddl/schema.sql
sqlite3 ejercicio-088.db < dml/inserts.sql
sqlite3 ejercicio-088.db < dml/operaciones.sql
sqlite3 ejercicio-088.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se catalogaron los estilos de cada artista, las citas agendadas por cliente y el total de ingresos generados por tatuador.

## Explicacion final

El diseño relacional facilita la agenda de citas del estudio, vinculando a los clientes con sus artistas preferidos y controlando los cobros realizados.
