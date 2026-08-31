PRAGMA foreign_keys = ON;

-- Ejercicio 062: Club Futbol Sala
-- Modelo: equipos, jugadores, partidos, goles, tarjetas

CREATE TABLE equipos (
    id_equipo   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE
);

CREATE TABLE jugadores (
    id_jugador   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo    INTEGER NOT NULL,
    nombre       TEXT NOT NULL,
    posicion     TEXT NOT NULL CHECK (posicion IN ('portero', 'defensa', 'medio', 'delantero')),
    dorsal       INTEGER NOT NULL,

    -- Dos jugadores del mismo equipo no pueden compartir dorsal.
    UNIQUE (id_equipo, dorsal),
    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE partidos (
    id_partido            INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_local       INTEGER NOT NULL,
    id_equipo_visitante   INTEGER NOT NULL,
    fecha_partido         TEXT NOT NULL DEFAULT (date('now')),
    estado                TEXT NOT NULL DEFAULT 'programado'
                              CHECK (estado IN ('programado', 'en_curso', 'finalizado')),

    -- Un equipo no puede jugar contra si mismo.
    CHECK (id_equipo_local <> id_equipo_visitante),
    FOREIGN KEY (id_equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos (id_equipo)
);

CREATE TABLE goles (
    id_gol       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partido   INTEGER NOT NULL,
    id_jugador   INTEGER NOT NULL,
    minuto       INTEGER NOT NULL CHECK (minuto BETWEEN 1 AND 60),

    FOREIGN KEY (id_partido) REFERENCES partidos (id_partido),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador)
);

CREATE TABLE tarjetas (
    id_tarjeta   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partido   INTEGER NOT NULL,
    id_jugador   INTEGER NOT NULL,
    tipo         TEXT NOT NULL CHECK (tipo IN ('amarilla', 'roja')),
    minuto       INTEGER NOT NULL CHECK (minuto BETWEEN 1 AND 60),

    FOREIGN KEY (id_partido) REFERENCES partidos (id_partido),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador)
);
