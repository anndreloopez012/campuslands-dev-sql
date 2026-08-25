# Ejercicio 90: GROUP BY Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-25

## Tema central

GROUP BY

## Descripcion del problema

Un torneo de videojuegos necesita administrar las partidas y los
puntajes de cada equipo, para saber cuantas partidas juega cada uno y
que equipos tienen mejor rendimiento promedio.

## Tablas y relaciones

- `equipos`: catalogo de equipos.
- `jugadores`: catalogo de jugadores, cada uno pertenece a un equipo.
- `partidas`: tabla principal, con `puntaje` por partida jugada.
  `equipos` 1—N `jugadores`; `equipos` 1—N `partidas`.

## Uso de GROUP BY

En `dql/consultas.sql`:

1. Conteo simple: `GROUP BY id_equipo` con `COUNT(*)`, para saber
   cuantas partidas jugo cada equipo.
2. Suma y promedio con `HAVING`: la consulta 5 agrupa las partidas por
   equipo y calcula `SUM(puntaje)` y `AVG(puntaje)` por grupo, y usa
   `HAVING AVG(...) > 70` para quedarse solo con los equipos cuyo
   promedio supera los 70 puntos.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `jugadores.id_equipo`, `partidas.id_equipo`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `equipos.nombre_equipo`, `jugadores.gamer_tag`.
- `CHECK`: `partidas.puntaje >= 0`, `partidas.resultado IN (...)`.
- `DEFAULT` en `partidas.resultado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Agrupar por equipo (`GROUP BY e.id_equipo`) pero mostrar
`j.nombre_jugador` sin agregarlo ni incluirlo en el `GROUP BY`.
SQLite lo permite (a diferencia de MySQL en modo estricto
`ONLY_FULL_GROUP_BY`, donde fallaria), pero el valor de
`nombre_jugador` que devuelve es arbitrario: se verifico con Python
(`sqlite3`) que para "Dragones Digitales" (2 jugadores, 3 partidas)
el resultado muestra "Alejandra Chinchilla" y un `COUNT(*)` de 6 en
vez de 3, porque el `JOIN` con `jugadores` duplica cada partida por
cada jugador del equipo antes de agrupar. La version correcta (sin el
`JOIN` a `jugadores`) es la de la consulta 4.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-90.db < ddl/schema.sql
sqlite3 ejercicio-90.db < dml/inserts.sql
sqlite3 ejercicio-90.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
