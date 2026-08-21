PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS resultados;
DROP TABLE IF EXISTS partidas;
DROP TABLE IF EXISTS jugadores;
DROP TABLE IF EXISTS equipos;

CREATE TABLE equipos (
    id_equipo INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    ciudad TEXT NOT NULL,
    fecha_creacion TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'ACTIVO',
    CHECK (estado IN ('ACTIVO', 'INACTIVO'))
);

CREATE TABLE jugadores (
    id_jugador INTEGER PRIMARY KEY,
    id_equipo INTEGER NOT NULL,
    nombre_completo TEXT NOT NULL,
    nickname TEXT NOT NULL UNIQUE,
    edad INTEGER NOT NULL,
    FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo),
    CHECK (edad BETWEEN 16 AND 60)
);

CREATE TABLE partidas (
    id_partida INTEGER PRIMARY KEY,
    id_equipo_1 INTEGER NOT NULL,
    id_equipo_2 INTEGER NOT NULL,
    fecha_partida TEXT NOT NULL,
    ronda TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'PROGRAMADA',
    FOREIGN KEY (id_equipo_1) REFERENCES equipos(id_equipo),
    FOREIGN KEY (id_equipo_2) REFERENCES equipos(id_equipo),
    CHECK (id_equipo_1 <> id_equipo_2),
    CHECK (estado IN ('PROGRAMADA', 'FINALIZADA', 'CANCELADA'))
);

CREATE TABLE resultados (
    id_resultado INTEGER PRIMARY KEY,
    id_partida INTEGER NOT NULL UNIQUE,
    puntos_equipo_1 INTEGER NOT NULL,
    puntos_equipo_2 INTEGER NOT NULL,
    ganador TEXT NOT NULL,
    FOREIGN KEY (id_partida) REFERENCES partidas(id_partida),
    CHECK (puntos_equipo_1 >= 0),
    CHECK (puntos_equipo_2 >= 0),
    CHECK (puntos_equipo_1 <> puntos_equipo_2),
    CHECK (ganador IN ('EQUIPO_1', 'EQUIPO_2'))
);