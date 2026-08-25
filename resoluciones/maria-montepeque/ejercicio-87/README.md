# Ejercicio 87: ORDER BY Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

ORDER BY

## Descripcion del problema

Una clinica necesita ver sus citas en el orden en que realmente
importan para la operacion diaria: primero las programadas (las que
todavia hay que atender), despues las atendidas y al final las
canceladas, y solo las mas urgentes, no la lista completa.

## Tablas y relaciones

- `medicos`: catalogo de medicos.
- `pacientes`: catalogo de pacientes.
- `citas`: tabla principal. `pacientes` 1—N `citas`; `medicos` 1—N
  `citas`.

## Uso de ORDER BY

En `dql/consultas.sql`:

1. Orden simple por dos columnas: `ORDER BY fecha_cita, hora_cita`
   (nivel basico, punto de partida).
2. Orden por prioridad de negocio con `CASE WHEN` (nivel intermedio):
   la consulta 5 ordena las citas por un orden de prioridad definido
   a mano (`'programada'` = 1, `'atendida'` = 2, `'cancelada'` = 3),
   en vez del orden alfabetico que darian esos mismos textos.
3. `LIMIT` combinado con `ORDER BY`: se queda solo con las 3 citas
   mas urgentes segun ese orden personalizado, en vez de traer toda
   la tabla.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `medicos.nombre_medico`, `pacientes.telefono`.
- `CHECK`: `citas.estado IN (...)`.
- `DEFAULT` en `citas.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`SELECT estado, COUNT(*) FROM citas GROUP BY estado ORDER BY
horacita;` falla porque `horacita` no es el nombre real de la columna
(falta el guion bajo de `hora_cita`). Se valido con Python
(`sqlite3`): lanza `no such column: horacita`.

Se probo primero un caso distinto: ordenar una consulta agrupada por
una columna que no esta en el `GROUP BY` ni en una funcion de
agregacion. En SQLite esa combinacion **si es valida** (a diferencia
de motores mas estrictos como PostgreSQL), asi que no sirve como caso
que falla; se reemplazo por el error de escritura real.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-87.db < ddl/schema.sql
sqlite3 ejercicio-87.db < dml/inserts.sql
sqlite3 ejercicio-87.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
