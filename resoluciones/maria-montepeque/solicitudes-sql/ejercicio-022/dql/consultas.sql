.headers on
.mode column

-- Ejercicio 022: Liga MOBA
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar el
--    nickname en vez de solo el id numerico).
SELECT
    pj.id_registro,
    j.nickname,
    pj.heroe_usado,
    pj.fecha_partida,
    pj.resultado,
    pj.premio_ganado,
    pj.estado
FROM partidas_jugadas pj
JOIN jugadores j ON j.id_jugador = pj.id_jugador;

-- 2. Que registros no estan confirmados todavia.
SELECT id_registro, id_jugador, heroe_usado, estado
FROM partidas_jugadas
WHERE estado <> 'confirmado';

-- 3. Que jugador tiene mas actividad (mas partidas jugadas).
SELECT j.nickname, j.rol, COUNT(*) AS partidas_jugadas
FROM jugadores j
JOIN partidas_jugadas pj ON pj.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nickname, j.rol
ORDER BY partidas_jugadas DESC;

-- 4. Registros ordenados por fecha de partida.
SELECT j.nickname, pj.heroe_usado, pj.fecha_partida, pj.resultado
FROM partidas_jugadas pj
JOIN jugadores j ON j.id_jugador = pj.id_jugador
ORDER BY pj.fecha_partida;

-- 5. Dinero en premios generado por cada equipo (sumando a todos sus
--    jugadores), para decisiones de patrocinio. JOIN de las tres tablas.
SELECT
    e.nombre_equipo,
    e.region,
    SUM(pj.premio_ganado) AS premios_totales
FROM equipos e
JOIN jugadores j ON j.id_equipo = e.id_equipo
JOIN partidas_jugadas pj ON pj.id_jugador = j.id_jugador
GROUP BY e.id_equipo, e.nombre_equipo, e.region
ORDER BY premios_totales DESC;
