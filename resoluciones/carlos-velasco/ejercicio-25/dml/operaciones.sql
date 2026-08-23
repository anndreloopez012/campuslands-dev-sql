PRAGMA foreign_keys = ON;

-- INSERT

INSERT INTO sedes (
    id_sede,
    nombre,
    direccion,
    capacidad
) VALUES (
    6,
    'Sede Biblioteca Digital',
    'Avenida Digital 606',
    250
);

INSERT INTO usuarios (
    id_usuario,
    id_sede,
    nombre_completo,
    correo,
    fecha_registro,
    estado
) VALUES (
    6,
    6,
    'Fabian Lopez',
    'fabian.lopez@campus.local',
    '2026-06-10',
    'ACTIVO'
);

-- UPDATE

UPDATE libros
SET ejemplares = ejemplares + 3
WHERE id_libro = 5;

UPDATE usuarios
SET estado = 'INACTIVO'
WHERE id_usuario = 5;

-- DELETE

DELETE FROM usuarios
WHERE id_usuario = 6;

DELETE FROM sedes
WHERE id_sede = 6;

-- OPERACIONES INVALIDAS

-- UNIQUE: el ISBN ya existe.
-- INSERT INTO libros (
--     id_libro,
--     titulo,
--     autor,
--     isbn,
--     anio_publicacion,
--     ejemplares
-- ) VALUES (
--     6,
--     'Libro duplicado',
--     'Autor de prueba',
--     '9780307474728',
--     2020,
--     5
-- );

-- FOREIGN KEY: el usuario referenciado no existe.
-- INSERT INTO prestamos (
--     id_prestamo,
--     id_usuario,
--     id_libro,
--     fecha_prestamo,
--     fecha_devolucion,
--     estado,
--     dias_prestamo
-- ) VALUES (
--     11,
--     999,
--     1,
--     '2026-06-20',
--     NULL,
--     'PRESTADO',
--     7
-- );