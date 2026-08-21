PRAGMA foreign_keys = ON;

-- Ejercicio 038: Clinica de Tatuajes
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La sesion de Cesar Molina con Karla Fong (id_sesion = 4) se
--    realizo y se pago completa: se corrige el estado de 'agendada' a
--    'completada' y el monto pagado de 0.00 a 600.00.
UPDATE sesiones
SET estado = 'completada',
    monto_pagado = 600.00
WHERE id_sesion = 4 AND estado = 'agendada';

-- 2. Josue Batz termino de pagar el saldo pendiente de su sesion con
--    Karla Fong (id_sesion = 3): el monto pagado sube de 1000.00 a
--    2000.00 (el costo total completo).
UPDATE sesiones
SET monto_pagado = 2000.00
WHERE id_sesion = 3;

-- 3. Se elimina la sesion duplicada (id_sesion = 10): es una copia
--    exacta de la sesion 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila.
DELETE FROM sesiones
WHERE id_sesion = 10;
