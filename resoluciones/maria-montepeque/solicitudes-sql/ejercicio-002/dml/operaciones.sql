PRAGMA foreign_keys = ON;

-- Ejercicio 002: Taller de Motos
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. El ajuste de cadena de la moto 1 (id_orden = 3) ya termino: se
--    corrige el estado de 'en_proceso' a 'completada'. WHERE especifico
--    por PK + estado actual.
UPDATE ordenes_trabajo
SET estado = 'completada'
WHERE id_orden = 3 AND estado = 'en_proceso';

-- 2. Se corrige el nombre del dueno de la moto 4: faltaba el apellido
--    completo en el registro original.
UPDATE motos
SET nombre_dueno = 'Karla Diaz Lopez'
WHERE id_moto = 4;

-- 3. Se elimina la orden duplicada (id_orden = 8): es una copia exacta de
--    la orden 2 por error de digitacion. DELETE seguro porque usa el id
--    exacto de la fila duplicada.
DELETE FROM ordenes_trabajo
WHERE id_orden = 8;
