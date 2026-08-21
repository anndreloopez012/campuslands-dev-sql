# Evidencias - Ejercicio 66

## Tema

ALTER TABLE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-66.db < ddl/schema.sql
sqlite3 ejercicio-66.db < dml/inserts.sql
sqlite3 ejercicio-66.db < dql/consultas.sql
```

## Resultados

Estado justo despues de los `ALTER TABLE` (antes de `inserts.sql`),
confirmando que los datos originales sobrevivieron:

```text
libros:    [(1, 1, 'Clean Code', 'programacion', 1), (2, 2, 'Redes de Computadoras', 'programacion', 1)]
prestamos: [(1, 1, 'Manuel Estrada', '2026-08-01', 'prestado'), (2, 2, 'Alejandra Chinchilla', '2026-08-02', 'prestado')]
escritores: [(1, 'Robert C. Martin'), (2, 'Andrew S. Tanenbaum')]   -- tabla renombrada, mismos datos
```

Caso que debe fallar (comentado en `ddl/schema.sql`):

```text
ALTER TABLE escritores ADD COLUMN nacionalidad TEXT NOT NULL;
Fallo como se esperaba: OperationalError: Cannot add a NOT NULL column with default value NULL
```

Consulta 5 (validacion especifica de ALTER TABLE):

```text
5a. libros originales, ya con categoria correcta
('Clean Code', 'programacion', 1)
('Redes de Computadoras', 'redes', 1)

5b. prestamos originales, con estado tomado del DEFAULT
(1, 'Manuel Estrada', 'prestado')
(2, 'Alejandra Chinchilla', 'prestado')

5c. la FOREIGN KEY de libros.id_autor sigue funcionando tras renombrar
    autores a escritores
('Clean Code', 'Robert C. Martin')
('Redes de Computadoras', 'Andrew S. Tanenbaum')
('Designing Data-Intensive Applications', 'Martin Kleppmann')
```

## Aprendizaje

`ALTER TABLE` en SQLite permite evolucionar varias tablas relacionadas
sin perder datos ni romper sus relaciones: agregar columnas con
`DEFAULT`, renombrar columnas, y renombrar una tabla completa. Al
renombrar `autores` a `escritores`, SQLite actualizo automaticamente la
definicion de la `FOREIGN KEY` de `libros.id_autor` para que siguiera
apuntando a la tabla correcta, sin necesidad de recrear `libros`. Esto
confirma que `ALTER TABLE` es seguro de usar incluso cuando hay tablas
dependientes por llave foranea.
