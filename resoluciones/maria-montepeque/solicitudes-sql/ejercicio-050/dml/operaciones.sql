PRAGMA foreign_keys = ON;

-- Ejercicio 050: Track Day Hiperdeportivos
-- Operaciones de mantenimiento: UPDATE de estado (y correccion de
-- datos) y DELETE controlado.

-- 1. Tras revisar el video, se confirmo un corte de pista en la
--    vuelta de Carlos Mota en la sesion 3 (id_tiempo = 10): se
--    corrige el estado de 'valido' a 'descalificado'. El tiempo
--    registrado (89.100) se conserva como evidencia.
UPDATE tiempos
SET estado = 'descalificado'
WHERE id_tiempo = 10 AND estado = 'valido';

-- 2. Se corrigio el tiempo de Andrea Solares en su segunda vuelta de
--    la sesion 2 (id_tiempo = 8): el cronometro manual tenia un
--    pequeno error y el tiempo real era 86.050, no 86.200.
UPDATE tiempos
SET tiempo_segundos = 86.050
WHERE id_tiempo = 8;

-- 3. DELETE controlado: solo se borra un tiempo 'invalido' si su
--    tiempo_segundos es 0 (la vuelta nunca se completo). El tiempo 9
--    cumple la condicion (Renata Ixchel se salio de pista); un
--    tiempo invalido con un valor real registrado no se borraria con
--    esta condicion.
DELETE FROM tiempos
WHERE id_tiempo = 9
  AND estado = 'invalido'
  AND tiempo_segundos = 0;

-- 4. Se elimina el tiempo duplicado (id_tiempo = 11): es una copia
--    exacta del tiempo 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio).
DELETE FROM tiempos
WHERE id_tiempo = 11;
