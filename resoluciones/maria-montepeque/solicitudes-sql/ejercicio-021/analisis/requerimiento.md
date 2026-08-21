# Analisis del requerimiento - Ejercicio 021

## Solicitud entendida

Una comunidad gamer registra partidas de battle royale, kills, posiciones finales y arma un ranking semanal. Hoy todo se maneja en hojas de calculo y varias personas duplican datos sin darse cuenta. El cliente pidio una base de datos con relaciones reales (no una sola tabla de texto), que permita corregir estados (por ejemplo, cuando una estadistica sospechosa entra en revision por posible trampa) y sacar reportes de ranking.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| jugadores | Es el catalogo de jugadores de la comunidad; un jugador participa en muchas partidas a lo largo del tiempo. | gamertag (unico), equipo, nivel |
| partidas | Es el catalogo de partidas jugadas (una partida = un mapa, una fecha, un total de jugadores); muchos jugadores participan en la misma partida. | mapa, fecha_partida, total_jugadores |
| estadisticas | Es la tabla de detalle que conecta un jugador con una partida especifica: cuantos kills hizo y en que posicion termino. Esta es la relacion muchos-a-muchos entre jugadores y partidas, resuelta con una tabla intermedia. | id_jugador (FK), id_partida (FK), kills, posicion_final, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| jugadores -> estadisticas | 1:N | Un jugador tiene muchas filas de estadisticas (una por cada partida que jugo). |
| partidas -> estadisticas | 1:N | Una partida tiene muchas filas de estadisticas (una por cada jugador que participo). |
| jugadores <-> partidas | N:M (via estadisticas) | Un jugador participa en muchas partidas y una partida tiene muchos jugadores; `estadisticas` es la tabla de detalle que resuelve esa relacion muchos-a-muchos, siguiendo el ejemplo de razonamiento del enunciado (separar `ventas` de `detalle_ventas`). |

## Reglas de negocio

- Regla 1: Toda estadistica debe apuntar a un jugador real y a una partida real (`FOREIGN KEY` doble).
- Regla 2: `kills` nunca puede ser negativo, y `posicion_final` siempre debe ser mayor a cero (`CHECK`).
- Regla 3: Una estadistica puede estar `confirmada`, `en_revision` o `anulada` (`CHECK`); el cliente necesita poder corregir este estado cuando una estadistica sospechosa (posible trampa) se investiga y se resuelve.
- Regla 4: `gamertag` no se repite (`UNIQUE`), identifica de forma unica a cada jugador.
- Regla 5: `mapa` solo puede ser uno de los mapas validos del juego (`CHECK`).

## Supuestos

- Se separo `estadisticas` de `jugadores` y `partidas` en vez de guardar los kills como una columna repetida en `jugadores`, siguiendo exactamente el ejemplo de razonamiento del enunciado: una tabla de detalle evita mezclar el catalogo (quien es el jugador, que partida se jugo) con el movimiento (que paso en esa combinacion especifica).
- El ranking semanal se calcula sumando `kills` y contando victorias (`posicion_final = 1`) por jugador sobre todas las partidas de la semana de prueba.
- Una estadistica `anulada` (por ejemplo, tras confirmarse una trampa) se conserva en el registro para trazabilidad, no se borra.

## Preguntas que responde la base de datos

1. Que estadisticas existen y en que estado quedo cada una.
2. Que estadisticas no estan confirmadas todavia (en revision o anuladas).
3. Que jugador tiene mas actividad (mas partidas jugadas).
4. Como se ordenan las estadisticas por fecha de partida.
5. Que ranking semanal (kills totales y victorias por jugador) puede usar la comunidad para premiar a los mejores jugadores.
