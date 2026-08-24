# Ejercicio 71: INSERT Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

INSERT

## Descripcion del problema

Una clinica agenda citas relacionando pacientes con medicos. El
negocio necesita cargar medicos, pacientes y citas iniciales, tanto de
a uno como en lotes, y entender cuando conviene escribir todas las
columnas y cuando conviene dejar que `DEFAULT` complete lo que no se
indica.

## Tablas y relaciones

- `medicos`: catalogo de medicos.
- `pacientes`: catalogo de pacientes.
- `citas`: relaciona un paciente con un medico en una fecha, con un
  estado. `pacientes` 1—N `citas`; `medicos` 1—N `citas`.

## Uso de INSERT

En `dml/inserts.sql`:

1. `INSERT` de una sola fila: se registra el primer medico.
2. `INSERT` multiple (varias filas en una sola sentencia
   `VALUES (...), (...)`): el resto de medicos, todos los pacientes y
   dos citas con estado explicito.
3. `INSERT` multiple omitiendo a proposito la columna `estado`: las
   citas 3 y 4 se insertan solo con `id_paciente`, `id_medico` y
   `fecha_cita`, y quedan completas con `estado = 'programada'` gracias
   al `DEFAULT` de la tabla.

La consulta 5 en `dql/consultas.sql` confirma que esas dos citas no
quedaron con datos faltantes por haber omitido la columna.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `medicos.nombre_medico`, `pacientes.telefono`.
- `CHECK`: `citas.estado IN (...)`.
- `DEFAULT` en `citas.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio de cada script.

## Casos que fallan / no recomendables (comentados en `dml/inserts.sql`)

Uno por cada restriccion, validado con Python (`sqlite3`):

- Repetir `nombre_medico` -> `UNIQUE constraint failed`.
- Apuntar a un `id_medico` que no existe -> `FOREIGN KEY constraint failed`.
- Escribir un `estado` fuera de la lista permitida -> `CHECK constraint failed`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 medicos, 4 pacientes, 4 citas (2 atendidas, 2
  programadas).

## Como ejecutar

```bash
sqlite3 ejercicio-71.db < ddl/schema.sql
sqlite3 ejercicio-71.db < dml/inserts.sql
sqlite3 ejercicio-71.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
