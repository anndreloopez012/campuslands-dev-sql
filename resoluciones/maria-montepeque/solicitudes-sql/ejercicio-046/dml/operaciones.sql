PRAGMA foreign_keys = ON;

-- Ejercicio 046: Battle Royale Ranking
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. La partida 6 (Isla Tormenta, 2026-08-12) termino: se corrige el
--    estado de 'en_curso' a 'finalizada'.
UPDATE partidas
SET estado = 'finalizada'
WHERE id_partida = 6 AND estado = 'en_curso';

-- 2. La partida 9 (Isla Tormenta, 2026-08-20) tambien termino: se
--    corrige el estado de 'en_curso' a 'finalizada'.
UPDATE partidas
SET estado = 'finalizada'
WHERE id_partida = 9 AND estado = 'en_curso';

-- 3. DELETE controlado: solo se borra una partida 'anulada' si NO
--    tiene ninguna estadistica registrada. La partida 7 se cayo
--    antes de generar cualquier resultado y cumple la condicion; la
--    partida 8, tambien anulada pero con un resultado parcial ya
--    guardado, NO se toca.
DELETE FROM partidas
WHERE id_partida = 7
  AND estado = 'anulada'
  AND NOT EXISTS (
      SELECT 1 FROM estadisticas WHERE estadisticas.id_partida = partidas.id_partida
  );

-- 4. Se elimina la partida duplicada (id_partida = 10): es una copia
--    exacta de la partida 3 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio); no tiene estadisticas asociadas propias
--    (las de la partida 3 quedan intactas), asi que no deja huerfanos.
DELETE FROM partidas
WHERE id_partida = 10;
