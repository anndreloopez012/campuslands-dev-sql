PRAGMA foreign_keys = ON;

-- Ejercicio 031: Renta Autos de Lujo
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	licencia TEXT NOT NULL UNIQUE
);

CREATE TABLE vehiculos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	marca TEXT NOT NULL,
	modelo TEXT NOT NULL,
	precio_dia REAL NOT NULL CHECK (precio_dia > 0),
	estado TEXT NOT NULL DEFAULT 'disponible' CHECK (estado IN ('disponible', 'alquilado'))
);

CREATE TABLE reservas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cliente_id INTEGER NOT NULL,
	vehiculo_id INTEGER NOT NULL,
	dias INTEGER NOT NULL CHECK (dias > 0),
	total REAL NOT NULL CHECK (total > 0),
	FOREIGN KEY (cliente_id) REFERENCES clientes(id),
	FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(id)
);