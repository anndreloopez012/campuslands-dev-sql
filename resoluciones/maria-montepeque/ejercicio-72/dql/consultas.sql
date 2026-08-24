.headers on
.mode column

-- Ejercicio 72: INSERT Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (partidas con nombre de
-- equipo local y visitante).
SELECT p.id_partida,
       eloc.nombre_equipo AS equipo_local,
       evis.nombre_equipo AS equipo_visitante,
       p.fecha_partida,
       p.puntaje_local,
       p.puntaje_visitante,
       p.estado
FROM partidas p
JOIN equipos eloc ON eloc.id_equipo = p.id_equipo_local
JOIN equipos evis ON evis.id_equipo = p.id_equipo_visitante;

-- 2. Consulta con WHERE: partidas ya jugadas.
SELECT id_partida, fecha_partida, puntaje_local, puntaje_visitante
FROM partidas
WHERE estado = 'jugada';

-- 3. Consulta con ORDER BY: partidas ordenadas por fecha.
SELECT id_partida, fecha_partida, estado
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: total de partidas por estado.
SELECT estado, COUNT(*) AS total
FROM partidas
GROUP BY estado;

-- 5. Validacion especifica de INSERT: la jornada 2 se creo con
-- INSERT ... SELECT a partir de la jornada 1, invirtiendo local y
-- visitante. Se confirma que por cada partida jugada existe ahora su
-- partida de vuelta programada, con los equipos intercambiados.
SELECT p1.id_partida AS id_ida,
       eloc1.nombre_equipo AS local_ida,
       evis1.nombre_equipo AS visitante_ida,
       p2.id_partida AS id_vuelta,
       eloc2.nombre_equipo AS local_vuelta,
       evis2.nombre_equipo AS visitante_vuelta,
       p2.fecha_partida AS fecha_vuelta,
       p2.estado AS estado_vuelta
FROM partidas p1
JOIN equipos eloc1 ON eloc1.id_equipo = p1.id_equipo_local
JOIN equipos evis1 ON evis1.id_equipo = p1.id_equipo_visitante
JOIN partidas p2
    ON p2.id_equipo_local = p1.id_equipo_visitante
   AND p2.id_equipo_visitante = p1.id_equipo_local
JOIN equipos eloc2 ON eloc2.id_equipo = p2.id_equipo_local
JOIN equipos evis2 ON evis2.id_equipo = p2.id_equipo_visitante
WHERE p1.estado = 'jugada';
