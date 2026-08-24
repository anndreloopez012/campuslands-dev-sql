.headers on
.mode column

-- Ejercicio 071: Battle Royale Ranking
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las estadisticas con su
-- jugador y su partida.
SELECT e.id_estadistica,
       j.nickname,
       p.mapa,
       p.fecha_partida,
       e.kills,
       e.posicion_final
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN partidas p ON p.id_partida = e.id_partida;

-- 2. Que partidas estan programadas, jugadas o canceladas.
SELECT id_partida, mapa, fecha_partida, estado
FROM partidas
ORDER BY estado;

-- 3. Que jugador participo en mas partidas (ranking de actividad).
SELECT j.nickname, COUNT(*) AS total_partidas
FROM jugadores j
JOIN estadisticas e ON e.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nickname
ORDER BY total_partidas DESC, j.nickname;

-- 4. Ranking final de la temporada, de mayor a menor puntaje.
SELECT j.nickname, r.puntos_totales
FROM ranking r
JOIN jugadores j ON j.id_jugador = r.id_jugador
WHERE r.id_temporada = 1
ORDER BY r.puntos_totales DESC;

-- 5. Reporte para decision de negocio: jugadores con mas kills
-- acumulados en partidas 'jugada' de la temporada, para decidir a
-- quien destacar como MVP (GROUP BY + HAVING).
SELECT j.nickname,
       SUM(e.kills) AS kills_totales
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN partidas p ON p.id_partida = e.id_partida
WHERE p.estado = 'jugada'
GROUP BY j.id_jugador, j.nickname
HAVING SUM(e.kills) >= 8
ORDER BY kills_totales DESC;
