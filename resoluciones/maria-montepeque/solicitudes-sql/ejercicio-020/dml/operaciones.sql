PRAGMA foreign_keys = ON;

-- Ejercicio 020: Soldadura Industrial
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La orden ORD-003 (id_orden = 3) paso la inspeccion: se corrige el
--    estado de 'inspeccionada' a 'aprobada'. WHERE especifico por PK +
--    estado actual.
UPDATE ordenes
SET estado = 'aprobada'
WHERE id_orden = 3 AND estado = 'inspeccionada';

-- 2. Sofia Reyes (id_tecnico = 5) obtuvo una nueva certificacion: de
--    'intermedia' a 'avanzada'.
UPDATE tecnicos
SET certificacion = 'avanzada'
WHERE id_tecnico = 5;

-- 3. Se elimina la orden de prueba (id_orden = 9): nunca fue un trabajo
--    real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM ordenes
WHERE id_orden = 9;
