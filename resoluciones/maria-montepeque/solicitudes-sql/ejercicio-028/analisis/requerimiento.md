# Analisis del requerimiento - Ejercicio 028

## Solicitud entendida

Una organizacion de esports registra equipos, jugadores, partidas y puntos. El cliente pidio explicitamente poder consultar rankings (jugador con mas puntos), totales (puntos por equipo) y casos pendientes (partidas cuyo resultado sigue en revision) directamente desde la base de datos.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Es el catalogo de equipos de la organizacion, cada uno con su region. | nombre_equipo (unico), region |
| jugadores | Es el catalogo de jugadores, cada uno con su equipo y rol. | id_equipo (FK), nickname (unico), rol |
| partidas | Es el registro transaccional de cada partida jugada por un jugador: puntos obtenidos, resultado y estado. Aqui viven directamente los rankings, totales y pendientes que pidio el cliente. | id_jugador (FK), puntos_obtenidos, resultado, fecha_partida, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene varios jugadores. |
| jugadores -> partidas | 1:N | Un jugador participa en muchas partidas a lo largo del torneo. |

## Reglas de negocio

- Regla 1: Todo jugador debe pertenecer a un equipo real (`FOREIGN KEY`), y toda partida debe apuntar a un jugador real (`FOREIGN KEY`).
- Regla 2: `puntos_obtenidos` nunca puede ser negativo (`CHECK`).
- Regla 3: `resultado` solo puede ser `victoria` o `derrota` (`CHECK`).
- Regla 4: Una partida puede estar `confirmada`, `pendiente` o `anulada` (`CHECK`); esto es exactamente lo que permite responder "casos pendientes" con una simple consulta filtrada.
- Regla 5: `nombre_equipo` y `nickname` no se repiten (`UNIQUE`).

## Supuestos

- El "ranking" que pide el cliente se interpreta como el jugador con mas puntos totales acumulados, y el "total" como la suma de puntos por equipo (agregando a traves de sus jugadores).
- Una partida `pendiente` representa un resultado que todavia esta en revision (por ejemplo, un posible desempate o reclamo); se corrige a `confirmada` una vez resuelta, sin borrarla.

## Preguntas que responde la base de datos

1. Que partidas existen y en que estado quedo cada una.
2. Que partidas estan pendientes (casos pendientes, tal como pidio el cliente).
3. Ranking: que jugador tiene mas puntos totales.
4. Como se ordenan las partidas por fecha.
5. Totales: cuantos puntos suma cada equipo (sumando a todos sus jugadores), para decidir a que equipo asignar el proximo torneo.
