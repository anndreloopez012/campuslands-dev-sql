PRAGMA foreign_keys = ON;
-- Ejercicio 33: Normalizacion Matriculas Academicas

INSERT INTO
    estudiante (documento, nombre)
VALUES ('DPI-100', 'Laura Cano'),
    ('DPI-101', 'Kevin Rios'),
    ('DPI-102', 'Sofia Luna');

INSERT INTO
    trainer (id_trainer, nombre)
VALUES (1, 'Mario Paz'),
    (2, 'Ana Solis'),
    (3, 'Luis Mora');

INSERT INTO
    ruta (id_ruta, nombre, id_trainer)
VALUES (1, 'Node JS', 1),
    (2, 'Python', 2),
    (3, 'Java', 3);

INSERT INTO
    modulo (id_modulo, nombre)
VALUES (1, 'SQL'),
    (2, 'Express'),
    (3, 'JWT'),
    (4, 'FastAPI'),
    (5, 'Docker'),
    (6, 'Deploy'),
    (7, 'Spring'),
    (8, 'Maven'),
    (9, 'GraphQL');

INSERT INTO
    matricula (
        id_matricula,
        documento,
        id_ruta
    )
VALUES (1, 'DPI-100', 1),
    (2, 'DPI-101', 2),
    (3, 'DPI-100', 1),
    (4, 'DPI-102', 3);

INSERT INTO
    matricula_modulo (
        id_matricula,
        id_modulo,
        horario,
        nota
    )
VALUES (1, 1, '08:00', 88),
    (1, 2, '10:00', 91),
    (1, 3, '12:00', 85),
    (2, 1, '14:00', 90),
    (2, 4, '16:00', 87),
    (3, 5, '15:00', 92),
    (3, 6, '17:00', 89),
    (4, 7, '09:00', 95),
    (4, 8, '11:00', 78);
