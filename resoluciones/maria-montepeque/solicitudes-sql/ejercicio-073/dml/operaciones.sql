PRAGMA foreign_keys = ON;

-- Ejercicio 073: Clanes Shooter
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que el scrim 5 se cayo a la mitad y
-- su resultado se anula.
UPDATE scrims
SET estado = 'cancelado'
WHERE id_scrim = 5 AND estado = 'jugado';

-- 1 DELETE controlado: el resultado del scrim 5 quedo huerfano apenas
-- se marco 'cancelado' (ya no representa un resultado oficial). Solo
-- se borran resultados de scrims 'cancelado'; un scrim 'jugado' nunca
-- pierde su resultado por este DELETE.
DELETE FROM resultados
WHERE id_scrim IN (
    SELECT id_scrim FROM scrims WHERE estado = 'cancelado'
);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar el resultado de un scrim que ya quedo 'jugado' (dato oficial
-- de la liga). El DELETE de arriba solo alcanza scrims 'cancelado'
-- por diseno.
-- DELETE FROM resultados WHERE id_scrim = 1;
