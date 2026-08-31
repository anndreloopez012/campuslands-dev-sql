PRAGMA foreign_keys = ON;

-- Ejercicio 052: Taller de Motos
INSERT INTO servicios (moto_id, descripcion, costo, estado) VALUES (1, 'Ajuste de cadena', 25.00, 'pendiente');

UPDATE servicios SET estado = 'completado' WHERE id = 2 AND estado = 'pendiente';

DELETE FROM clientes WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM motos WHERE cliente_id = clientes.id);