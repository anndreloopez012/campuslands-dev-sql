PRAGMA foreign_keys = ON;

-- Ejercicio 081: Renta Autos de Lujo
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: Cristina cancela su reserva antes de recoger el
-- vehiculo.
UPDATE reservas
SET estado = 'cancelada'
WHERE id_reserva = 4 AND estado = 'reservada';

-- 1 DELETE controlado: la inspeccion de entrega de la reserva 4
-- quedo invalida apenas se cancelo (el vehiculo nunca se entrego de
-- verdad). Solo se borran inspecciones de reservas 'cancelada'; una
-- reserva 'en_curso' o 'finalizada' nunca pierde sus inspecciones por
-- este DELETE.
DELETE FROM inspecciones
WHERE id_reserva IN (
    SELECT id_reserva FROM reservas WHERE estado = 'cancelada'
);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar una inspeccion de la reserva 1, que ya esta 'finalizada'
-- (parte del historico oficial). El DELETE de arriba solo alcanza
-- reservas 'cancelada' por diseno.
-- DELETE FROM inspecciones WHERE id_reserva = 1 AND tipo_inspeccion = 'entrega';
