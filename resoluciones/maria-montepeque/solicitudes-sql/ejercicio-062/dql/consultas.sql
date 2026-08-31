.headers on
.mode column

-- Ejercicio 062: Club Futbol Sala
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: goles con jugador, equipo y
-- partido en el que ocurrieron.
SELECT g.id_gol,
       j.nombre AS jugador,
       e.nombre AS equipo,
       g.id_partido,
       g.minuto
FROM goles g
JOIN jugadores j ON j.id_jugador = g.id_jugador
JOIN equipos e ON e.id_equipo = j.id_equipo
ORDER BY g.id_partido, g.minuto;

-- 2. Que registros estan programados, en curso o finalizados.
SELECT id_partido, fecha_partido, estado
FROM partidos
ORDER BY estado;

-- 3. Que jugador tiene mas actividad goleadora (ranking de goleadores).
SELECT j.nombre AS jugador,
       e.nombre AS equipo,
       COUNT(*) AS goles_anotados
FROM goles g
JOIN jugadores j ON j.id_jugador = g.id_jugador
JOIN equipos e ON e.id_equipo = j.id_equipo
GROUP BY j.id_jugador
ORDER BY goles_anotados DESC;

-- 4. Partidos ordenados por fecha, del mas reciente al mas antiguo.
SELECT p.id_partido,
       el.nombre AS equipo_local,
       ev.nombre AS equipo_visitante,
       p.fecha_partido,
       p.estado
FROM partidos p
JOIN equipos el ON el.id_equipo = p.id_equipo_local
JOIN equipos ev ON ev.id_equipo = p.id_equipo_visitante
ORDER BY p.fecha_partido DESC;

-- 5. Reporte para decision de negocio: equipos con mas de una tarjeta
-- acumulada (GROUP BY + HAVING), para decisiones disciplinarias.
SELECT e.nombre AS equipo,
       COUNT(*) AS total_tarjetas
FROM tarjetas t
JOIN jugadores j ON j.id_jugador = t.id_jugador
JOIN equipos e ON e.id_equipo = j.id_equipo
GROUP BY e.id_equipo
HAVING COUNT(*) > 1
ORDER BY total_tarjetas DESC;
