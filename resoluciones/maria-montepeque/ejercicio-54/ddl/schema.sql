PRAGMA foreign_keys = ON;

-- Ejercicio 54: NOT NULL Nivel Intermedio
-- Tema central: NOT NULL
-- Contexto: torneo de videojuegos (equipos, jugadores y partidas).

CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL,   -- obligatorio: un equipo no puede inscribirse sin nombre
    pais          TEXT NOT NULL,   -- obligatorio: el torneo exige saber de que pais participa
    logo_url      TEXT             -- OPCIONAL: no todos los equipos suben logo al inscribirse
);

CREATE TABLE jugadores (
    id_jugador  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo   INTEGER NOT NULL,  -- obligatorio: un jugador siempre pertenece a un equipo inscrito
    nombre      TEXT NOT NULL,     -- obligatorio: no se puede registrar un jugador sin nombre
    apodo       TEXT,              -- OPCIONAL: no todos usan un gamer tag distinto de su nombre

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- partidas: tabla principal. Distingue lo obligatorio (lo necesario para
-- programar el enfrentamiento) de lo opcional (el puntaje, que solo existe
-- despues de jugarse la partida).
CREATE TABLE partidas (
    id_partida        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_local   INTEGER NOT NULL,  -- obligatorio: toda partida tiene un equipo local
    id_equipo_visitante INTEGER NOT NULL, -- obligatorio: toda partida tiene un equipo visitante
    fecha_partida     TEXT NOT NULL,     -- obligatorio: sin fecha/hora no hay como programarla
    estado            TEXT NOT NULL DEFAULT 'programada' CHECK (estado IN ('programada', 'jugada', 'cancelada')),
    puntaje_local     INTEGER,           -- OPCIONAL: se llena solo cuando la partida ya se jugo
    puntaje_visitante INTEGER,           -- OPCIONAL: mismo caso que puntaje_local

    FOREIGN KEY (id_equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos (id_equipo)
);
