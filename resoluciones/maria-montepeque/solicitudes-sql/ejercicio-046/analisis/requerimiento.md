# Analisis del requerimiento - Ejercicio 046

## Solicitud entendida

Una comunidad gamer registra partidas, kills, posiciones y ranking semanal. El cliente pide explicitamente diferenciar catalogos, operaciones y resultados para no mezclar informacion permanente con movimientos. Es nivel 3: se pide `DELETE` controlado con criterios de negocio.

## Entidades detectadas

El modelo se organizo exactamente en los tres grupos que pidio el cliente:

| Grupo | Entidad | Por que existe | Atributos importantes |
| --- | --- | --- | --- |
| Catalogo | jugadores | Informacion permanente de cada jugador. | nombre_jugador (unico), plataforma |
| Catalogo | temporadas | Informacion permanente de cada temporada competitiva. | nombre_temporada (unico), fecha_inicio, fecha_fin, estado |
| Operacion | partidas | Un movimiento: una partida que se jugo, en que temporada y en que mapa. | id_temporada (FK), fecha_partida, mapa, estado |
| Resultado | estadisticas | El resultado de un jugador en una partida especifica: kills, posicion final y puntos ganados. | id_partida (FK), id_jugador (FK), kills, posicion_final, puntos |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| temporadas -> partidas | 1:N | Una temporada tiene muchas partidas. |
| partidas -> estadisticas | 1:N | Una partida genera el resultado de varios jugadores. |
| jugadores -> estadisticas | 1:N | Un jugador acumula resultados en muchas partidas. |

## Reglas de negocio

- Regla 1: Toda partida debe apuntar a una temporada real; toda estadistica debe apuntar a una partida real y a un jugador real (`FOREIGN KEY` en cadena).
- Regla 2: `plataforma`, `mapa`, `fecha_inicio`, `fecha_fin` y `fecha_partida` son `NOT NULL`.
- Regla 3: `fecha_fin` de una temporada siempre debe ser posterior a `fecha_inicio` (`CHECK`).
- Regla 4: `kills` y `puntos` nunca pueden ser negativos, y `posicion_final` siempre debe ser mayor a cero (`CHECK`).
- Regla 5: `nombre_jugador` y `nombre_temporada` no se repiten (`UNIQUE`).
- Regla 6: Una partida puede estar `en_curso`, `finalizada` o `anulada` (`CHECK`); el sistema corrige este estado con `UPDATE`.
- Regla 7: Solo se permite `DELETE` de una partida cuando esta `anulada` **y** no tiene ninguna estadistica registrada (se cayo el servidor antes de que se generara cualquier resultado). Una partida anulada que ya tiene estadisticas registradas (por ejemplo, se alcanzo a guardar resultados parciales antes de la caida) no se borra: se conserva como historial.

## Supuestos

- El "ranking semanal" que menciona el contexto se interpreta como el ranking de puntos acumulados en la temporada `activa`, calculado con una consulta (no se guarda una tabla de ranking aparte), porque es un resultado derivado de `estadisticas` y no informacion permanente nueva.

## Preguntas que responde la base de datos

1. Que partidas existen, con que temporada.
2. Que partidas no estan finalizadas todavia.
3. Que jugador tiene mas partidas jugadas (mas actividad).
4. Como se ordenan las partidas por fecha.
5. Ranking de puntos de la temporada activa, para decidir a quien reconocer esta temporada.
