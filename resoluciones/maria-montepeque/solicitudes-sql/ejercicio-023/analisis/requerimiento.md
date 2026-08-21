# Analisis del requerimiento - Ejercicio 023

## Solicitud entendida

Una plataforma de shooter administra clanes, sus jugadores, scrims (enfrentamientos amistosos entre clanes) en distintos mapas y sus resultados. El cliente pidio explicitamente evitar registros incompletos, porque despues no puede hacer reportes confiables: si un scrim no tiene marcador o mapa, no se puede saber con certeza quien gano ni construir un ranking de clanes.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clanes | Es el catalogo de clanes de la plataforma, cada uno con su region. | nombre_clan (unico), region |
| jugadores | Es el catalogo de jugadores, cada uno con su clan y rol. Un jugador siempre pertenece a un clan. | id_clan (FK), gamertag (unico), rol |
| scrims | Es el registro transaccional de cada enfrentamiento entre dos clanes: en que mapa, con que marcador y en que estado (jugado, disputado, anulado). Aqui es donde el cliente sufre los registros incompletos si el marcador o el mapa faltan. | id_clan_local (FK), id_clan_rival (FK), mapa, marcador_local, marcador_rival, fecha_scrim, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clanes -> jugadores | 1:N | Un clan tiene varios jugadores, pero cada jugador pertenece a un unico clan. |
| clanes -> scrims (local) | 1:N | Un clan participa en muchos scrims como local. |
| clanes -> scrims (rival) | 1:N | Un clan participa en muchos scrims como rival. Un scrim tiene dos llaves foraneas distintas hacia `clanes` (local y rival). |

## Reglas de negocio

- Regla 1: Todo scrim debe apuntar a dos clanes reales del catalogo (`FOREIGN KEY` doble), y ningun clan puede enfrentarse a si mismo (`CHECK id_clan_local <> id_clan_rival`).
- Regla 2: `mapa`, `marcador_local`, `marcador_rival` y `fecha_scrim` son `NOT NULL`: son exactamente los datos que, si faltaran, harian que un reporte de victorias no sea confiable.
- Regla 3: `marcador_local` y `marcador_rival` nunca pueden ser negativos (`CHECK`).
- Regla 4: Un scrim puede estar `jugado`, `disputado` o `anulado` (`CHECK`); la plataforma necesita poder corregir este estado cuando un resultado se pone en disputa (por ejemplo, revision de un replay) y luego se resuelve.
- Regla 5: `nombre_clan` y `gamertag` no se repiten (`UNIQUE`).

## Supuestos

- No se creo una tabla `mapas` separada: el mapa se guarda como texto con un `CHECK` de lista cerrada dentro de `scrims`, ya que el alcance de este nivel pide 2 a 3 tablas con relaciones uno a muchos, y el foco esta en clanes/jugadores/scrims.
- Un scrim `disputado` se corrige a `jugado` (confirmado) o `anulado` segun el resultado de la revision; no se borra mientras representa un enfrentamiento que realmente ocurrio.

## Preguntas que responde la base de datos

1. Que scrims existen y en que estado quedo cada uno.
2. Que scrims no estan confirmados todavia (disputados o anulados).
3. Que jugador o clan tiene mas actividad.
4. Como se ordenan los scrims por fecha.
5. Que clan tiene mas victorias (contando cuando gano como local o como rival), para armar un ranking confiable.
