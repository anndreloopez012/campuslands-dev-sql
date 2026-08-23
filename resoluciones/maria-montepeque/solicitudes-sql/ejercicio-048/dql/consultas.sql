.headers on
.mode column

-- Ejercicio 048: Clanes Shooter
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    clan rival y el mapa en vez de solo los id).
SELECT
    s.id_scrim,
    c.nombre_clan AS rival,
    m.nombre_mapa,
    s.fecha_scrim,
    s.rondas_ganadas,
    s.rondas_perdidas,
    s.estado
FROM scrims s
JOIN clanes c ON c.id_clan = s.id_clan_rival
JOIN mapas m ON m.id_mapa = s.id_mapa;

-- 2. Que scrims no estan jugados todavia (casos pendientes).
SELECT id_scrim, id_clan_rival, fecha_scrim, estado
FROM scrims
WHERE estado <> 'jugado';

-- 3. Contra que clan rival se ha jugado mas (ranking de actividad).
SELECT c.nombre_clan AS rival, COUNT(*) AS total_scrims
FROM clanes c
JOIN scrims s ON s.id_clan_rival = c.id_clan
GROUP BY c.id_clan, c.nombre_clan
ORDER BY total_scrims DESC, c.nombre_clan;

-- 4. Scrims ordenados por fecha.
SELECT c.nombre_clan AS rival, m.nombre_mapa, s.fecha_scrim
FROM scrims s
JOIN clanes c ON c.id_clan = s.id_clan_rival
JOIN mapas m ON m.id_mapa = s.id_mapa
ORDER BY s.fecha_scrim;

-- 5. Ratio de victoria contra cada clan rival (solo scrims jugados),
--    para decidir contra quien practicar mas.
SELECT
    c.nombre_clan AS rival,
    SUM(s.rondas_ganadas) AS rondas_ganadas_total,
    SUM(s.rondas_perdidas) AS rondas_perdidas_total,
    ROUND(SUM(s.rondas_ganadas) * 1.0 / NULLIF(SUM(s.rondas_ganadas) + SUM(s.rondas_perdidas), 0), 3) AS ratio_victoria
FROM scrims s
JOIN clanes c ON c.id_clan = s.id_clan_rival
WHERE s.estado = 'jugado'
GROUP BY c.id_clan, c.nombre_clan
ORDER BY ratio_victoria ASC;
