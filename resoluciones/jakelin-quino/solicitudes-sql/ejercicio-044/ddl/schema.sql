PRAGMA foreign_keys = ON;

-- Ejercicio 044: Diseno 3D Arquitectura
DROP TABLE IF EXISTS renders;
DROP TABLE IF EXISTS proyectos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	empresa TEXT NOT NULL UNIQUE
);

CREATE TABLE proyectos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cliente_id INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	area_m2 REAL NOT NULL CHECK (area_m2 > 0),
	FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE renders (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	proyecto_id INTEGER NOT NULL,
	vista TEXT NOT NULL,
	costo REAL NOT NULL CHECK (costo > 0),
	FOREIGN KEY (proyecto_id) REFERENCES proyectos(id)
);