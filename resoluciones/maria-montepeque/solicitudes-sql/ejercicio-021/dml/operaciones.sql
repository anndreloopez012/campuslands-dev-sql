PRAGMA foreign_keys = ON;

-- Ejercicio 021: Battle Royale Ranking
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La estadistica de BlazeStorm (id_estadistica = 3) termino su
--    revision y no hubo trampa: se corrige el estado de 'en_revision' a
--    'confirmada'. WHERE especifico por PK + estado actual.
UPDATE estadisticas
SET estado = 'confirmada'
WHERE id_estadistica = 3 AND estado = 'en_revision';

-- 2. ShadowFox (id_jugador = 1) sube de nivel tras su buen desempeno en
--    la semana.
UPDATE jugadores
SET nivel = nivel + 1
WHERE id_jugador = 1;

-- 3. Se elimina la estadistica duplicada (id_estadistica = 9): es una
--    copia exacta de la estadistica 1 por error de digitacion. DELETE
--    seguro porque usa el id exacto de la fila.
DELETE FROM estadisticas
WHERE id_estadistica = 9;
