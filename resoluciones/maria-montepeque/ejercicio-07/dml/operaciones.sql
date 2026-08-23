-- Ejercicio 07: Academia de Cursos
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO instructores (nombre, correo) VALUES
    ('Elena Vargas', 'elena.vargas@academia.com');

INSERT INTO matriculas (id_estudiante, id_curso, fecha_matricula, nota_final, estado) VALUES
    (2, 5, '2026-06-07', NULL, 'activa');

-- 2 UPDATE validos
UPDATE matriculas
SET nota_final = 82, estado = 'aprobada'
WHERE id_matricula = 6;

UPDATE cursos
SET duracion_horas = 45
WHERE id_curso = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM matriculas
WHERE estado = 'retirada';

DELETE FROM matriculas
WHERE id_matricula = 11;
