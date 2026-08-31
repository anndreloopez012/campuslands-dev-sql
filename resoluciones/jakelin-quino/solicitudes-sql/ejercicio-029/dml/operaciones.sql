PRAGMA foreign_keys = ON;

-- Ejercicio 029: Tienda Sneakers
INSERT INTO ventas (cliente_id, producto_id, cantidad) VALUES (1, 3, 1);

UPDATE productos SET stock = stock - 1 WHERE id = 1 AND stock > 0;

DELETE FROM clientes WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM ventas WHERE cliente_id = clientes.id);