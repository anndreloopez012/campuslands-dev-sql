PRAGMA foreign_keys = ON;

-- Ejercicio 19: Universidad Notas
-- Modelo: estudiantes, materias, profesores, notas

CREATE TABLE estudiantes (
    id_estudiante  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL,
    carnet         TEXT NOT NULL UNIQUE,
    correo         TEXT NOT NULL UNIQUE
);

CREATE TABLE materias (
    id_materia  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE,
    creditos    INTEGER NOT NULL CHECK (creditos > 0)
);

CREATE TABLE profesores (
    id_profesor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    correo       TEXT NOT NULL UNIQUE
);

CREATE TABLE notas (
    id_nota        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_estudiante  INTEGER NOT NULL,
    id_materia     INTEGER NOT NULL,
    id_profesor    INTEGER NOT NULL,
    nota           REAL NOT NULL CHECK (nota >= 0 AND nota <= 100),
    fecha          TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante),
    FOREIGN KEY (id_materia) REFERENCES materias (id_materia),
    FOREIGN KEY (id_profesor) REFERENCES profesores (id_profesor)
);
