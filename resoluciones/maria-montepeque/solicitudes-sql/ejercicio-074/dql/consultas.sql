.headers on
.mode column

-- Ejercicio 074: Liga Videojuego Futbol
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todos los goles con su club,
-- su partido y su jornada.
SELECT g.id_gol,
       c.nombre_club,
       j.numero_jornada,
       p.fecha_partido,
       g.minuto
FROM goles g
JOIN clubes c ON c.id_club = g.id_club
JOIN partidos p ON p.id_partido = g.id_partido
JOIN jornadas j ON j.id_jornada = p.id_jornada;

-- 2. Que partidos estan programados, jugados o cancelados.
SELECT id_partido, fecha_partido, estado
FROM partidos
ORDER BY estado;

-- 3. Que club anoto mas goles en total (ranking de actividad).
SELECT c.nombre_club, COUNT(*) AS goles_totales
FROM clubes c
JOIN goles g ON g.id_club = c.id_club
GROUP BY c.id_club, c.nombre_club
ORDER BY goles_totales DESC, c.nombre_club;

-- 4. Goles ordenados por minuto.
SELECT g.id_gol, c.nombre_club, g.minuto
FROM goles g
JOIN clubes c ON c.id_club = g.id_club
ORDER BY g.minuto;

-- 5. Reporte rapido semanal (lo que pidio el cliente): goles por club
-- dentro de la jornada 1, para decidir quien domino la semana
-- (GROUP BY + HAVING).
SELECT c.nombre_club,
       SUM(1) AS goles_jornada
FROM goles g
JOIN partidos p ON p.id_partido = g.id_partido
JOIN clubes c ON c.id_club = g.id_club
WHERE p.id_jornada = 1
GROUP BY c.id_club, c.nombre_club
HAVING SUM(1) >= 2
ORDER BY goles_jornada DESC;
