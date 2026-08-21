PRAGMA foreign_keys = ON;

-- Ejercicio 023: Clanes Shooter
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La revision del replay del scrim 3 confirmo el resultado tal como
--    se registro: se corrige el estado de 'disputado' a 'jugado'. WHERE
--    especifico por PK + estado actual.
UPDATE scrims
SET estado = 'jugado'
WHERE id_scrim = 3 AND estado = 'disputado';

-- 2. SilentBlade (id_jugador = 2) cambia de rol: de 'sniper' a 'entry'.
UPDATE jugadores
SET rol = 'entry'
WHERE id_jugador = 2;

-- 3. Se elimina el scrim duplicado (id_scrim = 9): es una copia exacta
--    del scrim 1 por error de digitacion. DELETE seguro porque usa el
--    id exacto de la fila.
DELETE FROM scrims
WHERE id_scrim = 9;
