PRAGMA foreign_keys = ON;

-- Ejercicio 045: Soldadura Industrial
DROP TABLE IF EXISTS ordenes;
DROP TABLE IF EXISTS materiales;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	empresa TEXT NOT NULL UNIQUE,
	contacto TEXT NOT NULL
);

CREATE TABLE materiales (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	tipo TEXT NOT NULL UNIQUE,
	precio_kg REAL NOT NULL CHECK (precio_kg > 0)
);

CREATE TABLE ordenes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cliente_id INTEGER NOT NULL,
	material_id INTEGER NOT NULL,
	peso_kg REAL NOT NULL CHECK (peso_kg > 0),
	FOREIGN KEY (cliente_id) REFERENCES clientes(id),
	FOREIGN KEY (material_id) REFERENCES materiales(id)
);