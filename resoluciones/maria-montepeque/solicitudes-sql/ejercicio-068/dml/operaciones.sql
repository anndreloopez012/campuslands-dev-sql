PRAGMA foreign_keys = ON;

-- Ejercicio 068: Escuela de Dibujo
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: la entrega 4 (pendiente) se evalua y pasa a
-- 'evaluada'.
UPDATE entregas
SET estado = 'evaluada'
WHERE id_entrega = 4;

INSERT INTO evaluaciones (id_entrega, nota, comentario) VALUES
    (4, 80, 'Buen estudio de proporciones, falta detalle en sombras');

-- 1 UPDATE de correccion: el profesor revisa de nuevo la entrega 3 y
-- sube la nota (la primera revision fue demasiado estricta).
UPDATE evaluaciones
SET nota = 82
WHERE id_entrega = 3;

-- 1 DELETE controlado: se elimina la entrega 8, que el alumno retiro
-- mientras estaba 'pendiente' (no rompe integridad referencial porque
-- no existe fila en evaluaciones para id_entrega = 8).
DELETE FROM entregas
WHERE id_entrega = 8 AND estado = 'pendiente';

-- Caso que debe fallar (queda comentado): eliminar un alumno que tiene
-- entregas asociadas viola la FOREIGN KEY de entregas.id_alumno.
-- DELETE FROM alumnos WHERE id_alumno = 1;
