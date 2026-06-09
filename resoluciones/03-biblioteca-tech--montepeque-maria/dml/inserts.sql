PRAGMA foreign_keys = ON;

-- Ejercicio 03: Biblioteca Tech
INSERT INTO
    categorias (nombre, descripcion)
VALUES (
        'Programacion',
        'Lenguajes, algoritmos y buenas practicas'
    ),
    (
        'Bases de Datos',
        'Modelado, SQL y administracion'
    ),
    (
        'Redes',
        'Protocolos, infraestructura y seguridad'
    ),
    (
        'Inteligencia Artificial',
        'Machine learning y ciencia de datos'
    ),
    (
        'Sistemas Operativos',
        'Kernel, procesos y administracion'
    );

INSERT INTO
    autores (nombre, nacionalidad)
VALUES (
        'Robert C. Martin',
        'Estadounidense'
    ),
    (
        'Andrew Hunt',
        'Estadounidense'
    ),
    ('C. J. Date', 'Britanica'),
    (
        'Andrew Tanenbaum',
        'Neerlandesa'
    ),
    ('Stuart Russell', 'Britanica'),
    ('Martin Fowler', 'Britanica');

INSERT INTO
    libros (
        titulo,
        isbn,
        anio_publicacion,
        precio,
        stock,
        estado,
        categoria_id,
        autor_id
    )
VALUES (
        'Clean Code',
        '978-0132350884',
        2008,
        320.00,
        5,
        'disponible',
        1,
        1
    ),
    (
        'The Pragmatic Programmer',
        '978-0201616224',
        1999,
        280.50,
        3,
        'disponible',
        1,
        2
    ),
    (
        'Clean Architecture',
        '978-0134494166',
        2017,
        350.00,
        4,
        'disponible',
        1,
        1
    ),
    (
        'An Introduction to Database Systems',
        '978-0321197849',
        2003,
        410.00,
        2,
        'disponible',
        2,
        3
    ),
    (
        'Refactoring',
        '978-0134757599',
        2018,
        390.00,
        0,
        'agotado',
        2,
        6
    ),
    (
        'Computer Networks',
        '978-0132126953',
        2010,
        450.00,
        6,
        'disponible',
        3,
        4
    ),
    (
        'Modern Operating Systems',
        '978-0133591620',
        2014,
        470.00,
        3,
        'disponible',
        5,
        4
    ),
    (
        'Artificial Intelligence',
        '978-0136042594',
        2009,
        520.00,
        2,
        'disponible',
        4,
        5
    ),
    (
        'Patterns of Enterprise App',
        '978-0321127426',
        2002,
        360.00,
        1,
        'disponible',
        1,
        6
    ),
    (
        'Distributed Systems',
        '978-0130888938',
        2006,
        300.00,
        0,
        'agotado',
        3,
        4
    );

INSERT INTO
    socios (
        nombre,
        email,
        fecha_registro,
        estado
    )
VALUES (
        'Maria Montepeque',
        'maria@biblioteca.com',
        '2024-01-15',
        'activo'
    ),
    (
        'Carlos Lopez',
        'carlos@biblioteca.com',
        '2024-02-20',
        'activo'
    ),
    (
        'Ana Garcia',
        'ana@biblioteca.com',
        '2024-03-10',
        'activo'
    ),
    (
        'Luis Perez',
        'luis@biblioteca.com',
        '2023-11-05',
        'inactivo'
    ),
    (
        'Sofia Ramirez',
        'sofia@biblioteca.com',
        '2024-05-01',
        'activo'
    ),
    (
        'Jorge Mendez',
        'jorge@biblioteca.com',
        '2023-09-18',
        'inactivo'
    );

INSERT INTO
    prestamos (
        libro_id,
        socio_id,
        fecha_prestamo,
        fecha_devolucion,
        estado
    )
VALUES (
        1,
        1,
        '2024-06-01',
        '2024-06-10',
        'devuelto'
    ),
    (
        1,
        2,
        '2024-06-15',
        NULL,
        'prestado'
    ),
    (
        3,
        1,
        '2024-06-20',
        NULL,
        'atrasado'
    ),
    (
        6,
        3,
        '2024-06-22',
        '2024-07-01',
        'devuelto'
    ),
    (
        8,
        5,
        '2024-07-02',
        NULL,
        'prestado'
    ),
    (
        4,
        2,
        '2024-07-05',
        '2024-07-12',
        'devuelto'
    ),
    (
        7,
        3,
        '2024-07-08',
        NULL,
        'atrasado'
    ),
    (
        1,
        5,
        '2024-07-10',
        NULL,
        'prestado'
    ),
    (
        6,
        1,
        '2024-07-11',
        '2024-07-20',
        'devuelto'
    ),
    (
        3,
        5,
        '2024-07-15',
        NULL,
        'prestado'
    ),
    (
        8,
        2,
        '2024-07-18',
        '2024-07-25',
        'devuelto'
    ),
    (
        6,
        5,
        '2024-07-20',
        NULL,
        'prestado'
    );