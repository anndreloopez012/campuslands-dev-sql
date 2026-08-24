PRAGMA foreign_keys = ON;

-- Ejercicio 072: Liga MOBA
-- Operaciones de mantenimiento sobre los datos base.

-- 2 UPDATE de confirmacion de resultado: una vez revisadas las
-- estadisticas de cada partida, se confirma el equipo ganador
-- (mas kills en equipo en esa partida).
UPDATE partidas
SET id_equipo_ganador = 1
WHERE id_partida = 1;

UPDATE partidas
SET id_equipo_ganador = 3
WHERE id_partida = 2;

-- 1 UPDATE de estado: la partida 3 se cancela por un conflicto de
-- calendario descubierto despues de programarla.
UPDATE partidas
SET estado = 'cancelada'
WHERE id_partida = 3 AND estado = 'programada';

-- 1 DELETE controlado: la estadistica que se habia cargado por error
-- para la partida 3 ya no tiene sentido, porque esa partida nunca se
-- jugo (quedo 'cancelada'). Solo se permite borrar estadisticas de
-- partidas 'cancelada'; una partida 'jugada' nunca pierde sus
-- estadisticas por este DELETE.
DELETE FROM estadisticas
WHERE id_partida IN (
    SELECT id_partida FROM partidas WHERE estado = 'cancelada'
);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar estadisticas de una partida que ya quedo 'jugada' (resultado
-- oficial del torneo). El DELETE de arriba solo alcanza partidas
-- 'cancelada' por diseno.
-- DELETE FROM estadisticas WHERE id_partida = 1;
