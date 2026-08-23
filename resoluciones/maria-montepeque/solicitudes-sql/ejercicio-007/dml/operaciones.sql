PRAGMA foreign_keys = ON;

-- Ejercicio 007: Academia Kickboxing
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Diana Cruz se puso al dia con el pago (id_alumno = 4): se corrige su
--    estado de 'suspendido' a 'activo'. Esto es exactamente lo que pidio
--    el cliente: corregir, no borrar. WHERE especifico por PK + estado
--    actual.
UPDATE alumnos
SET estado = 'activo'
WHERE id_alumno = 4 AND estado = 'suspendido';

-- 2. La academia ajusta el precio del Plan Intermedio (id_plan = 2) de
--    350.00 a 380.00.
UPDATE planes
SET precio_mensual = 380.00
WHERE id_plan = 2;

-- 3. Se elimina la entrada de prueba (id_alumno = 9): nunca fue un
--    alumno real, es el unico caso donde SI se borra (no se corrige un
--    estado porque no hay nada real que corregir). DELETE seguro porque
--    usa el id exacto de la fila.
DELETE FROM alumnos
WHERE id_alumno = 9;
