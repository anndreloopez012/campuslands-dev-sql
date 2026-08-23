.headers on
.mode column

-- Ejercicio 028: Torneo Esports
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar el
--    nickname en vez de solo el id numerico).
SELECT
    p.id_partida,
    j.nickname,
    p.puntos_obtenidos,
    p.resultado,
    p.fecha_partida,
    p.estado
FROM partidas p
JOIN jugadores j ON j.id_jugador = p.id_jugador;

-- 2. Casos pendientes (tal como pidio el cliente explicitamente).
SELECT id_partida, id_jugador, puntos_obtenidos, fecha_partida
FROM partidas
WHERE estado = 'pendiente';

-- 3. Ranking: que jugador tiene mas puntos totales.
SELECT j.nickname, j.rol, SUM(p.puntos_obtenidos) AS puntos_totales
FROM jugadores j
JOIN partidas p ON p.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nickname, j.rol
ORDER BY puntos_totales DESC;

-- 4. Partidas ordenadas por fecha.
SELECT j.nickname, p.puntos_obtenidos, p.fecha_partida, p.resultado
FROM partidas p
JOIN jugadores j ON j.id_jugador = p.id_jugador
ORDER BY p.fecha_partida;

-- 5. Totales: puntos acumulados por equipo (sumando a todos sus
--    jugadores), para decidir a que equipo asignar el proximo torneo.
--    JOIN de las tres tablas.
SELECT
    e.nombre_equipo,
    e.region,
    SUM(p.puntos_obtenidos) AS puntos_totales_equipo
FROM equipos e
JOIN jugadores j ON j.id_equipo = e.id_equipo
JOIN partidas p ON p.id_jugador = j.id_jugador
GROUP BY e.id_equipo, e.nombre_equipo, e.region
ORDER BY puntos_totales_equipo DESC;
