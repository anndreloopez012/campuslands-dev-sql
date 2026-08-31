# Evidencias - Ejercicio 67

## Tema

ALTER TABLE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-67.db < ddl/schema.sql
sqlite3 ejercicio-67.db < dml/inserts.sql
sqlite3 ejercicio-67.db < dql/consultas.sql
```

## Resultados

Estado justo despues de los `ALTER TABLE` (antes de `inserts.sql`),
confirmando que los datos originales sobrevivieron con los valores
`DEFAULT`:

```text
citas:   4 filas, todas con estado='programada' y motivo='consulta general'
medicos: 2 filas, ambas con consultorio='Sin asignar'
```

Caso que debe fallar (comentado en `ddl/schema.sql`):

```text
ALTER TABLE medicos ADD COLUMN codigo_colegiado TEXT UNIQUE;
Fallo como se esperaba: OperationalError: Cannot add a UNIQUE column
```

Estado final (despues de `inserts.sql`):

```text
citas por estado: atendida=3, programada=2
medicos con consultorio asignado:
  ('Dra. Sofia Ramirez', 'Consultorio 1')
  ('Dr. Carlos Perez', 'Consultorio 2')
```

Consulta 6 (medico con mas citas atendidas):

```text
medico                consultorio       citas_atendidas
Dra. Sofia Ramirez     Consultorio 1     2
```

## Aprendizaje

`ALTER TABLE` permite que un sistema de agenda evolucione con el tiempo
(agregar estado, motivo y consultorio) sin perder las citas ya
registradas, gracias a `DEFAULT`. Tambien se confirmo un limite real de
SQLite: no se puede agregar una columna con `UNIQUE` mediante
`ALTER TABLE ADD COLUMN`; esa restriccion solo se puede lograr creando
un indice unico por separado (`CREATE UNIQUE INDEX`) despues de agregar
la columna. Combinar `ALTER TABLE` con `JOIN` y `GROUP BY` permitio
ademas generar un reporte de negocio real: identificar al medico con
mas citas atendidas para decidir como distribuir los horarios.
