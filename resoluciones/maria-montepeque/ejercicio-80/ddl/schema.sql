PRAGMA foreign_keys = ON;

-- Ejercicio 80: SELECT Nivel Basico
-- Tema central: SELECT
-- Contexto: registro de campers inscritos en rutas de entrenamiento.

CREATE TABLE campers (
    id_camper          INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre             TEXT NOT NULL,
    fecha_nacimiento   TEXT NOT NULL,
    nivel              TEXT NOT NULL DEFAULT 'principiante'
                           CHECK (nivel IN ('principiante', 'intermedio', 'avanzado'))
);

CREATE TABLE rutas (
    id_ruta             INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_ruta         TEXT NOT NULL UNIQUE,
    distancia_km        REAL NOT NULL CHECK (distancia_km > 0),
    costo_inscripcion   REAL NOT NULL CHECK (costo_inscripcion >= 0)
);

CREATE TABLE inscripciones (
    id_inscripcion      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper           INTEGER NOT NULL,
    id_ruta             INTEGER NOT NULL,
    fecha_inscripcion   TEXT NOT NULL DEFAULT (date('now')),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta)
);
