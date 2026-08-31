PRAGMA foreign_keys = ON;

-- Ejercicio 92: HAVING Nivel Basico
-- Tema central: HAVING
-- Contexto: torneo de videojuegos, equipos y sus partidas.

CREATE TABLE equipos (
    id_equipo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo  TEXT NOT NULL UNIQUE
);

CREATE TABLE partidas (
    id_partida      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo       INTEGER NOT NULL,
    fecha_partida   TEXT NOT NULL,
    resultado       TEXT NOT NULL DEFAULT 'pendiente'
                        CHECK (resultado IN ('victoria', 'derrota', 'empate', 'pendiente')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);
