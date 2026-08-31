.headers on
.mode column

-- Ejercicio 062: Club Futbol Sala
-- 1. Plantel de jugadores por equipo
SELECT j.dorsal, j.nombre, e.nombre AS equipo FROM jugadores j JOIN equipos e ON e.id = j.equipo_id ORDER BY e.nombre, j.dorsal;

-- 2. Resultados de partidos
SELECT p.id, e1.nombre AS local, p.goles_local, p.goles_visita, e2.nombre AS visitante FROM partidos p JOIN equipos e1 ON e1.id = p.equipo_local_id JOIN equipos e2 ON e2.id = p.equipo_visita_id;

-- 3. Total de goles marcados por equipo local
SELECT e.nombre, SUM(p.goles_local) AS goles_favor FROM partidos p JOIN equipos e ON e.id = p.equipo_local_id GROUP BY e.id, e.nombre;