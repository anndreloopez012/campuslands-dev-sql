PRAGMA foreign_keys = ON;

-- Ejercicio 086: Delivery de Comida
INSERT INTO pedidos (plato_id, cliente, cantidad, estado) VALUES (2, 'Vilma Palma', 3, 'en_camino');

UPDATE pedidos SET estado = 'entregado' WHERE id = 2;

DELETE FROM restaurantes WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM platos WHERE restaurante_id = restaurantes.id);