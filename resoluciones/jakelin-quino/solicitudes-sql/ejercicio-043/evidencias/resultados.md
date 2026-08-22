# Evidencias - Ejercicio 043

## Comandos ejecutados

```bash
sqlite3 ejercicio-043.db < ddl/schema.sql
sqlite3 ejercicio-043.db < dml/inserts.sql
sqlite3 ejercicio-043.db < dml/operaciones.sql
sqlite3 ejercicio-043.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se consultaron los cursos dictados por profesor, los alumnos inscritos y el total recaudado por cada curso impartido.

## Explicacion final

La solución organiza la oferta académica del estudio de arte, vinculando docentes con estudiantes e integrando el control de los ingresos cobrados.
