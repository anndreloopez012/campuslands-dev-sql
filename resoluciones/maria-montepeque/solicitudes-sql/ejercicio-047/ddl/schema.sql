PRAGMA foreign_keys = ON;

-- Ejercicio 047: Liga MOBA
-- Modelo: equipos -> jugadores (1:N), y jugadores + heroes + equipos
-- (como rival) -> partidas (triple FOREIGN KEY). 4 tablas en total.

CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL UNIQUE,
    region        TEXT NOT NULL CHECK (region IN ('LATAM', 'NA', 'EU', 'APAC'))
);

CREATE TABLE heroes (
    id_heroe     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_heroe TEXT NOT NULL UNIQUE,
    rol          TEXT NOT NULL CHECK (rol IN ('tanque', 'asesino', 'soporte', 'tirador', 'mago'))
);

CREATE TABLE jugadores (
    id_jugador     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_jugador TEXT NOT NULL UNIQUE,
    id_equipo      INTEGER NOT NULL,
    posicion       TEXT NOT NULL CHECK (posicion IN ('carril_superior', 'jungla', 'carril_medio', 'tirador', 'soporte')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- partidas: tabla principal. El estado (y si hace falta, las
-- estadisticas) se corrigen con UPDATE, nunca con DELETE, salvo el
-- caso muy especifico de una partida anulada sin ninguna estadistica
-- real (ver dml/operaciones.sql).
CREATE TABLE partidas (
    id_partida       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_jugador       INTEGER NOT NULL,
    id_heroe         INTEGER NOT NULL,
    id_equipo_rival  INTEGER NOT NULL,
    fecha_partida    TEXT NOT NULL,
    kills            INTEGER NOT NULL DEFAULT 0 CHECK (kills >= 0),
    deaths           INTEGER NOT NULL DEFAULT 0 CHECK (deaths >= 0),
    assists          INTEGER NOT NULL DEFAULT 0 CHECK (assists >= 0),
    resultado        TEXT NOT NULL CHECK (resultado IN ('victoria', 'derrota')),
    estado           TEXT NOT NULL DEFAULT 'valida' CHECK (estado IN ('valida', 'en_revision', 'anulada')),

    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    FOREIGN KEY (id_heroe) REFERENCES heroes (id_heroe),
    FOREIGN KEY (id_equipo_rival) REFERENCES equipos (id_equipo)
);
