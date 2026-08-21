INSERT INTO autores (
    id_autor,
    nombre_completo,
    nacionalidad,
    fecha_nacimiento
) VALUES (
    6,
    'Joshua Bloch',
    'Estadounidense',
    '1961-08-28'
);

INSERT INTO campers (
    id_camper,
    nombre_completo,
    email,
    fecha_ingreso,
    estado
) VALUES (
    6,
    'Diego Ramirez',
    'diego.ramirez@campuslands.com',
    '2026-03-01',
    'ACTIVO'
);

UPDATE libros
SET ejemplares_disponibles = ejemplares_disponibles + 1
WHERE id_libro = 1;

UPDATE campers
SET estado = 'INACTIVO'
WHERE id_camper = 6;

DELETE FROM autores
WHERE id_autor = 6;

DELETE FROM campers
WHERE id_camper = 6;

-- Operacion invalida: UNIQUE
-- INSERT INTO libros (id_libro, id_autor, titulo, isbn, anio_publicacion, ejemplares_disponibles)
-- VALUES (6, 1, 'Clean Code Segunda Edicion', '9780132350884', 2020, 2);

-- Operacion invalida: FOREIGN KEY
-- INSERT INTO prestamos (id_prestamo, id_libro, id_camper, fecha_prestamo, fecha_devolucion, estado)
-- VALUES (11, 999, 1, '2026-07-01', NULL, 'PRESTADO');