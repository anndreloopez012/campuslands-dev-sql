PRAGMA foreign_keys = ON;

-- Ejercicio 075: Track Day Hiperdeportivos
INSERT INTO sesiones (vehiculo_id, tiempo_vuelta_seg, circuito) VALUES (1, 87.9, 'Spa-Francorchamps');

UPDATE vehiculos SET potencia_hp = 916 WHERE id = 1;

DELETE FROM pilotos WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM vehiculos WHERE piloto_id = pilotos.id);