PRAGMA foreign_keys = ON;

-- Ejercicio 043: Escuela de Dibujo
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. Wendy Choc entrego su trabajo de Pintura Digital Avanzada
--    (id_entrega = 3) y ya se evaluo: se corrige el estado de
--    'entregada' a 'evaluada' y se registra la calificacion.
UPDATE entregas
SET calificacion = 90.0,
    estado = 'evaluada'
WHERE id_entrega = 3 AND estado = 'entregada';

-- 2. Brandon Us entrego su trabajo de Manga Intermedio
--    (id_entrega = 6) y ya se evaluo.
UPDATE entregas
SET calificacion = 91.0,
    estado = 'evaluada'
WHERE id_entrega = 6 AND estado = 'entregada';

-- 3. DELETE controlado: se elimina la inscripcion equivocada de
--    Wendy Choc en Retrato a Lapiz (id_alumno = 3, id_curso = 1).
--    Las tres condiciones deben cumplirse a la vez: mismo alumno,
--    mismo curso incorrecto, y que siga 'pendiente' (nunca entrego
--    nada real). Esto evita borrar por accidente cualquier otra
--    entrega pendiente legitima, como la de Diego Sacbaja.
DELETE FROM entregas
WHERE id_alumno = 3
  AND id_curso = 1
  AND estado = 'pendiente';

-- 4. Se elimina la entrega duplicada (id_entrega = 11): es una copia
--    exacta de la entrega 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio).
DELETE FROM entregas
WHERE id_entrega = 11;
