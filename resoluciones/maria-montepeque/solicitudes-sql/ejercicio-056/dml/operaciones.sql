PRAGMA foreign_keys = ON;

-- Ejercicio 056: Renta Autos de Lujo
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. La reserva del Mercedes AMG GT (id_reserva = 4) termino: se
--    corrige el estado de 'en_curso' a 'finalizada'.
UPDATE reservas
SET estado = 'finalizada'
WHERE id_reserva = 4 AND estado = 'en_curso';

-- 2. La reserva del Audi R8 de Roberto Sagastume (id_reserva = 6)
--    comenzo: se corrige el estado de 'confirmada' a 'en_curso'.
UPDATE reservas
SET estado = 'en_curso'
WHERE id_reserva = 6 AND estado = 'confirmada';

-- 3. DELETE controlado: solo se borra un pago 'reembolsado' si la
--    reserva a la que pertenece esta 'cancelada'. El pago de la
--    reserva 7 cumple la condicion; un pago reembolsado de una
--    reserva que no esta cancelada no se borraria con esta condicion.
DELETE FROM pagos
WHERE estado = 'reembolsado'
  AND EXISTS (
      SELECT 1 FROM reservas WHERE reservas.id_reserva = pagos.id_reserva AND reservas.estado = 'cancelada'
  );

-- 4. Se elimina la reserva duplicada (id_reserva = 10): es una copia
--    exacta de la reserva 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio); no tiene pagos propios asociados, asi que
--    no deja huerfanos.
DELETE FROM reservas
WHERE id_reserva = 10;
