# Analisis del requerimiento - Ejercicio 078

## Solicitud entendida

Una organizacion de esports registra equipos, jugadores, partidas y
puntos. El cliente quiere consultar rankings, totales y casos
pendientes desde la base de datos: eso significa que el modelo debe
distinguir claramente que partidas ya se jugaron, cuales siguen
pendientes (programadas) y mantener un ranking de equipos que se
pueda consultar directamente, sin recalcularlo a mano cada vez.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Catalogo: cada equipo del torneo | nombre_equipo (unico), region |
| jugadores | Catalogo: cada jugador, miembro de un equipo | nickname (unico), id_equipo |
| partidas | Tabla transaccional: enfrentamiento entre dos equipos | fecha_partida, estado |
| estadisticas | Detalle de cada partida: puntos de cada jugador que participo | puntos |
| ranking | Resumen: puntos totales acumulados por equipo | puntos_totales |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene varios jugadores. |
| equipos -> partidas | 1:N (dos veces) | Un equipo juega muchas partidas, como local o como visitante. |
| partidas -> estadisticas | 1:N | Una partida tiene una fila de estadisticas por cada jugador que participo. |
| jugadores -> estadisticas | 1:N | Un jugador participa en muchas partidas distintas. |
| equipos -> ranking | 1:1 | Cada equipo tiene una sola fila de ranking, que se corrige con UPDATE. |

## Reglas de negocio

- Regla 1 (relaciones invalidas): toda estadistica debe apuntar a una
  partida y a un jugador reales (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `equipos.nombre_equipo` y
  `jugadores.nickname` no se repiten (`UNIQUE`); un jugador no puede
  tener dos filas de estadisticas en la misma partida
  (`UNIQUE (id_partida, id_jugador)`); cada equipo tiene una sola fila
  de ranking (`UNIQUE (id_equipo)` en `ranking`).
- Regla 3 (valores fuera de rango): `estadisticas.puntos` y
  `ranking.puntos_totales` nunca pueden ser negativos (`CHECK`).
- Regla 4: una partida nace `'programada'` (caso pendiente) y avanza a
  `'jugada'` o `'cancelada'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: las estadisticas solo tienen sentido para una partida que
  ya se jugo. Si una partida se cancela y ya tenia estadisticas
  cargadas por error, esas filas se eliminan; nunca se borra una
  estadistica de una partida `'jugada'`, porque ya es un resultado
  oficial. El ranking se recalcula con `UPDATE` solo a partir de las
  partidas `'jugada'` reales.

## Supuestos

- El cliente no detallo la formula de puntos por partida; se asume que
  cada jugador recibe una cantidad de puntos ya calculada externamente
  (por kills, objetivos, etc.) y aqui solo se registra el resultado
  final por jugador.
- Se asume que `ranking` es una tabla propia (no se calcula siempre al
  vuelo) porque el cliente pidio poder "consultar rankings... desde la
  base de datos", lo que sugiere un dato que se guarda y se corrige,
  no solo se calcula en cada consulta.
- No se detallo si un jugador puede cambiar de equipo; se asume que no
  para el alcance de este nivel.

## Preguntas que responde la base de datos

1. Que estadisticas existen, con que jugador y que partida.
2. Que partidas estan programadas (casos pendientes), jugadas o
   canceladas.
3. Que jugador tiene mas actividad (mas partidas con estadisticas
   registradas).
4. Como se ordena el ranking final, de mayor a menor puntaje.
5. Que equipos superan cierto puntaje total, para decidir quienes
   avanzan a la siguiente fase.
