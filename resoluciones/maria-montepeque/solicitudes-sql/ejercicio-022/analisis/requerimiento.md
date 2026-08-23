# Analisis del requerimiento - Ejercicio 022

## Solicitud entendida

Una liga MOBA controla equipos, jugadores, heroes usados, bans, partidas y estadisticas. El cliente pidio saber quien jugo, que heroe uso, cuando ocurrio la partida y cuanto dinero represento (en esta liga, cada partida ganada reparte un premio en efectivo al jugador).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Es el catalogo de equipos de la liga, cada uno con su region. | nombre_equipo (unico), region |
| jugadores | Es el catalogo de jugadores, cada uno con su equipo y rol. Un jugador siempre pertenece a un equipo. | id_equipo (FK), nickname (unico), rol |
| partidas_jugadas | Es el registro transaccional de cada partida que jugo un jugador: con que heroe, cuando, si gano o perdio y cuanto dinero gano. Aqui vive directamente la pregunta del cliente (quien, que, cuando, cuanto). | id_jugador (FK), heroe_usado, fecha_partida, resultado, premio_ganado, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene varios jugadores, pero cada jugador pertenece a un unico equipo. |
| jugadores -> partidas_jugadas | 1:N | Un jugador participa en muchas partidas a lo largo del torneo, pero cada registro de partida es de un unico jugador. |

## Reglas de negocio

- Regla 1: Todo jugador debe pertenecer a un equipo real (`FOREIGN KEY`), y todo registro de partida debe pertenecer a un jugador real (`FOREIGN KEY`).
- Regla 2: `premio_ganado` nunca puede ser negativo (`CHECK`).
- Regla 3: `resultado` solo puede ser `victoria` o `derrota` (`CHECK`).
- Regla 4: Un registro de partida puede estar `confirmado`, `en_revision` o `anulado` (`CHECK`); la liga necesita poder corregir este estado cuando se investiga una sospecha de trampa o exploit.
- Regla 5: `nickname` y `nombre_equipo` no se repiten (`UNIQUE`).

## Supuestos

- No se creo una tabla `heroes` separada: el heroe usado se guarda como texto dentro de `partidas_jugadas`, ya que el alcance de este nivel pide 2 a 3 tablas con relaciones uno a muchos, y el foco esta en jugadores/equipos/partidas.
- El "dinero que representa cada movimiento" se interpreta como el premio en efectivo que reparte la liga por cada partida ganada; las derrotas quedan con `premio_ganado = 0`.
- Un registro `en_revision` se corrige a `confirmado` o `anulado` segun el resultado de la investigacion; no se borra mientras representa una partida que realmente se jugo.

## Preguntas que responde la base de datos

1. Que registros de partidas existen y en que estado quedo cada uno.
2. Que registros no estan confirmados todavia (en revision o anulados).
3. Que jugador tiene mas actividad (mas partidas jugadas).
4. Como se ordenan los registros por fecha de partida.
5. Cuanto dinero en premios genero cada equipo (sumando a todos sus jugadores), para decisiones de patrocinio.
