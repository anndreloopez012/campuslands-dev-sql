.headers on
.mode column

-- Ejercicio 024: Liga Videojuego Futbol
-- 1. Tabla de posiciones de clubes
SELECT c.nombre_club, u.psn_id AS mánager, c.puntos FROM clubes c JOIN usuarios u ON u.id = c.usuario_id ORDER BY c.puntos DESC;

-- 2. Enfrentamientos de la liga
SELECT j.id, c1.nombre_club AS local, j.goles_local, j.goles_visita, c2.nombre_club AS visita FROM jornadas j JOIN clubes c1 ON c1.id = j.club_local_id JOIN clubes c2 ON c2.id = j.club_visita_id;

-- 3. Goles anotados por club local
SELECT c.nombre_club, SUM(j.goles_local) AS goles_afavor FROM jornadas j JOIN clubes c ON c.id = j.club_local_id GROUP BY c.id, c.nombre_club;