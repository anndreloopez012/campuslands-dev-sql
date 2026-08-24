.headers on
.mode column

-- Ejercicio 073: Clanes Shooter
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todos los scrims con sus
-- clanes y su mapa.
SELECT s.id_scrim,
       cloc.nombre_clan AS clan_local,
       cvis.nombre_clan AS clan_visitante,
       m.nombre_mapa,
       s.fecha_scrim,
       s.estado
FROM scrims s
JOIN clanes cloc ON cloc.id_clan = s.id_clan_local
JOIN clanes cvis ON cvis.id_clan = s.id_clan_visitante
JOIN mapas m ON m.id_mapa = s.id_mapa;

-- 2. Que scrims estan programados, jugados o cancelados.
SELECT id_scrim, fecha_scrim, estado
FROM scrims
ORDER BY estado;

-- 3. Que clan jugo mas scrims (ranking de actividad).
SELECT c.nombre_clan, COUNT(*) AS total_scrims
FROM clanes c
JOIN scrims s ON s.id_clan_local = c.id_clan OR s.id_clan_visitante = c.id_clan
GROUP BY c.id_clan, c.nombre_clan
ORDER BY total_scrims DESC, c.nombre_clan;

-- 4. Scrims ordenados por fecha.
SELECT id_scrim, fecha_scrim, estado
FROM scrims
ORDER BY fecha_scrim;

-- 5. Reporte para decision de negocio: victorias por clan, para saber
-- quien clasifica a playoffs (GROUP BY + HAVING).
SELECT c.nombre_clan, COUNT(*) AS victorias
FROM resultados r
JOIN clanes c ON c.id_clan = r.id_clan_ganador
GROUP BY c.id_clan, c.nombre_clan
HAVING COUNT(*) >= 1
ORDER BY victorias DESC, c.nombre_clan;
