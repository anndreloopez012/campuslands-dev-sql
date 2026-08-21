PRAGMA foreign_keys = ON;

-- Ejercicio 053: Torneo Esports
-- Operaciones de mantenimiento: UPDATE de estado (y correccion de
-- datos) y DELETE controlado.

-- 1. La partida contra Aurora Gaming (id_partida = 7) se jugo: se
--    corrige el estado de 'programada' a 'jugada'.
UPDATE partidas
SET estado = 'jugada'
WHERE id_partida = 7 AND estado = 'programada';

-- 2. Tras una revision administrativa, se confirmo que el resultado
--    de la partida 4 (contra Kraken Digital) se habia registrado al
--    reves: en realidad fue derrota, no victoria. Se corrige sin
--    borrar el registro ni las estadisticas de esa partida.
UPDATE partidas
SET resultado = 'derrota'
WHERE id_partida = 4;

-- 3. DELETE controlado: solo se borra una partida 'pospuesta' si
--    nunca genero ninguna estadistica. La partida 8 cumple la
--    condicion (se pospuso antes de jugarse); una partida pospuesta
--    que ya tuviera estadisticas registradas no se borraria con
--    esta condicion.
DELETE FROM partidas
WHERE id_partida = 8
  AND estado = 'pospuesta'
  AND NOT EXISTS (
      SELECT 1 FROM estadisticas WHERE estadisticas.id_partida = partidas.id_partida
  );

-- 4. Se elimina la partida duplicada (id_partida = 10): es una copia
--    exacta de la partida 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio); no tiene estadisticas propias asociadas,
--    asi que no deja huerfanos.
DELETE FROM partidas
WHERE id_partida = 10;
