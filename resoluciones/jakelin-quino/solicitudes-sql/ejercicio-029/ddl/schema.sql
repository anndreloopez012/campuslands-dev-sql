PRAGMA foreign_keys = ON;

-- Ejercicio 029: Tienda Sneakers
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	modelo TEXT NOT NULL,
	marca TEXT NOT NULL,
	precio REAL NOT NULL CHECK (precio > 0),
	stock INTEGER NOT NULL CHECK (stock >= 0)
);

CREATE TABLE ventas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cliente_id INTEGER NOT NULL,
	producto_id INTEGER NOT NULL,
	cantidad INTEGER NOT NULL CHECK (cantidad > 0),
	FOREIGN KEY (cliente_id) REFERENCES clientes(id),
	FOREIGN KEY (producto_id) REFERENCES productos(id)
);