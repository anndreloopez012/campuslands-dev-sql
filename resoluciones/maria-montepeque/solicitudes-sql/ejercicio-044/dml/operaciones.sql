PRAGMA foreign_keys = ON;

-- Ejercicio 044: Diseno 3D Arquitectura
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. La Vista Aerea Lotes (id_render = 2) recibio los cambios que
--    pidio el cliente y se aprobo en una segunda revision: se corrige
--    el estado de 'en_revision' a 'aprobado'.
UPDATE renders
SET estado = 'aprobado'
WHERE id_render = 2 AND estado = 'en_revision';

-- 2. La Fachada Plaza Pacifico (id_render = 9) se envio a revision:
--    se corrige el estado de 'en_proceso' a 'en_revision'.
UPDATE renders
SET estado = 'en_revision'
WHERE id_render = 9 AND estado = 'en_proceso';

-- 3. DELETE controlado: solo se borra un render si sigue
--    'en_proceso' Y nunca tuvo ninguna revision registrada. El
--    render 10 (una prueba creada por error) cumple ambas
--    condiciones; cualquier otro render 'en_proceso' que ya tuviera
--    una revision (o que ya avanzo de estado) no se veria afectado.
DELETE FROM renders
WHERE id_render = 10
  AND estado = 'en_proceso'
  AND NOT EXISTS (
      SELECT 1 FROM revisiones WHERE revisiones.id_render = renders.id_render
  );

-- 4. Se elimina el render duplicado (id_render = 11): es una copia
--    exacta del render 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio).
DELETE FROM renders
WHERE id_render = 11;
