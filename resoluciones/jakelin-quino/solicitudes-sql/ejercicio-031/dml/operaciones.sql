PRAGMA foreign_keys = ON;

-- Ejercicio 031: Renta Autos de Lujo
INSERT INTO reservas (cliente_id, vehiculo_id, dias, total) VALUES (3, 3, 1, 550.00);

UPDATE vehiculos SET estado = 'alquilado' WHERE id = 1;

DELETE FROM clientes WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM reservas WHERE cliente_id = clientes.id);