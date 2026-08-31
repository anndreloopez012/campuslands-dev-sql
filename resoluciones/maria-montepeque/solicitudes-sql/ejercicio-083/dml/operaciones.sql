PRAGMA foreign_keys = ON;

-- Ejercicio 083: Viajes y Paracaidismo
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que Cristina Barrios cancelo su
-- reserva antes de saltar; el equipo de ventas se habia adelantado a
-- marcarla como realizada.
UPDATE reservas
SET estado = 'cancelada'
WHERE id_reserva = 4 AND estado = 'realizada';

-- 1 DELETE controlado: el pago de la reserva 4 quedo invalido apenas
-- se corrigio el estado (el salto nunca ocurrio). Solo se borran
-- pagos de reservas 'cancelada'; una reserva 'realizada' nunca pierde
-- su pago por este DELETE.
DELETE FROM pagos
WHERE id_reserva IN (
    SELECT id_reserva FROM reservas WHERE estado = 'cancelada'
);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar el pago de la reserva 1, que ya esta 'realizada' (resultado
-- oficial). El DELETE de arriba solo alcanza reservas 'cancelada' por
-- diseno.
-- DELETE FROM pagos WHERE id_reserva = 1;
