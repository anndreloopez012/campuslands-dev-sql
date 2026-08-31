# Ejercicio 85: WHERE Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

WHERE

## Descripcion del problema

Una clinica agenda citas por fecha y necesita dos cosas del dia a dia:
la agenda pendiente de un dia especifico, ordenada por hora, y una
alerta de que pacientes cancelan seguido, para contactarlos antes de
agendarles una cita nueva: un caso de negocio con reporte final,
propio del nivel aplicado.

## Tablas y relaciones

- `medicos`: catalogo de medicos.
- `pacientes`: catalogo de pacientes.
- `citas`: tabla principal, relaciona un paciente con un medico en una
  fecha y hora. `pacientes` 1—N `citas`; `medicos` 1—N `citas`.

## Uso de WHERE

En `dql/consultas.sql`:

1. Consulta 2: agenda pendiente de un dia especifico
   (`WHERE fecha_cita = '2026-08-20' AND estado = 'programada'`,
   ordenada por hora), el caso de negocio central del ejercicio.
2. Consulta 5 (reporte final): pacientes con 2 o mas citas
   canceladas, usando `WHERE id_paciente IN (subconsulta)`, donde la
   subconsulta tiene su propio `GROUP BY` y `HAVING`. Esto combina
   filtrado simple con deteccion de un patron agregado, en una sola
   consulta legible.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `medicos.nombre_medico`, `pacientes.telefono`.
- `CHECK`: `citas.estado IN (...)`.
- `DEFAULT` en `citas.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`SELECT nombre_paciente FROM pacientes p WHERE x.nombre_paciente =
'Manuel Estrada';` falla porque la tabla se declaro con el alias `p`
en el `FROM`, pero el `WHERE` intenta usar un alias `x` que nunca se
declaro. Se valido con Python (`sqlite3`): lanza
`no such column: x.nombre_paciente`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 medicos, 5 pacientes, 10 citas. Agenda pendiente
  del 2026-08-20: 2 citas. Diego Paz es el unico paciente con 2 o mas
  cancelaciones.

## Como ejecutar

```bash
sqlite3 ejercicio-85.db < ddl/schema.sql
sqlite3 ejercicio-85.db < dml/inserts.sql
sqlite3 ejercicio-85.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
