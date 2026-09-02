PRAGMA foreign_keys = ON;

-- Ejercicio 071: Battle Royale Ranking
INSERT INTO estadisticas (jugador_id, partida_id, kills, posicion) VALUES (1, 2, 4, 3);

UPDATE jugadores SET nivel = 51 WHERE id = 1;

DELETE FROM jugadores WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM estadisticas WHERE jugador_id = jugadores.id);