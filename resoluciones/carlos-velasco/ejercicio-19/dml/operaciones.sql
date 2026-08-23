PRAGMA foreign_keys = ON;

-- INSERT ADICIONALES

INSERT INTO estudiantes
(id_estudiante, nombre_completo, correo, fecha_ingreso, semestre)
VALUES
(6, 'Andres Mendoza', 'andres.mendoza@campus.edu', '2025-01-15', 3);

INSERT INTO notas
(id_nota, id_estudiante, id_materia, calificacion, fecha_evaluacion, tipo_evaluacion)
VALUES
(11, 6, 2, 4.2, '2026-05-15', 'Proyecto');

-- UPDATE

UPDATE estudiantes
SET semestre = 7
WHERE id_estudiante = 2;

UPDATE notas
SET calificacion = 4.4
WHERE id_nota = 5;

-- DELETE

DELETE FROM notas
WHERE id_nota = 11;

DELETE FROM estudiantes
WHERE id_estudiante = 6;

-- OPERACIONES INVALIDAS

-- CHECK: la calificacion no puede ser superior a 5.
-- INSERT INTO notas
-- (id_nota, id_estudiante, id_materia, calificacion, fecha_evaluacion, tipo_evaluacion)
-- VALUES
-- (12, 1, 1, 5.5, '2026-06-01', 'Final');

-- FOREIGN KEY: el estudiante relacionado debe existir.
-- INSERT INTO notas
-- (id_nota, id_estudiante, id_materia, calificacion, fecha_evaluacion, tipo_evaluacion)
-- VALUES
-- (13, 999, 1, 4.0, '2026-06-01', 'Final');