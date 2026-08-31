.headers on
.mode column

-- Ejercicio 078: Torneo Esports
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las estadisticas con su
-- jugador y su partida.
SELECT e.id_estadistica,
       j.nickname,
       e.id_partida,
       p.fecha_partida,
       e.puntos
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN partidas p ON p.id_partida = e.id_partida;

-- 2. Que partidas estan programadas (casos pendientes), jugadas o
-- canceladas.
SELECT id_partida, fecha_partida, estado
FROM partidas
ORDER BY estado;

-- 3. Que jugador tiene mas actividad (mas partidas con estadisticas
-- registradas).
SELECT j.nickname, COUNT(*) AS partidas_registradas
FROM jugadores j
JOIN estadisticas e ON e.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nickname
ORDER BY partidas_registradas DESC, j.nickname;

-- 4. Ranking final, de mayor a menor puntaje.
SELECT eq.nombre_equipo, r.puntos_totales
FROM ranking r
JOIN equipos eq ON eq.id_equipo = r.id_equipo
ORDER BY r.puntos_totales DESC;

-- 5. Reporte para decision de negocio: equipos que superan un
-- puntaje total minimo, para decidir quienes avanzan a la siguiente
-- fase (GROUP BY + HAVING).
SELECT eq.nombre_equipo,
       SUM(e.puntos) AS puntos_calculados
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN equipos eq ON eq.id_equipo = j.id_equipo
GROUP BY eq.id_equipo, eq.nombre_equipo
HAVING SUM(e.puntos) >= 30
ORDER BY puntos_calculados DESC;
