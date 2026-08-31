PRAGMA foreign_keys = ON;

-- Ejercicio 053: Torneo Esports
INSERT INTO partidas (equipo_local_id, equipo_visitante_id, puntos_local, puntos_visitante) VALUES (1, 3, 2, 0);

UPDATE jugadores SET rol = 'Lider' WHERE id = 1;

DELETE FROM equipos WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM jugadores WHERE equipo_id = equipos.id);