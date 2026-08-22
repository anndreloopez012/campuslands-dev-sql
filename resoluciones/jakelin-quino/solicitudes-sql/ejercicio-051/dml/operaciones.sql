PRAGMA foreign_keys = ON;

-- Ejercicio 051: Cafeteria Campus
INSERT INTO ventas (producto_id, estudiante, cantidad, metodo_pago) VALUES (1, 'Laura Gil', 1, 'efectivo');

UPDATE productos SET precio = 4800 WHERE id = 1;

DELETE FROM productos WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM ventas WHERE producto_id = productos.id);