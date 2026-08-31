# Ejercicio 107: Indices Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Indices

## Descripcion del problema

Una agenda de citas medicas se consulta constantemente filtrando por
fecha ("que citas hay hoy"). El negocio necesita que ese filtro sea
rapido, sin que SQLite tenga que revisar fila por fila toda la tabla
cada vez.

## Tablas y relaciones

- `citas`: tabla principal (unica tabla de este ejercicio basico),
  con `nombre_paciente` y `nombre_medico` como texto simple, y su
  `fecha_cita`.

## Uso de Indices

En `ddl/schema.sql` se crea `idx_citas_fecha` sobre `citas
(fecha_cita)`, justo la columna por la que se filtra en el caso de
uso del contexto. En `dql/consultas.sql`:

- La consulta 2 filtra `WHERE fecha_cita = '2026-09-01'`.
- La consulta 5 usa `EXPLAIN QUERY PLAN` sobre esa MISMA consulta y
  confirma que SQLite eligio `SEARCH citas USING INDEX idx_citas_fecha
  (fecha_cita=?)` en vez de `SCAN citas` (revisar todas las filas):
  esa es la prueba directa de que el indice cumple su proposito,
  acelerar la busqueda por la columna indexada.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en `citas`.
- `NOT NULL` en todas las columnas obligatorias.
- `CHECK`: `estado IN ('programada', 'cancelada', 'atendida')`.
- `DEFAULT` en `estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script (aunque
  este ejercicio no tiene `FOREIGN KEY`, se mantiene por consistencia
  con el resto de la serie).

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Crear un indice `UNIQUE` sobre `nombre_paciente`, asumiendo (de forma
incorrecta) que cada paciente aparece una sola vez en `citas`. Un
mismo paciente puede tener varias citas (aqui, "Ana Lopez" aparece 2
veces, en filas distintas), asi que esa columna no deberia ser unica.
Se verifico con Python (`sqlite3`) que SQLite rechaza la creacion del
indice con el error `UNIQUE constraint failed:
citas.nombre_paciente` apenas encuentra el segundo "Ana Lopez": un
`CREATE UNIQUE INDEX` valida los datos ya existentes en la tabla, no
solo los que se inserten despues.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-107.db < ddl/schema.sql
sqlite3 ejercicio-107.db < dml/inserts.sql
sqlite3 ejercicio-107.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
