PRAGMA foreign_keys = ON;

-- Ejercicio 001: Cafeteria Campus
INSERT INTO productos (nombre, categoria, precio) VALUES
	('Cafe americano', 'bebida', 4500),
	('Chocolate', 'bebida', 5000),
	('Sandwich', 'comida', 9000),
	('Galleta', 'comida', 2500),
	('Jugo natural', 'bebida', 6000);

INSERT INTO ventas (producto_id, estudiante, cantidad, fecha, metodo_pago, estado) VALUES
	(1, 'Ana Torres', 2, '2026-08-18', 'efectivo', 'pagada'),
	(3, 'Luis Perez', 1, '2026-08-18', 'tarjeta', 'pagada'),
	(4, 'Marta Ruiz', 3, '2026-08-19', 'transferencia', 'pagada'),
	(2, 'Juan Diaz', 1, '2026-08-19', 'efectivo', 'pendiente'),
	(5, 'Sofia Leon', 2, '2026-08-20', 'tarjeta', 'pagada'),
	(1, 'Diego Mora', 1, '2026-08-20', 'transferencia', 'pagada');
