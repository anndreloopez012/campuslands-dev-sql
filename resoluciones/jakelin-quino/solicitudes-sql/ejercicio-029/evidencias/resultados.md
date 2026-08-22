# Evidencias - Ejercicio 029

## Comandos ejecutados

```bash
sqlite3 ejercicio-029.db < ddl/schema.sql
sqlite3 ejercicio-029.db < dml/inserts.sql
sqlite3 ejercicio-029.db < dml/operaciones.sql
sqlite3 ejercicio-029.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se obtuvo el catálogo con stock disponible, las ventas por cliente y el total facturado categorizado por cada marca de calzado.

## Explicacion final

La estructura relacional previene la sobreventa de sneakers regulando el stock e identifica las marcas con mayor volumen de ventas para el negocio.
