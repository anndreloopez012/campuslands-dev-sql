# Analisis del requerimiento - Ejercicio 037

## Solicitud entendida

Un club registra jugadores, partidos, goles, tarjetas y posiciones. El cliente pide explicitamente que el sistema permita corregir estados sin borrar informacion importante: si un partido se suspende o un arbitro corrige un gol o una tarjeta despues de revisar el video, el club necesita `UPDATE`, no `DELETE`.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Es el catalogo de equipos: tanto el club propio como los rivales que enfrenta. | nombre_equipo (unico), ciudad |
| jugadores | Es el catalogo de jugadores del club, cada uno con su posicion y su equipo. | nombre_jugador (unico), posicion, id_equipo (FK) |
| partidos | Es el registro transaccional de la actuacion de cada jugador en cada partido: contra que equipo, cuando, cuantos goles metio, si recibio tarjeta y en que estado quedo el partido. Aqui es donde el club corrige informacion sin borrarla. | id_jugador (FK), id_equipo_rival (FK), fecha_partido, goles, tarjeta, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo (el club) puede tener muchos jugadores. |
| jugadores -> partidos | 1:N | Un jugador puede tener muchos registros de partido. |
| equipos -> partidos | 1:N | Un equipo (como rival) puede aparecer en muchos partidos. |

## Reglas de negocio

- Regla 1: Todo registro de partido debe apuntar a un jugador real y a un equipo rival real (`FOREIGN KEY` doble).
- Regla 2: `ciudad` y `posicion` son `NOT NULL`: son datos que, si faltaran, romperian la ficha basica del equipo o del jugador.
- Regla 3: `goles` nunca puede ser negativo (`CHECK`).
- Regla 4: `tarjeta` solo puede ser `ninguna`, `amarilla` o `roja` (`CHECK`).
- Regla 5: Un partido puede estar `programado`, `jugado` o `suspendido` (`CHECK`); el club necesita poder corregir este estado (por ejemplo, si se suspende por clima) sin borrar el registro.
- Regla 6: `nombre_equipo` y `nombre_jugador` no se repiten (`UNIQUE`).

## Supuestos

- `equipos` funciona como catalogo unico tanto para el club propio (`Deportivo Real`, del que salen los `jugadores`) como para los rivales que aparecen en `partidos`, porque ambos son "equipos" en el mismo sentido y no hay razon para separarlos en dos catalogos distintos.
- Cada fila de `partidos` representa la actuacion de un jugador en un partido especifico contra un rival (no el resultado global del partido), porque lo que el cliente quiere rastrear son goles y tarjetas por jugador.

## Preguntas que responde la base de datos

1. Que partidos existen, con que jugador y contra que equipo.
2. Que partidos no se han jugado todavia.
3. Que jugador tiene mas goles en total.
4. Como se ordenan los partidos por fecha.
5. Que jugadores estan en riesgo de sancion (dos o mas tarjetas amarillas, o alguna roja), para decidir a quien cuidar en el siguiente partido.
