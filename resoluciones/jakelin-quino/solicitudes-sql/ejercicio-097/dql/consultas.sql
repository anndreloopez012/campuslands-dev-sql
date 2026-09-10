.headers on
.mode column

-- Ejercicio 097: Liga MOBA
-- 1. Roster de equipos
SELECT j.nickname, j.rol, e.nombre AS equipo FROM jugadores j JOIN equipos e ON e.id = j.equipo_id;

-- 2. Heroes mas jugados y KDA
SELECT p.id, j.nickname, p.heroe, p.kda_ratio FROM partidas p JOIN jugadores j ON j.id = p.jugador_id;

-- 3. Promedio KDA por jugador
SELECT j.nickname, AVG(p.kda_ratio) AS kda_promedio FROM partidas p JOIN jugadores j ON j.id = p.jugador_id GROUP BY j.id, j.nickname;