.headers on
.mode column

-- Ejercicio 037: Club Futbol Sala
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    jugador y el equipo rival en vez de solo los id).
SELECT
    p.id_partido,
    j.nombre_jugador,
    e.nombre_equipo AS rival,
    p.fecha_partido,
    p.goles,
    p.tarjeta,
    p.estado
FROM partidos p
JOIN jugadores j ON j.id_jugador = p.id_jugador
JOIN equipos e ON e.id_equipo = p.id_equipo_rival;

-- 2. Que partidos no se han jugado todavia.
SELECT id_partido, id_jugador, id_equipo_rival, fecha_partido, estado
FROM partidos
WHERE estado <> 'jugado';

-- 3. Que jugador tiene mas goles en total.
SELECT j.nombre_jugador, SUM(p.goles) AS total_goles
FROM jugadores j
JOIN partidos p ON p.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nombre_jugador
ORDER BY total_goles DESC, j.nombre_jugador;

-- 4. Partidos ordenados por fecha.
SELECT j.nombre_jugador, e.nombre_equipo AS rival, p.fecha_partido
FROM partidos p
JOIN jugadores j ON j.id_jugador = p.id_jugador
JOIN equipos e ON e.id_equipo = p.id_equipo_rival
ORDER BY p.fecha_partido;

-- 5. Jugadores en riesgo de sancion (2 o mas tarjetas amarillas, o
--    alguna tarjeta roja), para decidir a quien cuidar en el
--    siguiente partido.
SELECT
    j.nombre_jugador,
    SUM(CASE WHEN p.tarjeta = 'amarilla' THEN 1 ELSE 0 END) AS amarillas,
    SUM(CASE WHEN p.tarjeta = 'roja' THEN 1 ELSE 0 END) AS rojas
FROM jugadores j
JOIN partidos p ON p.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nombre_jugador
HAVING amarillas >= 2 OR rojas >= 1
ORDER BY rojas DESC, amarillas DESC;
