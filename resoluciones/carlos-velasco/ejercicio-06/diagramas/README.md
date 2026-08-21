# Diagrama ER

El modelo de Torneo Esports utiliza cuatro tablas:

- `equipos`
- `jugadores`
- `partidas`
- `resultados`

La tabla `partidas` registra los enfrentamientos entre dos equipos y `resultados` almacena el marcador y el equipo ganador de cada partida.

```mermaid
erDiagram
    EQUIPOS ||--o{ JUGADORES : pertenece
    EQUIPOS ||--o{ PARTIDAS : participa_local
    EQUIPOS ||--o{ PARTIDAS : participa_visitante
    PARTIDAS ||--|| RESULTADOS : tiene
    EQUIPOS ||--o{ RESULTADOS : gana

    EQUIPOS {
        INTEGER id_equipo PK
        TEXT nombre UK
        TEXT region
        TEXT fecha_fundacion
    }

    JUGADORES {
        INTEGER id_jugador PK
        TEXT nickname UK
        TEXT nombre_completo
        TEXT rol
        INTEGER id_equipo FK
    }

    PARTIDAS {
        INTEGER id_partida PK
        INTEGER id_equipo_local FK
        INTEGER id_equipo_visitante FK
        TEXT fecha_partida
        TEXT fase
    }

    RESULTADOS {
        INTEGER id_resultado PK
        INTEGER id_partida FK UK
        INTEGER ganador_id_equipo FK
        INTEGER puntos_local
        INTEGER puntos_visitante
        INTEGER duracion_minutos
    }
```

## Relaciones

- Un equipo puede tener varios jugadores.
- Cada jugador pertenece a un equipo.
- Un equipo puede participar como local en múltiples partidas.
- Un equipo puede participar como visitante en múltiples partidas.
- Cada partida tiene exactamente un resultado.
- Un equipo puede ganar múltiples partidas.
- Cada resultado registra un único equipo ganador.

## Restricciones

- Todas las tablas poseen `PRIMARY KEY`.
- Las relaciones se implementan mediante `FOREIGN KEY`.
- Los nombres de equipos son únicos.
- Los nicknames de jugadores son únicos.
- Una partida no puede enfrentar al mismo equipo contra sí mismo.
- Los roles de jugadores están restringidos mediante `CHECK`.
- Las fases del torneo están restringidas mediante `CHECK`.
- Los puntos deben ser valores no negativos.
- La duración de una partida debe ser positiva.
- Una partida no puede terminar empatada.
- Cada partida puede tener un único resultado mediante `UNIQUE`.
- Las fechas utilizan formato ISO.