PRAGMA foreign_keys = ON;

-- Ejercicio 016: Hotel Gamers
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Karen Solis hizo check-out (id_reserva = 3): se corrige el estado
--    de 'en_curso' a 'finalizada'. WHERE especifico por PK + estado
--    actual.
UPDATE reservas
SET estado = 'finalizada'
WHERE id_reserva = 3 AND estado = 'en_curso';

-- 2. La habitacion 101 (id_habitacion = 1) entra a mantenimiento tras la
--    ultima salida, ya no esta disponible para nuevas reservas.
UPDATE habitaciones
SET estado = 'mantenimiento'
WHERE id_habitacion = 1;

-- 3. Se elimina la reserva de prueba (id_reserva = 9): nunca fue una
--    estadia real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM reservas
WHERE id_reserva = 9;
