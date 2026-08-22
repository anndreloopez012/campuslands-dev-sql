PRAGMA foreign_keys = ON;

-- Ejercicio 033: Viajes Paracaidismo
INSERT INTO reservas (cliente_id, salto_id, fecha) VALUES (3, 1, '2026-08-22');

UPDATE saltos SET precio = 220.00 WHERE id = 1;

DELETE FROM clientes WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM reservas WHERE cliente_id = clientes.id);