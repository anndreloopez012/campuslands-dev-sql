PRAGMA foreign_keys = ON;

-- Ejercicio 086: Delivery de Comida
INSERT INTO restaurantes (nombre, categoria) VALUES
	('Burger Express', 'Comida Rapida'),
	('Sushi House', 'Japonesa');

INSERT INTO platos (restaurante_id, nombre, precio) VALUES
	(1, 'Hamburguesa Doble', 12.00),
	(1, 'Papas Fritas', 4.00),
	(2, 'Roll California', 15.00);

INSERT INTO pedidos (plato_id, cliente, cantidad, estado) VALUES
	(1, 'Pedro Picapiedra', 2, 'entregado'),
	(3, 'Pablo Marmol', 1, 'en_camino');