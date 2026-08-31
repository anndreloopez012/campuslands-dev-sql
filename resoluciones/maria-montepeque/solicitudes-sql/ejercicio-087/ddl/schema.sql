PRAGMA foreign_keys = ON;

-- Ejercicio 087: Club Futbol Sala
-- Modelo: equipos -> jugadores (1:N); equipos -> partidos (1:N, como
-- local y como visitante); partidos + jugadores -> goles (1:N cada
-- una); partidos + jugadores -> tarjetas (1:N cada una).

CREATE TABLE equipos (
    id_equipo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo  TEXT NOT NULL UNIQUE,
    categoria      TEXT NOT NULL
);

-- jugadores: el UNIQUE compuesto impide que un equipo repita el mismo
-- numero de camiseta en dos jugadores.
CREATE TABLE jugadores (
    id_jugador        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_jugador    TEXT NOT NULL,
    id_equipo         INTEGER NOT NULL,
    numero_camiseta   INTEGER NOT NULL CHECK (numero_camiseta >= 1),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo),
    UNIQUE (id_equipo, numero_camiseta)
);

CREATE TABLE partidos (
    id_partido            INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_local        INTEGER NOT NULL,
    id_equipo_visitante     INTEGER NOT NULL,
    fecha_partido            TEXT NOT NULL,
    estado                   TEXT NOT NULL DEFAULT 'programado'
                                 CHECK (estado IN ('programado', 'en_curso', 'finalizado', 'suspendido')),

    FOREIGN KEY (id_equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos (id_equipo)
);

-- goles y tarjetas: historico oficial de cada partido. Solo se borran
-- si el partido se suspende y resultaron ser un error de captura (ver
-- decision documentada en analisis/requerimiento.md).
CREATE TABLE goles (
    id_gol      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partido  INTEGER NOT NULL,
    id_jugador  INTEGER NOT NULL,
    minuto      INTEGER NOT NULL CHECK (minuto BETWEEN 1 AND 60),

    FOREIGN KEY (id_partido) REFERENCES partidos (id_partido),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador)
);

CREATE TABLE tarjetas (
    id_tarjeta      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_partido      INTEGER NOT NULL,
    id_jugador      INTEGER NOT NULL,
    tipo_tarjeta    TEXT NOT NULL CHECK (tipo_tarjeta IN ('amarilla', 'roja')),
    minuto          INTEGER NOT NULL CHECK (minuto BETWEEN 1 AND 60),

    FOREIGN KEY (id_partido) REFERENCES partidos (id_partido),
    FOREIGN KEY (id_jugador) REFERENCES jugadores (id_jugador)
);

-- Vista SQL (requerida en nivel 5): resumen legible de cada partido
-- con los nombres de ambos equipos, sin repetir el doble JOIN cada
-- vez.
CREATE VIEW vista_resumen_partidos AS
    SELECT
        p.id_partido,
        eloc.nombre_equipo AS equipo_local,
        evis.nombre_equipo AS equipo_visitante,
        p.fecha_partido,
        p.estado
    FROM partidos p
    JOIN equipos eloc ON eloc.id_equipo = p.id_equipo_local
    JOIN equipos evis ON evis.id_equipo = p.id_equipo_visitante;
