# Evidencias - Ejercicio 69

## Tema

DROP

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-69.db < ddl/schema.sql
sqlite3 ejercicio-69.db < dml/inserts.sql
sqlite3 ejercicio-69.db < dql/consultas.sql
```

## Resultados

Estado justo despues de `ddl/schema.sql` (migracion + DROP de tabla
temporal y vista):

```text
medicos: [(1, 'Dra. Sofia Ramirez', 'Medicina General'),
          (2, 'Dr. Carlos Perez', 'Pediatria')]

sqlite_master (tabla temporal, vista): []   -- ya no existen
```

Caso que debe fallar (comentado en `ddl/schema.sql`):

```text
DROP TABLE medicos;
Fallo como se esperaba: IntegrityError: FOREIGN KEY constraint failed
```

Estado final (despues de `inserts.sql`), 4 citas en total:

```text
estado         total
atendida        2
programada      2
```

Consulta 5 (validacion especifica de DROP):

```text
5a. sqlite_master para los 2 objetos eliminados: sin filas
5b. medicos migrados desde la tabla temporal, siguen disponibles:
    ('Dra. Sofia Ramirez', 'Medicina General')
    ('Dr. Carlos Perez', 'Pediatria')
```

## Aprendizaje

Ademas de lo visto en el nivel basico (migrar y luego eliminar una
tabla temporal, o eliminar una vista de apoyo sin afectar los datos),
este ejercicio mostro un limite importante de `DROP` en un modelo con
relaciones: SQLite, con `PRAGMA foreign_keys = ON`, no permite eliminar
una tabla que todavia esta referenciada por `FOREIGN KEY` desde otra
tabla con filas. Esto protege contra dejar datos huerfanos (citas
apuntando a un medico que ya no existe) y obliga a pensar el orden
correcto: eliminar primero las filas o tablas dependientes antes de
eliminar la tabla que referencian.
