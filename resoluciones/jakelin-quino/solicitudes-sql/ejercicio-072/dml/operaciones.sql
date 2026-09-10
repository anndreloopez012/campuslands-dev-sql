PRAGMA foreign_keys = ON;

-- Ejercicio 072: Liga MOBA
INSERT INTO partidas (jugador_id, heroe, kda_ratio) VALUES (1, 'Azir', 12.0);

UPDATE jugadores SET rol = 'Capitan Mid' WHERE id = 1;

DELETE FROM equipos WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM jugadores WHERE equipo_id = equipos.id);