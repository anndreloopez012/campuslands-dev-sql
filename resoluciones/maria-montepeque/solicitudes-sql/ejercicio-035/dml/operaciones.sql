PRAGMA foreign_keys = ON;

-- Ejercicio 035: Biblioteca Sci-Fi
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. El prestamo de Neuromante a Bryan Solis (id_prestamo = 2) paso su
--    fecha de devolucion esperada sin que el libro volviera: se marca
--    como 'atrasado'. WHERE especifico por PK + estado actual.
UPDATE prestamos
SET estado = 'atrasado'
WHERE id_prestamo = 2 AND estado = 'prestado';

-- 2. Jorge Cifuentes pidio una renovacion para Fundacion
--    (id_prestamo = 5): se extiende la fecha de devolucion esperada
--    de 2026-08-24 a 2026-08-31.
UPDATE prestamos
SET fecha_devolucion_esperada = '2026-08-31'
WHERE id_prestamo = 5;

-- 3. Se elimina el prestamo duplicado (id_prestamo = 10): es una
--    copia exacta del prestamo 9 por error de digitacion. DELETE
--    seguro porque usa el id exacto de la fila.
DELETE FROM prestamos
WHERE id_prestamo = 10;
