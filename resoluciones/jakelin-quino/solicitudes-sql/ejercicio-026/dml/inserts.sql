PRAGMA foreign_keys = ON;

-- Ejercicio 026: Cafeteria Campus
INSERT INTO productos (nombre, categoria, precio) VALUES
	('Cafe americano', 'bebida', 4500),
	('Chocolate', 'bebida', 5000),
	('Sandwich', 'comida', 9000);

INSERT INTO ventas (producto_id, estudiante, cantidad, metodo_pago) VALUES
	(1, 'Ana Torres', 2, 'efectivo'),
	(3, 'Luis Perez', 1, 'tarjeta'),
	(2, 'Juan Diaz', 1, 'transferencia');