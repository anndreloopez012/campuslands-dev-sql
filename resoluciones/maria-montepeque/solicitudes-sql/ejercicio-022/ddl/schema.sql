PRAGMA foreign_keys = ON;

-- Ejercicio 022: Liga MOBA
-- Modelo: equipos -> jugadores -> partidas_jugadas (cadena de relaciones
-- uno a muchos).

CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL UNIQUE,
    region        TEXT NOT NULL CHECK (region IN ('LATAM', 'NA', 'EU', 'ASIA'))
);

CREATE TABLE jugadores (
    id_jugador INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo  INTEGER NOT NULL,
    nickname   TEXT NOT NULL UNIQUE,
    rol        TEXT NOT NULL CHECK (rol IN ('top', 'jungla', 'medio', 'tirador', 'soporte')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- partidas_jugadas: tabla principal. Responde quien (jugador), que
-- (heroe_usado), cuando (fecha_partida) y cuanto dinero representa
-- (premio_ganado).
CREATE TABLE partidas_jugadas (
    id_registro    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_jugador     INTEGER NOT NULL,
    heroe_usado    TEXT NOT NULL,
    fecha_partida  TEXT NOT NULL DEFAULT (datetime('now')),
    resultado      TEXT NOT NULL CHECK (resultado IN ('victoria', 'derrota')),
    premio_ganado  REAL NOT NULL DEFAULT 0 CHECK (premio_ganado >= 0),
    estado         TEXT NOT NULL DEFAULT 'confirmado' CHECK (estado IN ('confirmado', 'en_revision', 'anulado')),

    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador)
);
