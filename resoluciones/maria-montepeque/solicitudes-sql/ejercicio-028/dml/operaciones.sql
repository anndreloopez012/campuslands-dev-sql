PRAGMA foreign_keys = ON;

-- Ejercicio 028: Torneo Esports
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La revision de la partida de IceQueen (id_partida = 3) termino: se
--    corrige el estado de 'pendiente' a 'confirmada'. WHERE especifico
--    por PK + estado actual.
UPDATE partidas
SET estado = 'confirmada'
WHERE id_partida = 3 AND estado = 'pendiente';

-- 2. IceQueen (id_jugador = 2) cambia de rol: de 'support' a 'entry'.
UPDATE jugadores
SET rol = 'entry'
WHERE id_jugador = 2;

-- 3. Se elimina la partida duplicada (id_partida = 9): es una copia
--    exacta de la partida 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila.
DELETE FROM partidas
WHERE id_partida = 9;
