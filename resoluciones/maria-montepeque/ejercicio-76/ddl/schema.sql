PRAGMA foreign_keys = ON;

-- Ejercicio 76: UPDATE Nivel Aplicado
-- Tema central: UPDATE
-- Contexto: registro de campers inscritos en rutas de entrenamiento,
-- con cupo limitado por ruta.

CREATE TABLE campers (
    id_camper   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE
);

-- rutas: cupo_disponible es el campo que se corrige con UPDATE cada
-- vez que alguien se inscribe o cancela. Nunca puede ser negativo
-- (eso significaria mas inscritos que cupo).
CREATE TABLE rutas (
    id_ruta            INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_ruta        TEXT NOT NULL UNIQUE,
    cupo_maximo        INTEGER NOT NULL DEFAULT 10 CHECK (cupo_maximo > 0),
    cupo_disponible    INTEGER NOT NULL CHECK (cupo_disponible >= 0)
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
