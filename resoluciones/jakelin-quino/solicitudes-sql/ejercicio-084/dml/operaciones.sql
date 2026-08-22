PRAGMA foreign_keys = ON;

-- Ejercicio 084: Estudio Animacion 3D
INSERT INTO renders (proyecto_id, escena, tiempo_horas, estado) VALUES (1, 'Escena 02 - Producto', 3.0, 'en_proceso');

UPDATE renders SET estado = 'finalizado' WHERE id = 2;

DELETE FROM clientes WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM proyectos WHERE cliente_id = clientes.id);