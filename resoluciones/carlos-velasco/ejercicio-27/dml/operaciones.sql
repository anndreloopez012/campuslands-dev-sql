PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO categorias (
    id_categoria,
    nombre
) VALUES (
    6,
    'Inteligencia Artificial'
);

INSERT INTO inscripciones (
    id_inscripcion,
    id_curso,
    nombre_estudiante,
    correo_estudiante,
    fecha_inscripcion,
    estado
) VALUES (
    11,
    2,
    'Luis Mendoza',
    'luis.mendoza@example.com',
    '2026-08-11',
    'Activa'
);

-- UPDATES

UPDATE cursos
SET precio = 235.00
WHERE id_curso = 2;

UPDATE instructores
SET experiencia_anios = 11
WHERE id_instructor = 3;

-- DELETES CONTROLADOS

DELETE FROM inscripciones
WHERE id_inscripcion = 11;

DELETE FROM categorias
WHERE id_categoria = 6;

-- OPERACION INVALIDA: UNIQUE

-- INSERT INTO categorias (
--     id_categoria,
--     nombre
-- ) VALUES (
--     7,
--     'Programacion'
-- );

-- OPERACION INVALIDA: CHECK

-- INSERT INTO cursos (
--     id_curso,
--     nombre,
--     codigo,
--     precio,
--     duracion_horas,
--     id_categoria,
--     id_instructor
-- ) VALUES (
--     7,
--     'Curso Invalido',
--     'CUR-INV-001',
--     -50.00,
--     20,
--     1,
--     1
-- );