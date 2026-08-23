PRAGMA foreign_keys = ON;

-- Ejercicio 049: Liga Videojuego Futbol
-- Modelo: usuarios, jornadas y clubes (dos veces: club del usuario y
-- club rival) alimentan partidos. fecha_ultimo_cambio guarda cuando
-- cambio el estado por ultima vez, para auditorias.

CREATE TABLE usuarios (
    id_usuario     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_usuario TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL UNIQUE
);

CREATE TABLE clubes (
    id_club     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_club TEXT NOT NULL UNIQUE,
    liga        TEXT NOT NULL CHECK (liga IN ('premier', 'laliga', 'seriea', 'bundesliga'))
);

CREATE TABLE jornadas (
    id_jornada     INTEGER PRIMARY KEY AUTOINCREMENT,
    numero_jornada INTEGER NOT NULL UNIQUE CHECK (numero_jornada > 0),
    fecha_jornada  TEXT NOT NULL,
    temporada      TEXT NOT NULL
);

-- partidos: tabla principal. El estado se corrige con UPDATE (nunca
-- con DELETE) y cada cambio actualiza fecha_ultimo_cambio.
CREATE TABLE partidos (
    id_partido           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario           INTEGER NOT NULL,
    id_jornada           INTEGER NOT NULL,
    club_usuario         INTEGER NOT NULL,
    club_rival           INTEGER NOT NULL,
    fecha_partido        TEXT NOT NULL,
    goles_usuario        INTEGER NOT NULL DEFAULT 0 CHECK (goles_usuario >= 0),
    goles_rival          INTEGER NOT NULL DEFAULT 0 CHECK (goles_rival >= 0),
    estado               TEXT NOT NULL DEFAULT 'jugado' CHECK (estado IN ('jugado', 'en_revision', 'anulado')),
    fecha_ultimo_cambio  TEXT NOT NULL,

    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
    FOREIGN KEY (id_jornada) REFERENCES jornadas (id_jornada),
    FOREIGN KEY (club_usuario) REFERENCES clubes (id_club),
    FOREIGN KEY (club_rival) REFERENCES clubes (id_club)
);
