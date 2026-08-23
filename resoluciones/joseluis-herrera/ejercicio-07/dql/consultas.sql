INSERT INTO estudiantes (
    id_estudiante,
    nombre_completo,
    correo,
    edad,
    fecha_registro,
    estado
) VALUES (
    6,
    'Daniel Fernandez',
    'daniel.fernandez@email.com',
    23,
    '2026-03-01',
    'ACTIVO'
);

INSERT INTO matriculas (
    id_matricula,
    id_estudiante,
    id_curso,
    fecha_matricula,
    nota_final,
    estado
) VALUES (
    11,
    6,
    1,
    '2026-03-02',
    85.0,
    'ACTIVA'
);

UPDATE estudiantes
SET estado = 'INACTIVO'
WHERE id_estudiante = 6;

UPDATE matriculas
SET nota_final = 87.0,
    estado = 'FINALIZADA'
WHERE id_matricula = 11;

DELETE FROM matriculas
WHERE id_matricula = 11;

DELETE FROM estudiantes
WHERE id_estudiante = 6;

-- Operacion invalida: UNIQUE
-- INSERT INTO estudiantes (
--     id_estudiante, nombre_completo, correo, edad, fecha_registro, estado
-- ) VALUES (
--     7, 'Estudiante Duplicado', 'jose.herrera@email.com', 21, '2026-03-05', 'ACTIVO'
-- );

-- Operacion invalida: CHECK
-- INSERT INTO cursos (
--     id_curso, id_instructor, nombre, categoria, duracion_horas, nivel
-- ) VALUES (
--     6, 1, 'Curso Invalido', 'Programacion', 0, 'BASICO'
-- );