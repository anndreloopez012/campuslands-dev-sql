PRAGMA foreign_keys = ON;

-- Ejercicio 079: Tienda Sneakers
INSERT INTO clientes (nombre, email) VALUES
	('Lucia Mendez', 'lucia@mail.com'),
	('David Rios', 'david@mail.com'),
	('Sofia Vega', 'sofia@mail.com');

INSERT INTO productos (modelo, marca, precio, stock) VALUES
	('Air Max 90', 'Nike', 120.00, 10),
	('Ultraboost', 'Adidas', 140.00, 8),
	('RS-X', 'Puma', 95.00, 15);

INSERT INTO ventas (cliente_id, producto_id, cantidad) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 1);