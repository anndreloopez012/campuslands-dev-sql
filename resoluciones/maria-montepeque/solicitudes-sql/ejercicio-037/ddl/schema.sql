PRAGMA foreign_keys = ON;

-- Ejercicio 037: Club Futbol Sala
-- Modelo: dos catalogos (equipos, jugadores; jugadores depende de
-- equipos) que alimentan una tabla de movimientos (partidos) con dos
-- FOREIGN KEY: el jugador y el equipo rival.

CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL UNIQUE,
    ciudad        TEXT NOT NULL
);

CREATE TABLE jugadores (
    id_jugador     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_jugador TEXT NOT NULL UNIQUE,
    posicion       TEXT NOT NULL CHECK (posicion IN ('portero', 'cierre', 'ala', 'pivot')),
    id_equipo      INTEGER NOT NULL,

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- partidos: tabla principal. estado usa CHECK y se corrige con UPDATE
-- (nunca con DELETE), que es exactamente lo que pidio el cliente.
CREATE TABLE partidos (
    id_partido      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_jugador      INTEGER NOT NULL,
    id_equipo_rival INTEGER NOT NULL,
    fecha_partido   TEXT NOT NULL,
    goles           INTEGER NOT NULL DEFAULT 0 CHECK (goles >= 0),
    tarjeta         TEXT NOT NULL DEFAULT 'ninguna' CHECK (tarjeta IN ('ninguna', 'amarilla', 'roja')),
    estado          TEXT NOT NULL DEFAULT 'programado' CHECK (estado IN ('programado', 'jugado', 'suspendido')),

    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador),
    FOREIGN KEY (id_equipo_rival) REFERENCES equipos (id_equipo)
);
