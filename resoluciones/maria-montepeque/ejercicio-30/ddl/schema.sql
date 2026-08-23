PRAGMA foreign_keys = ON;

-- Ejercicio 30: Proyecto Integrador SQL
-- Modelo: rutas, trainers, campers, modulos, evaluaciones, asistencias
--
-- Justificacion de 6 tablas:
--   rutas y trainers son catalogos independientes.
--   campers pertenece a una ruta.
--   modulos pertenece a una ruta y es impartido por un trainer.
--   evaluaciones y asistencias son tablas transaccionales que registran
--   el desempeno (nota) y la asistencia de un camper en un modulo;
--   se separan porque tienen responsabilidades distintas (calificacion vs. asistencia)
--   y cardinalidades distintas (varias evaluaciones y varias asistencias por camper-modulo).

CREATE TABLE rutas (
    id_ruta            INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre             TEXT NOT NULL UNIQUE,
    duracion_semanas   INTEGER NOT NULL CHECK (duracion_semanas > 0)
);

CREATE TABLE trainers (
    id_trainer  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE campers (
    id_camper       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ruta         INTEGER NOT NULL,
    nombre          TEXT NOT NULL,
    correo          TEXT NOT NULL UNIQUE,
    fecha_ingreso   TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta)
);

CREATE TABLE modulos (
    id_modulo    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ruta      INTEGER NOT NULL,
    id_trainer   INTEGER NOT NULL,
    nombre       TEXT NOT NULL,
    horas        INTEGER NOT NULL CHECK (horas > 0),

    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta),
    FOREIGN KEY (id_trainer) REFERENCES trainers (id_trainer)
);

CREATE TABLE evaluaciones (
    id_evaluacion  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper      INTEGER NOT NULL,
    id_modulo      INTEGER NOT NULL,
    nota           REAL NOT NULL CHECK (nota >= 0 AND nota <= 100),
    fecha          TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_modulo) REFERENCES modulos (id_modulo)
);

CREATE TABLE asistencias (
    id_asistencia  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper      INTEGER NOT NULL,
    id_modulo      INTEGER NOT NULL,
    fecha          TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    estado         TEXT NOT NULL CHECK (estado IN ('presente', 'ausente', 'tardanza')),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_modulo) REFERENCES modulos (id_modulo)
);
