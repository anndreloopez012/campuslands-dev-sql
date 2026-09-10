# Ejercicio 108: Indices Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Indices

## Descripcion del problema

Un torneo de videojuegos necesita consultar rapido "las partidas de
tal equipo" y, muchas veces, tambien "las partidas de tal equipo en
tal fecha", sin que SQLite tenga que revisar toda la tabla de
partidas cada vez.

## Tablas y relaciones

- `equipos`: catalogo de equipos.
- `jugadores`: catalogo de jugadores, cada uno de un equipo.
- `partidas`: tabla principal, cada fila es una partida con su
  `puntaje` y `fecha_partida`. `equipos` 1—N `jugadores`; `equipos`
  1—N `partidas`.

## Uso de Indices

En `ddl/schema.sql` se crea el indice compuesto
`idx_partidas_equipo_fecha` sobre `partidas (id_equipo,
fecha_partida)`. En `dql/consultas.sql`:

- La consulta 5 usa `EXPLAIN QUERY PLAN` sobre una busqueda por
  `id_equipo = 1 AND fecha_partida = '2026-08-10'` (las dos columnas
  del indice, en orden) y confirma `SEARCH partidas USING INDEX
  idx_partidas_equipo_fecha (id_equipo=? AND fecha_partida=?)`: el
  indice acelera la busqueda en vez de revisar las 10 filas una por
  una.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `jugadores.id_equipo`, `partidas.id_equipo`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `equipos.nombre_equipo`, `jugadores.gamer_tag`.
- `CHECK`: `partidas.puntaje >= 0`, `partidas.resultado IN (...)`.
- `DEFAULT` en `partidas.resultado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Esperar que `idx_partidas_equipo_fecha` tambien acelere una consulta
que filtra SOLO por `fecha_partida` (la columna de la derecha del
indice, sin `id_equipo`). Un indice compuesto solo sirve para
busquedas que usan su columna mas a la izquierda (`id_equipo`), sola o
junto con las siguientes; saltarsela invalida el indice para esa
consulta especifica ("regla del prefijo izquierdo"). Se verifico con
Python (`sqlite3`) que el `EXPLAIN QUERY PLAN` de
`WHERE fecha_partida = '2026-08-13'` muestra `SCAN partidas` (revisa
las 10 filas una por una), y NO `SEARCH ... USING INDEX
idx_partidas_equipo_fecha`, a pesar de que `fecha_partida` si forma
parte del indice.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-108.db < ddl/schema.sql
sqlite3 ejercicio-108.db < dml/inserts.sql
sqlite3 ejercicio-108.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
