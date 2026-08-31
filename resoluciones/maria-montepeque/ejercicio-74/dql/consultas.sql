.headers on
.mode column

-- Ejercicio 74: UPDATE Nivel Basico
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

-- 5. Validacion especifica de UPDATE: la partida 1 quedo con
-- puntaje_local = 2 (broto 3, la revision en video resto 1 con un
-- UPDATE por expresion) y estado = 'jugada'; las partidas 3 y 4
-- quedaron 'cancelada' por el UPDATE multiple con WHERE IN.
SELECT id_partida, puntaje_local, puntaje_visitante, estado
FROM partidas
WHERE id_partida IN (1, 3, 4);
