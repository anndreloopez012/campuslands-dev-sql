PRAGMA foreign_keys = ON;

-- Ejercicio 095: Soldadura Industrial
INSERT INTO ordenes (cliente_id, material_id, peso_kg) VALUES (1, 2, 200.0);

UPDATE materiales SET precio_kg = 6.00 WHERE id = 1;

DELETE FROM clientes WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM ordenes WHERE cliente_id = clientes.id);