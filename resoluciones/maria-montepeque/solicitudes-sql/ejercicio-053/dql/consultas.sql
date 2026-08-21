.headers on
.mode column

-- Ejercicio 053: Torneo Esports
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN al equipo rival).
SELECT
    p.id_partida,
    e.nombre_equipo AS rival,
    p.fecha_partida,
    p.resultado,
    p.estado
FROM partidas p
JOIN equipos e ON e.id_equipo = p.id_equipo_rival;

-- 2. Que partidas no estan jugadas todavia.
SELECT id_partida, id_equipo_rival, fecha_partida, estado
FROM partidas
WHERE estado <> 'jugada';

-- 3. Que jugador tiene mas partidas jugadas (mas actividad).
SELECT j.nombre_jugador, COUNT(*) AS partidas_jugadas
FROM jugadores j
JOIN estadisticas est ON est.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nombre_jugador
ORDER BY partidas_jugadas DESC, j.nombre_jugador;

-- 4. Partidas ordenadas por fecha.
SELECT e.nombre_equipo AS rival, p.fecha_partida, p.resultado
FROM partidas p
JOIN equipos e ON e.id_equipo = p.id_equipo_rival
ORDER BY p.fecha_partida;

-- 5. Jugador con mejor promedio de puntos por partida, para decidir
--    el MVP del equipo.
SELECT
    j.nombre_jugador,
    SUM(est.puntos) AS puntos_totales,
    COUNT(*) AS partidas_jugadas,
    ROUND(AVG(est.puntos), 2) AS promedio_puntos
FROM jugadores j
JOIN estadisticas est ON est.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nombre_jugador
ORDER BY promedio_puntos DESC;
