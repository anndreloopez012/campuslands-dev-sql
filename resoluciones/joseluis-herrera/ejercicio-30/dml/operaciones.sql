INSERT INTO campers (
    id_camper,
    id_ruta,
    nombre_completo,
    email,
    fecha_ingreso,
    estado
) VALUES (
    6,
    4,
    'Sofia Morales',
    'sofia.morales@campus.com',
    '2026-02-01',
    'activo'
);

INSERT INTO modulos (
    id_modulo,
    id_ruta,
    id_trainer,
    nombre,
    horas,
    fecha_inicio,
    fecha_fin
) VALUES (
    6,
    4,
    2,
    'SQL Avanzado',
    70,
    '2026-04-20',
    '2026-05-20'
);

UPDATE campers
SET estado = 'graduado'
WHERE id_camper = 5;

UPDATE trainers
SET especialidad = 'JavaScript y TypeScript'
WHERE id_trainer = 1;

DELETE FROM modulos
WHERE id_modulo = 6;

DELETE FROM campers
WHERE id_camper = 6;

-- INSERT que falla por UNIQUE
-- INSERT INTO campers (
--     id_camper,
--     id_ruta,
--     nombre_completo,
--     email,
--     fecha_ingreso,
--     estado
-- ) VALUES (
--     7,
--     1,
--     'Camper Duplicado',
--     'jose.perez@campus.com',
--     '2026-02-10',
--     'activo'
-- );

-- INSERT que falla por CHECK
-- INSERT INTO evaluaciones (
--     id_evaluacion,
--     id_camper,
--     id_modulo,
--     fecha_evaluacion,
--     nota,
--     tipo
-- ) VALUES (
--     11,
--     1,
--     1,
--     '2026-03-05',
--     120,
--     'practica'
-- );