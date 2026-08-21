.headers on
.mode column

-- Ejercicio 046: Battle Royale Ranking
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar la
--    temporada en vez de solo el id).
SELECT
    p.id_partida,
    t.nombre_temporada,
    p.fecha_partida,
    p.mapa,
    p.estado
FROM partidas p
JOIN temporadas t ON t.id_temporada = p.id_temporada;

-- 2. Que partidas no estan finalizadas todavia.
SELECT id_partida, id_temporada, fecha_partida, estado
FROM partidas
WHERE estado <> 'finalizada';

-- 3. Que jugador tiene mas partidas jugadas (mas actividad).
SELECT j.nombre_jugador, COUNT(*) AS partidas_jugadas
FROM jugadores j
JOIN estadisticas e ON e.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nombre_jugador
ORDER BY partidas_jugadas DESC, j.nombre_jugador;

-- 4. Partidas ordenadas por fecha.
SELECT t.nombre_temporada, p.mapa, p.fecha_partida
FROM partidas p
JOIN temporadas t ON t.id_temporada = p.id_temporada
ORDER BY p.fecha_partida;

-- 5. Ranking de puntos de la temporada activa, para decidir a quien
--    reconocer esta temporada.
SELECT j.nombre_jugador, SUM(e.puntos) AS puntos_temporada
FROM jugadores j
JOIN estadisticas e ON e.id_jugador = j.id_jugador
JOIN partidas p ON p.id_partida = e.id_partida
JOIN temporadas t ON t.id_temporada = p.id_temporada
WHERE t.estado = 'activa'
GROUP BY j.id_jugador, j.nombre_jugador
ORDER BY puntos_temporada DESC;
