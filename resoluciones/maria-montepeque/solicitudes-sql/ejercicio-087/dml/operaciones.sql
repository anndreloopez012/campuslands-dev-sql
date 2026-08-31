PRAGMA foreign_keys = ON;

-- Ejercicio 087: Club Futbol Sala
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que se corto la luz de la cancha
-- durante el partido 3 y se suspende.
UPDATE partidos
SET estado = 'suspendido'
WHERE id_partido = 3 AND estado = 'finalizado';

-- 2 DELETE controlados: el gol y la tarjeta del partido 3 quedaron
-- huerfanos apenas se marco 'suspendido'. Solo se borran registros de
-- partidos 'suspendido'; un partido 'finalizado' nunca pierde sus
-- goles ni tarjetas por estos DELETE.
DELETE FROM goles
WHERE id_partido IN (
    SELECT id_partido FROM partidos WHERE estado = 'suspendido'
);

DELETE FROM tarjetas
WHERE id_partido IN (
    SELECT id_partido FROM partidos WHERE estado = 'suspendido'
);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar un gol del partido 1, que ya esta 'finalizado' (historico
-- oficial). Los DELETE de arriba solo alcanzan partidos 'suspendido'
-- por diseno.
-- DELETE FROM goles WHERE id_partido = 1;
