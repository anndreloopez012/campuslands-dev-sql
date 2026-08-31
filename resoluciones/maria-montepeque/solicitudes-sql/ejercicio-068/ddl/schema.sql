PRAGMA foreign_keys = ON;

-- Ejercicio 068: Escuela de Dibujo
-- Modelo: profesores, cursos, alumnos, entregas, evaluaciones

CREATE TABLE profesores (
    id_profesor    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL,
    especialidad   TEXT NOT NULL
);

CREATE TABLE cursos (
    id_curso      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_profesor   INTEGER NOT NULL,
    nombre        TEXT NOT NULL UNIQUE,
    nivel         TEXT NOT NULL CHECK (nivel IN ('principiante', 'intermedio', 'avanzado')),

    FOREIGN KEY (id_profesor) REFERENCES profesores (id_profesor)
);

CREATE TABLE alumnos (
    id_alumno   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE
);

CREATE TABLE entregas (
    id_entrega       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_alumno        INTEGER NOT NULL,
    id_curso         INTEGER NOT NULL,
    titulo_obra      TEXT NOT NULL,
    fecha_entrega    TEXT NOT NULL DEFAULT (date('now')),
    estado           TEXT NOT NULL DEFAULT 'pendiente'
                         CHECK (estado IN ('pendiente', 'evaluada', 'rechazada')),

    FOREIGN KEY (id_alumno) REFERENCES alumnos (id_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos (id_curso)
);

CREATE TABLE evaluaciones (
    id_evaluacion   INTEGER PRIMARY KEY AUTOINCREMENT,
    -- UNIQUE: cada entrega tiene, a lo sumo, una evaluacion (relacion 1:1).
    id_entrega      INTEGER NOT NULL UNIQUE,
    nota            REAL NOT NULL CHECK (nota BETWEEN 0 AND 100),
    comentario      TEXT NOT NULL,

    FOREIGN KEY (id_entrega) REFERENCES entregas (id_entrega)
);
