PRAGMA foreign_keys = ON;

-- Ejercicio 001: Cafeteria Campus
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;

CREATE TABLE productos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	categoria TEXT NOT NULL,
	precio REAL NOT NULL CHECK (precio > 0),
	estado TEXT NOT NULL DEFAULT 'activo'
		CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE ventas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	producto_id INTEGER NOT NULL,
	estudiante TEXT NOT NULL,
	cantidad INTEGER NOT NULL CHECK (cantidad > 0),
	fecha TEXT NOT NULL,
	metodo_pago TEXT NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia')),
	estado TEXT NOT NULL DEFAULT 'pendiente'
		CHECK (estado IN ('pendiente', 'pagada', 'cancelada')),
	FOREIGN KEY (producto_id) REFERENCES productos(id)
);
