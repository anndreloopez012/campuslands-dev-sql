.headers on
.mode column

-- Ejercicio 071: Battle Royale Ranking
-- 1. Jugadores y sus niveles
SELECT id, nickname, nivel FROM jugadores ORDER BY nivel DESC;

-- 2. Estadisticas por partida
SELECT e.id, j.nickname, p.mapa, e.kills, e.posicion FROM estadisticas e JOIN jugadores j ON j.id = e.jugador_id JOIN partidas p ON p.id = e.partida_id;

-- 3. Total de kills por jugador
SELECT j.nickname, SUM(e.kills) AS total_kills FROM estadisticas e JOIN jugadores j ON j.id = e.jugador_id GROUP BY j.id, j.nickname ORDER BY total_kills DESC;