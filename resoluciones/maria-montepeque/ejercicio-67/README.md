# Ejercicio 67: ALTER TABLE Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

Una clinica agenda citas por fecha con una tabla `citas` muy simple
(paciente, medico, fecha). Con el tiempo la clinica pidio controlar el
estado de cada cita, registrar el motivo, saber en que consultorio
atiende cada medico, y usar un nombre de columna mas claro para la
fecha, todo sin perder las citas ya agendadas. Ademas necesita un
reporte para decidir a que medico asignarle mas horarios.

## Tablas y relaciones

- `medicos`: catalogo de medicos, con su consultorio.
- `pacientes`: catalogo de pacientes.
- `citas`: cita de un paciente con un medico, con fecha/hora, motivo y
  estado. `pacientes` 1—N `citas`; `medicos` 1—N `citas`.

## Uso de ALTER TABLE

En `ddl/schema.sql`, despues de crear las 3 tablas e insertar 2 medicos,
3 pacientes y 4 citas con la estructura original:

1. `ALTER TABLE citas ADD COLUMN estado ... DEFAULT 'programada' CHECK (...)`:
   agrega el estado de la cita con `DEFAULT`.
2. `ALTER TABLE citas ADD COLUMN motivo ... DEFAULT 'consulta general'`:
   agrega el motivo de la cita.
3. `ALTER TABLE medicos ADD COLUMN consultorio ... DEFAULT 'Sin asignar'`:
   agrega el consultorio del medico.
4. `ALTER TABLE citas RENAME COLUMN fecha_cita TO fecha_hora_cita`:
   renombra la columna de fecha.

Las 4 citas y los 2 medicos creados antes de los `ALTER TABLE`
conservaron sus datos originales y quedaron con las columnas nuevas
tomadas del `DEFAULT` (ver consulta 5 en `dql/consultas.sql`), luego
corregidos en `dml/inserts.sql` con el consultorio real de cada medico y
el estado real de cada cita ya pasada.

## Caso de negocio (nivel aplicado)

Consulta 6 en `dql/consultas.sql`: se calcula que medico tiene mas citas
atendidas, como apoyo para decidir a quien asignarle mas horarios. En
los datos de prueba, la Dra. Sofia Ramirez (Consultorio 1) es quien mas
citas atendidas tiene (2).

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `medicos.nombre`, `pacientes.telefono`.
- `CHECK`: `citas.estado IN (...)`.
- `DEFAULT` en las columnas agregadas por `ALTER TABLE`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `ddl/schema.sql`)

`ALTER TABLE medicos ADD COLUMN codigo_colegiado TEXT UNIQUE;` falla
porque SQLite no permite agregar una columna con restriccion `UNIQUE`
mediante `ALTER TABLE ADD COLUMN`, sin importar si la tabla tiene o no
filas. Se valido ejecutandolo con Python (`sqlite3`): lanza
`OperationalError: Cannot add a UNIQUE column`. Para lograrlo hay que
agregar la columna sin `UNIQUE` y despues crear un
`CREATE UNIQUE INDEX` sobre esa columna.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 2 medicos, 4 pacientes, 5 citas (4 originales que
  sobrevivieron los `ALTER TABLE`, 1 nueva con estructura completa).

## Como ejecutar

```bash
sqlite3 ejercicio-67.db < ddl/schema.sql
sqlite3 ejercicio-67.db < dml/inserts.sql
sqlite3 ejercicio-67.db < dql/consultas.sql
```
