PRAGMA foreign_keys = ON;

-- Ejercicio 066: Hotel Gamers
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: la reserva 3 hace check-out y pasa de 'activa' a
-- 'finalizada'.
UPDATE reservas
SET estado = 'finalizada'
WHERE id_reserva = 3;

-- 1 UPDATE de correccion: se corrige el monto del consumo de minibar de
-- la reserva 2 (se habia registrado un cargo incompleto).
UPDATE consumos
SET monto = 55.00
WHERE id_reserva = 2 AND descripcion = 'Minibar';

-- 1 DELETE controlado: se elimina la reserva 5, que quedo 'cancelada' y
-- nunca genero consumos (no rompe integridad referencial porque no
-- existe fila en consumos para id_reserva = 5).
DELETE FROM reservas
WHERE id_reserva = 5 AND estado = 'cancelada';

-- Caso que debe fallar (queda comentado): eliminar una habitacion que
-- tiene reservas asociadas viola la FOREIGN KEY de reservas.id_habitacion.
-- DELETE FROM habitaciones WHERE id_habitacion = 1;
