# Ejercicio 74: UPDATE Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

UPDATE

## Descripcion del problema

Un torneo de videojuegos registra sus partidas todas como
`'programada'` con puntaje 0-0 apenas se arma el calendario. Los
resultados reales, las cancelaciones y las correcciones se aplican
despues, una por una, con `UPDATE`.

## Tablas y relaciones

- `equipos`: catalogo de equipos participantes.
- `jugadores`: catalogo de jugadores, cada uno ligado a un equipo.
- `partidas`: tabla principal de este ejercicio. Relaciona un equipo
  local con un equipo visitante en una fecha, con puntaje y estado.
  `equipos` 1—N `jugadores`; `equipos` 1—N `partidas` (dos veces:
  como local y como visitante).

## Uso de UPDATE

En `dml/inserts.sql`, despues de insertar las 4 partidas (todas
`'programada'`, 0-0):

1. `UPDATE` de una sola fila (dos veces): llegan los resultados reales
   de las partidas 1 y 2, cada uno con su propio `WHERE id_partida = ...`.
2. `UPDATE` multiple: las partidas 3 y 4 se cancelan juntas por un
   problema con el estadio, con un solo `UPDATE` y
   `WHERE id_partida IN (3, 4)`.
3. `UPDATE` con expresion: la revision en video anula un gol que ya se
   habia contado de mas en la partida 1. En vez de escribir el
   resultado final a mano, se usa
   `SET puntaje_local = puntaje_local - 1`, que calcula el nuevo valor
   a partir del que ya tenia la columna.

La consulta 5 en `dql/consultas.sql` confirma el estado final de las
partidas 1, 3 y 4 despues de todos estos `UPDATE`.

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

## Caso que falla / no recomendable (comentado en `dml/inserts.sql`)

`UPDATE partidas SET estado = 'suspendida' WHERE id_partida = 1;`
falla porque `'suspendida'` no esta en la lista de valores permitidos
por el `CHECK` de `estado`. Se valido con Python (`sqlite3`): lanza
`CHECK constraint failed`. Ademas se dejo una nota (sin ejecutar)
sobre por que cada `UPDATE` de este archivo usa un `WHERE` especifico:
un `UPDATE` sin `WHERE` habria modificado las 4 partidas a la vez.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 4 equipos, 4 jugadores, 4 partidas (2 `jugada`, 2
  `cancelada`). Partida 1 terminada 2-1 despues de la correccion por
  video.

## Como ejecutar

```bash
sqlite3 ejercicio-74.db < ddl/schema.sql
sqlite3 ejercicio-74.db < dml/inserts.sql
sqlite3 ejercicio-74.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
