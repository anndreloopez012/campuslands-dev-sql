# Ejercicio 72: INSERT Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

INSERT

## Descripcion del problema

Un torneo regional de videojuegos juega en formato ida y vuelta: cada
enfrentamiento tiene una partida de ida y, una semana despues, una
partida de vuelta con los mismos equipos pero local y visitante
invertidos. El negocio necesita cargar equipos y jugadores, registrar
los resultados de la jornada 1, y generar automaticamente la jornada 2
a partir de esos resultados.

## Tablas y relaciones

- `equipos`: catalogo de equipos participantes.
- `jugadores`: catalogo de jugadores, cada uno ligado a un equipo.
- `partidas`: relaciona un equipo local con un equipo visitante en una
  fecha, con puntaje y estado. `equipos` 1—N `jugadores`; `equipos`
  1—N `partidas` (dos veces: como local y como visitante).

## Uso de INSERT

En `dml/inserts.sql`:

1. `INSERT` de una sola fila: se registra el primer equipo.
2. `INSERT` multiple (`VALUES (...), (...)`): el resto de equipos,
   los jugadores y las 2 partidas de la jornada 1 (ya jugadas, con
   puntaje y estado explicitos).
3. `INSERT ... SELECT`: la jornada 2 se genera automaticamente a
   partir de la jornada 1, seleccionando cada partida `jugada` e
   invirtiendo `id_equipo_local`/`id_equipo_visitante`, con la fecha
   movida una semana (`date(fecha_partida, '+7 days')`). No se
   escriben `puntaje_local`, `puntaje_visitante` ni `estado`: quedan
   en su `DEFAULT` (`0`, `0`, `'programada'`) porque esos partidos
   todavia no se juegan.

La consulta 5 en `dql/consultas.sql` confirma que cada partida jugada
de la jornada 1 tiene su partida de vuelta programada, con los equipos
correctamente invertidos.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `jugadores.id_equipo`, `partidas.id_equipo_local`,
  `partidas.id_equipo_visitante`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `equipos.nombre_equipo`.
- `CHECK`: `partidas.estado IN (...)`, `puntaje_local >= 0`,
  `puntaje_visitante >= 0`.
- `DEFAULT` en `partidas.puntaje_local`, `puntaje_visitante` y
  `estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Casos que fallan / no recomendables (comentados en `dml/inserts.sql`)

Uno por cada restriccion, validado con Python (`sqlite3`):

- Repetir `nombre_equipo` -> `UNIQUE constraint failed`.
- Apuntar a un `id_equipo` que no existe -> `FOREIGN KEY constraint failed`.
- Escribir un `estado` fuera de la lista permitida -> `CHECK constraint failed`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 4 equipos, 5 jugadores, 4 partidas (2 jugadas de
  ida, 2 programadas de vuelta generadas con `INSERT ... SELECT`).

## Como ejecutar

```bash
sqlite3 ejercicio-72.db < ddl/schema.sql
sqlite3 ejercicio-72.db < dml/inserts.sql
sqlite3 ejercicio-72.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
