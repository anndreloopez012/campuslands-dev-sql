PRAGMA foreign_keys = ON;

-- Ejercicio 018: Escuela de Dibujo
DROP TABLE IF EXISTS inscripciones;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS profesores;

CREATE TABLE profesores (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	especialidad TEXT NOT NULL
);

CREATE TABLE cursos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	profesor_id INTEGER NOT NULL,
	titulo TEXT NOT NULL UNIQUE,
	costo REAL NOT NULL CHECK (costo > 0),
	FOREIGN KEY (profesor_id) REFERENCES profesores(id)
);

CREATE TABLE inscripciones (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	curso_id INTEGER NOT NULL,
	alumno TEXT NOT NULL,
	fecha TEXT NOT NULL,
	FOREIGN KEY (curso_id) REFERENCES cursos(id)
);