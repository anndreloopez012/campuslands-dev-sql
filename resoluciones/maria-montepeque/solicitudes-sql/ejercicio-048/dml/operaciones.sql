PRAGMA foreign_keys = ON;

-- Ejercicio 048: Clanes Shooter
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. El scrim programado contra Trueno Silencioso (id_scrim = 8) se
--    jugo: se corrige el estado de 'programado' a 'jugado' y se
--    registra el resultado.
UPDATE scrims
SET estado = 'jugado',
    rondas_ganadas = 13,
    rondas_perdidas = 9
WHERE id_scrim = 8 AND estado = 'programado';

-- 2. Al revisar el replay del scrim contra Furia Escarlata en Bunker
--    Norte (id_scrim = 6), se corrigio el conteo de rondas ganadas de
--    13 a 14 (una ronda se habia contado mal).
UPDATE scrims
SET rondas_ganadas = 14
WHERE id_scrim = 6;

-- 3. DELETE controlado: solo se borra un scrim 'cancelado' si nunca
--    se jugo ninguna ronda (rondas_ganadas = 0 AND
--    rondas_perdidas = 0). El scrim 9 cumple la condicion; el scrim
--    10, que sigue 'programado' (no cancelado), no se toca.
DELETE FROM scrims
WHERE id_scrim = 9
  AND estado = 'cancelado'
  AND rondas_ganadas = 0
  AND rondas_perdidas = 0;

-- 4. Se elimina el scrim duplicado (id_scrim = 11): es una copia
--    exacta del scrim 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio).
DELETE FROM scrims
WHERE id_scrim = 11;
