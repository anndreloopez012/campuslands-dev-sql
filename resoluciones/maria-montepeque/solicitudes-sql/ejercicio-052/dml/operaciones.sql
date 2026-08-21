PRAGMA foreign_keys = ON;

-- Ejercicio 052: Taller de Motos
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. La moto de Herminio Coy con Elena Poou (id_orden = 5) entro a
--    reparacion: se corrige el estado de 'recibida' a
--    'en_reparacion'.
UPDATE ordenes_servicio
SET estado = 'en_reparacion'
WHERE id_orden = 5 AND estado = 'recibida';

-- 2. La moto de Rodrigo Batres con Marvin Us (id_orden = 3) ya se
--    entrego: se corrige el estado de 'listo' a 'entregado'.
UPDATE ordenes_servicio
SET estado = 'entregado'
WHERE id_orden = 3 AND estado = 'listo';

-- 3. DELETE controlado: se elimina el repuesto de la orden cancelada
--    de Paulina Xicay (id_orden = 7). Solo se borra un repuesto
--    cuando la orden a la que pertenece esta 'cancelada'; el
--    encabezado de la orden se conserva como historial.
DELETE FROM repuestos_usados
WHERE id_orden = 7
  AND EXISTS (
      SELECT 1 FROM ordenes_servicio WHERE ordenes_servicio.id_orden = repuestos_usados.id_orden AND ordenes_servicio.estado = 'cancelada'
  );

-- 4. Se elimina la orden duplicada (id_orden = 10): es una copia
--    exacta de la orden 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio); no tiene repuestos propios asociados, asi
--    que no deja huerfanos.
DELETE FROM ordenes_servicio
WHERE id_orden = 10;
