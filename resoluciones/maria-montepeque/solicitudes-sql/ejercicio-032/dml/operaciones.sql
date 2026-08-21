PRAGMA foreign_keys = ON;

-- Ejercicio 032: Academia Kickboxing
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Se verifico la transferencia de Carlos Ruiz (id_pago = 3): se
--    corrige el estado de 'pendiente' a 'confirmado'. WHERE especifico
--    por PK + estado actual.
UPDATE pagos
SET estado = 'confirmado'
WHERE id_pago = 3 AND estado = 'pendiente';

-- 2. Andres Lopez (id_alumno = 1) cambia de entrenador: de Pedro Ruiz a
--    Luis Marin.
UPDATE alumnos
SET entrenador_asignado = 'Luis Marin'
WHERE id_alumno = 1;

-- 3. Se elimina el pago duplicado (id_pago = 9): es una copia exacta
--    del pago 1 por error de digitacion. DELETE seguro porque usa el id
--    exacto de la fila.
DELETE FROM pagos
WHERE id_pago = 9;
