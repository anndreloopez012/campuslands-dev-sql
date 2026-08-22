PRAGMA foreign_keys = ON;

-- Ejercicio 033: Viajes Paracaidismo
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS saltos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	pasaporte TEXT NOT NULL UNIQUE
);

CREATE TABLE saltos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	modalidad TEXT NOT NULL,
	altura_pies INTEGER NOT NULL CHECK (altura_pies > 0),
	precio REAL NOT NULL CHECK (precio > 0)
);

CREATE TABLE reservas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cliente_id INTEGER NOT NULL,
	salto_id INTEGER NOT NULL,
	fecha TEXT NOT NULL,
	FOREIGN KEY (cliente_id) REFERENCES clientes(id),
	FOREIGN KEY (salto_id) REFERENCES saltos(id)
);