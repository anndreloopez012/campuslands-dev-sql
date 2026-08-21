PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. INSERT adicional
-- =========================================================

INSERT INTO libros (
    id_libro,
    titulo,
    isbn,
    anio_publicacion,
    paginas,
    id_autor
) VALUES (
    6,
    'You Don''t Know JS',
    '9781491904244',
    2015,
    278,
    3
);

-- =========================================================
-- 2. INSERT adicional
-- =========================================================

INSERT INTO campers (
    id_camper,
    nombre_completo,
    email,
    fecha_ingreso,
    nivel
) VALUES (
    6,
    'Sofia Ramirez',
    'sofia.ramirez@example.com',
    '2026-04-12',
    'JUNIOR'
);

-- =========================================================
-- 3. UPDATE válido
-- =========================================================

UPDATE libros
SET paginas = 280
WHERE id_libro = 6;

-- =========================================================
-- 4. UPDATE válido
-- =========================================================

UPDATE campers
SET nivel = 'MID'
WHERE id_camper = 6;

-- =========================================================
-- 5. DELETE controlado
-- =========================================================

DELETE FROM libros
WHERE id_libro = 6;

-- =========================================================
-- 6. DELETE controlado
-- =========================================================

DELETE FROM campers
WHERE id_camper = 6;

-- =========================================================
-- OPERACIONES QUE DEBEN FALLAR
-- Se mantienen comentadas para no interrumpir el script.
-- =========================================================

-- CHECK: cantidad de paginas no puede ser 0.
-- INSERT INTO libros (
--     id_libro, titulo, isbn, anio_publicacion, paginas, id_autor
-- ) VALUES (
--     7, 'Libro invalido', '9780000000001', 2020, 0, 1
-- );

-- UNIQUE: el ISBN ya existe.
-- INSERT INTO libros (
--     id_libro, titulo, isbn, anio_publicacion, paginas, id_autor
-- ) VALUES (
--     8, 'Duplicado', '9780132350884', 2020, 100, 1
-- );

-- FOREIGN KEY: el autor 999 no existe.
-- INSERT INTO libros (
--     id_libro, titulo, isbn, anio_publicacion, paginas, id_autor
-- ) VALUES (
--     9, 'Libro sin autor', '9780000000002', 2020, 150, 999
-- );