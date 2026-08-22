.headers on
.mode column

-- Ejercicio 053: Torneo Esports
-- 1. Jugadores y sus equipos
SELECT j.nickname, j.rol, e.nombre AS equipo FROM jugadores j JOIN equipos e ON e.id = j.equipo_id;

-- 2. Partidas jugadas
SELECT p.id, e1.nombre AS local, p.puntos_local, p.puntos_visitante, e2.nombre AS visitante FROM partidas p JOIN equipos e1 ON e1.id = p.equipo_local_id JOIN equipos e2 ON e2.id = p.equipo_visitante_id;

-- 3. Victorias como local
SELECT e.nombre, COUNT(*) AS victorias_local FROM partidas p JOIN equipos e ON e.id = p.equipo_local_id WHERE p.puntos_local > p.puntos_visitante GROUP BY e.id, e.nombre;