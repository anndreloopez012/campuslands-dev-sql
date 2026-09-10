# Ejercicio 103: Procedimientos almacenados Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Procedimientos almacenados

> **Nota:** SQLite no soporta procedimientos almacenados nativos. Como
> en los ejercicios 101 y 102, aqui se documenta el procedimiento
> teorico para MySQL y PostgreSQL (comentado en `ddl/schema.sql`) y se
> implementa la alternativa ejecutable en SQLite con un `TRIGGER`.

## Descripcion del problema

Una agenda de citas medicas necesita garantizar, como validacion
final de negocio, que un mismo medico nunca quede agendado dos veces
en la misma fecha y hora (choque de agenda), sin depender de que la
persona que agenda revise manualmente la disponibilidad antes de cada
cita.

## Tablas y relaciones

- `pacientes`: catalogo de pacientes.
- `medicos`: catalogo de medicos, con su especialidad.
- `citas`: tabla principal, cada fila es una cita con su `estado`
  (`programada`, `cancelada` o `atendida`). `pacientes` 1—N `citas`;
  `medicos` 1—N `citas`.

## Uso de Procedimientos almacenados

En `ddl/schema.sql`:

1. Se documenta, como comentario, el procedimiento teorico
   `agendar_cita` para MySQL (con `SIGNAL SQLSTATE '45000'`) y para
   PostgreSQL (con `RAISE EXCEPTION`), que verifica si ya existe una
   cita `programada` para el mismo medico en la misma fecha y hora, y
   solo inserta la cita nueva si no hay choque.
2. Como alternativa SI ejecutable en SQLite, el trigger
   `trg_validar_choque_agenda` (`BEFORE INSERT ON citas`) hace la
   misma validacion con `WHEN EXISTS (...)`: si ya hay una cita
   `programada` para ese medico, esa fecha y esa hora, aborta la
   operacion con `RAISE(ABORT, 'El medico ya tiene una cita
   programada en esa fecha y hora')` antes de insertar nada.
3. La consulta 5 en `dql/consultas.sql` es el reporte/validacion final
   de negocio: agenda una cita nueva en un horario realmente libre
   para "Dra. Sofia Martinez" y confirma, con una consulta posterior,
   que quedo registrada junto a sus citas existentes, sin chocar con
   ellas.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `pacientes.telefono`, `medicos.nombre_medico`.
- `CHECK`: `citas.estado IN ('programada', 'cancelada', 'atendida')`.
- `DEFAULT` en `citas.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Intentar agendar otra cita para "Dra. Sofia Martinez" el 2026-09-01 a
las 09:00, horario que ya tiene ocupado con la paciente Ana Lopez. Se
verifico con Python (`sqlite3`) que `trg_validar_choque_agenda` aborta
la operacion con el error `El medico ya tiene una cita programada en
esa fecha y hora`, y la cita no llega a registrarse. Es la misma
validacion que, en el procedimiento almacenado teorico, se resolveria
con un `SIGNAL SQLSTATE` (MySQL) o un `RAISE EXCEPTION` (PostgreSQL)
antes de ejecutar el `INSERT` interno.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-103.db < ddl/schema.sql
sqlite3 ejercicio-103.db < dml/inserts.sql
sqlite3 ejercicio-103.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
