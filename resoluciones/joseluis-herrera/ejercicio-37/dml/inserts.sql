INSERT INTO autores (
    id_autor,
    nombre_completo,
    nacionalidad,
    fecha_nacimiento
) VALUES
(1, 'Gabriel Garcia Marquez', 'Colombiana', '1927-03-06'),
(2, 'Isabel Allende', 'Chilena', '1942-08-02'),
(3, 'Mario Vargas Llosa', 'Peruana', '1936-03-28'),
(4, 'Julio Cortazar', 'Argentina', '1914-08-26'),
(5, 'Jorge Luis Borges', 'Argentina', '1899-08-24'),
(6, 'Laura Esquivel', 'Mexicana', '1950-09-30');

INSERT INTO generos (
    id_genero,
    nombre,
    descripcion
) VALUES
(1, 'Realismo magico', 'Narrativa con elementos fantasticos integrados en la realidad'),
(2, 'Novela', 'Obras narrativas extensas de ficcion'),
(3, 'Ficcion', 'Narrativa basada en acontecimientos imaginarios'),
(4, 'Romance', 'Narrativa centrada en relaciones sentimentales'),
(5, 'Cuento', 'Narrativa breve de ficcion'),
(6, 'Literatura latinoamericana', 'Obras de autores de America Latina');

INSERT INTO libros (
    id_libro,
    titulo,
    isbn,
    anio_publicacion,
    editorial,
    ejemplares,
    estado
) VALUES
(1, 'Cien anos de soledad', '9780307474728', 1967, 'Sudamericana', 5, 'disponible'),
(2, 'El amor en los tiempos del colera', '9780307389732', 1985, 'Sudamericana', 4, 'disponible'),
(3, 'La casa de los espiritus', '9781501117015', 1982, 'Plaza & Janes', 3, 'disponible'),
(4, 'La ciudad y los perros', '9780060539292', 1963, 'Seix Barral', 4, 'disponible'),
(5, 'Rayuela', '9788437604133', 1963, 'Alfaguara', 3, 'disponible'),
(6, 'Ficciones', '9780802130303', 1944, 'Sur', 5, 'disponible'),
(7, 'Como agua para chocolate', '9780385420174', 1989, 'Planeta', 2, 'disponible'),
(8, 'El Aleph', '9780802130971', 1949, 'Losada', 4, 'disponible');

INSERT INTO usuarios (
    id_usuario,
    nombre_completo,
    documento,
    email,
    telefono,
    estado
) VALUES
(1, 'Carlos Mendoza', 'USR10001', 'carlos.mendoza@example.com', '55510001', 'activo'),
(2, 'Ana Lopez', 'USR10002', 'ana.lopez@example.com', '55510002', 'activo'),
(3, 'Miguel Ramirez', 'USR10003', 'miguel.ramirez@example.com', '55510003', 'activo'),
(4, 'Sofia Castillo', 'USR10004', 'sofia.castillo@example.com', '55510004', 'activo'),
(5, 'Daniel Morales', 'USR10005', 'daniel.morales@example.com', '55510005', 'activo'),
(6, 'Laura Perez', 'USR10006', 'laura.perez@example.com', '55510006', 'activo');

INSERT INTO prestamos (
    id_prestamo,
    id_usuario,
    fecha_prestamo,
    fecha_devolucion_prevista,
    estado
) VALUES
(1, 1, '2026-08-01', '2026-08-15', 'devuelto'),
(2, 2, '2026-08-02', '2026-08-16', 'devuelto'),
(3, 3, '2026-08-04', '2026-08-18', 'activo'),
(4, 4, '2026-08-05', '2026-08-19', 'activo'),
(5, 5, '2026-08-07', '2026-08-21', 'atrasado'),
(6, 6, '2026-08-08', '2026-08-22', 'activo'),
(7, 1, '2026-08-10', '2026-08-24', 'activo'),
(8, 2, '2026-08-12', '2026-08-26', 'activo');

INSERT INTO detalle_prestamo (
    id_detalle,
    id_prestamo,
    id_libro,
    fecha_devolucion_real
) VALUES
(1, 1, 1, '2026-08-14'),
(2, 1, 2, '2026-08-14'),
(3, 2, 3, '2026-08-15'),
(4, 2, 5, '2026-08-15'),
(5, 3, 4, NULL),
(6, 3, 6, NULL),
(7, 4, 7, NULL),
(8, 4, 1, NULL),
(9, 5, 2, NULL),
(10, 5, 8, NULL),
(11, 6, 3, NULL),
(12, 6, 6, NULL),
(13, 7, 5, NULL),
(14, 7, 7, NULL),
(15, 8, 1, NULL),
(16, 8, 8, NULL);

INSERT INTO libro_autor (
    id_libro,
    id_autor
) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 5);

INSERT INTO libro_genero (
    id_libro,
    id_genero
) VALUES
(1, 1),
(1, 2),
(1, 6),
(2, 2),
(2, 4),
(2, 6),
(3, 2),
(3, 4),
(3, 6),
(4, 2),
(4, 6),
(5, 2),
(5, 3),
(5, 6),
(6, 3),
(6, 5),
(6, 6),
(7, 2),
(7, 4),
(7, 6),
(8, 3),
(8, 5),
(8, 6);

-- CASO INVALIDO 1
-- INSERT INTO libros (id_libro, titulo, isbn, anio_publicacion, editorial, ejemplares, estado)
-- VALUES (9, 'Libro duplicado', '9780307474728', 2026, 'Editorial Prueba', 2, 'disponible');

-- CASO INVALIDO 2
-- INSERT INTO detalle_prestamo (id_detalle, id_prestamo, id_libro, fecha_devolucion_real)
-- VALUES (17, 1, 1, '2026-08-15');