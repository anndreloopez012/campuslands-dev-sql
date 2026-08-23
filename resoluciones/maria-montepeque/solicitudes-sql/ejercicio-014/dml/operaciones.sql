PRAGMA foreign_keys = ON;

-- Ejercicio 014: Mecanica de Autos
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La alineacion y balanceo de la moto 1 (id_reparacion = 4) ya
--    termino: se corrige el estado de 'en_proceso' a 'completada'. WHERE
--    especifico por PK + estado actual.
UPDATE reparaciones
SET estado = 'completada'
WHERE id_reparacion = 4 AND estado = 'en_proceso';

-- 2. Se corrige el nombre del dueno del vehiculo 4: faltaba el apellido
--    completo en el registro original.
UPDATE vehiculos
SET nombre_dueno = 'Karla Diaz Lopez'
WHERE id_vehiculo = 4;

-- 3. Se elimina la entrada de prueba (id_reparacion = 9): nunca fue una
--    reparacion real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM reparaciones
WHERE id_reparacion = 9;
