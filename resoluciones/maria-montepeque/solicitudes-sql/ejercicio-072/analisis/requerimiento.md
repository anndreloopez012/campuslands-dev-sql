# Analisis del requerimiento - Ejercicio 072

## Solicitud entendida

Una liga MOBA controla equipos, jugadores, heroes usados, partidas y
estadisticas. La cita del cliente habla de "quien compro, que compro,
cuando ocurrio y cuanto dinero representa cada movimiento": en el
contexto de una liga MOBA, ese "dinero" es el oro que cada jugador
consigue durante una partida (la moneda del juego), y "que compro" se
traduce en que heroe uso. Se necesita una base de datos que permita
consultar datos, corregir estados, registrar movimientos y sacar
reportes utiles, como que equipo genera mas oro o quien acumula mas
kills.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Catalogo: cada equipo de la liga | nombre_equipo (unico), region |
| jugadores | Catalogo: cada jugador, con su rol fijo dentro del equipo | nickname (unico), id_equipo, rol |
| heroes | Catalogo: cada heroe disponible en el juego | nombre_heroe (unico), rol_principal |
| partidas | Tabla transaccional: enfrentamiento entre dos equipos | fecha_partida, estado, id_equipo_ganador |
| estadisticas | Detalle de cada partida: que heroe uso cada jugador y su rendimiento (kills, muertes, asistencias, oro) | kills, muertes, asistencias, oro_conseguido |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene varios jugadores. |
| equipos -> partidas | 1:N (dos veces) | Un equipo juega muchas partidas, como local o como visitante. |
| partidas -> estadisticas | 1:N | Una partida tiene una fila de estadisticas por cada jugador que participo (hasta 10, 5 por equipo). |
| jugadores -> estadisticas | 1:N | Un jugador participa en muchas partidas a lo largo del torneo. |
| heroes -> estadisticas | 1:N | Un heroe se usa en muchas partidas distintas. |

## Reglas de negocio

- Regla 1 (relaciones invalidas): toda estadistica debe apuntar a una
  partida, un jugador y un heroe reales (`FOREIGN KEY` en cadena).
  `partidas.id_equipo_ganador` solo puede ser el equipo local o el
  equipo visitante de esa misma partida (`CHECK` que compara columnas
  de la misma fila), nunca un tercer equipo.
- Regla 2 (registros repetidos): `equipos.nombre_equipo`,
  `jugadores.nickname` y `heroes.nombre_heroe` no se repiten
  (`UNIQUE`); un jugador no puede tener dos filas de estadisticas en
  la misma partida (`UNIQUE (id_partida, id_jugador)`).
- Regla 3 (valores fuera de rango): `kills`, `muertes`, `asistencias`
  y `oro_conseguido` nunca pueden ser negativos (`CHECK`).
- Regla 4: una partida nace `'programada'` y solo puede avanzar a
  `'jugada'` o `'cancelada'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: las estadisticas solo tienen sentido para una partida que
  ya se jugo. Si una partida se cancela y ya tenia estadisticas
  cargadas por error, esas filas se eliminan; nunca se borra una
  estadistica de una partida `'jugada'`, porque ya es un resultado
  oficial del torneo.

## Supuestos

- El cliente no detallo bans de heroes; se asume que registrar el
  heroe usado por cada jugador en `estadisticas` cubre el alcance
  pedido ("heroes usados"), sin agregar una tabla extra de bans para
  mantener el modelo dentro de las 5 tablas sugeridas.
- Se interpreta "cuanto dinero representa cada movimiento" como el oro
  del juego que cada jugador consigue en cada partida
  (`oro_conseguido`), ya que no aplica un pago real en este dominio.
- Se asume que cada jugador tiene un rol fijo dentro de su equipo
  (`top`, `jungla`, `medio`, `tirador`, `soporte`), y que puede usar
  cualquier heroe compatible con ese rol o no, segun la estrategia del
  equipo.

## Preguntas que responde la base de datos

1. Que estadisticas existen, con que jugador, que heroe y que partida.
2. Que partidas estan programadas, jugadas o canceladas.
3. Que jugador tiene mas kills acumulados (ranking de actividad).
4. Como se ordenan las estadisticas por oro conseguido.
5. Que equipo genero mas oro en total, para decidir cual domina
   economicamente la liga.
