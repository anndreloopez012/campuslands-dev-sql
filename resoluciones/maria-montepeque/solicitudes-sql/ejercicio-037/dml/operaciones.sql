PRAGMA foreign_keys = ON;

-- Ejercicio 037: Club Futbol Sala
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).
-- El cliente pidio corregir estados sin borrar informacion: por eso
-- las primeras dos operaciones son UPDATE, no DELETE.

-- 1. El partido de Rodrigo Chuc contra Panteras Negras (id_partido = 8)
--    se suspendio por clima: se corrige el estado de 'programado' a
--    'suspendido' sin borrar el registro. WHERE especifico por PK +
--    estado actual.
UPDATE partidos
SET estado = 'suspendido'
WHERE id_partido = 8 AND estado = 'programado';

-- 2. Tras revisar el video, el arbitro confirmo que el gol de Emilio
--    Solares contra Aguilas Rapidas (id_partido = 3) en realidad
--    fueron 2 goles, no 1: se corrige el dato sin borrar el registro.
UPDATE partidos
SET goles = 2
WHERE id_partido = 3;

-- 3. Se elimina el registro duplicado (id_partido = 10): es una
--    copia exacta del partido 1 por error de digitacion. DELETE
--    seguro porque usa el id exacto de la fila (esto si es un error
--    de captura, no un estado de negocio que corregir).
DELETE FROM partidos
WHERE id_partido = 10;
