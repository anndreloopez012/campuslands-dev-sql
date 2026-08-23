PRAGMA foreign_keys = ON;

-- Ejercicio 040: Laboratorio Quimico
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La muestra pendiente de Mezcla Gamma-3 (id_muestra = 4) fue
--    revisada y paso el control: se corrige el resultado de
--    'pendiente' a 'valido'. WHERE especifico por PK + resultado
--    actual.
UPDATE muestras
SET resultado = 'valido'
WHERE id_muestra = 4 AND resultado = 'pendiente';

-- 2. La muestra de Compuesto Alfa-7 marcada como 'invalido'
--    (id_muestra = 5) se reclasifica como 'repetir', porque el
--    laboratorio decidio volver a tomarla en vez de descartarla.
UPDATE muestras
SET resultado = 'repetir'
WHERE id_muestra = 5;

-- 3. Se elimina la muestra duplicada (id_muestra = 10): es una copia
--    exacta de la muestra 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila.
DELETE FROM muestras
WHERE id_muestra = 10;
