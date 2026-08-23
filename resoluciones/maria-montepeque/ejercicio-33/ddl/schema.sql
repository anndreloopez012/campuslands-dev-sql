PRAGMA foreign_keys = ON;

-- Ejercicio 33: Normalizacion Matriculas Academicas
-- Modelo normalizado (3FN): estudiantes, rutas, trainers, modulos, matriculas, notas

CREATE TABLE estudiantes (
    id_estudiante  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL,
    documento      TEXT NOT NULL UNIQUE CHECK (length(documento) > 0)
);

CREATE TABLE rutas (
    id_ruta  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre   TEXT NOT NULL UNIQUE
);

CREATE TABLE trainers (
    id_trainer  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE
);

CREATE TABLE modulos (
    id_modulo  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre     TEXT NOT NULL UNIQUE
);

-- Encabezado de matricula: un estudiante cursando una ruta con un trainer.
-- UNIQUE (id_estudiante, id_ruta) evita que el mismo estudiante quede matriculado
-- dos veces en la misma ruta (el CSV original repetia esta combinacion en dos filas).
CREATE TABLE matriculas (
    id_matricula  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_estudiante INTEGER NOT NULL,
    id_ruta       INTEGER NOT NULL,
    id_trainer    INTEGER NOT NULL,

    FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta),
    FOREIGN KEY (id_trainer) REFERENCES trainers (id_trainer),
    UNIQUE (id_estudiante, id_ruta)
);

-- Detalle transaccional: nota obtenida por una matricula en un modulo especifico,
-- con el horario en que se curso ese modulo.
CREATE TABLE notas (
    id_nota       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_matricula  INTEGER NOT NULL,
    id_modulo     INTEGER NOT NULL,
    horario       TEXT NOT NULL CHECK (horario GLOB '[0-2][0-9]:[0-5][0-9]'),   -- 'HH:MM'
    nota          INTEGER NOT NULL CHECK (nota BETWEEN 0 AND 100),

    FOREIGN KEY (id_matricula) REFERENCES matriculas (id_matricula),
    FOREIGN KEY (id_modulo) REFERENCES modulos (id_modulo),
    UNIQUE (id_matricula, id_modulo)
);
