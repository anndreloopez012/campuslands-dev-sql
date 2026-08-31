PRAGMA foreign_keys = ON;

-- Ejercicio 078: Torneo Esports
-- Modelo: equipos -> jugadores (1:N); equipos -> partidas (1:N, como
-- local y como visitante); partidas + jugadores -> estadisticas
-- (1:N cada una); equipos -> ranking (1:1).

CREATE TABLE equipos (
    id_equipo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo  TEXT NOT NULL UNIQUE,
    region         TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador   INTEGER PRIMARY KEY AUTOINCREMENT,
    nickname     TEXT NOT NULL UNIQUE,
    id_equipo    INTEGER NOT NULL,

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE partidas (
    id_partida            INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_local        INTEGER NOT NULL,
    id_equipo_visitante     INTEGER NOT NULL,
    fecha_partida            TEXT NOT NULL,
    estado                   TEXT NOT NULL DEFAULT 'programada'
                                 CHECK (estado IN ('programada', 'jugada', 'cancelada')),

    FOREIGN KEY (id_equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos (id_equipo)
);

-- estadisticas: el UNIQUE compuesto impide que un jugador quede
-- cargado dos veces en la misma partida.
CREATE TABLE estadisticas (
    id_estadistica   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partida       INTEGER NOT NULL,
    id_jugador       INTEGER NOT NULL,
    puntos           INTEGER NOT NULL DEFAULT 0 CHECK (puntos >= 0),

    FOREIGN KEY (id_partida) REFERENCES partidas (id_partida),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    UNIQUE (id_partida, id_jugador)
);

-- ranking: una sola fila por equipo (UNIQUE), que se corrige con
-- UPDATE a partir de las estadisticas de las partidas 'jugada'.
CREATE TABLE ranking (
    id_ranking       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo        INTEGER NOT NULL UNIQUE,
    puntos_totales   INTEGER NOT NULL DEFAULT 0 CHECK (puntos_totales >= 0),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);
