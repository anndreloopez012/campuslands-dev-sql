# Ejercicio 89: GROUP BY Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

GROUP BY

## Descripcion del problema

Una clinica necesita saber cuantas citas atiende cada medico y cuanto
tiempo le dedica en promedio a cada una, para identificar quien tiene
citas mas largas y podria necesitar horarios mas espaciados.

## Tablas y relaciones

- `medicos`: catalogo de medicos.
- `pacientes`: catalogo de pacientes.
- `citas`: tabla principal, con `duracion_minutos` para poder sumar y
  promediar. `pacientes` 1—N `citas`; `medicos` 1—N `citas`.

## Uso de GROUP BY

En `dql/consultas.sql`:

1. Conteo simple: `GROUP BY id_medico` con `COUNT(*)`, para saber
   cuantas citas tiene cada medico.
2. Suma y promedio con `HAVING`: la consulta 5 agrupa las citas por
   medico y calcula `SUM(duracion_minutos)` y
   `AVG(duracion_minutos)` por grupo, y usa `HAVING AVG(...) > 30`
   para quedarse solo con los medicos cuyo promedio supera los 30
   minutos.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `medicos.nombre_medico`, `pacientes.telefono`.
- `CHECK`: `citas.duracion_minutos > 0`, `citas.estado IN (...)`.
- `DEFAULT` en `citas.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`SELECT id_medico, COUNT(*) FROM citas WHERE COUNT(*) > 2 GROUP BY
id_medico;` falla porque `COUNT()` es una funcion de agregacion y no
se puede usar dentro de `WHERE` (que se evalua antes de que existan
los grupos). Se valido con Python (`sqlite3`): lanza
`misuse of aggregate: COUNT()`. Ese mismo filtro, escrito con
`HAVING COUNT(*) > 2` despues del `GROUP BY`, si es valido.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-89.db < ddl/schema.sql
sqlite3 ejercicio-89.db < dml/inserts.sql
sqlite3 ejercicio-89.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
