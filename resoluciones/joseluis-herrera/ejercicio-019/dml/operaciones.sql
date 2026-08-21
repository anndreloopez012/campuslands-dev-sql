INSERT INTO estudiantes (
    id_estudiante,
    nombre_completo,
    documento,
    correo,
    fecha_nacimiento
) VALUES (
    6,
    'Maria Hernandez',
    '10010006',
    'maria.hernandez@universidad.edu',
    '2003-09-12'
);

INSERT INTO notas (
    id_nota,
    id_estudiante,
    id_materia,
    id_profesor,
    nota,
    fecha_nota
) VALUES (
    11,
    6,
    1,
    1,
    4.1,
    '2026-08-11'
);

UPDATE estudiantes
SET correo = 'maria.herrera@universidad.edu'
WHERE id_estudiante = 6;

UPDATE notas
SET nota = 4.3
WHERE id_nota = 11;

DELETE FROM notas
WHERE id_nota = 11;

DELETE FROM estudiantes
WHERE id_estudiante = 6;

-- INSERT INTO materias (
--     id_materia,
--     nombre,
--     creditos,
--     semestre
-- ) VALUES (
--     6,
--     'Bases de Datos',
--     4,
--     3
-- );

-- INSERT INTO notas (
--     id_nota,
--     id_estudiante,
--     id_materia,
--     id_profesor,
--     nota,
--     fecha_nota
-- ) VALUES (
--     12,
--     1,
--     999,
--     1,
--     4.0,
--     '2026-08-12'
-- );