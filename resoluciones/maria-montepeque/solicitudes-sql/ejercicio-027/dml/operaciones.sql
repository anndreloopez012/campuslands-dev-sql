PRAGMA foreign_keys = ON;

-- Ejercicio 027: Taller de Motos
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. El ajuste de cadena de la moto 1 (id_orden = 3) ya termino: se
--    corrige el estado de 'en_proceso' a 'completada'. WHERE especifico
--    por PK + estado actual.
UPDATE ordenes_servicio
SET estado = 'completada'
WHERE id_orden = 3 AND estado = 'en_proceso';

-- 2. Se actualiza el telefono de Karla Diaz (id_cliente = 4).
UPDATE clientes
SET telefono = '5559001'
WHERE id_cliente = 4;

-- 3. Se elimina la orden duplicada (id_orden = 9): nunca fue un trabajo
--    real, es el unico caso donde SI se borra (no se corrige un estado
--    porque no hay nada real que corregir). DELETE seguro porque usa el
--    id exacto de la fila.
DELETE FROM ordenes_servicio
WHERE id_orden = 9;
