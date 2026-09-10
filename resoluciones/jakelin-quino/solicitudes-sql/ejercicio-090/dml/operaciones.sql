PRAGMA foreign_keys = ON;

-- Ejercicio 090: Laboratorio Quimico
INSERT INTO ensayos (muestra_id, reactivo_id, resultado) VALUES (1, 2, 'Precipitado Blanco');

UPDATE reactivos SET pureza_pct = 99.5 WHERE id = 1;

DELETE FROM muestras WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM ensayos WHERE muestra_id = muestras.id);