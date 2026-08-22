# Evidencias - Ejercicio 061

## Comandos ejecutados

```bash
sqlite3 ejercicio-061.db < ddl/schema.sql
sqlite3 ejercicio-061.db < dml/inserts.sql
sqlite3 ejercicio-061.db < dml/operaciones.sql
sqlite3 ejercicio-061.db < dql/consultas.sql
```

## Verificacion

- Estructura de tablas y restricciones creadas correctamente.
- Integridad referencial protegida con `FOREIGN KEY`.
- Operaciones `INSERT`, `UPDATE` y `DELETE` seguras verificadas.
- Consultas DQL probadas con exito.

## Resultados importantes

- Se consultó el menú por restaurante, los pedidos en camino y el total acumulado en ventas por cada plato ofrecido.

## Explicacion final

La base de datos agiliza la toma de pedidos a domicilio, relacionando restaurantes con clientes y registrando las ventas totales en tiempo real.
