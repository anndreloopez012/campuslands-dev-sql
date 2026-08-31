PRAGMA foreign_keys = ON;

-- Ejercicio 72: INSERT Nivel Intermedio
-- Tema central: INSERT
-- Contexto: torneo regional de videojuegos, formato ida y vuelta.

CREATE TABLE equipos (
    id_equipo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo  TEXT NOT NULL UNIQUE,
    region         TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    id_equipo    INTEGER NOT NULL,

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE partidas (
    id_partida           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_local       INTEGER NOT NULL,
    id_equipo_visitante   INTEGER NOT NULL,
    fecha_partida         TEXT NOT NULL,
    puntaje_local          INTEGER NOT NULL DEFAULT 0 CHECK (puntaje_local >= 0),
    puntaje_visitante      INTEGER NOT NULL DEFAULT 0 CHECK (puntaje_visitante >= 0),
    estado                 TEXT NOT NULL DEFAULT 'programada'
                               CHECK (estado IN ('programada', 'jugada', 'cancelada')),

    FOREIGN KEY (id_equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos (id_equipo)
);
