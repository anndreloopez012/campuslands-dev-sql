PRAGMA foreign_keys = ON;

-- Ejercicio 053: Torneo Esports
-- Modelo: equipos -> jugadores (1:N), y jugadores + partidas ->
-- estadisticas (doble FOREIGN KEY); equipos tambien alimenta
-- partidas como rival. 4 tablas en total.

CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL UNIQUE,
    region        TEXT NOT NULL CHECK (region IN ('LATAM', 'NA', 'EU', 'APAC'))
);

CREATE TABLE jugadores (
    id_jugador     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_jugador TEXT NOT NULL UNIQUE,
    id_equipo      INTEGER NOT NULL,
    rol            TEXT NOT NULL CHECK (rol IN ('titular', 'suplente', 'capitan')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- partidas: fecha_partida y resultado son NOT NULL a proposito, para
-- que ningun registro quede incompleto (la queja central del cliente).
CREATE TABLE partidas (
    id_partida       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_rival  INTEGER NOT NULL,
    fecha_partida    TEXT NOT NULL,
    resultado        TEXT NOT NULL CHECK (resultado IN ('victoria', 'derrota')),
    estado           TEXT NOT NULL DEFAULT 'programada' CHECK (estado IN ('programada', 'jugada', 'pospuesta')),

    FOREIGN KEY (id_equipo_rival) REFERENCES equipos (id_equipo)
);

CREATE TABLE estadisticas (
    id_estadistica  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_jugador      INTEGER NOT NULL,
    id_partida      INTEGER NOT NULL,
    puntos          INTEGER NOT NULL DEFAULT 0 CHECK (puntos >= 0),
    asistencias     INTEGER NOT NULL DEFAULT 0 CHECK (asistencias >= 0),

    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    FOREIGN KEY (id_partida) REFERENCES partidas (id_partida)
);
