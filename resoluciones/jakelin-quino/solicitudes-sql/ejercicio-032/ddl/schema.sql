PRAGMA foreign_keys = ON;

-- Ejercicio 032: Academia Kickboxing
DROP TABLE IF EXISTS inscripciones;
DROP TABLE IF EXISTS alumnos;
DROP TABLE IF EXISTS planes;

CREATE TABLE planes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	precio REAL NOT NULL CHECK (precio > 0)
);

CREATE TABLE alumnos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	telefono TEXT NOT NULL UNIQUE
);

CREATE TABLE inscripciones (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	alumno_id INTEGER NOT NULL,
	plan_id INTEGER NOT NULL,
	fecha TEXT NOT NULL,
	estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo')),
	FOREIGN KEY (alumno_id) REFERENCES alumnos(id),
	FOREIGN KEY (plan_id) REFERENCES planes(id)
);