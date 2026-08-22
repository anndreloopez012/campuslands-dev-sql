PRAGMA foreign_keys = ON;

-- Ejercicio 014: Mecanica de Autos
INSERT INTO ordenes (vehiculo_id, falla, costo_estimado) VALUES (1, 'Alineacion y balanceo', 40.00);

UPDATE ordenes SET costo_estimado = 280.00 WHERE id = 1;

DELETE FROM clientes WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM vehiculos WHERE cliente_id = clientes.id);