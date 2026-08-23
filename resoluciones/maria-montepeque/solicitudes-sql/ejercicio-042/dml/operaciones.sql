PRAGMA foreign_keys = ON;

-- Ejercicio 042: Streaming Musica
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. La reproduccion 9 (Natalia Boror, Bajo el Volcan) se reviso y
--    resulto ser legitima: se corrige el estado de 'en_revision' a
--    'contabilizada'.
UPDATE reproducciones
SET estado = 'contabilizada'
WHERE id_reproduccion = 9 AND estado = 'en_revision';

-- 2. La reproduccion 10 (Camila Rios, Luz de Neon, monto inusualmente
--    alto de 0.0200) se reviso y se confirmo que fue un bot: se marca
--    'fraudulenta' y se revierte su monto_regalia a 0 antes de poder
--    borrarla. Este paso es obligatorio: nunca se borra dinero
--    contabilizado sin revertirlo primero.
UPDATE reproducciones
SET estado = 'fraudulenta',
    monto_regalia = 0
WHERE id_reproduccion = 10 AND estado = 'en_revision';

-- 3. DELETE controlado: solo se borran reproducciones que ya estan
--    'fraudulenta' Y cuyo monto_regalia ya es 0 (ya revertido en el
--    paso anterior). Una reproduccion fraudulenta que todavia tuviera
--    dinero pendiente de revertir NO se borraria con esta condicion.
DELETE FROM reproducciones
WHERE estado = 'fraudulenta' AND monto_regalia = 0;

-- 4. Se elimina la reproduccion duplicada (id_reproduccion = 11): es
--    una copia exacta de la reproduccion 1 por error de digitacion.
--    DELETE seguro porque usa el id exacto de la fila (error de
--    captura, no una decision de negocio).
DELETE FROM reproducciones
WHERE id_reproduccion = 11;
