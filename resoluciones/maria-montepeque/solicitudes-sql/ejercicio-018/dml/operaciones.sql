PRAGMA foreign_keys = ON;

-- Ejercicio 018: Escuela de Dibujo
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Se evaluo la entrega de Karen Solis (id_entrega = 3): se corrige el
--    estado de 'pendiente' a 'evaluada' y se registra la calificacion.
--    WHERE especifico por PK + estado actual.
UPDATE entregas
SET estado = 'evaluada', calificacion = 82
WHERE id_entrega = 3 AND estado = 'pendiente';

-- 2. La escuela ajusta el precio del curso de Anime y Manga (id_curso =
--    3) de 220.00 a 270.00.
UPDATE cursos
SET precio = 270.00
WHERE id_curso = 3;

-- 3. Se elimina la entrada de prueba (id_entrega = 9): nunca fue una
--    entrega real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM entregas
WHERE id_entrega = 9;
