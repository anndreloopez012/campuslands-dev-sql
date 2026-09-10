PRAGMA foreign_keys = ON;

-- Ejercicio 108: Indices Nivel Intermedio
-- Tema central: Indices
-- Contexto: torneo de videojuegos, equipos y sus partidas.

CREATE TABLE equipos (
    id_equipo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo  TEXT NOT NULL UNIQUE
);

CREATE TABLE jugadores (
    id_jugador      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo       INTEGER NOT NULL,
    nombre_jugador  TEXT NOT NULL,
    gamer_tag       TEXT NOT NULL UNIQUE,

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE partidas (
    id_partida      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo       INTEGER NOT NULL,
    puntaje         INTEGER NOT NULL CHECK (puntaje >= 0),
    fecha_partida   TEXT NOT NULL,
    resultado       TEXT NOT NULL DEFAULT 'pendiente'
                        CHECK (resultado IN ('victoria', 'derrota', 'empate', 'pendiente')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- Indice compuesto: la consulta mas frecuente del torneo es "las
-- partidas de TAL equipo" y, dentro de eso, muchas veces tambien
-- filtrada por fecha ("las partidas de TAL equipo en TAL fecha"). Un
-- indice compuesto sobre (id_equipo, fecha_partida) sirve para ambos
-- casos, porque id_equipo es la columna de la izquierda (ver la
-- consulta 5 para la comprobacion con EXPLAIN QUERY PLAN).
CREATE INDEX idx_partidas_equipo_fecha ON partidas (id_equipo, fecha_partida);
