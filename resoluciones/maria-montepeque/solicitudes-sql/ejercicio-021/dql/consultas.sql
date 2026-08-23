.headers on
.mode column

-- Ejercicio 021: Battle Royale Ranking
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar el
--    gamertag y el mapa en vez de solo los id numericos).
SELECT
    e.id_estadistica,
    j.gamertag,
    p.mapa,
    e.kills,
    e.posicion_final,
    e.estado
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN partidas p ON p.id_partida = e.id_partida;

-- 2. Que estadisticas no estan confirmadas todavia.
SELECT id_estadistica, id_jugador, id_partida, kills, estado
FROM estadisticas
WHERE estado <> 'confirmada';

-- 3. Que jugador tiene mas actividad (mas partidas jugadas).
SELECT j.gamertag, COUNT(*) AS partidas_jugadas
FROM jugadores j
JOIN estadisticas e ON e.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.gamertag
ORDER BY partidas_jugadas DESC;

-- 4. Estadisticas ordenadas por fecha de partida.
SELECT j.gamertag, p.mapa, p.fecha_partida, e.kills, e.posicion_final
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN partidas p ON p.id_partida = e.id_partida
ORDER BY p.fecha_partida;

-- 5. Ranking semanal: kills totales y victorias (posicion 1) por
--    jugador, para que la comunidad decida a quien premiar.
SELECT
    j.gamertag,
    j.equipo,
    SUM(e.kills) AS kills_totales,
    SUM(CASE WHEN e.posicion_final = 1 THEN 1 ELSE 0 END) AS victorias
FROM jugadores j
JOIN estadisticas e ON e.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.gamertag, j.equipo
ORDER BY kills_totales DESC;
