# Evidencias - Ejercicio 105

## Tema

Triggers

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-105.db < ddl/schema.sql
sqlite3 ejercicio-105.db < dml/inserts.sql
sqlite3 ejercicio-105.db < dql/consultas.sql
```

## Resultados

**1. Citas con su estado final (despues de los UPDATE de dml/inserts.sql):**

```text
id_cita   nombre_paciente   nombre_medico          fecha_cita     hora_cita   estado
1           Ana Lopez          Dra. Sofia Martinez     2026-09-01      09:00       atendida
2           Byron Ramirez      Dra. Sofia Martinez     2026-09-01      10:00       cancelada
3           Carla Gomez        Dr. Pedro Ramirez       2026-09-02      09:00       atendida
4           Diego Torres       Dr. Pedro Ramirez       2026-09-02      10:00       programada
```

**5. Auditoria generada automaticamente por el trigger 1:**

```text
id_auditoria   id_cita   estado_anterior   estado_nuevo
1                2          programada        cancelada
2                1          programada        atendida
```

Verificacion manual: hay exactamente 2 filas en `citas_auditoria`, una
por cada `UPDATE` de `dml/inserts.sql` (cita 2: `programada` ->
`cancelada`; cita 1: `programada` -> `atendida`). Ningun `INSERT`
manual toco `citas_auditoria` en todo el script.

**Caso comentado verificado (CHECK):**

- `INSERT INTO citas (..., estado) VALUES (1, 1, '2026-09-03', '09:00', 'pendiente');` → `CHECK constraint failed: estado IN ('programada', 'cancelada', 'atendida')`.

**Caso comentado verificado (trigger bloquea edicion de cita ya atendida):**

```text
UPDATE citas SET estado = 'cancelada' WHERE id_cita = 3;
```

→ `No se puede modificar una cita que ya fue atendida` (el error
definido en `RAISE(ABORT, ...)` dentro de
`trg_bloquear_edicion_cita_atendida`). Despues de este intento
fallido, `citas_auditoria` se verifico que sigue teniendo exactamente
2 filas: el trigger `BEFORE UPDATE` cancelo la operacion antes de que
`trg_auditar_cambio_estado_cita` (`AFTER UPDATE`) llegara a
dispararse.

## Aprendizaje

Sobre una misma tabla pueden convivir varios triggers con proposito
distinto: uno `AFTER UPDATE` que reacciona a un cambio ya aplicado
(auditar el estado nuevo) y otro `BEFORE UPDATE` que decide si ese
cambio debe aplicarse siquiera (bloquear la edicion de un registro
cerrado). El orden importa: como `trg_bloquear_edicion_cita_atendida`
se dispara ANTES del `UPDATE` y lo aborta con `RAISE(ABORT, ...)`,
la fila nunca cambia, y por lo tanto el trigger `AFTER UPDATE` de
auditoria (que solo se dispara despues de un cambio real) tampoco se
ejecuta. Esto demuestra que los triggers `BEFORE` sirven para imponer
reglas de negocio que impiden que ciertos cambios ocurran, mientras
que los triggers `AFTER` sirven para reaccionar a cambios que ya
ocurrieron.
