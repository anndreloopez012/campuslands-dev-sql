PRAGMA foreign_keys = ON;

-- Ejercicio 78: DELETE Nivel Intermedio
-- Tema central: DELETE
-- Contexto: registro de campers inscritos en rutas de entrenamiento.

CREATE TABLE campers (
    id_camper   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE
);

-- rutas: "activa" es la bandera de baja logica. Una ruta con
-- inscripciones todavia activas no se puede borrar de verdad.
CREATE TABLE rutas (
    id_ruta       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_ruta   TEXT NOT NULL UNIQUE,
    cupo_maximo   INTEGER NOT NULL DEFAULT 10 CHECK (cupo_maximo > 0),
    activa        INTEGER NOT NULL DEFAULT 1 CHECK (activa IN (0, 1))
);

CREATE TABLE inscripciones (
    id_inscripcion      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper           INTEGER NOT NULL,
    id_ruta             INTEGER NOT NULL,
    estado              TEXT NOT NULL DEFAULT 'activa'
                            CHECK (estado IN ('activa', 'completada', 'cancelada')),
    fecha_inscripcion   TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta)
);
