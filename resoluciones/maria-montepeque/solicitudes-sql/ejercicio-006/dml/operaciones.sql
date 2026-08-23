PRAGMA foreign_keys = ON;

-- Ejercicio 006: Renta Autos de Lujo
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Tomas Blanco devolvio el Lamborghini (id_reserva = 3): se corrige el
--    estado de 'en_curso' a 'finalizada'. WHERE especifico por PK + estado
--    actual.
UPDATE reservas
SET estado = 'finalizada'
WHERE id_reserva = 3 AND estado = 'en_curso';

-- 2. El Ferrari (id_vehiculo = 1) entra a mantenimiento tras su ultima
--    devolucion, ya no esta disponible para nuevas reservas.
UPDATE vehiculos
SET estado = 'mantenimiento'
WHERE id_vehiculo = 1;

-- 3. Se elimina la reserva de prueba (id_reserva = 8): nunca fue un
--    alquiler real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM reservas
WHERE id_reserva = 8;
