PRAGMA foreign_keys = ON;

-- Ejercicio 071: Battle Royale Ranking
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que la partida 5 se cayo a la
-- mitad y su resultado se anula.
UPDATE partidas
SET estado = 'cancelada'
WHERE id_partida = 5 AND estado = 'jugada';

-- 1 DELETE controlado: las estadisticas de la partida 5 quedaron
-- huerfanas apenas se marco 'cancelada' (no deben contar para el
-- ranking). Solo se borran estadisticas de partidas 'cancelada'; una
-- partida 'jugada' nunca pierde sus estadisticas por este DELETE.
DELETE FROM estadisticas
WHERE id_partida IN (
    SELECT id_partida FROM partidas WHERE estado = 'cancelada'
);

-- 1 UPDATE de recalculo: el ranking de la temporada se actualiza a
-- partir de las estadisticas de las partidas 'jugada' (1 punto por
-- kill, mas bono de 10 puntos para el 1er lugar y 5 puntos del 2do al
-- 5to lugar). Se corrige el ranking existente, no se borra ni se
-- vuelve a insertar.
UPDATE ranking
SET puntos_totales = COALESCE((
    SELECT SUM(
        e.kills +
        CASE
            WHEN e.posicion_final = 1 THEN 10
            WHEN e.posicion_final <= 5 THEN 5
            ELSE 0
        END
    )
    FROM estadisticas e
    JOIN partidas p ON p.id_partida = e.id_partida
    WHERE e.id_jugador = ranking.id_jugador
      AND p.id_temporada = ranking.id_temporada
      AND p.estado = 'jugada'
), 0)
WHERE id_temporada = 1;

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar estadisticas de una partida que ya quedo 'jugada' (resultado
-- oficial, ya contado en el ranking). El DELETE de arriba solo alcanza
-- partidas 'cancelada' por diseno; esto seria un error de negocio, no
-- solo tecnico.
-- DELETE FROM estadisticas WHERE id_partida = 1;
