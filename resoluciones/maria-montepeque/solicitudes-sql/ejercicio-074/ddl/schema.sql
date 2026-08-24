PRAGMA foreign_keys = ON;

-- Ejercicio 074: Liga Videojuego Futbol
-- Modelo: jornadas -> partidos (1:N); usuarios + clubes -> partidos
-- (1:N cada uno, como local y como visitante); partidos + clubes ->
-- goles (1:N cada una).

CREATE TABLE usuarios (
    id_usuario      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_usuario  TEXT NOT NULL UNIQUE,
    email           TEXT NOT NULL UNIQUE
);

CREATE TABLE clubes (
    id_club      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_club  TEXT NOT NULL UNIQUE,
    liga         TEXT NOT NULL
);

CREATE TABLE jornadas (
    id_jornada       INTEGER PRIMARY KEY AUTOINCREMENT,
    numero_jornada   INTEGER NOT NULL UNIQUE CHECK (numero_jornada >= 1),
    fecha_inicio     TEXT NOT NULL,
    fecha_fin        TEXT NOT NULL,

    CHECK (fecha_fin >= fecha_inicio)
);

CREATE TABLE partidos (
    id_partido            INTEGER PRIMARY KEY AUTOINCREMENT,
    id_jornada             INTEGER NOT NULL,
    id_usuario_local        INTEGER NOT NULL,
    id_club_local            INTEGER NOT NULL,
    id_usuario_visitante     INTEGER NOT NULL,
    id_club_visitante        INTEGER NOT NULL,
    fecha_partido            TEXT NOT NULL,
    estado                   TEXT NOT NULL DEFAULT 'programado'
                                 CHECK (estado IN ('programado', 'jugado', 'cancelado')),

    FOREIGN KEY (id_jornada) REFERENCES jornadas (id_jornada),
    FOREIGN KEY (id_usuario_local) REFERENCES usuarios (id_usuario),
    FOREIGN KEY (id_club_local) REFERENCES clubes (id_club),
    FOREIGN KEY (id_usuario_visitante) REFERENCES usuarios (id_usuario),
    FOREIGN KEY (id_club_visitante) REFERENCES clubes (id_club)
);

-- goles: el marcador de un partido no se guarda como numero fijo, se
-- calcula sumando estas filas (ver el reporte semanal en
-- dql/consultas.sql).
CREATE TABLE goles (
    id_gol      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partido  INTEGER NOT NULL,
    id_club     INTEGER NOT NULL,
    minuto      INTEGER NOT NULL CHECK (minuto BETWEEN 1 AND 120),

    FOREIGN KEY (id_partido) REFERENCES partidos (id_partido),
    FOREIGN KEY (id_club) REFERENCES clubes (id_club)
);
