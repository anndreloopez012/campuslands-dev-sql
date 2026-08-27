PRAGMA foreign_keys = ON;

CREATE TABLE equipos (
    id_equipo INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE
);

CREATE TABLE jugadores (
    id_jugador INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo INTEGER NOT NULL,
    nickname TEXT NOT NULL UNIQUE,
    rol TEXT NOT NULL CHECK (rol IN ('duelist', 'support', 'entry', 'igl', 'sniper')),
    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE partidas (
    id_partida INTEGER PRIMARY KEY AUTOINCREMENT,
    equipo_local INTEGER NOT NULL,
    equipo_visitante INTEGER NOT NULL,
    fecha_partida TEXT NOT NULL,
    mapa TEXT NOT NULL,
    FOREIGN KEY (equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (equipo_visitante) REFERENCES equipos (id_equipo),
    CHECK (equipo_local <> equipo_visitante)
);

CREATE TABLE resultados (
    id_resultado INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partida INTEGER NOT NULL,
    id_jugador INTEGER NOT NULL,
    kills INTEGER NOT NULL CHECK (kills >= 0),
    muertes INTEGER NOT NULL CHECK (muertes >= 0),
    puntos INTEGER NOT NULL CHECK (puntos >= 0),
    FOREIGN KEY (id_partida) REFERENCES partidas (id_partida),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    UNIQUE (id_partida, id_jugador)
);
