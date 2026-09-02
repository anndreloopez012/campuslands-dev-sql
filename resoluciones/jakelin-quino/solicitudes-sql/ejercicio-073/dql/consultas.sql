.headers on
.mode column

-- Ejercicio 073: Clanes Shooter
-- 1. Jugadores por clan
SELECT j.gamertag, c.nombre AS clan, c.tag FROM jugadores j JOIN clanes c ON c.id = j.clan_id;

-- 2. Guerras de clanes disputadas
SELECT g.id, c1.tag AS clan_1, c2.tag AS clan_2, g.mapa, cg.nombre AS ganador FROM guerras g JOIN clanes c1 ON c1.id = g.clan_1_id JOIN clanes c2 ON c2.id = g.clan_2_id JOIN clanes cg ON cg.id = g.ganador_id;

-- 3. Victorias por clan
SELECT c.nombre, COUNT(g.id) AS guerras_ganadas FROM guerras g JOIN clanes c ON c.id = g.ganador_id GROUP BY c.id, c.nombre;