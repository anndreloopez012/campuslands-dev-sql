PRAGMA foreign_keys = ON;

-- Ejercicio 072: Liga MOBA
-- Modelo: equipos -> jugadores (1:N); equipos -> partidas (1:N,
-- como local y como visitante); heroes + partidas + jugadores ->
-- estadisticas (1:N cada una).

CREATE TABLE equipos (
    id_equipo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo  TEXT NOT NULL UNIQUE,
    region         TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador   INTEGER PRIMARY KEY AUTOINCREMENT,
    nickname     TEXT NOT NULL UNIQUE,
    id_equipo    INTEGER NOT NULL,
    rol          TEXT NOT NULL CHECK (rol IN ('top', 'jungla', 'medio', 'tirador', 'soporte')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE heroes (
    id_heroe        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_heroe    TEXT NOT NULL UNIQUE,
    rol_principal   TEXT NOT NULL
);

-- id_equipo_ganador es NULL mientras no se confirme el resultado; el
-- CHECK obliga a que, si se llena, sea uno de los dos equipos que
-- realmente jugaron esa partida.
CREATE TABLE partidas (
    id_partida           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_local       INTEGER NOT NULL,
    id_equipo_visitante   INTEGER NOT NULL,
    fecha_partida         TEXT NOT NULL,
    estado                TEXT NOT NULL DEFAULT 'programada'
                              CHECK (estado IN ('programada', 'jugada', 'cancelada')),
    id_equipo_ganador     INTEGER,

    FOREIGN KEY (id_equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_ganador) REFERENCES equipos (id_equipo),
    CHECK (
        id_equipo_ganador IS NULL
        OR id_equipo_ganador = id_equipo_local
        OR id_equipo_ganador = id_equipo_visitante
    )
);

-- estadisticas: detalle de cada partida. El UNIQUE compuesto impide
-- que un jugador quede cargado dos veces en la misma partida.
CREATE TABLE estadisticas (
    id_estadistica   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partida       INTEGER NOT NULL,
    id_jugador       INTEGER NOT NULL,
    id_heroe         INTEGER NOT NULL,
    kills            INTEGER NOT NULL DEFAULT 0 CHECK (kills >= 0),
    muertes          INTEGER NOT NULL DEFAULT 0 CHECK (muertes >= 0),
    asistencias      INTEGER NOT NULL DEFAULT 0 CHECK (asistencias >= 0),
    oro_conseguido   INTEGER NOT NULL DEFAULT 0 CHECK (oro_conseguido >= 0),

    FOREIGN KEY (id_partida) REFERENCES partidas (id_partida),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    FOREIGN KEY (id_heroe) REFERENCES heroes (id_heroe),
    UNIQUE (id_partida, id_jugador)
);
