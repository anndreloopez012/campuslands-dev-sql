.headers on
.mode column

-- Ejercicio 023: Clanes Shooter
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar los
--    nombres de los clanes en vez de solo los id numericos).
SELECT
    s.id_scrim,
    cl.nombre_clan AS clan_local,
    cr.nombre_clan AS clan_rival,
    s.mapa,
    s.marcador_local,
    s.marcador_rival,
    s.estado
FROM scrims s
JOIN clanes cl ON cl.id_clan = s.id_clan_local
JOIN clanes cr ON cr.id_clan = s.id_clan_rival;

-- 2. Que scrims no estan confirmados todavia.
SELECT id_scrim, id_clan_local, id_clan_rival, mapa, estado
FROM scrims
WHERE estado <> 'jugado';

-- 3. Que jugador tiene mas actividad (jugadores por clan, como
--    referencia de plantilla).
SELECT c.nombre_clan, COUNT(*) AS total_jugadores
FROM clanes c
JOIN jugadores j ON j.id_clan = c.id_clan
GROUP BY c.id_clan, c.nombre_clan
ORDER BY total_jugadores DESC;

-- 4. Scrims ordenados por fecha.
SELECT s.id_scrim, cl.nombre_clan AS clan_local, cr.nombre_clan AS clan_rival, s.fecha_scrim
FROM scrims s
JOIN clanes cl ON cl.id_clan = s.id_clan_local
JOIN clanes cr ON cr.id_clan = s.id_clan_rival
ORDER BY s.fecha_scrim;

-- 5. Que clan tiene mas victorias (contando cuando gano como local o
--    como rival), para armar un ranking confiable.
SELECT c.nombre_clan, COUNT(*) AS victorias
FROM (
    SELECT id_clan_local AS id_clan_ganador
    FROM scrims
    WHERE estado = 'jugado' AND marcador_local > marcador_rival
    UNION ALL
    SELECT id_clan_rival AS id_clan_ganador
    FROM scrims
    WHERE estado = 'jugado' AND marcador_rival > marcador_local
) ganadores
JOIN clanes c ON c.id_clan = ganadores.id_clan_ganador
GROUP BY c.id_clan, c.nombre_clan
ORDER BY victorias DESC;
