PRAGMA foreign_keys = ON;

-- Ejercicio 047: Liga MOBA
-- Operaciones de mantenimiento: UPDATE de estado (y estadisticas) y
-- DELETE controlado.

-- 1. La partida 7 (IronWisp) se reviso y se confirmo valida; ademas
--    se corrigio el conteo de kills de 3 a 4 tras revisar la
--    repeticion: se corrige sin borrar nada.
UPDATE partidas
SET estado = 'valida',
    kills = 4
WHERE id_partida = 7 AND estado = 'en_revision';

-- 2. Se confirmo un bug reportado en la partida 3 (SolaraFX): se
--    anula el resultado para efectos de ranking, pero se conservan
--    intactas sus estadisticas (kills, deaths, assists) como
--    evidencia. Exactamente lo que pidio el cliente: corregir el
--    estado sin borrar informacion importante.
UPDATE partidas
SET estado = 'anulada'
WHERE id_partida = 3 AND estado = 'valida';

-- 3. DELETE controlado: solo se borra una partida 'anulada' si nunca
--    genero ninguna estadistica real (kills = 0 AND deaths = 0 AND
--    assists = 0). La partida 9 cumple la condicion (se cayo el
--    servidor antes de que empezara el combate); la partida 3,
--    tambien anulada pero con estadisticas reales, NO se toca.
DELETE FROM partidas
WHERE id_partida = 9
  AND estado = 'anulada'
  AND kills = 0
  AND deaths = 0
  AND assists = 0;

-- 4. Se elimina la partida duplicada (id_partida = 11): es una copia
--    exacta de la partida 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio).
DELETE FROM partidas
WHERE id_partida = 11;
