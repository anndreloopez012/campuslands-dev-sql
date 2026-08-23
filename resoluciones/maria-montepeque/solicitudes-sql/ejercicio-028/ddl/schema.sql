PRAGMA foreign_keys = ON;

-- Ejercicio 028: Torneo Esports
-- Modelo: equipos -> jugadores (1:N) -> partidas (1:N).

CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL UNIQUE,
    region        TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo  INTEGER NOT NULL,
    nickname   TEXT NOT NULL UNIQUE,
    rol        TEXT NOT NULL CHECK (rol IN ('duelist', 'support', 'igl', 'entry')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- partidas: tabla principal. El estado permite responder directamente
-- la pregunta de "casos pendientes" que pidio el cliente.
CREATE TABLE partidas (
    id_partida       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_jugador       INTEGER NOT NULL,
    puntos_obtenidos INTEGER NOT NULL CHECK (puntos_obtenidos >= 0),
    resultado        TEXT NOT NULL CHECK (resultado IN ('victoria', 'derrota')),
    fecha_partida    TEXT NOT NULL DEFAULT (datetime('now')),
    estado           TEXT NOT NULL DEFAULT 'confirmada' CHECK (estado IN ('confirmada', 'pendiente', 'anulada')),

    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador)
);
