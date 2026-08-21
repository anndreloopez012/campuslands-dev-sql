PRAGMA foreign_keys = ON;

-- Ejercicio 022: Liga MOBA
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La revision de IronFist (id_registro = 3) termino y no hubo trampa:
--    se corrige el estado de 'en_revision' a 'confirmado'. WHERE
--    especifico por PK + estado actual.
UPDATE partidas_jugadas
SET estado = 'confirmado'
WHERE id_registro = 3 AND estado = 'en_revision';

-- 2. IronFist (id_jugador = 2) cambia de rol: de 'top' a 'jungla'.
UPDATE jugadores
SET rol = 'jungla'
WHERE id_jugador = 2;

-- 3. Se elimina el registro duplicado (id_registro = 9): es una copia
--    exacta del registro 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila.
DELETE FROM partidas_jugadas
WHERE id_registro = 9;
