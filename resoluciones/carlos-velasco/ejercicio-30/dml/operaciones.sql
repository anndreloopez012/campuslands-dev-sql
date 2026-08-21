PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO campers (
    id_camper,
    nombre_completo,
    correo,
    telefono,
    fecha_ingreso,
    estado
) VALUES (
    6,
    'Natalia Herrera',
    'natalia.herrera@example.com',
    '555-1006',
    '2026-03-01',
    'Activo'
);

INSERT INTO evaluaciones (
    id_evaluacion,
    id_camper,
    id_modulo,
    fecha_evaluacion,
    nota,
    tipo,
    estado
) VALUES (
    11,
    6,
    5,
    '2026-03-25',
    94.00,
    'Proyecto',
    'Calificada'
);

-- UPDATES

UPDATE campers
SET telefono = '555-1101'
WHERE id_camper = 1;

UPDATE evaluaciones
SET nota = 90.00
WHERE id_evaluacion = 7;

-- DELETES CONTROLADOS

DELETE FROM evaluaciones
WHERE id_evaluacion = 11;

DELETE FROM campers
WHERE id_camper = 6;

-- OPERACION INVALIDA: UNIQUE

-- INSERT INTO campers (
--     id_camper,
--     nombre_completo,
--     correo,
--     telefono,
--     fecha_ingreso,
--     estado
-- ) VALUES (
--     7,
--     'Camper Duplicado',
--     'carlos.velasco@example.com',
--     '555-1007',
--     '2026-03-10',
--     'Activo'
-- );

-- OPERACION INVALIDA: CHECK

-- INSERT INTO evaluaciones (
--     id_evaluacion,
--     id_camper,
--     id_modulo,
--     fecha_evaluacion,
--     nota,
--     tipo,
--     estado
-- ) VALUES (
--     12,
--     1,
--     1,
--     '2026-03-30',
--     150.00,
--     'Practica',
--     'Calificada'
-- );