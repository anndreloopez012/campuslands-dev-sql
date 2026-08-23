# Analisis del requerimiento - Ejercicio 048

## Solicitud entendida

Una plataforma de shooter administra clanes, scrims (partidas de practica contra otro clan), mapas y resultados. El cliente quiere poder consultar rankings, totales y casos pendientes directamente desde la base de datos. Es nivel 3: se pide `DELETE` controlado con criterios de negocio reales.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clanes | Es el catalogo de clanes: tanto el propio como los rivales contra los que se practica. | nombre_clan (unico), tag (unico), region |
| jugadores | Es el catalogo de jugadores del clan propio. | nombre_jugador (unico), id_clan (FK), rol |
| mapas | Es el catalogo de mapas disponibles para jugar. | nombre_mapa (unico), modo |
| scrims | Es el registro de cada scrim (partida de practica): contra que clan rival, en que mapa, cuando, cuantas rondas se ganaron y perdieron, y en que estado va. Aqui es donde se sacan los rankings y se detectan los casos pendientes. | id_clan_rival (FK), id_mapa (FK), fecha_scrim, rondas_ganadas, rondas_perdidas, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clanes -> jugadores | 1:N | Un clan tiene varios jugadores. |
| clanes -> scrims | 1:N | Un clan (como rival) puede aparecer en varios scrims. |
| mapas -> scrims | 1:N | Un mapa puede jugarse en varios scrims. |

## Reglas de negocio

- Regla 1: Todo jugador debe apuntar a un clan real; todo scrim debe apuntar a un clan rival real y a un mapa real (`FOREIGN KEY` en cadena).
- Regla 2: `region`, `rol` y `modo` son `NOT NULL`.
- Regla 3: `rondas_ganadas` y `rondas_perdidas` nunca pueden ser negativas (`CHECK`).
- Regla 4: `nombre_clan`, `tag`, `nombre_jugador` y `nombre_mapa` no se repiten (`UNIQUE`).
- Regla 5: Un scrim puede estar `programado`, `jugado` o `cancelado` (`CHECK`); se corrige con `UPDATE` a medida que se juega.
- Regla 6: Solo se permite `DELETE` de un scrim cuando esta `cancelado` **y** nunca se jugo ninguna ronda (`rondas_ganadas = 0 AND rondas_perdidas = 0`). Un scrim cancelado que ya tiene rondas registradas no se borra.

## Supuestos

- `id_clan_rival` en `scrims` apunta al mismo catalogo `clanes` que usa `jugadores.id_clan`: el clan propio (id_clan = 1) es el que tiene jugadores registrados; los demas clanes del catalogo solo aparecen como rivales en `scrims`.

## Preguntas que responde la base de datos

1. Que scrims existen, con que clan rival y que mapa.
2. Que scrims no estan jugados todavia (casos pendientes).
3. Contra que clan rival se ha jugado mas (ranking de actividad).
4. Como se ordenan los scrims por fecha.
5. Cual es el ratio de victoria contra cada clan rival, para decidir contra quien practicar mas (totales para tomar una decision).
