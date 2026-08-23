PRAGMA foreign_keys = ON;

-- Ejercicio 033: Viajes y Paracaidismo
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Karen Solis confirmo su salto en tandem (id_reserva = 3): se
--    corrige el estado de 'pendiente' a 'confirmada'. WHERE especifico
--    por PK + estado actual.
UPDATE reservas
SET estado = 'confirmada'
WHERE id_reserva = 3 AND estado = 'pendiente';

-- 2. La agencia ajusta el precio del salto en tandem (id_experiencia =
--    2) de 1800.00 a 1900.00.
UPDATE experiencias
SET precio = 1900.00
WHERE id_experiencia = 2;

-- 3. Se elimina la reserva duplicada (id_reserva = 9): es una copia
--    exacta de la reserva 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila.
DELETE FROM reservas
WHERE id_reserva = 9;
