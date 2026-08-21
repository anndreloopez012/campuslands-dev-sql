# Evidencias - Ejercicio 63

## Tema

AUTO_INCREMENT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-63.db < ddl/schema.sql
sqlite3 ejercicio-63.db < dml/inserts.sql
sqlite3 ejercicio-63.db < dql/consultas.sql
```

## Resultados

Conteo final de datos:

```text
clientes -> 3
productos -> 3
ventas -> 5
```

Caso que debe fallar (comentado en `dml/inserts.sql`):

```text
INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES (1, 999, 1);
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 5 (validacion especifica de AUTO_INCREMENT):

```text
5a. ventas finales en orden
(1, 1, 1)
(2, 2, 2)
(4, 1, 2)
(5, 2, 1)
(6, 3, 3)          -- ultima venta insertada, recibio id 6

5b. buscar id_venta = 3 (eliminada antes)
(sin filas)        -- confirma que AUTOINCREMENT no reutilizo el id 3
```

## Aprendizaje

`INTEGER PRIMARY KEY AUTOINCREMENT` garantiza que cada nueva fila reciba
un id mayor a cualquiera usado antes en esa tabla, aunque se eliminen
filas intermedias. Esto es especialmente importante en una tabla con
relaciones (`ventas` referenciando `clientes` y `productos`): si un id
eliminado se reutilizara, podria generar confusion al mezclar historicos
de ventas antiguas con ventas nuevas que compartieran el mismo
identificador.
