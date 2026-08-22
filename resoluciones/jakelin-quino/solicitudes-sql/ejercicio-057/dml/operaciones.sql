PRAGMA foreign_keys = ON;

-- Ejercicio 057: Academia Kickboxing
INSERT INTO inscripciones (alumno_id, plan_id, fecha, estado) VALUES (3, 2, '2026-08-15', 'activo');

UPDATE inscripciones SET estado = 'inactivo' WHERE id = 1;

DELETE FROM alumnos WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM inscripciones WHERE alumno_id = alumnos.id);