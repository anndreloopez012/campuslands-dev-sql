PRAGMA foreign_keys = ON;

-- Ejercicio 018: Escuela de Dibujo
INSERT INTO inscripciones (curso_id, alumno, fecha) VALUES (1, 'Salvador Dali', '2026-08-15');

UPDATE cursos SET costo = 135.00 WHERE id = 1;

DELETE FROM profesores WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM cursos WHERE profesor_id = profesores.id);