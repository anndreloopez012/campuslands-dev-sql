PRAGMA foreign_keys = ON;

-- Ejercicio 025: Track Day Hiperdeportivos
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La revision de la sesion 3 (Porsche 911 GT3) confirmo que no hubo
--    corte de pista: se corrige el estado de 'en_revision' a 'valida'.
--    WHERE especifico por PK + estado actual.
UPDATE sesiones
SET estado = 'valida'
WHERE id_sesion = 3 AND estado = 'en_revision';

-- 2. Marta Vega (id_piloto = 2) asciende de categoria: de
--    'semi_profesional' a 'profesional'.
UPDATE pilotos
SET categoria = 'profesional'
WHERE id_piloto = 2;

-- 3. Se elimina la sesion duplicada (id_sesion = 9): es una copia
--    exacta de la sesion 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila.
DELETE FROM sesiones
WHERE id_sesion = 9;
