# Ejercicio 105: Triggers Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Triggers

## Descripcion del problema

Una agenda de citas medicas necesita dos cosas: un historial de cada
cambio de estado de una cita (auditoria), y que una cita ya
`atendida` quede protegida como registro historico cerrado, sin que
nadie pueda modificarla despues.

## Tablas y relaciones

- `pacientes`: catalogo de pacientes.
- `medicos`: catalogo de medicos.
- `citas`: tabla principal, cada fila con su `estado` (`programada`,
  `cancelada` o `atendida`). `pacientes` 1—N `citas`; `medicos` 1—N
  `citas`.
- `citas_auditoria`: historial de cambios de `estado`. `citas` 1—N
  `citas_auditoria`.

## Uso de Triggers

En `ddl/schema.sql` se definen dos triggers:

1. `trg_auditar_cambio_estado_cita` (`AFTER UPDATE OF estado ON
   citas`, con `WHEN OLD.estado <> NEW.estado`): automatiza el
   registro de auditoria. Cada cambio de estado deja una fila en
   `citas_auditoria` con el estado anterior y el nuevo, sin que nadie
   tenga que escribirla a mano.
2. `trg_bloquear_edicion_cita_atendida` (`BEFORE UPDATE ON citas`, con
   `WHEN OLD.estado = 'atendida'`): automatiza una regla de negocio.
   Si la cita que se intenta modificar ya estaba `atendida`, el
   trigger cancela el `UPDATE` completo con `RAISE(ABORT, ...)` antes
   de que se aplique, protegiendo el registro historico.

En `dml/inserts.sql`, los 2 `UPDATE` validos (cancelar una cita
`programada` y marcar otra como `atendida`) disparan el trigger 1 dos
veces. En `dql/consultas.sql`, la consulta 5 confirma que
`citas_auditoria` tiene exactamente esas 2 filas, generadas solas.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`,
  `citas_auditoria.id_cita`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `pacientes.telefono`, `medicos.nombre_medico`.
- `CHECK`: `citas.estado IN ('programada', 'cancelada', 'atendida')`.
- `DEFAULT` en `citas.estado` y `citas_auditoria.fecha_evento`
  (`datetime('now')`).
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Intentar modificar la cita 3, que en `dml/inserts.sql` ya quedo
`atendida` desde su insercion. Se verifico con Python (`sqlite3`) que
`trg_bloquear_edicion_cita_atendida` aborta la operacion con el error
`No se puede modificar una cita que ya fue atendida` antes de que el
`UPDATE` llegue a aplicarse. Como ese trigger es `BEFORE UPDATE` y
cancela la operacion, `trg_auditar_cambio_estado_cita` (que es
`AFTER UPDATE`) nunca llega a dispararse: se verifico que
`citas_auditoria` sigue teniendo exactamente 2 filas despues del
intento fallido.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-105.db < ddl/schema.sql
sqlite3 ejercicio-105.db < dml/inserts.sql
sqlite3 ejercicio-105.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
