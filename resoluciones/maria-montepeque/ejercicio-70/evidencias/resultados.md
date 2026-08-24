# Evidencias - Ejercicio 70

## Tema

DROP

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-70.db < ddl/schema.sql
sqlite3 ejercicio-70.db < dml/inserts.sql
sqlite3 ejercicio-70.db < dql/consultas.sql
```

## Resultados

Estado justo despues de `ddl/schema.sql` (migracion de la primera
jornada desde `partidas_temporal` + `DROP TABLE`):

```text
equipos: 4 registros (Dragones del Norte, Lobos del Sur, Halcones del Centro, Tigres del Oeste)
partidas: 4 (2 jugadas migradas, 2 programadas)
sqlite_master (partidas_temporal): []   -- ya no existe
```

Caso que debe fallar (comentado en `ddl/schema.sql`):

```text
DROP TABLE equipos;
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Estado final (despues de `dml/inserts.sql`), 5 partidas en total:

```text
estado         total
jugada          3
programada      2
```

Reporte oficial de la jornada (consulta 5, con la vista
`vista_tabla_posiciones` antes de eliminarla):

```text
nombre_equipo          partidas_jugadas   partidas_ganadas
Dragones del Norte      2                   2
Halcones del Centro     2                   0
Lobos del Sur            1                   0
Tigres del Oeste         1                   0
```

Validacion especifica de DROP (consulta 5, despues de `DROP VIEW` y
`DROP INDEX`):

```text
5a. sqlite_master para partidas_temporal, vista_tabla_posiciones e
    idx_partidas_estado: sin filas -- los 3 objetos se eliminaron.
5b. total_partidas: 5 -- los datos reales con los que se armo el
    reporte siguen intactos.
```

## Aprendizaje

Ademas de lo visto en el nivel intermedio (migrar y eliminar una tabla
temporal, o crear y eliminar una vista de apoyo), este ejercicio de
nivel aplicado agrego un caso de negocio completo: un indice y una
vista se crean, se usan para generar un reporte oficial (la tabla de
posiciones del torneo) y se eliminan enseguida porque ya cumplieron su
proposito puntual. `DROP` no es solo "borrar algo que sobra": tambien
es parte normal del ciclo de vida de un objeto de apoyo que se crea
para una tarea especifica y se descarta una vez terminada, sin tocar
los datos reales (`equipos`, `jugadores`, `partidas`) que ese objeto
consultaba. El caso comentado (`DROP TABLE equipos`) confirma que las
`FOREIGN KEY` protegen a las tablas permanentes de un DROP accidental
mientras tengan filas dependientes.
