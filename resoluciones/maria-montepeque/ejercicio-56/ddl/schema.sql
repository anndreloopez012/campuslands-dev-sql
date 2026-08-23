PRAGMA foreign_keys = ON;

-- Ejercicio 56: CHECK Nivel Basico
-- Tema central: CHECK
-- Contexto: torneo de videojuegos (equipos, jugadores y partidas).

-- region: CHECK de valores permitidos (lista cerrada de dominios validos).
CREATE TABLE equipos (
    id_equipo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo TEXT NOT NULL,
    region        TEXT NOT NULL CHECK (region IN ('Norteamerica', 'Sudamerica', 'Europa', 'Asia'))
);

-- edad: CHECK de rango numerico (el torneo exige jugadores entre 14 y 45 anios).
CREATE TABLE jugadores (
    id_jugador INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo  INTEGER NOT NULL,
    nombre     TEXT NOT NULL,
    edad       INTEGER NOT NULL CHECK (edad BETWEEN 14 AND 45),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- partidas: tabla principal. Reune los tres tipos de regla de dominio que
-- pide el ejercicio:
--   - estado: CHECK de valores permitidos (lista cerrada).
--   - puntaje_local / puntaje_visitante: CHECK de rango numerico (no
--     pueden ser negativos, un puntaje negativo no existe en el negocio).
--   - CHECK a nivel de tabla: un equipo no puede jugar contra si mismo.
CREATE TABLE partidas (
    id_partida          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo_local     INTEGER NOT NULL,
    id_equipo_visitante INTEGER NOT NULL,
    fecha_partida       TEXT NOT NULL,
    estado              TEXT NOT NULL DEFAULT 'programada' CHECK (estado IN ('programada', 'jugada', 'cancelada')),
    puntaje_local        INTEGER CHECK (puntaje_local >= 0),
    puntaje_visitante    INTEGER CHECK (puntaje_visitante >= 0),

    FOREIGN KEY (id_equipo_local) REFERENCES equipos (id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos (id_equipo),
    CHECK (id_equipo_local <> id_equipo_visitante)
);
