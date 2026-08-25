INSERT INTO cursos (
    id_curso,
    id_categoria,
    id_instructor,
    nombre,
    descripcion,
    precio,
    fecha_inicio,
    cupo_maximo
) VALUES
(11, 1, 1, 'React para Interfaces', 'Construccion de interfaces web con React.', 420.00, '2026-10-01', 25);

INSERT INTO cursos (
    id_curso,
    id_categoria,
    id_instructor,
    nombre,
    descripcion,
    precio,
    fecha_inicio,
    cupo_maximo
) VALUES
(12, 5, 5, 'Kubernetes Inicial', 'Fundamentos de orquestacion de contenedores.', 450.00, '2026-10-05', 20);

UPDATE cursos
SET precio = 275.00
WHERE id_curso = 2;

UPDATE cursos
SET cupo_maximo = 35
WHERE id_curso = 5;

DELETE FROM cursos
WHERE id_curso = 11;

DELETE FROM cursos
WHERE id_curso = 12;

-- INSERT que falla por UNIQUE
-- INSERT INTO cursos (
--     id_curso,
--     id_categoria,
--     id_instructor,
--     nombre,
--     descripcion,
--     precio,
--     fecha_inicio,
--     cupo_maximo
-- ) VALUES (
--     13,
--     1,
--     1,
--     'JavaScript Moderno',
--     'Curso duplicado.',
--     300.00,
--     '2026-10-10',
--     20
-- );

-- INSERT que falla por FOREIGN KEY
-- INSERT INTO cursos (
--     id_curso,
--     id_categoria,
--     id_instructor,
--     nombre,
--     descripcion,
--     precio,
--     fecha_inicio,
--     cupo_maximo
-- ) VALUES (
--     14,
--     99,
--     1,
--     'Curso Invalido',
--     'Curso con categoria inexistente.',
--     250.00,
--     '2026-10-12',
--     20
-- );