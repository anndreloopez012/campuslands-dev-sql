# Evidencias - Ejercicio 103

## Tema

Procedimientos almacenados

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-103.db < ddl/schema.sql
sqlite3 ejercicio-103.db < dml/inserts.sql
sqlite3 ejercicio-103.db < dql/consultas.sql
```

## Resultados

**4. Total de citas por medico (antes de la consulta 5):**

```text
id_medico   total_citas
1             2
2             2
3             1
```

**5. Reporte de negocio: nueva cita agendada sin choque para "Dra. Sofia Martinez":**

El `INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita)
VALUES (4, 1, '2026-09-01', '11:00');` paso la validacion del trigger
(11:00 estaba libre) y quedo registrado junto a sus citas anteriores:

```text
id_cita   id_medico   fecha_cita     hora_cita   estado
1            1          2026-09-01      09:00       programada
2            1          2026-09-01      10:00       programada
6            1          2026-09-01      11:00       programada
```

**Caso comentado verificado (CHECK):**

- `INSERT INTO citas (..., estado) VALUES (1, 1, '2026-09-03', '09:00', 'pendiente');` → `CHECK constraint failed: estado IN ('programada', 'cancelada', 'atendida')`.

**Caso comentado verificado (trigger bloquea choque de agenda):**

```text
INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita)
VALUES (5, 1, '2026-09-01', '09:00');
```

→ `El medico ya tiene una cita programada en esa fecha y hora` (el
error definido en `RAISE(ABORT, ...)` dentro de
`trg_validar_choque_agenda`). "Dra. Sofia Martinez" (id_medico = 1) ya
tenia una cita `programada` exactamente en esa fecha y hora con Ana
Lopez.

## Aprendizaje

En un sistema de agenda, el caso de negocio final no es solo insertar
la cita, sino garantizar que la insercion respete una regla que
depende de datos ya existentes en la misma tabla (que el medico no
tenga otra cita en esa fecha y hora). Un procedimiento almacenado
resolveria esto validando la condicion antes del `INSERT` y cancelando
la operacion con una excepcion (`SIGNAL` en MySQL, `RAISE EXCEPTION`
en PostgreSQL) si el choque existe. SQLite no tiene procedimientos
almacenados, pero un trigger `BEFORE INSERT` con `WHEN EXISTS (...)` y
`RAISE(ABORT, mensaje)` logra el mismo resultado: cualquier intento de
duplicar un horario para el mismo medico se bloquea automaticamente,
sin que la aplicacion que inserta la cita tenga que implementar esa
verificacion por su cuenta cada vez.
