PRAGMA foreign_keys = ON;

-- Ejercicio 063: Clinica Tatuajes
INSERT INTO citas (artista_id, cliente_id, diseno, costo) VALUES (1, 2, 'Calavera Pecho', 200.00);

UPDATE citas SET costo = 160.00 WHERE id = 1;

DELETE FROM clientes WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM citas WHERE cliente_id = clientes.id);