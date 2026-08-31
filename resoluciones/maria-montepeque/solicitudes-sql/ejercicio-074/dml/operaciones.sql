PRAGMA foreign_keys = ON;

-- Ejercicio 074: Liga Videojuego Futbol
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que el partido 3 se desconecto a la
-- mitad y su resultado se anula.
UPDATE partidos
SET estado = 'cancelado'
WHERE id_partido = 3 AND estado = 'jugado';

-- 1 DELETE controlado: el gol del partido 3 quedo huerfano apenas se
-- marco 'cancelado' (ya no representa un resultado oficial). Solo se
-- borran goles de partidos 'cancelado'; un partido 'jugado' nunca
-- pierde sus goles por este DELETE.
DELETE FROM goles
WHERE id_partido IN (
    SELECT id_partido FROM partidos WHERE estado = 'cancelado'
);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar goles de un partido que ya quedo 'jugado' (resultado oficial
-- de la liga). El DELETE de arriba solo alcanza partidos 'cancelado'
-- por diseno.
-- DELETE FROM goles WHERE id_partido = 1;
