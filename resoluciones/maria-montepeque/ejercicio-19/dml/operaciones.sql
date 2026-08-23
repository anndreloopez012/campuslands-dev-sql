-- Ejercicio 19: Universidad Notas
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO estudiantes (nombre, carnet, correo) VALUES
    ('Ingrid Say', 'CARN-3006', 'ingrid.say@correo.com');

INSERT INTO notas (id_estudiante, id_materia, id_profesor, nota, fecha) VALUES
    (2, 5, 5, 89.0, '2026-06-06');

-- 2 UPDATE validos
UPDATE notas
SET nota = 68.0
WHERE id_nota = 5;

UPDATE materias
SET creditos = 5
WHERE id_materia = 4;

-- 2 DELETE controlados con WHERE
DELETE FROM notas
WHERE id_nota = 6;

DELETE FROM notas
WHERE id_estudiante = 5 AND id_nota = 9;
