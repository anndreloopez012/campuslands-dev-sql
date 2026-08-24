PRAGMA foreign_keys = ON;

-- Ejercicio 078: Torneo Esports
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que el servidor fallo durante la
-- partida 3 y su resultado se anula.
UPDATE partidas
SET estado = 'cancelada'
WHERE id_partida = 3 AND estado = 'jugada';

-- 1 DELETE controlado (multiple): las estadisticas de la partida 3
-- quedaron huerfanas apenas se marco 'cancelada'. Solo se borran
-- estadisticas de partidas 'cancelada'; una partida 'jugada' nunca
-- pierde sus estadisticas por este DELETE.
DELETE FROM estadisticas
WHERE id_partida IN (
    SELECT id_partida FROM partidas WHERE estado = 'cancelada'
);

-- 3 UPDATE de recalculo: el ranking de cada equipo se corrige a
-- partir de las estadisticas de las partidas 'jugada' (la partida 3
-- cancelada ya no aporta nada, porque sus estadisticas se eliminaron
-- arriba).
UPDATE ranking
SET puntos_totales = COALESCE((
    SELECT SUM(e.puntos)
    FROM estadisticas e
    JOIN jugadores j ON j.id_jugador = e.id_jugador
    WHERE j.id_equipo = ranking.id_equipo
), 0);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar estadisticas de una partida que ya quedo 'jugada' (resultado
-- oficial del torneo, ya contado en el ranking). El DELETE de arriba
-- solo alcanza partidas 'cancelada' por diseno.
-- DELETE FROM estadisticas WHERE id_partida = 1;
