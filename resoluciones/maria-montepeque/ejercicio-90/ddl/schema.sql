PRAGMA foreign_keys = ON;

-- Ejercicio 90: GROUP BY Nivel Intermedio
-- Tema central: GROUP BY
-- Contexto: torneo de videojuegos, equipos y sus partidas.

CREATE TABLE equipos (
    id_equipo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo  TEXT NOT NULL UNIQUE,
    region         TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo       INTEGER NOT NULL,
    nombre_jugador  TEXT NOT NULL,
    gamer_tag       TEXT NOT NULL UNIQUE,

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE partidas (
    id_partida      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo       INTEGER NOT NULL,
    fecha_partida   TEXT NOT NULL,
    puntaje         INTEGER NOT NULL CHECK (puntaje >= 0),
    resultado       TEXT NOT NULL DEFAULT 'pendiente'
                        CHECK (resultado IN ('victoria', 'derrota', 'empate', 'pendiente')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);
