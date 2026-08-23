# Ejercicio 08: Clinica de Citas

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-04

## Descripcion del problema

La clinica necesita reemplazar el registro manual de pacientes, medicos, consultorios y citas por una base de datos relacional que evite duplicidad y permita controlar la disponibilidad de la agenda.

## Tablas y relaciones

- `pacientes`: catalogo de pacientes (nombre, correo, telefono).
- `medicos`: catalogo de medicos (nombre, especialidad, colegiado).
- `consultorios`: catalogo de consultorios (numero, piso).
- `citas`: cita de un paciente con un medico en un consultorio (`pacientes` 1—N `citas`, `medicos` 1—N `citas`, `consultorios` 1—N `citas`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`, `citas.id_consultorio`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `pacientes.correo`, `medicos.colegiado`, `consultorios.numero`, `(id_medico, fecha_hora)` en `citas` (evita doble cita para el mismo medico a la misma hora).
- `CHECK`: `consultorios.piso > 0`, `citas.estado IN ('programada', 'atendida', 'cancelada')`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 5 pacientes, 6 medicos, 5 consultorios y 9 citas tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (id_medico, fecha_hora)` y otra por `CHECK (estado IN (...))`.
- Consulta de decision de negocio (medico con mas citas atendidas): `Dra. Marta Solis`.

## Como ejecutar

```bash
sqlite3 ejercicio-08.db < ddl/schema.sql
sqlite3 ejercicio-08.db < dml/inserts.sql
sqlite3 ejercicio-08.db < dml/operaciones.sql
sqlite3 ejercicio-08.db < dql/consultas.sql
```
