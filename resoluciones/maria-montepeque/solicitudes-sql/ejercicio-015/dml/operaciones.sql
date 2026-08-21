PRAGMA foreign_keys = ON;

-- Ejercicio 015: Laboratorio Quimico
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La muestra M-003 (id_muestra = 3) termino su analisis: se corrige
--    el estado de 'en_analisis' a 'completado' y se registra el
--    resultado. WHERE especifico por PK + estado actual.
UPDATE muestras
SET estado = 'completado', resultado = 'Positivo - concentracion 2.5%'
WHERE id_muestra = 3 AND estado = 'en_analisis';

-- 2. Se descuenta del stock el Acido Sulfurico (id_reactivo = 1)
--    consumido en los analisis: 50 ml usados.
UPDATE reactivos
SET stock_disponible = stock_disponible - 50
WHERE id_reactivo = 1;

-- 3. Se elimina la muestra de prueba (id_muestra = 9): nunca fue una
--    muestra real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM muestras
WHERE id_muestra = 9;
