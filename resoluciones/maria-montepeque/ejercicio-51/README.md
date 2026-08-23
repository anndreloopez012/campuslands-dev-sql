# Ejercicio 51: UNIQUE Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

UNIQUE

## Descripcion del problema

Sistema de agenda de citas de una clinica: `pacientes`, `medicos` y `citas`. Nivel intermedio: profundiza el tema del ejercicio 50 (UNIQUE simple) agregando un **UNIQUE compuesto** — sobre dos columnas a la vez — para resolver un problema real de agenda: evitar que un medico quede doblemente reservado a la misma hora.

## Tablas y relaciones

- `pacientes`: catalogo de pacientes, con `documento` `UNIQUE` (simple).
- `medicos`: catalogo de medicos, con `correo` `UNIQUE` (simple).
- `citas`: cada cita, con `UNIQUE (id_medico, fecha_hora)` — restriccion **compuesta**. `pacientes` 1—N `citas` y `medicos` 1—N `citas`.

## Que aprendi sobre UNIQUE

- **UNIQUE tambien puede ser compuesto (varias columnas juntas)**, igual que una `PRIMARY KEY` puede serlo. `citas.id_medico` por si solo NO es `UNIQUE` (un medico atiende muchas citas), y `fecha_hora` por si sola tampoco (a la misma hora pueden atender varios medicos distintos). Lo que si debe ser unico es la **combinacion**: ese medico, a esa hora, una sola vez. Confirme con datos reales que ambas cosas conviven: la Dra. Marta Solis (`id_medico = 1`) tiene 3 citas en horas distintas, y a las `2026-08-05 08:00` hay citas de 2 medicos diferentes — ninguno de los dos casos viola el `UNIQUE` compuesto.
- **Verificacion con datos, no solo con el caso que falla**: la consulta 5.b agrupa por `(id_medico, fecha_hora)` y filtra con `HAVING COUNT(*) > 1`; con los 10 datos de prueba, devuelve 0 filas, confirmando que ninguna combinacion se repite en la base ya cargada.
- El caso comentado que falla intenta agendar a la Dra. Marta Solis otra vez a las `2026-08-05 08:00` (con un paciente distinto): eso es exactamente la doble reserva que la restriccion existe para evitar, y falla con `UNIQUE constraint failed: citas.id_medico, citas.fecha_hora`.

## Como ejecutar

```bash
sqlite3 ejercicio-51.db < ddl/schema.sql
sqlite3 ejercicio-51.db < dml/inserts.sql
sqlite3 ejercicio-51.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
