PRAGMA foreign_keys = ON;

-- Ejercicio 94: HAVING Nivel Aplicado
-- Tema central: HAVING
-- Contexto: registro de campers inscritos en rutas de entrenamiento.

CREATE TABLE campers (
    id_camper      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_camper  TEXT NOT NULL,
    email          TEXT NOT NULL UNIQUE
);

CREATE TABLE rutas (
    id_ruta        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_ruta    TEXT NOT NULL UNIQUE,
    cupo_maximo    INTEGER NOT NULL CHECK (cupo_maximo > 0)
);

CREATE TABLE inscripciones (
    id_inscripcion       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper            INTEGER NOT NULL,
    id_ruta              INTEGER NOT NULL,
    fecha_inscripcion    TEXT NOT NULL,
    estado               TEXT NOT NULL DEFAULT 'activo'
                             CHECK (estado IN ('activo', 'retirado', 'completado')),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta)
);
