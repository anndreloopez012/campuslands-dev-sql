# Evidencias - Ejercicio 68

## Tema

DROP

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-68.db < ddl/schema.sql
sqlite3 ejercicio-68.db < dml/inserts.sql
sqlite3 ejercicio-68.db < dql/consultas.sql
```

## Resultados

Estado justo despues de `ddl/schema.sql` (migracion + DROP de tabla,
indice y vista):

```text
libros: [(1, 'Clean Code', 'programacion', 1),
         (2, 'Redes de Computadoras', 'redes', 1),
         (3, 'Designing Data-Intensive Applications', 'bases_de_datos', 1)]

sqlite_master (tabla temporal, indice, vista): []   -- los 3 ya no existen
```

Caso que debe fallar (comentado en `ddl/schema.sql`):

```text
DROP TABLE libros_importacion_temporal;   -- segunda vez
Fallo como se esperaba: OperationalError: no such table: libros_importacion_temporal
```

Estado final (despues de `inserts.sql`), 6 libros en total:

```text
categoria             total_libros
bases_de_datos          2
programacion            1
redes                   2
sistemas_operativos     1
```

Consulta 5 (validacion especifica de DROP):

```text
5a. sqlite_master para los 3 objetos eliminados: sin filas
5b. libros migrados desde la tabla temporal, siguen disponibles:
    ('Clean Code', 'programacion')
    ('Designing Data-Intensive Applications', 'bases_de_datos')
    ('Redes de Computadoras', 'redes')
```

## Aprendizaje

`DROP` elimina de forma permanente una tabla, un indice o una vista, y
no se puede deshacer: por eso es indispensable migrar o respaldar los
datos importantes antes de usarlo, como se hizo aqui con la tabla
temporal de importacion. `DROP INDEX` y `DROP VIEW` son mas seguros en
el sentido de que nunca afectan los datos de la tabla base, solo
eliminan la definicion del objeto auxiliar. Consultar `sqlite_master`
es una forma directa de confirmar que un objeto realmente se elimino.
