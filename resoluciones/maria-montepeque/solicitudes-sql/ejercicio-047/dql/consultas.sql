.headers on
.mode column

-- Ejercicio 047: Liga MOBA
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN triple: jugador,
--    heroe y equipo rival).
SELECT
    p.id_partida,
    j.nombre_jugador,
    h.nombre_heroe,
    e.nombre_equipo AS rival,
    p.fecha_partida,
    p.kills,
    p.deaths,
    p.assists,
    p.resultado,
    p.estado
FROM partidas p
JOIN jugadores j ON j.id_jugador = p.id_jugador
JOIN heroes h ON h.id_heroe = p.id_heroe
JOIN equipos e ON e.id_equipo = p.id_equipo_rival;

-- 2. Que partidas no estan validas todavia.
SELECT id_partida, id_jugador, fecha_partida, estado
FROM partidas
WHERE estado <> 'valida';

-- 3. Que jugador tiene mas partidas jugadas.
SELECT j.nombre_jugador, COUNT(*) AS total_partidas
FROM jugadores j
JOIN partidas p ON p.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nombre_jugador
ORDER BY total_partidas DESC, j.nombre_jugador;

-- 4. Partidas ordenadas por fecha.
SELECT j.nombre_jugador, h.nombre_heroe, p.fecha_partida
FROM partidas p
JOIN jugadores j ON j.id_jugador = p.id_jugador
JOIN heroes h ON h.id_heroe = p.id_heroe
ORDER BY p.fecha_partida;

-- 5. Jugador con mejor KDA (solo partidas validas), para decidir a
--    quien priorizar en el proximo draft.
SELECT
    j.nombre_jugador,
    SUM(p.kills) AS kills_totales,
    SUM(p.deaths) AS deaths_totales,
    SUM(p.assists) AS assists_totales,
    ROUND((SUM(p.kills) + SUM(p.assists)) * 1.0 / NULLIF(SUM(p.deaths), 0), 2) AS kda
FROM jugadores j
JOIN partidas p ON p.id_jugador = j.id_jugador
WHERE p.estado = 'valida'
GROUP BY j.id_jugador, j.nombre_jugador
ORDER BY kda DESC;
