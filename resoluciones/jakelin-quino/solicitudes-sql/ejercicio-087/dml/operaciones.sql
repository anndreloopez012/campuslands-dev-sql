PRAGMA foreign_keys = ON;

-- Ejercicio 087: Club Futbol Sala
INSERT INTO partidos (equipo_local_id, equipo_visita_id, goles_local, goles_visita) VALUES (2, 1, 2, 2);

UPDATE jugadores SET dorsal = 9 WHERE id = 2;

DELETE FROM equipos WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM jugadores WHERE equipo_id = equipos.id);