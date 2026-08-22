PRAGMA foreign_keys = ON;

-- Ejercicio 044: Diseno 3D Arquitectura
INSERT INTO renders (proyecto_id, vista, costo) VALUES (1, 'Vista Aerea Nocturna', 400.00);

UPDATE proyectos SET area_m2 = 480.0 WHERE id = 1;

DELETE FROM clientes WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM proyectos WHERE cliente_id = clientes.id);