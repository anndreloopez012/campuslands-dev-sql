PRAGMA foreign_keys = ON;

-- Ejercicio 024: Liga Videojuego Futbol
-- Modelo: usuarios -> clubes (1:N) y clubes -> partidos (1:N, dos
-- veces: como local y como visitante).

CREATE TABLE usuarios (
    id_usuario     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_usuario TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL UNIQUE
);

CREATE TABLE clubes (
    id_club     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario  INTEGER NOT NULL,
    nombre_club TEXT NOT NULL UNIQUE,
    division    TEXT NOT NULL CHECK (division IN ('primera', 'segunda', 'tercera')),

    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);

-- partidos: tabla principal. Aqui vive el reporte semanal que pide el
-- cliente.
CREATE TABLE partidos (
    id_partido         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_club_local      INTEGER NOT NULL,
    id_club_visitante  INTEGER NOT NULL,
    jornada            INTEGER NOT NULL CHECK (jornada > 0),
    goles_local        INTEGER NOT NULL CHECK (goles_local >= 0),
    goles_visitante    INTEGER NOT NULL CHECK (goles_visitante >= 0),
    fecha_partido      TEXT NOT NULL DEFAULT (datetime('now')),
    estado             TEXT NOT NULL DEFAULT 'jugado' CHECK (estado IN ('jugado', 'pendiente', 'suspendido')),

    FOREIGN KEY (id_club_local) REFERENCES clubes (id_club),
    FOREIGN KEY (id_club_visitante) REFERENCES clubes (id_club),
    CHECK (id_club_local <> id_club_visitante)
);
