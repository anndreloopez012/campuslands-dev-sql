PRAGMA foreign_keys = ON;

-- Ejercicio 089: Mecanica de Autos
DROP TABLE IF EXISTS ordenes;
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	telefono TEXT NOT NULL UNIQUE
);

CREATE TABLE vehiculos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cliente_id INTEGER NOT NULL,
	placa TEXT NOT NULL UNIQUE,
	modelo TEXT NOT NULL,
	FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE ordenes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	vehiculo_id INTEGER NOT NULL,
	falla TEXT NOT NULL,
	costo_estimado REAL NOT NULL CHECK (costo_estimado > 0),
	FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(id)
);