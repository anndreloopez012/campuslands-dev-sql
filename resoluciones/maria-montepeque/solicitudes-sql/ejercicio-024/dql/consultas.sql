.headers on
.mode column

-- Ejercicio 024: Liga Videojuego Futbol
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar los
--    nombres de los clubes en vez de solo los id numericos).
SELECT
    p.id_partido,
    cl.nombre_club AS club_local,
    cv.nombre_club AS club_visitante,
    p.jornada,
    p.goles_local,
    p.goles_visitante,
    p.estado
FROM partidos p
JOIN clubes cl ON cl.id_club = p.id_club_local
JOIN clubes cv ON cv.id_club = p.id_club_visitante;

-- 2. Que partidos no estan jugados todavia.
SELECT id_partido, id_club_local, id_club_visitante, jornada, estado
FROM partidos
WHERE estado <> 'jugado';

-- 3. Que club tiene mas partidos jugados (como local o visitante).
SELECT c.nombre_club, COUNT(*) AS total_partidos
FROM clubes c
JOIN partidos p ON p.id_club_local = c.id_club OR p.id_club_visitante = c.id_club
GROUP BY c.id_club, c.nombre_club
ORDER BY total_partidos DESC;

-- 4. Partidos ordenados por fecha, para revisar la semana dia a dia.
SELECT cl.nombre_club AS club_local, cv.nombre_club AS club_visitante, p.fecha_partido
FROM partidos p
JOIN clubes cl ON cl.id_club = p.id_club_local
JOIN clubes cv ON cv.id_club = p.id_club_visitante
ORDER BY p.fecha_partido;

-- 5. Reporte semanal para la liga: goles totales por dia (solo
--    partidos jugados), para decidir en que jornada hubo mas actividad.
SELECT
    date(fecha_partido) AS dia,
    SUM(goles_local + goles_visitante) AS goles_del_dia,
    COUNT(*) AS partidos_jugados
FROM partidos
WHERE estado = 'jugado'
GROUP BY date(fecha_partido)
ORDER BY dia;
