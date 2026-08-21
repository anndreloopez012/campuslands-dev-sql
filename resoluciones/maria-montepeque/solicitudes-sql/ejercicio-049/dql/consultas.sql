.headers on
.mode column

-- Ejercicio 049: Liga Videojuego Futbol
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN a usuario, jornada
--    y ambos clubes).
SELECT
    p.id_partido,
    u.nombre_usuario,
    j.numero_jornada,
    cu.nombre_club AS club_usuario,
    cr.nombre_club AS club_rival,
    p.fecha_partido,
    p.goles_usuario,
    p.goles_rival,
    p.estado
FROM partidos p
JOIN usuarios u ON u.id_usuario = p.id_usuario
JOIN jornadas j ON j.id_jornada = p.id_jornada
JOIN clubes cu ON cu.id_club = p.club_usuario
JOIN clubes cr ON cr.id_club = p.club_rival;

-- 2. Que partidos no estan jugados todavia.
SELECT id_partido, id_usuario, fecha_partido, estado
FROM partidos
WHERE estado <> 'jugado';

-- 3. Que usuario tiene mas partidos jugados.
SELECT u.nombre_usuario, COUNT(*) AS total_partidos
FROM usuarios u
JOIN partidos p ON p.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nombre_usuario
ORDER BY total_partidos DESC, u.nombre_usuario;

-- 4. Partidos ordenados por fecha.
SELECT u.nombre_usuario, cu.nombre_club AS club_usuario, cr.nombre_club AS club_rival, p.fecha_partido
FROM partidos p
JOIN usuarios u ON u.id_usuario = p.id_usuario
JOIN clubes cu ON cu.id_club = p.club_usuario
JOIN clubes cr ON cr.id_club = p.club_rival
ORDER BY p.fecha_partido;

-- 5. Usuario con mas goles anotados en total (solo partidos
--    jugados), para decidir a quien destacar como jugador del mes.
SELECT u.nombre_usuario, SUM(p.goles_usuario) AS goles_totales
FROM usuarios u
JOIN partidos p ON p.id_usuario = u.id_usuario
WHERE p.estado = 'jugado'
GROUP BY u.id_usuario, u.nombre_usuario
ORDER BY goles_totales DESC;
