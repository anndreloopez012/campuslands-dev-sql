# Analisis del requerimiento - Ejercicio 053

## Solicitud entendida

Una organizacion de esports registra equipos, jugadores, partidas y puntos. El cliente quiere evitar registros incompletos porque despues no puede hacer reportes confiables. Es nivel 3: se pide `DELETE` controlado con criterios de negocio reales.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Es el catalogo de equipos: tanto el propio como los rivales. | nombre_equipo (unico), region |
| jugadores | Es el catalogo de jugadores del equipo propio. | nombre_jugador (unico), id_equipo (FK), rol |
| partidas | Es el registro de cada partida contra un equipo rival: cuando, el resultado y en que estado va. | id_equipo_rival (FK), fecha_partida, resultado, estado |
| estadisticas | Es el registro de los puntos y asistencias que gano cada jugador en cada partida. | id_jugador (FK), id_partida (FK), puntos, asistencias |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene varios jugadores. |
| equipos -> partidas | 1:N | Un equipo (como rival) aparece en varias partidas. |
| jugadores -> estadisticas | 1:N | Un jugador acumula estadisticas en muchas partidas. |
| partidas -> estadisticas | 1:N | Una partida genera estadisticas de varios jugadores. |

## Reglas de negocio

- Regla 1: Todo jugador debe apuntar a un equipo real; toda partida debe apuntar a un equipo rival real; toda estadistica debe apuntar a un jugador real y a una partida real (`FOREIGN KEY` en cadena).
- Regla 2: `region`, `rol`, `fecha_partida` y `resultado` son `NOT NULL`: son justo los datos que, si faltaran, dejarian un registro incompleto e inutil para un reporte (la queja central del cliente).
- Regla 3: `puntos` y `asistencias` nunca pueden ser negativos (`CHECK`).
- Regla 4: `nombre_equipo` y `nombre_jugador` no se repiten (`UNIQUE`).
- Regla 5: Una partida puede estar `programada`, `jugada` o `pospuesta` (`CHECK`); se corrige con `UPDATE` a medida que se juega.
- Regla 6: Solo se permite `DELETE` de una partida cuando esta `pospuesta` **y** no tiene ninguna estadistica registrada (nunca se llego a jugar). Una partida pospuesta que ya genero estadisticas no se borra.

## Supuestos

- `id_equipo_rival` en `partidas` apunta al mismo catalogo `equipos` que usa `jugadores.id_equipo`: el equipo propio (id_equipo = 1) es el unico con jugadores registrados; los demas equipos solo aparecen como rivales en `partidas`.

## Preguntas que responde la base de datos

1. Que partidas existen, con que equipo rival.
2. Que partidas no estan jugadas todavia.
3. Que jugador tiene mas partidas jugadas (mas actividad).
4. Como se ordenan las partidas por fecha.
5. Que jugador tiene el mejor promedio de puntos por partida, para decidir el MVP del equipo.
