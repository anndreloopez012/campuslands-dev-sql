PRAGMA foreign_keys = ON;

-- Ejercicio 045: Soldadura Industrial
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. Herberth Sical empezo la reparacion de la reja perimetral
--    (id_orden = 6): se corrige el estado de 'recibida' a
--    'en_proceso'.
UPDATE ordenes
SET estado = 'en_proceso'
WHERE id_orden = 6 AND estado = 'recibida';

-- 2. La rampa de carga de Talleres Vial (id_orden = 3) paso la
--    inspeccion y se entrego: se corrige el estado de 'inspeccion' a
--    'entregada'.
UPDATE ordenes
SET estado = 'entregada'
WHERE id_orden = 3 AND estado = 'inspeccion';

-- 3. DELETE controlado: se elimina el material 8 (Electrodo E7018 de
--    la orden 8) porque el cliente decidio no usarlo. Solo se puede
--    borrar porque su orden todavia esta 'recibida' (el trabajo no ha
--    empezado). Si la orden ya estuviera 'en_proceso' o mas
--    adelante, el material ya se pudo haber usado y no se borraria.
DELETE FROM materiales
WHERE id_material = 8
  AND EXISTS (
      SELECT 1 FROM ordenes o
      WHERE o.id_orden = materiales.id_orden AND o.estado = 'recibida'
  );

-- 4. Se elimina la orden duplicada (id_orden = 9): es una copia
--    exacta de la orden 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio); no tiene materiales asociados, asi que no
--    deja huerfanos.
DELETE FROM ordenes
WHERE id_orden = 9;
