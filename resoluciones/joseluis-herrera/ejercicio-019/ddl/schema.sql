PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS materias;
DROP TABLE IF EXISTS profesores;
DROP TABLE IF EXISTS estudiantes;

CREATE TABLE estudiantes (
    id_estudiante INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    fecha_nacimiento TEXT NOT NULL CHECK (date(fecha_nacimiento) IS NOT NULL)
);

CREATE TABLE profesores (
    id_profesor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL
);

CREATE TABLE materias (
    id_materia INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    creditos INTEGER NOT NULL CHECK (creditos BETWEEN 1 AND 6),
    semestre INTEGER NOT NULL CHECK (semestre BETWEEN 1 AND 12)
);

CREATE TABLE notas (
    id_nota INTEGER PRIMARY KEY,
    id_estudiante INTEGER NOT NULL,
    id_materia INTEGER NOT NULL,
    id_profesor INTEGER NOT NULL,
    nota REAL NOT NULL CHECK (nota BETWEEN 0 AND 5),
    fecha_nota TEXT NOT NULL CHECK (date(fecha_nota) IS NOT NULL),
    UNIQUE (id_estudiante, id_materia),
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia),
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor)
);

CREATE INDEX idx_notas_estudiante
ON notas(id_estudiante);

CREATE INDEX idx_notas_materia
ON notas(id_materia);

CREATE INDEX idx_notas_profesor
ON notas(id_profesor);

CREATE INDEX idx_notas_fecha
ON notas(fecha_nota);