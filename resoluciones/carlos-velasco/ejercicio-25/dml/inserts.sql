PRAGMA foreign_keys = ON;

-- SEDES

INSERT INTO sedes (
    id_sede,
    nombre,
    direccion,
    capacidad
) VALUES
    (1, 'Sede Central', 'Avenida Central 101', 500),
    (2, 'Sede Norte', 'Calle Norte 202', 350),
    (3, 'Sede Sur', 'Avenida Sur 303', 300),
    (4, 'Sede Universitaria', 'Boulevard Academico 404', 450),
    (5, 'Sede Tecnologica', 'Calle Innovacion 505', 400);

-- LIBROS

INSERT INTO libros (
    id_libro,
    titulo,
    autor,
    isbn,
    anio_publicacion,
    ejemplares
) VALUES
    (1, 'Cien años de soledad', 'Gabriel Garcia Marquez', '9780307474728', 1967, 12),
    (2, 'Don Quijote de la Mancha', 'Miguel de Cervantes', '9788420412146', 1605, 8),
    (3, 'El principito', 'Antoine de Saint-Exupery', '9780156012195', 1943, 15),
    (4, '1984', 'George Orwell', '9780451524935', 1949, 10),
    (5, 'Clean Code', 'Robert C. Martin', '9780132350884', 2008, 7);

-- USUARIOS

INSERT INTO usuarios (
    id_usuario,
    id_sede,
    nombre_completo,
    correo,
    fecha_registro,
    estado
) VALUES
    (1, 1, 'Ana Morales', 'ana.morales@campus.local', '2024-01-15', 'ACTIVO'),
    (2, 2, 'Bruno Castillo', 'bruno.castillo@campus.local', '2023-08-20', 'ACTIVO'),
    (3, 3, 'Carla Mendoza', 'carla.mendoza@campus.local', '2024-03-10', 'ACTIVO'),
    (4, 4, 'Diego Ramirez', 'diego.ramirez@campus.local', '2022-11-05', 'ACTIVO'),
    (5, 5, 'Elena Torres', 'elena.torres@campus.local', '2025-01-22', 'ACTIVO');

-- PRESTAMOS

INSERT INTO prestamos (
    id_prestamo,
    id_usuario,
    id_libro,
    fecha_prestamo,
    fecha_devolucion,
    estado,
    dias_prestamo
) VALUES
    (1, 1, 1, '2026-01-10', '2026-01-17', 'DEVUELTO', 7),
    (2, 2, 2, '2026-01-15', '2026-01-23', 'DEVUELTO', 8),
    (3, 3, 3, '2026-02-02', '2026-02-10', 'DEVUELTO', 8),
    (4, 4, 4, '2026-02-18', NULL, 'PRESTADO', 14),
    (5, 5, 5, '2026-03-01', '2026-03-12', 'DEVUELTO', 11),
    (6, 1, 4, '2026-03-15', NULL, 'PRESTADO', 14),
    (7, 2, 1, '2026-04-05', '2026-04-13', 'DEVUELTO', 8),
    (8, 3, 5, '2026-04-20', NULL, 'ATRASADO', 15),
    (9, 4, 3, '2026-05-02', '2026-05-09', 'DEVUELTO', 7),
    (10, 5, 2, '2026-05-18', NULL, 'PRESTADO', 10);