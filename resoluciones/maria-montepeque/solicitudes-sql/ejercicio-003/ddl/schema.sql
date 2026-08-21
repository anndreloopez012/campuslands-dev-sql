PRAGMA foreign_keys = ON;

-- Ejercicio 003: Torneo Esports
-- Modelo minimo: catalogo de equipos y registro de jugadores.

-- equipos: catalogo.
CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL UNIQUE,
    region        TEXT NOT NULL
);

-- jugadores: tabla principal. NOT NULL en todos los campos que, si
-- faltaran, harian que un reporte no sea confiable (la queja central del
-- cliente: "evitar registros incompletos").
CREATE TABLE jugadores (
    id_jugador     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo      INTEGER NOT NULL,
    nickname       TEXT NOT NULL UNIQUE,
    nombre_real    TEXT NOT NULL,
    rol            TEXT NOT NULL CHECK (rol IN ('duelist', 'support', 'igl', 'entry')),
    puntos_totales INTEGER NOT NULL DEFAULT 0 CHECK (puntos_totales >= 0),
    estado         TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo', 'suspendido')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);
