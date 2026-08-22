PRAGMA foreign_keys = ON;

-- Ejercicio 098: Clanes Shooter
INSERT INTO guerras (clan_1_id, clan_2_id, mapa, ganador_id) VALUES (2, 1, 'Inferno', 2);

UPDATE clanes SET tag = 'VE' WHERE id = 1;

DELETE FROM clanes WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM jugadores WHERE clan_id = clanes.id);