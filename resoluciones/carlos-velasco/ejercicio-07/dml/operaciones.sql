PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. INSERT adicional
-- =========================================================

INSERT INTO cursos (
    id_curso,
    nombre,
    categoria,
    duracion_horas,
    nivel
) VALUES (
    6,
    'Docker para Desarrollo',
    'DevOps',
    45,
    'INTERMEDIO'
);

-- =========================================================
-- 2. INSERT adicional
-- =========================================================

INSERT INTO estudiantes (
    id_estudiante,
    nombre_completo,
    email,
    fecha_nacimiento,
    ciudad
) VALUES (
    6,
    'Mariana Gomez',
    'mariana.gomez@email.com',
    '2003-09-25',
    'Amatitlan'
);

-- =========================================================
-- 3. UPDATE válido
-- =========================================================

UPDATE cursos
SET duracion_horas = 50
WHERE id_curso = 6;

-- =========================================================
-- 4. UPDATE válido
-- =========================================================

UPDATE estudiantes
SET ciudad = 'Escuintla'
WHERE id_estudiante = 6;

-- =========================================================
-- 5. DELETE controlado
-- =========================================================

DELETE FROM cursos
WHERE id_curso = 6;

-- =========================================================
-- 6. DELETE controlado
-- =========================================================

DELETE FROM estudiantes
WHERE id_estudiante = 6;

-- =========================================================
-- OPERACIONES QUE DEBEN FALLAR
-- Se mantienen comentadas.
-- =========================================================

-- CHECK: el progreso no puede ser mayor que 100.
-- INSERT INTO matriculas (
--     id_matricula,
--     id_estudiante,
--     id_curso,
--     id_instructor,
--     fecha_matricula,
--     progreso,
--     estado
-- ) VALUES (
--     11,
--     1,
--     2,
--     2,
--     '2026-07-01',
--     150,
--     'ACTIVA'
-- );

-- UNIQUE: el correo del estudiante ya existe.
-- INSERT INTO estudiantes (
--     id_estudiante,
--     nombre_completo,
--     email,
--     fecha_nacimiento,
--     ciudad
-- ) VALUES (
--     7,
--     'Estudiante Duplicado',
--     'carlos.mendoza@email.com',
--     '2004-01-15',
--     'Guatemala'
-- );

-- FOREIGN KEY: el curso 999 no existe.
-- INSERT INTO matriculas (
--     id_matricula,
--     id_estudiante,
--     id_curso,
--     id_instructor,
--     fecha_matricula,
--     progreso,
--     estado
-- ) VALUES (
--     12,
--     1,
--     999,
--     1,
--     '2026-07-02',
--     10,
--     'ACTIVA'
-- );