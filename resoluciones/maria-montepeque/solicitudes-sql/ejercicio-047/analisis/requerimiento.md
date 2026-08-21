# Analisis del requerimiento - Ejercicio 047

## Solicitud entendida

Una liga MOBA controla equipos, heroes usados, bans, partidas y estadisticas. El cliente pide que el sistema permita corregir estados sin borrar informacion importante: si una partida se invalida por un bug reportado, o si se corrige una estadistica tras revisar la repeticion, eso se hace con `UPDATE`, no con `DELETE`. Es nivel 3: se pide `DELETE` controlado con criterios de negocio reales.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Es el catalogo de equipos de la liga (tanto el propio como los rivales). | nombre_equipo (unico), region |
| heroes | Es el catalogo de heroes jugables. | nombre_heroe (unico), rol |
| jugadores | Es el catalogo de jugadores del equipo propio. | nombre_jugador (unico), id_equipo (FK), posicion |
| partidas | Es el registro de la actuacion de cada jugador en cada partida: que heroe uso, contra que equipo, cuantos kills/deaths/assists tuvo, si gano y en que estado quedo el registro. Aqui es donde la liga corrige informacion sin borrarla. | id_jugador (FK), id_heroe (FK), id_equipo_rival (FK), fecha_partida, kills, deaths, assists, resultado, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene varios jugadores. |
| jugadores -> partidas | 1:N | Un jugador tiene muchos registros de partida. |
| heroes -> partidas | 1:N | Un heroe puede usarse en muchas partidas. |
| equipos -> partidas | 1:N | Un equipo (como rival) aparece en muchas partidas. |

## Reglas de negocio

- Regla 1: Toda partida debe apuntar a un jugador real, a un heroe real y a un equipo rival real (`FOREIGN KEY` triple); todo jugador debe apuntar a un equipo real.
- Regla 2: `region`, `rol` y `posicion` son `NOT NULL`.
- Regla 3: `kills`, `deaths` y `assists` nunca pueden ser negativos (`CHECK`).
- Regla 4: `resultado` solo puede ser `victoria` o `derrota` (`CHECK`).
- Regla 5: `nombre_equipo`, `nombre_heroe` y `nombre_jugador` no se repiten (`UNIQUE`).
- Regla 6: Una partida puede estar `valida`, `en_revision` o `anulada` (`CHECK`); la liga corrige este estado (y si hace falta, tambien los numeros de kills/deaths/assists) con `UPDATE`, sin borrar el registro. Una partida anulada por un bug conserva sus estadisticas completas como evidencia.
- Regla 7: Solo se permite `DELETE` de una partida cuando esta `anulada` **y** nunca genero ninguna estadistica real (`kills = 0 AND deaths = 0 AND assists = 0`, por ejemplo por una desconexion del servidor antes de que empezara el combate). Una partida anulada que si tiene estadisticas reales no se borra.

## Supuestos

- "Bans" (heroes prohibidos antes de la partida) se menciona en el contexto pero no se modelo como tabla aparte: el alcance de este nivel es 3 a 4 tablas, y lo que el cliente necesita rastrear con precision son los heroes que si se jugaron, no los que se banearon.
- `id_equipo_rival` en `partidas` apunta al mismo catalogo `equipos` que usa `jugadores.id_equipo`: un equipo de la liga puede aparecer tanto como equipo propio de un jugador como rival en la partida de otro.

## Preguntas que responde la base de datos

1. Que partidas existen, con que jugador, que heroe y que equipo rival.
2. Que partidas no estan validas todavia.
3. Que jugador tiene mas partidas jugadas.
4. Como se ordenan las partidas por fecha.
5. Que jugador tiene el mejor KDA (solo partidas validas), para decidir a quien priorizar en el proximo draft.
