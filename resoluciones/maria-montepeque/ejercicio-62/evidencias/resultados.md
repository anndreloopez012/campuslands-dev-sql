# Evidencias - Ejercicio 62

## Tema

AUTO_INCREMENT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-62.db < ddl/schema.sql
sqlite3 ejercicio-62.db < dml/inserts.sql
sqlite3 ejercicio-62.db < dql/consultas.sql
```

## Resultados

Conteo final de datos:

```text
rutas -> 3
campers -> 5
inscripciones -> 6
```

Caso que debe fallar (comentado en `dml/inserts.sql`):

```text
INSERT INTO campers (id_camper, nombre, email) VALUES (1, 'Duplicado', 'duplicado@correo.com');
Fallo como se esperaba: UNIQUE constraint failed: campers.id_camper
```

Consulta 5 (validacion especifica de AUTO_INCREMENT):

```text
5a. ids finales en orden
(1, 'Manuel Estrada')
(2, 'Alejandra Chinchilla')
(4, 'Cristina Barrios')
(5, 'Douglas Pineda')
(6, 'Ingrid Say')          -- ultimo insertado, recibio id 6

5b. buscar id_camper = 3 (eliminado antes)
(sin filas)                -- confirma que AUTOINCREMENT no reutilizo el id 3
```

## Aprendizaje

`INTEGER PRIMARY KEY AUTOINCREMENT` genera automaticamente un id creciente
para cada fila nueva, sin que la aplicacion tenga que calcularlo. La
diferencia frente a un `INTEGER PRIMARY KEY` simple es que
`AUTOINCREMENT` nunca reutiliza un id que ya se uso, aunque la fila se
elimine despues: SQLite recuerda el maximo historico en la tabla interna
`sqlite_sequence`. Esto es util cuando el id se usa como referencia
externa (por ejemplo, en un comprobante o una URL) y no se quiere que un
id eliminado vuelva a aparecer apuntando a otro registro distinto.
