PRAGMA foreign_keys = ON;

-- Ejercicio 62: AUTO_INCREMENT Nivel Basico
-- Tema central: AUTO_INCREMENT
-- Contexto: registro de campers inscritos en rutas de entrenamiento.

CREATE TABLE rutas (
    id_ruta   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT NOT NULL UNIQUE
);

-- Tabla principal: id_camper se genera solo con INTEGER PRIMARY KEY
-- AUTOINCREMENT (equivalente en SQLite de AUTO_INCREMENT). No se indica
-- el id en los INSERT.
CREATE TABLE campers (
    id_camper   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE
);

CREATE TABLE inscripciones (
    id_inscripcion      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper           INTEGER NOT NULL,
    id_ruta             INTEGER NOT NULL,
    fecha_inscripcion   TEXT NOT NULL DEFAULT (date('now')),

    -- Un camper no se inscribe dos veces a la misma ruta.
    UNIQUE (id_camper, id_ruta),
    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta)
);
