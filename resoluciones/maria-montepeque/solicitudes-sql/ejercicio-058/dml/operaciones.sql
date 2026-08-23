PRAGMA foreign_keys = ON;

-- Ejercicio 058: Viajes y Paracaidismo
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. Ana Gomez confirmo su segundo salto en paracaidas
--    (id_reserva = 7): se corrige el estado de 'pendiente' a
--    'confirmada'.
UPDATE reservas
SET estado = 'confirmada'
WHERE id_reserva = 7 AND estado = 'pendiente';

-- 2. Karen Solis realizo su salto en tandem (id_reserva = 3): se
--    corrige el estado de 'confirmada' a 'completada'.
UPDATE reservas
SET estado = 'completada'
WHERE id_reserva = 3 AND estado = 'confirmada';

-- 3. DELETE controlado: solo se borra una reserva 'cancelada' si
--    nunca tuvo ningun pago registrado. La reserva 9 cumple la
--    condicion; la reserva 6, tambien cancelada pero con un deposito
--    ya reembolsado, no se toca: se conserva como historial
--    financiero.
DELETE FROM reservas
WHERE id_reserva = 9
  AND estado = 'cancelada'
  AND NOT EXISTS (
      SELECT 1 FROM pagos WHERE pagos.id_reserva = reservas.id_reserva
  );

-- 4. Se elimina la reserva duplicada (id_reserva = 10): es una copia
--    exacta de la reserva 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio); no tiene pagos propios asociados, asi que
--    no deja huerfanos.
DELETE FROM reservas
WHERE id_reserva = 10;
